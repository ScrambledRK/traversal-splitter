package calculator;

import at.dotpoint.math.MathUtil;
import at.dotpoint.math.vector.Vector2;

/**
 * containing all lines of the given orthogonal polygon as well as generated lines due to split-points
 * manages 2 seperate sorted lists (vertical, horizontal) for (very) efficient intersection tests
 * 
 * @author RK
 */
class EdgeContainer
{

	/**
	 * y-axis sorted list of edges (pair of vertices) along the x-axis
	 */
	public var horizontal:Array<Vertex>;
	
	/**
	 * x-axis sorted list of edges (pair of vertices) along the y-axis
	 */
	public var vertical:Array<Vertex>;
	
	// ************************************************************************ //
	// Constructor
	// ************************************************************************ //	
	
	public function new() 
	{
		this.vertical 	= new Array<Vertex>();
		this.horizontal = new Array<Vertex>();
	}
	
	// ************************************************************************ //
	// Methods
	// ************************************************************************ //	
	
	/**
	 * inserts a new line between the given vertices. depending on the orientation
	 * it will be internally sorted into the vertical or horizontal list
	 * 
	 * @param	a
	 * @param	b
	 */
	public function insert( a:Vertex, b:Vertex ):Void
	{
		if( this.isVertical( a, b ) )
		{
			var index:Int = this.getIndex( a.x, true );		
			
			this.vertical.insert( index * 2, a );
			this.vertical.insert( index * 2, b );	
		}
		else
		{
			var index:Int = this.getIndex( a.y, false );
			
			this.horizontal.insert( index * 2,  a );
			this.horizontal.insert( index * 2, 	b );
		}			
	}
	
	/**
	 * BUG: might remove wrong Nodes, causing Edges to become diagonal even ... more tests required ...
	 * 
	 * @param	a
	 * @param	b
	 */
	public function remove( a:Vertex, b:Vertex ):Void
	{		
		if( this.isVertical( a, b ) )
		{			
			this.vertical.remove( a );
			this.vertical.remove( b );
		}
		else
		{
			this.horizontal.remove( a );
			this.horizontal.remove( b );
		}			
	}
	
	// ----------------------------------- //
	// ----------------------------------- //
	
	/**
	 * checks if the given ray (line direction) originating from the given vertex (start)
	 * intersects with any given line, if so: insert a new vertex on the intersection point,
	 * adjust the graph (new neighbors), add a new line (between start and intersection) and
	 * return this new intersection-vertex
	 * 
	 * TODO: remove graph manipulation and just return the necessary data (edge + split point)
	 * TODO: hlength/vlength could be calculated for a minimum and "<=" seems wrong
	 * TODO: macro to replace duplicate code (flip x,y coordinates)
	 * 
	 * @param	start		position the ray starts
	 * @param	dir			direction the ray shoots until it hits a perpendicular edge
	 * @return	new vertex created on the line the ray intersects with
	 */
	public function split( start:Vertex, dir:Vector2 ):Vertex
	{
		var isVertical:Bool = Math.abs(dir.x) < Math.abs(dir.y);	
		
		if( isVertical ) 	// vertical ray, check horizontal lines
		{
			var ystep:Int 	= dir.y < 0 ? -1 : 1;						// direction to iterate through the y-sorted list
			
			var hstart:Int 	= this.getIndex( start.y, false ) - 1;		// start index where the iteration should begin		
			var hlength:Int = this.horizontal.length >> 1;				// maximum amount of steps: all lines (since lines are 2 points: length * 0.5)
			
			// ---------------- //			
			// trace( "v check:", hstart, ystep, hlength );
			
			while( (hstart += ystep) >= 0 && hstart <= hlength )		// while still in bounds of the horizontal-list
			{			
				var hindex:Int = hstart * 2;							// get line index to check intersection
				
				var a:Vertex = this.horizontal[hindex + 0];				// line ...
				var b:Vertex = this.horizontal[hindex + 1];
				
				if( a == start || b == start )							// ignore the line the ray originates from (always intersects and is wrong)
					continue;
				
				if( ( start.x >= a.x && start.x <= b.x )				// does the ray intersect with the current one?
				||	( start.x >= b.x && start.x <= a.x ) )
				{
					return this.insertSplit( start, a, b );				// insert new line, adjust graph and return new vertex
				}
			}
		}
		else			// horizontal ray, check vertical lines: same as above but flipped coordinates.
		{
			var xstep:Int 	= dir.x < 0 ? -1 : 1;
			
			var vstart:Int 	= this.getIndex( start.x, true ) - 1;				
			var vlength:Int = this.vertical.length >> 1;
			
			// ---------------- //				
			// trace( "h check:", vstart, xstep, vlength );
			
			while( (vstart += xstep) >= 0 && vstart <= vlength )
			{			
				var vindex:Int = vstart * 2;
				
				var a:Vertex = this.vertical[vindex + 0];
				var b:Vertex = this.vertical[vindex + 1];				
				
				if( a == start || b == start )
					continue;
				
				if( ( start.y >= a.y && start.y <= b.y )
				||	( start.y >= b.y && start.y <= a.y ) )
				{
					return this.insertSplit( start, a, b );
				}				
			}
		}
		
		return null;
	}
	
