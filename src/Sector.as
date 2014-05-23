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
    private var circleRadius:int;

    private var exclusionCircleOrigin:Point;
    private var exclusionCircleRadius:int;

    public function Sector(x:int, y:int, width:int, height:int)
    {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;

        circleOrigin = new Point(x + width/2, y + height/2);
        circleRadius = 200;
    }

    public function setExclusionRadius(radius:int):void
    {
        exclusionCircleOrigin = circleOrigin;
        exclusionCircleRadius = radius;
    }

    public function getTargetPoint():Point
    {
        var point:Point;

        do {
            point = getRandomPoint();
        } while ( ! fallsWithinBoundaries(point) || doesCollide(point));

        return point;
    }

    private function fallsWithinBoundaries(point:Point):Boolean
    {
        var fallsWithinCircle:Boolean = doesFallWithinCircle(circleOrigin, circleRadius, point);
        var isExcluded:Boolean = true;

        if (exclusionCircleOrigin) {
             isExcluded = ! doesFallWithinCircle(exclusionCircleOrigin, exclusionCircleRadius, point);
        }

        return fallsWithinCircle && isExcluded;
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
