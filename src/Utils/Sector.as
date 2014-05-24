package Utils
{
import flash.geom.Point;

import net.flashpunk.Entity;
import net.flashpunk.FP;

public class Sector extends Entity
{
    private var colliderSize:Point = new Point(30, 30);
    private var borderMargin:int = 20;

    private var collider:Collider = new Collider(colliderSize, "collider");;
    private var colliderPool:Vector.<Collider> = new Vector.<Collider>();
    private var colliderIndex:int = 0;

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

        circleOrigin = new Point(x + width / 2, y + height / 2);
    }

    override public function added():void
    {
        super.added();

        world.add(collider);

        for (var i:int = 0; i < 104; i++) {
            var newCollider:Collider = new Collider(colliderSize, "targetCollider");
            colliderPool.push(newCollider);
            world.add(newCollider);
        }

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

    public function resetCollision():void
    {
        colliderIndex = 0;
        for each (var collider:Collider in colliderPool) {
            collider.x = 0;
            collider.y = 0;
        }
    }

    public function getTargetPoint():Point
    {
        var point:Point;

        do {
            do {
                point = getRandomPoint();
            } while ( ! fallsWithinBoundaries(point));
        } while (collides(point));

        return point;
    }

    private function fallsWithinBoundaries(point:Point):Boolean
    {
        var withinMargin:Boolean = true;
        var passesClusion:Boolean = true;

        if (point.x < borderMargin || point.x > FP.width - borderMargin) {
            withinMargin = false;
        }

        if (point.y < borderMargin || point.y > FP.height - borderMargin) {
            withinMargin = false;
        }

        if (exclusionCircleOrigin) {
            passesClusion = !doesFallWithinCircle(exclusionCircleOrigin, exclusionCircleRadius, point);
        }

        if (inclusionCircleOrigin) {
            passesClusion = doesFallWithinCircle(inclusionCircleOrigin, inclusionCircleRadius, point);
        }

        return withinMargin && passesClusion;
    }

    private function getRandomPoint():Point
    {
        return new Point(x + FP.rand(width), y + FP.rand(height));
    }

    private function collides(point:Point):Boolean
    {
        if (collider.collidesWith(point)) {
            FP.log("collision detected");
            return true;
        }

        colliderPool[colliderIndex].x = point.x;
        colliderPool[colliderIndex].y = point.y;

        colliderIndex++;
        if (colliderIndex >= colliderPool.length) {
            colliderIndex = 0;
        }

        return false;
    }

    public function doesFallWithinCircle(origin:Point, radius:int, point:Point):Boolean
    {
        return Math.sqrt(Math.pow(origin.x - point.x, 2) + Math.pow(origin.y - point.y, 2)) < radius;
    }
}
}
