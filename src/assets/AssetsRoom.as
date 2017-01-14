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
	
	public class AssetsRoom 
	{
		[Embed(source = "../../lib/images/cupboard.png")]
		public static var cupboardClass:Class;
		[Embed(source="../../lib/animation/cat/cote.png")]
		public static var catClass:Class;
		[Embed(source="../../lib/animation/cat/cote.xml", mimeType = "application/octet-stream")]
		public static var catXMLClass:Class;
		
		//public static var musicaClass:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		//private static var gameTextureAtlas:TextureAtlas;
		
		private static var gameCatAtlas:TextureAtlas;
		/*private static var gameManagerHITAtlas:TextureAtlas;
		private static var gameManagerDEATHAtlas:TextureAtlas*/;	
       
		public static function getCATAtlas():TextureAtlas//TODO Manager!
		{
			if (gameCatAtlas==null) 
			{
				var texture:Texture = getTexture("catClass");
				var xml:XML = XML(new catXMLClass());
				gameCatAtlas = new TextureAtlas(texture,xml);
			}
			
			return gameCatAtlas;
		}
		
		public static function getTexture($name:String):Texture
		{
			if (gameTextures[$name]==undefined) 
			{
				var bitmap:Bitmap = new AssetsRoom[$name]();
				gameTextures[$name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[$name];
		}
	}

}