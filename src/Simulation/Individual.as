package Simulation
{
public class Individual
{
    private var baseHazardRate:Number = .00027;
    private var currentState:IndividualState;
    private var history:Vector.<IndividualState> = new Vector.<IndividualState>();

    public function Individual()
    {
        currentState = IndividualState.GenerateNewState(0);
    }

    public function GetTotalEventCount():int
    {
        var events:int = 0;

        for each (var state:IndividualState in history) {
            if (state.HadEvent()) {
                events++;
            }
        }

        return events;
    }

    public function GetHistory():Vector.<IndividualState>
    {
        return history;
    }

    public function GetHistoryToEvent(number:Number):Vector.<IndividualState>
    {
        return history.slice(0, getIndexOfEvent(number));
    }

    private function getIndexOfEvent(number:Number):Number
    {
        var counter:int = 0;
        for each (var state:IndividualState in history) {
            if (state.HadEvent()) {
                counter++;
            }
            if (counter == number) {
                return history.indexOf(state);
            }
        }
        return null;
    }

    public function HadEvent():Boolean
    {
        return currentState.HadEvent();
    }

    public function HasEverHadAnEvent():Boolean
    {
        for each (var state:IndividualState in history) {
            if (state.HadEvent()) return true;
        }
        return false;
    }

    public function GetColor():Number
    {
        return currentState.GetColor();
    }

    public function DailyUpdate():void
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