package
{
import net.flashpunk.Engine;
import net.flashpunk.FP;
import net.flashpunk.graphics.Text;
import Simulation.Simulation;

public class Main extends Engine
{
    [Embed(source="../assets/ufonts.com_gillsans.ttf", embedAsCFF="false", fontFamily="Gill Sans")] const GILL_SANS:Class;

    public function Main()
    {
        Text.font = "Gill Sans";

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