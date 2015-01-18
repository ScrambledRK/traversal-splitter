package calculator {
	import calculator.Vertex;
	import at.dotpoint.math.vector.Vector2;
	import at.dotpoint.math.MathUtil;
	import flash.Boot;
	public class EdgeContainer {
		public function EdgeContainer() : void { if( !flash.Boot.skip_constructor ) {
			this.vertical = new Array();
			this.horizontal = new Array();
		}}
		
		public var horizontal : Array;
		public var vertical : Array;
		public function insert(a : calculator.Vertex,b : calculator.Vertex) : void {
			if(this.isVertical(a,b)) {
				var index : int = this.getIndex(a.get_x(),true);
				this.vertical.insert(index * 2,a);
				this.vertical.insert(index * 2,b);
			}
			else {
				var index1 : int = this.getIndex(a.get_y(),false);
				this.horizontal.insert(index1 * 2,a);
				this.horizontal.insert(index1 * 2,b);
			}
		}
		
		public function remove(a : calculator.Vertex,b : calculator.Vertex) : void {
			if(this.isVertical(a,b)) {
				this.vertical.remove(a);
				this.vertical.remove(b);
			}
			else {
				this.horizontal.remove(a);
				this.horizontal.remove(b);
			}
		}
		
		public function split(start : calculator.Vertex,dir : at.dotpoint.math.vector.Vector2) : calculator.Vertex {
			var isVertical : Boolean = Math.abs(dir.get_x()) < Math.abs(dir.get_y());
			if(isVertical) {
				var ystep : int;
				if(dir.get_y() < 0) ystep = -1;
				else ystep = 1;
				var hstart : int = this.getIndex(start.get_y(),false) - 1;
				var hlength : int = this.horizontal.length >> 1;
				while((hstart += ystep) >= 0 && hstart <= hlength) {
					var hindex : int = hstart * 2;
					var a : calculator.Vertex = this.horizontal[hindex];
					var b : calculator.Vertex = this.horizontal[hindex + 1];
					if(a == start || b == start) continue;
					if(start.get_x() >= a.get_x() && start.get_x() <= b.get_x() || start.get_x() >= b.get_x() && start.get_x() <= a.get_x()) return this.insertSplit(start,a,b);
				}
			}
			else {
				var xstep : int;
				if(dir.get_x() < 0) xstep = -1;
				else xstep = 1;
				var vstart : int = this.getIndex(start.get_x(),true) - 1;
				var vlength : int = this.vertical.length >> 1;
				while((vstart += xstep) >= 0 && vstart <= vlength) {
					var vindex : int = vstart * 2;
					var a1 : calculator.Vertex = this.vertical[vindex];
					var b1 : calculator.Vertex = this.vertical[vindex + 1];
					if(a1 == start || b1 == start) continue;
					if(start.get_y() >= a1.get_y() && start.get_y() <= b1.get_y() || start.get_y() >= b1.get_y() && start.get_y() <= a1.get_y()) return this.insertSplit(start,a1,b1);
				}
			};
			return null;
		}
		
		public function insertSplit(start : calculator.Vertex,a : calculator.Vertex,b : calculator.Vertex) : calculator.Vertex {
			var split : calculator.Vertex = new calculator.Vertex(null);
			split.index = Math.min(a.index,b.index) + Math.min(1,Math.abs(b.index - a.index)) * 0.5;
			if(this.isVertical(a,b)) {
				split.set_x(a.get_x());
				split.set_y(start.get_y());
			}
			else {
				split.set_x(start.get_x());
				split.set_y(a.get_y());
			};
			this.remove(a,b);
			this.insert(split,start);
			this.insert(split,a);
			this.insert(split,b);
			a.removeNeighbor(b);
			b.removeNeighbor(a);
			a.insertNeighbor(split);
			b.insertNeighbor(split);
			split.insertNeighbor(start);
			split.insertNeighbor(a);
			split.insertNeighbor(b);
			start.insertNeighbor(split);
			return split;
		}
		
		public function getIndex(value : Number,isVertical : Boolean) : int {
			if(isVertical) {
				var vlength : int = this.vertical.length >> 1;
				{
					var _g : int = 0;
					while(_g < vlength) {
						var v : int = _g++;
						if(this.vertical[v * 2].get_x() > value) return v;
					}
				};
				return vlength;
			}
			else {
				var hlength : int = this.horizontal.length >> 1;
				{
					var _g1 : int = 0;
					while(_g1 < hlength) {
						var h : int = _g1++;
						if(this.horizontal[h * 2].get_y() > value) return h;
					}
				};
				return hlength;
			};
			return -1;
		}
		
		public function isVertical(a : calculator.Vertex,b : calculator.Vertex) : Boolean {
			return at.dotpoint.math.MathUtil.isEqual(a.get_x(),b.get_x());
		}
		
	}
}
