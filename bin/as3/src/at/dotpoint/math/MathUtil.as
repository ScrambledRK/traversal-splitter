package at.dotpoint.math {
	public class MathUtil {
		static public var ZERO_TOLERANCE : Number = 1e-08;
		static public var RAD_DEG : Number = 57.29577951308232;
		static public var DEG_RAD : Number = 0.017453292519943295;
		static public var FLOAT_MAX : Number = 3.4028234663852886e+37;
		static public var FLOAT_MIN : Number = -3.4028234663852886e+37;
		static public function isEqual(a : Number,b : Number) : Boolean {
			if(a > b) return a - b < 1e-08;
			else return b - a < 1e-08;
			return false;
		}
		
		static public function getAngle(x1 : Number,y1 : Number,x2 : Number,y2 : Number) : Number {
			var dx : Number = x2 - x1;
			var dy : Number = y2 - y1;
			return Math.atan2(dy,dx);
		}
		
	}
}
