package Collections
{
import Entities.*;
import Simulation.Individual;
import net.flashpunk.FP;

public class ProportionalMeepleArray extends HistoryMeepleArray
{
    public function ProportionalMeepleArray(individual:Individual, horizontalMargin:int, verticalMargin:int)
    {
        super(individual, horizontalMargin, verticalMargin);
    }

    override protected function colorMeeples():void
    {
        var colors:Array = new Array();

        for each (var meeple:HistoryMeeple in meeples) {
            if (meeple.hadEvent()) {
                colors.push(meeple.getState().GetColor());
                meeple.setColorToCovariate();
            } else {
                meeple.SetColorToUnknown();
            }
        }

        for each (meeple in meeples) {
            if (meeple.isColorUnknown()) {
                meeple.setColor(FP.choose(colors));
            }
        }
    }
}
}
