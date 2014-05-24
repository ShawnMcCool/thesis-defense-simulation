package Worlds
{
import Simulation.Individual;
import Simulation.IndividualState;
import Simulation.Simulation;

import Sprites.MeepleArray;

import net.flashpunk.FP;

import net.flashpunk.World;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class IndividualHistoryWorld extends World
{
    private var simulation:Simulation;
    private var meepleIndex:int = 0;

    private var actualArray:MeepleArray = new MeepleArray();

    public function IndividualHistoryWorld(simulation:Simulation)
    {
        super();
        this.simulation = simulation;

        add(actualArray);
    }


    override public function begin():void
    {
        super.begin();
        displayMeeple();
    }

    override public function end():void
    {
        super.end();
        FP.log("changed away");
    }

    public function displayMeeple():void
    {
        var individual:Individual = selectIndividual();

        if ( ! individual) {
            return;
        }

        for each (var state:IndividualState in individual.GetHistory()) {
            actualArray.addMeeple(state.GetColor());
        }
    }

    public function selectIndividual():Individual
    {
        for each (var individual:Individual in simulation.GetIndividuals()) {
            if (meetsSelectionCriteria(individual)) {
                meepleIndex++;
                return individual;
            }
        }
        FP.log("No valid individuals found.");
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
    }

    private function meetsSelectionCriteria(individual:Individual):Boolean
    {
        return individual.GetTotalEventCount() >= 3;
    }
}
}