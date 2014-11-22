package objects;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;

import common.GameObject;

import com.haxepunk.HXP;
import com.haxepunk.utils.Input;

/**
 * ...
 * @author Romko Pidstryhach
 */

enum PlayerState
{
	OnGround;
	InAir;
	IsStomping;
}

class Player extends GameObject
{
	private var _image : Image;
	private var _speed : Vector;
	
	public function new() 
	{
		_image = Image.createRect(32, 48);
		_image.centerOrigin();
		
		_speed = new Vector();
		
		state.set(OnGround);
		
		super(HXP.width * 0.5, HXP.height * 0.5, _image);
		
		setHitbox(32, 48, 16, 24);
	}
	
	override public function update():Void 
	{
		handleMovement();
		
		super.update();
	}
	
	private function handleMovement()
	{
		if (Input.check("right")) 
		{
			if (_speed.x < G.MaxSpeed)
			{
				_speed.x += G.Acceleration;
			}
		}
		else if (Input.check("left")) 
		{
			if (_speed.x > - G.MaxSpeed)
			{
				_speed.x -= G.Acceleration;
			}
		}
		else
		{
			_speed.x *= G.Friction;
		}
		
		if (Input.pressed("jump") && state.is(OnGround)) 
		{
			state.set(InAir);
			_speed.y -= G.JumpSpeed;
		}
		
		if (Input.pressed("duck")) 
		{
			if (state.is(InAir)) 
			{
				state.set(IsStomping);
				_speed.y += G.StompSpeed;
			}
			else if (state.is(OnGround))
			{
				//duck behaviour
			}
		}
		
		_speed.y += G.Gravity;
		
		moveBy(_speed.x * HXP.elapsed, _speed.y * HXP.elapsed, "solid", true);	
	}
	
	override public function moveCollideY(e:Entity):Bool 
	{	
		if (state.is(IsStomping)) 
		{
			level.shake();
		}
		
		_speed.y = 0.0;
		state.set(OnGround);
		
		return super.moveCollideY(e);
	}
}