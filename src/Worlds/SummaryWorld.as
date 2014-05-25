package Worlds
{
import Simulation.Simulation;

import net.flashpunk.World;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class SummaryWorld extends World
{
    private var simulation:Simulation;

    public function SummaryWorld(simulation:Simulation)
    {
        this.simulation = simulation;
    }

    override public function update():void
    {
        if (Input.pressed(Key.LEFT)) {
            WorldManager.switchTo("history");
        }
    }
}
}