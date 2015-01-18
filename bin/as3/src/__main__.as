package  {
	import flash.Boot;
	import flash.Lib;
	public class __main__ extends flash.Boot {
		public function __main__() {
			super();
			flash.Lib.current = this;
			{
				Math["NaN"] = Number.NaN;
				Math["NEGATIVE_INFINITY"] = Number.NEGATIVE_INFINITY;
				Math["POSITIVE_INFINITY"] = Number.POSITIVE_INFINITY;
				Math["isFinite"] = function(i : Number) : Boolean {
					return isFinite(i);
				};
				Math["isNaN"] = function(i1 : Number) : Boolean {
					return isNaN(i1);
				}
			}
			{
				var aproto : * = Array.prototype;
				aproto.copy = function() : * {
					return this.slice();
				};
				aproto.insert = function(i : *,x : *) : void {
					this.splice(i,0,x);
				};
				aproto.remove = function(obj : *) : Boolean {
					var idx : int = this.indexOf(obj);
					if(idx == -1) return false;
					this.splice(idx,1);
					return true;
				};
				aproto.iterator = function() : * {
					var cur : int = 0;
					var arr : Array = this;
					return { hasNext : function() : Boolean {
						return cur < arr.length;
					}, next : function() : * {
						return arr[cur++];
					}}
				};
				aproto.setPropertyIsEnumerable("copy",false);
				aproto.setPropertyIsEnumerable("insert",false);
				aproto.setPropertyIsEnumerable("remove",false);
				aproto.setPropertyIsEnumerable("iterator",false);
				aproto.filterHX = function(f : Function) : Array {
					var ret : Array = [];
					var i1 : int = 0;
					var l : int = this.length;
					while(i1 < l) {
						if(f(this[i1])) ret.push(this[i1]);
						i1++;
					};
					return ret;
				};
				aproto.mapHX = function(f1 : Function) : Array {
					var ret1 : Array = [];
					var i2 : int = 0;
					var l1 : int = this.length;
					while(i2 < l1) {
						ret1.push(f1(this[i2]));
						i2++;
					};
					return ret1;
				};
				aproto.setPropertyIsEnumerable("mapHX",false);
				aproto.setPropertyIsEnumerable("filterHX",false);
				String.prototype.charCodeAtHX = function(i3 : *) : * {
					var s : String = this;
					var x1 : Number = s.charCodeAt(i3);
					if(isNaN(x1)) return null;
					return Std._int(x1);
				}
			}
			Main.main();
		}
	}
}
