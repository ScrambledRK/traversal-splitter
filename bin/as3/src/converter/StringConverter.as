package converter {
	import at.dotpoint.math.vector.Vector2;
	import flash.Boot;
	public class StringConverter implements IPolygonConverter{
		public function StringConverter(seperator : String = null) : void { if( !flash.Boot.skip_constructor ) {
			if(seperator == null) seperator = " ";
			this.seperator = seperator;
		}}
		
		public var seperator : String;
		public function convert(_tmp_input : *) : Array {
			var input : String = String(_tmp_input);
			var coordinates : Array = new Array();
			var splitted : Array = input.split(this.seperator);
			var length : int = Std._int(splitted.length * 0.5);
			{
				var _g : int = 0;
				while(_g < length) {
					var j : int = _g++;
					var index : int = j * 2;
					var point : at.dotpoint.math.vector.Vector2 = new at.dotpoint.math.vector.Vector2();
					point.set_x(Std._parseInt(splitted[index]));
					point.set_y(Std._parseInt(splitted[index + 1]));
					coordinates.push(point);
				}
			};
			if(coordinates.length == 0) throw "input string does not contain parsable float or integer coordinates or does not use " + this.seperator + " as seperator";
			return coordinates;
		}
		
	}
}
