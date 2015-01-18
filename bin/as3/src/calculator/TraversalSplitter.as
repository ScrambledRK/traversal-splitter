package calculator {
	import calculator.EdgeContainer;
	import calculator.VertexTriangle;
	import at.dotpoint.math.geom.Rectangle;
	import calculator.Vertex;
	import haxe.Log;
	import at.dotpoint.math.vector.Vector2;
	import at.dotpoint.math.vector.Vector3;
	public class TraversalSplitter implements IPartitionCalculator{
		public function TraversalSplitter() : void {
		}
		
		public var coordinates : Array;
		public var splitters : Array;
		public var edges : calculator.EdgeContainer;
		public var partitions : Array;
		public function calculate(input : Array) : Array {
			this.coordinates = new Array();
			this.edges = new calculator.EdgeContainer();
			this.partitions = new Array();
			this.prepareInput(input);
			this.split();
			this.partitionate();
			return this.partitions;
		}
		
		public function prepareInput(input : Array) : void {
			this.toVertices(input);
			this.sortClockwise();
			this.buildGraph();
		}
		
		public function toVertices(input : Array) : void {
			{
				var _g : int = 0;
				while(_g < input.length) {
					var point : at.dotpoint.math.vector.Vector2 = input[_g];
					++_g;
					this.coordinates.push(new calculator.Vertex(point));
				}
			};
			var first : calculator.Vertex = this.coordinates[0];
			var last : calculator.Vertex = this.coordinates[this.coordinates.length - 1];
			if(at.dotpoint.math.vector.Vector2.isEqual(first.coordinate,last.coordinate)) this.coordinates.pop();
		}
		
		public function sortClockwise() : void {
			var clockwise : Array = new Array();
			var counterwise : Array = new Array();
			{
				var _g1 : int = 0;
				var _g : int = this.coordinates.length;
				while(_g1 < _g) {
					var v : int = _g1++;
					var triangle : calculator.VertexTriangle = this.getTriangle(v,true);
					if(triangle.isClockwise()) clockwise.push(triangle.p2);
					else counterwise.push(triangle.p2);
				}
			};
			if(clockwise.length < counterwise.length) {
				(haxe.Log._trace)("reverse coordinates to conform to clockwise direction",{ fileName : "TraversalSplitter.hx", lineNumber : 168, className : "calculator.TraversalSplitter", methodName : "sortClockwise"});
				this.coordinates.reverse();
				this.splitters = clockwise;
				this.splitters.reverse();
			}
			else this.splitters = counterwise;
		}
		
		public function buildGraph() : void {
			{
				var _g1 : int = 0;
				var _g : int = this.coordinates.length;
				while(_g1 < _g) {
					var v : int = _g1++;
					var triangle : calculator.VertexTriangle = this.getTriangle(v,true);
					triangle.p2.insertNeighbor(triangle.p1);
					triangle.p2.insertNeighbor(triangle.p3);
					this.edges.insert(triangle.p1,triangle.p2);
				}
			};
			(haxe.Log._trace)("vertical:  " + Std.string(this.edges.vertical),{ fileName : "TraversalSplitter.hx", lineNumber : 204, className : "calculator.TraversalSplitter", methodName : "buildGraph"});
			(haxe.Log._trace)("horizontal:" + Std.string(this.edges.horizontal),{ fileName : "TraversalSplitter.hx", lineNumber : 205, className : "calculator.TraversalSplitter", methodName : "buildGraph"});
		}
		
		public function split() : void {
			var _g : int = 0;
			var _g1 : Array = this.splitters;
			while(_g < _g1.length) {
				var vertex : calculator.Vertex = _g1[_g];
				++_g;
				var normal : at.dotpoint.math.vector.Vector2 = this.getNormal(vertex);
				var split : calculator.Vertex = this.edges.split(vertex,normal);
				if(split == null) throw "split could not be resolved, check the input";
				this.coordinates.push(split);
			}
		}
		
		public function partitionate() : void {
			var _g : int = 0;
			var _g1 : Array = this.coordinates;
			while(_g < _g1.length) {
				var start : calculator.Vertex = _g1[_g];
				++_g;
				var current : calculator.Vertex = start;
				var previous : calculator.Vertex = null;
				var next : calculator.Vertex = null;
				var partition : at.dotpoint.math.geom.Rectangle = null;
				do {
					next = this.selectClockwiseVertex(current,previous);
					if(next == null) {
						(haxe.Log._trace)("skip",{ fileName : "TraversalSplitter.hx", lineNumber : 276, className : "calculator.TraversalSplitter", methodName : "partitionate", customParams : [current]});
						break;
					}
					else {
						(haxe.Log._trace)("select",{ fileName : "TraversalSplitter.hx", lineNumber : 281, className : "calculator.TraversalSplitter", methodName : "partitionate", customParams : [previous,current,next,"\t neighbors:" + Std.string(next.neighbors)]});
						if(partition == null) partition = new at.dotpoint.math.geom.Rectangle();
						this.expandBounding(next,partition);
					};
					previous = current;
					current = next;
				} while(current != start);
				if(partition != null && this.isUniquePartiton(partition)) this.partitions.push(partition);
			}
		}
		
		public function selectClockwiseVertex(current : calculator.Vertex,previous : calculator.Vertex) : calculator.Vertex {
			var iterator : * = null;
			var possible : calculator.Vertex = null;
			if(previous == null) {
				iterator = current.neighbors.iterator();
				previous = current.neighbors[0];
			};
			while(previous != null) {
				{ var $it : * = current.neighbors.iterator();
				while( $it.hasNext() ) { var neighbor : calculator.Vertex = $it.next();
				{
					if(neighbor == previous) continue;
					var triangle : calculator.VertexTriangle = calculator.VertexTriangle.instance;
					triangle.p1 = previous;
					triangle.p2 = current;
					triangle.p3 = neighbor;
					if(triangle.isClockwise()) return neighbor;
					else if(triangle.isClockwise(true)) possible = neighbor;
				}
				}};
				if(possible != null) return possible;
				if(iterator == null || !iterator.hasNext()) break;
				previous = iterator.next();
			};
			return null;
		}
		
		public function isUniquePartiton(partition : at.dotpoint.math.geom.Rectangle) : Boolean {
			{
				var _g : int = 0;
				var _g1 : Array = this.partitions;
				while(_g < _g1.length) {
					var area : at.dotpoint.math.geom.Rectangle = _g1[_g];
					++_g;
					if(area == partition) continue;
					if(at.dotpoint.math.vector.Vector2.isEqual(partition.get_topLeft(),area.get_topLeft()) && at.dotpoint.math.vector.Vector2.isEqual(partition.get_bottomRight(),area.get_bottomRight())) return false;
				}
			};
			return true;
		}
		
		public function getTriangle(index : int,pool : * = false) : calculator.VertexTriangle {
			if(pool==null) pool=false;
			var p1 : calculator.Vertex = this.coordinates[index % this.coordinates.length];
			var p2 : calculator.Vertex = this.coordinates[(index + 1) % this.coordinates.length];
			var p3 : calculator.Vertex = this.coordinates[(index + 2) % this.coordinates.length];
			var triangle : calculator.VertexTriangle;
			if(pool) triangle = calculator.VertexTriangle.instance;
			else triangle = new calculator.VertexTriangle();
			triangle.p1 = p1;
			triangle.p2 = p2;
			triangle.p3 = p3;
			return triangle;
		}
		
		public function getNormal(current : calculator.Vertex) : at.dotpoint.math.vector.Vector2 {
			var previous : calculator.Vertex = current.neighbors[0];
			var delta : at.dotpoint.math.vector.Vector3 = new at.dotpoint.math.vector.Vector3();
			delta.set_x(current.get_x() - previous.get_x());
			delta.set_y(current.get_y() - previous.get_y());
			var normal : at.dotpoint.math.vector.Vector3 = at.dotpoint.math.vector.Vector3.cross(delta,new at.dotpoint.math.vector.Vector3(0,0,-1));
			normal.normalize();
			return new at.dotpoint.math.vector.Vector2(normal.get_x(),normal.get_y());
		}
		
		public function expandBounding(vertex : calculator.Vertex,bounding : at.dotpoint.math.geom.Rectangle) : void {
			var v : Boolean = bounding.get_width() == 0 && bounding.get_height() == 0 && bounding.get_x() == 0 && bounding.get_y() == 0;
			var x : Number = vertex.get_x();
			var y : Number = vertex.get_y();
			var nl : Number;
			if(v) nl = x;
			else nl = Math.min(bounding.get_left(),x);
			var nr : Number;
			if(v) nr = x;
			else nr = Math.max(bounding.get_right(),x);
			var nt : Number;
			if(v) nt = y;
			else nt = Math.min(bounding.get_top(),y);
			var nb : Number;
			if(v) nb = y;
			else nb = Math.max(bounding.get_bottom(),y);
			if(nl != bounding.get_left() || nr != bounding.get_right() || nt != bounding.get_top() || nb != bounding.get_bottom()) {
				bounding.set_right(nr);
				bounding.set_left(nl);
				bounding.set_bottom(nb);
				bounding.set_top(nt);
			}
		}
		
	}
}
