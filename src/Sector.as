package
{
import flash.geom.Point;

import net.flashpunk.Entity;
import net.flashpunk.FP;

public class Sector
{
    private var height:int;
    private var x:int;
    private var y:int;
    private var width:int;

    private var collider:Entity = new Collider(24, 24);

    private var circleOrigin:Point;

    private var exclusionCircleOrigin:Point;
    private var exclusionCircleRadius:int;

    private var inclusionCircleOrigin:Point;
    private var inclusionCircleRadius:int;

    public function Sector(x:int, y:int, width:int, height:int)
    {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;

        circleOrigin = new Point(x + width/2, y + height/2);
    }

    public function setExclusionRadius(radius:int):void
    {
        exclusionCircleOrigin = circleOrigin;
        exclusionCircleRadius = radius;
    }

    public function setInclusionRadius(radius:int):void
    {
        inclusionCircleOrigin = circleOrigin;
        inclusionCircleRadius = radius;
    }

    public function getTargetPoint():Point
    {
        var point:Point;

        do {
            point = getRandomPoint();
        } while ( ! fallsWithinBoundaries(point));

        return point;
    }

    private function fallsWithinBoundaries(point:Point):Boolean
    {
        var passesClusion:Boolean = true;

        if (exclusionCircleOrigin) {
            passesClusion = ! doesFallWithinCircle(exclusionCircleOrigin, exclusionCircleRadius, point);
        }

        if (inclusionCircleOrigin) {
            passesClusion = doesFallWithinCircle(inclusionCircleOrigin, inclusionCircleRadius, point);
        }

        return passesClusion;
    }

    private function getRandomPoint():Point
    {
        return new Point(x + FP.rand(width), y + FP.rand(height));
    }

    private function doesCollide(point:Point):Boolean
    {
        return false;
    }
    
    public function doesFallWithinCircle(origin:Point, radius:int, point:Point):Boolean
    {
        return Math.sqrt(Math.pow(origin.x - point.x, 2) + Math.pow(origin.y - point.y, 2)) < radius;
    }
}
}
