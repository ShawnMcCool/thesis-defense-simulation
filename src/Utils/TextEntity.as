package Utils
{
import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Text;

public class TextEntity extends Entity
{
    private var text:Text;
    private var prefix:String = "";
	private var color:Number;

    public function TextEntity(text:String, color:Number = 0x000000, size:Number = 32, x:Number = 0, y:Number = 0)
    {
        setOrigin(0, 0);
        this.x = x;
        this.y = y;
		
        SetSize(size);
        SetText(text);
		SetColor(color);
    }
	
	public function SetColor(color:Number):void 
	{
		this.text.color = color;
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
		SetColor(color);
	}

    public function CenterText():void
    {
        this.x = FP.halfWidth - text.textWidth/2;
    }
}
}