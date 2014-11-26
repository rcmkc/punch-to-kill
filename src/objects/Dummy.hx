package objects;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import common.GameObject;
import com.haxepunk.math.Vector;
import com.haxepunk.HXP;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Dummy extends GameObject
{
	private var _image  : Image;
	private var _target : Entity;
	
	private var _onGround:Bool;
	
	public var speed : Vector;
		
	public function new(target:Entity) 
	{
		_target = target;
		
		_image = Image.createRect(48, 64, 0xFF6666);
		_image.originX = _image.width * 0.5;
		
		speed = new Vector();
		
		super(200, 100, _image);
		
		setHitbox(48, 64, 24, 0);
		type = "enemy";
	}
	
	override public function update():Void 
	{
		
		var ground : Ground = cast(collide("solid", x, y + 1), Ground);
		
		if (ground == null) 
		{
			_onGround = false;
		}
		else
		{
			_onGround = true;
			
			if (x < _target.x) 
			{
				if (speed.x < G.MaxSpeed * 0.5)
				{
					speed.x += G.Acceleration;
				}
			}
			else
			{
				if (speed.x > - G.MaxSpeed * 0.5)
				{
					speed.x -= G.Acceleration;
				}
			}
			
			speed.x *= 0.9;
		}
		
		speed.y += G.Gravity;
		
		HXP.clampInRect(this, 0, 0, HXP.width, HXP.height, 24);
		
		moveBy(speed.x * HXP.elapsed, speed.y * HXP.elapsed, "solid", true);
		
		super.update();
	}
	
	override public function moveCollideY(e:Entity):Bool 
	{	
		speed.y = 0.0;
		//_onGround = true;
		return super.moveCollideY(e);
	}
}