package
{
import net.flashpunk.World;
import net.flashpunk.FP;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

public class TitleScreen extends World
{
    private var titleEntity:TextEntity;
    private var authorEntity:TextEntity;

    public function TitleScreen()
    {
        renderAuthors();
        renderTitle();
    }

    private function renderAuthors():void
    {
        authorEntity = new TextEntity(
            "Author: Danielle McCool\nSupervisor: Maarten Cruyff",
			0xE4001B,
            32,
            0, FP.halfHeight + 100
        );

        authorEntity.CenterText();

        add(authorEntity);
    }

    private function renderTitle():void
    {
        titleEntity = new TextEntity(
            "Recurrent event model for\npopulation size estimation",
			0x606060,			
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