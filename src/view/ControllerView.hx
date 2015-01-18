package view;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;

/**
 * ...
 * @author RK
 */
class ControllerView extends Sprite
{
	
	/**
	 * 
	 */
	private var presets:Array<String>;
	
	// ----------------- //
	
	/**
	 * 
	 */
	private var inputField:TextField;
	
	/**
	 * 
	 */
	private var resultField:TextField;	
	
	// ----------------- //
	
	/**
	 * 
	 */
	public var input(get, set):String;
	
	/**
	 * 
	 */
	public var output(get, set):String;
	
	// ************************************************************************ //
	// Constructor
	// ************************************************************************ //	
	
	public function new() 
	{
		super();
		
		this.presets = new Array<String>();		
		this.presets.push( "740 917 740 747 540 747 540 637 390 637 390 527 260 527 260 427 130 427 130 177 710 177 710 87 950 87 950 257 1090 257 1090 387 1220 387 1220 567 1340 567 1340 767 1080 767 1080 917" 		);
		this.presets.push( "68 139 223 139 223 216 382 216 382 45 791 45 791 329 923 329 923 564 858 564 858 505 665 505 665 410 562 410 562 670 730 670 730 740 296 740 296 450 68 450 68 139" 		);
		this.presets.push( "164 156 164 280 230 280 230 373 299 373 299 218 361 218 361 156 164 156" 		);
		this.presets.push( "132 112 468 112 468 429 352 429 352 287 249 287 249 529 132 529 132 112" 		);
		this.presets.push( "133 63 500 63 500 339 458 339 458 416 564 416 564 623 133 623 133 63" 			);
		this.presets.push( "584 143 584 592 756 592 756 379 860 379 860 143" 								);		
		
		this.createUI();
	}
	
	// ************************************************************************ //
	// getter / setter
	// ************************************************************************ //	
	
	/**
	 * 
	 * @return
	 */
	private function get_input():String { return this.inputField.text; }
	
	private function set_input( value:String ):String 
	{ 
		return this.inputField.text = value; 
	}
	
	/**
	 * 
	 * @return
	 */
	private function get_output():String { return this.resultField.text; }
	
	private function set_output( value:String ):String 
	{ 
		return this.resultField.text = value; 
	}
	
	// ************************************************************************ //
	// Methods
	// ************************************************************************ //	
	
	/**
	 * 
	 */
	private function createUI():Void
	{
		var input:DisplayObject  = this.createInputBox();	
		var output:DisplayObject = this.createOutputBox();	
			output.y = input.y + input.height + 10;
		
		this.addChild( input );
		this.addChild( output );
		
		this.selectInput( 0 );
	}
	
	/**
	 * 
	 * @param	event
	 */
	private function onCalculate( value:Event ):Void 
	{		
		this.output = "processing ... ";
		this.dispatchEvent( new Event("calculate") );
	}
	
	/**
	 * 
	 * @param	event
	 */
	private function onInputSelected( value:Event ):Void
	{
		var item:TextField 	= cast value.target;		
		var index:Int 		= this.presets.indexOf( item.text );
		
		if( index < 0 )
			this.output = "error: preset not found";
		
		this.selectInput( index );
	}
	
	/**
	 * 
	 * @param	index
	 */
	private function selectInput( index:Int ):Void
	{
		this.input 	= this.presets[index];
		this.output = "press 'calculate' to process";
	}

	// ----------------------------------------------- //
	// ----------------------------------------------- //
	// Input:
	
	/**
	 * 
	 */
	private function createInputBox():DisplayObject
	{
		var presetList:Sprite = this.createPresetList();
		
		var inputField:Sprite = this.createInputField();
			inputField.y = presetList.height + 15;
		
		// -------------- //	
		
		var vbox:Sprite = new Sprite();	
			vbox.addChild( presetList );
			vbox.addChild( inputField );
		
		return vbox;	
	}
	
	/**
	 * 
	 * @return
	 */
	private function createPresetList():Sprite
	{		
		var presetList:Sprite = new Sprite();
		
		// ---------- //
		
		var y:Float = 0;
		
		for( preset in this.presets )
		{
			var item:TextField = new TextField();
				item.autoSize = TextFieldAutoSize.LEFT;
				item.text = preset;
				item.selectable = false;
				
			item.addEventListener( MouseEvent.CLICK, this.onInputSelected );
			item.y = y;
			
			presetList.addChild( item );
			
			y += item.height;
		}
		
		return presetList;
	}
	
	/**
	 * 
	 * @return
	 */
	private function createInputField():Sprite
	{
		this.inputField = new TextField();			
		this.inputField.type 	 = TextFieldType.INPUT;
		this.inputField.autoSize = TextFieldAutoSize.LEFT;
		this.inputField.border 	= true;		
		
		// ---------- //
		
		var calculate:TextField = new TextField();
			calculate.text = ">> calculate <<";
			calculate.border = true;
			calculate.addEventListener( MouseEvent.CLICK, this.onCalculate );
			calculate.y = this.inputField.height + 5;
			calculate.autoSize = TextFieldAutoSize.LEFT;
			calculate.selectable = false;
			
		// ---------- //	
		
		var hbox:Sprite = new Sprite();
			hbox.addChild( this.inputField );
			hbox.addChild( calculate );
		
		return hbox;
	}
	
	// ----------------------------------------------- //
	// ----------------------------------------------- //
	// Output:
	
	/**
	 * 
	 */
	private function createOutputBox():DisplayObject
	{
		this.resultField = new TextField();		
		this.resultField.autoSize = TextFieldAutoSize.LEFT;
		
		return this.resultField;
	}
}