<?php

class at_dotpoint_math_MathUtil {
	public function __construct(){}
	static $ZERO_TOLERANCE = 1e-08;
	static $RAD_DEG = 57.29577951308232;
	static $DEG_RAD = 0.017453292519943295;
	static $FLOAT_MAX = 3.4028234663852886e+37;
	static $FLOAT_MIN = -3.4028234663852886e+37;
	static function isEqual($a, $b) {
		if($a > $b) {
			return $a - $b < 1e-08;
		} else {
			return $b - $a < 1e-08;
		}
	}
	static function getAngle($x1, $y1, $x2, $y2) {
		$dx = $x2 - $x1;
		$dy = $y2 - $y1;
		return Math::atan2($dy, $dx);
	}
	function __toString() { return 'at.dotpoint.math.MathUtil'; }
}
