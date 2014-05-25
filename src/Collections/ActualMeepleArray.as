package Collections
{
import Entities.*;

import Simulation.Individual;

public class ActualMeepleArray extends HistoryMeepleArray
{
    public function ActualMeepleArray(individual:Individual, horizontalMargin:int, verticalMargin:int)
    {
        super(individual, horizontalMargin, verticalMargin);
    }

    override protected function colorMeeples():void
    {
        for each (var meeple:HistoryMeeple in meeples) {
            meeple.setColorToCovariate();
        }
    }
}
}
