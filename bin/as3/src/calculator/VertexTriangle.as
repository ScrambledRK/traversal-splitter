package calculator {
	import calculator.Vertex;
	import at.dotpoint.math.vector.Vector3;
	public class VertexTriangle {
		public function VertexTriangle() : void {
		}
		
		public var p1 : calculator.Vertex;
		public var p2 : calculator.Vertex;
		public var p3 : calculator.Vertex;
		public function isClockwise(includeZero : Boolean = false) : Boolean {
			if(this.p1 == null || this.p2 == null || this.p3 == null) throw "must set 3 vertex coordinates";
			var v1 : at.dotpoint.math.vector.Vector3 = new at.dotpoint.math.vector.Vector3(this.p1.coordinate.get_x(),this.p1.coordinate.get_y(),0);
			var v2 : at.dotpoint.math.vector.Vector3 = new at.dotpoint.math.vector.Vector3(this.p2.coordinate.get_x(),this.p2.coordinate.get_y(),0);
			var v3 : at.dotpoint.math.vector.Vector3 = new at.dotpoint.math.vector.Vector3(this.p3.coordinate.get_x(),this.p3.coordinate.get_y(),0);
			var sub1 : at.dotpoint.math.vector.Vector3 = at.dotpoint.math.vector.Vector3.subtract(v2,v1,new at.dotpoint.math.vector.Vector3());
			var sub2 : at.dotpoint.math.vector.Vector3 = at.dotpoint.math.vector.Vector3.subtract(v3,v1,new at.dotpoint.math.vector.Vector3());
			var cross : at.dotpoint.math.vector.Vector3 = at.dotpoint.math.vector.Vector3.cross(sub1,sub2);
			if(includeZero) return cross.get_z() >= 0;
			else return cross.get_z() > 0;
			return false;
		}
		
		static public var instance : calculator.VertexTriangle = new calculator.VertexTriangle();
	}
}
