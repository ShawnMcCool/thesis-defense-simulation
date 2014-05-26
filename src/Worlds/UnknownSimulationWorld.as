package Worlds
{
import Simulation.Simulation;

import net.flashpunk.FP;

public class UnknownSimulationWorld extends SimulationWorld
{
    public function UnknownSimulationWorld(simulation:Simulation)
    {
        super(simulation);
        headings = [
            "Covariates",
            "Time-varying covariates",
            "Individuals with one or more events"
        ];
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
