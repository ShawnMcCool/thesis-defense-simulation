package Entities
{
import flash.geom.Point;
import Simulation.Individual;

public class SimulationMeeple extends Meeple
{
    private const eventScaleSize:Number = 2;

    private var individual:Individual;
    private var homePoint:Point;
    private var targetPoint:Point;
    private var target:String = "home";

    public function SimulationMeeple(individual:Individual, x:Number = 0, y:Number = 0)
    {
        super(x, y);
        homePoint = new Point(x, y);
        this.individual = individual;
    }

    public function HadEvent():Boolean
    {
        return individual.hadEvent();
    }

    public function GetTotalEventCount():int
    {
        return individual.getTotalEventCount();
    }

    public function HasEverHadAnEvent():Boolean
    {
        return individual.hasEverHadAnEvent();
    }

    public function setColorToUnknown():void
    {
        setColor(unknownColor);
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
        updateStyles();
        updateTargeting();
    }

    private function updateTargeting():void
    {
        if (target == "home") {
            moveTowards(homePoint.x, homePoint.y, speed);
        } else if (target == "target") {
            moveTowards(targetPoint.x, targetPoint.y, speed);
        }
    }

    public function setMeepleColorToCovariate():void
    {
        setColor(individual.getColor());
    }

    private function updateStyles():void
    {
        if (HadEvent()) {
            sprMeeple.scale = eventScaleSize;
			setTint(GetTotalEventCount());
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
