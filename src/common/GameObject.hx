package common ;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.HXP;

import haxe.io.Error;
import scenes.Level;

/**
 * Basic game object. Should be added to Level
 * @author Romko Pidstryhach

 */
class GameObject extends Entity
{
	private var level(get, null) : Level;
	
	public var state : State;
	
	/**
	 * Constructor
	 * @param	x X position
	 * @param	y Y position
	 * @param	graphic Graphic 
	 * @param	mask Collision mask
	 */
	public function new(x:Float = .0, y:Float = .0, graphic:Graphic = null, mask:Mask = null)
	{
		state = new State();
		super(x, y, graphic, mask);
	}
	
	override public function added() : Void 
	{
		try 
		{
			level = cast(world, Level);
		}
		catch (msg:String)
		{
			trace("Error: " + msg);
		}
		
		super.added();
	}
	
	override public function removed() : Void 
	{
		level = null;
		super.removed();
	}
	
	/**
	 * Level accessor
	 * @return current Level instance
	 */
	public function get_level() : Level
	{
		return level;
	}
}