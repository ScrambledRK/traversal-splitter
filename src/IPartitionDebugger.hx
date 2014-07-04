package ;

import at.dotpoint.math.geom.Rectangle;
import at.dotpoint.math.vector.Vector2;

/**
 * @author RK
 */

interface IPartitionDebugger 
{
	
	/**
	 * 
	 * @param	list
	 */
	public function drawOutline( list:Array<Vector2> ):Void;
	
	/**
	 * 
	 * @param	area
	 * @param	name
	 */
	public function drawPartition( area:Rectangle ):Void;
	
	/**
	 * 
	 * @param	a
	 * @param	b
	 */
	public function drawSplitLine( a:Vector2, b:Vector2 ):Void;
	
	/**
	 * 
	 * @param	a
	 */
	public function drawSplitStart( a:Vector2 ):Void;
	
	/**
	 * 
	 * @param	a
	 */
	public function drawSplitEnd( a:Vector2 ):Void;
	
}