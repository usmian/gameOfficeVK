
package mainView 

{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import starling.display.DisplayObject;
	import starling.display.Image;
	
	
	import starling.core.Starling;
	import flash.display.Stage;
	import starling.display.Quad;
	
	
	
	/**
	 * ...
	 * @author ф
	 */
	public class StarlingTest extends Sprite
	{
		//[Embed(source = "../../lib/preloader/preload.png")]
		//private var cl:Class;
		//private var img:;
		
		private var _starling:Starling;
		public function StarlingTest() 
		{
			_starling = new Starling(WindowManager, App.gameStage);
			_starling.antiAliasing = 4;
			_starling.start();
			_starling.showStats = true;
		
			//img = new cl();
		
		}
		
	}

}