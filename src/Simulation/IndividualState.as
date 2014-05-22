package Simulation
{
	import net.flashpunk.FP;
		
	public class IndividualState 
	{
		private var beta:Number;
		private var color:Number;
		private var eventCount:int;
		private var event:Boolean;
		
		public function IndividualState(beta:Number, color:Number, eventCount:int) 
		{
			this.beta = beta;
			this.color = color;
			this.eventCount = eventCount;
		}
		
		public static function GenerateNewState(eventCount:int):IndividualState
		{
			var state:int = FP.choose(0, 1, 2);

			switch(state)
			{
				case 0:
					return new IndividualState(0, 0xFF0000, eventCount);
				case 1:
					return new IndividualState(.02, 0x00FF00, eventCount);
				case 2:
					return new IndividualState(.04, 0x0000FF, eventCount);
			}
			
			throw new Error("Covariate randomization error.");
		}
		
		public function GetBeta():Number
		{
			return beta;
		}
		
		public function GetEventCount():int
		{
			return eventCount;
		}
		
		public function EventOccurrs():void
		{
			event = true;
		}
		
		public function HadEvent():Boolean
		{
			return event;
		}
	}

}