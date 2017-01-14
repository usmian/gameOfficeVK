package
{
	import events.GameEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	import flash.system.ApplicationDomain;
	import events.EventConstants;
	import flash.display.LoaderInfo;
	
	/**
	 * ...
	 * @author ф
	 */
	public class Preloader extends MovieClip 
	{
		[Embed(source = "../lib/preloader/preload.png")]
		private var _prClass:Class;
		private var _imgPreloader:Bitmap;
		private var _bar:MovieClip;
		private var _tfPercent:TextField;
		private var _percent:int;
		
		public function Preloader() 
		{
			if (stage) {
				//stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			
			
			
			//_url = 'lib/preloader/libraryTest1.swf';
			
		    // loaderInfo.addEventListener(Event.COMPLETE, loader_complete);
		addEventListener(Event.ENTER_FRAME, checkFrame);
		loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
		loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
		show();
			// TODO show loader
		}
		
	/*	private function loader_complete(e:Event):void 
		{
			trace(e.target.content);
			Facade.gameStage.dispatchEvent(new GameEvent(EventConstants.PRELOAD_COMPLETE, e.target));
			
			
			/*var appDomain:ApplicationDomain = _loader.contentLoaderInfo.applicationDomain;
			var imgCl:Class = appDomain.getDefinition('fonBack') as Class;
			var imData:BitmapData = new imgCl();
			var bb:Bitmap = new Bitmap(imData);*/
			
		//}
		
	
		private function show():void 
		{
			_imgPreloader = new _prClass();
			_bar=new bar()
			 this.addChild(_imgPreloader);//
			 this.addChild(_bar);
			_bar.x = 150;
			_bar.y = 100;
			_bar.gotoAndStop(0);
			//_bar.addEventListener(Event.ENTER_FRAME, checkFrame);
			_tfPercent = (_bar.getChildByName('percent')) as TextField;
		}
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			
			_percent = Math.floor(e.bytesLoaded / e.bytesTotal * 100);
			_tfPercent.text = _percent +'%';
			_bar.gotoAndStop(Math.floor(_percent/(100/GlobalSettings.PR_FRAMES)));
			
			
			
			// TODO update loader
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			trace('Load complete!');
			
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			this.removeChild(_bar);
			this.removeChild(_imgPreloader);
			// TODO hide loader
			
			startup();
		}
		
		private function startup():void 
		{
			var mainClass:Class = getDefinitionByName("App") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}