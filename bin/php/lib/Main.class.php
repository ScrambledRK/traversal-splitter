<?php

class Main {
	public function __construct() {
		if(!php_Boot::$skip_constructor) {
		$this->initialize();
	}}
	public $calculator;
	public function initialize() {
		$this->calculator = new calculator_TraversalSplitter();
	}
	public function calculate($inputString) {
		$input = $this->parseInput($inputString);
		$result = $this->calculator->calculate($input);
		return $result;
	}
	public function parseInput($input) {
		$coordinates = new _hx_array(array());
		$splitted = _hx_explode(" ", $input);
		$length = Std::int($splitted->length * 0.5);
		{
			$_g = 0;
			while($_g < $length) {
				$j = $_g++;
				$index = $j * 2;
				$x = Std::parseInt($splitted[$index]);
				$y = Std::parseInt($splitted[$index + 1]);
				$coordinates->push($x);
				$coordinates->push($y);
				unset($y,$x,$j,$index);
			}
		}
		if($coordinates->length === 0) {
			throw new HException("input issue");
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
	static $instance;
	static function main() {
		Main::$instance = new Main();
	}
	function __toString() { return 'Main'; }
}
