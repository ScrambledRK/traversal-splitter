package haxe.ds._ObjectMap {
	public class NativeValueIterator {
		public function NativeValueIterator() : void {
		}
		
		public var collection : *;
		protected var index : int = 0;
		public function hasNext() : Boolean {
			var c : * = this.collection;
			var i : int = this.index;
			var result : Boolean = __has_next__(c,i);
			this.collection = c;
			this.index = i;
			return result;
		}
		
		public function next() : * {
			var i : int = this.index;
			var result : * = __foreach__(this.collection,i);
			this.index = i;
			return result;
		}
		
		static public function iterator(collection : *) : haxe.ds._ObjectMap.NativeValueIterator {
			var result : haxe.ds._ObjectMap.NativeValueIterator = new haxe.ds._ObjectMap.NativeValueIterator();
			result.collection = collection;
			return result;
		}
		
	}
}
