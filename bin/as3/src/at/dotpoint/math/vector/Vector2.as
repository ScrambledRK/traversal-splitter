package at.dotpoint.math.vector {
	import at.dotpoint.math.vector.IVector2;
	import at.dotpoint.core.ICloneable;
	import at.dotpoint.math.MathUtil;
	import flash.Boot;
	public class Vector2 implements at.dotpoint.core.ICloneable, at.dotpoint.math.vector.IVector2{
		public function Vector2(x : Number = 0,y : Number = 0) : void { if( !flash.Boot.skip_constructor ) {
			this.set_x(x);
			this.set_y(y);
		}}
		
		public function get x() : Number { return get_x(); }
		public function set x( __v : Number ) : void { set_x(__v); }
		protected var $x : Number;
		public function get y() : Number { return get_y(); }
		public function set y( __v : Number ) : void { set_y(__v); }
		protected var $y : Number;
		public function clone(_tmp_output : * = null) : * {
			var output : at.dotpoint.math.vector.Vector2 = at.dotpoint.math.vector.Vector2(_tmp_output);
			if(output != null) output = output;
			else output = new at.dotpoint.math.vector.Vector2();
			output.set_x(this.get_x());
			output.set_y(this.get_y());
			return output;
		}
		
		public function get_x() : Number {
			return this.$x;
		}
		
		public function set_x(value : Number) : Number {
			return this.$x = value;
		}
		
		public function get_y() : Number {
			return this.$y;
		}
		
		public function set_y(value : Number) : Number {
			return this.$y = value;
		}
		
		public function set(x : Number,y : Number) : void {
			this.set_x(x);
			this.set_y(y);
		}
		
		public function normalize() : void {
			var k : Number = 1. / this.length();
			{
				var _g : at.dotpoint.math.vector.Vector2 = this;
				_g.set_x(_g.get_x() * k);
			};
			{
				var _g1 : at.dotpoint.math.vector.Vector2 = this;
				_g1.set_y(_g1.get_y() * k);
			}
		}
		
		public function length() : Number {
			return Math.sqrt(this.get_x() * this.get_x() + this.get_y() * this.get_y());
		}
		
		public function lengthSq() : Number {
			return this.get_x() * this.get_x() + this.get_y() * this.get_y();
		}
		
		public function toArray(output : Array = null) : Array {
			if(output != null) output = new Array();
			output[0] = this.get_x();
			output[1] = this.get_y();
			return output;
		}
		
		public function getIndex(index : int) : Number {
			switch(index) {
			case 0:
			return this.get_x();
			break;
			case 1:
			return this.get_y();
			break;
			default:
			throw "out of bounds";
			break;
			};
			return 0.;
		}
		
		public function setIndex(index : int,value : Number) : void {
			switch(index) {
			case 0:
			this.set_x(value);
			break;
			case 1:
			this.set_y(value);
			break;
			default:
			throw "out of bounds";
			break;
			}
		}
		
		public function toString() : String {
			return "[Vector2;" + this.get_x() + ", " + this.get_y() + "]";
		}
		
		static public function add(a : at.dotpoint.math.vector.IVector2,b : at.dotpoint.math.vector.IVector2,output : * = null) : * {
			if(output == null) output = new at.dotpoint.math.vector.Vector2();
			output.set_x(a.get_x() + b.get_x());
			output.set_y(a.get_y() + b.get_y());
			return output;
		}
		
		static public function subtract(a : at.dotpoint.math.vector.IVector2,b : at.dotpoint.math.vector.IVector2,output : * = null) : * {
			if(output == null) output = new at.dotpoint.math.vector.Vector2();
			output.set_x(a.get_x() - b.get_x());
			output.set_y(a.get_y() - b.get_y());
			return output;
		}
		
		static public function scale(a : at.dotpoint.math.vector.IVector2,scalar : Number,output : * = null) : * {
			if(output == null) output = new at.dotpoint.math.vector.Vector2();
			output.set_x(a.get_x() * scalar);
			output.set_y(a.get_y() * scalar);
			return output;
		}
		
		static public function isEqual(a : at.dotpoint.math.vector.IVector2,b : at.dotpoint.math.vector.IVector2) : Boolean {
			if(!at.dotpoint.math.MathUtil.isEqual(a.get_x(),b.get_x())) return false;
			if(!at.dotpoint.math.MathUtil.isEqual(a.get_y(),b.get_y())) return false;
			return true;
		}
		
	}
}
