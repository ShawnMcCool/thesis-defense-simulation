package
{
import net.flashpunk.World;

import Simulation.Individual;
import Simulation.Simulation;

import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class SimWorld extends World
{
    private var simulation:Simulation;
    private var meeples:Vector.<Meeple> = new Vector.<Meeple>();

    private var paused:Boolean = true;
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

        dayCountLabel.SetPrefix("Day ");
        
        add(dayCountLabel);
    }

    private function initializeMeeples():void
    {
        var individuals:Vector.<Individual> = simulation.GetIndividuals();
        var counter:int = 0;

        for (var i:int = 0; i < 8; i++) {
            for (var j:int = 0; j < 13; j++) {
                var meep:Meeple = new Meeple(individuals[j + i * j], 78 * j + 39, 80 * i + 168);
                meeples.push(meep);
                add(meep);
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

        if ( ! paused) {
            simulation.Update();
        }

        updateDayCount();
        updateMeepleColor();
        updateInput();
    }

    private function updateInput():void
    {
        if (paused) {
            if (Input.pressed(Key.LEFT)) {
                WorldManager.switchTo("title");
            }
            if (Input.pressed(Key.RIGHT)) {
                paused = false;
            }
        } else {
            if (Input.pressed(Key.RIGHT)) {
                // change to analysis
            }
            if (Input.pressed(Key.LEFT)) {
                paused = true;
            }
        }
    }

    private function updateMeepleColor():void
    {

    }

    private function updateDayCount():void
    {
        dayCountLabel.SetText(simulation.GetDayCount().toString());
    }
}
}