package objects;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;

import common.GameObject;

import com.haxepunk.HXP;

/**
 * Enemy base class
 * @author Andrew Ivasiv
 */
class Enemy extends GameObject
{
	private var _target : GameObject;
	
	private var _image : Image;
	
	private var _speed : Float;
	private var _maxSpeed : Float;
	
	private var _health : Int;
	private var _isDead : Bool;
	
	private var _minDamage : Int;
	private var _maxDamage : Int;
	private var _attackRange : Float;
	private var _attackDelay : Float;
	private var _attackCooldown : Float;
	
	public function new(target : GameObject)
	{
		_image = Image.createRect(32, 48, 0xFF0000);
		_image.centerOrigin();
		
		_target = target;
		
		_speed = 0;
		_isDead = false;
		
		super(HXP.width * 0.5, HXP.height * 0.5, _image);
	}
	
	public function spawn(x : Float, y : Float) : Entity
	{
		this.x = x;
		this.y = y;
		
		return this;
	}
	
	override public function update():Void
	{
		if (!_isDead)
		{
			behave();
		}
		else
		{
			collidable = false;
		}
		
		super.update();
	}
	
	private function behave()
	{
		
	}
	
	private function attack()
	{
		
	}
	
	public function takeDamage(damage : Int)
	{
		
	}
	
	public function die()
	{
		_isDead = true;
	}
}