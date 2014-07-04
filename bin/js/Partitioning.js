(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var HxOverrides = function() { };
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
var List = function() {
	this.length = 0;
};
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
	,iterator: function() {
		return { h : this.h, hasNext : function() {
			return this.h != null;
		}, next : function() {
			if(this.h == null) return null;
			var x = this.h[0];
			this.h = this.h[1];
			return x;
		}};
	}
};
var Main = function() {
	this.initialize();
};
Main.main = function() {
	Main.instance = new Main();
};
Main.prototype = {
	initialize: function() {
		this.calculator = new calculator.TraversalSplitter();
	}
	,calculate: function(inputString) {
		var input = this.parseInput(inputString);
		var result = this.calculator.calculate(input);
		return result;
	}
	,parseInput: function(input) {
		var coordinates = new Array();
		var splitted = input.split(" ");
		var length = splitted.length * 0.5 | 0;
		var _g = 0;
		while(_g < length) {
			var j = _g++;
			var index = j * 2;
			var x = Std.parseInt(splitted[index]);
			var y = Std.parseInt(splitted[index + 1]);
			coordinates.push(x);
			coordinates.push(y);
		}
		if(coordinates.length == 0) throw "input issue";
		return coordinates;
	}
};
var Std = function() { };
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
at.dotpoint.math.geom.Rectangle.prototype = {
	clone: function() {
		return new at.dotpoint.math.geom.Rectangle(this.position.x,this.position.y,this.size.x,this.size.y);
	}
	,setZero: function() {
		this.position.x = 0;
		this.position.y = 0;
		this.size.x = 0;
		this.size.y = 0;
	}
	,get_x: function() {
		return this.position.x;
	}
	,set_x: function(value) {
		return this.position.x = value;
	}
	,get_y: function() {
		return this.position.y;
	}
	,set_y: function(value) {
		return this.position.y = value;
	}
	,get_width: function() {
		return this.size.x;
	}
	,set_width: function(value) {
		if(value < 0) throw "dimension below zero";
		return this.size.x = value;
	}
	,get_height: function() {
		return this.size.y;
	}
	,set_height: function(value) {
		if(value < 0) throw "dimension below zero";
		return this.size.y = value;
	}
	,get_top: function() {
		return this.position.y;
	}
	,set_top: function(value) {
		var _g = this;
		_g.set_height(_g.size.y - (value - this.position.y));
		this.position.y = value;
		return value;
	}
	,get_bottom: function() {
		return this.position.y + this.size.y;
	}
	,set_bottom: function(value) {
		this.set_height(value - this.position.y);
		return value;
	}
	,get_left: function() {
		return this.position.x;
	}
	,set_left: function(value) {
		var _g = this;
		_g.set_width(_g.size.x - (value - this.position.x));
		this.position.x = value;
		return value;
	}
	,get_right: function() {
		return this.position.x + this.size.x;
	}
	,set_right: function(value) {
		this.set_width(value - this.position.x);
		return value;
	}
	,get_topLeft: function() {
		return this.position.clone();
	}
	,set_topLeft: function(value) {
		this.set_top(value.y);
		this.set_left(value.x);
		return value;
	}
	,get_bottomRight: function() {
		return at.dotpoint.math.vector.Vector2.add(this.position,this.size);
	}
	,set_bottomRight: function(value) {
		this.set_bottom(value.y);
		this.set_right(value.x);
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
		if(x < this.position.x) return false;
		if(y < this.position.y) return false;
		if(x > this.position.x + this.size.x) return false;
		if(y > this.position.y + this.size.y) return false;
		return true;
	}
	,toString: function() {
		return "x:" + this.position.x + " y:" + this.position.y + " w:" + this.size.x + " h:" + this.size.y;
	}
};
at.dotpoint.math.vector = {};
at.dotpoint.math.vector.IMatrix33 = function() { };
at.dotpoint.math.vector.IMatrix44 = function() { };
at.dotpoint.math.vector.IMatrix44.__interfaces__ = [at.dotpoint.math.vector.IMatrix33];
at.dotpoint.math.vector.IVector2 = function() { };
at.dotpoint.math.vector.IVector3 = function() { };
at.dotpoint.math.vector.IVector3.__interfaces__ = [at.dotpoint.math.vector.IVector2];
at.dotpoint.math.vector.Matrix44 = function(m) {
	if(m != null) this.set44(m); else this.toIdentity();
};
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
	this.x = x;
	this.y = y;
};
at.dotpoint.math.vector.Vector2.__interfaces__ = [at.dotpoint.math.vector.IVector2];
at.dotpoint.math.vector.Vector2.add = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector2();
	output.x = a.x + b.x;
	output.y = a.y + b.y;
	return output;
};
at.dotpoint.math.vector.Vector2.subtract = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector2();
	output.x = a.x - b.x;
	output.y = a.y - b.y;
	return output;
};
at.dotpoint.math.vector.Vector2.scale = function(a,scalar,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector2();
	output.x = a.x * scalar;
	output.y = a.y * scalar;
	return output;
};
at.dotpoint.math.vector.Vector2.isEqual = function(a,b) {
	if(!at.dotpoint.math.MathUtil.isEqual(a.x,b.x)) return false;
	if(!at.dotpoint.math.MathUtil.isEqual(a.y,b.y)) return false;
	return true;
};
at.dotpoint.math.vector.Vector2.prototype = {
	clone: function() {
		return new at.dotpoint.math.vector.Vector2(this.x,this.y);
	}
	,set: function(x,y) {
		this.x = x;
		this.y = y;
	}
	,copyFrom: function(vector) {
		this.x = vector.x;
		this.y = vector.y;
	}
	,normalize: function() {
		var k = 1. / this.length();
		this.x *= k;
		this.y *= k;
	}
	,length: function() {
		return Math.sqrt(this.lengthSq());
	}
	,lengthSq: function() {
		return this.x * this.x + this.y * this.y;
	}
	,toString: function() {
		return "[Vector2;" + this.x + ", " + this.y + "]";
	}
};
at.dotpoint.math.vector.Vector3 = function(x,y,z,w) {
	if(w == null) w = 1;
	if(z == null) z = 0;
	if(y == null) y = 0;
	if(x == null) x = 0;
	this.x = x;
	this.y = y;
	this.z = z;
	this.w = w;
};
at.dotpoint.math.vector.Vector3.__interfaces__ = [at.dotpoint.math.vector.IVector3];
at.dotpoint.math.vector.Vector3.add = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	output.x = a.x + b.x;
	output.y = a.y + b.y;
	output.z = a.z + b.z;
	return output;
};
at.dotpoint.math.vector.Vector3.subtract = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	output.x = a.x - b.x;
	output.y = a.y - b.y;
	output.z = a.z - b.z;
	return output;
};
at.dotpoint.math.vector.Vector3.scale = function(a,scalar,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	output.x = a.x * scalar;
	output.y = a.y * scalar;
	output.z = a.z * scalar;
	return output;
};
at.dotpoint.math.vector.Vector3.cross = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	output.x = a.y * b.z - a.z * b.y;
	output.y = a.z * b.x - a.x * b.z;
	output.z = a.x * b.y - a.y * b.x;
	return output;
};
at.dotpoint.math.vector.Vector3.dot = function(a,b) {
	return a.x * b.x + a.y * b.y + a.z * b.z;
};
at.dotpoint.math.vector.Vector3.multiplyMatrix = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	var x = a.x;
	var y = a.y;
	var z = a.z;
	var w = a.w;
	output.x = b.m11 * x + b.m12 * y + b.m13 * z + b.m14 * w;
	output.y = b.m21 * x + b.m22 * y + b.m23 * z + b.m24 * w;
	output.z = b.m31 * x + b.m32 * y + b.m33 * z + b.m34 * w;
	output.w = b.m41 * x + b.m42 * y + b.m43 * z + b.m44 * w;
	return output;
};
at.dotpoint.math.vector.Vector3.isEqual = function(a,b) {
	if(!at.dotpoint.math.MathUtil.isEqual(a.x,b.x)) return false;
	if(!at.dotpoint.math.MathUtil.isEqual(a.y,b.y)) return false;
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
		return new at.dotpoint.math.vector.Vector3(this.x,this.y,this.z,this.w);
	}
	,normalize: function() {
		var l = this.length();
		if(l == 0) return;
		var k = 1. / l;
		this.x *= k;
		this.y *= k;
		this.z *= k;
	}
	,length: function() {
		return Math.sqrt(this.lengthSq());
	}
	,lengthSq: function() {
		return this.x * this.x + this.y * this.y + this.z * this.z;
	}
	,toArray: function(w) {
		if(w == null) w = false;
		var output = new Array();
		output[0] = this.x;
		output[1] = this.y;
		output[2] = this.z;
		if(w) output[3] = this.w;
		return output;
	}
	,getIndex: function(index) {
		switch(index) {
		case 0:
			return this.x;
		case 1:
			return this.y;
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
			this.x = value;
			break;
		case 1:
			this.y = value;
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
		this.x = x;
		this.y = y;
		this.z = z;
		if(w != null) this.w = w;
	}
	,toString: function() {
		return "[Vector3;" + this.x + ", " + this.y + ", " + this.z + ", " + this.w + "]";
	}
};
var calculator = {};
calculator.EdgeContainer = function() {
	this.vertical = new Array();
	this.horizontal = new Array();
};
calculator.EdgeContainer.prototype = {
	insert: function(a,b) {
		if(this.isVertical(a,b)) {
			var index = this.getIndex(a.x,true);
			this.vertical.splice(index * 2,0,a);
			this.vertical.splice(index * 2,0,b);
		} else {
			var index1 = this.getIndex(a.y,false);
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
		var isVertical = Math.abs(dir.x) < Math.abs(dir.y);
		if(isVertical) {
			var ystep;
			if(dir.y < 0) ystep = -1; else ystep = 1;
			var hstart = this.getIndex(start.y,false) - 1;
			var hlength = this.horizontal.length >> 1;
			while((hstart += ystep) >= 0 && hstart <= hlength) {
				var hindex = hstart * 2;
				var a = this.horizontal[hindex];
				var b = this.horizontal[hindex + 1];
				if(a == start || b == start) continue;
				if(start.x >= a.x && start.x <= b.x || start.x >= b.x && start.x <= a.x) return this.insertSplit(start,a,b);
			}
		} else {
			var xstep;
			if(dir.x < 0) xstep = -1; else xstep = 1;
			var vstart = this.getIndex(start.x,true) - 1;
			var vlength = this.vertical.length >> 1;
			while((vstart += xstep) >= 0 && vstart <= vlength) {
				var vindex = vstart * 2;
				var a1 = this.vertical[vindex];
				var b1 = this.vertical[vindex + 1];
				if(a1 == start || b1 == start) continue;
				if(start.y >= a1.y && start.y <= b1.y || start.y >= b1.y && start.y <= a1.y) return this.insertSplit(start,a1,b1);
			}
		}
		return null;
	}
	,insertSplit: function(start,a,b) {
		var split = new calculator.Vertex();
		if(this.isVertical(a,b)) {
			split.x = a.x;
			split.y = start.y;
		} else {
			split.x = start.x;
			split.y = a.y;
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
				if(this.vertical[v * 2].x > value) return v;
			}
			return vlength;
		} else {
			var hlength = this.horizontal.length >> 1;
			var _g1 = 0;
			while(_g1 < hlength) {
				var h = _g1++;
				if(this.horizontal[h * 2].y > value) return h;
			}
			return hlength;
		}
		return -1;
	}
	,isVertical: function(a,b) {
		return at.dotpoint.math.MathUtil.isEqual(a.x,b.x);
	}
};
calculator.TraversalSplitter = function() {
};
calculator.TraversalSplitter.__interfaces__ = [IPartitionCalculator];
calculator.TraversalSplitter.prototype = {
	calculate: function(input) {
		this.prepareInput(input);
		this.split();
		this.partition();
		return this.prepareOutput();
	}
	,prepareInput: function(input) {
		this.coordinates = this.parseInput(input);
		this.traverse();
		this.buildGraph();
	}
	,parseInput: function(input) {
		var coordinates = new Array();
		var length = (input.length * 0.5 | 0) - 1;
		var _g = 0;
		while(_g < length) {
			var j = _g++;
			var index = j * 2;
			var x = input[index];
			var y = input[index + 1];
			var vertex = new calculator.Vertex(x,y);
			coordinates.push(vertex);
		}
		return coordinates;
	}
	,traverse: function() {
		var clockwise = new Array();
		var counterwise = new Array();
		var _g1 = 0;
		var _g = this.coordinates.length;
		while(_g1 < _g) {
			var v = _g1++;
			var p1 = this.coordinates[v % this.coordinates.length];
			var p2 = this.coordinates[(v + 1) % this.coordinates.length];
			var p3 = this.coordinates[(v + 2) % this.coordinates.length];
			if(this.isClockwise(p1,p2,p3)) clockwise.push(p2); else counterwise.push(p2);
		}
		if(clockwise.length < counterwise.length) {
			this.coordinates.reverse();
			this.splitters = clockwise;
			this.splitters.reverse();
		} else this.splitters = counterwise;
	}
	,buildGraph: function() {
		this.edges = new calculator.EdgeContainer();
		var _g1 = 0;
		var _g = this.coordinates.length;
		while(_g1 < _g) {
			var v = _g1++;
			var p1 = this.coordinates[v % this.coordinates.length];
			var p2 = this.coordinates[(v + 1) % this.coordinates.length];
			var p3 = this.coordinates[(v + 2) % this.coordinates.length];
			p2.neighbors.add(p1);
			p2.neighbors.add(p3);
			this.edges.insert(p1,p2);
		}
		null;
	}
	,split: function() {
		var _g1 = 0;
		var _g = this.splitters.length;
		while(_g1 < _g) {
			var v = _g1++;
			var current = this.splitters[v];
			var previous = current.neighbors.first();
			var normal = this.getNormal(current,previous);
			var split = this.edges.split(current,normal);
			if(split == null) throw "split could not be resolved";
			this.coordinates.push(split);
		}
	}
	,partition: function() {
		this.partitions = new Array();
		while(this.coordinates.length > 0) {
			var start = this.coordinates.pop();
			var current = start;
			var previous = null;
			var next = null;
			var partition = new at.dotpoint.math.geom.Rectangle();
			do {
				next = this.selectCircleNode(current,previous);
				if(next == null) {
					partition = null;
					break;
				} else this.expandBounding(next,partition);
				previous = current;
				current = next;
			} while(current != start);
			if(partition != null && this.isUniquePartiton(partition)) this.partitions.push(partition);
		}
	}
	,selectCircleNode: function(current,previous) {
		if(previous == null) previous = current;
		var rotation = new Array();
		rotation[0] = new at.dotpoint.math.vector.Vector2(1,0);
		rotation[1] = new at.dotpoint.math.vector.Vector2(0,1);
		rotation[2] = new at.dotpoint.math.vector.Vector2(-1,0);
		rotation[3] = new at.dotpoint.math.vector.Vector2(0,-1);
		var direction = this.getDirection(current,previous);
		var rotationStart = -1;
		var rotationOffset = 1;
		var _g1 = 0;
		var _g = rotation.length;
		while(_g1 < _g) {
			var r = _g1++;
			if(at.dotpoint.math.vector.Vector2.isEqual(rotation[r],direction)) {
				rotationStart = r;
				break;
			}
		}
		var _g11 = 0;
		var _g2 = rotation.length;
		while(_g11 < _g2) {
			var r1 = _g11++;
			var index = rotationStart + rotationOffset + r1;
			if(index < 0) index = rotation.length - index;
			var desired = rotation[index % rotation.length];
			var $it0 = current.neighbors.iterator();
			while( $it0.hasNext() ) {
				var neighbor = $it0.next();
				var direction1 = this.getDirection(neighbor,current);
				if(at.dotpoint.math.vector.Vector2.isEqual(direction1,desired) && neighbor != previous) return neighbor;
			}
			rotationOffset = -1;
		}
		return null;
	}
	,prepareOutput: function() {
		var output = new Array();
		var _g = 0;
		var _g1 = this.partitions;
		while(_g < _g1.length) {
			var area = _g1[_g];
			++_g;
			output.push(area.position.x | 0);
			output.push(area.position.y | 0);
			output.push(area.size.x | 0);
			output.push(area.size.y | 0);
		}
		return output;
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
	,getNormal: function(current,previous) {
		var delta = new at.dotpoint.math.vector.Vector3();
		delta.x = current.x - previous.x;
		delta.y = current.y - previous.y;
		var normal = at.dotpoint.math.vector.Vector3.cross(delta,new at.dotpoint.math.vector.Vector3(0,0,-1));
		normal.normalize();
		return new at.dotpoint.math.vector.Vector2(normal.x,normal.y);
	}
	,getDirection: function(current,previous) {
		var direction = at.dotpoint.math.vector.Vector2.subtract(current,previous);
		direction.normalize();
		direction.x = Math.round(direction.x);
		direction.y = Math.round(direction.y);
		return direction;
	}
	,isClockwise: function(a,b,c) {
		var p1 = new at.dotpoint.math.vector.Vector3(a.x,a.y,0);
		var p2 = new at.dotpoint.math.vector.Vector3(b.x,b.y,0);
		var p3 = new at.dotpoint.math.vector.Vector3(c.x,c.y,0);
		var sub1 = at.dotpoint.math.vector.Vector3.subtract(p2,p1,new at.dotpoint.math.vector.Vector3());
		var sub2 = at.dotpoint.math.vector.Vector3.subtract(p3,p1,new at.dotpoint.math.vector.Vector3());
		return at.dotpoint.math.vector.Vector3.cross(sub1,sub2).z > 0;
	}
	,expandBounding: function(vertex,bounding) {
		var v = bounding.size.x == 0 && bounding.size.y == 0 && bounding.position.x == 0 && bounding.position.y == 0;
		var x = vertex.x;
		var y = vertex.y;
		var nl;
		if(v) nl = x; else nl = Math.min(bounding.position.x,x);
		var nr;
		if(v) nr = x; else nr = Math.max(bounding.position.x + bounding.size.x,x);
		var nt;
		if(v) nt = y; else nt = Math.min(bounding.position.y,y);
		var nb;
		if(v) nb = y; else nb = Math.max(bounding.position.y + bounding.size.y,y);
		if(nl != bounding.position.x || nr != bounding.position.x + bounding.size.x || nt != bounding.position.y || nb != bounding.position.y + bounding.size.y) {
			bounding.set_width(nr - bounding.position.x);
			nr;
			bounding.set_left(nl);
			bounding.set_height(nb - bounding.position.y);
			nb;
			bounding.set_top(nt);
		}
	}
};
calculator.Vertex = function(x,y) {
	if(y == null) y = 0;
	if(x == null) x = 0;
	at.dotpoint.math.vector.Vector2.call(this,x,y);
	this.neighbors = new List();
};
calculator.Vertex.__super__ = at.dotpoint.math.vector.Vector2;
calculator.Vertex.prototype = $extend(at.dotpoint.math.vector.Vector2.prototype,{
});
if(Array.prototype.indexOf) HxOverrides.indexOf = function(a,o,i) {
	return Array.prototype.indexOf.call(a,o,i);
};
Math.NaN = Number.NaN;
Math.NEGATIVE_INFINITY = Number.NEGATIVE_INFINITY;
Math.POSITIVE_INFINITY = Number.POSITIVE_INFINITY;
Math.isFinite = function(i) {
	return isFinite(i);
};
Math.isNaN = function(i1) {
	return isNaN(i1);
};
at.dotpoint.math.MathUtil.ZERO_TOLERANCE = 1e-08;
at.dotpoint.math.MathUtil.RAD_DEG = 57.29577951308232;
at.dotpoint.math.MathUtil.DEG_RAD = 0.017453292519943295;
at.dotpoint.math.MathUtil.FLOAT_MAX = 3.4028234663852886e+37;
at.dotpoint.math.MathUtil.FLOAT_MIN = -3.4028234663852886e+37;
Main.main();
})();
