package at.dotpoint.math.geom {
	import at.dotpoint.math.vector.Vector2;
	import flash.Boot;
	public class Rectangle {
		public function Rectangle(x : Number = 0,y : Number = 0,w : Number = 0,h : Number = 0) : void { if( !flash.Boot.skip_constructor ) {
			this.position = new at.dotpoint.math.vector.Vector2(x,y);
			this.size = new at.dotpoint.math.vector.Vector2(w,h);
		}}
		
		public var position : at.dotpoint.math.vector.Vector2;
		public var size : at.dotpoint.math.vector.Vector2;
		public function get x() : Number { return get_x(); }
		public function set x( __v : Number ) : void { set_x(__v); }
		protected var $x : Number;
		public function get y() : Number { return get_y(); }
		public function set y( __v : Number ) : void { set_y(__v); }
		protected var $y : Number;
		public function get width() : Number { return get_width(); }
		public function set width( __v : Number ) : void { set_width(__v); }
		protected var $width : Number;
		public function get height() : Number { return get_height(); }
		public function set height( __v : Number ) : void { set_height(__v); }
		protected var $height : Number;
		public function get top() : Number { return get_top(); }
		public function set top( __v : Number ) : void { set_top(__v); }
		protected var $top : Number;
		public function get bottom() : Number { return get_bottom(); }
		public function set bottom( __v : Number ) : void { set_bottom(__v); }
		protected var $bottom : Number;
		public function get left() : Number { return get_left(); }
		public function set left( __v : Number ) : void { set_left(__v); }
		protected var $left : Number;
		public function get right() : Number { return get_right(); }
		public function set right( __v : Number ) : void { set_right(__v); }
		protected var $right : Number;
		public function get topLeft() : at.dotpoint.math.vector.Vector2 { return get_topLeft(); }
		public function set topLeft( __v : at.dotpoint.math.vector.Vector2 ) : void { set_topLeft(__v); }
		protected var $topLeft : at.dotpoint.math.vector.Vector2;
		public function get bottomRight() : at.dotpoint.math.vector.Vector2 { return get_bottomRight(); }
		public function set bottomRight( __v : at.dotpoint.math.vector.Vector2 ) : void { set_bottomRight(__v); }
		protected var $bottomRight : at.dotpoint.math.vector.Vector2;
		public function get dimension() : at.dotpoint.math.vector.Vector2 { return get_dimension(); }
		public function set dimension( __v : at.dotpoint.math.vector.Vector2 ) : void { set_dimension(__v); }
		protected var $dimension : at.dotpoint.math.vector.Vector2;
		public function clone() : at.dotpoint.math.geom.Rectangle {
			return new at.dotpoint.math.geom.Rectangle(this.get_x(),this.get_y(),this.get_width(),this.get_height());
		}
		
		public function setZero() : void {
			this.position.set_x(0);
			this.position.set_y(0);
			this.size.set_x(0);
			this.size.set_y(0);
		}
		
		public function get_x() : Number {
			return this.position.get_x();
		}
		
		public function set_x(value : Number) : Number {
			return this.position.set_x(value);
		}
		
		public function get_y() : Number {
			return this.position.get_y();
		}
		
		public function set_y(value : Number) : Number {
			return this.position.set_y(value);
		}
		
		public function get_width() : Number {
			return this.size.get_x();
		}
		
		public function set_width(value : Number) : Number {
			if(value < 0) throw "dimension below zero";
			return this.size.set_x(value);
		}
		
		public function get_height() : Number {
			return this.size.get_y();
		}
		
		public function set_height(value : Number) : Number {
			if(value < 0) throw "dimension below zero";
			return this.size.set_y(value);
		}
		
		public function get_top() : Number {
			return this.get_y();
		}
		
		public function set_top(value : Number) : Number {
			{
				var _g : at.dotpoint.math.geom.Rectangle = this;
				_g.set_height(_g.get_height() - (value - this.get_y()));
			};
			this.set_y(value);
			return value;
		}
		
		public function get_bottom() : Number {
			return this.get_y() + this.get_height();
		}
		
		public function set_bottom(value : Number) : Number {
			this.set_height(value - this.get_y());
			return value;
		}
		
		public function get_left() : Number {
			return this.get_x();
		}
		
		public function set_left(value : Number) : Number {
			{
				var _g : at.dotpoint.math.geom.Rectangle = this;
				_g.set_width(_g.get_width() - (value - this.get_x()));
			};
			this.set_x(value);
			return value;
		}
		
		public function get_right() : Number {
			return this.get_x() + this.get_width();
		}
		
		public function set_right(value : Number) : Number {
			this.set_width(value - this.get_x());
			return value;
		}
		
		public function get_topLeft() : at.dotpoint.math.vector.Vector2 {
			return this.position.clone();
		}
		
		public function set_topLeft(value : at.dotpoint.math.vector.Vector2) : at.dotpoint.math.vector.Vector2 {
			this.set_top(value.get_y());
			this.set_left(value.get_x());
			return value;
		}
		
		public function get_bottomRight() : at.dotpoint.math.vector.Vector2 {
			return at.dotpoint.math.vector.Vector2.add(this.position,this.size);
		}
		
		public function set_bottomRight(value : at.dotpoint.math.vector.Vector2) : at.dotpoint.math.vector.Vector2 {
			this.set_bottom(value.get_y());
			this.set_right(value.get_x());
			return value;
		}
		
		public function get_dimension() : at.dotpoint.math.vector.Vector2 {
			return this.size.clone();
		}
		
		public function set_dimension(value : at.dotpoint.math.vector.Vector2) : at.dotpoint.math.vector.Vector2 {
			this.size.set(value.get_x(),value.get_y());
			return value;
		}
		
		public function isInside(x : int,y : int) : Boolean {
			if(x < this.get_left()) return false;
			if(y < this.get_top()) return false;
			if(x > this.get_right()) return false;
			if(y > this.get_bottom()) return false;
			return true;
		}
		
		public function toString() : String {
			return "x:" + this.get_x() + " y:" + this.get_y() + " w:" + this.get_width() + " h:" + this.get_height();
		}
		
	}
}
