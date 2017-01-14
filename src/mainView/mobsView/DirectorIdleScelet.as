package mainView.mobsView 
{
	import starling.display.Sprite;
	import dragonBones.Armature;
	import dragonBones.animation.WorldClock;
    import dragonBones.starling.StarlingFactory;
	import starling.events.EnterFrameEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ф
	 */
	public class DirectorIdleScelet extends Sprite 
	{
		[Embed(source="../../../lib/animation/boss/directorIdle2.png", mimeType = "application/octet-stream")]
		private var dataBossIdle:Class;
		
		private var factory:StarlingFactory;
        private var armature:Armature;
        private var armatureClip:Sprite;
		
		public function DirectorIdleScelet() 
		{
			super();
			factory = new StarlingFactory();
			factory.parseData(new dataBossIdle());
			
			factory.addEventListener(Event.COMPLETE, factory_complete);
		}
		
		private function factory_complete(e:Event):void 
		{
			armature = factory.buildArmature("bossIDLE");
			armatureClip = armature.display as Sprite;
			
		   // armatureClip.x = 400;
            //armatureClip.y = 550;
			addChild(armatureClip);
			WorldClock.clock.add(armature);
			addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrame);
			armature.animation.gotoAndPlay("IDLE",-1,-1,0);
			
		}
		
		private function enterFrame(e:EnterFrameEvent):void 
		{
			WorldClock.clock.advanceTime( -1);
		}
		
	}

}