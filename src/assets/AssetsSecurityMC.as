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
	
	public class AssetsSecurityMC 
	{
	    [Embed(source="../../lib/animation/Security/securityIdle.png")]
		public static var securIdleClass:Class;
		[Embed(source = "../../lib/animation/Security/securityIdle.xml", mimeType = "application/octet-stream")]
		public static var securIdleXmlClass:Class;
		[Embed(source = "../../lib/animation/Security/securityHIT.png")]
		public static var securHitClass:Class;
		[Embed(source="../../lib/animation/Security/securityHIT.xml", mimeType = "application/octet-stream")]
		public static var securHitXmlClass:Class;
		[Embed(source = "../../lib/animation/Security/securityDEAD.png")]
		public static var securDeadClass:Class;
		[Embed(source="../../lib/animation/Security/securityDEAD.xml", mimeType = "application/octet-stream")]
		public static var securDeadXmlClass:Class;
		[Embed(source = "../../lib/images/securityChair.png")]
		public static var securChairClass:Class;
		//
		private static var gameTextures:Dictionary = new Dictionary();
		//private static var gameTextureAtlas:TextureAtlas;
		
		private static var gameSecutityIDLEAtlas:TextureAtlas;
		private static var gameSecutityHITAtlas:TextureAtlas;
		private static var gameSecutityDEATHAtlas:TextureAtlas;	
       
		public static function getSecurityIDLEAtlas():TextureAtlas
		{
			if (gameSecutityIDLEAtlas==null) 
			{
				var texture:Texture = getTexture("securIdleClass");
				var xml:XML = XML(new securIdleXmlClass());
				gameSecutityIDLEAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameSecutityIDLEAtlas;
		}
		
		public static function getSecurityHitAtlas():TextureAtlas
		{
			if (gameSecutityHITAtlas==null) 
			{
				var texture:Texture = getTexture("securHitClass");
				var xml:XML = XML(new securHitXmlClass());
				gameSecutityHITAtlas= new TextureAtlas(texture,xml);
			}
			
			return gameSecutityHITAtlas;
		}
		
		public static function getSecurityDeathAtlas():TextureAtlas
		{
			if (gameSecutityDEATHAtlas==null) 
			{
				var texture:Texture = getTexture("securDeadClass");
				var xml:XML = XML(new securDeadXmlClass());
				gameSecutityDEATHAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameSecutityDEATHAtlas;
		}
			
		public static function getTexture($name:String):Texture
		{
			if (gameTextures[$name]==undefined) 
			{
				var bitmap:Bitmap = new AssetsSecurityMC[$name]();
				gameTextures[$name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[$name];
		}
	}

}