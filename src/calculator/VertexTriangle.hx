package calculator;
import at.dotpoint.math.vector.Vector2;
import at.dotpoint.math.vector.Vector3;

/**
 * ...
 * @author RK
 */
class VertexTriangle
{

	/**
	 * vertices used for its coordinates
	 */
	public var p1:Vertex;
	public var p2:Vertex;
	public var p3:Vertex;
	
	// ------------- //
	
	/**
	 * use this instance to "pool" a temporary instance of this object.
	 * since VertexTriangle can be reused and writing a pooling-mechanism would be overkill
	 */
	public static var instance:VertexTriangle = new VertexTriangle();
	
	// ************************************************************************ //
	// Constructor
	// ************************************************************************ //	
	
	public function new() 
	{
		
	}
	
	// ************************************************************************ //
	// Methods
	// ************************************************************************ //	
	
	/**
	 * using the cross product of 3 3D vectors to determine the rotation direction. similar to backface culling in 3D
	 * @return	true in case all vertices are ordered clockwise, false if counter-clockwise
	 * 
	 * TODO: could pool necessary Vector3 instances
	 */
	public function isClockwise( includeZero:Bool = false ):Bool
	{
		if( this.p1 == null || this.p2 == null || this.p3 == null )
			throw "must set 3 vertex coordinates";
		
		var v1:Vector3 = new Vector3( this.p1.coordinate.x, this.p1.coordinate.y, 0 );	
		var v2:Vector3 = new Vector3( this.p2.coordinate.x, this.p2.coordinate.y, 0 );
		var v3:Vector3 = new Vector3( this.p3.coordinate.x, this.p3.coordinate.y, 0 );			
		
		var sub1:Vector3 = Vector3.subtract( v2, v1, new Vector3() );
		var sub2:Vector3 = Vector3.subtract( v3, v1, new Vector3() );
		
		var cross:Vector3 = Vector3.cross( sub1, sub2 );
		
		return includeZero ? cross.z  >= 0 : cross.z > 0; 
	}
}