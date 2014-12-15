package ;
import at.dotpoint.math.geom.Rectangle;
import at.dotpoint.math.vector.Vector2;

/**
 * @author RK
 */

interface IPartitionCalculator 
{
	
	#if debug
	
	/**
	 * drawing
	 */
	public var debugger:IPartitionDebugger;
	
	#end
	
	/**
	 * 
	 * @param	input	x,y coordinates in Integer seperated by space for each outline-vertex
	 * @return	x,y,w,h coordinates in Integer seperated by space for each partition
	 */
	public function calculate( input:Array<Vector2> ):Array<Rectangle>;
}