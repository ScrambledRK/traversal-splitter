package calculator;

import at.dotpoint.math.geom.Rectangle;
import at.dotpoint.math.vector.Vector2;
import at.dotpoint.math.vector.Vector3;

/**
 * partitionates a given orthogonal polygon into several rectangular areas. it does so by
 * creating a graph out of the given coordinate system, traverses the graph clockwise and 
 * looks out for points that create a counter-clockwise walk. those vertices define points
 * where rectangles can be found. it then inserts on all those points lines into the graph
 * and then traverses the graph once again to find all closed-walks defining rectangles.
 * 
 * @author RK
 */
class TraversalSplitter implements IPartitionCalculator
{

	#if debug	
	/**
	 * draws/traces additional informations/visualisations
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
	 * output: rectangles enclosed by the given orthogonal polygon
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
	public function calculate( input:Array<Vector2> ):Array<Rectangle>
	{		
		this.coordinates 	= new Array<Vertex>();		// all vertices, at first only outline; later split-vertices
		this.edges 			= new EdgeContainer();		// horizontal and vertical lines used for fast intersection
		
		this.partitions		= new Array<Rectangle>();	// found rectangles
		
		// ---------------------------- //
		
		this.prepareInput( input );	// build graph, detect split-points
		
		this.split();				// insert new lines and vertices used to extract partitions
		this.partitionate();		// traverse the graph to extract rectangular-partitions
		
		// ---------------------------- //
		
		#if debug
			for( area in this.partitions )
			{
				if( this.debugger != null )
					this.debugger.drawPartition( area );
			}
		#end
		
		return this.partitions;
	}		
	
	// ************************************************************************ //
	// Prepare: parse, ensure clockwise, build graph, get splitters
	// ************************************************************************ //	
	
	/**
	 * - build a graph of vertices
	 * - assert clockwise rotation
	 * - detect counter-clockwise vertices for splitting
	 * - collect all orthogonal lines for splitting
	 */
	private function prepareInput( input:Array<Vector2> ):Void
	{	
		this.toVertices( input );	// create vertices out of the input coordinates
		this.sortClockwise();		// assert clockwise rotation, detect counter-clockwise for splitting
		this.buildGraph();			// assign neighbor vertices for each vertex, extract orthogonal lines
		
		// TODO: check if given orthogonal polygon is closed, truly orthogonal and alternating vertical/horizontal lines (no useless vertices)
		
		// ---------------------------- //
		
		#if debug
			if( this.debugger != null )
			{			
				this.debugger.drawOutline( cast this.coordinates );	
				
				for( vertex in this.splitters )
					this.debugger.drawSplitStart( vertex.coordinate );			
			}
		#end
	}
	
	/**
	 * fill up this.coordinates with given vertices
	 */
	private function toVertices( input:Array<Vector2> ):Void
	{
		for( point in input )
		{			
			this.coordinates.push( new Vertex( point ) );
		}
		
		// ------------ //
		
		var first:Vertex = this.coordinates[0];
		var last:Vertex  = this.coordinates[this.coordinates.length - 1];
		
		if( Vector2.isEqual( first.coordinate, last.coordinate ) ) // we do not want overlapping vertices
			this.coordinates.pop();
	}
	
	/**
	 * - ensure vertices are indexed clockwise for consistency
	 * - store counter-clockwise vertices as "splitters" 
	 */
	private function sortClockwise():Void
	{		
		var clockwise:Array<Vertex> 	= new Array<Vertex>();		
		var counterwise:Array<Vertex> 	= new Array<Vertex>();		
		
		for( v in 0...this.coordinates.length )
		{
			var triangle:VertexTriangle = this.getTriangle( v, true );		
			
			if( triangle.isClockwise() )	clockwise.push( triangle.p2 );			
			else							counterwise.push( triangle.p2 );			
		}
		
		// ---------------------------- //
		// assert clockwise, counter-clockwise are "splitters"
		
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
		for( v in 0...this.coordinates.length )
		{
			var triangle:VertexTriangle = this.getTriangle( v, true );		
			
			triangle.p2.neighbors.add( triangle.p1 ); 		// clockwise previous neighbor
			triangle.p2.neighbors.add( triangle.p3 ); 		// clockwise next neighbor			
			
			this.edges.insert( triangle.p1, triangle.p2 );	// line between previous and current vertex
		}
		
		trace( "vertical:  " + this.edges.vertical );
		trace( "horizontal:" + this.edges.horizontal );		
	}
	
	// ************************************************************************ //
	// Split + Partition
	// ************************************************************************ //	
	
	/**
	 * insert a new line for each counter-clockwise vertex in the polygon outline
	 * normal to the direction of the line between the split-vertex and its neighbor.
	 * 
	 * insert a new vertex on the point this new line crosses another line of the polygon.
	 * this might be a line from the original polygon or another inserted one from a previous split.
	 * 
	 * adjust the graph to respect the inserted line and vertex	
	 * 
	 * TODO: remove graph adjustment from EdgeContainer (should not be its responsibility)
	 */
	private function split():Void 
	{
		for( vertex in this.splitters )
		{
			var normal:Vector2 = this.getNormal( vertex );				// line normal to the given vertex and its neighbor
			var split:Vertex   = this.edges.split( vertex, normal );	// point this new line intersects another line, graph manipulation			
			
			if( split == null )
				throw "split could not be resolved, check the input";	// cannot happen given a valid orthogonal polygon graph
			
			this.coordinates.push( split );								// order is no longer important
			
			// ------------------ //
			
			#if debug
				split.index  = this.coordinates.length;
				
				if( this.debugger != null )
				{				
					this.debugger.drawSplitLine( vertex.coordinate, split.coordinate );	
					this.debugger.drawSplitEnd( split.coordinate );		
				}
			#end
		}
	}
	
