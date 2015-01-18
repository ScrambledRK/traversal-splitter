package view {
	import flash.display.Sprite;
	import at.dotpoint.math.vector.IVector2;
	import at.dotpoint.math.geom.Rectangle;
	import flash.display.Shape;
	import flash.text.TextField;
	import haxe.ds.ObjectMap;
	import flash.Boot;
	public class CanvasView extends flash.display.Sprite implements IPartitionDebugger{
		public function CanvasView() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.countRectangle = 0;
			this.countVertex = 0;
			this.debugRectangle = new haxe.ds.ObjectMap();
			this.debugVertex = new haxe.ds.ObjectMap();
			this.canvas = new flash.display.Sprite();
			this.addChild(this.canvas);
		}}
		
		public var debugVertex : haxe.ds.ObjectMap;
		public var countVertex : int;
		public var debugRectangle : haxe.ds.ObjectMap;
		public var countRectangle : int;
		public var canvas : flash.display.Sprite;
		public function drawOutline(list : Array) : void {
			var shape : flash.display.Shape = new flash.display.Shape();
			shape.graphics.lineStyle(8,Std._int(16777215 * Math.random()),0.35);
			{
				var _g1 : int = 0;
				var _g : int = list.length + 1;
				while(_g1 < _g) {
					var v : int = _g1++;
					var vertex : at.dotpoint.math.vector.IVector2 = list[v % list.length];
					if(v == 0) shape.graphics.moveTo(vertex.get_x(),vertex.get_y());
					else shape.graphics.lineTo(vertex.get_x(),vertex.get_y());
					var debug : flash.text.TextField = new flash.text.TextField();
					debug.text = this.getDebugVertex(vertex);
					debug.x = vertex.get_x();
					debug.y = vertex.get_y();
					this.canvas.addChild(debug);
				}
			};
			this.canvas.addChild(shape);
			var bounds : at.dotpoint.math.geom.Rectangle = this.calculateBoundings(list);
			this.canvas.x -= bounds.get_x() - 15;
			this.canvas.y -= bounds.get_y() - 25;
		}
		
		public function drawPartition(area : at.dotpoint.math.geom.Rectangle) : void {
			var color : int = Std._int(16777215 * Math.random());
			var shape : flash.display.Shape = new flash.display.Shape();
			shape.graphics.lineStyle(1,color);
			shape.graphics.beginFill(color,0.1);
			shape.graphics.drawRect(area.get_x(),area.get_y(),area.get_width(),area.get_height());
			shape.graphics.endFill();
			this.canvas.addChild(shape);
			var debug : flash.text.TextField = new flash.text.TextField();
			debug.text = this.getDebugRectangle(area);
			debug.x = area.get_x() + area.get_width() * 0.5;
			debug.y = area.get_y() + area.get_height() * 0.5;
			this.canvas.addChild(debug);
		}
		
		public function drawSplitLine(a : at.dotpoint.math.vector.IVector2,b : at.dotpoint.math.vector.IVector2) : void {
			var shape : flash.display.Shape = new flash.display.Shape();
			shape.graphics.lineStyle(4,0,0.65);
			shape.graphics.moveTo(a.get_x(),a.get_y());
			shape.graphics.lineTo(b.get_x(),b.get_y());
			this.canvas.addChild(shape);
		}
		
		public function drawSplitStart(a : at.dotpoint.math.vector.IVector2) : void {
			var shape : flash.display.Shape = new flash.display.Shape();
			shape.graphics.lineStyle(2,16711680,0.85);
			shape.graphics.drawCircle(a.get_x(),a.get_y(),4);
			this.canvas.addChild(shape);
		}
		
		public function drawSplitEnd(a : at.dotpoint.math.vector.IVector2) : void {
			var shape : flash.display.Shape = new flash.display.Shape();
			shape.graphics.lineStyle(2,0,0.85);
			shape.graphics.drawCircle(a.get_x(),a.get_y(),4);
			this.canvas.addChild(shape);
			var debug : flash.text.TextField = new flash.text.TextField();
			debug.text = this.getDebugVertex(a);
			debug.x = a.get_x();
			debug.y = a.get_y();
			this.canvas.addChild(debug);
		}
		
		public function getDebugVertex(vertex : at.dotpoint.math.vector.IVector2) : String {
			if(!this.debugVertex.exists(vertex)) this.setDebugVertex(vertex);
			return this.debugVertex.get(vertex);
		}
		
		public function setDebugVertex(vertex : at.dotpoint.math.vector.IVector2) : void {
			var index : int = this.countVertex++;
			var value : String = "[" + index + "]";
			this.debugVertex.set(vertex,value);
		}
		
		public function getDebugRectangle(rectangle : at.dotpoint.math.geom.Rectangle) : String {
			if(!this.debugRectangle.exists(rectangle)) this.setDebugRectangle(rectangle);
			return this.debugRectangle.get(rectangle);
		}
		
		public function setDebugRectangle(rectangle : at.dotpoint.math.geom.Rectangle) : void {
			var letters : Array = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q"];
			var index : int = this.countRectangle++;
			var value : String = "[" + letters[index % letters.length] + "]";
			this.debugRectangle.set(rectangle,value);
		}
		
		public function calculateBoundings(coordinates : Array) : at.dotpoint.math.geom.Rectangle {
			var bounding : at.dotpoint.math.geom.Rectangle = new at.dotpoint.math.geom.Rectangle();
			{
				var _g1 : int = 0;
				var _g : int = coordinates.length;
				while(_g1 < _g) {
					var v : int = _g1++;
					var x : Number = coordinates[v].get_x();
					var y : Number = coordinates[v].get_y();
					var nl : Number;
					if(v == 0) nl = x;
					else nl = Math.min(bounding.get_left(),x);
					var nr : Number;
					if(v == 0) nr = x;
					else nr = Math.max(bounding.get_right(),x);
					var nt : Number;
					if(v == 0) nt = y;
					else nt = Math.min(bounding.get_top(),y);
					var nb : Number;
					if(v == 0) nb = y;
					else nb = Math.max(bounding.get_bottom(),y);
					if(nl != bounding.get_left() || nr != bounding.get_right() || nt != bounding.get_top() || nb != bounding.get_bottom()) {
						bounding.set_right(nr);
						bounding.set_left(nl);
						bounding.set_bottom(nb);
						bounding.set_top(nt);
					}
				}
			};
			return bounding;
		}
		
	}
}
