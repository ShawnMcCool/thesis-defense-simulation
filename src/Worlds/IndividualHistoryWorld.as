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

    private function initializeArrays():void
    {
        var individual:Individual = selectIndividual();

        actualArray = new ActualMeepleArray(individual, 100, 100);
        add(actualArray);
        recordedArray = new RecordedMeepleArray(individual, 100, 200);
        add(recordedArray);
        poissonArray = new PoissonMeepleArray(individual, 100, 300);
        add(poissonArray);
        intervalArray = new IntervalMeepleArray(individual, 100, 400);
        add(intervalArray);
        proportionalArray = new ProportionalMeepleArray(individual, 100, 500);
        add(proportionalArray);
    }

    private function initializeLabels():void
    {
        var actualLabel:TextEntity = new TextEntity(
            "Actual",
            0x000000,
            32,
            30, 80
        );
        add(actualLabel);

        var recordedLabel:TextEntity = new TextEntity(
            "Recorded",
            0x000000,
            32,
            30, 180
        );
        add(recordedLabel);

        var poissonLabel:TextEntity = new TextEntity(
            "Poisson\nEquivalent",
            0x000000,
            32,
            30, 280
        );
        add(poissonLabel);

        var intervalLabel:TextEntity = new TextEntity(
            "Interval\nStable",
            0x000000,
            32,
            30, 380
        );
        add(intervalLabel);

        var proportionalLabel:TextEntity = new TextEntity(
            "Pro-\nportional",
            0x000000,
            32,
            30, 480
        );
        add(proportionalLabel);

    }

    override public function begin():void
    {
        super.begin();
        initializeArrays();
    }

    public function selectIndividual():Individual
    {
        var individuals:Vector.<Individual> = simulation.GetIndividuals();

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
        return selectIndividual();
    }

    override public function update():void
    {
        super.update();
        updateInput();
    }

    private function updateInput():void
    {
        if (Input.pressed(Key.LEFT)) {
            WorldManager.switchTo("simulation");
        }
        if (Input.pressed(Key.RIGHT)) {
            WorldManager.switchTo("summary");
        }
        if (Input.pressed(Key.DOWN)) {
            remove(actualArray);
            remove(recordedArray);
            remove(poissonArray);
            remove(intervalArray);
            remove(proportionalArray);
            initializeArrays();
        }
    }

    private function meetsSelectionCriteria(individual:Individual):Boolean
    {
        return individual.getTotalEventCount() >= 3;
    }
}
}