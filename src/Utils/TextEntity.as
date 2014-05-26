package Utils
{
import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Text;

public class TextEntity extends Entity
{
    private var text:Text;
    private var size:int;
    private var prefix:String = "";
	private var color:Number;

    public function TextEntity(text:String, color:Number = 0xFF0000, size:Number = 32, x:Number = 0, y:Number = 0)
    {
        setOrigin(0, 0);
        this.x = x;
        this.y = y;
        this.size = size;

        SetColor(color);
        SetSize(size);
        SetText(text);
    }
	
	public function SetColor(color:Number):void 
	{
		this.color = color;
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
        SetSize(this.size);
        this.text = new Text(prefix + text);
        this.text.color = this.color;
        graphic = this.text;
    }

    public function center():void
    {
        this.x = FP.halfWidth - text.textWidth/2;
    }
}
}