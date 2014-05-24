package Sprites
{
import net.flashpunk.Entity;
import net.flashpunk.FP;

public class MeepleArray extends Entity
{
    private var leftMargin:int = 40;
    private var topMargin:int = 40;

    private var meeples:Vector.<MeepleSprite> = new Vector.<MeepleSprite>();

    public function MeepleArray() {}

    public function addMeeple(color:Number):void
    {
        var meeple:MeepleSprite = new MeepleSprite(20, 20, .25);
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
        FP.log(meeples.length);
    }

    private function orderMeeples():void
    {
        var widthPer:int = getWidthPer();
        var i:int = 0;

        for each (var meeple:MeepleSprite in meeples) {
            meeple.x = leftMargin + widthPer*i;
            meeple.y = topMargin;
            i++;
        }
    }

    private function getWidthPer():int
    {
        var usableSpace:int = FP.width;

        return usableSpace / meeples.length;
    }
}
}
