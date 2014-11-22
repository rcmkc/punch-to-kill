package common;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import openfl.geom.Rectangle;
import com.haxepunk.HXP;

/**
 * ...
 * @author Romko Pidstryhach

 */
class MuteButton extends Button
{
	private var MUTED   : Image = new Image("graphics/mute_button.png", new Rectangle(23, 0, 23, 23)); 
	private var UNMUTED : Image = new Image("graphics/mute_button.png", new Rectangle(0, 0, 23, 23)); 
	
	@:isVar private var muted(get, set) : Bool;
	
	public function new() 
	{
		MUTED.scrollX   = 0.0;
		MUTED.scrollY   = 0.0;
		
		UNMUTED.scrollX = 0.0;
		UNMUTED.scrollY = 0.0;
		
		super(HXP.width - 28, HXP.height - 28, UNMUTED);
		
		setHitbox(23, 23);
		
		cast(graphic, Image).alpha = 0.8;
		
		muted = false;
	}

	override public function act():Void 
	{
		super.act();
		
		muted = !muted;
		graphic = muted ? MUTED : UNMUTED;
		
		Audio.mute(muted);
	}
	
	override public function mouseIn():Void 
	{
		super.mouseIn();
		cast(graphic, Image).alpha = 1.0;
	}
	
	override public function mouseOut():Void 
	{
		super.mouseOut();
		cast(graphic, Image).alpha = 0.8;
	}
	
	public function set_muted(value : Bool) : Bool
	{
		return muted = value;
	}
	
	public function get_muted() : Bool
	{
		return muted;
	}
}