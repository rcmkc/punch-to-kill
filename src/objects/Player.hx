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
	
	private var _leftHand  : HitZone;
	private var _rightHand : HitZone;
	
	private var _leftLeg  : HitZone;
	private var _rightLeg : HitZone;
	
	public function new() 
	{
		_image = new Image("graphics/player.png");
		_image.scale = G.GameScale;
		_image.smooth = false;
		_image.originX = _image.width * 0.5;
		
		_speed = new Vector();
		
		state.set(OnGround);
		
		super(HXP.width * 0.5, HXP.height * 0.3, _image);
		
		var playerWidth :Int = Std.int(_image.scaledWidth);
		var playerHeight:Int = Std.int(_image.scaledHeight);
		
		setHitbox(playerWidth, playerHeight, Std.int(playerWidth * 0.5), 0);
	}
	
	override public function added():Void 
	{
		HXP.world.add(_leftHand  = new HitZone());
		HXP.world.add(_rightHand = new HitZone());
		HXP.world.add(_leftLeg   = new HitZone());
		HXP.world.add(_rightLeg  = new HitZone());
		
		super.added();
	}
	
	override public function update():Void 
	{
		handleMovement();
		handlePunches();
		
		positionHitZones();
		
		super.update();
	}
	
	private function positionHitZones()
	{
		_leftHand.x = left;
		_leftHand.y = y + 50;
		
		_rightHand.x = right;
		_rightHand.y = y + 50;
		
		_leftLeg.x = left;
		_leftLeg.y = y + 80;
		
		_rightLeg.x = right;
		_rightLeg.y = y + 80;
	}
	
	private function handlePunches()
	{
		if (state.is(OnGround)) 
		{
			var leftHit  : Bool = Input.pressed("left_hit");
			var rightHit : Bool = Input.pressed("right_hit");
			
			if (Input.check("up_hit")) 
			{
				if (leftHit) 
				{
					_leftHand.hit(110, 1400);
				}
				
				if (rightHit) 
				{
					_rightHand.hit(70, 1400);
				}
			}
			else
			{
				if (leftHit) 
				{
					_leftHand.hit(180, 700);
				}
				
				if (rightHit) 
				{
					_rightHand.hit(0, 700);
				}
			}
		}
		else if (state.is(InAir))
		{
			if (Input.pressed("left_hit")) 
			{
				_leftLeg.hit(180, 2000);
			}
			
			if (Input.pressed("right_hit")) 
			{
				_rightLeg.hit(0, 2000);
			}
		}
	}
	
	private function handleMovement()
	{
		if (Input.check("right")) 
		{
			_image.flipped = false;
			
			if (_speed.x < G.MaxSpeed)
			{
				_speed.x += G.Acceleration;
			}
		}
		else if (Input.check("left")) 
		{
			_image.flipped = true;
			
			if (_speed.x > - G.MaxSpeed)
			{
				_speed.x -= G.Acceleration;
			}
		}
		else
		{
			if (state.is(OnGround)) 
			{
				_speed.x *= G.Friction;
			}	
		}
		
		if (Input.pressed("jump") && state.is(OnGround)) 
		{
			state.set(InAir);
			_speed.y -= G.JumpSpeed;
		}
		
		if (Input.pressed("down_hit")) 
		{
			if (state.is(InAir)) 
			{
				state.set(IsStomping);
				_speed.y += G.StompSpeed;
			}
		}
		
		_speed.y += G.Gravity;
		
		// clamps player within viewport bounds
		HXP.clampInRect(this, 0, 0, HXP.width, HXP.height, 24);
		
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