package haxe.ds {
	import flash.Boot;
	public class TreeNode {
		public function TreeNode(l : haxe.ds.TreeNode = null,k : * = null,v : * = null,r : haxe.ds.TreeNode = null,h : int = -1) : void { if( !flash.Boot.skip_constructor ) {
			this.left = l;
			this.key = k;
			this.value = v;
			this.right = r;
			if(h == -1) this._height = ((((function($this:TreeNode) : int {
				var $r : int;
				var _this : haxe.ds.TreeNode = $this.left;
				$r = ((_this == null)?0:_this._height);
				return $r;
			}(this)) > (function($this:TreeNode) : int {
				var $r2 : int;
				var _this1 : haxe.ds.TreeNode = $this.right;
				$r2 = ((_this1 == null)?0:_this1._height);
				return $r2;
			}(this)))?(function($this:TreeNode) : int {
				var $r3 : int;
				var _this2 : haxe.ds.TreeNode = $this.left;
				$r3 = ((_this2 == null)?0:_this2._height);
				return $r3;
			}(this)):(function($this:TreeNode) : int {
				var $r4 : int;
				var _this3 : haxe.ds.TreeNode = $this.right;
				$r4 = ((_this3 == null)?0:_this3._height);
				return $r4;
			}(this)))) + 1;
			else this._height = h;
		}}
		
		public var left : haxe.ds.TreeNode;
		public var right : haxe.ds.TreeNode;
		public var key : *;
		public var value : *;
		public var _height : int;
		public function toString() : String {
			return (((this.left == null)?"":this.left.toString() + ", ")) + ("" + Std.string(this.key) + "=" + Std.string(this.value)) + (((this.right == null)?"":", " + this.right.toString()));
		}
		
	}
}
