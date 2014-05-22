package {
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Text;
	
	public class TitleScreen extends World 
	{
		public function TitleScreen() 
		{
			var titleText:Text = new Text("Author: Danielle McCool\nSupervisor: Maarten Cruyff");
			var textEntity:Entity = new Entity(0, 0, titleText);
			[Embed(source = "../assets/ufonts.com_gillsans.ttf", embedAsCFF = "false", fontFamily = "Gill Sans")]
			const GILL_SANS:Class;

			textEntity.x = (FP.halfWidth)-(titleText.width/2);
			textEntity.y = (FP.halfHeight) - (titleText.height / 2);
			titleText.font = "Gill Sans";
			add(textEntity);
			var splashText:Text = new Text("Recurrent event model for\npopulation size estimation");
			splashText.color = 0x000000;
			splashText.size = 64;
			splashText.font = "Gill Sans";
			splashText.centerOrigin();
			var splashEntity:Entity = new Entity(FP.halfWidth+100,FP.halfHeight - 200,splashText);
			add(splashEntity);
		}
		override public function update():void 
		{
			
		}
		}
	}