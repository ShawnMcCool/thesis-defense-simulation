package Collections
{
import Entities.SummaryMeeple;

import Simulation.Individual;

import net.flashpunk.FP;

public class MeeplePyramid extends MeepleArray
{
    private var individuals:Vector.<Individual>;

    public function MeeplePyramid(individuals:Vector.<Individual>)
    {
        super(0, 0);
        this.individuals = individuals;
    }

    override public function added():void
    {
        super.added();
        buildMeeples();
        arrangeMeeples();
        colorAllMeeplesUnknown();
    }

    public function showAllMeeples():void
    {
        for each (var meeple:SummaryMeeple in meeples) {
            meeple.show();
        }
    }

    public function hideMeeplesWithoutEvents():void
    {
        for each (var meeple:SummaryMeeple in meeples) {
            if (!meeple.hasEverHadAnEvent()) {
                meeple.hide();
            }
        }
    }

    public function colorAllMeeplesUnknown():void
    {
        for each (var meeple:SummaryMeeple in meeples) {
            meeple.setColorToUnknown();
            meeple.tintByEventCount();
        }
    }

    public function colorMeeplesPoisson():void
    {
        for each (var meeple:SummaryMeeple in meeples) {
            meeple.colorPoisson();
        }
    }

    private function arrangeMeeples():void
    {
        meeples.sort(orderByEventCount);

        var totalRows:int = 13;
        var perRow:int = 14;
        var rowHeight:int = 50;
        var meepleXOffset:int = 70;

        var rowCounter:int = 0;
        var currentRow:int = totalRows;
        var centeringMargin:int = FP.halfWidth;

        verticalMargin = 25;

        for each (var meeple:SummaryMeeple in meeples) {

            meeple.x = centeringMargin - ((perRow - 1) * meepleXOffset / 2) + (meepleXOffset * rowCounter);
            meeple.y = verticalMargin + rowHeight * currentRow;

            // update row counter
            rowCounter++;
            if (rowCounter == perRow) {
                currentRow--;
                rowCounter = 0;
                perRow--;
            }
        }
    }

    private function orderByEventCount(a:SummaryMeeple, b:SummaryMeeple):int
    {
        var aCount:int = a.getIndividual().getTotalEventCount();
        var bCount:int = b.getIndividual().getTotalEventCount();

        if (aCount < bCount) {
            return -1;
        } else if (bCount < aCount) {
            return 1;
        }

        return 0;
    }

    private function buildMeeples():void
    {
        for each (var individual:Individual in individuals) {
            var meeple:SummaryMeeple = new SummaryMeeple(individual);
            meeples.push(meeple);
            world.add(meeple);
        }
    }
}
}
