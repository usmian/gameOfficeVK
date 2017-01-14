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
	
	 
	 
	public class AssetsDrop 
	{
		[Embed(source = "../../lib/animation/monet.png")]
		public static var coinClass:Class
		[Embed(source = "../../lib/animation/monet.xml", mimeType = "application/octet-stream")]
		public static var coinXML:Class;
		[Embed(source = "../../lib/images/starExp.png")]
		public static var _starCl:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameCoinAtlas:TextureAtlas;
		
		public static function getCoinAtlas():TextureAtlas
	    {
		  if (gameCoinAtlas==null) 
		  {
			  var texture:Texture = getTexture("coinClass");
			  var xml:XML = XML(new coinXML());
			  gameCoinAtlas = new TextureAtlas(texture,xml);
		  }
		  
		  return gameCoinAtlas;
	    }
	  
	  public static function getTexture($name:String):Texture
       {
	     if (gameTextures[$name]==undefined) 
	      {
		  var bitmap:Bitmap = new AssetsDrop[$name]();
		  gameTextures[$name] = Texture.fromBitmap(bitmap);
	      }
	  return gameTextures[$name];
       }
	}
	
}