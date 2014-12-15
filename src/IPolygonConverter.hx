package ;

import at.dotpoint.math.vector.Vector2;


/**
 * @author RK
 */

interface IPolygonConverter<TInput:Dynamic> 
{
	
	/**
	 * converts a given set of input coordinates of an orthogonal polygon 
	 * into an interable list of 2D coordinates. the input might be a string,
	 * a list of floats or integers or any other form. 
	 * 
	 * @param	input - depending on the implementation
	 * @return  interable list of 2D coordinates
	 */
	public function convert( input:TInput ):Array<Vector2>;
	
}