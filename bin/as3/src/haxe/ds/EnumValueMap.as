package haxe.ds {
	import haxe.IMap;
	import haxe.ds.BalancedTree;
	import flash.Boot;
	public class EnumValueMap extends haxe.ds.BalancedTree implements haxe.IMap{
		public function EnumValueMap() : void { if( !flash.Boot.skip_constructor ) {
			super();
		}}
		
		protected override function compare(_tmp_k1 : *,_tmp_k2 : *) : int {
			var k1 : enum = enum(_tmp_k1);
			var k2 : enum = enum(_tmp_k2);
			var d : int = Type.enumIndex(k1) - Type.enumIndex(k2);
			if(d != 0) return d;
			var p1 : Array = Type.enumParameters(k1);
			var p2 : Array = Type.enumParameters(k2);
			if(p1.length == 0 && p2.length == 0) return 0;
			return this.compareArgs(p1,p2);
		}
		
		protected function compareArgs(a1 : Array,a2 : Array) : int {
			var ld : int = a1.length - a2.length;
			if(ld != 0) return ld;
			{
				var _g1 : int = 0;
				var _g : int = a1.length;
				while(_g1 < _g) {
					var i : int = _g1++;
					var d : int = this.compareArg(a1[i],a2[i]);
					if(d != 0) return d;
				}
			};
			return 0;
		}
		
		protected function compareArg(v1 : *,v2 : *) : int {
			if(Reflect.isEnumValue(v1) && Reflect.isEnumValue(v2)) return this.compare(v1,v2);
			else if(Std._is(v1,Array) && Std._is(v2,Array)) return this.compareArgs(v1,v2);
			else return Reflect.compare(v1,v2);
			return 0;
		}
		
	}
}
