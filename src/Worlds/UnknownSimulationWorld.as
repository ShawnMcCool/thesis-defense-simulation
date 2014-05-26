package Worlds
{
import Simulation.Simulation;
import Entities.SimulationMeeple;

public class UnknownSimulationWorld extends SimulationWorld
{
    public function UnknownSimulationWorld(simulation:Simulation)
    {
        super(simulation);
    }

    override protected function colorMeeples():void
    {
        for each (var meeple:SimulationMeeple in meeples) {
            meeple.setMeepleColorToCovariate();
        }
    }

    override protected function nextWorld():void
    {
        WorldManager.switchTo("simulation");
    }
}
}
