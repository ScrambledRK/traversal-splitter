package view ;

import at.dotpoint.core.event.Event;
import at.dotpoint.display.event.MouseEvent;
import at.dotpoint.display.Sprite;
import at.dotpoint.display.Stage;
import at.dotpoint.display.TextField;
import at.dotpoint.gui.Constraints;
import at.dotpoint.gui.dataprovider.ArrayCollection;
import at.dotpoint.gui.dataprovider.IDataProvider;
import at.dotpoint.gui.event.SelectionEvent;
import at.dotpoint.gui.layout.VerticalLayout;
import at.dotpoint.gui.UIDisplayObjectContainer;
import at.dotpoint.gui.viewport.List;
import at.dotpoint.gui.viewport.Viewport;

#if flash
	import at.dotpoint.display.components.renderable.flash.TextFieldEC;
	import flash.text.TextFieldType;
#end

/**
 * ...
 * @author RK
 */
class ControllerView extends Sprite
{
	
	/**
	 * 
	 */
	private var presets:IDataProvider<String>;
	
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
		this.create();
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
	private function create():Void
	{
		this.createInputBox();	
		this.createOutputBox();	
		
		this.selectInput( 0 );
	}
	
	/**
	 * 
	 * @param	event
	 */
	private function onCalculate( value:Event ):Void 
	{		
		this.output = "processing ... ";
		this.dispatchEvent( value );
	}
	
	/**
	 * 
	 * @param	event
	 */
	private function onInputSelected( value:Event ):Void
	{
		var event:SelectionEvent = cast value;
		this.selectInput( event.dataIndex );
	}
	
	/**
	 * 
	 * @param	index
	 */
	private function selectInput( index:Int ):Void
	{
		this.input 	= this.presets.toArray()[index];
		this.output = "press 'calculate' to process";
	}

	// ----------------------------------------------- //
	// ----------------------------------------------- //
	// Input:
	
	/**
	 * 
	 */
	private function createInputBox():Void
	{
		var vbox:UIDisplayObjectContainer = new UIDisplayObjectContainer();
			vbox.addComponent( new VerticalLayout() );
		
		vbox.addChild( this.createPresetList() );
		vbox.addChild( this.createInputField() );
		
		this.addChild( vbox );		
	}
	
	/**
	 * 
	 * @return
	 */
	private function createPresetList():UIDisplayObjectContainer
	{
		var presetList:List<String> = new List<String>();
			presetList.boundings.bb.width  = 450;
			presetList.boundings.bb.height = 100;
			presetList.addEventListener( SelectionEvent.ITEM_SELECTED, this.onInputSelected );
			
		// --------------------------- //
		
		this.presets = presetList.dataProvider;
		this.presets.add( "68 139 223 139 223 216 382 216 382 45 791 45 791 329 923 329 923 564 858 564 858 505 665 505 665 410 562 410 562 670 730 670 730 740 296 740 296 450 68 450 68 139" 		);
		this.presets.add( "164 156 164 280 230 280 230 373 299 373 299 218 361 218 361 156 164 156" 		);
		this.presets.add( "132 112 468 112 468 429 352 429 352 287 249 287 249 529 132 529 132 112" 		);
		this.presets.add( "133 63 500 63 500 339 458 339 458 416 564 416 564 623 133 623 133 63" 			);
		this.presets.add( "584 143 584 592 756 592 756 379 860 379 860 143 584 143" 						);
		
		
		return presetList;
	}
	
	/**
	 * 
	 * @return
	 */
	private function createInputField():UIDisplayObjectContainer
	{
		this.inputField = new TextField();			
		
		#if flash		
			var renderable:TextFieldEC 			= cast this.inputField.renderable;
			var internal:flash.text.TextField 	= cast renderable.internal;				
				internal.type = TextFieldType.INPUT;
				internal.border = true;		
		#end
		
		// ---------- //
		
		var calculate:TextField = new TextField();
			calculate.text = ">> calculate <<";
			calculate.userInput.addEventListener( MouseEvent.CLICK, this.onCalculate );
			calculate.y = 40;	
		
		// ---------- //	
		
		var hbox:UIDisplayObjectContainer = new UIDisplayObjectContainer();
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
	private function createOutputBox():Void
	{
		this.resultField = new TextField();
		this.resultField.y = 120;
		
		this.addChild( this.resultField );
	}
}