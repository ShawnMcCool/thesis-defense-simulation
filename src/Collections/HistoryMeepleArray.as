package Collections
{
import Entities.*;

import Simulation.Individual;
import Simulation.IndividualState;

public class HistoryMeepleArray extends MeepleArray
{
    protected var individual:Individual;

    public function HistoryMeepleArray(individual:Individual, horizontalMargin:int, verticalMargin:int)
    {
        super(horizontalMargin, verticalMargin);
        this.individual = individual;

        this.horizontalMargin = horizontalMargin;
        this.verticalMargin = verticalMargin;
    }

    override public function added():void
    {
        super.added();
        buildMeeplesFromHistory();
    }

    protected function buildMeeplesFromHistory():void
    {
        for each (var state:IndividualState in individual.getHistory()) {
            var meeple:HistoryMeeple = new HistoryMeeple(state);
            addMeeple(meeple);

            if (state.hadEvent()) {
                meeple.setEventStyle();
            }
        }
        colorMeeples();
        orderMeeples();
    }

    protected function colorMeeples():void
    {
    }
}
}
