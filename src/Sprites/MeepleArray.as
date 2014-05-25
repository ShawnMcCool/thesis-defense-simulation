package Sprites
{
import net.flashpunk.Entity;
import net.flashpunk.FP;

public class MeepleArray extends Entity
{
    protected var horizontalMargin:int = 40;
    protected var verticalMargin:int = 40;
    private var leftOffset:int = 100;

    protected var meeples:Vector.<Meeple> = new Vector.<Meeple>();

    public function MeepleArray(horizontalMargin:int, verticalMargin:int)
    {
        this.horizontalMargin = horizontalMargin;
        this.verticalMargin = verticalMargin;
    }

    public function addMeeple(meeple:Meeple):void
    {
        meeples.push(meeple);
        world.add(meeple);
        orderMeeples();
    }

    public function getAll():Vector.<Meeple>
    {
        return meeples;
    }

    public function getIndex(index:int):Meeple
    {
        return meeples[index];
    }

    public function clear():void
    {
        var meeple:Meeple;
        while (meeple = meeples.pop()) {
            world.remove(meeple);
        }
    }

    protected function orderMeeples():void
    {
        var widthPer:int = getWidthPer();
        var i:int = 0;

        for each (var meeple:Meeple in meeples) {
            meeple.x = leftOffset + horizontalMargin + widthPer*i;
            meeple.y = verticalMargin;
            i++;
        }
    }

    private function getWidthPer():int
    {
        var usableSpace:int = FP.width - (horizontalMargin*2);
        return usableSpace / meeples.length;
    }

    override public function removed():void
    {
        super.removed();
        for each (var meeple:Meeple in meeples) {
            world.remove(meeple);
        }
    }
}
}
