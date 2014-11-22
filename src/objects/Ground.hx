package objects;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;

import com.haxepunk.HXP;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Ground extends Entity
{
	public function new() 
	{
		var image:Image = new Image("graphics/ground.png");
		image.scale = G.GameScale;
		image.smooth = false;
		
		super(0, HXP.height - G.GroundHeight, image);
		
		setHitbox(Std.int(image.scaledWidth), Std.int(image.scaledHeight));
		type = "solid";
	}
}