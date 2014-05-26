package Worlds
{
import Simulation.Simulation;

public class UnknownSimulationWorld extends SimulationWorld
{
    public function UnknownSimulationWorld(simulation:Simulation)
    {
        super(simulation);
    }

    override protected function colorMeeples():void
    {
    }

    override protected function previousWorld():void
    {
        WorldManager.switchTo("title");
    }

    override protected function nextWorld():void
    {
        WorldManager.switchTo("simulation");
    }
}
}
