package ;
import com.haxepunk.Sfx;

/**
 * Sound manager
 * @author Romko Pidstryhach

 */
class Audio
{
	private static var _sound  : Sfx;
	
	private static var _volume : Float;
	private static var _sounds : Array <Sfx>;
	
	public static function initialize() : Void
	{
		//_sound = new Sfx("audio/sound.mp3");
		
		_volume = 1.0;
		//_sounds = [_sound];
	}
	
	public static function mute(value : Bool)
	{
		_volume = value ? 0.0 : 1.0;
		//updateSounds();
	}
	
	private static function updateSounds()
	{
		for (i in _sounds) 
		{
			i.volume = _volume;
		}
	}
}