package objects;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;
import com.haxepunk.tweens.misc.ColorTween;
import com.haxepunk.HXP;
import common.GameObject;
import openfl.geom.Point;

import com.haxepunk.Tween.TweenType;

/**
 * ...
 * @author Romko Pidstryhach

 */
class HitZone extends GameObject
{	
	private var _debugImage : Image;
	private var _isActing   : Bool;
	private var _vector     : Point;
	
	private var _debugTween : ColorTween;
	
	public function new() 
	{
		_debugImage = Image.createRect(48, 16, 0x66FFA4);
		_debugImage.alpha = 0.4;
		_debugImage.centerOrigin();
		
		_vector = new Point();
		
		_isActing = false;
		
		super(0, 0, _debugImage);
		//super(0, 0);
		
		setHitbox(48, 16, 24, 8);
		
		_debugTween = new ColorTween(null, TweenType.Persist);
		_debugTween.color = 0x66FFA4;
		addTween(_debugTween);
	}
	
	public function hit(angle:Float, force:Float)
	{
		_debugTween.tween(0.2, 0xFF0404, 0x66FFA4);
		
		var enemy : Dummy = cast(collide("enemy", x, y), Dummy);
		
		if (enemy != null) 
		{
			HXP.angleXY(_vector, angle, force);
			
			enemy.speed.x += _vector.x;
			enemy.speed.y += _vector.y;
			
			level.shake(8.0);
		}
	}	
	
	override public function update():Void 
	{
		_debugImage.color = _debugTween.color;
		
		super.update();
	}
}