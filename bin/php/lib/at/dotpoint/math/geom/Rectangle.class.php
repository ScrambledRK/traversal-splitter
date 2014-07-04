<?php

class at_dotpoint_math_geom_Rectangle {
	public function __construct($x = null, $y = null, $w = null, $h = null) {
		if(!php_Boot::$skip_constructor) {
		if($h === null) {
			$h = 0;
		}
		if($w === null) {
			$w = 0;
		}
		if($y === null) {
			$y = 0;
		}
		if($x === null) {
			$x = 0;
		}
		$this->position = new at_dotpoint_math_vector_Vector2($x, $y);
		$this->size = new at_dotpoint_math_vector_Vector2($w, $h);
	}}
	public $position;
	public $size;
	public function hclone() {
		return new at_dotpoint_math_geom_Rectangle($this->position->x, $this->position->y, $this->size->x, $this->size->y);
	}
	public function setZero() {
		$this->position->x = 0;
		$this->position->y = 0;
		$this->size->x = 0;
		$this->size->y = 0;
	}
	public function get_x() {
		return $this->position->x;
	}
	public function set_x($value) {
		return $this->position->x = $value;
	}
	public function get_y() {
		return $this->position->y;
	}
	public function set_y($value) {
		return $this->position->y = $value;
	}
	public function get_width() {
		return $this->size->x;
	}
	public function set_width($value) {
		if($value < 0) {
			throw new HException("dimension below zero");
		}
		return $this->size->x = $value;
	}
	public function get_height() {
		return $this->size->y;
	}
	public function set_height($value) {
		if($value < 0) {
			throw new HException("dimension below zero");
		}
		return $this->size->y = $value;
	}
	public function get_top() {
		return $this->position->y;
	}
	public function set_top($value) {
		{
			$_g = $this;
			{
				$value1 = $_g->size->y - ($value - $this->position->y);
				if($value1 < 0) {
					throw new HException("dimension below zero");
				}
				$_g->size->y = $value1;
			}
		}
		$this->position->y = $value;
		return $value;
	}
	public function get_bottom() {
		return $this->position->y + $this->size->y;
	}
	public function set_bottom($value) {
		{
			$value1 = $value - $this->position->y;
			if($value1 < 0) {
				throw new HException("dimension below zero");
			}
			$this->size->y = $value1;
		}
		return $value;
	}
	public function get_left() {
		return $this->position->x;
	}
	public function set_left($value) {
		{
			$_g = $this;
			{
				$value1 = $_g->size->x - ($value - $this->position->x);
				if($value1 < 0) {
					throw new HException("dimension below zero");
				}
				$_g->size->x = $value1;
			}
		}
		$this->position->x = $value;
		return $value;
	}
	public function get_right() {
		return $this->position->x + $this->size->x;
	}
	public function set_right($value) {
		{
			$value1 = $value - $this->position->x;
			if($value1 < 0) {
				throw new HException("dimension below zero");
			}
			$this->size->x = $value1;
		}
		return $value;
	}
	public function get_topLeft() {
		return $this->position->hclone();
	}
	public function set_topLeft($value) {
		{
			$value1 = $value->y;
			{
				$_g = $this;
				{
					$value2 = $_g->size->y - ($value1 - $this->position->y);
					if($value2 < 0) {
						throw new HException("dimension below zero");
					}
					$_g->size->y = $value2;
				}
			}
			$this->position->y = $value1;
			$value1;
		}
		{
			$value3 = $value->x;
			{
				$_g1 = $this;
				{
					$value4 = $_g1->size->x - ($value3 - $this->position->x);
					if($value4 < 0) {
						throw new HException("dimension below zero");
					}
					$_g1->size->x = $value4;
				}
			}
			$this->position->x = $value3;
			$value3;
		}
		return $value;
	}
	public function get_bottomRight() {
		return at_dotpoint_math_vector_Vector2::add($this->position, $this->size, null);
	}
	public function set_bottomRight($value) {
		{
			$value1 = $value->y;
			{
				$value2 = $value1 - $this->position->y;
				if($value2 < 0) {
					throw new HException("dimension below zero");
				}
				$this->size->y = $value2;
			}
			$value1;
		}
		{
			$value3 = $value->x;
			{
				$value4 = $value3 - $this->position->x;
				if($value4 < 0) {
					throw new HException("dimension below zero");
				}
				$this->size->x = $value4;
			}
			$value3;
		}
		return $value;
	}
	public function get_dimension() {
		return $this->size->hclone();
	}
	public function set_dimension($value) {
		$this->size->copyFrom($value);
		return $value;
	}
	public function isInside($x, $y) {
		if($x < $this->position->x) {
			return false;
		}
		if($y < $this->position->y) {
			return false;
		}
		if($x > $this->position->x + $this->size->x) {
			return false;
		}
		if($y > $this->position->y + $this->size->y) {
			return false;
		}
		return true;
	}
	public function toString() {
		return "x:" . _hx_string_rec($this->position->x, "") . " y:" . _hx_string_rec($this->position->y, "") . " w:" . _hx_string_rec($this->size->x, "") . " h:" . _hx_string_rec($this->size->y, "");
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
	static $__properties__ = array("set_dimension" => "set_dimension","get_dimension" => "get_dimension","set_bottomRight" => "set_bottomRight","get_bottomRight" => "get_bottomRight","set_topLeft" => "set_topLeft","get_topLeft" => "get_topLeft","set_right" => "set_right","get_right" => "get_right","set_left" => "set_left","get_left" => "get_left","set_bottom" => "set_bottom","get_bottom" => "get_bottom","set_top" => "set_top","get_top" => "get_top","set_height" => "set_height","get_height" => "get_height","set_width" => "set_width","get_width" => "get_width","set_y" => "set_y","get_y" => "get_y","set_x" => "set_x","get_x" => "get_x");
	function __toString() { return $this->toString(); }
}
