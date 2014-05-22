package
{
import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Text;

public class TextEntity extends Entity
{
    private var text:Text;
    private var prefix:String = "";

    public function TextEntity(text:String, size:Number = 32, x:Number = 0, y:Number = 0)
    {
        setOrigin(0, 0);
        this.x = x;
        this.y = y;

        SetSize(size);
        SetText(text);
    }

    public function SetPrefix(prefix:String):void
    {
        this.prefix = prefix;
    }

    private function SetSize(size:Number = 32):void
    {
        Text.size = size;
    }

    public function SetText(text:String):void
    {
        this.text = new Text(prefix + text);
        graphic = this.text;
    }

    public function CenterText():void
    {
        this.x = FP.halfWidth - text.textWidth/2;
    }
}
}