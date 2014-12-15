package ;

import at.dotpoint.math.geom.Rectangle;
import at.dotpoint.math.vector.IVector2;
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
	public function drawOutline( list:Array<IVector2> ):Void;
	
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
	public function drawSplitLine( a:IVector2, b:IVector2 ):Void;
	
	/**
	 * 
	 * @param	a
	 */
	public function drawSplitStart( a:IVector2 ):Void;
	
	/**
	 * 
	 * @param	a
	 */
	public function drawSplitEnd( a:IVector2 ):Void;
	
}