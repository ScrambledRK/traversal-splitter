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
	public function calculate($input) {
		$input1 = $this->parseInput($input);
		$result = $this->calculator->calculate($input1);
		return $result;
	}
	public function parseInput($input) {
		$output = null;
		if(Std::is($input, _hx_qtype("String"))) {
			$output = _hx_deref(new converter_StringConverter(null))->convert($input);
		}
		if($output === null) {
			throw new HException("unable to convert given input " . Std::string($input));
		}
		return $output;
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
