package Worlds
{
import Simulation.Individual;
import Simulation.IndividualState;
import Simulation.Simulation;

import Sprites.MeepleArray;

import net.flashpunk.FP;

import net.flashpunk.World;

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

    public function displayMeeple():void
    {
        var individual:Individual = selectIndividual();

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

    private function meetsSelectionCriteria(individual:Individual):Boolean
    {
        return individual.GetTotalEventCount() >= 3;
    }
}
}