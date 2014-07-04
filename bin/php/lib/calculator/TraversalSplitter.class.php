<?php

class calculator_TraversalSplitter implements IPartitionCalculator{
	public function __construct() {
		;
	}
	public $coordinates;
	public $splitters;
	public $edges;
	public $partitions;
	public function calculate($input) {
		$this->prepareInput($input);
		$this->split();
		$this->partition();
		return $this->prepareOutput();
	}
	public function prepareInput($input) {
		$this->coordinates = $this->parseInput($input);
		$this->traverse();
		$this->buildGraph();
	}
	public function parseInput($input) {
		$coordinates = new _hx_array(array());
		$length = Std::int($input->length * 0.5) - 1;
		{
			$_g = 0;
			while($_g < $length) {
				$j = $_g++;
				$index = $j * 2;
				$x = $input[$index];
				$y = $input[$index + 1];
				$vertex = new calculator_Vertex($x, $y);
				$coordinates->push($vertex);
				unset($y,$x,$vertex,$j,$index);
			}
		}
		return $coordinates;
	}
	public function traverse() {
		$clockwise = new _hx_array(array());
		$counterwise = new _hx_array(array());
		{
			$_g1 = 0;
			$_g = $this->coordinates->length;
			while($_g1 < $_g) {
				$v = $_g1++;
				$p1 = $this->coordinates[_hx_mod($v, $this->coordinates->length)];
				$p2 = $this->coordinates[_hx_mod(($v + 1), $this->coordinates->length)];
				$p3 = $this->coordinates[_hx_mod(($v + 2), $this->coordinates->length)];
				if($this->isClockwise($p1, $p2, $p3)) {
					$clockwise->push($p2);
				} else {
					$counterwise->push($p2);
				}
				unset($v,$p3,$p2,$p1);
			}
		}
		if($clockwise->length < $counterwise->length) {
			$this->coordinates->reverse();
			$this->splitters = $clockwise;
			$this->splitters->reverse();
		} else {
			$this->splitters = $counterwise;
		}
	}
	public function buildGraph() {
		$this->edges = new calculator_EdgeContainer();
		{
			$_g1 = 0;
			$_g = $this->coordinates->length;
			while($_g1 < $_g) {
				$v = $_g1++;
				$p1 = $this->coordinates[_hx_mod($v, $this->coordinates->length)];
				$p2 = $this->coordinates[_hx_mod(($v + 1), $this->coordinates->length)];
				$p3 = $this->coordinates[_hx_mod(($v + 2), $this->coordinates->length)];
				$p2->neighbors->add($p1);
				$p2->neighbors->add($p3);
				$this->edges->insert($p1, $p2);
				unset($v,$p3,$p2,$p1);
			}
		}
		null;
	}
	public function split() {
		$_g1 = 0;
		$_g = $this->splitters->length;
		while($_g1 < $_g) {
			$v = $_g1++;
			$current = $this->splitters[$v];
			$previous = $current->neighbors->first();
			$normal = $this->getNormal($current, $previous);
			$split = $this->edges->split($current, $normal);
			if($split === null) {
				throw new HException("split could not be resolved");
			}
			$this->coordinates->push($split);
			unset($v,$split,$previous,$normal,$current);
		}
	}
	public function partition() {
		$this->partitions = new _hx_array(array());
		while($this->coordinates->length > 0) {
			$start = $this->coordinates->pop();
			$current = $start;
			$previous = null;
			$next = null;
			$partition = new at_dotpoint_math_geom_Rectangle(null, null, null, null);
			do {
				$next = $this->selectCircleNode($current, $previous);
				if($next === null) {
					$partition = null;
					break;
				} else {
					$this->expandBounding($next, $partition);
				}
				$previous = $current;
				$current = $next;
			} while($current !== $start);
			if($partition !== null && $this->isUniquePartiton($partition)) {
				$this->partitions->push($partition);
			}
			unset($start,$previous,$partition,$next,$current);
		}
	}
	public function selectCircleNode($current, $previous) {
		if($previous === null) {
			$previous = $current;
		}
		$rotation = new _hx_array(array());
		$rotation[0] = new at_dotpoint_math_vector_Vector2(1, 0);
		$rotation[1] = new at_dotpoint_math_vector_Vector2(0, 1);
		$rotation[2] = new at_dotpoint_math_vector_Vector2(-1, 0);
		$rotation[3] = new at_dotpoint_math_vector_Vector2(0, -1);
		$direction = $this->getDirection($current, $previous);
		$rotationStart = -1;
		$rotationOffset = 1;
		{
			$_g1 = 0;
			$_g = $rotation->length;
			while($_g1 < $_g) {
				$r = $_g1++;
				if(at_dotpoint_math_vector_Vector2::isEqual($rotation[$r], $direction)) {
					$rotationStart = $r;
					break;
				}
				unset($r);
			}
		}
		{
			$_g11 = 0;
			$_g2 = $rotation->length;
			while($_g11 < $_g2) {
				$r1 = $_g11++;
				$index = $rotationStart + $rotationOffset + $r1;
				if($index < 0) {
					$index = $rotation->length - $index;
				}
				$desired = $rotation[_hx_mod($index, $rotation->length)];
				if(null == $current->neighbors) throw new HException('null iterable');
				$__hx__it = $current->neighbors->iterator();
				while($__hx__it->hasNext()) {
					$neighbor = $__hx__it->next();
					$direction1 = $this->getDirection($neighbor, $current);
					if(at_dotpoint_math_vector_Vector2::isEqual($direction1, $desired) && $neighbor !== $previous) {
						return $neighbor;
					}
					unset($direction1);
				}
				$rotationOffset = -1;
				unset($r1,$index,$desired);
			}
		}
		return null;
	}
	public function prepareOutput() {
		$output = new _hx_array(array());
		{
			$_g = 0;
			$_g1 = $this->partitions;
			while($_g < $_g1->length) {
				$area = $_g1[$_g];
				++$_g;
				$output->push(Std::int($area->position->x));
				$output->push(Std::int($area->position->y));
				$output->push(Std::int($area->size->x));
				$output->push(Std::int($area->size->y));
				unset($area);
			}
		}
		return $output;
	}
	public function isUniquePartiton($partition) {
		{
			$_g = 0;
			$_g1 = $this->partitions;
			while($_g < $_g1->length) {
				$area = $_g1[$_g];
				++$_g;
				if($area === $partition) {
					continue;
				}
				if(at_dotpoint_math_vector_Vector2::isEqual($partition->position->hclone(), $area->position->hclone()) && at_dotpoint_math_vector_Vector2::isEqual(at_dotpoint_math_vector_Vector2::add($partition->position, $partition->size, null), at_dotpoint_math_vector_Vector2::add($area->position, $area->size, null))) {
					return false;
				}
				unset($area);
			}
		}
		return true;
	}
	public function getNormal($current, $previous) {
		$delta = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		$delta->x = $current->x - $previous->x;
		$delta->y = $current->y - $previous->y;
		$normal = at_dotpoint_math_vector_Vector3::cross($delta, new at_dotpoint_math_vector_Vector3(0, 0, -1, null), null);
		$normal->normalize();
		return new at_dotpoint_math_vector_Vector2($normal->x, $normal->y);
	}
	public function getDirection($current, $previous) {
		$direction = at_dotpoint_math_vector_Vector2::subtract($current, $previous, null);
		$direction->normalize();
		$direction->x = Math::round($direction->x);
		$direction->y = Math::round($direction->y);
		return $direction;
	}
	public function isClockwise($a, $b, $c) {
		$p1 = new at_dotpoint_math_vector_Vector3($a->x, $a->y, 0, null);
		$p2 = new at_dotpoint_math_vector_Vector3($b->x, $b->y, 0, null);
		$p3 = new at_dotpoint_math_vector_Vector3($c->x, $c->y, 0, null);
		$sub1 = at_dotpoint_math_vector_Vector3::subtract($p2, $p1, new at_dotpoint_math_vector_Vector3(null, null, null, null));
		$sub2 = at_dotpoint_math_vector_Vector3::subtract($p3, $p1, new at_dotpoint_math_vector_Vector3(null, null, null, null));
		return at_dotpoint_math_vector_Vector3::cross($sub1, $sub2, null)->z > 0;
	}
	public function expandBounding($vertex, $bounding) {
		$v = _hx_equal($bounding->size->x, 0) && _hx_equal($bounding->size->y, 0) && _hx_equal($bounding->position->x, 0) && _hx_equal($bounding->position->y, 0);
		$x = $vertex->x;
		$y = $vertex->y;
		$nl = null;
		if($v) {
			$nl = $x;
		} else {
			$nl = Math::min($bounding->position->x, $x);
		}
		$nr = null;
		if($v) {
			$nr = $x;
		} else {
			$nr = Math::max($bounding->position->x + $bounding->size->x, $x);
		}
		$nt = null;
		if($v) {
			$nt = $y;
		} else {
			$nt = Math::min($bounding->position->y, $y);
		}
		$nb = null;
		if($v) {
			$nb = $y;
		} else {
			$nb = Math::max($bounding->position->y + $bounding->size->y, $y);
		}
		if($nl !== $bounding->position->x || $nr !== $bounding->position->x + $bounding->size->x || $nt !== $bounding->position->y || $nb !== $bounding->position->y + $bounding->size->y) {
			{
				{
					$value = $nr - $bounding->position->x;
					if($value < 0) {
						throw new HException("dimension below zero");
					}
					$bounding->size->x = $value;
				}
				$nr;
			}
			{
				{
					$_g = $bounding;
					{
						$value1 = $_g->size->x - ($nl - $bounding->position->x);
						if($value1 < 0) {
							throw new HException("dimension below zero");
						}
						$_g->size->x = $value1;
					}
				}
				$bounding->position->x = $nl;
				$nl;
			}
			{
				{
					$value2 = $nb - $bounding->position->y;
					if($value2 < 0) {
						throw new HException("dimension below zero");
					}
					$bounding->size->y = $value2;
				}
				$nb;
			}
			{
				{
					$_g1 = $bounding;
					{
						$value3 = $_g1->size->y - ($nt - $bounding->position->y);
						if($value3 < 0) {
							throw new HException("dimension below zero");
						}
						$_g1->size->y = $value3;
					}
				}
				$bounding->position->y = $nt;
				$nt;
			}
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
	function __toString() { return 'calculator.TraversalSplitter'; }
}
