package objects;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;
import com.haxepunk.HXP;

import common.GameObject;

/**
 * Game object for throwable stuff
 * @author Andrew Ivasiv
 */
class ThrowObject extends GameObject
{
	private var _image : Image;
	private var _target : Vector;
	private var _velocity : Float;
	private var _throwAngle : Float;
	
	public function new(target : Vector, velocity : Float, angle : Float = 0)
	{
		_image = Image.createCircle(16, 0x00FF00);
		_image.centerOrigin();
		
		_throwAngle = angle;
		_velocity = velocity;
		_target = target;
		
		super(HXP.width * 0.5, HXP.height * 0.5, _image);
	}
	
	public override function update()
	{
		if (x == _target.x) scene.remove(this);
		
		moveTowards(_target.x, _target.y, _velocity * HXP.elapsed);
		
		// check for collisions
	}
}