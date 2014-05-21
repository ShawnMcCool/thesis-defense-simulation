package   
{
	public class Simulation 
	{
		private var daysPerSecond:int = 4;
		private var numberOfMeeples:int = 20;
		
		private var meeples:Vector.<Meeple> = new Vector.<Meeple>();
		
		public function Simulation() 
		{
			for (var i:int = 0; i < numberOfMeeples; i++) 
			{
				meeples.push(new Meeple);
			}
		}
		
		public function Update():void
		{
			nextDay();
		}
		
		private function nextDay():void
		{
			updateMeeples();
		}
		
		private function updateMeeples():void
		{
			for each(var meeple:Meeple in meeples)
			{
				meeple.DailyUpdate();
			}
		}
	}

}