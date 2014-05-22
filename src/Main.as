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
			//FP.world = new SimWorld(new Simulation);
			FP.world = new TitleScreen();
			FP.screen.color = 0xC6C6C6;
			
		}

		override public function init():void
		{
			
		}
	}
}