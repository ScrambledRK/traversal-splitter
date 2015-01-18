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
	 * unique ID of the vertex - calculated by counting through the whole 
	 * polygon graph clockwise/counterclockwise. new vertices are assigned
	 * a value between its left and right neighbor. e.g.: 8 --- 8.5 --- 9
	 */
	public var index:Float;
	
	/**
	 * X------o------X
	 *        |
	 *        |
	 *        X
	 * 
	 * up to 3 neighbors vertices: left, right and when a split-vertex a normal vertex
	 * linked list to save memory and random access performance is not an issue
	 */
	public var neighbors:Array<Vertex>;	
	
	// ----------------- //
	// IVector2
	
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
		this.neighbors = new Array<Vertex>();
	}
	
	// ************************************************************************ //
	// IVector2
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
	
	/**
	 * this.coordinate.normalize()
	 */
	public function normalize():Void
	{
		this.coordinate.normalize();
	}
	
	/**
	 * 
	 * @return
	 */
	public function length():Float
	{
		return this.coordinate.length();
	}
	
	// ************************************************************************ //
	// Neighbors
	// ************************************************************************ //	
	
	/**
	 * 
	 * @param	vertex
	 */
	public function insertNeighbor( vertex:Vertex ):Void
	{
		this.neighbors.push( vertex );
		this.neighbors.sort( this.sortNeighbors );
	}
	
	/**
	 * 
	 * @param	vertex
	 */
	public function removeNeighbor( vertex:Vertex ):Bool
	{
		return this.neighbors.remove( vertex );
	}
	
	/**
	 * 
	 * @param	a
	 * @param	b
	 * @return
	 */
	private function sortNeighbors( a:Vertex, b:Vertex ):Int
	{
		return Math.round( a.index - b.index );
	}
	
	// ************************************************************************ //
	// Debug / toString
	// ************************************************************************ //	
	
	/**
	 * 
	 * @return
	 */
	public function toString():String
	{
		return "[" + this.index + "]";
	}
}