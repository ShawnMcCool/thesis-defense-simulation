package
{
import net.flashpunk.Entity;
import net.flashpunk.Mask;
import net.flashpunk.graphics.Spritemap;

import Simulation.Individual;

public class Meeple extends Entity
{
    [Embed(source="../assets/spritesheet-w.png")]
    protected var MEEPLE:Class;
    public var sprMeeple:Spritemap = new Spritemap(MEEPLE, 51, 51);

    private var individual:Individual;

    public function Meeple(individual:Individual, x:Number = 0, y:Number = 0, mask:Mask = null)
    {
        super(x, y, sprMeeple);
        this.individual = individual;
        configureGraphics();
    }

    public function UpdateColor():void
    {
        sprMeeple.color = individual.GetColor();// individual.GetColor();
    }

    override public function update():void
    {
        super.update();
    }

    private function configureGraphics():void
    {
        type = "solid";
        graphic = sprMeeple;

        sprMeeple.add("stand", [0], 20, true);
        sprMeeple.add("wiggle", [0, 1, 2, 3], 20, true);
        sprMeeple.centerOrigin();

        setHitboxTo(graphic);
    }
}
}
