package Worlds
{
import Collections.MeeplePyramid;
import Simulation.Simulation;

import net.flashpunk.World;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class SummaryWorld extends World
{
    private var simulation:Simulation;
    private var pyramid:MeeplePyramid;

    private var state:int = 0;
    private const STATE_ALL_UNKNOWN:int = 0;
    private const STATE_REMOVE_WITHOUT_EVENTS:int = 1;
    private const STATE_SHOW_ALL:int = 2;
    private const STATE_COLOR_CAPTURED:int = 3;

    public function SummaryWorld(simulation:Simulation)
    {
        this.simulation = simulation;
        this.pyramid = new MeeplePyramid(simulation.getIndividuals());
        add(this.pyramid);
        changeState(STATE_ALL_UNKNOWN);
    }

    override public function update():void
    {
        switch (state) {
            case STATE_ALL_UNKNOWN:
                if (Input.pressed(Key.LEFT)) {
                    WorldManager.switchTo("history");
                }
                if (Input.pressed(Key.RIGHT)) {
                    changeState(STATE_REMOVE_WITHOUT_EVENTS);
                }
                break;
            case STATE_REMOVE_WITHOUT_EVENTS:
                if (Input.pressed(Key.LEFT)) {
                    changeState(STATE_ALL_UNKNOWN);
                }
                if (Input.pressed(Key.RIGHT)) {
                    changeState(STATE_SHOW_ALL);
                }
                break;
            case STATE_SHOW_ALL:
                if (Input.pressed(Key.LEFT)) {
                    changeState(STATE_REMOVE_WITHOUT_EVENTS);
                }
                if (Input.pressed(Key.RIGHT)) {
                    changeState(STATE_COLOR_CAPTURED);
                }
                break;
            case STATE_COLOR_CAPTURED:
                if (Input.pressed(Key.LEFT)) {
                    changeState(STATE_SHOW_ALL);
                }
                break;
        }

    }

    private function changeState(state:int):void
    {
        this.state = state;

        switch (state) {
            case STATE_ALL_UNKNOWN:
                pyramid.showAllMeeples();
                pyramid.colorAllMeeplesUnknown();
                break;
            case STATE_REMOVE_WITHOUT_EVENTS:
                pyramid.hideMeeplesWithoutEvents();
                break;
            case STATE_SHOW_ALL:
                pyramid.showAllMeeples();
                pyramid.colorAllMeeplesUnknown();
                break;
            case STATE_COLOR_CAPTURED:
                pyramid.colorMeeplesPoisson();
                break;
        }
    }
}
}