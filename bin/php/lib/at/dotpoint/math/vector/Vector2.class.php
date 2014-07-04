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
		$this->x = $x;
		$this->y = $y;
	}}
	public $x;
	public $y;
	public function hclone() {
		return new at_dotpoint_math_vector_Vector2($this->x, $this->y);
	}
	public function set($x, $y) {
		$this->x = $x;
		$this->y = $y;
	}
	public function copyFrom($vector) {
		$this->x = $vector->x;
		$this->y = $vector->y;
	}
	public function normalize() {
		$k = 1. / $this->length();
		$this->x *= $k;
		$this->y *= $k;
	}
	public function length() {
		return Math::sqrt($this->lengthSq());
	}
	public function lengthSq() {
		return $this->x * $this->x + $this->y * $this->y;
	}
	public function toString() {
		return "[Vector2;" . _hx_string_rec($this->x, "") . ", " . _hx_string_rec($this->y, "") . "]";
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
		$output->x = $a->x + $b->x;
		$output->y = $a->y + $b->y;
		return $output;
	}
	static function subtract($a, $b, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector2(null, null);
		}
		$output->x = $a->x - $b->x;
		$output->y = $a->y - $b->y;
		return $output;
	}
	static function scale($a, $scalar, $output = null) {
		if($output === null) {
			$output = new at_dotpoint_math_vector_Vector2(null, null);
		}
		$output->x = $a->x * $scalar;
		$output->y = $a->y * $scalar;
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
	function __toString() { return $this->toString(); }
}
function at_dotpoint_math_vector_Vector2_0(&$a, &$b) {
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
function at_dotpoint_math_vector_Vector2_1(&$a, &$b) {
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
