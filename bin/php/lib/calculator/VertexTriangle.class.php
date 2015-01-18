<?php

class calculator_VertexTriangle {
	public function __construct() {}
	public $p1;
	public $p2;
	public $p3;
	public function isClockwise($includeZero = null) {
		if(!php_Boot::$skip_constructor) {
		if($includeZero === null) {
			$includeZero = false;
		}
		if($this->p1 === null || $this->p2 === null || $this->p3 === null) {
			throw new HException("must set 3 vertex coordinates");
		}
		$v1 = new at_dotpoint_math_vector_Vector3($this->p1->coordinate->get_x(), $this->p1->coordinate->get_y(), 0, null);
		$v2 = new at_dotpoint_math_vector_Vector3($this->p2->coordinate->get_x(), $this->p2->coordinate->get_y(), 0, null);
		$v3 = new at_dotpoint_math_vector_Vector3($this->p3->coordinate->get_x(), $this->p3->coordinate->get_y(), 0, null);
		$sub1 = at_dotpoint_math_vector_Vector3::subtract($v2, $v1, new at_dotpoint_math_vector_Vector3(null, null, null, null));
		$sub2 = at_dotpoint_math_vector_Vector3::subtract($v3, $v1, new at_dotpoint_math_vector_Vector3(null, null, null, null));
		$cross = at_dotpoint_math_vector_Vector3::cross($sub1, $sub2, null);
		if($includeZero) {
			return $cross->get_z() >= 0;
		} else {
			return $cross->get_z() > 0;
		}
	}}
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
	static $instance;
	function __toString() { return 'calculator.VertexTriangle'; }
}
calculator_VertexTriangle::$instance = new calculator_VertexTriangle();
