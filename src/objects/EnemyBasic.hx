package objects;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;

import common.GameObject;

import com.haxepunk.HXP;

/**
 * Basic enemy type moves to target and attacks
 * @author Andrew Ivasiv
 */
class EnemyBasic extends Enemy
{
	public function new(target : GameObject)
	{
		super(target);
		_maxSpeed = 200;
		
		_attackRange = 10;
		_attackDelay = 1;
		_attackCooldown = 0;
		
		_minDamage = 1;
		_maxDamage = 3;
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
			var damage = HXP.rand(_maxDamage - _minDamage + 1) + _minDamage;
			_attackCooldown = _attackDelay;
		}
	}
}