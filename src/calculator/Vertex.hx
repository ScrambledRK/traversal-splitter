package calculator;

import at.dotpoint.math.vector.IVector2;
import at.dotpoint.math.vector.Vector2;

/**
 * ...
 * @author RK
 */
class Vertex implements IVector2
{

	/**
	 * x,y coordinates of this vertex
	 */
	public var coordinate:Vector2;
	
	/**
	 * X------o------X
	 *        |
	 *        |
	 *        X
	 * 
	 * up to 3 neighbors vertices: left, right and when a split-vertex a normal vertex
	 * linked list to save memory and random access performance is not an issue
	 */
	public var neighbors:List<Vertex>;	
	
	// ----------------- //
	
	/**
	 * getter / setter for coordinate
	 */
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	// ************************************************************************ //
	// Constructor
	// ************************************************************************ //	
	
	public function new( coordinate:Vector2 ) 
	{
		if( coordinate == null )
			coordinate = new Vector2();
		
		this.coordinate = coordinate;				
		this.neighbors = new List<Vertex>();
	}
	
	// ************************************************************************ //
	// getter / setter
	// ************************************************************************ //	
	
	/**
	 * this.coordinate.x
	 */
	private function get_x():Float { return this.coordinate.x; }
	
	private function set_x( value:Float ):Float 
	{
		return this.coordinate.x = value;
	}
	
	/**
	 * this.coordinate.y
	 */
	private function get_y():Float { return this.coordinate.y; }
	
	private function set_y( value:Float ):Float 
	{
		return this.coordinate.y = value;
	}
	
	// ************************************************************************ //
	// Debug / toString
	// ************************************************************************ //	
	
	#if debug
	
	public var index:Int;
	
	/**
	 * 
	 * @return
	 */
	public function toString():String
	{
		return "[" + this.index + "]";
	}
	
	#end
}