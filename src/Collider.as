package
{
import net.flashpunk.Entity;

public class Collider extends Entity
{
    public function Collider(width:int, height:int)
    {
        this.width = width;
        this.height = height;

        setHitbox(width, height);
    }
}
}
