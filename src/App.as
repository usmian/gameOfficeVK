package
{
	import events.GameEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import mainView.StarlingTest;
	import mainView.WindowManager;
	
	import events.EventConstants;
	import flash.system.ApplicationDomain;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.system.LoaderContext;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	
	

	/**
	 * ...Main entry point, for loading DATA an create starling engine(use flash displayList)
	 * @author ф
	 */
	[Frame(factoryClass = "Preloader")]
	
	public class App extends Sprite
	{
       
		private var _loader:Loader;
	
		private var _url:String;
	
		private var _context:LoaderContext;
		private var _date:Date;
	    [Embed(source = "../lib/preloader/preload.png")]
		private var pre:Class;
		[Embed(source="../lib/preloader/preload.jpg")]
		private var cl:Class;
		private var _prel:Bitmap;
		private var _bar:MovieClip;
		private var _main:WindowManager;
		private var _starl:StarlingTest;
		public static var gameStage:Stage;
		
		public function App() 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
		    Security.allowDomain("*");
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			 App.gameStage = stage;
			_loader = new Loader();
	        _prel = new pre();
			 App.gameStage.addChild(_prel);
			_bar = new bar();
		    _bar.gotoAndStop(0);
			 App.gameStage.addChild(_bar);
			_bar.y = 200;
			_date = new Date();
			_context = new LoaderContext(false, ApplicationDomain.currentDomain);//load files to currentDomain
			
			//_url = 'http://usmian.ucoz.net/resource/libraryTest2.swf?' + _date.time;//антикэш!!!! - это 'link?'+ random
		/*    _url = 'http://usmian.ucoz.net/resource/libraryTest2.swf';
			_loader.load(new URLRequest(_url),_context);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_complete);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderInfo_progress);	*/
				initStarling();
		}
		
	
		
		private function loaderInfo_progress(e:ProgressEvent):void 
		{
			trace(e.bytesLoaded);
			var _percent:int;
			_percent = Math.floor(e.bytesLoaded / e.bytesTotal * 100);

			_bar.gotoAndStop(Math.floor(_percent / (100 / GlobalSettings.PR_FRAMES)));
			
		}
		
		private function loader_complete(e:Event):void 
		{
			trace(e.target.content);
			initStarling();//
		   /*
		    var appDomain:ApplicationDomain = _loader.contentLoaderInfo.applicationDomain;
			
			var imgCl:Class = appDomain.getDefinition('fonBack') as Class;
			var imData:BitmapData = new imgCl();
			
			var bb:Bitmap = new Bitmap(imData);
			
			
			App.gameStage.addChild(bb);
			bb.x = 100;
			bb.y = 100;*/
			/*App.gameStage.removeChild(bb);
			bb = null;*/
		}
		private function initStarling():void 
		{
			App.gameStage.removeChild(_prel);
			App.gameStage.removeChild(_bar);
			_prel = null;
			_bar = null;
			_starl = new StarlingTest();
		}
	}

}