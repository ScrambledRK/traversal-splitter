package haxe.ds._HashMap {
	import haxe.ds._HashMap.HashMapData;
	public class HashMap_Impl_ {
		static public function _new() : haxe.ds._HashMap.HashMapData {
			return new haxe.ds._HashMap.HashMapData();
		}
		
		static public function set(this1 : haxe.ds._HashMap.HashMapData,k : *,v : *) : void {
			this1.keys.set(k.hashCode(),k);
			this1.values.set(k.hashCode(),v);
		}
		
		static public function get(this1 : haxe.ds._HashMap.HashMapData,k : *) : * {
			return this1.values.get(k.hashCode());
		}
		
		static public function exists(this1 : haxe.ds._HashMap.HashMapData,k : *) : Boolean {
			return this1.values.exists(k.hashCode());
		}
		
		static public function remove(this1 : haxe.ds._HashMap.HashMapData,k : *) : Boolean {
			this1.values.remove(k.hashCode());
			return this1.keys.remove(k.hashCode());
		}
		
		static public function keys(this1 : haxe.ds._HashMap.HashMapData) : * {
			return this1.keys.iterator();
		}
		
		static public function iterator(this1 : haxe.ds._HashMap.HashMapData) : * {
			return this1.values.iterator();
		}
		
	}
}
