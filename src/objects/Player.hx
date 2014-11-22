package objects;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.Mask;
import com.haxepunk.math.Vector;

import common.GameObject;

import com.haxepunk.HXP;
import com.haxepunk.utils.Input;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Player extends GameObject
{
	private var _image : Image;
	
	public function new() 
	{
		_image = Image.createRect(32, 48);
		_image.centerOrigin();
		
		super(HXP.width * 0.5, HXP.height * 0.5, _image);
	}
	
	override public function update():Void 
	{
		handleInput();
		
		super.update();
	}
	
	private function handleInput()
	{
		
	}
}