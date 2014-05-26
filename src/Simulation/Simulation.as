package Simulation
{
public class Simulation
{
    private var daysPerSecond:int = 1;
    private var numberOfIndividuals:int = 104;
    private var numberOfProblemChildren:int = 4;
    private var problemChildHazardRate:Number = .2;
    private var maxNumberOfSimulatedDays:int = 30;

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

    public function getIndividuals():Vector.<Individual>
    {
        return individuals;
    }

    public function update():void
    {
        if (getDayCount() >= maxNumberOfSimulatedDays) {
            return;
        }

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
            individual.dailyUpdate();
        }
    }

    public function getDayCount():Number
    {
        return dayCount;
    }

    public function countIndividualsWithMinimumEvents(number:Number):Number
    {
        var counter:int = 0;
        for each (var individual:Individual in individuals) {
            if (individual.getTotalEventCount() >= number) {
                counter++;
            }
        }
        return counter;
    }
}
}