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

    private var state:int = 0;

    private const STATE_INITIAL:int = 0;
    private const STATE_RUNNING:int = 1;
    private const STATE_ANALYSIS:int = 2;

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
			0x000000,
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

        if (state == STATE_RUNNING) {
            simulation.Update();
        }

        updateDayCount();
        updateMeepleColor();
        updateInput();
    }

    private function updateInput():void
    {
        if (state == STATE_INITIAL) {
            if (Input.pressed(Key.LEFT)) {
                WorldManager.switchTo("title");
            }
            if (Input.pressed(Key.RIGHT)) {
                ChangeState(STATE_RUNNING);
            }
        } else if(state == STATE_RUNNING) {
            if (Input.pressed(Key.LEFT)) {
                ChangeState(STATE_INITIAL);
            }
            if (Input.pressed(Key.RIGHT)) {
                ChangeState(STATE_ANALYSIS);
            }
        } else if(state == STATE_ANALYSIS) {
            if (Input.pressed(Key.LEFT)) {
                ChangeState(STATE_RUNNING);
            }
        }
    }

    private function ChangeState(state:int):void
    {
        if (state == STATE_RUNNING) {
            paused = false;
        }

        this.state = state;
    }

    private function updateMeepleColor():void
    {
        for each (var meeple:Meeple in meeples) {
            meeple.UpdateColor();
        }
    }

    private function updateDayCount():void
    {
        dayCountLabel.SetText(simulation.GetDayCount().toString());
    }
}
}