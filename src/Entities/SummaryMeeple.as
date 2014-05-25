package Entities
{
import Simulation.IndividualState;

public class SummaryMeeple extends Meeple
{
    private var state:IndividualState;
    protected var unknownColor:Number = 0xC1C1C1;

    public function SummaryMeeple(state:IndividualState)
    {
        super(0, 0);
        this.state = state;
    }

    public function hadEvent():Boolean
    {
        return state.HadEvent();
    }

    public function isColorUnknown():Boolean
    {
        return getColor() == unknownColor;
    }

    public function setColorToCovariate():void
    {
        setColor(state.GetColor());
    }

    public function SetColorToUnknown():void
    {
        setColor(unknownColor);
    }

    public function getState():IndividualState
    {
        return state;
    }
}
}
