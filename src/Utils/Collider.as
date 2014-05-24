package Utils
{
import flash.geom.Point;
import net.flashpunk.Entity;

public class Collider extends Entity
{
    public function Collider(size:Point, type:String)
    {
        width = size.x;
        height = size.y;

        setHitbox(width, height);

        this.type = type;
        centerOrigin();
    }

    public function collidesWith(point:Point):Boolean
    {
        return collide("targetCollider", point.x, point.y);
    }

    override public function update():void
    {
        super.update();
    }
}
}
