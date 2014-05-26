package Worlds
{
import Simulation.Individual;
import Simulation.Simulation;

import Collections.ActualMeepleArray;

import Collections.IntervalMeepleArray;
import Collections.PoissonMeepleArray;
import Collections.ProportionalMeepleArray;
import Collections.RecordedMeepleArray;

import Utils.TextEntity;

import net.flashpunk.FP;

import net.flashpunk.World;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class IndividualHistoryWorld extends World
{
    private var simulation:Simulation;
    private var meepleIndex:int = 1;

    private var actualArray:ActualMeepleArray;
    private var recordedArray:RecordedMeepleArray;
    private var poissonArray:PoissonMeepleArray;
    private var intervalArray:IntervalMeepleArray;
    private var proportionalArray:ProportionalMeepleArray;

    public function IndividualHistoryWorld(simulation:Simulation)
    {
        super();
        this.simulation = simulation;
        initializeLabels();
    }

    public function setSimulation(simulation:Simulation):void
    {
        this.simulation = simulation;
    }

    private function initializeArrays():void
    {
        var individual:Individual = selectIndividual();

        actualArray = new ActualMeepleArray(individual, 100, 250);
        add(actualArray);
        recordedArray = new RecordedMeepleArray(individual, 100, 350);
        add(recordedArray);
        poissonArray = new PoissonMeepleArray(individual, 100, 450);
        add(poissonArray);
        intervalArray = new IntervalMeepleArray(individual, 100, 550);
        add(intervalArray);
        proportionalArray = new ProportionalMeepleArray(individual, 100, 650);
        add(proportionalArray);
    }

    private function initializeLabels():void
    {
        var actualLabel:TextEntity = new TextEntity(
            "Actual",
            0x000000,
            32,
            30, 230
        );
        add(actualLabel);

        var recordedLabel:TextEntity = new TextEntity(
            "Recorded",
            0x000000,
            32,
            30, 330
        );
        add(recordedLabel);

        var poissonLabel:TextEntity = new TextEntity(
            "Poisson\nEquivalent",
            0x000000,
            32,
            30, 430
        );
        add(poissonLabel);

        var intervalLabel:TextEntity = new TextEntity(
            "Interval\nStable",
            0x000000,
            32,
            30, 530
        );
        add(intervalLabel);

        var proportionalLabel:TextEntity = new TextEntity(
            "Pro-\nportional",
            0x000000,
            32,
            30, 630
        );
        add(proportionalLabel);

        var heading:TextEntity = new TextEntity(
            "Time-varying covariate methods",
            0x000000,
            48,
            FP.halfWidth, 30
        );
        heading.center();
        add(heading);
    }

    override public function begin():void
    {
        super.begin();
        initializeArrays();
    }

    public function selectIndividual():Individual
    {
        var individuals:Vector.<Individual> = simulation.getIndividuals();

        var counter:int = 0;
        for each (var individual:Individual in individuals) {
            if (meetsSelectionCriteria(individual)) {
                counter++;
                if (counter >= meepleIndex) {
                    meepleIndex++;
                    return individual;
                }
            }
        }

        meepleIndex = 1;
        WorldManager.switchTo("summary");
        return selectIndividual();
    }

    override public function update():void
    {
        super.update();
        updateInput();
    }

    private function updateInput():void
    {
        if (Input.pressed(Key.PAGE_UP)) {
            WorldManager.switchTo("simulation");
        }
        if (Input.pressed(Key.PAGE_DOWN)) {
<<<<<<< HEAD
            advanceIndividual();
=======
            WorldManager.switchTo("summary");
        }
        if (Input.pressed(Key.PERIOD)) {
            remove(actualArray);
            remove(recordedArray);
            remove(poissonArray);
            remove(intervalArray);
            remove(proportionalArray);
            initializeArrays();
>>>>>>> 7fdb8fa... updates
        }
    }

    private function advanceIndividual():void
    {
        remove(actualArray);
        remove(recordedArray);
        remove(poissonArray);
        remove(intervalArray);
        remove(proportionalArray);
        initializeArrays();
    }

    private function meetsSelectionCriteria(individual:Individual):Boolean
    {
        return individual.getTotalEventCount() >= 3;
    }
}
}