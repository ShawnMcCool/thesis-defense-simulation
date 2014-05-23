package Simulation
{
public class Individual
{
    private var baseHazardRate:Number = .02;
    private var currentState:IndividualState;
    private var history:Vector.<IndividualState> = new Vector.<IndividualState>();

    public function Individual()
    {
        assignNewState();
    }

    public function HadEvent():Boolean
    {
        return currentState.HadEvent;
    }

    public function GetColor():Number
    {
        return currentState.GetColor();
    }

    public function DailyUpdate():void
    {
        if (hasEvent()) {
            currentState.EventOccurrs();
        }
        history.push(currentState);
        assignNewState();
    }

    private function assignNewState():void
    {
        var eventCount:Number = this.currentState ? this.currentState.GetEventCount() : 0;
        this.currentState = IndividualState.GenerateNewState(eventCount);
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