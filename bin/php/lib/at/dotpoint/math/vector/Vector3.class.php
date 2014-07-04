<?php

class at_dotpoint_math_vector_Vector3 implements at_dotpoint_math_vector_IVector3{
	public function __construct($x = null, $y = null, $z = null, $w = null) {
		if(!php_Boot::$skip_constructor) {
		if($w === null) {
			$w = 1;
		}
		if($z === null) {
			$z = 0;
		}
		if($y === null) {
			$y = 0;
		}
		if($x === null) {
			$x = 0;
		}
		$this->x = $x;
		$this->y = $y;
		$this->z = $z;
		$this->w = $w;
	}}
	public $x;
	public $y;
	public $z;
	public $w;
	public function hclone() {
		return new at_dotpoint_math_vector_Vector3($this->x, $this->y, $this->z, $this->w);
	}
	public function normalize() {
		$l = $this->length();
		if(_hx_equal($l, 0)) {
			return;
		}
		$k = 1. / $l;
		$this->x *= $k;
		$this->y *= $k;
		$this->z *= $k;
	}
	public function length() {
		return Math::sqrt($this->lengthSq());
	}
	public function lengthSq() {
		return $this->x * $this->x + $this->y * $this->y + $this->z * $this->z;
	}
	public function toArray($w = null) {
		if($w === null) {
			$w = false;
		}
		$output = new _hx_array(array());
		$output[0] = $this->x;
		$output[1] = $this->y;
		$output[2] = $this->z;
		if($w) {
			$output[3] = $this->w;
		}
		return $output;
	}
	public function getIndex($index) {
		switch($index) {
		case 0:{
			return $this->x;
		}break;
		case 1:{
			return $this->y;
		}break;
		case 2:{
			return $this->z;
		}break;
		case 3:{
			return $this->w;
		}break;
		default:{
			throw new HException("out of bounds");
		}break;
		}
	}
	public function setIndex($index, $value) {
		switch($index) {
		case 0:{
			$this->x = $value;
		}break;
		case 1:{
			$this->y = $value;
		}break;
		case 2:{
			$this->z = $value;
		}break;
		case 3:{
			$this->w = $value;
		}break;
		default:{
			throw new HException("out of bounds");
		}break;
		}
	}
	public function set($x, $y, $z, $w = null) {
		$this->x = $x;
		$this->y = $y;
		$this->z = $z;
		if($w !== null) {
			$this->w = $w;
		}
	}
	public function toString() {
		return "[Vector3;" . _hx_string_rec($this->x, "") . ", " . _hx_string_rec($this->y, "") . ", " . _hx_string_rec($this->z, "") . ", " . _hx_string_rec($this->w, "") . "]";
	}
	public function __call($m, $a) {
		if(isset($this->$m) && is_callable($this->$m))
			return call_user_func_array($this->$m, $a);
		else if(isset($this->__dynamics[$m]) && is_callable($this->__dynamics[$m]))
			return call_user_func_array($this->__dynamics[$m], $a);
		else if('toString' == $m)
			return $this->__toString();
		else
			throw new HException('Unable to call <'.$m.'>');
	}
	static function add($a, $b, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		}
		$output->x = $a->x + $b->x;
		$output->y = $a->y + $b->y;
		$output->z = $a->z + $b->z;
		return $output;
	}
	static function subtract($a, $b, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		}
		$output->x = $a->x - $b->x;
		$output->y = $a->y - $b->y;
		$output->z = $a->z - $b->z;
		return $output;
	}
	static function scale($a, $scalar, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		}
		$output->x = $a->x * $scalar;
		$output->y = $a->y * $scalar;
		$output->z = $a->z * $scalar;
		return $output;
	}
	static function cross($a, $b, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		}
		$output->x = $a->y * $b->z - $a->z * $b->y;
		$output->y = $a->z * $b->x - $a->x * $b->z;
		$output->z = $a->x * $b->y - $a->y * $b->x;
		return $output;
	}
	static function dot($a, $b) {
		return $a->x * $b->x + $a->y * $b->y + $a->z * $b->z;
	}
	static function multiplyMatrix($a, $b, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		}
		$x = $a->x;
		$y = $a->y;
		$z = $a->z;
		$w = $a->w;
		$output->x = $b->m11 * $x + $b->m12 * $y + $b->m13 * $z + $b->m14 * $w;
		$output->y = $b->m21 * $x + $b->m22 * $y + $b->m23 * $z + $b->m24 * $w;
		$output->z = $b->m31 * $x + $b->m32 * $y + $b->m33 * $z + $b->m34 * $w;
		$output->w = $b->m41 * $x + $b->m42 * $y + $b->m43 * $z + $b->m44 * $w;
		return $output;
	}
	static function isEqual($a, $b) {
		if(!at_dotpoint_math_vector_Vector3_0($a, $b)) {
			return false;
		}
		if(!at_dotpoint_math_vector_Vector3_1($a, $b)) {
			return false;
		}
		if(!at_dotpoint_math_vector_Vector3_2($a, $b)) {
			return false;
		}
		return true;
	}
	static function project($a, $b, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		}
		$l = $a->lengthSq();
		if(_hx_equal($l, 0)) {
			throw new HException("undefined result");
		}
		$d = at_dotpoint_math_vector_Vector3::dot($a, $b);
		$d_div = $d / $l;
		return at_dotpoint_math_vector_Vector3::scale($a, $d_div, $output);
	}
	static function orthoNormalize($vectors) {
		$_g1 = 0;
		$_g = $vectors->length;
		while($_g1 < $_g) {
			$i = $_g1++;
			$sum = new at_dotpoint_math_vector_Vector3(null, null, null, null);
			{
				$_g2 = 0;
				while($_g2 < $i) {
					$j = $_g2++;
					$projected = at_dotpoint_math_vector_Vector3::project($vectors[$i], $vectors[$j], null);
					at_dotpoint_math_vector_Vector3::add($sum, $projected, $sum);
					unset($projected,$j);
				}
				unset($_g2);
			}
			at_dotpoint_math_vector_Vector3::subtract($vectors[$i], $sum, $vectors[$i])->normalize();
			unset($sum,$i);
		}
	}
	function __toString() { return $this->toString(); }
}
function at_dotpoint_math_vector_Vector3_0(&$a, &$b) {
	{
		$a1 = $a->x;
		$b1 = $b->x;
		if($a1 > $b1) {
			return $a1 - $b1 < 1e-08;
		} else {
			return $b1 - $a1 < 1e-08;
		}
		unset($b1,$a1);
	}
}
function at_dotpoint_math_vector_Vector3_1(&$a, &$b) {
	{
		$a2 = $a->y;
		$b2 = $b->y;
		if($a2 > $b2) {
			return $a2 - $b2 < 1e-08;
		} else {
			return $b2 - $a2 < 1e-08;
		}
		unset($b2,$a2);
	}
}
function at_dotpoint_math_vector_Vector3_2(&$a, &$b) {
	{
		$a3 = $a->z;
		$b3 = $b->z;
		if($a3 > $b3) {
			return $a3 - $b3 < 1e-08;
		} else {
			return $b3 - $a3 < 1e-08;
		}
		unset($b3,$a3);
	}
}
