import com.haxepunk.utils.Data;

/**
 * Saving manager
 * @author Romko Pidstryhach
 */
class Save
{
	private static var _name:String;
	
	public static function initialize(id : String) : Void 
	{
		Data.id = id;
		Data.load();
		
		_name = id;
	}
	
	public static function saveData() : Void
	{
		Data.save(_name + "_save");
	}
}