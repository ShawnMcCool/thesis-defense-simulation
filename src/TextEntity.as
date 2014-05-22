package
{
import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Text;

public class TextEntity extends Entity
{
    private var text:Text;

    public function TextEntity(text:String, size:Number = 32, x:Number = 0, y:Number = 0)
    {
        setOrigin(0, 0);
        this.x = x;
        this.y = y;

        SetSize(size);
        SetText(text);
    }

    private function SetSize(size:Number = 32):void
    {
        Text.size = size;
    }

    public function SetText(text:String):void
    {
        this.text = new Text(text);
        graphic = this.text;
    }

    public function CenterText():void
    {
        this.x = FP.halfWidth - text.textWidth/2;
    }
}
}