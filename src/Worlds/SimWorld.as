package Worlds
{
import Simulation.Individual;

import Sprites.Meeple;

import Utils.Sector;
import Utils.TextEntity;

import flash.geom.Point;

import net.flashpunk.FP;
import net.flashpunk.World;
import net.flashpunk.graphics.Text;
import net.flashpunk.utils.Key;
import net.flashpunk.utils.Input;

import Simulation.Simulation;

public class SimWorld extends World
{
    private var simulation:Simulation;
    private var meeples:Vector.<Meeple> = new Vector.<Meeple>();

    private var paused:Boolean = true;
    private var dayCountLabel:TextEntity;
    private var meepleEventCriteriaLabel:TextEntity;

    private var state:int = 0;

    private var freedomSector:Sector;
    private var jailSector:Sector;

    private const STATE_INITIAL:int = 0;
    private const STATE_RUNNING:int = 1;
    private const STATE_JAIL_ANALYSIS:int = 2;
    private const STATE_INDIVIDUAL_ANALYSIS:int = 3;

    public function SimWorld(simulation:Simulation)
    {
        super();
        this.simulation = simulation;
        this.meeples = meeples;

        initializeMeeples();
        initializeHud();
        setMeepleHomes();

        freedomSector = new Sector(0, 100, FP.width, FP.height);
        freedomSector.setExclusionRadius(380);
        add(freedomSector);

        jailSector = new Sector(0, 100, FP.width, FP.height);
        jailSector.setInclusionRadius(250);
        add(jailSector);
    }

    private function getPointFor(row:int, col:int):Point
    {
        return new Point(78 * row + 39, 80 * col + 168);
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
    }

    private function initializeMeeples():void
    {
        for each (var individual:Individual in simulation.GetIndividuals()) {
            var meeple:Meeple = new Meeple(individual, FP.rand(FP.width), FP.rand(FP.height));
            meeples.push(meeple);
            add(meeple);
        }
    }

    private function setMeepleHomes():void
    {
        var row:int = 0;
        var col:int = 0;

        for each (var meeple:Meeple in meeples) {
            meeple.SetHomePoint(getPointFor(row, col));

            row++;
            if (row > 12) {
                col++;
                row = 0;
            }
        }
    }

    override public function update():void
    {
        super.update();

        if (state == STATE_RUNNING) {
            simulation.Update();
        }

        updateLabels();
        updateMeepleStyle();
        updateInput();
    }

    private function updateInput():void
    {
        if (state == STATE_INITIAL) {
            if (Input.pressed(Key.LEFT)) {
                WorldManager.switchTo("title");
            }
            if (Input.pressed(Key.RIGHT)) {
                ChangeState(STATE_RUNNING);
            }
        } else if (state == STATE_RUNNING) {
            if (Input.pressed(Key.LEFT)) {
                ChangeState(STATE_INITIAL);
            }
            if (Input.pressed(Key.RIGHT)) {
                ChangeState(STATE_JAIL_ANALYSIS);
            }
            if (Input.pressed(Key.DOWN)) {
                for (var i:int = 0; i<50; i++) {
                    simulation.nextDay();
                }
            }
        } else if (state == STATE_JAIL_ANALYSIS) {
            if (Input.pressed(Key.LEFT)) {
                ChangeState(STATE_RUNNING);
            }
            if (Input.pressed(Key.RIGHT)) {
                WorldManager.switchTo("history");
            }
        }
    }

    private function ChangeState(state:int):void
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
        for each (var meeple:Meeple in meeples) {
            meeple.GoHome();
        }
    }

    private function sendMeeplesToJail():void
    {
        jailSector.resetCollision();
        freedomSector.resetCollision();

        for each (var meeple:Meeple in meeples) {
            if (meeple.HasEverHadAnEvent()) {
                meeple.GoToTarget(jailSector.getTargetPoint());
            } else {
                meeple.GoToTarget(freedomSector.getTargetPoint());
            }
        }
    }

    private function updateMeepleStyle():void
    {
        for each (var meeple:Meeple in meeples) {
            meeple.UpdateStyle();
        }
    }

    private function updateLabels():void
    {
        dayCountLabel.SetText(simulation.GetDayCount().toString());
        meepleEventCriteriaLabel.SetText(simulation.GetNumberOfIndividualsWithMoreEventsThan(2).toString());
    }
}
}