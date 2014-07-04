package calculator;

import at.dotpoint.math.geom.Rectangle;
import at.dotpoint.math.vector.Vector2;
import at.dotpoint.math.vector.Vector3;

/**
 * ...
 * @author RK
 */
class TraversalSplitter implements IPartitionCalculator
{

	#if debug
	/**
	 * draws/outputs infos
	 */
	public var debugger:IPartitionDebugger;	
	#end
	
	// ------------------ //
	
	/**
	 * outline coordinates, + neighbor vertices
	 */
	private var coordinates:Array<Vertex>;
	
	/**
	 * vertices that initiate a split
	 */
	private var splitters:Array<Vertex>;
	
	/**
	 * manages and stores all lines/edges between vertices
	 * and provides an interface to split lines
	 */
	private var edges:EdgeContainer;
	
	// ------------------ //
	
	/**
	 * output
	 */
	private var partitions:Array<Rectangle>;
	
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
	 * 
	 * @param	input	x,y coordinates in Integer seperated by space for each outline-vertex
	 * @return	x,y,w,h coordinates in Integer seperated by space for each partition
	 */
	public function calculate( input:Array<Int> ):Array<Int>
	{		
		this.prepareInput( input );
		
		this.split();
		this.partition();
		
		return this.prepareOutput();
	}		
	
	// ************************************************************************ //
	// Prepare: parse, ensure clockwise, build graph, get splitters
	// ************************************************************************ //	
	
	/**
	 * 
	 */
	private function prepareInput( input:Array<Int> ):Void
	{					
		this.coordinates = this.parseInput( input );
		
		this.traverse();	
		this.buildGraph();
		
		// ---------------------------- //
		
		#if debug
			if( this.debugger != null )
			{			
				this.debugger.drawOutline( cast this.coordinates );	
				
				for( vertex in this.splitters )
					this.debugger.drawSplitStart( vertex );			
			}
		#end
	}
	
	/**
	 * 
	 * @param	input x, y, x, y, x, y ...
	 * @return	vec1, vec2, vec3, ...
	 */
	private function parseInput( input:Array<Int> ):Array<Vertex>
	{
		var coordinates:Array<Vertex> = new Array<Vertex>();		
		var length:Int = Std.int( input.length * 0.5 ) - 1;	
		
		for( j in 0...length )
		{
			var index:Int = j * 2;
			
			var x:Int = input[ index + 0 ];
			var y:Int = input[ index + 1 ];
			
			var vertex:Vertex = new Vertex( x, y );
			
			coordinates.push( vertex );
		}
		
		return coordinates;
	}
	
	/**
	 * - ensure vertices are indexed clockwise for consistency
	 * - store counter-clockwise vertices as "splitters" 
	 */
	private function traverse():Void
	{		
		var clockwise:Array<Vertex> 	= new Array<Vertex>();		
		var counterwise:Array<Vertex> 	= new Array<Vertex>();		
		
		for( v in 0...this.coordinates.length )
		{
			var p1:Vertex = this.coordinates[(v + 0) % this.coordinates.length];
			var p2:Vertex = this.coordinates[(v + 1) % this.coordinates.length];
			var p3:Vertex = this.coordinates[(v + 2) % this.coordinates.length];			
			
			if( this.isClockwise( p1, p2, p3 ) )	clockwise.push( p2 );			
			else									counterwise.push( p2 );			
		}
		
		// ---------------------------- //
		
		if( clockwise.length < counterwise.length )
		{			
			trace("reverse coordinates to conform to clockwise direction");			
			
			this.coordinates.reverse();
			
			this.splitters = clockwise;
			this.splitters.reverse();
		}
		else
		{
			this.splitters = counterwise;
		}	
		
		// ---------------------------- //
		
		#if debug
			for( v in 0...this.coordinates.length )		
				this.coordinates[v].index = v;		
		#end
	}
	
