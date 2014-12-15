<?php

class converter_StringConverter implements IPolygonConverter{
	public function __construct($seperator = null) {
		if(!php_Boot::$skip_constructor) {
		if($seperator === null) {
			$seperator = " ";
		}
		$this->seperator = $seperator;
	}}
	public $seperator;
	public function convert($input) {
		$coordinates = new _hx_array(array());
		$splitted = _hx_explode($this->seperator, $input);
		$length = Std::int($splitted->length * 0.5);
		{
			$_g = 0;
			while($_g < $length) {
				$j = $_g++;
				$index = $j * 2;
				$point = new at_dotpoint_math_vector_Vector2(null, null);
				$point->set_x(Std::parseInt($splitted[$index]));
				$point->set_y(Std::parseInt($splitted[$index + 1]));
				$coordinates->push($point);
				unset($point,$j,$index);
			}
		}
		if($coordinates->length === 0) {
			throw new HException("input string does not contain parsable float or integer coordinates or does not use " . _hx_string_or_null($this->seperator) . " as seperator");
		}
		return $coordinates;
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
	function __toString() { return 'converter.StringConverter'; }
}
