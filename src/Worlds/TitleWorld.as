package Worlds
{
import Utils.TextEntity;

import net.flashpunk.World;
import net.flashpunk.FP;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class TitleWorld extends World
{
    private var titleEntity:TextEntity;
    private var authorEntity:TextEntity;

    public function TitleWorld()
    {
        renderText();
    }

    private function renderText():void
    {
        authorEntity = new TextEntity(
            "Author: Danielle McCool\nSupervisor: Maarten Cruyff",
			0x611A23,
            32,
            0, FP.halfHeight + 100
        );
        authorEntity.CenterText();
        add(authorEntity);

        titleEntity = new TextEntity(
            "Recurrent event model for\npopulation size estimation",
            0x051C24,
            82,
            0, FP.halfHeight - 200
        );
        titleEntity.CenterText();
        add(titleEntity);
    }

    override public function update():void
    {
        if (Input.pressed(Key.RIGHT)) {
            WorldManager.switchTo("simulation");
        }
    }
}
}