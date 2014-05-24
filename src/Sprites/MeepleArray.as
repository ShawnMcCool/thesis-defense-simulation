package Sprites
{
import net.flashpunk.Entity;
import net.flashpunk.FP;

public class MeepleArray extends Entity
{
    private var horizontalMargin:int = 40;
    private var verticalMargin:int = 40;

    private var meeples:Vector.<MeepleSprite> = new Vector.<MeepleSprite>();

    public function MeepleArray(horizontalMargin:int, verticalMargin:int)
    {
        this.horizontalMargin = horizontalMargin;
        this.verticalMargin = verticalMargin;
    }

    public function addMeeple(color:Number):void
    {
        var meeple:MeepleSprite = new MeepleSprite(20, 20, 1);
        meeple.setColor(color);
        meeples.push(meeple);
        world.add(meeple);
        orderMeeples();
    }

    public function clear():void
    {
        var meeple:MeepleSprite;
        while (meeple = meeples.pop()) {
            world.remove(meeple);
        }
    }

    private function orderMeeples():void
    {
        var widthPer:int = getWidthPer();
        var i:int = 0;

        for each (var meeple:MeepleSprite in meeples) {
            meeple.x = horizontalMargin + widthPer*i;
            meeple.y = verticalMargin;
            i++;
        }
    }

    private function getWidthPer():int
    {
        var usableSpace:int = FP.width - (horizontalMargin*2);
        return usableSpace / meeples.length;
    }
}
}
