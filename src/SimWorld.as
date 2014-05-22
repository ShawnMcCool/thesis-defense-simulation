package  
{
	import net.flashpunk.World;
	import Simulation.Individual;
	import Simulation.Simulation;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.graphics.Text;
		
	public class SimWorld extends World 
	{
		private var simulation:Simulation;
		private var dayCountText:Text;
		
		public function SimWorld(simulation:Simulation) 
		{
			super();
			this.simulation = simulation;
			initializeMeeples();
		}
		
		private function initializeMeeples():void
		{
			var individuals:Vector.<Individual> = simulation.GetIndividuals();
			var counter:int = 0;
			
			for (var i:int = 0; i < 8 ; i++) 
			{
				for (var j:int = 0; j < 13; j++) 
				{
					add(new Meeple(individuals[j + i * j], 78 * j + 39, 80 * i + 168));
					counter++;
					trace(counter);
					if (counter == individuals.length) 
					{
						return;
					}
				}
			}
		}
		
		override public function update():void 
		{
			super.update();
			simulation.Update();
			Draw.text("I poop into my own butt - Shawn");

		}
		
	}

}