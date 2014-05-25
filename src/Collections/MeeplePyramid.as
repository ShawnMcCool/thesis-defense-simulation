package Collections
{
import Simulation.Individual;

public class MeeplePyramid extends MeepleArray
{
    public function MeeplePyramid(individuals:Vector.<Individual>, horizontalMargin:int, verticalMargin:int)
    {
        super(horizontalMargin, verticalMargin);
    }

    override public function added():void
    {
        super.added();
        buildMeeples();
    }

    private function buildMeeples():void
    {
        
    }
}
}