	/**
	 * traverse the graph finding closed rectangular loops and store them as partitions
	 * and make sure to discared duplicates. loops are found using a clockwise check from
	 * a set of 3 vertices, this time including previously splitted lines/vertices
	 * 
	 * TODO: could be optimized to avoid finding the same partition multiple times
	 * TODO: could run into an infinit loop in case the graph is not valid 
	 */
	private function partitionate():Void
	{	
		for( start in this.coordinates )
		{			
			var current:Vertex 		= start;	// current, previous, next define a triangle for clockwise check
			var previous:Vertex 	= null;		// closed clockwise traversal using the new graph gives the smallest
			var next:Vertex			= null;		// possible rectangle ...
			
			var partition:Rectangle = null;
			
			// ------------------- //
			// traverse partition:
			
			do
			{				
				next = this.selectClockwiseVertex( current, previous );
				
				if( next == null ) 	// could not select a clockwise vertex, skip - another partition will include the current vertex
				{					
					trace("skip", current);						
					break;
				}				
				else				// found a clockwise vertex, a partition can be created
				{					
					trace("select", previous, current, next, "\t neighbors:" + next.neighbors );					
					
					if( partition == null )
						partition = new Rectangle();
					
					this.expandBounding( next, partition );
				}							
				
				previous = current;
				current	 = next;	
			}
			while( current != start );
			
			// ------------------- //
			// save partition:
			
			if( partition != null && this.isUniquePartiton( partition ) )
				this.partitions.push( partition );
		}
	}
	
	/**
	 * @param	previous
	 * @param	current
	 * @return
	 */
	private function selectClockwiseVertex( current:Vertex, previous:Vertex ):Vertex
	{
		var iterator:Iterator<Vertex> = null;	// used in case no previous is given to try all possible neighbors as a "previous" vertex
		var possible:Vertex = null;				// a vertex that is on the same line as the previous and current one. not clockwise, but still valid 
		
		if( previous == null )
		{
			iterator = current.neighbors.iterator();
			previous = current.neighbors.first();		
		}
		
		while( previous != null )
		{
			for( neighbor in current.neighbors.iterator() )
			{
				if( neighbor == previous )
					continue;
				
				var triangle:VertexTriangle = VertexTriangle.instance;
					triangle.p1 = previous;
					triangle.p2 = current;
					triangle.p3 = neighbor;
				
				if( triangle.isClockwise() )				// we found our next vertex in case the triangle is clockwise
				{					
					return neighbor;
				}
				else
				{
					if( triangle.isClockwise( true ) )		// otherwise we check if its at least in the same direction
						possible = neighbor;				// and store it, as it might be a fit
				}
			}	
			
			// -------------------- //
			
			if( possible != null )							// we did not find a clockwise, but is there at least one in the same direction?
				return possible;
			
			if( iterator == null || !iterator.hasNext() )	// can't try further previous vertices in case we were given a previous (or tried all)
				break;
			
			previous = iterator.next();						// the previous vertex does not produce a clockwise direction, check another
		}
		
		return null;
	}
	
	// ************************************************************************ //
	// Output:
	// ************************************************************************ //
	
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
	 * returns a triangle composed of 3 vertices using the given index to lookup
	 * the first vertex withing the coordinates list and add the other following 
	 * vertices to the triangle, looping through the list to the beginning if necessary.
	 * 
	 * @param	index	starting index of the polygon (first vertex)
	 * @param	pool 	optionally set this to true to reuse an existing instance of 
	 * 					VertexTriangle, false to create a new one
	 * 
	 * @return	VertexTriangle composed of 3 vertices from the coordinates list
	 */
	private function getTriangle( index:Int, ?pool:Bool = false ):VertexTriangle
	{
		var p1:Vertex = this.coordinates[(index + 0) % this.coordinates.length];
		var p2:Vertex = this.coordinates[(index + 1) % this.coordinates.length];
		var p3:Vertex = this.coordinates[(index + 2) % this.coordinates.length];	
		
		var triangle:VertexTriangle = pool ? VertexTriangle.instance : new VertexTriangle();
			triangle.p1 = p1;
			triangle.p2 = p2;
			triangle.p3 = p3;
		
		return triangle;
	}
	
	/**
	 * calculates the direction (normalized line) of the given vertex
	 * and its (clockwise previous) neighbor.
	 * 
	 * @param	current vertex to calculate a normal from (using neighbor)
	 * @return	direction normal to the given vertex and its neighbor
	 * 
	 * TODO: could pool necessary Vector2/3 instances
	 */
	private function getNormal( current:Vertex ):Vector2
	{
		var previous:Vertex = current.neighbors.first();
		
		var delta:Vector3 = new Vector3();
			delta.x = current.x - previous.x;
			delta.y = current.y - previous.y;
		
		var normal:Vector3 = Vector3.cross( delta, new Vector3( 0, 0, -1 ) );
			normal.normalize();
		
		return new Vector2( normal.x, normal.y );  
	}
	
	/**
	 * expands the given bounding rectangle using the given vertex. the size of the rectangle
	 * will be adjusted including the given vertex in case the given vertex is outside of the current rectangle.
	 * 
	 * @param	vertex to include into the given bounds
	 * @param	bounding to insert the vertex into (adjust size to include the vertex)	
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
		
		if( nl != bounding.left 			// pretty sure work setting bounding.right/left etc directly
		||	nr != bounding.right			
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