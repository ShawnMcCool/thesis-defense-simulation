package Entities
{
import flash.geom.Point;

import net.flashpunk.Entity;
import net.flashpunk.graphics.Spritemap;

public class Meeple extends Entity
{
    [Embed(source="../../assets/test_meeple_spritesheet.png")]
    protected var MEEPLE:Class;

    [Embed(source="../../assets/event_meeple_3.png")]
    protected var EVENTMEEPLE:Class;

    protected var previousPoint:Point = new Point(0, 0);
    protected var speed:Number = 10;
    public var sprMeeple:Spritemap;
    protected var unknownColor:Number = 0xe6e6e6;

    public function Meeple(x:Number = 0, y:Number = 0)
    {
        sprMeeple = new Spritemap(MEEPLE, 51, 51);
        super(x, y, sprMeeple);
        setHitbox(0, 0, 0, 0);
        configureGraphics();
    }

    public function setEventStyle():void
    {
        sprMeeple = new Spritemap(EVENTMEEPLE, 51, 51);
        sprMeeple.centerOrigin();
        sprMeeple.scale = 1;
        graphic = sprMeeple;
    }

    public function setColorUnknown():void
    {
        setColor(unknownColor);
    }

    public function setColor(color:Number):void
    {
        sprMeeple.color = color;
    }
	
	public function setTint(events:int):void
	{
		sprMeeple.tinting = .50*events + .50;
	}

    public function getColor():Number
    {
        return sprMeeple.color;
    }
	
	public function getTint():Number
	{
		return sprMeeple.tinting;
	}

    private function configureGraphics():void
    {
        graphic = sprMeeple;
        sprMeeple.add("stand", [0], 1, true);
        sprMeeple.add("walk", [0,1,2,3,4,5,6,7,8], .5, true);
        sprMeeple.play("stand");
        sprMeeple.centerOrigin();
		sprMeeple.tintMode = 0;
		sprMeeple.tinting = .5;
        centerOrigin();
    }

    override public function update():void
    {
        super.update();
        var currentAnim:String = sprMeeple.currentAnim;

        if (currentAnim == "stand" && moved()) {
            sprMeeple.play("walk");
        } else if (currentAnim == "walk" && ! moved()) {
            sprMeeple.play("stand");
        }

        previousPoint = new Point(x, y);
    }

    private function moved():Boolean
    {
        return previousPoint.x != x || previousPoint.y != y;
    }
}
}
