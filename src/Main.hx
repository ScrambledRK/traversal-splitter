package ;

import calculator.TraversalSplitter;

#if display
	import view.CanvasView;
	import view.ControllerView;

	import at.dotpoint.core.bootstrapper.task.StageTask;
	import at.dotpoint.core.event.Event;
	import at.dotpoint.display.event.MouseEvent;
	import at.dotpoint.display.Stage;
#end

/**
 * ...
 * @author RK
 */

class Main
{
	
	private static var instance:Main;
	
	// --------------- //	
	
	/**
	 * doing all the work
	 */
	private var calculator:IPartitionCalculator;
	
	#if display
	
	/**
	 * display controller (input/output)
	 */
	private var controller:ControllerView;
	
	/**
	 * debug rectangle
	 */
	private var canvas:CanvasView;
	
	#end
	
	// ************************************************************************ //
	// Constructor
	// ************************************************************************ //
	
	static public function main() 
	{                
		Main.instance = new Main();
	}        
	
	public function new() 
	{
		this.initialize();
	}
	
	// ************************************************************************ //
	// Methodes
	// ************************************************************************ //
	
	/**
	 * 
	 */
	private function initialize():Void 
	{
		this.calculator = new TraversalSplitter();			
		
		#if display				
			this.setupController();
			this.onCalculate( null );
		#end
	}
	
	/**
	 * 
	 */
	public function calculate( inputString:String ):Array<Int>
	{
		var input:Array<Int> = this.parseInput( inputString );
		var result:Array<Int> = this.calculator.calculate( input );
		
		return result;
	}
	
	/**
	 * 
	 * @param	input
	 * @return
	 */
	private function parseInput( input:String ):Array<Int>
	{
		var coordinates:Array<Int> = new Array<Int>();
		
		// ----------- //
		
		var splitted:Array<String> = input.split(" ");		
		var length:Int = Std.int( splitted.length * 0.5 );		
		
		for( j in 0...length )
		{
			var index:Int = j * 2;
			
			var x:Int = Std.parseInt( splitted[ index + 0 ] );
			var y:Int = Std.parseInt( splitted[ index + 1 ] );
			
			coordinates.push( x );
			coordinates.push( y );
		}
		
		if( coordinates.length == 0 )
			throw "input issue";
		
		return coordinates;
	}
	
	// ************************************************************************ //
	// View
	// ************************************************************************ //
	
	#if display	
	
	/**
	 * 
	 * @param	value
	 */
	private function onCalculate( value:Event ):Void
	{		
		this.setupCanvas();		
		
		// ------------------------ //
		
		#if debug
			this.controller.output = this.calculate( this.controller.input ).toString();
		#else
			try
			{
				this.controller.output = this.calculate( this.controller.input ).toString();
			}
			catch( error:Dynamic )
			{
				this.controller.output = "error: " + error;				
			}
		#end
	}
	
	
	/**
	 * 
	 */
	public function setupController():Void
	{
		var task:StageTask = new StageTask(null);
			task.execute();	
		
		// ------------ //		
		
		this.controller = new ControllerView();
		this.controller.addEventListener( MouseEvent.CLICK, this.onCalculate );		
		
		Stage.instance.addChild( this.controller );	
	}

	/**
	 * 
	 */
	private function setupCanvas():Void
	{
		if( this.canvas != null )
		{
			Stage.instance.removeChild( this.canvas );
			this.canvas = null;
		}
		
		// ------------------------ //
		
		this.canvas = new CanvasView();
		this.canvas.x = 15;
		this.canvas.y = 150;
		
		Stage.instance.addChild( this.canvas );
		
		#if debug
			this.calculator.debugger = this.canvas;	
		#end
	}
	
	#end
}