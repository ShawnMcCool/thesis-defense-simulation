package Entities
{
import Simulation.Individual;

import net.flashpunk.FP;

public class SummaryMeeple extends Meeple
{
    private var individual:Individual;

    public function SummaryMeeple(individual:Individual)
    {
        super(0, 0);
        this.individual = individual;
    }

    public function hadEvent():Boolean
    {
        return individual.hadEvent();
    }

    public function hasEverHadAnEvent():Boolean
    {
        return individual.hasEverHadAnEvent();
    }

    public function hide():void
    {
        visible = false;
    }

    public function show():void
    {
        visible = true;
    }

    public function isColorUnknown():Boolean
    {
        return getColor() == unknownColor;
    }

    public function setColorToCovariate():void
    {
        setColor(individual.getColor());
    }

    public function setColorToUnknown():void
    {
        setColor(unknownColor);
    }

    public function getIndividual():Individual
    {
        return individual;
    }

    public function colorPoisson():void
    {
        var color:Number = individual.getFirstEventColor();

        if (color == 0) {
            color = unknownColor;
        }

        setColor(color);
        setTint(individual.getTotalEventCount());
    }
}
}
