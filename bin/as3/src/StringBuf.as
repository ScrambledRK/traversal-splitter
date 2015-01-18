package  {
	import flash.Boot;
	public class StringBuf {
		public function StringBuf() : void { if( !flash.Boot.skip_constructor ) {
			this.b = "";
		}}
		
		protected var b : String;
		public function get length() : int { return get_length(); }
		public function set length( __v : int ) : void { $length = __v; }
		protected var $length : int;
		public function get_length() : int {
			return this.b.length;
		}
		
		public function add(x : *) : void {
			this.b += Std.string(x);
		}
		
		public function addChar(c : int) : void {
			this.b += String.fromCharCode(c);
		}
		
		public function addSub(s : String,pos : int,len : * = null) : void {
			if(len == null) this.b += s.substr(pos);
			else this.b += s.substr(pos,len);
		}
		
		public function toString() : String {
			return this.b;
		}
		
	}
}
