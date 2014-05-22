package
{
import net.flashpunk.Entity;
import net.flashpunk.World;
import net.flashpunk.FP;
import net.flashpunk.graphics.Text;

public class TitleScreen extends World
{
    [Embed(source="../assets/ufonts.com_gillsans.ttf", embedAsCFF="false", fontFamily="Gill Sans")]
    const GILL_SANS:Class;

    private var authorText:Text;
    private var authorEntity:Entity;

    public function TitleScreen()
    {
        renderAuthors();
        renderTitle();
    }

    private function renderAuthors():void
    {
        Text.font = "Gill Sans";
        Text.size = 32;
        Text.align = "left";

        authorText = new Text("Author: Danielle McCool\nSupervisor: Maarten Cruyff");

        authorEntity = new Entity(FP.halfWidth - authorText.textWidth/2, FP.halfHeight + 100, new Text("Author: Danielle McCool\nSupervisor: Maarten Cruyff"));

        add(authorEntity);
    }

    private function renderTitle():void
    {
        Text.font = "Gill Sans";
        Text.size = 82;
        Text.align = "center";

        var titleText:Text = new Text("Recurrent event model for\npopulation size estimation", 0, 0, {size: 82, align: "center"});
        titleText.color = 0x000000;

        var titleEntity:Entity = new Entity(FP.halfWidth - titleText.textWidth/2, FP.halfHeight - 200, titleText);

        add(titleEntity);
    }

    override public function update():void
    {

    }
}
}