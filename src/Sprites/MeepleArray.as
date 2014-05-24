package Sprites
{
import net.flashpunk.Entity;

public class MeepleArray extends Entity
{
    private var leftMargin:int = 40;
    private var topMargin:int = 40;

    private var meeples:Vector.<MeepleSprite> = new Vector.<MeepleSprite>();

    public function MeepleArray() {}

    public function addMeeple(color:Number):void
    {
        var meeple:MeepleSprite = new MeepleSprite(0, 0);
        meeples.push(meeple);
        world.add(meeple);
        orderMeeples();
    }

    private function orderMeeples():void
    {
        var widthPer:int = 60;
        var i:int = 0;

        for each (var meeple:MeepleSprite in meeples) {
            meeple.x = leftMargin + widthPer*i;
            meeple.y = topMargin;
            i++;
        }
    }

    override public function removed():void
    {
        for each (var meeple:MeepleSprite in meeples) {
            world.remove(meeple);
        }
        super.removed();
    }

    override public function added():void
    {
        super.added();
    }
}
}
