package ;

import at.dotpoint.math.geom.Rectangle;
import at.dotpoint.math.vector.Vector2;
import calculator.TraversalSplitter;
import converter.StringConverter;

#if display
	import view.CanvasView;
	import view.ControllerView;

	import at.dotpoint.core.bootstrapper.task.StageTask;
	import at.dotpoint.core.event.Event;
	import at.dotpoint.display.event.MouseEvent;
	import at.dotpoint.display.Stage;
#end

/**
 * partitionates a given orthogonal polygon into several rectangular areas. provides an optional view
 * to display the result and a very basic UI to test custom or predefined polygons. depending on the
 * compiler flags anything view or debug related will be discarded allowing to compile a minimal version
 * to be used in several languages.
 * 
 * the magic happens in TraversalSplitter.hx and EdgeContainer.hx
 * some basic math classes are used from the dotCore library: Vector2, Vector3 and Rectangle
 * 
 * TODO: implement typedef/interface to inject used math classes, allowing for custom/native classes
 * TODO: implement a more practical way to provide input/output converter instead of hardcoding a switch/case
 * BUG:	 input is not validated sufficently, easily possible to feed the calculator with wrong/breaking data
 * 
 * GitHub: 		https://github.com/ScrambledRK/TraversalSplitter
 * Blog-Post:	http://scrambledrk.blogspot.co.at/2014/07/polygon-partitioning.html
 * 
 * @author Gerald Hattensauer: ScrambledRK
 */
class Main
{
	
	/**
	 * singleton (habit, convinience, ... )
	 */
	private static var instance:Main;
	
	// --------------- //	
	
	/**
	 * calculating rectangular partitions for a given set of coordinates of an orthogonal polygon
	 * this is where all the magic happens ...
	 */
	private var calculator:IPartitionCalculator;
	
	#if display
	
	/**
	 * display controller (input/output)
	 */
	private var controller:ControllerView;
	
	/**
	 * canvas for all the debug informations
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
	public function calculate( input:Dynamic ):Dynamic
	{		
		var input:Array<Vector2> = this.parseInput( input );
		var result:Array<Rectangle> = this.calculator.calculate( input );		
		
		return result;
	}
	
	/**
	 * 
	 * @param	input
	 * @return
	 */
	private function parseInput( input:Dynamic ):Array<Vector2>
	{
		var output:Array<Vector2> = null;
		
		// ----------- //
		
		if( Std.is( input, String ) )
			output = new StringConverter().convert( cast input );
		
		// ----------- //	
		
		if( output == null )
			throw "unable to convert given input " + input;
		
		return output;
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