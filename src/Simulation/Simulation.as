package Simulation
{
public class Simulation
{
    private var daysPerSecond:int = 4;
    private var numberOfIndividuals:int = 104;
    private var numberOfProblemChildren:int = 4;
    private var problemChildHazardRate:Number = .2;

    private var frameCount:int = 0;
    private var dayCount:int = 0;
    private var individuals:Vector.<Individual> = new Vector.<Individual>();

    public function Simulation()
    {
        for (var i:int = 0; i < numberOfIndividuals - numberOfProblemChildren; i++) {
            individuals.push(new Individual);
        }

        for (var j:int = 0; j < numberOfProblemChildren; j++) {
            individuals.push(new Individual(problemChildHazardRate));
        }
    }

    public function GetIndividuals():Vector.<Individual>
    {
        return individuals;
    }

    public function Update():void
    {
        frameCount++;
        if (frameCount == 60 / daysPerSecond) {
            frameCount = 0;
            nextDay();
        }
    }

    public function nextDay():void
    {
        dayCount++;
        for each(var individual:Individual in individuals) {
            individual.DailyUpdate();
        }
    }

    public function GetDayCount():Number
    {
        return dayCount;
    }

    public function CountIndividualsWithEvents():Number
    {
        return CountIndividualsWithMinimumEvents(1);
    }

    public function CountIndividualsWithMinimumEvents(number:Number):Number
    {
        var counter:int = 0;
        for each (var individual:Individual in individuals) {
            if (individual.GetTotalEventCount() >= number) {
                counter++;
            }
        }
        return counter;
    }
}
}