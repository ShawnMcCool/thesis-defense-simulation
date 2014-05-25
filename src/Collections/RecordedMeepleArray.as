package Collections
{
import Entities.*;

import Simulation.Individual;

public class RecordedMeepleArray extends HistoryMeepleArray
{
    public function RecordedMeepleArray(individual:Individual, horizontalMargin:int, verticalMargin:int)
    {
        super(individual, horizontalMargin, verticalMargin);
    }

    override protected function colorMeeples():void
    {
        for each (var meeple:HistoryMeeple in meeples) {
            if (meeple.hadEvent()) {
                meeple.setColorToCovariate();
            } else {
                meeple.SetColorToUnknown();
            }
        }
    }
}
}
