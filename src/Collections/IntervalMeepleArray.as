package Collections
{
import Entities.*;

import Simulation.Individual;
import Simulation.IndividualState;

import flash.utils.Dictionary;

import net.flashpunk.FP;

public class IntervalMeepleArray extends HistoryMeepleArray
{
    public function IntervalMeepleArray(individual:Individual, horizontalMargin:int, verticalMargin:int)
    {
        super(individual, horizontalMargin, verticalMargin);
    }

    override protected function colorMeeples():void
    {
        var counter:int = 0;
        var events:Dictionary = new Dictionary();

        for each (var meeple:HistoryMeeple in meeples) {
            if (meeple.hadEvent()) {
                events[counter] = meeple.getState();
                meeple.setColorToCovariate();
            } else {
                meeple.SetColorToUnknown();
            }
            counter++;
        }

        counter = 0;
        for each (meeple in meeples) {
            if (meeple.isColorUnknown()) {
                if (getNextEventIndex(events, counter)) {
                    meeple.setColor(events[getNextEventIndex(events, counter)].GetColor());
                } else {
                    meeple.setColor(events[getPreviousEventIndex(events, counter)].GetColor());
                }
            }
            counter++;
        }
    }

    private function getNextEventIndex(events:Dictionary, counter:int):Number
    {
        var indices:Array = new Array();

        for (var k:Object in events) {
            var value:IndividualState = events[k];
            var key:String = k.toString();
            indices.push(int(key));
        }

        indices.sort(Array.NUMERIC);

        for each (var index:int in indices) {
            if (index >= counter) {
                return index;
            }
        }

        return 0;
    }

    private function getPreviousEventIndex(events:Dictionary, counter:int):Number
    {
        var indices:Array = new Array();

        for (var k:Object in events) {
            var value:IndividualState = events[k];
            var key:String = k.toString();
            indices.push(int(key));
        }

        indices.sort(Array.NUMERIC | Array.DESCENDING);

        for each (var index:int in indices) {
            if (counter >= index) {
                return index;
            }
        }

        return 0;
    }
}
}
