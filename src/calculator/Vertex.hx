package calculator;

import at.dotpoint.math.vector.Vector2;

/**
 * ...
 * @author RK
 */
class Vertex extends Vector2
{

	/**
	 * 
	 * @param	x
	 * @param	y
	 */
	public var neighbors:List<Vertex>;	
	
	// ************************************************************************ //
	// Constructor
	// ************************************************************************ //	
	
	public function new( x:Float = 0, y:Float = 0 ) 
	{
		super( x, y );				
		this.neighbors = new List<Vertex>();
	}
	
	// ************************************************************************ //
	// Methods
	// ************************************************************************ //	
	
	#if debug
	public var index:Int;
	
	/**
	 * 
	 * @return
	 */
	override public function toString():String
	{
		return "[" + this.index + "]";
	}
	#end
}