package Worlds
{
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
    private const STATE_PAUSED_COVARIATES:int = 3;
    private const STATE_RUNNING_COVARIATES:int = 4;
    private const STATE_ANALYSIS_COVARIATES:int = 5;

    private var state:int = 0;
    private var paused:Boolean = true;

    private var dayCountLabel:TextEntity;
    private var headingLabels:Vector.<TextEntity> = new <TextEntity>[];
    protected var simulation:Simulation;
    protected var meeples:Vector.<SimulationMeeple>;

    private var freedomSector:Sector;
    private var jailSector:Sector;

    public function SimulationWorld(simulation:Simulation)
    {
        super();
        this.simulation = simulation;

        initializeMeeples();
        initializeHud();
        setMeepleHomes();
        initializeSectors();
        changeState(STATE_PAUSED_COVARIATES);
    }

    private function initializeMeeples():void
    {
        meeples = new Vector.<SimulationMeeple>();
        for each (var individual:Individual in simulation.getIndividuals()) {
            var meeple:SimulationMeeple = new SimulationMeeple(individual, FP.rand(FP.width), FP.rand(FP.height));
            meeples.push(meeple);
            add(meeple);
        }

        meeples.sort(shuffleVector);
    }

    private function shuffleVector(a:Object, b:Object):int
    {
        return Math.floor(Math.random() * 3 - 1);
    }

    private function initializeHud():void
    {
        dayCountLabel = new TextEntity(
            "0",
            0x444444,
            32,
            20, 50
        );
        dayCountLabel.SetPrefix("Day ");
        add(dayCountLabel);
		
        var headings:Array = [
            "A hidden population",
            "Events in a hidden population",
            "Individuals with one or more events",
            "Covariates",
            "Time-varying covariates",
            "Individuals with one or more events"
        ];

        for each (var title:String in headings) {
            var text:TextEntity = new TextEntity(title, 0x444444, 48, FP.halfWidth, 30);
            text.center();
            text.visible = false;
            headingLabels.push(text);
            add(text);
        }
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
        freedomSector = new Sector(0, 140, FP.width, FP.height);
        freedomSector.setExclusionRadius(320);
        add(freedomSector);

        jailSector = new Sector(0, 100, FP.width, FP.height);
        jailSector.setInclusionRadius(150);
        add(jailSector);
    }

    override public function update():void
    {
        super.update();

        if (!paused) {
            simulation.update();
        }

        if (state == STATE_RUNNING_COVARIATES) {
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
        switch (state) {
            case STATE_PAUSED_COVARIATES:
                if (Input.pressed(Key.LEFT)) {
                    previousWorld();
                }
                if (Input.pressed(Key.RIGHT)) {
                    if (simulationDone()) {
                        changeState(STATE_ANALYSIS_COVARIATES);
                        return;
                    }
                    changeState(STATE_RUNNING_COVARIATES);
                }
                break;
            case STATE_RUNNING_COVARIATES:
                if (Input.pressed(Key.LEFT)) {
                    changeState(STATE_PAUSED_COVARIATES);
                }
                if (Input.pressed(Key.RIGHT)) {
                    changeState(STATE_ANALYSIS_COVARIATES);
                }
                if (Input.pressed(Key.DOWN)) {
                    finishSimulation();
                }
                break;
            case STATE_ANALYSIS_COVARIATES:
                if (Input.pressed(Key.LEFT)) {
                    if (simulationDone()) {
                        changeState(STATE_PAUSED_COVARIATES);
                        return;
                    }
                    changeState(STATE_RUNNING_COVARIATES);
                }
                if (Input.pressed(Key.RIGHT)) {
                    if (simulationDone()) {
                        nextWorld();
                    }
                }
                break;
        }
    }

    protected function previousWorld():void
    {
        WorldManager.switchTo("unknown_simulation");
    }

    protected function nextWorld():void
    {
        WorldManager.switchTo("history");
    }

    private function finishSimulation():void
    {
        var count:int = simulation.getDayCount();
        for (var i:int = 0; i < (30 - count); i++) {
            simulation.nextDay();
        }
    }

    private function simulationDone():Boolean
    {
        return simulation.getDayCount() == 30;
    }

    protected function colorMeeples():void
    {
        for each (var meeple:SimulationMeeple in meeples) {
            meeple.setMeepleColorToCovariate();
        }
    }

    private function changeState(state:int):void
    {
        headingLabels[this.state].visible = false;
        headingLabels[state].visible = true;

        switch (state) {
            case STATE_PAUSED_COVARIATES:
                sendMeeplesHome();
                colorMeeples();
                paused = true;
                break;
            case STATE_RUNNING_COVARIATES:
                sendMeeplesHome();
                paused = false;
                break;
            case STATE_ANALYSIS_COVARIATES:
                sendMeeplesToJail();
                paused = true;
        }

        this.state = state;
    }

    private function colorAllMeeplesUnknown():void
    {
        for each (var meeple:SimulationMeeple in meeples) {
            meeple.setColorToUnknown();
        }
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
        dayCountLabel.SetText(simulation.getDayCount().toString());
    }
}
}