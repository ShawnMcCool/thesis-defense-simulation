package Worlds
{
import Simulation.Individual;
import Simulation.IndividualState;
import Simulation.Simulation;

import Sprites.MeepleArray;

import net.flashpunk.World;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class IndividualHistoryWorld extends World
{
    private var simulation:Simulation;
    private var meepleIndex:int = 1;

    private var actualArray:MeepleArray = new MeepleArray(80, 100);

    public function IndividualHistoryWorld(simulation:Simulation)
    {
        super();
        this.simulation = simulation;

        add(actualArray);
    }


    override public function begin():void
    {
        super.begin();
        actualArray.clear();
        displayMeeple();
    }

    public function displayMeeple():void
    {
        var individual:Individual = selectIndividual();

        if (!individual) {
            return;
        }

        for each (var state:IndividualState in individual.GetHistoryToEvent(3)) {
            actualArray.addMeeple(state.GetColor());
        }
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
        return null;
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

        if (Input.pressed(Key.DOWN)) {
            actualArray.clear();
            displayMeeple();
        }
    }

    private function meetsSelectionCriteria(individual:Individual):Boolean
    {
        return individual.GetTotalEventCount() >= 3;
    }
}
}