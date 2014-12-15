<?php

class Math {
	public function __construct(){}
	static $PI;
	static $NaN;
	static $POSITIVE_INFINITY;
	static $NEGATIVE_INFINITY;
	static function abs($v) {
		return abs($v);
	}
	static function min($a, $b) {
		if(!Math::isNaN($a)) {
			return min($a, $b);
		} else {
			return Math::$NaN;
		}
	}
	static function max($a, $b) {
		if(!Math::isNaN($b)) {
			return max($a, $b);
		} else {
			return Math::$NaN;
		}
	}
	static function atan2($y, $x) {
		return atan2($y, $x);
	}
	static function sqrt($v) {
		return sqrt($v);
	}
	static function isNaN($f) {
		return is_nan($f);
	}
	function __toString() { return 'Math'; }
}
{
	Math::$PI = M_PI;
	Math::$NaN = acos(1.01);
	Math::$NEGATIVE_INFINITY = log(0);
	Math::$POSITIVE_INFINITY = -Math::$NEGATIVE_INFINITY;
}
