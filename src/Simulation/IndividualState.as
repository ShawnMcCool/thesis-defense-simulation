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
		
		public static function doesStateChange():Boolean
		{
			return (FP.rand(9) < 2);
			
		}
		
		public static function generateNewState(eventCount:int):IndividualState
		{
			switch(FP.choose(0, 1, 2))
			{
				case 0:
					return new IndividualState(-.004, 0x51a4e4, eventCount);
				case 1:
					return new IndividualState(0, 0x9af74d, eventCount);
			}
            return new IndividualState(.004, 0xf74d81, eventCount);
		}
		
		public function duplicateStateWithoutEvent():IndividualState
		{
			return new IndividualState(getBeta(), getColor(), getEventCount());
		}
		
		public function getBeta():Number
		{
			return beta;
		}
		
		public function getEventCount():int
		{
			return eventCount;
		}
		
		public function eventOccurs():void
		{
			event = true;
		}
		
		public function hadEvent():Boolean
		{
			return event;
		}

        public function getColor():Number
        {
            return color;
        }
	}

}