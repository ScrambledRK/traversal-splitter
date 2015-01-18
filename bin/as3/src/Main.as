// Compile __main__.as instead
package  {
	import flash.events.Event;
	import flash.Lib;
	import converter.StringConverter;
	import calculator.TraversalSplitter;
	import view.CanvasView;
	import flash.display.StageScaleMode;
	import view.ControllerView;
	import flash.display.StageAlign;
	import flash.Boot;
	public class Main {
		public function Main() : void { if( !flash.Boot.skip_constructor ) {
			this.initialize();
		}}
		
		public var calculator : IPartitionCalculator;
		public var controller : view.ControllerView;
		public var canvas : view.CanvasView;
		public function initialize() : void {
			this.calculator = new calculator.TraversalSplitter();
			this.setupController();
			this.onCalculate(null);
		}
		
		public function calculate(input : *) : * {
			var input1 : Array = this.parseInput(input);
			var result : Array = this.calculator.calculate(input1);
			return result;
		}
		
		public function parseInput(input : *) : Array {
			var output : Array = null;
			if(Std._is(input,String)) output = new converter.StringConverter().convert(String(input));
			if(output == null) throw "unable to convert given input " + Std.string(input);
			return output;
		}
		
		public function setupController() : void {
			flash.Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
			flash.Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
			this.controller = new view.ControllerView();
			this.controller.addEventListener("calculate",this.onCalculate);
			flash.Lib.current.stage.addChild(this.controller);
		}
		
		public function setupCanvas() : void {
			if(this.canvas != null) {
				flash.Lib.current.stage.removeChild(this.canvas);
				this.canvas = null;
			};
			this.canvas = new view.CanvasView();
			this.canvas.x = 15;
			this.canvas.y = this.controller.y + this.controller.height;
			flash.Lib.current.stage.addChild(this.canvas);
		}
		
		public function onCalculate(value : flash.events.Event) : void {
			this.setupCanvas();
			try {
				this.controller.set_output(this.calculate(this.controller.get_input()).toString());
			}
			catch( error : * ){
				this.controller.set_output("error: " + Std.string(error));
			}
		}
		
		static public var instance : Main;
		static public function main() : void {
			Main.instance = new Main();
		}
		
	}
}
