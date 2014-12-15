<?php

class at_dotpoint_math_vector_Vector2 implements at_dotpoint_math_vector_IVector2{
	public function __construct($x = null, $y = null) {
		if(!php_Boot::$skip_constructor) {
		if($y === null) {
			$y = 0;
		}
		if($x === null) {
			$x = 0;
		}
		$this->set_x($x);
		$this->set_y($y);
	}}
	public $x;
	public $y;
	public function hclone() {
		return new at_dotpoint_math_vector_Vector2($this->get_x(), $this->get_y());
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
	public function set($x, $y) {
		$this->set_x($x);
		$this->set_y($y);
	}
	public function copyFrom($vector) {
		$this->set_x($vector->get_x());
		$this->set_y($vector->get_y());
	}
	public function normalize() {
		$k = 1. / $this->length();
		{
			$_g = $this;
			$_g->set_x($_g->get_x() * $k);
		}
		{
			$_g1 = $this;
			$_g1->set_y($_g1->get_y() * $k);
		}
	}
	public function length() {
		return Math::sqrt($this->lengthSq());
	}
	public function lengthSq() {
		return $this->get_x() * $this->get_x() + $this->get_y() * $this->get_y();
	}
	public function toString() {
		return "[Vector2;" . _hx_string_rec($this->get_x(), "") . ", " . _hx_string_rec($this->get_y(), "") . "]";
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
			$output = new at_dotpoint_math_vector_Vector2(null, null);
		}
		$output->set_x($a->get_x() + $b->get_x());
		$output->set_y($a->get_y() + $b->get_y());
		return $output;
	}
	static function subtract($a, $b, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector2(null, null);
		}
		$output->set_x($a->get_x() - $b->get_x());
		$output->set_y($a->get_y() - $b->get_y());
		return $output;
	}
	static function scale($a, $scalar, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector2(null, null);
		}
		$output->set_x($a->get_x() * $scalar);
		$output->set_y($a->get_y() * $scalar);
		return $output;
	}
	static function isEqual($a, $b) {
		if(!at_dotpoint_math_vector_Vector2_0($a, $b)) {
			return false;
		}
		if(!at_dotpoint_math_vector_Vector2_1($a, $b)) {
			return false;
		}
		return true;
	}
	static $__properties__ = array("set_y" => "set_y","get_y" => "get_y","set_x" => "set_x","get_x" => "get_x");
	function __toString() { return $this->toString(); }
}
function at_dotpoint_math_vector_Vector2_0(&$a, &$b) {
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
function at_dotpoint_math_vector_Vector2_1(&$a, &$b) {
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
