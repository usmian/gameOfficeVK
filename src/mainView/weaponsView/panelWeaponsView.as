package mainView.weaponsView 
{
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import assets.AssetsWeapons;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import flash.display.Bitmap;
	
	/**
	 * ...
	 * @author ф
	 */
	public class panelWeaponsView extends Sprite 
	{
		private var _monitor:MovieClip;
		public function panelWeaponsView() 
		{
			super();
			_monitor = new MonitorView(AssetsWeapons.getWeaponMonitorAtlas().getTextures("monitor_"));
		}
		
	
		
	}

}