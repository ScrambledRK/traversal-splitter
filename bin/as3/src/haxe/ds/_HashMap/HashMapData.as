package haxe.ds._HashMap {
	import haxe.ds.IntMap;
	import flash.Boot;
	public class HashMapData {
		public function HashMapData() : void { if( !flash.Boot.skip_constructor ) {
			this.keys = new haxe.ds.IntMap();
			this.values = new haxe.ds.IntMap();
		}}
		
		public var keys : haxe.ds.IntMap;
		public var values : haxe.ds.IntMap;
	}
}
