package Collections
{
import Entities.SummaryMeeple;

import Simulation.Individual;

import net.flashpunk.FP;

public class MeeplePyramid extends MeepleArray
{
    private var individuals:Vector.<Individual>;

    public function MeeplePyramid(individuals:Vector.<Individual>, horizontalMargin:int, verticalMargin:int)
    {
        super(horizontalMargin, verticalMargin);
        this.individuals = individuals;
    }

    override public function added():void
    {
        super.added();
        buildMeeples();
        arrangeMeeples();
    }

    private function arrangeMeeples():void
    {
        meeples.sort(orderByEventCount);

        var totalRows:int = 13;
        var perRow:int = 14;
        var rowHeight:int = 60;
        var meepleXOffset:int = 30;

        var rowCounter:int = 0;
        var currentRow:int = totalRows;

        for each (var meeple:SummaryMeeple in meeples) {
            meeple.x = horizontalMargin + meepleXOffset*rowCounter;
            meeple.y = verticalMargin + rowHeight*currentRow;

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
        var aCount:int = a.getIndividual().GetTotalEventCount();
        var bCount:int = b.getIndividual().GetTotalEventCount();

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
