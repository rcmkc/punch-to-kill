package ;

import flash.filters.GlowFilter;
import openfl.filters.BlurFilter;

/**
 * Global variables
 * @author Romko Pidstryhach

 */
class G
{
	public inline static var Friction       : Float = 0.8;
	public inline static var MaxSpeed       : Float = 300.0;
	public inline static var Acceleration   : Float = 50.0;
	public inline static var JumpSpeed      : Float = 1000.0;
	public inline static var StompSpeed     : Float = 1500.0;
	public inline static var Gravity        : Float = 40.0;
	
	public inline static var GroundHeight   : Int = 150;
		
	public inline static var GameScale      : Int = 4;
	
	public inline static var LAYER_TOP      : Int = -1;
	public inline static var LAYER_MAIN     : Int = 0;
	public inline static var LAYER_FADE     : Int = 1;
	public inline static var LAYER_GUI      : Int = 2;
	public inline static var LAYER_OBJECTS  : Int = 3;
	public inline static var LAYER_BACKDROP : Int = 4;
}