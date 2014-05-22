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
            82,
            0, FP.halfHeight - 200
        );

        titleEntity.CenterText();

        add(titleEntity);
    }

    override public function update():void
    {
        if (Input.check(Key.RIGHT)) {
            WorldManager.switchTo("simulation");
        }
    }
}
}