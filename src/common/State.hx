package common;

/**
 * Integer state typed interface. Holds up to 32 states
 * @author Romko Pidstryhach
 */
abstract State(Int)
{
	public inline function new(state = 0)
	{
		this = state; 
	}
	
	/**
	 * Sets the bitflag for the corresponding enum instance
	 * @param	value enum instance
	 */
	public inline function set(value:EnumValue):Void
	{
		this = 1 << Type.enumIndex(value);
	}
	
	/**
	 * Checks the state of the bitflag
	 * @param	value Corresponding enum instance
	 * @return  bitflag state
	 */
	public inline function is(value:EnumValue):Bool
	{
		return this & (1 << Type.enumIndex(value)) != 0;
	}
}