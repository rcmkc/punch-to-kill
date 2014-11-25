package objects;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;

import common.GameObject;

import com.haxepunk.HXP;

/**
 * Charger gets in range and charges
 * @author Andrew Ivasiv
 */
class EnemyCharger extends Enemy
{
	private var _attackChargeTime : Float;
	private var _curChargeTime : Float;
	private var _isCharging : Bool;
	private var _chargeLocation : Float;
	
	public function new(target : GameObject)
	{
		super(target);
		_maxSpeed = 200;
		
		_attackRange = 100;

		_attackChargeTime = 2;
		_curChargeTime = 0;
		_isCharging = false;
		
		_attackDelay = 5;
		_attackCooldown = 0;
		
		_minDamage = 1;
		_maxDamage = 3;
	}
	
	public override function behave()
	{
		_attackCooldown -= HXP.elapsed;
		
		if (Math.abs(x - _target.x) > _attackRange && !_isCharging)
		{
			_speed += 10 * HXP.sign(_target.x - x);
			_speed = HXP.clamp(_speed, -_maxSpeed, _maxSpeed);
			
			moveBy(_speed * HXP.elapsed, 0);
		}
		else
		{
			attack();
		}
	}
	
	public override function attack()
	{
		if (_attackCooldown <= 0)
		{
			if (!_isCharging)
			{
				_chargeLocation = _target.x + 60 * HXP.sign(_target.x - x);
			}
			
			_attackCooldown = _attackDelay;
			_isCharging = true;
		}
		
		if (_isCharging)
		{
			_curChargeTime += HXP.elapsed;
			if (_curChargeTime >= _attackChargeTime)
			{
				moveTowards(_chargeLocation, y, 770 * HXP.elapsed);
				
				if (x == _chargeLocation)
				{
					_curChargeTime = 0;
					_isCharging = false;
				}
			}
		}
	}
}