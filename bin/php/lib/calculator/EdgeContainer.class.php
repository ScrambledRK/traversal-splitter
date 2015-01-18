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
			$index = $this->getIndex($a->get_x(), true);
			$this->vertical->insert($index * 2, $a);
			$this->vertical->insert($index * 2, $b);
		} else {
			$index1 = $this->getIndex($a->get_y(), false);
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
		$isVertical = Math::abs($dir->get_x()) < Math::abs($dir->get_y());
		if($isVertical) {
			$ystep = null;
			if($dir->get_y() < 0) {
				$ystep = -1;
			} else {
				$ystep = 1;
			}
			$hstart = $this->getIndex($start->get_y(), false) - 1;
			$hlength = $this->horizontal->length >> 1;
			while(($hstart += $ystep) >= 0 && $hstart <= $hlength) {
				$hindex = $hstart * 2;
				$a = $this->horizontal[$hindex];
				$b = $this->horizontal[$hindex + 1];
				if($a === $start || $b === $start) {
					continue;
				}
				if($start->get_x() >= $a->get_x() && $start->get_x() <= $b->get_x() || $start->get_x() >= $b->get_x() && $start->get_x() <= $a->get_x()) {
					return $this->insertSplit($start, $a, $b);
				}
				unset($hindex,$b,$a);
			}
		} else {
			$xstep = null;
			if($dir->get_x() < 0) {
				$xstep = -1;
			} else {
				$xstep = 1;
			}
			$vstart = $this->getIndex($start->get_x(), true) - 1;
			$vlength = $this->vertical->length >> 1;
			while(($vstart += $xstep) >= 0 && $vstart <= $vlength) {
				$vindex = $vstart * 2;
				$a1 = $this->vertical[$vindex];
				$b1 = $this->vertical[$vindex + 1];
				if($a1 === $start || $b1 === $start) {
					continue;
				}
				if($start->get_y() >= $a1->get_y() && $start->get_y() <= $b1->get_y() || $start->get_y() >= $b1->get_y() && $start->get_y() <= $a1->get_y()) {
					return $this->insertSplit($start, $a1, $b1);
				}
				unset($vindex,$b1,$a1);
			}
		}
		return null;
	}
	public function insertSplit($start, $a, $b) {
		$split = new calculator_Vertex(null);
		$split->index = Math::min($a->index, $b->index) + Math::min(1, Math::abs($b->index - $a->index)) * 0.5;
		if($this->isVertical($a, $b)) {
			$split->set_x($a->get_x());
			$split->set_y($start->get_y());
		} else {
			$split->set_x($start->get_x());
			$split->set_y($a->get_y());
		}
		$this->remove($a, $b);
		$this->insert($split, $start);
		$this->insert($split, $a);
		$this->insert($split, $b);
		$a->removeNeighbor($b);
		$b->removeNeighbor($a);
		$a->insertNeighbor($split);
		$b->insertNeighbor($split);
		$split->insertNeighbor($start);
		$split->insertNeighbor($a);
		$split->insertNeighbor($b);
		$start->insertNeighbor($split);
		return $split;
	}
	public function getIndex($value, $isVertical) {
		if($isVertical) {
			$vlength = $this->vertical->length >> 1;
			{
				$_g = 0;
				while($_g < $vlength) {
					$v = $_g++;
					if(_hx_array_get($this->vertical, $v * 2)->get_x() > $value) {
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
					if(_hx_array_get($this->horizontal, $h * 2)->get_y() > $value) {
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
		$a1 = $a->get_x();
		$b1 = $b->get_x();
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
