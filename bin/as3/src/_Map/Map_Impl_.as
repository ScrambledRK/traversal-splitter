package _Map {
	import haxe.IMap;
	import haxe.ds.IntMap;
	import haxe.ds.EnumValueMap;
	import haxe.ds.ObjectMap;
	import haxe.ds.StringMap;
	public class Map_Impl_ {
		static public var _new : Function;
		static public function set(this1 : haxe.IMap,key : *,value : *) : void {
			this1.set(key,value);
		}
		
		static public function get(this1 : haxe.IMap,key : *) : * {
			return this1.get(key);
		}
		
		static public function exists(this1 : haxe.IMap,key : *) : Boolean {
			return this1.exists(key);
		}
		
		static public function remove(this1 : haxe.IMap,key : *) : Boolean {
			return this1.remove(key);
		}
		
		static public function keys(this1 : haxe.IMap) : * {
			return this1.keys();
		}
		
		static public function iterator(this1 : haxe.IMap) : * {
			return this1.iterator();
		}
		
		static public function toString(this1 : haxe.IMap) : String {
			return this1.toString();
		}
		
		static public function arrayWrite(this1 : haxe.IMap,k : *,v : *) : * {
			this1.set(k,v);
			return v;
		}
		
		static public function toStringMap(t : haxe.IMap) : haxe.ds.StringMap {
			return new haxe.ds.StringMap();
		}
		
		static public function toIntMap(t : haxe.IMap) : haxe.ds.IntMap {
			return new haxe.ds.IntMap();
		}
		
		static public function toEnumValueMapMap(t : haxe.IMap) : haxe.ds.EnumValueMap {
			return new haxe.ds.EnumValueMap();
		}
		
		static public function toObjectMap(t : haxe.IMap) : haxe.ds.ObjectMap {
			return new haxe.ds.ObjectMap();
		}
		
		static public function fromStringMap(map : haxe.ds.StringMap) : haxe.ds.StringMap {
			return haxe.ds.StringMap(map);
		}
		
		static public function fromIntMap(map : haxe.ds.IntMap) : haxe.ds.IntMap {
			return haxe.ds.IntMap(map);
		}
		
		static public function fromObjectMap(map : haxe.ds.ObjectMap) : haxe.ds.ObjectMap {
			return haxe.ds.ObjectMap(map);
		}
		
	}
}
