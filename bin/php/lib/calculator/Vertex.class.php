<?php

class calculator_Vertex extends at_dotpoint_math_vector_Vector2 {
	public function __construct($x = null, $y = null) {
		if(!php_Boot::$skip_constructor) {
		if($y === null) {
			$y = 0;
		}
		if($x === null) {
			$x = 0;
		}
		parent::__construct($x,$y);
		$this->neighbors = new HList();
	}}
	public $neighbors;
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
	function __toString() { return 'calculator.Vertex'; }
}