	/**
	 * - link previous + following node for each vertex
	 * - add each line/edge to a sorted list 
	 */
	private function buildGraph():Void
	{
		this.edges = new EdgeContainer();		
		
		for( v in 0...this.coordinates.length )
		{
			var p1:Vertex = this.coordinates[(v + 0) % this.coordinates.length];
			var p2:Vertex = this.coordinates[(v + 1) % this.coordinates.length];
			var p3:Vertex = this.coordinates[(v + 2) % this.coordinates.length];			
			
			p2.neighbors.add( p1 );
			p2.neighbors.add( p3 );			
			
			this.edges.insert( p1, p2 );
		}
		
		trace( "vertical:  " + this.edges.vertical );
		trace( "horizontal:" + this.edges.horizontal );		
	}
	
	// ************************************************************************ //
	// Split + Partition
	// ************************************************************************ //	
	
	/**
	 * split edges normal to the split-points and insert a new vertex + edge
	 */
	private function split():Void 
	{
		for( v in 0...this.splitters.length )
		{
			var current:Vertex 		= this.splitters[v];
			var previous:Vertex 	= current.neighbors.first(); 			// only works on first iteration, afterwards order is chaotic
			
			// ------------------ //	
			
			var normal:Vector2 = this.getNormal( current, previous );			
			
			var split:Vertex = this.edges.split( current, normal );			// already adjust graph + edges				
			
			if( split == null )
				throw "split could not be resolved";
			
			this.coordinates.push( split );				
			
			// ------------------ //
			
			#if debug
				split.index  = this.coordinates.length;
				
				if( this.debugger != null )
				{				
					this.debugger.drawSplitLine( current, split );	
					this.debugger.drawSplitEnd( split );		
				}
			#end
		}
	}
	
	/**
	 * traverse the graph finding close rectangular loops and store them as partitions
	 */
	private function partition():Void
	{	
		this.partitions = new Array<Rectangle>();
		
		#if debug
			var counter:Int = 0;
		#end
		
		while( this.coordinates.length > 0 )
		{
			var start:Vertex 	= this.coordinates.pop();
			
			var current:Vertex 	= start;
			var previous:Vertex = null;
			var next:Vertex 	= null;			
			
			trace("");
			trace("new partition", start );			
			
			var partition:Rectangle = new Rectangle();
			
			// ------------------- //
			// traverse partition:
			
			do
			{				
				next = this.selectCircleNode( current, previous );
				
				if( next == null ) // could not select clockwise, skip as the partition will be t at some point
				{					
					trace("skip", current);					
					
					partition = null;					
					break;
				}				
				else
				{					
					trace("select", current + " > " + next, "\t", next.neighbors );					
					
					this.expandBounding( next, partition );
				}							
				
				previous = current;
				current	 = next;	
				
				#if debug 
					if( counter++ > 800 )
						return;
				#end
			}
			while( current != start );
			
			// ------------------- //
			// save partition:
			
			if( partition != null && this.isUniquePartiton( partition ) )
				this.partitions.push( partition );
		}
	}
	
	/**
	 * TODO: use isClockwise and remove predefined rotation
	 * 
	 * @param	previous
	 * @param	current
	 * @return
	 */
	private function selectCircleNode( current:Vertex, previous:Vertex ):Vertex
	{
		if( previous == null )
			previous = current;		
		
		var rotation:Array<Vector2> = new Array<Vector2>();		// preference in selecting neighbor: clockwise
			rotation[0] = new Vector2(  1,  0 );				// right
			rotation[1] = new Vector2(  0,  1 );				// down
			rotation[2] = new Vector2( -1,  0 );				// left
			rotation[3] = new Vector2(  0, -1 );				// up
		
		// ----------------- //	
		// select start:
		
		var direction:Vector2 = this.getDirection( current, previous );	
		
		var rotationStart:Int 	= -1;
		var rotationOffset:Int 	= 1; // next direction is first to check, on fail set to 0 to try current
		
		for( r in 0...rotation.length )
		{
			if( Vector2.isEqual( rotation[r], direction ) )
			{
				rotationStart = r; 
				break;
			}
		}
		
		// ----------------- //		
		// select neighbor:
		
		for( r in 0...rotation.length )
		{
			var index:Int = rotationStart + rotationOffset + r;
			
			if( index < 0 )
				index = rotation.length - index;
			
			var desired:Vector2 = rotation[ index % rotation.length ];
			
			// ---------------- //
			
			for( neighbor in current.neighbors.iterator() )
			{
				var direction:Vector2 = this.getDirection( neighbor, current );
				
				if( Vector2.isEqual( direction, desired ) && neighbor != previous )
				{					
					return neighbor;
				}				
			}			
			
			rotationOffset = -1; // reset to try current rotation next, then normal loop again
		}		
		
		return null;
	}
	
