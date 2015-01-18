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
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var IPartitionCalculator = function() { };
IPartitionCalculator.__name__ = true;
var IPolygonConverter = function() { };
IPolygonConverter.__name__ = true;
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
at.dotpoint.core = {};
at.dotpoint.core.ICloneable = function() { };
at.dotpoint.core.ICloneable.__name__ = true;
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
		this.size.set(value.get_x(),value.get_y());
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
at.dotpoint.math.vector.Vector2 = function(x,y) {
	if(y == null) y = 0;
	if(x == null) x = 0;
	this.set_x(x);
	this.set_y(y);
};
at.dotpoint.math.vector.Vector2.__name__ = true;
at.dotpoint.math.vector.Vector2.__interfaces__ = [at.dotpoint.core.ICloneable,at.dotpoint.math.vector.IVector2];
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
	clone: function(output) {
		if(output != null) output = output; else output = new at.dotpoint.math.vector.Vector2();
		output.set_x(this.get_x());
		output.set_y(this.get_y());
		return output;
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
	,normalize: function() {
		var k = 1. / this.length();
		var _g = this;
		_g.set_x(_g.get_x() * k);
		var _g1 = this;
		_g1.set_y(_g1.get_y() * k);
	}
	,length: function() {
		return Math.sqrt(this.get_x() * this.get_x() + this.get_y() * this.get_y());
	}
	,lengthSq: function() {
		return this.get_x() * this.get_x() + this.get_y() * this.get_y();
	}
	,toArray: function(output) {
		if(output != null) output = [];
		output[0] = this.get_x();
		output[1] = this.get_y();
		return output;
	}
	,getIndex: function(index) {
		switch(index) {
		case 0:
			return this.get_x();
		case 1:
			return this.get_y();
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
		default:
			throw "out of bounds";
		}
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
	this.set_z(z);
	this.set_w(w);
};
at.dotpoint.math.vector.Vector3.__name__ = true;
at.dotpoint.math.vector.Vector3.__interfaces__ = [at.dotpoint.core.ICloneable,at.dotpoint.math.vector.IVector3];
at.dotpoint.math.vector.Vector3.add = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	output.set_x(a.get_x() + b.get_x());
	output.set_y(a.get_y() + b.get_y());
	output.set_z(a.get_z() + b.get_z());
	return output;
};
at.dotpoint.math.vector.Vector3.subtract = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	output.set_x(a.get_x() - b.get_x());
	output.set_y(a.get_y() - b.get_y());
	output.set_z(a.get_z() - b.get_z());
	return output;
};
at.dotpoint.math.vector.Vector3.scale = function(a,scalar,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	output.set_x(a.get_x() * scalar);
	output.set_y(a.get_y() * scalar);
	output.set_z(a.get_z() * scalar);
	return output;
};
at.dotpoint.math.vector.Vector3.cross = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	output.set_x(a.get_y() * b.get_z() - a.get_z() * b.get_y());
	output.set_y(a.get_z() * b.get_x() - a.get_x() * b.get_z());
	output.set_z(a.get_x() * b.get_y() - a.get_y() * b.get_x());
	return output;
};
at.dotpoint.math.vector.Vector3.dot = function(a,b) {
	return a.get_x() * b.get_x() + a.get_y() * b.get_y() + a.get_z() * b.get_z();
};
at.dotpoint.math.vector.Vector3.multiplyMatrix = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	var x = a.get_x();
	var y = a.get_y();
	var z = a.get_z();
	var w = a.get_w();
	output.set_x(b.m11 * x + b.m12 * y + b.m13 * z + b.m14 * w);
	output.set_y(b.m21 * x + b.m22 * y + b.m23 * z + b.m24 * w);
	output.set_z(b.m31 * x + b.m32 * y + b.m33 * z + b.m34 * w);
	output.set_w(b.m41 * x + b.m42 * y + b.m43 * z + b.m44 * w);
	return output;
};
at.dotpoint.math.vector.Vector3.project = function(a,b,output) {
	if(output == null) output = new at.dotpoint.math.vector.Vector3();
	var l = a.get_x() * a.get_x() + a.get_y() * a.get_y() + a.get_z() * a.get_z();
	if(l == 0) throw "undefined result";
	var d = at.dotpoint.math.vector.Vector3.dot(a,b);
	var div = d / l;
	return at.dotpoint.math.vector.Vector3.scale(a,div,output);
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
at.dotpoint.math.vector.Vector3.isEqual = function(a,b) {
	if(!at.dotpoint.math.MathUtil.isEqual(a.get_x(),b.get_x())) return false;
	if(!at.dotpoint.math.MathUtil.isEqual(a.get_y(),b.get_y())) return false;
	if(!at.dotpoint.math.MathUtil.isEqual(a.get_z(),b.get_z())) return false;
	return true;
};
at.dotpoint.math.vector.Vector3.prototype = {
	clone: function(output) {
		if(output == null) output = new at.dotpoint.math.vector.Vector3();
		output.set_x(this.get_x());
		output.set_y(this.get_y());
		output.set_z(this.get_z());
		output.set_w(this.get_w());
		return output;
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
	,get_z: function() {
		return this.z;
	}
	,set_z: function(value) {
		return this.z = value;
	}
	,get_w: function() {
		return this.w;
	}
	,set_w: function(value) {
		return this.w = value;
	}
	,set: function(x,y,z,w) {
		this.set_x(x);
		this.set_y(y);
		this.set_z(z);
		if(w != null) this.set_w(w);
	}
	,normalize: function() {
		var l = this.length();
		if(l == 0) return;
		var k = 1. / l;
		var _g = this;
		_g.set_x(_g.get_x() * k);
		var _g1 = this;
		_g1.set_y(_g1.get_y() * k);
		var _g2 = this;
		_g2.set_z(_g2.get_z() * k);
	}
	,length: function() {
		return Math.sqrt(this.get_x() * this.get_x() + this.get_y() * this.get_y() + this.get_z() * this.get_z());
	}
	,lengthSq: function() {
		return this.get_x() * this.get_x() + this.get_y() * this.get_y() + this.get_z() * this.get_z();
	}
	,toArray: function(w,output) {
		if(w == null) w = false;
		if(output != null) output = [];
		output[0] = this.get_x();
		output[1] = this.get_y();
		output[2] = this.get_z();
		if(w) output[3] = this.get_w();
		return output;
	}
	,getIndex: function(index) {
		switch(index) {
		case 0:
			return this.get_x();
		case 1:
			return this.get_y();
		case 2:
			return this.get_z();
		case 3:
			return this.get_w();
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
			this.set_z(value);
			break;
		case 3:
			this.set_w(value);
			break;
		default:
			throw "out of bounds";
		}
	}
	,toString: function() {
		return "[Vector3;" + this.get_x() + ", " + this.get_y() + ", " + this.get_z() + ", " + this.get_w() + "]";
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
		split.index = Math.min(a.index,b.index) + Math.min(1,Math.abs(b.index - a.index)) * 0.5;
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
		a.removeNeighbor(b);
		b.removeNeighbor(a);
		a.insertNeighbor(split);
		b.insertNeighbor(split);
		split.insertNeighbor(start);
		split.insertNeighbor(a);
		split.insertNeighbor(b);
		start.insertNeighbor(split);
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
			triangle.p2.insertNeighbor(triangle.p1);
			triangle.p2.insertNeighbor(triangle.p3);
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
			iterator = HxOverrides.iter(current.neighbors);
			previous = current.neighbors[0];
		}
		while(previous != null) {
			var $it0 = HxOverrides.iter(current.neighbors);
			while( $it0.hasNext() ) {
				var neighbor = $it0.next();
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
		var previous = current.neighbors[0];
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
	this.neighbors = [];
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
	,normalize: function() {
		this.coordinate.normalize();
	}
	,length: function() {
		return this.coordinate.length();
	}
	,insertNeighbor: function(vertex) {
		this.neighbors.push(vertex);
		this.neighbors.sort($bind(this,this.sortNeighbors));
	}
	,removeNeighbor: function(vertex) {
		return HxOverrides.remove(this.neighbors,vertex);
	}
	,sortNeighbors: function(a,b) {
		return Math.round(a.index - b.index);
	}
	,toString: function() {
		return "[" + this.index + "]";
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
		var cross = at.dotpoint.math.vector.Vector3.cross(sub1,sub2);
		if(includeZero) return cross.get_z() >= 0; else return cross.get_z() > 0;
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
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
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
