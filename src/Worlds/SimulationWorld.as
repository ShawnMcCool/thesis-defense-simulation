package Worlds
{
import Entities.SimulationMeeple;

import Utils.Sector;
import Utils.TextEntity;

import flash.geom.Point;

import net.flashpunk.FP;
import net.flashpunk.World;
import net.flashpunk.utils.Key;
import net.flashpunk.utils.Input;

import Simulation.Simulation;
import Simulation.Individual;
import Entities.SimulationMeeple;

public class SimulationWorld extends World
{
    private const STATE_INITIAL:int = 0;
    private const STATE_PAUSED:int = 3;
    private const STATE_RUNNING:int = 1;
    private const STATE_JAIL_ANALYSIS:int = 2;

    private var state:int = 0;
    private var paused:Boolean = true;

    private var dayCountLabel:TextEntity;
    private var meeplesWithEventsCountLabel:TextEntity;
    private var meepleEventCriteriaLabel:TextEntity;

    private var simulation:Simulation;
    private var meeples:Vector.<SimulationMeeple> = new Vector.<SimulationMeeple>();

    private var freedomSector:Sector;
    private var jailSector:Sector;

    public function SimulationWorld(simulation:Simulation)
    {
        super();
        this.simulation = simulation;

        changeState(STATE_INITIAL);
        initializeMeeples();
        initializeHud();
        setMeepleHomes();
        initializeSectors();
    }

    private function initializeMeeples():void
    {
        for each (var individual:Individual in simulation.GetIndividuals()) {
            var meeple:SimulationMeeple = new SimulationMeeple(individual, FP.rand(FP.width), FP.rand(FP.height));
            meeples.push(meeple);
            add(meeple);
            meeple.setColorUnknown();
        }

        meeples.sort(shuffleVector);
    }

    private function shuffleVector( a:Object, b:Object ):int
    {
        return Math.floor( Math.random() * 3 - 1 );
    }

    private function initializeHud():void
    {
        dayCountLabel = new TextEntity(
            "0",
            0x000000,
            32,
            20, 20
        );
        dayCountLabel.SetPrefix("Day ");
        add(dayCountLabel);

        meepleEventCriteriaLabel = new TextEntity(
            "0",
            0x000000,
            32,
            200, 20
        );
        meepleEventCriteriaLabel.SetPrefix(">2 Events: ");
        add (meepleEventCriteriaLabel);

        meeplesWithEventsCountLabel = new TextEntity(
            "0",
            0x000000,
            32,
            400, 20
        );
        meeplesWithEventsCountLabel.SetPrefix("Have Had Events: ");
        add (meeplesWithEventsCountLabel);
    }

    private function setMeepleHomes():void
    {
        var row:int = 0;
        var col:int = 0;

        for each (var meeple:SimulationMeeple in meeples) {
            meeple.SetHomePoint(getRowColPoint(row, col));

            row++;
            if (row > 12) {
                col++;
                row = 0;
            }
        }
    }

    private function initializeSectors():void
    {
        freedomSector = new Sector(0, 100, FP.width, FP.height);
        freedomSector.setExclusionRadius(380);
        add(freedomSector);

        jailSector = new Sector(0, 100, FP.width, FP.height);
        jailSector.setInclusionRadius(150);
        add(jailSector);
    }

    override public function update():void
    {
        super.update();

        if (state == STATE_RUNNING) {
            simulation.Update();
            colorMeeples();
        }

        updateLabels();
        updateInput();
    }

    private function getRowColPoint(row:int, col:int):Point
    {
        return new Point(78 * row + 39, 80 * col + 168);
    }

    private function updateInput():void
    {
        if (state == STATE_INITIAL) {
            if (Input.pressed(Key.LEFT)) {
                WorldManager.switchTo("title");
            }
            if (Input.pressed(Key.RIGHT)) {
                changeState(STATE_PAUSED);
                colorMeeples();
            }
        } else if (state == STATE_PAUSED) {
            if (Input.pressed(Key.RIGHT)) {
                changeState(STATE_RUNNING);
            }
        } else if (state == STATE_RUNNING) {
            if (Input.pressed(Key.LEFT)) {
                changeState(STATE_INITIAL);
            }
            if (Input.pressed(Key.RIGHT)) {
                changeState(STATE_JAIL_ANALYSIS);
            }
            if (Input.pressed(Key.DOWN)) {
                for (var i:int = simulation.GetDayCount(); i<30; i++) {
                    simulation.nextDay();
                }
            }
        } else if (state == STATE_JAIL_ANALYSIS) {
            if (Input.pressed(Key.LEFT)) {
                changeState(STATE_RUNNING);
            }
            if (Input.pressed(Key.RIGHT)) {
                if (simulation.CountIndividualsWithMinimumEvents(3)) {
                    WorldManager.switchTo("history");
                }
            }
        }
    }

    private function markMeeplesUnknown():void
    {
        for each (var meeple:SimulationMeeple in meeples) {
            meeple.setColorUnknown();
        }
    }

    private function colorMeeples():void
    {
        for each (var meeple:SimulationMeeple in meeples) {
            meeple.setMeepleColorToCovariate();
        }
    }

    private function changeState(state:int):void
    {
        if (state == STATE_RUNNING) {
            sendMeeplesHome();
            paused = false;
        }

        if (state == STATE_JAIL_ANALYSIS) {
            sendMeeplesToJail();
        }

        this.state = state;
    }

    private function sendMeeplesHome():void
    {
        for each (var meeple:SimulationMeeple in meeples) {
            meeple.GoHome();
        }
    }

    private function sendMeeplesToJail():void
    {
        jailSector.resetCollision();
        freedomSector.resetCollision();

        for each (var meeple:SimulationMeeple in meeples) {
            if (meeple.HasEverHadAnEvent()) {
                meeple.GoToTarget(jailSector.getTargetPoint());
            } else {
                meeple.GoToTarget(freedomSector.getTargetPoint());
            }
        }
    }

    private function updateLabels():void
    {
        dayCountLabel.SetText(simulation.GetDayCount().toString());
        meepleEventCriteriaLabel.SetText(simulation.CountIndividualsWithMinimumEvents(3).toString());
        meeplesWithEventsCountLabel.SetText(simulation.CountIndividualsWithEvents().toString());
    }
}
}