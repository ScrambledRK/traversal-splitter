package haxe.ds {
	import haxe.IMap;
	import flash.Boot;
	import flash.utils.Dictionary;
	public class WeakMap extends flash.utils.Dictionary implements haxe.IMap{
		public function WeakMap() : void { if( !flash.Boot.skip_constructor ) {
			super(true);
		}}
		
		public function get(_tmp_key : *) : * {
			var key : * = _tmp_key;
			return this[key];
		}
		
		public function set(_tmp_key : *,value : *) : void {
			var key : * = _tmp_key;
			this[key] = value;
		}
		
		public function exists(_tmp_key : *) : Boolean {
			var key : * = _tmp_key;
			return this[key] != null;
		}
		
		public function remove(_tmp_key : *) : Boolean {
			var key : * = _tmp_key;
			var has : Boolean = this.exists(key);
			delete(this[key]);
			return has;
		}
		
		public function keys() : * {
			return (function($this:WeakMap) : * {
				var $r : *;
				$r = new Array();
				for(var $k2 : String in $this) $r.push($k2);
				return $r;
			}(this)).iterator();
		}
		
		public function iterator() : * {
			var ret : Array = [];
			{ var $it : * = this.keys();
			while( $it.hasNext() ) { var i : * = $it.next();
			ret.push(this.get(i));
			}};
			return ret.iterator();
		}
		
		public function toString() : String {
			var s : String = "";
			var it : * = this.keys();
			{ var $it : * = it;
			while( $it.hasNext() ) { var i : * = $it.next();
			{
				s += (((s == "")?"":",")) + Std.string(i);
				s += " => ";
				s += Std.string(this.get(i));
			}
			}};
			return s + "}";
		}
		
	}
}
