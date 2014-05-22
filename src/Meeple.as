package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Spritemap;
	import Simulation.Individual;
	
	public class Meeple extends Entity 
	{
		[Embed(source = "../assets/spritesheet-w.png")]
		protected var MEEPLE:Class;
		public var sprMeeple:Spritemap = new Spritemap(MEEPLE, 51, 51);
		public var checkCollision:Boolean = true;
		private var individual:Individual;
		
		public function Meeple(individual:Individual, x:Number=0, y:Number=0, mask:Mask=null) 
		{
			sprMeeple.add("stand", [0], 20, true);
			sprMeeple.add("wiggle", [0, 1, 2, 3], 20, true);
			graphic = sprMeeple;
			type = "solid";
			super(x, y, graphic);
			
						
			this.individual = individual;
			
			if (!mask) setHitboxTo(graphic);
			sprMeeple.centerOrigin();
			centerOrigin();		
		}
		
		override public function update():void 
		{
			super.update();	
		}
	}

}
