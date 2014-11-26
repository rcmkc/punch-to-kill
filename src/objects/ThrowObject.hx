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
	
	private var _isLineTrajectory : Bool;
	private var _direction : Int;
	private var _slope : Float;
	private var _vertex : Float;
	
	public function new(target : Vector, velocity : Float, isLineTrajectory : Bool = true)
	{
		_image = Image.createCircle(16, 0x00FF00);
		_image.centerOrigin();
		
		_target = target;
		_velocity = velocity;
		_isLineTrajectory = isLineTrajectory;
		
		super(HXP.width * 0.5, HXP.height * 0.5, _image);
	}
	
	public override function added()
	{
		_direction = HXP.sign(_target.x - x);
		
		if (_isLineTrajectory)
		{
			_slope = (_target.y - y) / (_target.x - x);
		}
		else
		{
			_vertex = (_target.x + x) / 2;
			_vertex = HXP.clamp(_vertex, 0, x + 65);
		}
	}
	
	public override function update()
	{
		var newX : Float;
		var newY : Float;
		
		// note that 10K and 1K for x calculation are magical numbers they just work ok
		if (_isLineTrajectory)
		{
			// line
			newX = x + 10000 * _direction;
			newY = y + _slope * newX;
		}
		else
		{
			//parabolic
			newX = x + 1500 * _direction;
			newY = y + (x < _vertex ? ( -1 * Math.pow((x - _vertex), 2)) : -( -1 * Math.pow((x - _vertex), 2))) * _direction;
		}
		
		moveTowards(newX, newY, _velocity * HXP.elapsed);
		
		// check for collisions
	}
}