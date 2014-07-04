<?php

class calculator_EdgeContainer {
	public function __construct() {
		if(!php_Boot::$skip_constructor) {
		$this->vertical = new _hx_array(array());
		$this->horizontal = new _hx_array(array());
	}}
	public $horizontal;
	public $vertical;
	public function insert($a, $b) {
		if($this->isVertical($a, $b)) {
			$index = $this->getIndex($a->x, true);
			$this->vertical->insert($index * 2, $a);
			$this->vertical->insert($index * 2, $b);
		} else {
			$index1 = $this->getIndex($a->y, false);
			$this->horizontal->insert($index1 * 2, $a);
			$this->horizontal->insert($index1 * 2, $b);
		}
	}
	public function remove($a, $b) {
		if($this->isVertical($a, $b)) {
			$this->vertical->remove($a);
			$this->vertical->remove($b);
		} else {
			$this->horizontal->remove($a);
			$this->horizontal->remove($b);
		}
	}
	public function split($start, $dir) {
		$isVertical = Math::abs($dir->x) < Math::abs($dir->y);
		if($isVertical) {
			$ystep = null;
			if($dir->y < 0) {
				$ystep = -1;
			} else {
				$ystep = 1;
			}
			$hstart = $this->getIndex($start->y, false) - 1;
			$hlength = $this->horizontal->length >> 1;
			while(($hstart += $ystep) >= 0 && $hstart <= $hlength) {
				$hindex = $hstart * 2;
				$a = $this->horizontal[$hindex];
				$b = $this->horizontal[$hindex + 1];
				if($a === $start || $b === $start) {
					continue;
				}
				if($start->x >= $a->x && $start->x <= $b->x || $start->x >= $b->x && $start->x <= $a->x) {
					return $this->insertSplit($start, $a, $b);
				}
				unset($hindex,$b,$a);
			}
		} else {
			$xstep = null;
			if($dir->x < 0) {
				$xstep = -1;
			} else {
				$xstep = 1;
			}
			$vstart = $this->getIndex($start->x, true) - 1;
			$vlength = $this->vertical->length >> 1;
			while(($vstart += $xstep) >= 0 && $vstart <= $vlength) {
				$vindex = $vstart * 2;
				$a1 = $this->vertical[$vindex];
				$b1 = $this->vertical[$vindex + 1];
				if($a1 === $start || $b1 === $start) {
					continue;
				}
				if($start->y >= $a1->y && $start->y <= $b1->y || $start->y >= $b1->y && $start->y <= $a1->y) {
					return $this->insertSplit($start, $a1, $b1);
				}
				unset($vindex,$b1,$a1);
			}
		}
		return null;
	}
	public function insertSplit($start, $a, $b) {
		$split = new calculator_Vertex(null, null);
		if($this->isVertical($a, $b)) {
			$split->x = $a->x;
			$split->y = $start->y;
		} else {
			$split->x = $start->x;
			$split->y = $a->y;
		}
		$this->remove($a, $b);
		$this->insert($split, $start);
		$this->insert($split, $a);
		$this->insert($split, $b);
		$a->neighbors->remove($b);
		$b->neighbors->remove($a);
		$a->neighbors->add($split);
		$b->neighbors->add($split);
		$split->neighbors->add($start);
		$split->neighbors->add($a);
		$split->neighbors->add($b);
		$start->neighbors->add($split);
		return $split;
	}
	public function getIndex($value, $isVertical) {
		if($isVertical) {
			$vlength = $this->vertical->length >> 1;
			{
				$_g = 0;
				while($_g < $vlength) {
					$v = $_g++;
					if(_hx_array_get($this->vertical, $v * 2)->x > $value) {
						return $v;
					}
					unset($v);
				}
			}
			return $vlength;
		} else {
			$hlength = $this->horizontal->length >> 1;
			{
				$_g1 = 0;
				while($_g1 < $hlength) {
					$h = $_g1++;
					if(_hx_array_get($this->horizontal, $h * 2)->y > $value) {
						return $h;
					}
					unset($h);
				}
			}
			return $hlength;
		}
		return -1;
	}
	public function isVertical($a, $b) {
		$a1 = $a->x;
		$b1 = $b->x;
		if($a1 > $b1) {
			return $a1 - $b1 < 1e-08;
		} else {
			return $b1 - $a1 < 1e-08;
		}
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
	function __toString() { return 'calculator.EdgeContainer'; }
}
