package objects;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;

import common.GameObject;

import com.haxepunk.HXP;

/**
 * Thrower enemy that throws stuff
 * @author Andrew Ivasiv
 */
class EnemyThrower extends Enemy
{
	public function new(target : GameObject)
	{
		super(target);
		_maxSpeed = 150;
		
		_attackRange = 140;
		_attackDelay = 2;
		_attackCooldown = 0;
	}
	
	public override function behave()
	{
		_attackCooldown -= HXP.elapsed;
		
		_speed += 10 * HXP.sign(_target.x - x);
		_speed = HXP.clamp(_speed, -_maxSpeed, _maxSpeed);
		
		if (Math.abs(x - _target.x) < _attackRange)
		{
			_speed = 0;
			attack();
		}
		
		moveBy(_speed * HXP.elapsed, 0);
	}
	
	public override function attack()
	{
		if (_attackCooldown <= 0)
		{
			var throwable : ThrowObject;
			throwable = new ThrowObject(new Vector(_target.x, _target.y), 300, false);
			throwable.x = x;
			throwable.y = y;
			scene.add(throwable);
			_attackCooldown = _attackDelay;
		}
	}
}