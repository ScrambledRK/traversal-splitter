package view;

import at.dotpoint.math.geom.Rectangle;
import at.dotpoint.math.vector.IVector2;
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextField;

/**
 * ...
 * @author RK
 */
class CanvasView extends Sprite implements IPartitionDebugger
{
	
	/**
	 * key: 	vertex coordinates
	 * value:	index/debug string
	 */
	public var debugVertex:Map<IVector2,String>;
	
	/**
	 * num unique Vertices within debugVertex
	 */
	public var countVertex:Int;	
	
	/**
	 * key: 	rectangle coordinates
	 * value:	index/debug string
	 */
	public var debugRectangle:Map<Rectangle,String>;
	
	/**
	 * num unique Rectangles within debugRectangle
	 */
	public var countRectangle:Int;
	
	// ------------------- //
	
	/**
	 * polygon canvas (where debug gets drawn onto)
	 */
	private var canvas:Sprite;

	// ************************************************************************ //
	// Constructor
	// ************************************************************************ //	
	
	public function new() 
	{
		super();
		
		this.countRectangle = 0;
		this.countVertex 	= 0;
		
		this.debugRectangle = new Map<Rectangle,String>();	
		this.debugVertex 	= new Map<IVector2,String>();
		
		this.canvas = new Sprite();
		this.addChild( this.canvas );
	}
	
	// ************************************************************************ //
	// Methods
	// ************************************************************************ //	
	
	/**
	 * 
	 * @param	list
	 */
	public function drawOutline( list:Array<IVector2> ):Void
	{
		var shape:Shape = new Shape();
			shape.graphics.lineStyle( 8, Std.int( 0xFFFFFF * Math.random() ), 0.35 );
			
		for( v in 0...list.length + 1 )
		{
			var vertex:IVector2 = list[v % list.length];			
			
			if( v == 0 )
				shape.graphics.moveTo( vertex.x, vertex.y );
			else
				shape.graphics.lineTo( vertex.x, vertex.y );
			
			// ---------- //	
			
			var debug:TextField = new TextField();
				debug.text = this.getDebugVertex( vertex );
				debug.x = vertex.x;
				debug.y = vertex.y;
			
			this.canvas.addChild( debug );			
		}
		
		this.canvas.addChild( shape );
		
		// ----------------- //
		// remove offset
		
		var bounds:Rectangle = this.calculateBoundings( list );
		
		this.canvas.x -= bounds.x - 15;
		this.canvas.y -= bounds.y - 25;
	}
	
	/**
	 * 
	 * @param	area
	 * @param	name
	 */
	public function drawPartition( area:Rectangle ):Void
	{
		var color:Int = Std.int( 0xFFFFFF * Math.random() );
		
		var shape:Shape = new Shape();
			shape.graphics.lineStyle( 1, color );
			shape.graphics.beginFill( color, 0.1 );
			shape.graphics.drawRect( area.x, area.y, area.width, area.height );
			shape.graphics.endFill();
		
		this.canvas.addChild( shape );
		
		// ---------- //
		
		var debug:TextField = new TextField();
			debug.text = this.getDebugRectangle( area );
			debug.x = area.x + area.width  * 0.5;
			debug.y = area.y + area.height * 0.5;
		
		this.canvas.addChild( debug );
	}
	
	/**
	 * 
	 * @param	a
	 * @param	b
	 */
	public function drawSplitLine( a:IVector2, b:IVector2 ):Void
	{
		var shape:Shape = new Shape();
			shape.graphics.lineStyle( 4, 0x000000, 0.65 );
			shape.graphics.moveTo( a.x, a.y );
			shape.graphics.lineTo( b.x, b.y );
		
		this.canvas.addChild( shape );
	}
	
	/**
	 * 
	 * @param	a
	 */
	public function drawSplitStart( a:IVector2 ):Void
	{
		var shape:Shape = new Shape();
			shape.graphics.lineStyle( 2, 0xFF0000, 0.85 );
			shape.graphics.drawCircle( a.x, a.y, 4 );
		
		this.canvas.addChild( shape );
	}
	
	/**
	 * 
	 * @param	a
	 */
	public function drawSplitEnd( a:IVector2 ):Void
	{
		var shape:Shape = new Shape();
			shape.graphics.lineStyle( 2, 0x000000, 0.85 );
			shape.graphics.drawCircle( a.x, a.y, 4 );
		
		this.canvas.addChild( shape );
		
		// ---------- //	
			
		var debug:TextField = new TextField();
			debug.text = this.getDebugVertex( a );
			debug.x = a.x;
			debug.y = a.y;
		
		this.canvas.addChild( debug );
	}
	
	// ------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------- //
	// debug:
	
	/**
	 * 
	 * @param	vertex
	 * @return
	 */
	private function getDebugVertex( vertex:IVector2 ):String
	{
		if( !this.debugVertex.exists( vertex ) )
			this.setDebugVertex( vertex );
		
		return this.debugVertex.get( vertex );
	}
	
	/**
	 * 
	 */
	private function setDebugVertex( vertex:IVector2 ):Void
	{
		var index:Int 	 = this.countVertex++;
		var value:String = "[" + index + "]";
	
		this.debugVertex.set( vertex, value );	
	}	
	
	// ------------------------- //
	// ------------------------- //
	
	/**
	 * 
	 * @param	vertex
	 * @return
	 */
	private function getDebugRectangle( rectangle:Rectangle ):String
	{
		if( !this.debugRectangle.exists( rectangle ) )
			this.setDebugRectangle( rectangle );
		
		return this.debugRectangle.get( rectangle );
	}
	
	/**
	 * 
	 */
	private function setDebugRectangle( rectangle:Rectangle ):Void
	{
		var letters:Array<String> = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q" ];
		
		// ----------- //		
		
		var index:Int 	 = this.countRectangle++;
		var value:String = "[" + letters[index % letters.length] + "]";
		
		this.debugRectangle.set( rectangle, value );		
	}
	
	
	// ------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------- //
	// tools:
	
	/**
	 * 
	 * @param	coordinates
	 * @return
	 */
	private function calculateBoundings( coordinates:Array<IVector2> ):Rectangle
	{
		var bounding:Rectangle = new Rectangle();		
		
		for( v in 0...coordinates.length )
		{
			var x:Float = coordinates[v].x;
			var y:Float = coordinates[v].y;
			
			var nl:Float = v == 0 ? x : Math.min( bounding.left, 	x );
			var nr:Float = v == 0 ? x : Math.max( bounding.right,  	x );
			var nt:Float = v == 0 ? y : Math.min( bounding.top, 	y );
			var nb:Float = v == 0 ? y : Math.max( bounding.bottom, 	y );
			
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
		
		return bounding;
	}
}