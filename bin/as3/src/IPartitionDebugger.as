package  {
	import at.dotpoint.math.vector.IVector2;
	import at.dotpoint.math.geom.Rectangle;
	public interface IPartitionDebugger {
		function drawOutline(list : Array) : void ;
		function drawPartition(area : at.dotpoint.math.geom.Rectangle) : void ;
		function drawSplitLine(a : at.dotpoint.math.vector.IVector2,b : at.dotpoint.math.vector.IVector2) : void ;
		function drawSplitStart(a : at.dotpoint.math.vector.IVector2) : void ;
		function drawSplitEnd(a : at.dotpoint.math.vector.IVector2) : void ;
	}
}
