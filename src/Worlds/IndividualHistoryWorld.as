package Worlds
{
import Simulation.Individual;
import Simulation.Simulation;
import net.flashpunk.World;

public class IndividualHistoryWorld extends World
{
    private var simulation:Simulation;
    private var meepleIndex:int = 0;

    public function IndividualHistoryWorld(simulation:Simulation)
    {
        super();
        this.simulation = simulation;
    }

    public function displayMeeple():void
    {
    }

    public function selectIndividual():Individual
    {
        for each (var individual:Individual in simulation.GetIndividuals()) {
            if (meetsSelectionCriteria(individual)) {
                meepleIndex++;
                return individual;
            }
        }
        return null;
    }

    private function meetsSelectionCriteria(individual:Individual):Boolean
    {
        return individual.GetTotalEventCount() >= 3;
    }
}
}