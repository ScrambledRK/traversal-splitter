package haxe.ds {
	import haxe.ds.TreeNode;
	public class BalancedTree {
		public function BalancedTree() : void {
		}
		
		protected var root : haxe.ds.TreeNode;
		public function set(key : *,value : *) : void {
			this.root = this.setLoop(key,value,this.root);
		}
		
		public function get(key : *) : * {
			var node : haxe.ds.TreeNode = this.root;
			while(node != null) {
				var c : int = this.compare(key,node.key);
				if(c == 0) return node.value;
				if(c < 0) node = node.left;
				else node = node.right;
			};
			return null;
		}
		
		public function remove(key : *) : Boolean {
			try {
				this.root = this.removeLoop(key,this.root);
				return true;
			}
			catch( e : String ){
				return false;
			};
			return false;
		}
		
		public function exists(key : *) : Boolean {
			var node : haxe.ds.TreeNode = this.root;
			while(node != null) {
				var c : int = this.compare(key,node.key);
				if(c == 0) return true;
				else if(c < 0) node = node.left;
				else node = node.right;
			};
			return false;
		}
		
		public function iterator() : * {
			var ret : Array = [];
			this.iteratorLoop(this.root,ret);
			return ret.iterator();
		}
		
		public function keys() : * {
			var ret : Array = [];
			this.keysLoop(this.root,ret);
			return ret.iterator();
		}
		
		protected function setLoop(k : *,v : *,node : haxe.ds.TreeNode) : haxe.ds.TreeNode {
			if(node == null) return new haxe.ds.TreeNode(null,k,v,null);
			var c : int = this.compare(k,node.key);
			if(c == 0) return new haxe.ds.TreeNode(node.left,k,v,node.right,((node == null)?0:node._height));
			else if(c < 0) {
				var nl : haxe.ds.TreeNode = this.setLoop(k,v,node.left);
				return this.balance(nl,node.key,node.value,node.right);
			}
			else {
				var nr : haxe.ds.TreeNode = this.setLoop(k,v,node.right);
				return this.balance(node.left,node.key,node.value,nr);
			};
			return null;
		}
		
		protected function removeLoop(k : *,node : haxe.ds.TreeNode) : haxe.ds.TreeNode {
			if(node == null) throw "Not_found";
			var c : int = this.compare(k,node.key);
			if(c == 0) return this.merge(node.left,node.right);
			else if(c < 0) return this.balance(this.removeLoop(k,node.left),node.key,node.value,node.right);
			else return this.balance(node.left,node.key,node.value,this.removeLoop(k,node.right));
			return null;
		}
		
		protected function iteratorLoop(node : haxe.ds.TreeNode,acc : Array) : void {
			if(node != null) {
				this.iteratorLoop(node.left,acc);
				acc.push(node.value);
				this.iteratorLoop(node.right,acc);
			}
		}
		
		protected function keysLoop(node : haxe.ds.TreeNode,acc : Array) : void {
			if(node != null) {
				this.keysLoop(node.left,acc);
				acc.push(node.key);
				this.keysLoop(node.right,acc);
			}
		}
		
		protected function merge(t1 : haxe.ds.TreeNode,t2 : haxe.ds.TreeNode) : haxe.ds.TreeNode {
			if(t1 == null) return t2;
			if(t2 == null) return t1;
			var t : haxe.ds.TreeNode = this.minBinding(t2);
			return this.balance(t1,t.key,t.value,this.removeMinBinding(t2));
		}
		
		protected function minBinding(t : haxe.ds.TreeNode) : haxe.ds.TreeNode {
			if(t == null) throw "Not_found";
			else if(t.left == null) return t;
			else return this.minBinding(t.left);
			return null;
		}
		
		protected function removeMinBinding(t : haxe.ds.TreeNode) : haxe.ds.TreeNode {
			if(t.left == null) return t.right;
			else return this.balance(this.removeMinBinding(t.left),t.key,t.value,t.right);
			return null;
		}
		
		protected function balance(l : haxe.ds.TreeNode,k : *,v : *,r : haxe.ds.TreeNode) : haxe.ds.TreeNode {
			var hl : int;
			if(l == null) hl = 0;
			else hl = l._height;
			var hr : int;
			if(r == null) hr = 0;
			else hr = r._height;
			if(hl > hr + 2) {
				if((function($this:BalancedTree) : int {
					var $r : int;
					var _this : haxe.ds.TreeNode = l.left;
					$r = ((_this == null)?0:_this._height);
					return $r;
				}(this)) >= (function($this:BalancedTree) : int {
					var $r2 : int;
					var _this1 : haxe.ds.TreeNode = l.right;
					$r2 = ((_this1 == null)?0:_this1._height);
					return $r2;
				}(this))) return new haxe.ds.TreeNode(l.left,l.key,l.value,new haxe.ds.TreeNode(l.right,k,v,r));
				else return new haxe.ds.TreeNode(new haxe.ds.TreeNode(l.left,l.key,l.value,l.right.left),l.right.key,l.right.value,new haxe.ds.TreeNode(l.right.right,k,v,r));
			}
			else if(hr > hl + 2) {
				if((function($this:BalancedTree) : int {
					var $r3 : int;
					var _this2 : haxe.ds.TreeNode = r.right;
					$r3 = ((_this2 == null)?0:_this2._height);
					return $r3;
				}(this)) > (function($this:BalancedTree) : int {
					var $r4 : int;
					var _this3 : haxe.ds.TreeNode = r.left;
					$r4 = ((_this3 == null)?0:_this3._height);
					return $r4;
				}(this))) return new haxe.ds.TreeNode(new haxe.ds.TreeNode(l,k,v,r.left),r.key,r.value,r.right);
				else return new haxe.ds.TreeNode(new haxe.ds.TreeNode(l,k,v,r.left.left),r.left.key,r.left.value,new haxe.ds.TreeNode(r.left.right,r.key,r.value,r.right));
			}
			else return new haxe.ds.TreeNode(l,k,v,r,(((hl > hr)?hl:hr)) + 1);
			return null;
		}
		
		protected function compare(k1 : *,k2 : *) : int {
			return Reflect.compare(k1,k2);
		}
		
		public function toString() : String {
			if(this.root == null) return "{}";
			else return "{" + this.root.toString() + "}";
			return null;
		}
		
	}
}
