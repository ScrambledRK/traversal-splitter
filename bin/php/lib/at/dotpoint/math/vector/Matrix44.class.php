<?php

class at_dotpoint_math_vector_Matrix44 implements at_dotpoint_math_vector_IMatrix44{
	public function __construct($m = null) {
		if(!php_Boot::$skip_constructor) {
		if($m !== null) {
			$this->set44($m);
		} else {
			$this->toIdentity();
		}
	}}
	public $m11;
	public $m12;
	public $m13;
	public $m14;
	public $m21;
	public $m22;
	public $m23;
	public $m24;
	public $m31;
	public $m32;
	public $m33;
	public $m34;
	public $m41;
	public $m42;
	public $m43;
	public $m44;
	public function hclone() {
		return new at_dotpoint_math_vector_Matrix44($this);
	}
	public function set44($m) {
		$this->m11 = $m->m11;
		$this->m12 = $m->m12;
		$this->m13 = $m->m13;
		$this->m14 = $m->m14;
		$this->m21 = $m->m21;
		$this->m22 = $m->m22;
		$this->m23 = $m->m23;
		$this->m24 = $m->m24;
		$this->m31 = $m->m31;
		$this->m32 = $m->m32;
		$this->m33 = $m->m33;
		$this->m34 = $m->m34;
		$this->m41 = $m->m41;
		$this->m42 = $m->m42;
		$this->m43 = $m->m43;
		$this->m44 = $m->m44;
	}
	public function set33($m) {
		$this->m11 = $m->m11;
		$this->m12 = $m->m12;
		$this->m13 = $m->m13;
		$this->m14 = 0;
		$this->m21 = $m->m21;
		$this->m22 = $m->m22;
		$this->m23 = $m->m23;
		$this->m24 = 0;
		$this->m31 = $m->m31;
		$this->m32 = $m->m32;
		$this->m33 = $m->m33;
		$this->m34 = 0;
		$this->m41 = 0;
		$this->m42 = 0;
		$this->m43 = 0;
		$this->m44 = 1;
	}
	public function toIdentity() {
		$this->m11 = 1;
		$this->m12 = 0;
		$this->m13 = 0;
		$this->m14 = 0;
		$this->m21 = 0;
		$this->m22 = 1;
		$this->m23 = 0;
		$this->m24 = 0;
		$this->m31 = 0;
		$this->m32 = 0;
		$this->m33 = 1;
		$this->m34 = 0;
		$this->m41 = 0;
		$this->m42 = 0;
		$this->m43 = 0;
		$this->m44 = 1;
	}
	public function transpose() {
		$t = null;
		$t = $this->m21;
		$this->m21 = $this->m12;
		$this->m12 = $t;
		$t = $this->m31;
		$this->m31 = $this->m13;
		$this->m13 = $t;
		$t = $this->m32;
		$this->m32 = $this->m23;
		$this->m23 = $t;
		$t = $this->m41;
		$this->m41 = $this->m14;
		$this->m14 = $t;
		$t = $this->m42;
		$this->m42 = $this->m24;
		$this->m24 = $t;
		$t = $this->m43;
		$this->m43 = $this->m34;
		$this->m34 = $t;
	}
	public function determinant() {
		return ($this->m11 * $this->m22 - $this->m21 * $this->m12) * ($this->m33 * $this->m44 - $this->m43 * $this->m34) - ($this->m11 * $this->m32 - $this->m31 * $this->m12) * ($this->m23 * $this->m44 - $this->m43 * $this->m24) + ($this->m11 * $this->m42 - $this->m41 * $this->m12) * ($this->m23 * $this->m34 - $this->m33 * $this->m24) + ($this->m21 * $this->m32 - $this->m31 * $this->m22) * ($this->m13 * $this->m44 - $this->m43 * $this->m14) - ($this->m21 * $this->m42 - $this->m41 * $this->m22) * ($this->m13 * $this->m34 - $this->m33 * $this->m14) + ($this->m31 * $this->m42 - $this->m41 * $this->m32) * ($this->m13 * $this->m24 - $this->m23 * $this->m14);
	}
	public function inverse() {
		$d = $this->determinant();
		if(Math::abs($d) < 1e-08) {
			return;
		}
		$d = 1 / $d;
		$m11 = $this->m11;
		$m21 = $this->m21;
		$m31 = $this->m31;
		$m41 = $this->m41;
		$m12 = $this->m12;
		$m22 = $this->m22;
		$m32 = $this->m32;
		$m42 = $this->m42;
		$m13 = $this->m13;
		$m23 = $this->m23;
		$m33 = $this->m33;
		$m43 = $this->m43;
		$m14 = $this->m14;
		$m24 = $this->m24;
		$m34 = $this->m34;
		$m44 = $this->m44;
		$this->m11 = $d * ($m22 * ($m33 * $m44 - $m43 * $m34) - $m32 * ($m23 * $m44 - $m43 * $m24) + $m42 * ($m23 * $m34 - $m33 * $m24));
		$this->m12 = -$d * ($m12 * ($m33 * $m44 - $m43 * $m34) - $m32 * ($m13 * $m44 - $m43 * $m14) + $m42 * ($m13 * $m34 - $m33 * $m14));
		$this->m13 = $d * ($m12 * ($m23 * $m44 - $m43 * $m24) - $m22 * ($m13 * $m44 - $m43 * $m14) + $m42 * ($m13 * $m24 - $m23 * $m14));
		$this->m14 = -$d * ($m12 * ($m23 * $m34 - $m33 * $m24) - $m22 * ($m13 * $m34 - $m33 * $m14) + $m32 * ($m13 * $m24 - $m23 * $m14));
		$this->m21 = -$d * ($m21 * ($m33 * $m44 - $m43 * $m34) - $m31 * ($m23 * $m44 - $m43 * $m24) + $m41 * ($m23 * $m34 - $m33 * $m24));
		$this->m22 = $d * ($m11 * ($m33 * $m44 - $m43 * $m34) - $m31 * ($m13 * $m44 - $m43 * $m14) + $m41 * ($m13 * $m34 - $m33 * $m14));
		$this->m23 = -$d * ($m11 * ($m23 * $m44 - $m43 * $m24) - $m21 * ($m13 * $m44 - $m43 * $m14) + $m41 * ($m13 * $m24 - $m23 * $m14));
		$this->m24 = $d * ($m11 * ($m23 * $m34 - $m33 * $m24) - $m21 * ($m13 * $m34 - $m33 * $m14) + $m31 * ($m13 * $m24 - $m23 * $m14));
		$this->m31 = $d * ($m21 * ($m32 * $m44 - $m42 * $m34) - $m31 * ($m22 * $m44 - $m42 * $m24) + $m41 * ($m22 * $m34 - $m32 * $m24));
		$this->m32 = -$d * ($m11 * ($m32 * $m44 - $m42 * $m34) - $m31 * ($m12 * $m44 - $m42 * $m14) + $m41 * ($m12 * $m34 - $m32 * $m14));
		$this->m33 = $d * ($m11 * ($m22 * $m44 - $m42 * $m24) - $m21 * ($m12 * $m44 - $m42 * $m14) + $m41 * ($m12 * $m24 - $m22 * $m14));
		$this->m34 = -$d * ($m11 * ($m22 * $m34 - $m32 * $m24) - $m21 * ($m12 * $m34 - $m32 * $m14) + $m31 * ($m12 * $m24 - $m22 * $m14));
		$this->m41 = -$d * ($m21 * ($m32 * $m43 - $m42 * $m33) - $m31 * ($m22 * $m43 - $m42 * $m23) + $m41 * ($m22 * $m33 - $m32 * $m23));
		$this->m42 = $d * ($m11 * ($m32 * $m43 - $m42 * $m33) - $m31 * ($m12 * $m43 - $m42 * $m13) + $m41 * ($m12 * $m33 - $m32 * $m13));
		$this->m43 = -$d * ($m11 * ($m22 * $m43 - $m42 * $m23) - $m21 * ($m12 * $m43 - $m42 * $m13) + $m41 * ($m12 * $m23 - $m22 * $m13));
		$this->m44 = $d * ($m11 * ($m22 * $m33 - $m32 * $m23) - $m21 * ($m12 * $m33 - $m32 * $m13) + $m31 * ($m12 * $m23 - $m22 * $m13));
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
	static function add($a, $b, $output) {
		$output->m11 = $a->m11 + $b->m11;
		$output->m12 = $a->m12 + $b->m12;
		$output->m13 = $a->m13 + $b->m13;
		$output->m14 = $a->m14 + $b->m14;
		$output->m21 = $a->m21 + $b->m21;
		$output->m22 = $a->m22 + $b->m22;
		$output->m23 = $a->m23 + $b->m23;
		$output->m24 = $a->m24 + $b->m24;
		$output->m31 = $a->m31 + $b->m31;
		$output->m32 = $a->m32 + $b->m32;
		$output->m33 = $a->m33 + $b->m33;
		$output->m34 = $a->m34 + $b->m34;
		$output->m41 = $a->m41 + $b->m41;
		$output->m42 = $a->m42 + $b->m42;
		$output->m43 = $a->m43 + $b->m43;
		$output->m44 = $a->m44 + $b->m44;
		return $output;
	}
	static function subtract($a, $b, $output) {
		$output->m11 = $a->m11 - $b->m11;
		$output->m12 = $a->m12 - $b->m12;
		$output->m13 = $a->m13 - $b->m13;
		$output->m14 = $a->m14 - $b->m14;
		$output->m21 = $a->m21 - $b->m21;
		$output->m22 = $a->m22 - $b->m22;
		$output->m23 = $a->m23 - $b->m23;
		$output->m24 = $a->m24 - $b->m24;
		$output->m31 = $a->m31 - $b->m31;
		$output->m32 = $a->m32 - $b->m32;
		$output->m33 = $a->m33 - $b->m33;
		$output->m34 = $a->m34 - $b->m34;
		$output->m41 = $a->m41 - $b->m41;
		$output->m42 = $a->m42 - $b->m42;
		$output->m43 = $a->m43 - $b->m43;
		$output->m44 = $a->m44 - $b->m44;
		return $output;
	}
	static function scale($a, $scalar, $output) {
		$output->m11 = $a->m11 * $scalar;
		$output->m12 = $a->m12 * $scalar;
		$output->m13 = $a->m13 * $scalar;
		$output->m14 = $a->m14 * $scalar;
		$output->m21 = $a->m21 * $scalar;
		$output->m22 = $a->m22 * $scalar;
		$output->m23 = $a->m23 * $scalar;
		$output->m24 = $a->m24 * $scalar;
		$output->m31 = $a->m31 * $scalar;
		$output->m32 = $a->m32 * $scalar;
		$output->m33 = $a->m33 * $scalar;
		$output->m34 = $a->m34 * $scalar;
		$output->m41 = $a->m41 * $scalar;
		$output->m42 = $a->m42 * $scalar;
		$output->m43 = $a->m43 * $scalar;
		$output->m44 = $a->m44 * $scalar;
		return $output;
	}
	static function multiply($a, $b, $output) {
		$b11 = $b->m11;
		$b12 = $b->m12;
		$b13 = $b->m13;
		$b14 = $b->m14;
		$b21 = $b->m21;
		$b22 = $b->m22;
		$b23 = $b->m23;
		$b24 = $b->m24;
		$b31 = $b->m31;
		$b32 = $b->m32;
		$b33 = $b->m33;
		$b34 = $b->m34;
		$b41 = $b->m41;
		$b42 = $b->m42;
		$b43 = $b->m43;
		$b44 = $b->m44;
		$t1 = null;
		$t2 = null;
		$t3 = null;
		$t4 = null;
		$t1 = $a->m11;
		$t2 = $a->m12;
		$t3 = $a->m13;
		$t4 = $a->m14;
		$output->m11 = $t1 * $b11 + $t2 * $b21 + $t3 * $b31 + $t4 * $b41;
		$output->m12 = $t1 * $b12 + $t2 * $b22 + $t3 * $b32 + $t4 * $b42;
		$output->m13 = $t1 * $b13 + $t2 * $b23 + $t3 * $b33 + $t4 * $b43;
		$output->m14 = $t1 * $b14 + $t2 * $b24 + $t3 * $b34 + $t4 * $b44;
		$t1 = $a->m21;
		$t2 = $a->m22;
		$t3 = $a->m23;
		$t4 = $a->m24;
		$output->m21 = $t1 * $b11 + $t2 * $b21 + $t3 * $b31 + $t4 * $b41;
		$output->m22 = $t1 * $b12 + $t2 * $b22 + $t3 * $b32 + $t4 * $b42;
		$output->m23 = $t1 * $b13 + $t2 * $b23 + $t3 * $b33 + $t4 * $b43;
		$output->m24 = $t1 * $b14 + $t2 * $b24 + $t3 * $b34 + $t4 * $b44;
		$t1 = $a->m31;
		$t2 = $a->m32;
		$t3 = $a->m33;
		$t4 = $a->m34;
		$output->m31 = $t1 * $b11 + $t2 * $b21 + $t3 * $b31 + $t4 * $b41;
		$output->m32 = $t1 * $b12 + $t2 * $b22 + $t3 * $b32 + $t4 * $b42;
		$output->m33 = $t1 * $b13 + $t2 * $b23 + $t3 * $b33 + $t4 * $b43;
		$output->m34 = $t1 * $b14 + $t2 * $b24 + $t3 * $b34 + $t4 * $b44;
		$t1 = $a->m41;
		$t2 = $a->m42;
		$t3 = $a->m43;
		$t4 = $a->m44;
		$output->m41 = $t1 * $b11 + $t2 * $b21 + $t3 * $b31 + $t4 * $b41;
		$output->m42 = $t1 * $b12 + $t2 * $b22 + $t3 * $b32 + $t4 * $b42;
		$output->m43 = $t1 * $b13 + $t2 * $b23 + $t3 * $b33 + $t4 * $b43;
		$output->m44 = $t1 * $b14 + $t2 * $b24 + $t3 * $b34 + $t4 * $b44;
		return $output;
	}
	static function isEqual($a, $b) {
		$success = true;
		if(!at_dotpoint_math_vector_Matrix44_0($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_1($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_2($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_3($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_4($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_5($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_6($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_7($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_8($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_9($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_10($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_11($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_12($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_13($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_14($a, $b, $success) || !at_dotpoint_math_vector_Matrix44_15($a, $b, $success)) {
			$success = false;
		}
		return $success;
	}
	function __toString() { return 'at.dotpoint.math.vector.Matrix44'; }
}
function at_dotpoint_math_vector_Matrix44_0(&$a, &$b, &$success) {
	{
		$a1 = $a->m11;
		$b1 = $b->m11;
		if($a1 > $b1) {
			return $a1 - $b1 < 1e-08;
		} else {
			return $b1 - $a1 < 1e-08;
		}
		unset($b1,$a1);
	}
}
function at_dotpoint_math_vector_Matrix44_1(&$a, &$b, &$success) {
	{
		$a2 = $a->m12;
		$b2 = $b->m12;
		if($a2 > $b2) {
			return $a2 - $b2 < 1e-08;
		} else {
			return $b2 - $a2 < 1e-08;
		}
		unset($b2,$a2);
	}
}
function at_dotpoint_math_vector_Matrix44_2(&$a, &$b, &$success) {
	{
		$a3 = $a->m13;
		$b3 = $b->m13;
		if($a3 > $b3) {
			return $a3 - $b3 < 1e-08;
		} else {
			return $b3 - $a3 < 1e-08;
		}
		unset($b3,$a3);
	}
}
function at_dotpoint_math_vector_Matrix44_3(&$a, &$b, &$success) {
	{
		$a4 = $a->m14;
		$b4 = $b->m14;
		if($a4 > $b4) {
			return $a4 - $b4 < 1e-08;
		} else {
			return $b4 - $a4 < 1e-08;
		}
		unset($b4,$a4);
	}
}
function at_dotpoint_math_vector_Matrix44_4(&$a, &$b, &$success) {
	{
		$a5 = $a->m21;
		$b5 = $b->m21;
		if($a5 > $b5) {
			return $a5 - $b5 < 1e-08;
		} else {
			return $b5 - $a5 < 1e-08;
		}
		unset($b5,$a5);
	}
}
function at_dotpoint_math_vector_Matrix44_5(&$a, &$b, &$success) {
	{
		$a6 = $a->m22;
		$b6 = $b->m22;
		if($a6 > $b6) {
			return $a6 - $b6 < 1e-08;
		} else {
			return $b6 - $a6 < 1e-08;
		}
		unset($b6,$a6);
	}
}
function at_dotpoint_math_vector_Matrix44_6(&$a, &$b, &$success) {
	{
		$a7 = $a->m23;
		$b7 = $b->m23;
		if($a7 > $b7) {
			return $a7 - $b7 < 1e-08;
		} else {
			return $b7 - $a7 < 1e-08;
		}
		unset($b7,$a7);
	}
}
function at_dotpoint_math_vector_Matrix44_7(&$a, &$b, &$success) {
	{
		$a8 = $a->m24;
		$b8 = $b->m24;
		if($a8 > $b8) {
			return $a8 - $b8 < 1e-08;
		} else {
			return $b8 - $a8 < 1e-08;
		}
		unset($b8,$a8);
	}
}
function at_dotpoint_math_vector_Matrix44_8(&$a, &$b, &$success) {
	{
		$a9 = $a->m31;
		$b9 = $b->m31;
		if($a9 > $b9) {
			return $a9 - $b9 < 1e-08;
		} else {
			return $b9 - $a9 < 1e-08;
		}
		unset($b9,$a9);
	}
}
function at_dotpoint_math_vector_Matrix44_9(&$a, &$b, &$success) {
	{
		$a10 = $a->m32;
		$b10 = $b->m32;
		if($a10 > $b10) {
			return $a10 - $b10 < 1e-08;
		} else {
			return $b10 - $a10 < 1e-08;
		}
		unset($b10,$a10);
	}
}
function at_dotpoint_math_vector_Matrix44_10(&$a, &$b, &$success) {
	{
		$a11 = $a->m33;
		$b11 = $b->m33;
		if($a11 > $b11) {
			return $a11 - $b11 < 1e-08;
		} else {
			return $b11 - $a11 < 1e-08;
		}
		unset($b11,$a11);
	}
}
function at_dotpoint_math_vector_Matrix44_11(&$a, &$b, &$success) {
	{
		$a12 = $a->m34;
		$b12 = $b->m34;
		if($a12 > $b12) {
			return $a12 - $b12 < 1e-08;
		} else {
			return $b12 - $a12 < 1e-08;
		}
		unset($b12,$a12);
	}
}
function at_dotpoint_math_vector_Matrix44_12(&$a, &$b, &$success) {
	{
		$a13 = $a->m41;
		$b13 = $b->m41;
		if($a13 > $b13) {
			return $a13 - $b13 < 1e-08;
		} else {
			return $b13 - $a13 < 1e-08;
		}
		unset($b13,$a13);
	}
}
function at_dotpoint_math_vector_Matrix44_13(&$a, &$b, &$success) {
	{
		$a14 = $a->m42;
		$b14 = $b->m42;
		if($a14 > $b14) {
			return $a14 - $b14 < 1e-08;
		} else {
			return $b14 - $a14 < 1e-08;
		}
		unset($b14,$a14);
	}
}
function at_dotpoint_math_vector_Matrix44_14(&$a, &$b, &$success) {
	{
		$a15 = $a->m43;
		$b15 = $b->m43;
		if($a15 > $b15) {
			return $a15 - $b15 < 1e-08;
		} else {
			return $b15 - $a15 < 1e-08;
		}
		unset($b15,$a15);
	}
}
function at_dotpoint_math_vector_Matrix44_15(&$a, &$b, &$success) {
	{
		$a16 = $a->m44;
		$b16 = $b->m44;
		if($a16 > $b16) {
			return $a16 - $b16 < 1e-08;
		} else {
			return $b16 - $a16 < 1e-08;
		}
		unset($b16,$a16);
	}
}
