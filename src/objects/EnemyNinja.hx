package objects;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;

import common.GameObject;

import com.haxepunk.HXP;

/**
 * Throws shurikens in straight line or jumps and throws 3 shurikens downwards
 * @author Andrew Ivasiv
 */
class EnemyNinja extends Enemy
{
	private var _throwCooldown : Float;
	private var _throwDelay : Float;
	
	private var _jumpHeight : Float;
	private var _specialJumpPos : Float;
	private var _specialChance : Float;
	private var _isSpecialAttack : Bool;
	
	public function new(target : GameObject)
	{
		super(target);
		_maxSpeed = 300;
		
		_attackRange = 150;
		_attackDelay = 1;
		_attackCooldown = 0;
		
		_jumpHeight = 100;
		_specialChance = 0.5;
		_isSpecialAttack = false;
		
		_minDamage = 1;
		_maxDamage = 3;
	}
	
	public override function behave()
	{
		_attackCooldown -= HXP.elapsed;
		
		_speed += 10 * HXP.sign(_target.x - x);
		_speed = HXP.clamp(_speed, -_maxSpeed, _maxSpeed);
		
		if (Math.abs(x - _target.x) < _attackRange && !_isSpecialAttack)
		{
			_speed = 0;
			attack();
		}
		
		if (_isSpecialAttack)
		{
			_speed = 400;
			
			if (y > _specialJumpPos)
			{
				moveTowards(x, _specialJumpPos, _speed * HXP.elapsed);
			}
			
			if (y == _specialJumpPos)
			{
				specialAttack();

				// this is a temp hack, later fall down until collision with ground
				moveBy(0, _jumpHeight);
			}
		}
		else
		{
			moveBy(_speed * HXP.elapsed, 0);
		}
	}
	
	public override function attack()
	{
		if (_attackCooldown <= 0)
		{
			if (!_isSpecialAttack && HXP.random < _specialChance)
			{
				_isSpecialAttack = true;
				_specialJumpPos = y - _jumpHeight;
			}
			else
			{
				var throwable : ThrowObject;
				throwable = new ThrowObject(new Vector(_target.x, _target.y), 300);
				throwable.x = x;
				throwable.y = y;
				scene.add(throwable);
			}
			_attackCooldown = _attackDelay;
		}
	}
	
	private function specialAttack()
	{
		var throwables = new Array<ThrowObject>();
		
		for (i in -1 ... 2)
		{
			HXP.log(""+i);
			throwables[i + 1] = new ThrowObject(new Vector(_target.x + 100 * i, _target.y), 300);
			throwables[i + 1].x = x;
			throwables[i + 1].y = y;
			scene.add(throwables[i + 1]);
		}
		
		_isSpecialAttack = false;
	}
}