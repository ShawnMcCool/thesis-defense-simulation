package Simulation
{
	public class Meeple 
	{
		private var baseHazardRate:Number = .02;
		private var currentState:MeepleState;
		private var history:Vector.<MeepleState> = new Vector.<MeepleState>();
		
		public function Meeple() 
		{
			getNewState();
		}

		public function DailyUpdate():void
		{
			if (hasEvent()) 
			{
				currentState.EventOccurrs();
			}
			history.push(currentState);
			getNewState();
		}
		
		private function getNewState():void
		{
			this.currentState = MeepleState.GenerateNewState(currentState.GetEventCount());
		}
		
		private function getHazardRate():Number
		{
			return baseHazardRate + currentState.GetBeta();
		}
		
		private function hasEvent():Boolean
		{
			return getHazardRate() >= Math.random();
		}
	}

}