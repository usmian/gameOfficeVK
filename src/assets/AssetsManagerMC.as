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
	
	public class AssetsManagerMC 
	{
	    [Embed(source="../../lib/animation/manager/managerIDLE.png")]
		public static var managerIdleClass:Class;
		[Embed(source="../../lib/animation/manager/managerIDLE.xml", mimeType = "application/octet-stream")]
		public static var managerIdleXmlClass:Class;
	    [Embed(source="../../lib/animation/manager/managerHIT.png")]
		public static var managerHitClass:Class;
		[Embed(source="../../lib/animation/manager/managerHIT.xml", mimeType = "application/octet-stream")]
		public static var managerHitXmlClass:Class;
		[Embed(source="../../lib/animation/manager/managerDEATH.png")]
		public static var managerDeathClass:Class;
		[Embed(source="../../lib/animation/manager/managerDEATH.xml", mimeType = "application/octet-stream")]
		public static var managerDeathXmlClass:Class;
		
		[Embed(source="../../lib/images/stolManger.png")]
		public static var managerTable:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		private static var gameManagerIDLEAtlas:TextureAtlas;
		private static var gameManagerHITAtlas:TextureAtlas;
		private static var gameManagerDEATHAtlas:TextureAtlas;	
       
		public static function getManagerIDLEAtlas():TextureAtlas//TODO Manager!
		{
			if (gameManagerIDLEAtlas==null) 
			{
				var texture:Texture = getTexture("managerIdleClass");
				var xml:XML = XML(new managerIdleXmlClass());
				gameManagerIDLEAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameManagerIDLEAtlas;
		}
		
		public static function getManagerHITAtlas():TextureAtlas//TODO Manager!
		{
			if (gameManagerHITAtlas==null) 
			{
				var texture:Texture = getTexture("managerHitClass");
				var xml:XML = XML(new managerHitXmlClass());
				gameManagerHITAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameManagerHITAtlas;
		}
			
		public static function getManagerDEATHAtlas():TextureAtlas//TODO Manager!
		{
			if (gameManagerDEATHAtlas==null) 
			{
				var texture:Texture = getTexture("managerDeathClass");
				var xml:XML = XML(new managerDeathXmlClass());
				gameManagerDEATHAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameManagerDEATHAtlas;
		}
		
		public static function getTexture($name:String):Texture
		{
			if (gameTextures[$name]==undefined) 
			{
				var bitmap:Bitmap = new AssetsManagerMC[$name]();
				gameTextures[$name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[$name];
		}
	}

}
		
