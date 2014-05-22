package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	 
	public class TextEntity extends Entity
	{
		public function TextEntity(text:String) 
		{
			SetText(text);
			x = 20;
			y = 20;
			setOrigin(0, 0);
			
		}
		
		public function SetText(text:String):void
		{
			graphic = new Text("my butt is a butt.", 20, 20, 640, 480);
			
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}


			var splashText:Text = new Text("GAME NAME",0,0,640,480);
			splashText.color = 0x00ff00;
			splashText.size = 32;
			var splashEntity:Entity = new Entity(0,0,splashText);
			splashEntity.x = (FP.width/2)-(splashText.width/2);
			splashEntity.y = 100;
			add(splashEntity);