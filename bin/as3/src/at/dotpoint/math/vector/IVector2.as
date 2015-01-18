package at.dotpoint.math.vector {
	public interface IVector2 {
		function get_x() : Number ;
		function set_x(value : Number) : Number ;
		function get_y() : Number ;
		function set_y(value : Number) : Number ;
		
		
		function normalize() : void ;
		function length() : Number ;
	}
}
