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
	public class AssetsSecretaryMC 
	{
		[Embed(source="../../lib/animation/secretaryHit.png")]
		public static var sekrHClass:Class;
		
		[Embed(source="../../lib/animation/secretaryHit.xml", mimeType = "application/octet-stream")]
		public static var sekrHXMLClass:Class;
		
		[Embed(source="../../lib/animation/secretDeath.png")]
		public static var sekrDClass:Class;
		
		[Embed(source = "../../lib/animation/secretDeath.xml", mimeType = "application/octet-stream")]
		public static var sekrDXMLClass:Class;
		
		[Embed(source = "../../lib/animation/sol.png")]
		public static var solClass:Class;
		
		[Embed(source="../../lib/animation/direc.png")]
		public static var directorAClass:Class;
		
		[Embed(source="../../lib/animation/direc.xml", mimeType="application/octet-stream")]
		public static var directorXMLClass:Class;
		
		[Embed(source="../../lib/animation/sprites.png")]
		public static var secretClass:Class;
		
		[Embed(source="../../lib/animation/sprites.xml", mimeType="application/octet-stream")]
		public static var secXMLClass:Class;
		
		[Embed(source="../../lib/animation/secretIdle.png")]
		public static var sekrClass:Class;
		
		[Embed(source="../../lib/animation/secretIdle.xml", mimeType = "application/octet-stream")]
		public static var sekrXMLClass:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		private static var gameSekrIDLEAtlas:TextureAtlas;
		private static var gameSekrHITAtlas:TextureAtlas;
		private static var gameSekretDEATHAtlas:TextureAtlas;
		
		public static function getSekretAtlas():TextureAtlas
		{
			if (gameTextureAtlas==null) 
			{
				var texture:Texture = getTexture("sekrClass");
				var xml:XML = XML(new sekrXMLClass());
				gameTextureAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameTextureAtlas;
		}
		public static function getSekretHitAtlas():TextureAtlas
		{
			if (gameSekrHITAtlas==null) 
			{
				var texture:Texture = getTexture("sekrHClass");
				var xml:XML = XML(new sekrHXMLClass());
				gameSekrHITAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameSekrHITAtlas;
		}	
		
		
		public static function getSekretDeathAtlas():TextureAtlas
		{
			if (gameSekretDEATHAtlas==null) 
			{
				var texture:Texture = getTexture("sekrDClass");
				var xml:XML = XML(new sekrDXMLClass());
				gameSekretDEATHAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameSekretDEATHAtlas;
		}
	
		public static function getTexture($name:String):Texture
		{
			if (gameTextures[$name]==undefined) 
			{
				var bitmap:Bitmap = new AssetsSecretaryMC[$name]();
				gameTextures[$name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[$name];
		}
		
	}

}