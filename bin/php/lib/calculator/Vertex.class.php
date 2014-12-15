<?php

class calculator_Vertex implements at_dotpoint_math_vector_IVector2{
	public function __construct($coordinate) {
		if(!php_Boot::$skip_constructor) {
		if($coordinate === null) {
			$coordinate = new at_dotpoint_math_vector_Vector2(null, null);
		}
		$this->coordinate = $coordinate;
		$this->neighbors = new HList();
	}}
	public $coordinate;
	public $neighbors;
	public function get_x() {
		return $this->coordinate->get_x();
	}
	public function set_x($value) {
		return $this->coordinate->set_x($value);
	}
	public function get_y() {
		return $this->coordinate->get_y();
	}
	public function set_y($value) {
		return $this->coordinate->set_y($value);
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
	static $__properties__ = array("set_y" => "set_y","get_y" => "get_y","set_x" => "set_x","get_x" => "get_x");
	function __toString() { return 'calculator.Vertex'; }
}
