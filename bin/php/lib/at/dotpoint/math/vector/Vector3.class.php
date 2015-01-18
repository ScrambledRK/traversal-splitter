<?php

class at_dotpoint_math_vector_Vector3 implements at_dotpoint_core_ICloneable, at_dotpoint_math_vector_IVector3{
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
		$this->set_x($x);
		$this->set_y($y);
		$this->set_z($z);
		$this->set_w($w);
	}}
	public $x;
	public $y;
	public $z;
	public $w;
	public function hclone($output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		}
		$output->set_x($this->get_x());
		$output->set_y($this->get_y());
		$output->set_z($this->get_z());
		$output->set_w($this->get_w());
		return $output;
	}
	public function get_x() {
		return $this->x;
	}
	public function set_x($value) {
		return $this->x = $value;
	}
	public function get_y() {
		return $this->y;
	}
	public function set_y($value) {
		return $this->y = $value;
	}
	public function get_z() {
		return $this->z;
	}
	public function set_z($value) {
		return $this->z = $value;
	}
	public function get_w() {
		return $this->w;
	}
	public function set_w($value) {
		return $this->w = $value;
	}
	public function set($x, $y, $z, $w = null) {
		$this->set_x($x);
		$this->set_y($y);
		$this->set_z($z);
		if($w !== null) {
			$this->set_w($w);
		}
	}
	public function normalize() {
		$l = $this->length();
		if(_hx_equal($l, 0)) {
			return;
		}
		$k = 1. / $l;
		{
			$_g = $this;
			$_g->set_x($_g->get_x() * $k);
		}
		{
			$_g1 = $this;
			$_g1->set_y($_g1->get_y() * $k);
		}
		{
			$_g2 = $this;
			$_g2->set_z($_g2->get_z() * $k);
		}
	}
	public function length() {
		return Math::sqrt($this->get_x() * $this->get_x() + $this->get_y() * $this->get_y() + $this->get_z() * $this->get_z());
	}
	public function lengthSq() {
		return $this->get_x() * $this->get_x() + $this->get_y() * $this->get_y() + $this->get_z() * $this->get_z();
	}
	public function toArray($w = null, $output = null) {
		if($w === null) {
			$w = false;
		}
		if($output !== null) {
			$output = new _hx_array(array());
		}
		$output[0] = $this->get_x();
		$output[1] = $this->get_y();
		$output[2] = $this->get_z();
		if($w) {
			$output[3] = $this->get_w();
		}
		return $output;
	}
	public function getIndex($index) {
		switch($index) {
		case 0:{
			return $this->get_x();
		}break;
		case 1:{
			return $this->get_y();
		}break;
		case 2:{
			return $this->get_z();
		}break;
		case 3:{
			return $this->get_w();
		}break;
		default:{
			throw new HException("out of bounds");
		}break;
		}
	}
	public function setIndex($index, $value) {
		switch($index) {
		case 0:{
			$this->set_x($value);
		}break;
		case 1:{
			$this->set_y($value);
		}break;
		case 2:{
			$this->set_z($value);
		}break;
		case 3:{
			$this->set_w($value);
		}break;
		default:{
			throw new HException("out of bounds");
		}break;
		}
	}
	public function toString() {
		return "[Vector3;" . _hx_string_rec($this->get_x(), "") . ", " . _hx_string_rec($this->get_y(), "") . ", " . _hx_string_rec($this->get_z(), "") . ", " . _hx_string_rec($this->get_w(), "") . "]";
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
		$output->set_x($a->get_x() + $b->get_x());
		$output->set_y($a->get_y() + $b->get_y());
		$output->set_z($a->get_z() + $b->get_z());
		return $output;
	}
	static function subtract($a, $b, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		}
		$output->set_x($a->get_x() - $b->get_x());
		$output->set_y($a->get_y() - $b->get_y());
		$output->set_z($a->get_z() - $b->get_z());
		return $output;
	}
	static function scale($a, $scalar, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		}
		$output->set_x($a->get_x() * $scalar);
		$output->set_y($a->get_y() * $scalar);
		$output->set_z($a->get_z() * $scalar);
		return $output;
	}
	static function cross($a, $b, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		}
		$output->set_x($a->get_y() * $b->get_z() - $a->get_z() * $b->get_y());
		$output->set_y($a->get_z() * $b->get_x() - $a->get_x() * $b->get_z());
		$output->set_z($a->get_x() * $b->get_y() - $a->get_y() * $b->get_x());
		return $output;
	}
	static function dot($a, $b) {
		return $a->get_x() * $b->get_x() + $a->get_y() * $b->get_y() + $a->get_z() * $b->get_z();
	}
	static function multiplyMatrix($a, $b, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		}
		$x = $a->get_x();
		$y = $a->get_y();
		$z = $a->get_z();
		$w = $a->get_w();
		$output->set_x($b->m11 * $x + $b->m12 * $y + $b->m13 * $z + $b->m14 * $w);
		$output->set_y($b->m21 * $x + $b->m22 * $y + $b->m23 * $z + $b->m24 * $w);
		$output->set_z($b->m31 * $x + $b->m32 * $y + $b->m33 * $z + $b->m34 * $w);
		$output->set_w($b->m41 * $x + $b->m42 * $y + $b->m43 * $z + $b->m44 * $w);
		return $output;
	}
	static function project($a, $b, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		}
		$l = $a->get_x() * $a->get_x() + $a->get_y() * $a->get_y() + $a->get_z() * $a->get_z();
		if(_hx_equal($l, 0)) {
			throw new HException("undefined result");
		}
		$d = at_dotpoint_math_vector_Vector3::dot($a, $b);
		$div = $d / $l;
		return at_dotpoint_math_vector_Vector3::scale($a, $div, $output);
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
	static $__properties__ = array("set_w" => "set_w","get_w" => "get_w","set_z" => "set_z","get_z" => "get_z","set_y" => "set_y","get_y" => "get_y","set_x" => "set_x","get_x" => "get_x");
	function __toString() { return $this->toString(); }
}
function at_dotpoint_math_vector_Vector3_0(&$a, &$b) {
	{
		$a1 = $a->get_x();
		$b1 = $b->get_x();
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
		$a2 = $a->get_y();
		$b2 = $b->get_y();
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
		$a3 = $a->get_z();
		$b3 = $b->get_z();
		if($a3 > $b3) {
			return $a3 - $b3 < 1e-08;
		} else {
			return $b3 - $a3 < 1e-08;
		}
		unset($b3,$a3);
	}
}
