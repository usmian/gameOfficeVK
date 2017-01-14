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
	
	public class AssetsAdminMC 
	{
		[Embed(source="../../lib/animation/admin/adminIDLE.png")]
		private static var adminIdleClass:Class;
		[Embed(source="../../lib/animation/admin/adminIDLE.xml", mimeType = "application/octet-stream")]
		private static var adminIdleXMLClass:Class;
		[Embed(source="../../lib/animation/admin/adminHIT.png")]
		private static var adminHitClass:Class;
		[Embed(source = "../../lib/animation/admin/adminHIT.xml", mimeType = "application/octet-stream")]
		private static var adminHitXMLClass:Class;
		[Embed(source = "../../lib/animation/admin/adminDEATH.png")]
		private static var adminDeathClass:Class;
		[Embed(source="../../lib/animation/admin/adminDEATH.xml", mimeType = "application/octet-stream")]
		private static var adminDeathXMLClass:Class;
		
		private static var gameAdminIDLEAtlas:TextureAtlas;
		private static var gameAdminHITAtlas:TextureAtlas;
		private static var gameAdminDEATHAtlas:TextureAtlas;	
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		public static function getAdminIDLEAtlas():TextureAtlas
		{
			if (gameAdminIDLEAtlas==null) 
			{
				var texture:Texture = getTexture("adminIdleClass");
				var xml:XML = XML(new adminIdleXMLClass());
				gameAdminIDLEAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameAdminIDLEAtlas;
		}
		
		public static function getAdminHITAtlas():TextureAtlas
		{
			if (gameAdminHITAtlas==null) 
			{
				var texture:Texture = getTexture("adminHitClass");
				var xml:XML = XML(new adminHitXMLClass());
				gameAdminHITAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameAdminHITAtlas;
		}
			
		public static function getAdminDEATHAtlas():TextureAtlas
		{
			if (gameAdminDEATHAtlas==null) 
			{
				var texture:Texture = getTexture("adminDeathClass");
				var xml:XML = XML(new adminDeathXMLClass());
				gameAdminDEATHAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameAdminDEATHAtlas;
		}
		
		public static function getTexture($name:String):Texture
		{
			if (gameTextures[$name]==undefined) 
			{
				var bitmap:Bitmap = new AssetsAdminMC[$name]();
				gameTextures[$name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[$name];
		}
	}

}