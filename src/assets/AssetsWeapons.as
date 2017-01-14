package assets 
{
	
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author ф
	 */
	public class AssetsWeapons 

	{
	   /* [Embed(source="../../lib/animation/weapons/monitor/monikW.png")]
		public static var weaponMonitorClass:Class;
		[Embed(source="../../lib/animation/weapons/monitor/monikW.xml", mimeType = "application/octet-stream")]
        public static var weaponMonitorXMLClass:Class;*/
		[Embed(source="../../lib/animation/weapons/monikT.png")]
		public static var weaponMonitorClass:Class;
        [Embed(source="../../lib/animation/weapons/monikT.xml", mimeType = "application/octet-stream")]
		public static var weaponMonitorXMLClass:Class;
		
		private static var weaponMonitorAtlas:TextureAtlas;
		
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		public static function getWeaponMonitorAtlas():TextureAtlas
		{
			if (weaponMonitorAtlas==null) 
			{
				var texture:Texture = getTexture("weaponMonitorClass");
				var xml:XML = XML(new weaponMonitorXMLClass());
				weaponMonitorAtlas = new TextureAtlas(texture,xml);
			}
			
			return weaponMonitorAtlas;
		}
		
/*		public static function getBossHITAtlas():TextureAtlas
		{
			if (gameBossHITAtlas==null) 
			{
				var texture:Texture = getTexture("bossHitClass");
				var xml:XML = XML(new bossHitXMLClass());
				gameBossHITAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameBossHITAtlas;
		}
			
		public static function getBossDEATHAtlas():TextureAtlas
		{
			if (gameBossDEATHAtlas==null) 
			{
				var texture:Texture = getTexture("bossDeathClass");
				var xml:XML = XML(new bossDeathXMLClass());
				gameBossDEATHAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameBossDEATHAtlas;
		}*/
		
		public static function getTexture($name:String):Texture
		{
			if (gameTextures[$name]==undefined) 
			{
				var bitmap:Bitmap = new AssetsWeapons[$name]();
				gameTextures[$name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[$name];
		}
	 
	}

}