	// ************************************************************************ //
	// Output:
	// ************************************************************************ //
	
	/**
	 * - remove duplicated partitions
	 * - parse output
	 */
	private function prepareOutput():Array<Int>
	{
		var output:Array<Int> = new Array<Int>();
		
		for( area in this.partitions )
		{
			output.push( Std.int( area.x 		) );
			output.push( Std.int( area.y		) );
			output.push( Std.int( area.width  	) );
			output.push( Std.int( area.height 	) );			
		}
		
		#if debug
			for( area in this.partitions )
			{
				if( this.debugger != null )
					this.debugger.drawPartition( area );
			}
		#end
		
		return output;
	}
	
	/**
	 * 
	 * @param	partition
	 * @return
	 */
	private function isUniquePartiton( partition:Rectangle ):Bool
	{		
		for( area in this.partitions )
		{			
			if( area == partition )
				continue;				
				
			if( Vector2.isEqual( partition.topLeft, 	area.topLeft 	 )
			&&	Vector2.isEqual( partition.bottomRight, area.bottomRight ) )
			{				
				return false;
			}
		}
		
		return true;
	}
	
	// ************************************************************************ //
	// Tools
	// ************************************************************************ //	
	
	/**
	 * 
	 * @param	current
	 * @param	previous
	 */
	private function getNormal( current:Vertex, previous:Vertex ):Vector2
	{
		var delta:Vector3 = new Vector3();
			delta.x = current.x - previous.x;
			delta.y = current.y - previous.y;
		
		var normal:Vector3 = Vector3.cross( delta, new Vector3( 0, 0, -1 ) );
			normal.normalize();
		
		return new Vector2( normal.x, normal.y );
	}
	
	/**
	 * 
	 * @param	current
	 * @param	previous
	 * @return
	 */
	private function getDirection( current:Vertex, previous:Vertex ):Vector2
	{
		var direction:Vector2 = Vector2.subtract( current, previous );
			direction.normalize();			
			direction.x = Math.round( direction.x );			
			direction.y = Math.round( direction.y );
		
		return direction;
	}
	
	/**
	 * 
	 * @param	list
	 * @return
	 */
	private function isClockwise( a:Vector2, b:Vector2, c:Vector2 ):Bool
	{
		var p1:Vector3 = new Vector3( a.x, a.y, 0 );
		var p2:Vector3 = new Vector3( b.x, b.y, 0 );
		var p3:Vector3 = new Vector3( c.x, c.y, 0 );			
		
		var sub1:Vector3 = Vector3.subtract( p2, p1, new Vector3() );
		var sub2:Vector3 = Vector3.subtract( p3, p1, new Vector3() );
		
		return Vector3.cross( sub1, sub2 ).z > 0;
	}
	
	/**
	 * 
	 * @param	coordinates
	 * @return
	 */
	private function expandBounding( vertex:Vertex, bounding:Rectangle ):Void
	{		
		var v:Bool = bounding.width == 0 && bounding.height == 0 && bounding.x == 0 && bounding.y == 0;
		
		var x:Float = vertex.x;
		var y:Float = vertex.y;
		
		var nl:Float = v ? x : Math.min( bounding.left, 	x );
		var nr:Float = v ? x : Math.max( bounding.right,  	x );
		var nt:Float = v ? y : Math.min( bounding.top, 		y );
		var nb:Float = v ? y : Math.max( bounding.bottom, 	y );
		
		if( nl != bounding.left 			// could work setting bounding.right/left etc directly
		||	nr != bounding.right			// is copy/paste from similar code I've used somewhere else
		||  nt != bounding.top
		||  nb != bounding.bottom )			
		{	
			bounding.right 		= nr;	
			bounding.left 		= nl;			
			bounding.bottom 	= nb;	
			bounding.top 		= nt;					
		}
	}
}