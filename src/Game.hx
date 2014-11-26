import com.haxepunk.Engine;
import com.haxepunk.HXP;

import scenes.Level;

import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

/**
 * Game's entry point
 */
class Game extends Engine
{
	public static function main() 
	{ 
		new Game(); 
	}

	override public function init()
	{
#if debug
		HXP.console.enable();
#end		
		HXP.defaultFont = "font/nokiafc22.ttf";
		
		Audio.initialize();
		Save .initialize("jam-entry");
		
		defineInputs();
		
		HXP.scene = new Level();
	}
	
	private function defineInputs()
	{
		Input.define("jump",  [Key.W]);
		Input.define("duck",  [Key.S]);
		Input.define("left",  [Key.A]);
		Input.define("right", [Key.D]);
		
		Input.define("left_hit",   [Key.LEFT]);
		Input.define("right_hit",  [Key.RIGHT]);
		Input.define("up_hit",     [Key.UP]);
		Input.define("down_hit",   [Key.DOWN]);
	}
}