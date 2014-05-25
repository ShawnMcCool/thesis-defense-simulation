package
{
import Worlds.WorldManager;

import net.flashpunk.Engine;
import net.flashpunk.FP;
import net.flashpunk.graphics.Text;
import Simulation.Simulation;

public class Main extends Engine
{
    [Embed(source="../assets/ufonts.com_gillsans.ttf", embedAsCFF="false", fontFamily="Gill Sans")] public const GILL_SANS:Class;

    public function Main()
    {
        Text.font = "Gill Sans";

        super(1024, 768, 60, true);

        FP.screen.color = 0xFFFFFF;
        FP.console.enable();

        WorldManager.init();
        WorldManager.switchTo("title");
    }

    override public function init():void
    {

    }
}
}