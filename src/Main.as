package
{
import net.flashpunk.Engine;
import net.flashpunk.FP;
import Simulation.Simulation;

public class Main extends Engine
{
    public function Main()
    {
        super(1024, 768, 60, true);

        FP.screen.color = 0xC6C6C6;

        WorldManager.add("title", new TitleScreen());
        WorldManager.add("simulation", new SimWorld(new Simulation));

        WorldManager.switchTo("title");
    }

    override public function init():void
    {

    }
}
}