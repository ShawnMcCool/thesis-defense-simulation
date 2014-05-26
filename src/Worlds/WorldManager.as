/**
 * Created by shawn on 22-5-14.
 */
package Worlds
{
import flash.utils.Dictionary;
import net.flashpunk.FP;
import net.flashpunk.World;
import Simulation.Simulation;

public class WorldManager
{
    private static var worlds:Dictionary = new Dictionary();
    private static var simulation:Simulation;

    public function WorldManager() {}

    public static function init():void
    {
        var unknownSimulation:Simulation = new Simulation();
        add("title", new TitleWorld());
        add("unknown_simulation", new UnknownSimulationWorld(unknownSimulation));

        var simulation:Simulation = new Simulation();
        add("simulation", new SimulationWorld(simulation));
        add("history", new IndividualHistoryWorld(simulation));
        add("summary", new SummaryWorld(simulation));
    }

    public static function switchTo(name:String):void
    {
        FP.world = worlds[name];
    }

    private static function add(name:String, world:World):void
    {
        worlds[name] = world;
    }
}
}
