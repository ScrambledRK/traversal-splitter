package haxe.ds._WeakMap {
	public class NativePropertyIterator {
		public function NativePropertyIterator() : void {
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
			var result : * = __forin__(this.collection,i);
			this.index = i;
			return result;
		}
		
		static public function iterator(collection : *) : haxe.ds._WeakMap.NativePropertyIterator {
			var result : haxe.ds._WeakMap.NativePropertyIterator = new haxe.ds._WeakMap.NativePropertyIterator();
			result.collection = collection;
			return result;
		}
		
	}
}
