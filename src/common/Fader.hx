package common;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.tweens.misc.VarTween;
import com.haxepunk.tweens.TweenEvent;
import com.haxepunk.HXP;
import com.haxepunk.utils.Ease;
/**
 * ...
 * @author Romko Pidstryhach

 */
class Fader extends Entity
{
	private var _fader  : VarTween;
	private var _screen : Image;
	
	public function new(color : UInt = 0x000000) 
	{
		_screen = Image.createRect(HXP.width, HXP.height, color, 0.0);
		_fader = new VarTween();
		
		_screen.scrollX = 0.0;
		_screen.scrollY = 0.0;
		
		addTween(_fader);
		
		super(0, 0, _screen);
		
		layer = G.LAYER_FADE;
	}
	
	public function fade(fromAlpha : Float, toAlpha : Float, time : Float, callback : Dynamic -> Void = null)
	{
		_screen.alpha = fromAlpha;
		
		if (callback != null) 
		{
			_fader.addEventListener(TweenEvent.FINISH, callback);
		}
		
		_fader.tween(_screen, "alpha", toAlpha, time, Ease.quadOut);
	}
}