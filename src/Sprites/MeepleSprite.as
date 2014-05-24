package Sprites
{
import net.flashpunk.Entity;
import net.flashpunk.graphics.Spritemap;

public class MeepleSprite extends Entity
{
    [Embed(source="../../assets/spritesheet-w.png")]
    protected var MEEPLE:Class;
    public var sprMeeple:Spritemap = new Spritemap(MEEPLE, 51, 51);

    public function MeepleSprite(x:Number = 0, y:Number = 0, scale:Number = 1)
    {
        super(x, y, sprMeeple);
        sprMeeple.scale = scale;
        setHitbox(0, 0, 0, 0);
        configureGraphics();
    }

    public function setColor(color:Number):void
    {
        sprMeeple.color = color;
    }

    private function configureGraphics():void
    {
        graphic = sprMeeple;
        sprMeeple.add("stand", [0], 20, true);
        sprMeeple.add("wiggle", [0, 1, 2, 3], 20, true);
        sprMeeple.centerOrigin();
        centerOrigin();
    }
}
}
