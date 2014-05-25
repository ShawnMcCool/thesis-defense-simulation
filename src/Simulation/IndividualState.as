package Simulation
{
	import net.flashpunk.FP;
		
	public class IndividualState 
	{
		private var beta:Number;
		private var color:Number;
		private var eventCount:int;
		private var event:Boolean = false;
		
		public function IndividualState(beta:Number, color:Number, eventCount:int) 
		{
			this.beta = beta;
			this.color = color;
			this.eventCount = eventCount;
		}
		
		public static function DoesStateChange():Boolean
		{
			return (FP.rand(9) < 2);
			
		}
		
		public static function GenerateNewState(eventCount:int):IndividualState
		{
			switch(FP.choose(0, 1, 2))
			{
				case 0:
					return new IndividualState(-.002, 0x52a5e5, eventCount);
				case 1:
					return new IndividualState(0, 0xffe250, eventCount);
			}
            return new IndividualState(.004, 0xfe5054, eventCount);
		}
		
		
		public function DuplicateStateWithoutEvent():IndividualState
		{
			return new IndividualState(GetBeta(), GetColor(), GetEventCount());
		}
		
		public function GetBeta():Number
		{
			return beta;
		}
		
		public function GetEventCount():int
		{
			return eventCount;
		}
		
		public function EventOccurs():void
		{
			event = true;
		}
		
		public function HadEvent():Boolean
		{
			return event;
		}

        public function GetColor():Number
        {
            return color;
        }
	}

}