package Entities
{
import Simulation.IndividualState;

public class HistoryMeeple extends Meeple
{
    private var state:IndividualState;

    public function HistoryMeeple(state:IndividualState)
    {
        super(0, 0);
        this.state = state;
		sprMeeple.tinting = 1;
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
