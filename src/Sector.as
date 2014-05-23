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

        circleOrigin = new Point(x + (width), y + (height));
        circleRadius = width/2;
    }

    public function setExclusionRadius(radius:int):void
    {
        exclusionCircleOrigin = circleOrigin;
        exclusionCircleRadius = radius;
    }

    public function getTargetPoint():Point
    {
        var point:Point;
        var fallsWithinCircle:Boolean = false;
        var collides:Boolean = false;
        var isExcluded:Boolean = true;

        while(( ! fallsWithinCircle || collides) && isExcluded) {
//            private var freedomSector:Sector = new Sector(0, 0, FP.halfWidth, FP.height);
            point = new Point(x + FP.rand(width), y + FP.rand(height));

            fallsWithinCircle = doesFallWithinCircle(circleOrigin, circleRadius, point);
            collides = doesCollide(point);

            if (exclusionCircleOrigin) {
                isExcluded = ! doesFallWithinCircle(exclusionCircleOrigin, exclusionCircleRadius, point);
            }
        } 

        return point;
    }
    private function doesCollide(point:Point):Boolean
    {
        return false;
    }
    
    public function doesFallWithinCircle(origin:Point, radius:int, point:Point):Boolean
    {
        return Math.sqrt((origin.x - point.x)^2 + (origin.y - point.y)^2) < radius;
    }
}
}
