package Entities
{
import Simulation.Individual;

public class SummaryMeeple extends Meeple
{
    private var individual:Individual;
    protected var unknownColor:Number = 0xC1C1C1;

    public function SummaryMeeple(individual:Individual)
    {
        super(0, 0);
        this.individual = individual;
    }

    public function hadEvent():Boolean
    {
        return individual.HadEvent();
    }

    public function isColorUnknown():Boolean
    {
        return getColor() == unknownColor;
    }

    public function setColorToCovariate():void
    {
        setColor(individual.GetColor());
    }

    public function SetColorToUnknown():void
    {
        setColor(unknownColor);
    }

    public function getIndividual():Individual
    {
        return individual;
    }
}
}
