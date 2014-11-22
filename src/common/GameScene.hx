package common;

import com.haxepunk.Scene;

/**
 * Basic game scene with simple fader
 * @author Romko Pidstryhach
 * 
 */
class GameScene extends Scene
{
	private var _fader : Fader;
	
	public function new(sceneColor:UInt = 0x000000)
	{
		_fader = new Fader(sceneColor);
		super();
	}
	
	override public function begin() 
	{
		add(_fader);
		super.begin();
	}
	
	override public function end() 
	{
		remove(_fader);
		_fader = null;
		super.end();
	}
	
	public function fadeIn(time:Float = 1.0, ?callback:Dynamic -> Void = null)
	{
		_fader.fade(1.0, 0.0, time, callback);
	}
	
	public function fadeOut(time:Float = 1.0, ?callback:Dynamic -> Void = null)
	{
		_fader.fade(0.0, 1.0, time, callback);
	}
}