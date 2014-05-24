package Sprites
{
import flash.geom.Point;
import net.flashpunk.Mask;
import Simulation.Individual;

public class Meeple extends MeepleSprite
{
    private const speed:Number = 16;
    private const eventScaleSize:Number = 2;

    private var individual:Individual;
    private var homePoint:Point;
    private var targetPoint:Point;
    private var target:String = "home";

    public function Meeple(individual:Individual, x:Number = 0, y:Number = 0, mask:Mask = null)
    {
        super(x, y);
        homePoint = new Point(x, y);
        this.individual = individual;
    }

    public function HadEvent():Boolean
    {
        return individual.HadEvent();
    }

    public function GetTotalEventCount():int
    {
        return individual.GetTotalEventCount();
    }

    public function HasEverHadAnEvent():Boolean
    {
        return individual.HasEverHadAnEvent();
    }

    public function UpdateStyle():void
    {
        setColor(individual.GetColor());
        if (HadEvent()) {
            sprMeeple.scale = eventScaleSize;
        }
    }

    public function SetHomePoint(homePoint:Point):void
    {
        this.homePoint = homePoint;
    }

    public function GoHome():void
    {
        target = "home";
    }

    public function GoToTarget(targetPoint:Point):void
    {
        target = "target";
        this.targetPoint = targetPoint;
    }

    override public function update():void
    {
        super.update();

        if (target == "home") {
            moveTowards(homePoint.x, homePoint.y, speed);
        } else if (target == "target") {
            moveTowards(targetPoint.x, targetPoint.y, speed);
        }

        if (sprMeeple.scale > 1) {
            sprMeeple.scale -= .5;
        }
        if (sprMeeple.scale < 1) {
            sprMeeple.scale = 1;
        }
    }
}
}
