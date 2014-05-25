package Collections
{
import Entities.*;

import Simulation.Individual;
import Simulation.IndividualState;

public class PoissonMeepleArray extends HistoryMeepleArray
{
    public function PoissonMeepleArray(individual:Individual, horizontalMargin:int, verticalMargin:int)
    {
        super(individual, horizontalMargin, verticalMargin);
    }

    override protected function colorMeeples():void
    {
        var firstState:IndividualState;

        for each (var meeple:HistoryMeeple in meeples) {
            if ( ! firstState && meeple.hadEvent()) {
                firstState = meeple.getState();
            }
        }

        for each (meeple in meeples) {
            meeple.setColor(firstState.GetColor());
        }
    }
}
}
