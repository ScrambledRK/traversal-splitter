package haxe.ds {
	import haxe.IMap;
	import flash.utils.Dictionary;
	import flash.Boot;
	public class IntMap implements haxe.IMap{
		public function IntMap() : void { if( !flash.Boot.skip_constructor ) {
			this.h = new flash.utils.Dictionary();
		}}
		
		protected var h : flash.utils.Dictionary;
		public function set(_tmp_key : *,value : *) : void {
			var key : int = int(_tmp_key);
			this.h[key] = value;
		}
		
		public function get(_tmp_key : *) : * {
			var key : int = int(_tmp_key);
			return this.h[key];
		}
		
		public function exists(_tmp_key : *) : Boolean {
			var key : int = int(_tmp_key);
			return (key in this.h);
		}
		
		public function remove(_tmp_key : *) : Boolean {
			var key : int = int(_tmp_key);
			if(!this.exists(key)) return false;
			delete(this.h[key]);
			return true;
		}
		
		public function keys() : * {
			return (function($this:IntMap) : * {
				var $r : *;
				$r = new Array();
				for(var $k2 : String in $this.h) $r.push($k2);
				return $r;
			}(this)).iterator();
		}
		
		public function iterator() : * {
			return { ref : this.h, it : this.keys(), hasNext : function() : Boolean {
				return this.it.hasNext();
			}, next : function() : * {
				var i : int = this.it.next();
				return this.ref[i];
			}}
		}
		
		public function toString() : String {
			var s : StringBuf = new StringBuf();
			s.add("{");
			var it : * = this.keys();
			{ var $it : * = it;
			while( $it.hasNext() ) { var i : int = $it.next();
			{
				s.add(i);
				s.add(" => ");
				s.add(Std.string(this.get(i)));
				if(it.hasNext()) s.add(", ");
			}
			}};
			s.add("}");
			return s.toString();
		}
		
	}
}
