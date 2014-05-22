/**
 * Created by shawn on 22-5-14.
 */
package
{
import flash.utils.Dictionary;

import net.flashpunk.FP;

import net.flashpunk.World;

public class WorldManager
{
    private static var worlds:Dictionary = new Dictionary();

    public function WorldManager()
    {
    }

    public static function add(name:String, world:World)
    {
        worlds[name] = world;
    }

    public static function get(name:String)
    {
        return worlds[name];
    }

    public static function switchTo(name:String)
    {
        FP.world = worlds[name];
    }
}
}
