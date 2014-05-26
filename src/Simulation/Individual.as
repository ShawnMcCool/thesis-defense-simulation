package Simulation
{
public class Individual
{
    private var baseHazardRate:Number;
    private var currentState:IndividualState;
    private var history:Vector.<IndividualState> = new Vector.<IndividualState>();

    public function Individual(baseHazardRate:Number = .0046666)
    {
        this.baseHazardRate = baseHazardRate;
        currentState = IndividualState.generateNewState(0);
    }

    public function getFirstEventColor():Number
    {
        for each (var state:IndividualState in history) {
            if (state.hadEvent()) {
                return state.getColor();
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
        return currentState.hadEvent();
    }

    public function getColor():Number
    {
        return currentState.getColor();
    }

    public function hasEverHadAnEvent():Boolean
    {
        for each (var state:IndividualState in history) {
            if (state.hadEvent()) return true;
        }
        return false;
    }

    public function getTotalEventCount():int
    {
        var events:int = 0;

        for each (var state:IndividualState in history) {
            if (state.hadEvent()) {
                events++;
            }
        }

        return events;
    }

    public function dailyUpdate():void
    {
        assignNewState();
        if (hasEvent()) {
            currentState.eventOccurs();
        }
        history.push(currentState);
    }

    private function assignNewState():void
    {
        var eventCount:Number = this.currentState ? this.currentState.getEventCount() : 0;
         
		if (IndividualState.doesStateChange()){
			this.currentState = IndividualState.generateNewState(eventCount);
		} else {
			this.currentState = this.currentState.duplicateStateWithoutEvent();
		}
    }

    private function getHazardRate():Number
    {
        return baseHazardRate + currentState.getBeta();
    }

    private function hasEvent():Boolean
    {
        return getHazardRate() >= Math.random();
    }
}
}