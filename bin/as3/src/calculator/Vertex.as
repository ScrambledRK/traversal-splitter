package calculator {
	import at.dotpoint.math.vector.IVector2;
	import at.dotpoint.math.vector.Vector2;
	import flash.Boot;
	public class Vertex implements at.dotpoint.math.vector.IVector2{
		public function Vertex(coordinate : at.dotpoint.math.vector.Vector2 = null) : void { if( !flash.Boot.skip_constructor ) {
			if(coordinate == null) coordinate = new at.dotpoint.math.vector.Vector2();
			this.coordinate = coordinate;
			this.neighbors = new Array();
		}}
		
		public var coordinate : at.dotpoint.math.vector.Vector2;
		public var index : Number;
		public var neighbors : Array;
		public function get x() : Number { return get_x(); }
		public function set x( __v : Number ) : void { set_x(__v); }
		protected var $x : Number;
		public function get y() : Number { return get_y(); }
		public function set y( __v : Number ) : void { set_y(__v); }
		protected var $y : Number;
		public function get_x() : Number {
			return this.coordinate.get_x();
		}
		
		public function set_x(value : Number) : Number {
			return this.coordinate.set_x(value);
		}
		
		public function get_y() : Number {
			return this.coordinate.get_y();
		}
		
		public function set_y(value : Number) : Number {
			return this.coordinate.set_y(value);
		}
		
		public function normalize() : void {
			this.coordinate.normalize();
		}
		
		public function length() : Number {
			return this.coordinate.length();
		}
		
		public function insertNeighbor(vertex : calculator.Vertex) : void {
			this.neighbors.push(vertex);
			this.neighbors.sort(this.sortNeighbors);
		}
		
		public function removeNeighbor(vertex : calculator.Vertex) : Boolean {
			return this.neighbors.remove(vertex);
		}
		
		public function sortNeighbors(a : calculator.Vertex,b : calculator.Vertex) : int {
			return Math.round(a.index - b.index);
		}
		
		public function toString() : String {
			return "[" + this.index + "]";
		}
		
	}
}
