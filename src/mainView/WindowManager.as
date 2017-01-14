package mainView 
{
	import flash.display.Loader;
	import starling.core.StatsDisplay;
	
	import events.GameEvent;
	import events.EventConstants;
	import flash.display.Stage;
	import starling.events.TouchPhase;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.display.Quad;
	import starling.display.DisplayObject;
	import starling.text.TextField;
	import flash.geom.Point;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author ф
	 */
	public class WindowManager extends Sprite
	{
		private var _mobsLayer:MainArea;
	    
		private var mouseX:Number = 0;
        private var mouseY:Number = 0;
	    
		public function WindowManager() 
		{
	
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this_addedToStage);
		}
		
		private function this_addedToStage(e:Event):void 
		{
			trace('Starling Init');
			Facade.starlingStage = stage;
			stage.color = 0x45;
			
			_mobsLayer = new MainArea(100, 100);
		  
			
			Facade.starlingStage.addChild(_mobsLayer);
			
			Facade.starlingStage.addEventListener(TouchEvent.TOUCH, onTouch);
			Facade.starlingStage.addEventListener(Event.ENTER_FRAME, onFrame);
			
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			// get the mouse location related to the stage
			    
		    	    var touch:Touch;
				    var pos:Point;
				   
					touch = e.getTouch(Facade.starlingStage);
					if (touch) 
					{
						
						if(touch.phase == TouchPhase.BEGAN)
				    {
 
						pos = touch.getLocation(Facade.starlingStage);
						// store the mouse coordinates
						mouseX = pos.x;
						mouseY = pos.y;
				    }
 
			       if(touch.phase == TouchPhase.ENDED)
				
				    {
						 
						
				    }
 
				else if(touch.phase == TouchPhase.MOVED)
				{
				
					
				}
				
				
					}
					
				
			    //trace(mouseX, mouseY);
		}
		
		
		
		private function onFrame(e:Event):void 
		{
				  _mobsLayer.update(mouseX,mouseY);	   
		}
		
	}

}