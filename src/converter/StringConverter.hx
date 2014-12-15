package converter;
import at.dotpoint.math.vector.Vector2;

/**
 * ...
 * @author RK
 */
class StringConverter implements IPolygonConverter<String>
{

	/**
	 * used to split the string into its x, y coordinates
	 */
	private var seperator:String;
	
	// ************************************************************************ //
	// Constructor
	// ************************************************************************ //	
	
	public function new( ?seperator:String ) 
	{
		if( seperator == null )
			seperator = " ";
		
		this.seperator = seperator;
	}
	
	// ************************************************************************ //
	// Methods
	// ************************************************************************ //	
	
	/**
	 * @param	input - string of space or comma seperated floats or integers; assumes alternating x and y coordinates
	 * @return  interable list of 2D coordinates
	 */
	public function convert( input:String ):Array<Vector2>
	{
		var coordinates:Array<Vector2> = new Array<Vector2>();
		
		// ----------- //
		
		var splitted:Array<String> = input.split( this.seperator );		
		var length:Int = Std.int( splitted.length * 0.5 );		
		
		for( j in 0...length )
		{
			var index:Int = j * 2;
			
			var point:Vector2 = new Vector2();
				point.x = Std.parseInt( splitted[ index + 0 ] );
				point.y = Std.parseInt( splitted[ index + 1 ] );
			
			coordinates.push( point );
		}
		
		// ----------- //
		
		if( coordinates.length == 0 )
			throw "input string does not contain parsable float or integer coordinates or does not use " + this.seperator + " as seperator";
		
		return coordinates;
	}
	
}