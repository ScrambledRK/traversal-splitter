package view {
	import flash.events.Event;
	import flash.text.TextFieldType;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	import flash.display.DisplayObject;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.Boot;
	public class ControllerView extends flash.display.Sprite {
		public function ControllerView() : void { if( !flash.Boot.skip_constructor ) {
			super();
			this.presets = new Array();
			this.presets.push("740 917 740 747 540 747 540 637 390 637 390 527 260 527 260 427 130 427 130 177 710 177 710 87 950 87 950 257 1090 257 1090 387 1220 387 1220 567 1340 567 1340 767 1080 767 1080 917");
			this.presets.push("68 139 223 139 223 216 382 216 382 45 791 45 791 329 923 329 923 564 858 564 858 505 665 505 665 410 562 410 562 670 730 670 730 740 296 740 296 450 68 450 68 139");
			this.presets.push("164 156 164 280 230 280 230 373 299 373 299 218 361 218 361 156 164 156");
			this.presets.push("132 112 468 112 468 429 352 429 352 287 249 287 249 529 132 529 132 112");
			this.presets.push("133 63 500 63 500 339 458 339 458 416 564 416 564 623 133 623 133 63");
			this.presets.push("584 143 584 592 756 592 756 379 860 379 860 143");
			this.createUI();
		}}
		
		public var presets : Array;
		public var inputField : flash.text.TextField;
		public var resultField : flash.text.TextField;
		public function get input() : String { return get_input(); }
		public function set input( __v : String ) : void { set_input(__v); }
		protected var $input : String;
		public function get output() : String { return get_output(); }
		public function set output( __v : String ) : void { set_output(__v); }
		protected var $output : String;
		public function get_input() : String {
			return this.inputField.text;
		}
		
		public function set_input(value : String) : String {
			return this.inputField.text = value;
		}
		
		public function get_output() : String {
			return this.resultField.text;
		}
		
		public function set_output(value : String) : String {
			return this.resultField.text = value;
		}
		
		public function createUI() : void {
			var input : flash.display.DisplayObject = this.createInputBox();
			var output : flash.display.DisplayObject = this.createOutputBox();
			output.y = input.y + input.height + 10;
			this.addChild(input);
			this.addChild(output);
			this.selectInput(0);
		}
		
		public function onCalculate(value : flash.events.Event) : void {
			this.set_output("processing ... ");
			this.dispatchEvent(new flash.events.Event("calculate"));
		}
		
		public function onInputSelected(value : flash.events.Event) : void {
			var item : flash.text.TextField = flash.text.TextField(value.target);
			var index : int = this.presets.indexOf(item.text);
			if(index < 0) this.set_output("error: preset not found");
			this.selectInput(index);
		}
		
		public function selectInput(index : int) : void {
			this.set_input(this.presets[index]);
			this.set_output("press 'calculate' to process");
		}
		
		public function createInputBox() : flash.display.DisplayObject {
			var presetList : flash.display.Sprite = this.createPresetList();
			var inputField : flash.display.Sprite = this.createInputField();
			inputField.y = presetList.height + 15;
			var vbox : flash.display.Sprite = new flash.display.Sprite();
			vbox.addChild(presetList);
			vbox.addChild(inputField);
			return vbox;
		}
		
		public function createPresetList() : flash.display.Sprite {
			var presetList : flash.display.Sprite = new flash.display.Sprite();
			var y : Number = 0;
			{
				var _g : int = 0;
				var _g1 : Array = this.presets;
				while(_g < _g1.length) {
					var preset : String = _g1[_g];
					++_g;
					var item : flash.text.TextField = new flash.text.TextField();
					item.autoSize = flash.text.TextFieldAutoSize.LEFT;
					item.text = preset;
					item.selectable = false;
					item.addEventListener(flash.events.MouseEvent.CLICK,this.onInputSelected);
					item.y = y;
					presetList.addChild(item);
					y += item.height;
				}
			};
			return presetList;
		}
		
		public function createInputField() : flash.display.Sprite {
			this.inputField = new flash.text.TextField();
			this.inputField.type = flash.text.TextFieldType.INPUT;
			this.inputField.autoSize = flash.text.TextFieldAutoSize.LEFT;
			this.inputField.border = true;
			var calculate : flash.text.TextField = new flash.text.TextField();
			calculate.text = ">> calculate <<";
			calculate.border = true;
			calculate.addEventListener(flash.events.MouseEvent.CLICK,this.onCalculate);
			calculate.y = this.inputField.height + 5;
			calculate.autoSize = flash.text.TextFieldAutoSize.LEFT;
			calculate.selectable = false;
			var hbox : flash.display.Sprite = new flash.display.Sprite();
			hbox.addChild(this.inputField);
			hbox.addChild(calculate);
			return hbox;
		}
		
		public function createOutputBox() : flash.display.DisplayObject {
			this.resultField = new flash.text.TextField();
			this.resultField.autoSize = flash.text.TextFieldAutoSize.LEFT;
			return this.resultField;
		}
		
	}
}
