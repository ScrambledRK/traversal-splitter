package at.dotpoint.math.vector {
	import at.dotpoint.math.vector.IVector3;
	import at.dotpoint.core.ICloneable;
	import at.dotpoint.math.vector.IMatrix44;
	import at.dotpoint.math.MathUtil;
	import flash.Boot;
	public class Vector3 implements at.dotpoint.core.ICloneable, at.dotpoint.math.vector.IVector3{
		public function Vector3(x : Number = 0,y : Number = 0,z : Number = 0,w : Number = 1) : void { if( !flash.Boot.skip_constructor ) {
			this.set_x(x);
			this.set_y(y);
			this.set_z(z);
			this.set_w(w);
		}}
		
		public function get x() : Number { return get_x(); }
		public function set x( __v : Number ) : void { set_x(__v); }
		protected var $x : Number;
		public function get y() : Number { return get_y(); }
		public function set y( __v : Number ) : void { set_y(__v); }
		protected var $y : Number;
		public function get z() : Number { return get_z(); }
		public function set z( __v : Number ) : void { set_z(__v); }
		protected var $z : Number;
		public function get w() : Number { return get_w(); }
		public function set w( __v : Number ) : void { set_w(__v); }
		protected var $w : Number;
		public function clone(_tmp_output : * = null) : * {
			var output : at.dotpoint.math.vector.Vector3 = at.dotpoint.math.vector.Vector3(_tmp_output);
			if(output == null) output = new at.dotpoint.math.vector.Vector3();
			output.set_x(this.get_x());
			output.set_y(this.get_y());
			output.set_z(this.get_z());
			output.set_w(this.get_w());
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
		
		public function get_z() : Number {
			return this.$z;
		}
		
		public function set_z(value : Number) : Number {
			return this.$z = value;
		}
		
		public function get_w() : Number {
			return this.$w;
		}
		
		public function set_w(value : Number) : Number {
			return this.$w = value;
		}
		
		public function set(x : Number,y : Number,z : Number,w : * = null) : void {
			this.set_x(x);
			this.set_y(y);
			this.set_z(z);
			if(w != null) this.set_w(w);
		}
		
		public function normalize() : void {
			var l : Number = this.length();
			if(l == 0) return;
			var k : Number = 1. / l;
			{
				var _g : at.dotpoint.math.vector.Vector3 = this;
				_g.set_x(_g.get_x() * k);
			};
			{
				var _g1 : at.dotpoint.math.vector.Vector3 = this;
				_g1.set_y(_g1.get_y() * k);
			};
			{
				var _g2 : at.dotpoint.math.vector.Vector3 = this;
				_g2.set_z(_g2.get_z() * k);
			}
		}
		
		public function length() : Number {
			return Math.sqrt(this.get_x() * this.get_x() + this.get_y() * this.get_y() + this.get_z() * this.get_z());
		}
		
		public function lengthSq() : Number {
			return this.get_x() * this.get_x() + this.get_y() * this.get_y() + this.get_z() * this.get_z();
		}
		
		public function toArray(w : * = false,output : Array = null) : Array {
			if(w==null) w=false;
			if(output != null) output = new Array();
			output[0] = this.get_x();
			output[1] = this.get_y();
			output[2] = this.get_z();
			if(w) output[3] = this.get_w();
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
			case 2:
			return this.get_z();
			break;
			case 3:
			return this.get_w();
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
			case 2:
			this.set_z(value);
			break;
			case 3:
			this.set_w(value);
			break;
			default:
			throw "out of bounds";
			break;
			}
		}
		
		public function toString() : String {
			return "[Vector3;" + this.get_x() + ", " + this.get_y() + ", " + this.get_z() + ", " + this.get_w() + "]";
		}
		
		static public function add(a : at.dotpoint.math.vector.IVector3,b : at.dotpoint.math.vector.IVector3,output : * = null) : * {
			if(output == null) output = new at.dotpoint.math.vector.Vector3();
			output.set_x(a.get_x() + b.get_x());
			output.set_y(a.get_y() + b.get_y());
			output.set_z(a.get_z() + b.get_z());
			return output;
		}
		
		static public function subtract(a : at.dotpoint.math.vector.IVector3,b : at.dotpoint.math.vector.IVector3,output : * = null) : * {
			if(output == null) output = new at.dotpoint.math.vector.Vector3();
			output.set_x(a.get_x() - b.get_x());
			output.set_y(a.get_y() - b.get_y());
			output.set_z(a.get_z() - b.get_z());
			return output;
		}
		
		static public function scale(a : at.dotpoint.math.vector.IVector3,scalar : Number,output : * = null) : * {
			if(output == null) output = new at.dotpoint.math.vector.Vector3();
			output.set_x(a.get_x() * scalar);
			output.set_y(a.get_y() * scalar);
			output.set_z(a.get_z() * scalar);
			return output;
		}
		
		static public function cross(a : at.dotpoint.math.vector.IVector3,b : at.dotpoint.math.vector.IVector3,output : * = null) : * {
			if(output == null) output = new at.dotpoint.math.vector.Vector3();
			output.set_x(a.get_y() * b.get_z() - a.get_z() * b.get_y());
			output.set_y(a.get_z() * b.get_x() - a.get_x() * b.get_z());
			output.set_z(a.get_x() * b.get_y() - a.get_y() * b.get_x());
			return output;
		}
		
		static public function dot(a : at.dotpoint.math.vector.IVector3,b : at.dotpoint.math.vector.IVector3) : Number {
			return a.get_x() * b.get_x() + a.get_y() * b.get_y() + a.get_z() * b.get_z();
		}
		
		static public function multiplyMatrix(a : at.dotpoint.math.vector.IVector3,b : at.dotpoint.math.vector.IMatrix44,output : * = null) : * {
			if(output == null) output = new at.dotpoint.math.vector.Vector3();
			var x : Number = a.get_x();
			var y : Number = a.get_y();
			var z : Number = a.get_z();
			var w : Number = a.get_w();
			output.set_x(b["m11"] * x + b["m12"] * y + b["m13"] * z + b["m14"] * w);
			output.set_y(b["m21"] * x + b["m22"] * y + b["m23"] * z + b["m24"] * w);
			output.set_z(b["m31"] * x + b["m32"] * y + b["m33"] * z + b["m34"] * w);
			output.set_w(b["m41"] * x + b["m42"] * y + b["m43"] * z + b["m44"] * w);
			return output;
		}
		
		static public function project(a : at.dotpoint.math.vector.IVector3,b : at.dotpoint.math.vector.IVector3,output : * = null) : * {
			if(output == null) output = new at.dotpoint.math.vector.Vector3();
			var l : Number = a.get_x() * a.get_x() + a.get_y() * a.get_y() + a.get_z() * a.get_z();
			if(l == 0) throw "undefined result";
			var d : Number = at.dotpoint.math.vector.Vector3.dot(a,b);
			var div : Number = d / l;
			return at.dotpoint.math.vector.Vector3.scale(a,div,output);
		}
		
		static public function orthoNormalize(vectors : Array) : void {
			var _g1 : int = 0;
			var _g : int = vectors.length;
			while(_g1 < _g) {
				var i : int = _g1++;
				var sum : at.dotpoint.math.vector.Vector3 = new at.dotpoint.math.vector.Vector3();
				{
					var _g2 : int = 0;
					while(_g2 < i) {
						var j : int = _g2++;
						var projected : at.dotpoint.math.vector.Vector3 = at.dotpoint.math.vector.Vector3.project(vectors[i],vectors[j]);
						at.dotpoint.math.vector.Vector3.add(sum,projected,sum);
					}
				};
				at.dotpoint.math.vector.Vector3.subtract(vectors[i],sum,vectors[i]).normalize();
			}
		}
		
		static public function isEqual(a : at.dotpoint.math.vector.IVector3,b : at.dotpoint.math.vector.IVector3) : Boolean {
			if(!at.dotpoint.math.MathUtil.isEqual(a.get_x(),b.get_x())) return false;
			if(!at.dotpoint.math.MathUtil.isEqual(a.get_y(),b.get_y())) return false;
			if(!at.dotpoint.math.MathUtil.isEqual(a.get_z(),b.get_z())) return false;
			return true;
		}
		
	}
}
