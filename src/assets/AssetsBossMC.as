package assets 
{
	/**
	 * ...
	 * @author ф
	 */
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class AssetsBossMC 
	{
	    [Embed(source="../../lib/animation/boss/bossIDLE.png")]
		public static var bossIdleClass:Class;
		[Embed(source="../../lib/animation/boss/bossIDLE.xml", mimeType = "application/octet-stream")]
        public static var bossIdleXMLClass:Class;
		[Embed(source="../../lib/animation/boss/bossHIT.png")]
		public static var bossHitClass:Class;
		[Embed(source="../../lib/animation/boss/bossHIT.xml", mimeType = "application/octet-stream")]
        public static var bossHitXMLClass:Class;
		[Embed(source="../../lib/animation/boss/bossDEATH.png")]
		public static var bossDeathClass:Class;
		[Embed(source="../../lib/animation/boss/bossDEATH.xml", mimeType = "application/octet-stream")]
        public static var bossDeathXMLClass:Class;
		[Embed(source = "../../lib/images/bossChair.png")]
		public static var bossChair:Class;
		
		private static var gameBossIDLEAtlas:TextureAtlas;
		private static var gameBossHITAtlas:TextureAtlas;
		private static var gameBossDEATHAtlas:TextureAtlas;	
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		public static function getBossIDLEAtlas():TextureAtlas
		{
			if (gameBossIDLEAtlas==null) 
			{
				var texture:Texture = getTexture("bossIdleClass");
				var xml:XML = XML(new bossIdleXMLClass());
				gameBossIDLEAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameBossIDLEAtlas;
		}
		
		public static function getBossHITAtlas():TextureAtlas
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
		}
		
		public static function getTexture($name:String):Texture
		{
			if (gameTextures[$name]==undefined) 
			{
				var bitmap:Bitmap = new AssetsBossMC[$name]();
				gameTextures[$name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[$name];
		}
	}

}