	/**
	 * - insert a new vertex between the vertices a and b
	 * - add a new line between this new intersection vertex and the start vertex
	 * - adjust graph with new neighbors
	 * - return new intersection vertex
	 * 
	 * @return
	 */
	private function insertSplit( start:Vertex, a:Vertex, b:Vertex ):Vertex
	{		
		var split:Vertex = new Vertex( null );	
			split.index = Math.min( a.index, b.index ) + Math.min( 1, Math.abs(b.index - a.index) ) * 0.5;
			
		if( this.isVertical( a, b ) )  // vertical edge, horizontal ray that splits the edge
		{			
			split.x = a.x;
			split.y = start.y;
		}
		else
		{
			split.x = start.x;
			split.y = a.y;
		}	
		
		#if debug
			trace( "split", start, "--X--", a, b + ": [" + split.index + "]" );
		#end
		
		// ------------------- //
		// adjust edges:
		
		this.remove( a, b );
		
		this.insert( split, start );
		this.insert( split, a );
		this.insert( split, b );
		
		// ------------------- //
		// adjust graph:
		
		a.removeNeighbor( b );
		b.removeNeighbor( a );
		
		a.insertNeighbor( split );
		b.insertNeighbor( split );
		
		split.insertNeighbor( start );
		split.insertNeighbor( a );
		split.insertNeighbor( b );
		
		start.insertNeighbor( split );
		
		// ------------------- //
		
		return split;
	}
	
	// ----------------------------------- //
	// ----------------------------------- //
	
	/**
	 * searches for the closest edge to the given coordinate
	 * 
	 * @param	value	x-coordinate for vertical, y-coordinate for horizontal
	 * @return	index where the edge would be inserted -1
	 */
	private function getIndex( value:Float, isVertical:Bool ):Int
	{
		if( isVertical )
		{
			var vlength:Int = this.vertical.length >> 1;
			
			for( v in 0...vlength )
			{
				if( this.vertical[v * 2].x > value )
					return v;
			}
			
			return vlength;
		}		
		else
		{
			var hlength:Int = this.horizontal.length >> 1;
			
			for( h in 0...hlength )
			{
				if( this.horizontal[h * 2].y > value )
					return h;
			}
			
			return hlength;
		}		
		
		return -1;
	}
	
	/**
	 * 
	 * @param	a
	 * @param	b
	 */
	public function isVertical( a:Vertex, b:Vertex ):Bool
	{
		#if debug
			if( !MathUtil.isEqual( a.x, b.x ) && !MathUtil.isEqual( a.y, b.y ) )
				throw "both vertices are not perpendicular";
		#end
		
		return MathUtil.isEqual( a.x, b.x );
	}
	
}