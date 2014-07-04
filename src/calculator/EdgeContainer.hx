package calculator;

import at.dotpoint.math.MathUtil;
import at.dotpoint.math.vector.Vector2;

/**
 * ...
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
		this.vertical = new Array<Vertex>();
		this.horizontal = new Array<Vertex>();
	}
	
	// ************************************************************************ //
	// Methods
	// ************************************************************************ //	
	
	/**
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
	 * BUG: might remove wrong Nodes, causing Edges to become diagonal even
	 * 
	 * @param	a
	 * @param	b
	 */
	public function remove( a:Vertex, b:Vertex ):Void
	{
		
		if( this.isVertical( a, b ) )
		{
			//var index:Int = this.getIndex( a.x, true );		
			//
			//this.vertical = this.vertical.splice( index * 2, 1 );
			//this.vertical = this.vertical.splice( index * 2, 1 );	
			
			this.vertical.remove( a );
			this.vertical.remove( b );
		}
		else
		{
			//var index:Int = this.getIndex( a.y, false );
			//
			//this.horizontal = this.horizontal.splice( index * 2, 1 );
			//this.horizontal = this.horizontal.splice( index * 2, 1 );
			
			this.horizontal.remove( a );
			this.horizontal.remove( b );
		}			
	}
	
	// ----------------------------------- //
	// ----------------------------------- //
	
	/**
	 * TODO: remove graph manipulation and just return the necessary data (edge + split point)
	 * TODO: hlength/vlength could be calculated for a minimum and "<=" seems wrong
	 * 
	 * @param	start		position the ray starts
	 * @param	ray			direction the ray shoots until it hits a perpendicular edge
	 * @return	new vertex created on the edge the ray hits
	 */
	public function split( start:Vertex, dir:Vector2 ):Vertex
	{
		var isVertical:Bool = Math.abs(dir.x) < Math.abs(dir.y);	// vertical ray, check horizontal edges
		
		if( isVertical )
		{
			var ystep:Int 	= dir.y < 0 ? -1 : 1;
			
			var hstart:Int 	= this.getIndex( start.y, false ) - 1;				
			var hlength:Int = this.horizontal.length >> 1;
			
			// ---------------- //			
			// trace( "v check:", hstart, ystep, hlength );
			
			while( (hstart += ystep) >= 0 && hstart <= hlength )
			{			
				var hindex:Int = hstart * 2;
				
				var a:Vertex = this.horizontal[hindex + 0];
				var b:Vertex = this.horizontal[hindex + 1];
				
				if( a == start || b == start )
					continue;
				
				if( ( start.x >= a.x && start.x <= b.x )
				||	( start.x >= b.x && start.x <= a.x ) )
				{
					return this.insertSplit( start, a, b );
				}
			}
		}
		else
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
	 * 
	 * @return
	 */
	private function insertSplit( start:Vertex, a:Vertex, b:Vertex ):Vertex
	{		
		var split:Vertex = new Vertex();	
		
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
			var index:Float = Math.min( a.index, b.index ) + Math.min( 1, Math.abs(b.index - a.index) ) * 0.5;
			trace( "split", start, "--X--", a, b + ": [" + index + "]" );
		#end
		
		// ------------------- //
		// adjust edges:
		
		this.remove( a, b );
		
		this.insert( split, start );
		this.insert( split, a );
		this.insert( split, b );
		
		// ------------------- //
		// adjust graph:
		
		a.neighbors.remove( b );
		b.neighbors.remove( a );
		
		a.neighbors.add( split );
		b.neighbors.add( split );
		
		split.neighbors.add( start );
		split.neighbors.add( a );
		split.neighbors.add( b );
		
		start.neighbors.add( split );
		
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