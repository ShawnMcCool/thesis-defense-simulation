package
{
import net.flashpunk.World;

import Simulation.Individual;
import Simulation.Simulation;

public class SimWorld extends World
{
    private var simulation:Simulation;

    private var dayCountLabel:TextEntity;

    public function SimWorld(simulation:Simulation)
    {
        super();
        this.simulation = simulation;

        initializeMeeples();
        initializeHud();
    }

    private function initializeHud():void
    {
        dayCountLabel = new TextEntity(
            "0",
            32,
            20, 20
        );

        add(dayCountLabel);
    }

    private function initializeMeeples():void
    {
        var individuals:Vector.<Individual> = simulation.GetIndividuals();
        var counter:int = 0;

        for (var i:int = 0; i < 8; i++) {
            for (var j:int = 0; j < 13; j++) {
                add(new Meeple(individuals[j + i * j], 78 * j + 39, 80 * i + 168));
                counter++;
                if (counter == individuals.length) {
                    return;
                }
            }
        }
    }

    override public function update():void
    {
        super.update();
        simulation.Update();
        updateDayCount();
    }

    private function updateDayCount():void
    {
        dayCountLabel.SetText(simulation.GetDayCount().toString());
    }
}
}