package scenes;

import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import common.CameraEffects;
import common.GameScene;
import objects.Player;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Level extends GameScene
{	
	private var _camera : CameraEffects;
	private var _player : Player;
	
	override public function begin() 
	{
		fadeIn(0.5);
		
		_camera = new CameraEffects();
		
		add(_player = new Player());
		
		super.begin();
	}
	
	override public function update() 
	{
		_camera.update();
		super.update();
	}
}