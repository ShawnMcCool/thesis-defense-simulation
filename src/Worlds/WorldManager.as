/**
 * Created by shawn on 22-5-14.
 */
package Worlds
{
import Sprites.Meeple;

import flash.utils.Dictionary;

import net.flashpunk.FP;
import net.flashpunk.World;

import Simulation.Simulation;
import Simulation.Individual;

public class WorldManager
{
    private static var worlds:Dictionary = new Dictionary();

    public function WorldManager() {}

    public static function init():void
    {
        var simulation:Simulation = new Simulation();
        var meeples:Vector.<Meeple> = new Vector.<Meeple>();

        for each (var individual:Individual in simulation.GetIndividuals()) {
            var meeple:Meeple = new Meeple(individual, FP.rand(FP.width), FP.rand(FP.height));
            meeples.push(meeple);
        }

        add("title", new TitleScreen());
        add("simulation", new SimWorld(simulation, meeples));
    }

    public static function add(name:String, world:World):void
    {
        worlds[name] = world;
    }

    public static function get(name:String):World
    {
        return worlds[name];
    }

    public static function switchTo(name:String):void
    {
        FP.world = worlds[name];
    }
}
}
