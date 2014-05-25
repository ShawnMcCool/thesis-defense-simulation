package Simulation
{
public class Individual
{
    private var baseHazardRate:Number;
    private var currentState:IndividualState;
    private var history:Vector.<IndividualState> = new Vector.<IndividualState>();

    public function Individual(baseHazardRate:Number = .002)
    {
        this.baseHazardRate = baseHazardRate;
        currentState = IndividualState.GenerateNewState(0);
    }

    public function getFirstEventColor():Number
    {
        for each (var state:IndividualState in history) {
            if (state.HadEvent()) {
                return state.GetColor();
            }
        }
        return 0;
    }

    public function getHistory():Vector.<IndividualState>
    {
        return history;
    }

    public function hadEvent():Boolean
    {
        return currentState.HadEvent();
    }

    public function getColor():Number
    {
        return currentState.GetColor();
    }

    public function hasEverHadAnEvent():Boolean
    {
        for each (var state:IndividualState in history) {
            if (state.HadEvent()) return true;
        }
        return false;
    }

    public function getTotalEventCount():int
    {
        var events:int = 0;

        for each (var state:IndividualState in history) {
            if (state.HadEvent()) {
                events++;
            }
        }

        return events;
    }

    public function dailyUpdate():void
    {
        assignNewState();
        if (hasEvent()) {
            currentState.EventOccurs();
        }
        history.push(currentState);
    }

    private function assignNewState():void
    {
        var eventCount:Number = this.currentState ? this.currentState.GetEventCount() : 0;
         
		if (IndividualState.DoesStateChange()){
			this.currentState = IndividualState.GenerateNewState(eventCount);
		} else {
			this.currentState = this.currentState.DuplicateStateWithoutEvent();
		}
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