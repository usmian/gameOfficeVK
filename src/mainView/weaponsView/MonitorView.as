package mainView.weaponsView 
{
	import starling.display.MovieClip;
	import assets.AssetsWeapons;
	import starling.display.Quad;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import flash.display.Bitmap;
	import starling.events.TouchEvent;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.TouchPhase;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author ф
	 */
	public class MonitorView extends MovieClip 
	{
	    private var _sensor:Quad;
		public function MonitorView(textures:Vector.<Texture>, fps:Number=20) 
		{
			super(textures, fps);
			setPosition();
			Facade.starlingStage.addChild(this);
			Starling.juggler.add(this);
			this.stop();
			createSensor();
		}
		
		private function createSensor():void 
		{
			_sensor = new Quad(this.width-10, this.height-10);
			_sensor.x = GlobalSettings.MONITOR_X;
			_sensor.y = GlobalSettings.MONITOR_Y;
			Facade.starlingStage.addChild(_sensor);
			_sensor.alpha = 0;
			_sensor.addEventListener(TouchEvent.TOUCH, sensor_touch);
		}
		
		private function sensor_touch(e:TouchEvent):void 
		{
			var on:Boolean=false;
			if (e.getTouch((e.target) as DisplayObject,TouchPhase.HOVER))//TODO:REAPAIR!!!!!!!!!!!!!
			{
				
					this.play();
					this.loop = false;
					this.addEventListener(Event.COMPLETE, this_complete);
				
				
			}
			else 
			{
			
					this.play();
					this.loop = false;
					this.addEventListener(Event.COMPLETE, this_complete);
				
				
				
			}
		}
		
		private function this_complete(e:Event):void 
		{
			(e.target as MovieClip).reverseFrames();
			(e.target as MovieClip).stop();
		   	e.target.removeEventListener(Event.COMPLETE, this_complete);
		}
		
		private function setPosition():void 
		{
			this.x = GlobalSettings.MONITOR_X;
			this.y = GlobalSettings.MONITOR_Y;
		}
	}

}