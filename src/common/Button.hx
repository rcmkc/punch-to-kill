package common;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;

import haxe.EnumFlags;

/**
 * Basic button
 * @author Romko Pidstryhach
 */

enum ButtonState
{
	Locked;
	Hovered;
	Relative;
}

class Button extends Entity
{
	private var _state : EnumFlags<ButtonState>;
	
	public function new(x : Float = 0, y : Float = 0, graphic : Graphic = null) 
	{
		_state = new EnumFlags<ButtonState>();
		
		super(x, y, graphic, null);	
		
		layer = G.LAYER_GUI;
	}
	
	public function setLockedState(value : Bool) : Void
	{
		value ? _state.set(Locked) : _state.unset(Locked);
	}
	
	public function setRelativeState(value : Bool) : Void
	{
		value ? _state.set(Relative) : _state.unset(Relative);
	}
	
	override public function update() : Void 
	{
		super.update();
		
		if (_state.has(Locked)) 
		{
			isDeactivated();
			return;
		}
		
		var mouseX : Int = _state.has(Relative) ? HXP.world.mouseX : Input.mouseX;
		var mouseY : Int = _state.has(Relative) ? HXP.world.mouseY : Input.mouseY;
		
		if (collidePoint(x, y, mouseX, mouseY))
		{
			if (!_state.has(Hovered))
			{
				mouseIn();
				_state.set(Hovered);
			}
			
			if (Input.mousePressed)	 {  click(); }
			if (Input.mouseReleased) {    act(); }
		}
		else
		{
			if (_state.has(Hovered))
			{
				mouseOut();
				_state.unset(Hovered);
			}
		}
	}
		
	/**
	 * Override this. Called when button is clicked.
	 */
	public function click() : Void {}
	
	/**
	 * Override this. Called when button is released.
	 */
	public function act() : Void {}
	
	/**
	 * Override this. Called when cursor moved inside the button.
	 */
	public function mouseIn() : Void {}
	
	/**
	 * Override this. Called when cursor moved outside the button.
	 */
	public function mouseOut() : Void {}
	
	/**
	 * Override this. Called when button is locked.
	 */
	public function isDeactivated() : Void {}
}