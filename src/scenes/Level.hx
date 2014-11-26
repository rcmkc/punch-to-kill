package scenes;

import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import common.CameraEffects;
import common.GameScene;
import objects.Dummy;
import objects.Ground;
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
		add(new Ground());
		
		add(new Dummy(_player));
		
		super.begin();
	}
	
	override public function update() 
	{
		_camera.update();
		super.update();
	}
	
	public function shake(amount:Float = 25.0)
	{
		_camera.startShake(amount);
	}
}