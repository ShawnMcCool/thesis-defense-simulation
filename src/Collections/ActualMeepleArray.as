package Collections
{
import Entities.HistoryMeeple;
import Simulation.Individual;

import net.flashpunk.FP;

import net.flashpunk.utils.Draw;

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


    override public function render():void
    {
        super.render();
        for each (var meeple:HistoryMeeple in meeples) {
            if (meeple.hadEvent()) {
                var x:int = leftOffset + horizontalMargin + getWidthPer() * meeples.indexOf(meeple);
                Draw.line(x, 0, x, FP.height, 0x000000);
            }
        }
    }
}
}
