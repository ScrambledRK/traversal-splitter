<?php

class calculator_TraversalSplitter implements IPartitionCalculator{
	public function __construct() {}
	public $coordinates;
	public $splitters;
	public $edges;
	public $partitions;
	public function calculate($input) {
		if(!php_Boot::$skip_constructor) {
		$this->coordinates = new _hx_array(array());
		$this->edges = new calculator_EdgeContainer();
		$this->partitions = new _hx_array(array());
		$this->prepareInput($input);
		$this->split();
		$this->partitionate();
		return $this->partitions;
	}}
	public function prepareInput($input) {
		$this->toVertices($input);
		$this->sortClockwise();
		$this->buildGraph();
	}
	public function toVertices($input) {
		{
			$_g = 0;
			while($_g < $input->length) {
				$point = $input[$_g];
				++$_g;
				$this->coordinates->push(new calculator_Vertex($point));
				unset($point);
			}
		}
		$first = $this->coordinates[0];
		$last = $this->coordinates[$this->coordinates->length - 1];
		if(at_dotpoint_math_vector_Vector2::isEqual($first->coordinate, $last->coordinate)) {
			$this->coordinates->pop();
		}
	}
	public function sortClockwise() {
		$clockwise = new _hx_array(array());
		$counterwise = new _hx_array(array());
		{
			$_g1 = 0;
			$_g = $this->coordinates->length;
			while($_g1 < $_g) {
				$v = $_g1++;
				$triangle = $this->getTriangle($v, true);
				if($triangle->isClockwise(null)) {
					$clockwise->push($triangle->p2);
				} else {
					$counterwise->push($triangle->p2);
				}
				unset($v,$triangle);
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
		{
			$_g1 = 0;
			$_g = $this->coordinates->length;
			while($_g1 < $_g) {
				$v = $_g1++;
				$triangle = $this->getTriangle($v, true);
				$triangle->p2->insertNeighbor($triangle->p1);
				$triangle->p2->insertNeighbor($triangle->p3);
				$this->edges->insert($triangle->p1, $triangle->p2);
				unset($v,$triangle);
			}
		}
		null;
	}
	public function split() {
		$_g = 0;
		$_g1 = $this->splitters;
		while($_g < $_g1->length) {
			$vertex = $_g1[$_g];
			++$_g;
			$normal = $this->getNormal($vertex);
			$split = $this->edges->split($vertex, $normal);
			if($split === null) {
				throw new HException("split could not be resolved, check the input");
			}
			$this->coordinates->push($split);
			unset($vertex,$split,$normal);
		}
	}
	public function partitionate() {
		$_g = 0;
		$_g1 = $this->coordinates;
		while($_g < $_g1->length) {
			$start = $_g1[$_g];
			++$_g;
			$current = $start;
			$previous = null;
			$next = null;
			$partition = null;
			do {
				$next = $this->selectClockwiseVertex($current, $previous);
				if($next === null) {
					break;
				} else {
					if($partition === null) {
						$partition = new at_dotpoint_math_geom_Rectangle(null, null, null, null);
					}
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
	public function selectClockwiseVertex($current, $previous) {
		$iterator = null;
		$possible = null;
		if($previous === null) {
			$iterator = $current->neighbors->iterator();
			$previous = $current->neighbors[0];
		}
		while($previous !== null) {
			if(null == $current->neighbors) throw new HException('null iterable');
			$__hx__it = $current->neighbors->iterator();
			while($__hx__it->hasNext()) {
				unset($neighbor);
				$neighbor = $__hx__it->next();
				if($neighbor === $previous) {
					continue;
				}
				$triangle = calculator_VertexTriangle::$instance;
				$triangle->p1 = $previous;
				$triangle->p2 = $current;
				$triangle->p3 = $neighbor;
				if($triangle->isClockwise(null)) {
					return $neighbor;
				} else {
					if($triangle->isClockwise(true)) {
						$possible = $neighbor;
					}
				}
				unset($triangle);
			}
			if($possible !== null) {
				return $possible;
			}
			if($iterator === null || !$iterator->hasNext()) {
				break;
			}
			$previous = $iterator->next();
		}
		return null;
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
				if(at_dotpoint_math_vector_Vector2::isEqual($partition->position->hclone(null), $area->position->hclone(null)) && at_dotpoint_math_vector_Vector2::isEqual(at_dotpoint_math_vector_Vector2::add($partition->position, $partition->size, null), at_dotpoint_math_vector_Vector2::add($area->position, $area->size, null))) {
					return false;
				}
				unset($area);
			}
		}
		return true;
	}
	public function getTriangle($index, $pool = null) {
		if($pool === null) {
			$pool = false;
		}
		$p1 = $this->coordinates[_hx_mod($index, $this->coordinates->length)];
		$p2 = $this->coordinates[_hx_mod(($index + 1), $this->coordinates->length)];
		$p3 = $this->coordinates[_hx_mod(($index + 2), $this->coordinates->length)];
		$triangle = null;
		if($pool) {
			$triangle = calculator_VertexTriangle::$instance;
		} else {
			$triangle = new calculator_VertexTriangle();
		}
		$triangle->p1 = $p1;
		$triangle->p2 = $p2;
		$triangle->p3 = $p3;
		return $triangle;
	}
	public function getNormal($current) {
		$previous = $current->neighbors[0];
		$delta = new at_dotpoint_math_vector_Vector3(null, null, null, null);
		$delta->set_x($current->get_x() - $previous->get_x());
		$delta->set_y($current->get_y() - $previous->get_y());
		$normal = at_dotpoint_math_vector_Vector3::cross($delta, new at_dotpoint_math_vector_Vector3(0, 0, -1, null), null);
		$normal->normalize();
		return new at_dotpoint_math_vector_Vector2($normal->get_x(), $normal->get_y());
	}
	public function expandBounding($vertex, $bounding) {
		$v = _hx_equal($bounding->size->get_x(), 0) && _hx_equal($bounding->size->get_y(), 0) && _hx_equal($bounding->position->get_x(), 0) && _hx_equal($bounding->position->get_y(), 0);
		$x = $vertex->get_x();
		$y = $vertex->get_y();
		$nl = null;
		if($v) {
			$nl = $x;
		} else {
			$nl = Math::min($bounding->position->get_x(), $x);
		}
		$nr = null;
		if($v) {
			$nr = $x;
		} else {
			$nr = Math::max($bounding->position->get_x() + $bounding->size->get_x(), $x);
		}
		$nt = null;
		if($v) {
			$nt = $y;
		} else {
			$nt = Math::min($bounding->position->get_y(), $y);
		}
		$nb = null;
		if($v) {
			$nb = $y;
		} else {
			$nb = Math::max($bounding->position->get_y() + $bounding->size->get_y(), $y);
		}
		if($nl !== $bounding->position->get_x() || $nr !== $bounding->position->get_x() + $bounding->size->get_x() || $nt !== $bounding->position->get_y() || $nb !== $bounding->position->get_y() + $bounding->size->get_y()) {
			{
				{
					$value = $nr - $bounding->position->get_x();
					if($value < 0) {
						throw new HException("dimension below zero");
					}
					$bounding->size->set_x($value);
				}
				$nr;
			}
			{
				{
					$_g = $bounding;
					{
						$value1 = $_g->size->get_x() - ($nl - $bounding->position->get_x());
						if($value1 < 0) {
							throw new HException("dimension below zero");
						}
						$_g->size->set_x($value1);
					}
				}
				$bounding->position->set_x($nl);
				$nl;
			}
			{
				{
					$value2 = $nb - $bounding->position->get_y();
					if($value2 < 0) {
						throw new HException("dimension below zero");
					}
					$bounding->size->set_y($value2);
				}
				$nb;
			}
			{
				{
					$_g1 = $bounding;
					{
						$value3 = $_g1->size->get_y() - ($nt - $bounding->position->get_y());
						if($value3 < 0) {
							throw new HException("dimension below zero");
						}
						$_g1->size->set_y($value3);
					}
				}
				$bounding->position->set_y($nt);
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
