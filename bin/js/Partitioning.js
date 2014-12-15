(function () { "use strict";
var console = (1,eval)('this').console || {log:function(){}};
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) return undefined;
	return x;
};
HxOverrides.indexOf = function(a,obj,i) {
	var len = a.length;
	if(i < 0) {
		i += len;
		if(i < 0) i = 0;
	}
	while(i < len) {
		if(a[i] === obj) return i;
		i++;
	}
	return -1;
};
HxOverrides.remove = function(a,obj) {
	var i = HxOverrides.indexOf(a,obj,0);
	if(i == -1) return false;
	a.splice(i,1);
	return true;
};
var IPartitionCalculator = function() { };
IPartitionCalculator.__name__ = true;
var IPolygonConverter = function() { };
IPolygonConverter.__name__ = true;
var List = function() {
	this.length = 0;
};
List.__name__ = true;
List.prototype = {
	add: function(item) {
		var x = [item];
		if(this.h == null) this.h = x; else this.q[1] = x;
		this.q = x;
		this.length++;
	}
	,first: function() {
		if(this.h == null) return null; else return this.h[0];
	}
	,remove: function(v) {
		var prev = null;
		var l = this.h;
		while(l != null) {
			if(l[0] == v) {
				if(prev == null) this.h = l[1]; else prev[1] = l[1];
				if(this.q == l) this.q = prev;
				this.length--;
				return true;
			}
			prev = l;
			l = l[1];
		}
		return false;
	}
};
var _List = {};
_List.ListIterator = function(head) {
	this.head = head;
	this.val = null;
};
_List.ListIterator.__name__ = true;
_List.ListIterator.prototype = {
	hasNext: function() {
		return this.head != null;
	}
	,next: function() {
		this.val = this.head[0];
		this.head = this.head[1];
		return this.val;
	}
};
var Main = function() {
	this.initialize();
};
Main.__name__ = true;
Main.main = function() {
	Main.instance = new Main();
};
Main.prototype = {
	initialize: function() {
		this.calculator = new calculator.TraversalSplitter();
	}
	,calculate: function(input) {
		var input1 = this.parseInput(input);
		var result = this.calculator.calculate(input1);
		return result;
	}
	,parseInput: function(input) {
		var output = null;
		if(typeof(input) == "string") output = new converter.StringConverter().convert(input);
		if(output == null) throw "unable to convert given input " + Std.string(input);
		return output;
	}
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
};
Std.parseInt = function(x) {
	var v = parseInt(x,10);
	if(v == 0 && (HxOverrides.cca(x,1) == 120 || HxOverrides.cca(x,1) == 88)) v = parseInt(x);
	if(isNaN(v)) return null;
	return v;
};
var at = {};
at.dotpoint = {};
at.dotpoint.math = {};
at.dotpoint.math.MathUtil = function() { };
at.dotpoint.math.MathUtil.__name__ = true;
at.dotpoint.math.MathUtil.isEqual = function(a,b) {
	if(a > b) return a - b < 1e-08; else return b - a < 1e-08;
};
at.dotpoint.math.MathUtil.getAngle = function(x1,y1,x2,y2) {
	var dx = x2 - x1;
	var dy = y2 - y1;
	return Math.atan2(dy,dx);
};
at.dotpoint.math.geom = {};
at.dotpoint.math.geom.Rectangle = function(x,y,w,h) {
	if(h == null) h = 0;
	if(w == null) w = 0;
	if(y == null) y = 0;
	if(x == null) x = 0;
	this.position = new at.dotpoint.math.vector.Vector2(x,y);
	this.size = new at.dotpoint.math.vector.Vector2(w,h);
};
at.dotpoint.math.geom.Rectangle.__name__ = true;
at.dotpoint.math.geom.Rectangle.prototype = {
	clone: function() {
		return new at.dotpoint.math.geom.Rectangle(this.position.get_x(),this.position.get_y(),this.size.get_x(),this.size.get_y());
	}
	,setZero: function() {
		this.position.set_x(0);
		this.position.set_y(0);
		this.size.set_x(0);
		this.size.set_y(0);
	}
	,get_x: function() {
		return this.position.get_x();
	}
	,set_x: function(value) {
		return this.position.set_x(value);
	}
	,get_y: function() {
		return this.position.get_y();
	}
	,set_y: function(value) {
		return this.position.set_y(value);
	}
	,get_width: function() {
		return this.size.get_x();
	}
	,set_width: function(value) {
		if(value < 0) throw "dimension below zero";
		return this.size.set_x(value);
	}
	,get_height: function() {
		return this.size.get_y();
	}
	,set_height: function(value) {
		if(value < 0) throw "dimension below zero";
		return this.size.set_y(value);
	}
	,get_top: function() {
		return this.position.get_y();
	}
	,set_top: function(value) {
		var _g = this;
		_g.set_height(_g.size.get_y() - (value - this.position.get_y()));
		this.position.set_y(value);
		return value;
	}
	,get_bottom: function() {
		return this.position.get_y() + this.size.get_y();
	}
	,set_bottom: function(value) {
		this.set_height(value - this.position.get_y());
		return value;
	}
	,get_left: function() {
		return this.position.get_x();
	}
	,set_left: function(value) {
		var _g = this;
		_g.set_width(_g.size.get_x() - (value - this.position.get_x()));
		this.position.set_x(value);
		return value;
	}
	,get_right: function() {
		return this.position.get_x() + this.size.get_x();
	}
	,set_right: function(value) {
		this.set_width(value - this.position.get_x());
		return value;
	}
	,get_topLeft: function() {
		return this.position.clone();
	}
	,set_topLeft: function(value) {
		this.set_top(value.get_y());
		this.set_left(value.get_x());
		return value;
	}
	,get_bottomRight: function() {
		return at.dotpoint.math.vector.Vector2.add(this.position,this.size);
	}
	,set_bottomRight: function(value) {
		this.set_bottom(value.get_y());
		this.set_right(value.get_x());
		return value;
	}
	,get_dimension: function() {
		return this.size.clone();
	}
	,set_dimension: function(value) {
		this.size.copyFrom(value);
		return value;
	}
	,isInside: function(x,y) {
		if(x < this.position.get_x()) return false;
		if(y < this.position.get_y()) return false;
		if(x > this.position.get_x() + this.size.get_x()) return false;
		if(y > this.position.get_y() + this.size.get_y()) return false;
		return true;
	}
	,toString: function() {
		return "x:" + this.position.get_x() + " y:" + this.position.get_y() + " w:" + this.size.get_x() + " h:" + this.size.get_y();
	}
};
at.dotpoint.math.vector = {};
at.dotpoint.math.vector.IMatrix33 = function() { };
at.dotpoint.math.vector.IMatrix33.__name__ = true;
at.dotpoint.math.vector.IMatrix44 = function() { };
at.dotpoint.math.vector.IMatrix44.__name__ = true;
at.dotpoint.math.vector.IMatrix44.__interfaces__ = [at.dotpoint.math.vector.IMatrix33];
at.dotpoint.math.vector.IVector2 = function() { };
at.dotpoint.math.vector.IVector2.__name__ = true;
at.dotpoint.math.vector.IVector3 = function() { };
at.dotpoint.math.vector.IVector3.__name__ = true;
at.dotpoint.math.vector.IVector3.__interfaces__ = [at.dotpoint.math.vector.IVector2];
at.dotpoint.math.vector.Matrix44 = function(m) {
	if(m != null) this.set44(m); else this.toIdentity();
};
at.dotpoint.math.vector.Matrix44.__name__ = true;
at.dotpoint.math.vector.Matrix44.__interfaces__ = [at.dotpoint.math.vector.IMatrix44];
at.dotpoint.math.vector.Matrix44.add = function(a,b,output) {
	output.m11 = a.m11 + b.m11;
	output.m12 = a.m12 + b.m12;
	output.m13 = a.m13 + b.m13;
	output.m14 = a.m14 + b.m14;
	output.m21 = a.m21 + b.m21;
	output.m22 = a.m22 + b.m22;
	output.m23 = a.m23 + b.m23;
	output.m24 = a.m24 + b.m24;
	output.m31 = a.m31 + b.m31;
	output.m32 = a.m32 + b.m32;
	output.m33 = a.m33 + b.m33;
	output.m34 = a.m34 + b.m34;
	output.m41 = a.m41 + b.m41;
	output.m42 = a.m42 + b.m42;
	output.m43 = a.m43 + b.m43;
	output.m44 = a.m44 + b.m44;
	return output;
};
at.dotpoint.math.vector.Matrix44.subtract = function(a,b,output) {
	output.m11 = a.m11 - b.m11;
	output.m12 = a.m12 - b.m12;
	output.m13 = a.m13 - b.m13;
	output.m14 = a.m14 - b.m14;
	output.m21 = a.m21 - b.m21;
	output.m22 = a.m22 - b.m22;
	output.m23 = a.m23 - b.m23;
	output.m24 = a.m24 - b.m24;
	output.m31 = a.m31 - b.m31;
	output.m32 = a.m32 - b.m32;
	output.m33 = a.m33 - b.m33;
	output.m34 = a.m34 - b.m34;
	output.m41 = a.m41 - b.m41;
	output.m42 = a.m42 - b.m42;
	output.m43 = a.m43 - b.m43;
	output.m44 = a.m44 - b.m44;
	return output;
};
at.dotpoint.math.vector.Matrix44.scale = function(a,scalar,output) {
	output.m11 = a.m11 * scalar;
	output.m12 = a.m12 * scalar;
	output.m13 = a.m13 * scalar;
	output.m14 = a.m14 * scalar;
	output.m21 = a.m21 * scalar;
	output.m22 = a.m22 * scalar;
	output.m23 = a.m23 * scalar;
	output.m24 = a.m24 * scalar;
	output.m31 = a.m31 * scalar;
	output.m32 = a.m32 * scalar;
	output.m33 = a.m33 * scalar;
	output.m34 = a.m34 * scalar;
	output.m41 = a.m41 * scalar;
	output.m42 = a.m42 * scalar;
	output.m43 = a.m43 * scalar;
	output.m44 = a.m44 * scalar;
	return output;
};
at.dotpoint.math.vector.Matrix44.multiply = function(a,b,output) {
	var b11 = b.m11;
	var b12 = b.m12;
	var b13 = b.m13;
	var b14 = b.m14;
	var b21 = b.m21;
	var b22 = b.m22;
	var b23 = b.m23;
	var b24 = b.m24;
	var b31 = b.m31;
	var b32 = b.m32;
	var b33 = b.m33;
	var b34 = b.m34;
	var b41 = b.m41;
	var b42 = b.m42;
	var b43 = b.m43;
	var b44 = b.m44;
	var t1;
	var t2;
	var t3;
	var t4;
	t1 = a.m11;
	t2 = a.m12;
	t3 = a.m13;
	t4 = a.m14;
	output.m11 = t1 * b11 + t2 * b21 + t3 * b31 + t4 * b41;
	output.m12 = t1 * b12 + t2 * b22 + t3 * b32 + t4 * b42;
	output.m13 = t1 * b13 + t2 * b23 + t3 * b33 + t4 * b43;
	output.m14 = t1 * b14 + t2 * b24 + t3 * b34 + t4 * b44;
	t1 = a.m21;
	t2 = a.m22;
	t3 = a.m23;
	t4 = a.m24;
	output.m21 = t1 * b11 + t2 * b21 + t3 * b31 + t4 * b41;
	output.m22 = t1 * b12 + t2 * b22 + t3 * b32 + t4 * b42;
	output.m23 = t1 * b13 + t2 * b23 + t3 * b33 + t4 * b43;
	output.m24 = t1 * b14 + t2 * b24 + t3 * b34 + t4 * b44;
	t1 = a.m31;
	t2 = a.m32;
	t3 = a.m33;
	t4 = a.m34;
	output.m31 = t1 * b11 + t2 * b21 + t3 * b31 + t4 * b41;
	output.m32 = t1 * b12 + t2 * b22 + t3 * b32 + t4 * b42;
	output.m33 = t1 * b13 + t2 * b23 + t3 * b33 + t4 * b43;
	output.m34 = t1 * b14 + t2 * b24 + t3 * b34 + t4 * b44;
	t1 = a.m41;
	t2 = a.m42;
	t3 = a.m43;
	t4 = a.m44;
	output.m41 = t1 * b11 + t2 * b21 + t3 * b31 + t4 * b41;
	output.m42 = t1 * b12 + t2 * b22 + t3 * b32 + t4 * b42;
	output.m43 = t1 * b13 + t2 * b23 + t3 * b33 + t4 * b43;
	output.m44 = t1 * b14 + t2 * b24 + t3 * b34 + t4 * b44;
	return output;
};
at.dotpoint.math.vector.Matrix44.isEqual = function(a,b) {
	var success = true;
	if(!at.dotpoint.math.MathUtil.isEqual(a.m11,b.m11) || !at.dotpoint.math.MathUtil.isEqual(a.m12,b.m12) || !at.dotpoint.math.MathUtil.isEqual(a.m13,b.m13) || !at.dotpoint.math.MathUtil.isEqual(a.m14,b.m14) || !at.dotpoint.math.MathUtil.isEqual(a.m21,b.m21) || !at.dotpoint.math.MathUtil.isEqual(a.m22,b.m22) || !at.dotpoint.math.MathUtil.isEqual(a.m23,b.m23) || !at.dotpoint.math.MathUtil.isEqual(a.m24,b.m24) || !at.dotpoint.math.MathUtil.isEqual(a.m31,b.m31) || !at.dotpoint.math.MathUtil.isEqual(a.m32,b.m32) || !at.dotpoint.math.MathUtil.isEqual(a.m33,b.m33) || !at.dotpoint.math.MathUtil.isEqual(a.m34,b.m34) || !at.dotpoint.math.MathUtil.isEqual(a.m41,b.m41) || !at.dotpoint.math.MathUtil.isEqual(a.m42,b.m42) || !at.dotpoint.math.MathUtil.isEqual(a.m43,b.m43) || !at.dotpoint.math.MathUtil.isEqual(a.m44,b.m44)) success = false;
	return success;
};
at.dotpoint.math.vector.Matrix44.prototype = {
	clone: function() {
		return new at.dotpoint.math.vector.Matrix44(this);
	}
	,set44: function(m) {
		this.m11 = m.m11;
		this.m12 = m.m12;
		this.m13 = m.m13;
		this.m14 = m.m14;
		this.m21 = m.m21;
		this.m22 = m.m22;
		this.m23 = m.m23;
		this.m24 = m.m24;
		this.m31 = m.m31;
		this.m32 = m.m32;
		this.m33 = m.m33;
		this.m34 = m.m34;
		this.m41 = m.m41;
		this.m42 = m.m42;
		this.m43 = m.m43;
		this.m44 = m.m44;
	}
	,set33: function(m) {
		this.m11 = m.m11;
		this.m12 = m.m12;
		this.m13 = m.m13;
		this.m14 = 0;
		this.m21 = m.m21;
		this.m22 = m.m22;
		this.m23 = m.m23;
		this.m24 = 0;
		this.m31 = m.m31;
		this.m32 = m.m32;
		this.m33 = m.m33;
		this.m34 = 0;
		this.m41 = 0;
		this.m42 = 0;
		this.m43 = 0;
		this.m44 = 1;
	}
	,toIdentity: function() {
		this.m11 = 1;
		this.m12 = 0;
		this.m13 = 0;
		this.m14 = 0;
		this.m21 = 0;
		this.m22 = 1;
		this.m23 = 0;
		this.m24 = 0;
		this.m31 = 0;
		this.m32 = 0;
		this.m33 = 1;
		this.m34 = 0;
		this.m41 = 0;
		this.m42 = 0;
		this.m43 = 0;
		this.m44 = 1;
	}
	,transpose: function() {
		var t;
		t = this.m21;
		this.m21 = this.m12;
		this.m12 = t;
		t = this.m31;
		this.m31 = this.m13;
		this.m13 = t;
		t = this.m32;
		this.m32 = this.m23;
		this.m23 = t;
		t = this.m41;
		this.m41 = this.m14;
		this.m14 = t;
		t = this.m42;
		this.m42 = this.m24;
		this.m24 = t;
		t = this.m43;
		this.m43 = this.m34;
		this.m34 = t;
	}
	,determinant: function() {
		return (this.m11 * this.m22 - this.m21 * this.m12) * (this.m33 * this.m44 - this.m43 * this.m34) - (this.m11 * this.m32 - this.m31 * this.m12) * (this.m23 * this.m44 - this.m43 * this.m24) + (this.m11 * this.m42 - this.m41 * this.m12) * (this.m23 * this.m34 - this.m33 * this.m24) + (this.m21 * this.m32 - this.m31 * this.m22) * (this.m13 * this.m44 - this.m43 * this.m14) - (this.m21 * this.m42 - this.m41 * this.m22) * (this.m13 * this.m34 - this.m33 * this.m14) + (this.m31 * this.m42 - this.m41 * this.m32) * (this.m13 * this.m24 - this.m23 * this.m14);
	}
	,inverse: function() {
		var d = this.determinant();
		if(Math.abs(d) < 1e-08) return;
		d = 1 / d;
		var m11 = this.m11;
		var m21 = this.m21;
		var m31 = this.m31;
		var m41 = this.m41;
		var m12 = this.m12;
		var m22 = this.m22;
		var m32 = this.m32;
		var m42 = this.m42;
		var m13 = this.m13;
		var m23 = this.m23;
		var m33 = this.m33;
		var m43 = this.m43;
		var m14 = this.m14;
		var m24 = this.m24;
		var m34 = this.m34;
		var m44 = this.m44;
		this.m11 = d * (m22 * (m33 * m44 - m43 * m34) - m32 * (m23 * m44 - m43 * m24) + m42 * (m23 * m34 - m33 * m24));
		this.m12 = -d * (m12 * (m33 * m44 - m43 * m34) - m32 * (m13 * m44 - m43 * m14) + m42 * (m13 * m34 - m33 * m14));
		this.m13 = d * (m12 * (m23 * m44 - m43 * m24) - m22 * (m13 * m44 - m43 * m14) + m42 * (m13 * m24 - m23 * m14));
		this.m14 = -d * (m12 * (m23 * m34 - m33 * m24) - m22 * (m13 * m34 - m33 * m14) + m32 * (m13 * m24 - m23 * m14));
		this.m21 = -d * (m21 * (m33 * m44 - m43 * m34) - m31 * (m23 * m44 - m43 * m24) + m41 * (m23 * m34 - m33 * m24));
		this.m22 = d * (m11 * (m33 * m44 - m43 * m34) - m31 * (m13 * m44 - m43 * m14) + m41 * (m13 * m34 - m33 * m14));
		this.m23 = -d * (m11 * (m23 * m44 - m43 * m24) - m21 * (m13 * m44 - m43 * m14) + m41 * (m13 * m24 - m23 * m14));
		this.m24 = d * (m11 * (m23 * m34 - m33 * m24) - m21 * (m13 * m34 - m33 * m14) + m31 * (m13 * m24 - m23 * m14));
		this.m31 = d * (m21 * (m32 * m44 - m42 * m34) - m31 * (m22 * m44 - m42 * m24) + m41 * (m22 * m34 - m32 * m24));
		this.m32 = -d * (m11 * (m32 * m44 - m42 * m34) - m31 * (m12 * m44 - m42 * m14) + m41 * (m12 * m34 - m32 * m14));
		this.m33 = d * (m11 * (m22 * m44 - m42 * m24) - m21 * (m12 * m44 - m42 * m14) + m41 * (m12 * m24 - m22 * m14));
		this.m34 = -d * (m11 * (m22 * m34 - m32 * m24) - m21 * (m12 * m34 - m32 * m14) + m31 * (m12 * m24 - m22 * m14));
		this.m41 = -d * (m21 * (m32 * m43 - m42 * m33) - m31 * (m22 * m43 - m42 * m23) + m41 * (m22 * m33 - m32 * m23));
		this.m42 = d * (m11 * (m32 * m43 - m42 * m33) - m31 * (m12 * m43 - m42 * m13) + m41 * (m12 * m33 - m32 * m13));
		this.m43 = -d * (m11 * (m22 * m43 - m42 * m23) - m21 * (m12 * m43 - m42 * m13) + m41 * (m12 * m23 - m22 * m13));
		this.m44 = d * (m11 * (m22 * m33 - m32 * m23) - m21 * (m12 * m33 - m32 * m13) + m31 * (m12 * m23 - m22 * m13));
	}
};
at.dotpoint.math.vector.Vector2 = function(x,y) {
	if(y == null) y = 0;
	if(x == null) x = 0;
	this.set_x(x);
	this.set_y(y);
};
at.dotpoint.math.vector.Vector2.__name__ = true;
at.dotpoint.math.vector.Vector2.__interfaces__ = [at.dotpoint.math.vector.IVector2];
at.dotpoint.math.vector.Vector2.add = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector2();
	output.set_x(a.get_x() + b.get_x());
	output.set_y(a.get_y() + b.get_y());
	return output;
};
at.dotpoint.math.vector.Vector2.subtract = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector2();
	output.set_x(a.get_x() - b.get_x());
	output.set_y(a.get_y() - b.get_y());
	return output;
};
at.dotpoint.math.vector.Vector2.scale = function(a,scalar,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector2();
	output.set_x(a.get_x() * scalar);
	output.set_y(a.get_y() * scalar);
	return output;
};
at.dotpoint.math.vector.Vector2.isEqual = function(a,b) {
	if(!at.dotpoint.math.MathUtil.isEqual(a.get_x(),b.get_x())) return false;
	if(!at.dotpoint.math.MathUtil.isEqual(a.get_y(),b.get_y())) return false;
	return true;
};
at.dotpoint.math.vector.Vector2.prototype = {
	clone: function() {
		return new at.dotpoint.math.vector.Vector2(this.get_x(),this.get_y());
	}
	,get_x: function() {
		return this.x;
	}
	,set_x: function(value) {
		return this.x = value;
	}
	,get_y: function() {
		return this.y;
	}
	,set_y: function(value) {
		return this.y = value;
	}
	,set: function(x,y) {
		this.set_x(x);
		this.set_y(y);
	}
	,copyFrom: function(vector) {
		this.set_x(vector.get_x());
		this.set_y(vector.get_y());
	}
	,normalize: function() {
		var k = 1. / this.length();
		var _g = this;
		_g.set_x(_g.get_x() * k);
		var _g1 = this;
		_g1.set_y(_g1.get_y() * k);
	}
	,length: function() {
		return Math.sqrt(this.lengthSq());
	}
	,lengthSq: function() {
		return this.get_x() * this.get_x() + this.get_y() * this.get_y();
	}
	,toString: function() {
		return "[Vector2;" + this.get_x() + ", " + this.get_y() + "]";
	}
};
at.dotpoint.math.vector.Vector3 = function(x,y,z,w) {
	if(w == null) w = 1;
	if(z == null) z = 0;
	if(y == null) y = 0;
	if(x == null) x = 0;
	this.set_x(x);
	this.set_y(y);
	this.z = z;
	this.w = w;
};
at.dotpoint.math.vector.Vector3.__name__ = true;
at.dotpoint.math.vector.Vector3.__interfaces__ = [at.dotpoint.math.vector.IVector3];
at.dotpoint.math.vector.Vector3.add = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	output.set_x(a.get_x() + b.get_x());
	output.set_y(a.get_y() + b.get_y());
	output.z = a.z + b.z;
	return output;
};
at.dotpoint.math.vector.Vector3.subtract = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	output.set_x(a.get_x() - b.get_x());
	output.set_y(a.get_y() - b.get_y());
	output.z = a.z - b.z;
	return output;
};
at.dotpoint.math.vector.Vector3.scale = function(a,scalar,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	output.set_x(a.get_x() * scalar);
	output.set_y(a.get_y() * scalar);
	output.z = a.z * scalar;
	return output;
};
at.dotpoint.math.vector.Vector3.cross = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	output.set_x(a.get_y() * b.z - a.z * b.get_y());
	output.set_y(a.z * b.get_x() - a.get_x() * b.z);
	output.z = a.get_x() * b.get_y() - a.get_y() * b.get_x();
	return output;
};
at.dotpoint.math.vector.Vector3.dot = function(a,b) {
	return a.get_x() * b.get_x() + a.get_y() * b.get_y() + a.z * b.z;
};
at.dotpoint.math.vector.Vector3.multiplyMatrix = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	var x = a.get_x();
	var y = a.get_y();
	var z = a.z;
	var w = a.w;
	output.set_x(b.m11 * x + b.m12 * y + b.m13 * z + b.m14 * w);
	output.set_y(b.m21 * x + b.m22 * y + b.m23 * z + b.m24 * w);
	output.z = b.m31 * x + b.m32 * y + b.m33 * z + b.m34 * w;
	output.w = b.m41 * x + b.m42 * y + b.m43 * z + b.m44 * w;
	return output;
};
at.dotpoint.math.vector.Vector3.isEqual = function(a,b) {
	if(!at.dotpoint.math.MathUtil.isEqual(a.get_x(),b.get_x())) return false;
	if(!at.dotpoint.math.MathUtil.isEqual(a.get_y(),b.get_y())) return false;
	if(!at.dotpoint.math.MathUtil.isEqual(a.z,b.z)) return false;
	return true;
};
at.dotpoint.math.vector.Vector3.project = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	var l = a.lengthSq();
	if(l == 0) throw "undefined result";
	var d = at.dotpoint.math.vector.Vector3.dot(a,b);
	var d_div = d / l;
	return at.dotpoint.math.vector.Vector3.scale(a,d_div,output);
};
at.dotpoint.math.vector.Vector3.orthoNormalize = function(vectors) {
	var _g1 = 0;
	var _g = vectors.length;
	while(_g1 < _g) {
		var i = _g1++;
		var sum = new at.dotpoint.math.vector.Vector3();
		var _g2 = 0;
		while(_g2 < i) {
			var j = _g2++;
			var projected = at.dotpoint.math.vector.Vector3.project(vectors[i],vectors[j]);
			at.dotpoint.math.vector.Vector3.add(sum,projected,sum);
		}
		at.dotpoint.math.vector.Vector3.subtract(vectors[i],sum,vectors[i]).normalize();
	}
};
at.dotpoint.math.vector.Vector3.prototype = {
	clone: function() {
		return new at.dotpoint.math.vector.Vector3(this.get_x(),this.get_y(),this.z,this.w);
	}
	,get_x: function() {
		return this.x;
	}
	,set_x: function(value) {
		return this.x = value;
	}
	,get_y: function() {
		return this.y;
	}
	,set_y: function(value) {
		return this.y = value;
	}
	,normalize: function() {
		var l = this.length();
		if(l == 0) return;
		var k = 1. / l;
		var _g = this;
		_g.set_x(_g.get_x() * k);
		var _g1 = this;
		_g1.set_y(_g1.get_y() * k);
		this.z *= k;
	}
	,length: function() {
		return Math.sqrt(this.lengthSq());
	}
	,lengthSq: function() {
		return this.get_x() * this.get_x() + this.get_y() * this.get_y() + this.z * this.z;
	}
	,toArray: function(w) {
		if(w == null) w = false;
		var output = [];
		output[0] = this.get_x();
		output[1] = this.get_y();
		output[2] = this.z;
		if(w) output[3] = this.w;
		return output;
	}
	,getIndex: function(index) {
		switch(index) {
		case 0:
			return this.get_x();
		case 1:
			return this.get_y();
		case 2:
			return this.z;
		case 3:
			return this.w;
		default:
			throw "out of bounds";
		}
	}
	,setIndex: function(index,value) {
		switch(index) {
		case 0:
			this.set_x(value);
			break;
		case 1:
			this.set_y(value);
			break;
		case 2:
			this.z = value;
			break;
		case 3:
			this.w = value;
			break;
		default:
			throw "out of bounds";
		}
	}
	,set: function(x,y,z,w) {
		this.set_x(x);
		this.set_y(y);
		this.z = z;
		if(w != null) this.w = w;
	}
	,toString: function() {
		return "[Vector3;" + this.get_x() + ", " + this.get_y() + ", " + this.z + ", " + this.w + "]";
	}
};
var calculator = {};
calculator.EdgeContainer = function() {
	this.vertical = [];
	this.horizontal = [];
};
calculator.EdgeContainer.__name__ = true;
calculator.EdgeContainer.prototype = {
	insert: function(a,b) {
		if(this.isVertical(a,b)) {
			var index = this.getIndex(a.get_x(),true);
			this.vertical.splice(index * 2,0,a);
			this.vertical.splice(index * 2,0,b);
		} else {
			var index1 = this.getIndex(a.get_y(),false);
			this.horizontal.splice(index1 * 2,0,a);
			this.horizontal.splice(index1 * 2,0,b);
		}
	}
	,remove: function(a,b) {
		if(this.isVertical(a,b)) {
			HxOverrides.remove(this.vertical,a);
			HxOverrides.remove(this.vertical,b);
		} else {
			HxOverrides.remove(this.horizontal,a);
			HxOverrides.remove(this.horizontal,b);
		}
	}
	,split: function(start,dir) {
		var isVertical = Math.abs(dir.get_x()) < Math.abs(dir.get_y());
		if(isVertical) {
			var ystep;
			if(dir.get_y() < 0) ystep = -1; else ystep = 1;
			var hstart = this.getIndex(start.get_y(),false) - 1;
			var hlength = this.horizontal.length >> 1;
			while((hstart += ystep) >= 0 && hstart <= hlength) {
				var hindex = hstart * 2;
				var a = this.horizontal[hindex];
				var b = this.horizontal[hindex + 1];
				if(a == start || b == start) continue;
				if(start.get_x() >= a.get_x() && start.get_x() <= b.get_x() || start.get_x() >= b.get_x() && start.get_x() <= a.get_x()) return this.insertSplit(start,a,b);
			}
		} else {
			var xstep;
			if(dir.get_x() < 0) xstep = -1; else xstep = 1;
			var vstart = this.getIndex(start.get_x(),true) - 1;
			var vlength = this.vertical.length >> 1;
			while((vstart += xstep) >= 0 && vstart <= vlength) {
				var vindex = vstart * 2;
				var a1 = this.vertical[vindex];
				var b1 = this.vertical[vindex + 1];
				if(a1 == start || b1 == start) continue;
				if(start.get_y() >= a1.get_y() && start.get_y() <= b1.get_y() || start.get_y() >= b1.get_y() && start.get_y() <= a1.get_y()) return this.insertSplit(start,a1,b1);
			}
		}
		return null;
	}
	,insertSplit: function(start,a,b) {
		var split = new calculator.Vertex(null);
		if(this.isVertical(a,b)) {
			split.set_x(a.get_x());
			split.set_y(start.get_y());
		} else {
			split.set_x(start.get_x());
			split.set_y(a.get_y());
		}
		this.remove(a,b);
		this.insert(split,start);
		this.insert(split,a);
		this.insert(split,b);
		a.neighbors.remove(b);
		b.neighbors.remove(a);
		a.neighbors.add(split);
		b.neighbors.add(split);
		split.neighbors.add(start);
		split.neighbors.add(a);
		split.neighbors.add(b);
		start.neighbors.add(split);
		return split;
	}
	,getIndex: function(value,isVertical) {
		if(isVertical) {
			var vlength = this.vertical.length >> 1;
			var _g = 0;
			while(_g < vlength) {
				var v = _g++;
				if(this.vertical[v * 2].get_x() > value) return v;
			}
			return vlength;
		} else {
			var hlength = this.horizontal.length >> 1;
			var _g1 = 0;
			while(_g1 < hlength) {
				var h = _g1++;
				if(this.horizontal[h * 2].get_y() > value) return h;
			}
			return hlength;
		}
		return -1;
	}
	,isVertical: function(a,b) {
		return at.dotpoint.math.MathUtil.isEqual(a.get_x(),b.get_x());
	}
};
calculator.TraversalSplitter = function() {
};
calculator.TraversalSplitter.__name__ = true;
calculator.TraversalSplitter.__interfaces__ = [IPartitionCalculator];
calculator.TraversalSplitter.prototype = {
	calculate: function(input) {
		this.coordinates = [];
		this.edges = new calculator.EdgeContainer();
		this.partitions = [];
		this.prepareInput(input);
		this.split();
		this.partitionate();
		return this.partitions;
	}
	,prepareInput: function(input) {
		this.toVertices(input);
		this.sortClockwise();
		this.buildGraph();
	}
	,toVertices: function(input) {
		var _g = 0;
		while(_g < input.length) {
			var point = input[_g];
			++_g;
			this.coordinates.push(new calculator.Vertex(point));
		}
		var first = this.coordinates[0];
		var last = this.coordinates[this.coordinates.length - 1];
		if(at.dotpoint.math.vector.Vector2.isEqual(first.coordinate,last.coordinate)) this.coordinates.pop();
	}
	,sortClockwise: function() {
		var clockwise = [];
		var counterwise = [];
		var _g1 = 0;
		var _g = this.coordinates.length;
		while(_g1 < _g) {
			var v = _g1++;
			var triangle = this.getTriangle(v,true);
			if(triangle.isClockwise()) clockwise.push(triangle.p2); else counterwise.push(triangle.p2);
		}
		if(clockwise.length < counterwise.length) {
			this.coordinates.reverse();
			this.splitters = clockwise;
			this.splitters.reverse();
		} else this.splitters = counterwise;
	}
	,buildGraph: function() {
		var _g1 = 0;
		var _g = this.coordinates.length;
		while(_g1 < _g) {
			var v = _g1++;
			var triangle = this.getTriangle(v,true);
			triangle.p2.neighbors.add(triangle.p1);
			triangle.p2.neighbors.add(triangle.p3);
			this.edges.insert(triangle.p1,triangle.p2);
		}
		null;
	}
	,split: function() {
		var _g = 0;
		var _g1 = this.splitters;
		while(_g < _g1.length) {
			var vertex = _g1[_g];
			++_g;
			var normal = this.getNormal(vertex);
			var split = this.edges.split(vertex,normal);
			if(split == null) throw "split could not be resolved, check the input";
			this.coordinates.push(split);
		}
	}
	,partitionate: function() {
		var _g = 0;
		var _g1 = this.coordinates;
		while(_g < _g1.length) {
			var start = _g1[_g];
			++_g;
			var current = start;
			var previous = null;
			var next = null;
			var partition = null;
			do {
				next = this.selectClockwiseVertex(current,previous);
				if(next == null) break; else {
					if(partition == null) partition = new at.dotpoint.math.geom.Rectangle();
					this.expandBounding(next,partition);
				}
				previous = current;
				current = next;
			} while(current != start);
			if(partition != null && this.isUniquePartiton(partition)) this.partitions.push(partition);
		}
	}
	,selectClockwiseVertex: function(current,previous) {
		var iterator = null;
		var possible = null;
		if(previous == null) {
			iterator = new _List.ListIterator(current.neighbors.h);
			previous = current.neighbors.first();
		}
		while(previous != null) {
			var _g_head = current.neighbors.h;
			var _g_val = null;
			while(_g_head != null) {
				var neighbor;
				_g_val = _g_head[0];
				_g_head = _g_head[1];
				neighbor = _g_val;
				if(neighbor == previous) continue;
				var triangle = calculator.VertexTriangle.instance;
				triangle.p1 = previous;
				triangle.p2 = current;
				triangle.p3 = neighbor;
				if(triangle.isClockwise()) return neighbor; else if(triangle.isClockwise(true)) possible = neighbor;
			}
			if(possible != null) return possible;
			if(iterator == null || !iterator.hasNext()) break;
			previous = iterator.next();
		}
		return null;
	}
	,isUniquePartiton: function(partition) {
		var _g = 0;
		var _g1 = this.partitions;
		while(_g < _g1.length) {
			var area = _g1[_g];
			++_g;
			if(area == partition) continue;
			if(at.dotpoint.math.vector.Vector2.isEqual(partition.position.clone(),area.position.clone()) && at.dotpoint.math.vector.Vector2.isEqual(at.dotpoint.math.vector.Vector2.add(partition.position,partition.size),at.dotpoint.math.vector.Vector2.add(area.position,area.size))) return false;
		}
		return true;
	}
	,getTriangle: function(index,pool) {
		if(pool == null) pool = false;
		var p1 = this.coordinates[index % this.coordinates.length];
		var p2 = this.coordinates[(index + 1) % this.coordinates.length];
		var p3 = this.coordinates[(index + 2) % this.coordinates.length];
		var triangle;
		if(pool) triangle = calculator.VertexTriangle.instance; else triangle = new calculator.VertexTriangle();
		triangle.p1 = p1;
		triangle.p2 = p2;
		triangle.p3 = p3;
		return triangle;
	}
	,getNormal: function(current) {
		var previous = current.neighbors.first();
		var delta = new at.dotpoint.math.vector.Vector3();
		delta.set_x(current.get_x() - previous.get_x());
		delta.set_y(current.get_y() - previous.get_y());
		var normal = at.dotpoint.math.vector.Vector3.cross(delta,new at.dotpoint.math.vector.Vector3(0,0,-1));
		normal.normalize();
		return new at.dotpoint.math.vector.Vector2(normal.get_x(),normal.get_y());
	}
	,expandBounding: function(vertex,bounding) {
		var v = bounding.size.get_x() == 0 && bounding.size.get_y() == 0 && bounding.position.get_x() == 0 && bounding.position.get_y() == 0;
		var x = vertex.get_x();
		var y = vertex.get_y();
		var nl;
		if(v) nl = x; else nl = Math.min(bounding.position.get_x(),x);
		var nr;
		if(v) nr = x; else nr = Math.max(bounding.position.get_x() + bounding.size.get_x(),x);
		var nt;
		if(v) nt = y; else nt = Math.min(bounding.position.get_y(),y);
		var nb;
		if(v) nb = y; else nb = Math.max(bounding.position.get_y() + bounding.size.get_y(),y);
		if(nl != bounding.position.get_x() || nr != bounding.position.get_x() + bounding.size.get_x() || nt != bounding.position.get_y() || nb != bounding.position.get_y() + bounding.size.get_y()) {
			bounding.set_width(nr - bounding.position.get_x());
			nr;
			bounding.set_left(nl);
			bounding.set_height(nb - bounding.position.get_y());
			nb;
			bounding.set_top(nt);
		}
	}
};
calculator.Vertex = function(coordinate) {
	if(coordinate == null) coordinate = new at.dotpoint.math.vector.Vector2();
	this.coordinate = coordinate;
	this.neighbors = new List();
};
calculator.Vertex.__name__ = true;
calculator.Vertex.__interfaces__ = [at.dotpoint.math.vector.IVector2];
calculator.Vertex.prototype = {
	get_x: function() {
		return this.coordinate.get_x();
	}
	,set_x: function(value) {
		return this.coordinate.set_x(value);
	}
	,get_y: function() {
		return this.coordinate.get_y();
	}
	,set_y: function(value) {
		return this.coordinate.set_y(value);
	}
};
calculator.VertexTriangle = function() {
};
calculator.VertexTriangle.__name__ = true;
calculator.VertexTriangle.prototype = {
	isClockwise: function(includeZero) {
		if(includeZero == null) includeZero = false;
		if(this.p1 == null || this.p2 == null || this.p3 == null) throw "must set 3 vertex coordinates";
		var v1 = new at.dotpoint.math.vector.Vector3(this.p1.coordinate.get_x(),this.p1.coordinate.get_y(),0);
		var v2 = new at.dotpoint.math.vector.Vector3(this.p2.coordinate.get_x(),this.p2.coordinate.get_y(),0);
		var v3 = new at.dotpoint.math.vector.Vector3(this.p3.coordinate.get_x(),this.p3.coordinate.get_y(),0);
		var sub1 = at.dotpoint.math.vector.Vector3.subtract(v2,v1,new at.dotpoint.math.vector.Vector3());
		var sub2 = at.dotpoint.math.vector.Vector3.subtract(v3,v1,new at.dotpoint.math.vector.Vector3());
		if(includeZero) return at.dotpoint.math.vector.Vector3.cross(sub1,sub2).z >= 0; else return at.dotpoint.math.vector.Vector3.cross(sub1,sub2).z > 0;
	}
};
var converter = {};
converter.StringConverter = function(seperator) {
	if(seperator == null) seperator = " ";
	this.seperator = seperator;
};
converter.StringConverter.__name__ = true;
converter.StringConverter.__interfaces__ = [IPolygonConverter];
converter.StringConverter.prototype = {
	convert: function(input) {
		var coordinates = [];
		var splitted = input.split(this.seperator);
		var length = splitted.length * 0.5 | 0;
		var _g = 0;
		while(_g < length) {
			var j = _g++;
			var index = j * 2;
			var point = new at.dotpoint.math.vector.Vector2();
			point.set_x(Std.parseInt(splitted[index]));
			point.set_y(Std.parseInt(splitted[index + 1]));
			coordinates.push(point);
		}
		if(coordinates.length == 0) throw "input string does not contain parsable float or integer coordinates or does not use " + this.seperator + " as seperator";
		return coordinates;
	}
};
var js = {};
js.Boot = function() { };
js.Boot.__name__ = true;
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str2 = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i1 = _g1++;
					if(i1 != 2) str2 += "," + js.Boot.__string_rec(o[i1],s); else str2 += js.Boot.__string_rec(o[i1],s);
				}
				return str2 + ")";
			}
			var l = o.length;
			var i;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js.Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
if(Array.prototype.indexOf) HxOverrides.indexOf = function(a,o,i) {
	return Array.prototype.indexOf.call(a,o,i);
};
String.__name__ = true;
Array.__name__ = true;
at.dotpoint.math.MathUtil.ZERO_TOLERANCE = 1e-08;
at.dotpoint.math.MathUtil.RAD_DEG = 57.29577951308232;
at.dotpoint.math.MathUtil.DEG_RAD = 0.017453292519943295;
at.dotpoint.math.MathUtil.FLOAT_MAX = 3.4028234663852886e+37;
at.dotpoint.math.MathUtil.FLOAT_MIN = -3.4028234663852886e+37;
calculator.VertexTriangle.instance = new calculator.VertexTriangle();
Main.main();
})();
