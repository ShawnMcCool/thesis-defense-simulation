package Worlds
{
import Collections.MeeplePyramid;

import Simulation.Simulation;

import net.flashpunk.World;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class SummaryWorld extends World
{
    private var simulation:Simulation;
    private var pyramid:MeeplePyramid;

    public function SummaryWorld(simulation:Simulation)
    {
        this.simulation = simulation;
        this.pyramid = new MeeplePyramid(simulation.GetIndividuals(), 100, 10);
        add(this.pyramid);
    }

    override public function update():void
    {
        if (Input.pressed(Key.LEFT)) {
            WorldManager.switchTo("history");
        }
    }
}
}