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
		Input.define("up",     [Key.UP,    Key.W]);
		Input.define("down",   [Key.DOWN,  Key.S]);
		Input.define("left",   [Key.LEFT,  Key.A]);
		Input.define("right",  [Key.RIGHT, Key.D]);
		Input.define("attack", [Key.SPACE, Key.X]);
	}
}