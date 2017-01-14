package mainView 
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import mainView.dropView.dropThingImage;
	import mainView.dropView.dropThingMC;
	import mainView.weaponsView.panelWeaponsView;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import starling.filters.GlowFilter;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.display.Quad;
	import starling.display.DisplayObject;
	import starling.text.TextField;
	//assets
	import assets.AssetsSecretaryMC;
	import assets.AssetsSecurityMC;
	import assets.AssetsManagerMC;
	import assets.AssetsAdminMC;
	import assets.AssetsBossMC;
	import assets.AssetsDrop;
	import assets.AssetsRoom;
	import starling.filters.BlurFilter;
	import starling.filters.DropShadowFilter;
	import starling.filters.ColorMatrixFilter;
	import starling.events.TouchPhase;
	import ru.flashpress.tween.FPTween;
	import ru.flashpress.tween.events.FPTEvent;
	import ru.flashpress.tween.core.constants.FPTProperties;
	import ru.flashpress.tween.ease.*;
	import ru.flashpress.tween.core.constants.FPTEaseTypes;
	import flash.ui.MouseCursor;
	import flash.ui.Mouse;
	import mainView.mobsView.DirectorIdleScelet;
	import GlobalSettings;
	/**
	 * ...
	 * @author ф
	 */
	public class MainArea extends Sprite 
	{
		[Embed(source = "../../lib/particles/fireStar/texture.png")]
		private var partTex:Class;
		[Embed(source = "../../lib/particles/fireStar/particle.pex", mimeType = "application/octet-stream")]
		private var partPex:Class;
		[Embed(source = "../../lib/images/panel.png")]
		private var panelCl:Class;
		[Embed(source = "../../lib/images/table.png")]
		private var tableCl:Class;
		//
		private var rect:Quad;
		//
		private var quadWidth:uint;
        private var quadHeight:uint;
		private var color:uint;
		//
		private var psConfig:XML;
		private var psTexture:Texture;
		private var ps:PDParticleSystem;
		//
		private var _glowFilter:DropShadowFilter;
		//
		private var container:Sprite
		private var direct:Sprite;
		private var _sensorSecret:Quad;
		private var _sensorSecurity:Quad;
		private var _sensorManager:Quad;
		private var _sensorAdmin:Quad;
		private var _sensorBoss:Quad;
		private var _stateFilter:Boolean = false;
		//drop things
		private var _monet:MovieClip;
		private var spr:Sprite;
		private var animCoin:FPTween;
		private var animcc:FPTween;
		private var skr:MovieClip;
		//secretary
		private var _secretStay:MovieClip;
		private var _secretHit:MovieClip;
		private var _sekretDeath:MovieClip;
		//security
		private var _securityStay:MovieClip;
		private var _securityHit:MovieClip;
		private var _securityDeath:MovieClip;
		private var _securityChair:Image;
		//manager
		private var _managerStay:MovieClip;
		private var _managerHit:MovieClip;
		private var _managerDeath:MovieClip;
		private var _managerTable:Image;
		//admin
		private var _adminStay:MovieClip;
		private var _adminHit:MovieClip;
		private var _adminDeath:MovieClip;
		//boss
		private var _bossStay:MovieClip;
		private var _bossHit:MovieClip;
		private var _bossDeath:MovieClip;
		private var _bossChair:Image;
		//
		//
		[Embed(source="../../lib/images/sol.png")]
		private var ccl:Class;
		private var soln:Image;
		[Embed(source="../../lib/images/noAnimation.png")]
		private var fonCl:Class;
		private var _background:Image;
		
		private var _starExperience:Image;
		private var delta:int = 30;
		
		private var experienceViews:Vector.<Image>;
		private var _table:Image;
		private var _panel:Image;
		private var _panelWeapons:Sprite;
		//temporary vars because we havent server
		//for Death - temporary var
		private var _deathControl:Number=1;
		private var _deathControlSecu:Number = 1;
		private var _deathControlManager:Number = 1;
		private var _deathControlAdmin:Number = 1;
		private var _deathControlBoss:Number = 1;
		//
		private var _bossIdle:Sprite;
		
		public function MainArea($width:Number,$height:Number,$color:uint=0x800000) 
		{
			_background= new Image(Texture.fromBitmap(new fonCl()));
			soln = new Image(Texture.fromBitmap(new ccl()));
			_table = new Image(Texture.fromBitmap(new tableCl()));
			_panel= new Image(Texture.fromBitmap(new panelCl()));
			Facade.starlingStage.addChild(_background);
		    
			/*psConfig = XML(new partPex());
			psTexture = Texture.fromBitmap(new partTex());
			ps = new PDParticleSystem(psConfig, psTexture);
			addChild(ps);
			Starling.juggler.add(ps);
			ps.emitterX = -20;
			ps.emitterY = -20;*/
			
		
			//ps.start();
			spr = new Sprite();
		    container = new Sprite();
			direct = new Sprite();
			quadWidth = $width;
			quadHeight = $height;
			color = $color;
			rect = new Quad(quadWidth, quadHeight, color);
			experienceViews = new Vector.<Image>;
			//soln.alignPivot();//center
		   
			
			/*rect.alpha=.5
			container.x = Facade.starlingStage.stageWidth - rect.width >> 1;
			container.y = Facade.starlingStage.stageHeight - rect.height >> 1;
			var legend:TextField = new TextField(100, 20, "Hello, Man!! CLICK,CLICK!!!");
			Facade.starlingStage.addChild(container);
			container.addChild(rect);
		    container.addChild(legend);
			trace(rect.x, rect.y);	*/
			//cat!
			var _cupBoard:Image = new Image(AssetsRoom.getTexture("cupboardClass"));
			_cupBoard.x = GlobalSettings.CUPBOARD_X;
			_cupBoard.y = GlobalSettings.CUPBOARD_Y;
			var _cat:MovieClip = new MovieClip(AssetsRoom.getCATAtlas().getTextures("cote_"), 13);
			_cat.x = _cupBoard.x + 57;//cat on cupboard
			_cat.y = _cupBoard.y - 20;
			Starling.juggler.add(_cat);
			Facade.starlingStage.addChild(_cupBoard);
			Facade.starlingStage.addChild(_cat);
			//cat
			//
			createSecurity();
			createManager();
			createBoss();
			createAdmin();
			createSecretary();
			addSensors();
			
			
			//Facade.starlingStage.addChild
			//add addition images over mobs layers
			Facade.starlingStage.addChild(_table);
			Facade.starlingStage.addChild(_panel);
			_panelWeapons = new panelWeaponsView();
			_table.x = 123;
			_table.y = 523, 40;
			sensorVisible();//temporary function for tune sensor area
			//TODO: 1.отдельно фции create-dispose
			//2.сделать обводку персонажей
			//3.переделать анимацию чтобы попадала в размер
			//4.оружие и фрейм реверс
			
			
		}
		private function sensorVisible(on:Boolean=false):void 
		{
			if (on) 
			{
		       _sensorSecret.alpha = 1;
		       _sensorSecurity.alpha = 1;
		       _sensorManager.alpha = 1;
		       _sensorAdmin.alpha = 1;
	           _sensorBoss.alpha = 1;	
			}
			else
			{
			   _sensorSecret.alpha = 0;
		       _sensorSecurity.alpha = 0;
		       _sensorManager.alpha = 0;
		       _sensorAdmin.alpha = 0;
	           _sensorBoss.alpha = 0; 	
			}
		}
		private function createSecurity():void 
		{
			_sensorSecurity=new Quad(77, 183);
			_sensorSecurity.alpha = 0;
			
			_securityStay = new MovieClip(AssetsSecurityMC.getSecurityIDLEAtlas().getTextures("securityIdle_"), 60);
			_securityHit = new MovieClip(AssetsSecurityMC.getSecurityHitAtlas().getTextures("securityHIT_"), 45);
			_securityDeath = new MovieClip(AssetsSecurityMC.getSecurityDeathAtlas().getTextures("securityDEAD_"), 60);
		    _securityChair= new Image(AssetsSecurityMC.getTexture("securChairClass"));
			//
			_securityStay.x = _securityHit.x= _securityDeath.x= GlobalSettings.SECURITY_X; 
			_securityStay.y = _securityHit.y= _securityDeath.y= GlobalSettings.SECURITY_Y;
			_sensorSecurity.x  = _securityChair.x = _securityStay.x;
			_sensorSecurity.y  =  _securityChair.y = _securityStay.y+67;
			Starling.juggler.add(_securityStay);
			Starling.juggler.add(_securityHit);
			Starling.juggler.add(_securityDeath);
			Facade.starlingStage.addChild(_securityChair);
			Facade.starlingStage.addChild (_securityStay);
			Facade.starlingStage.addChild(_securityHit);
			Facade.starlingStage.addChild(_securityDeath);
			_securityHit.stop();
			_securityDeath.stop();
			_securityHit.visible = false;
			_securityDeath.visible = false;
			Facade.starlingStage.addChild(_sensorSecurity);
			_sensorSecurity.addEventListener(TouchEvent.TOUCH, security_touch);
		}
		
	
		private function createSecretary():void 
		
		{
			_secretStay = new MovieClip(AssetsSecretaryMC.getSekretAtlas().getTextures("sekrIdle"), 60);
			_sekretDeath = new MovieClip(AssetsSecretaryMC.getSekretDeathAtlas().getTextures("secretDeath_"), 60);
			_secretHit = new MovieClip(AssetsSecretaryMC.getSekretHitAtlas().getTextures("secretHit_"), 45);
			//directorStay.scaleX = directorStay.scaleY = 0.5;
			_secretStay.x = _sekretDeath.x = _secretHit.x= GlobalSettings.SECRETARY_X; 
			_secretStay.y = _sekretDeath.y = _secretHit.y= GlobalSettings.SECRETARY_Y;
			
			Starling.juggler.add(_secretStay);
			Starling.juggler.add(_secretHit);
			Starling.juggler.add(_sekretDeath);
			Facade.starlingStage.addChild(_secretStay);
			Facade.starlingStage.addChild(_secretHit);
			Facade.starlingStage.addChild(_sekretDeath);
			_secretHit.stop();
			_sekretDeath.stop();
			_secretHit.visible = false;
			_sekretDeath.visible = false;
			
		}
	
		private function createManager():void 
		
		{
			_managerStay = new MovieClip(AssetsManagerMC.getManagerIDLEAtlas().getTextures("managerIDLE_"), 60);
			_managerHit = new MovieClip(AssetsManagerMC.getManagerHITAtlas().getTextures("managerHIT_"), 45);
			_managerTable = new Image(AssetsManagerMC.getTexture("managerTable"));
			_managerDeath = new MovieClip(AssetsManagerMC.getManagerDEATHAtlas().getTextures("managerDEATH_"), 45);
		    //
			//sensor
			_managerStay .x = _managerTable.x = _managerHit.x = GlobalSettings.MANAGER_X; //_securityHit.x= _securityDeath.x=
			_managerStay .y = _managerHit.y = GlobalSettings.MANAGER_Y;
			_managerTable.y = GlobalSettings.MANAGER_Y + 33;
			_managerDeath.x = GlobalSettings.MANAGER_X-29;
			_managerDeath.y = GlobalSettings.MANAGER_Y-1;
			
			Starling.juggler.add(_managerStay);
			Starling.juggler.add(_managerHit);
			Starling.juggler.add(_managerDeath);
			Facade.starlingStage.addChild (_managerStay );
			Facade.starlingStage.addChild(_managerHit);
			Facade.starlingStage.addChild (_managerTable);
			Facade.starlingStage.addChild(_managerDeath);
			_managerHit.stop();
			_managerDeath.stop();
			_managerHit.visible = false;
			_managerDeath.visible = false;
			
		}
		
		private function createAdmin():void 
		
		{
			_adminStay = new MovieClip(AssetsAdminMC.getAdminIDLEAtlas().getTextures("AdminIDLE_"), 80);
			_adminHit = new MovieClip(AssetsAdminMC.getAdminHITAtlas().getTextures("AdminHIT_"), 60);
			_adminDeath = new MovieClip(AssetsAdminMC.getAdminDEATHAtlas().getTextures("adminDEATH_"), 60);
		    //
			//
			_adminStay.x =_adminHit.x = GlobalSettings.ADMIN_X; 
			_adminStay.y = GlobalSettings.ADMIN_Y;
			_adminHit.y = GlobalSettings.ADMIN_Y + 12;
			
			_adminDeath.x = GlobalSettings.ADMIN_X-10;
			_adminDeath.y = GlobalSettings.ADMIN_Y+10;
			
			Starling.juggler.add(_adminStay);
			Starling.juggler.add(_adminHit);
			Starling.juggler.add(_adminDeath);
			Facade.starlingStage.addChild (_adminStay);
			Facade.starlingStage.addChild(_adminHit);
			Facade.starlingStage.addChild(_adminDeath);
			_adminHit.stop();
			_adminDeath.stop();
			_adminHit.visible = false;
			_adminDeath.visible = false;
			
		}
		
	
		
		private function createBoss():void 
		
		{
			_bossStay = new MovieClip(AssetsBossMC.getBossIDLEAtlas().getTextures("bossIDLE_"), 60);
			_bossIdle = new DirectorIdleScelet();
			_bossHit = new MovieClip(AssetsBossMC.getBossHITAtlas().getTextures("bossHIT_"), 60);
			_bossDeath = new MovieClip(AssetsBossMC.getBossDEATHAtlas().getTextures("bossDEATH_"), 60);
			
			Facade.starlingStage.addChild(_bossIdle);
			
			_bossChair = new Image(AssetsBossMC.getTexture("bossChair"));
		    //sensor
			//coordinates
			_bossStay.x = GlobalSettings.BOSS_X; 
			_bossChair.x = _bossStay.x + 80;
			_bossChair.y = _bossStay.y = GlobalSettings.BOSS_Y;
			//_bossIdle.x = _bossStay.x+94;
			//_bossIdle.y = _bossStay.y+72;
			_bossIdle.x = _bossStay.x;
			_bossIdle.y = _bossStay.y;
			_bossHit.x = GlobalSettings.BOSS_X;
			_bossHit.y = GlobalSettings.BOSS_Y;
			_bossDeath.x = GlobalSettings.BOSS_X;
			_bossDeath.y = GlobalSettings.BOSS_Y;
			//
			Starling.juggler.add(_bossStay);
			Starling.juggler.add(_bossHit);
			Starling.juggler.add(_bossDeath);
			Facade.starlingStage.addChild(_bossChair);
			Facade.starlingStage.addChild (_bossStay);
			Facade.starlingStage.addChild(_bossHit);
			Facade.starlingStage.addChild(_bossDeath);
			_bossHit.stop();
			_bossDeath.stop();
			_bossHit.visible = false;
			_bossDeath.visible = false;
		}
		//
		//addSensors
		//
		private function addSensors():void 
		{
			//secret
			_sensorSecret=new Quad(210, 200);
			_sensorSecret.alpha = 0;
			_sensorSecret.x = _secretStay.x + 80;
			_sensorSecret.y = _secretStay.y + 55;
			Facade.starlingStage.addChild(_sensorSecret);
			_sensorSecret.addEventListener(TouchEvent.TOUCH, secretary_touch);
			//boss
			_sensorBoss = new Quad(_bossStay.width-40, _bossStay.height);
			_sensorBoss.alpha = 0;
			_sensorBoss.x = _bossStay.x+20;
			_sensorBoss.y = _bossStay.y;
			Facade.starlingStage.addChild(_sensorBoss);
			_sensorBoss.addEventListener(TouchEvent.TOUCH, boss_touch);
			//manager
			_sensorManager = new Quad(_managerDeath.width, _managerDeath.height);
			_sensorManager.alpha = 0;
			_sensorManager.x = _managerStay.x;
			_sensorManager.y = _managerStay.y ;
			Facade.starlingStage.addChild(_sensorManager);
			_sensorManager.addEventListener(TouchEvent.TOUCH, manager_touch);
			//admin
			_sensorAdmin = new Quad(_adminDeath.width, _adminDeath.height);
			_sensorAdmin.alpha = 0;
			_sensorAdmin.x = _adminStay.x;
			_sensorAdmin.y = _adminStay.y;
			Facade.starlingStage.addChild(_sensorAdmin);
			_sensorAdmin.addEventListener(TouchEvent.TOUCH, admin_touch);
			
		}
		//SECRETARY
		private function secretary_touch(e:TouchEvent):void 
		{
			
			if (e.getTouch((e.target) as DisplayObject,TouchPhase.HOVER))
			{
				       if (!_stateFilter && _deathControl < 7) 
					   {
						   Mouse.cursor = MouseCursor.BUTTON;
						  _glowFilter = new DropShadowFilter(3, 0.790, 0x400080, 0,5, 1);
						   //_monet.play();
						  
						   Starling.juggler.tween(_glowFilter, 0.4 ,{alpha:1} );
						   _secretStay.filter = _glowFilter;// new BlurFilter();
						   _stateFilter = true;   
						  // animCoin=new FPTween( { duration:0.5, property:FPTProperties.Y, ease:FPTEaseTypes.ELASTIC_IN_OUT, target:spr, finish:300 } );
						  // animCoin.start();
						   
					   }
					
					   
					   //directorStay.scaleX = directorStay.scaleY	= 1.01;
			}
			else 
			{
				//_monet.pause();
				
				Mouse.cursor = MouseCursor.ARROW;
				Starling.juggler.tween(_glowFilter, 0.4 ,{alpha:0} );
			    _stateFilter = false;
				//animCoin=new FPTween( { duration:0.5, property:FPTProperties.Y, ease:FPTEaseTypes.ELASTIC_IN_OUT, target:spr, finish:200 } );
			//	animCoin.start();
			}
		
			if(e.getTouch((e.target) as DisplayObject,TouchPhase.ENDED))
				
			{
				trace('click');
				_deathControl += 1;
				if (_deathControl < 7)
				{
			    //Drop from Mob
				createStarsSecret();
				createClip();
				//Drop from Mob
				_monet = new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("coin_"), 16,GlobalSettings.SECRETARY_X+GlobalSettings.DROP_SECRETARY_X,GlobalSettings.SECRETARY_Y+GlobalSettings.DROP_SECRETARY_Y);
				Starling.juggler.add(_monet);
				Facade.starlingStage.addChild(_monet);
				//
				_monet.scaleX = _monet.scaleY = 0.4;
				_starExperience.scaleX = _starExperience.scaleY = 0.7;
				_monet.addEventListener(TouchEvent.TOUCH, monet_touch);
				_secretHit.visible = true;
				_secretStay.visible = false;
				_secretHit.play();
				_secretStay.stop();
				_secretHit.loop = false;
				_secretHit.addEventListener(Event.COMPLETE, secretHit_complete); 
				}
			    
				else {
				      secretaryDeath()
			         }	
			}
				
				//directorStay.filter.dispose();
               // directorStay.filter = null;
			
		}
		
		private function secretaryDeath():void 
		{
			 createStarsSecret();
				         //
		     createClip();
			 _monet = new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("coin_"), 16,GlobalSettings.SECRETARY_X+GlobalSettings.DROP_SECRETARY_X,GlobalSettings.SECRETARY_Y+GlobalSettings.DROP_SECRETARY_Y);
			_secretStay.stop();
			_secretStay.visible = false;
			 Facade.starlingStage.removeChild(_secretStay);//??/????????????????????????????????????????????????WTF
			 
			_sekretDeath.visible = true;
			_sekretDeath.play();
			_sekretDeath.loop = false;
			_sensorSecret.touchable = false;
		}
		//
		//security Mouse event
		//
		private function security_touch(e:TouchEvent):void 
		{
			
			if (e.getTouch((e.target) as DisplayObject,TouchPhase.HOVER))
			{
				       if (!_stateFilter && _deathControlSecu<7) 
					   {
						   Mouse.cursor = MouseCursor.BUTTON;
						  _glowFilter = new DropShadowFilter(3, 0.790, 0x4534, 0, 1, 1);  
						   Starling.juggler.tween(_glowFilter, 0.4 ,{alpha:1} );
						   _securityStay.filter = _glowFilter;// new BlurFilter();
						   _stateFilter = true;   
					   }
			}
			else 
			{
				Mouse.cursor = MouseCursor.ARROW;
				Starling.juggler.tween(_glowFilter, 0.4 ,{alpha:0} );
			    _stateFilter = false;
			}
		
			if(e.getTouch((e.target) as DisplayObject,TouchPhase.ENDED))
				
			    {
				trace('click');	
				_deathControlSecu += 1;
				if (_deathControlSecu < 7)
				{
				createStarsSecu();
				//
				createClipSecu();
				_monet = new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("coin_"), 16,GlobalSettings.SECURITY_X+GlobalSettings.DROP_SECURITY_X,GlobalSettings.SECURITY_Y+GlobalSettings.DROP_SECURITY_Y);
				Starling.juggler.add(_monet);
				Facade.starlingStage.addChild(_monet);
				
				_monet.scaleX = _monet.scaleY = 0.4;
				_starExperience.scaleX = _starExperience.scaleY = 0.7;
				_monet.addEventListener(TouchEvent.TOUCH, monet_touch);
				_securityHit.visible = true;
				_securityStay.visible = false;
				_securityHit.play();
				_securityStay.stop();
				_securityHit.loop = false;
				_securityHit.addEventListener(Event.COMPLETE, securityHit_complete);
				}
				
				else
				{
					     createStarsSecu();
				         //
				         createClipSecu();
						_monet = new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("coin_"), 16,GlobalSettings.SECURITY_X+GlobalSettings.DROP_SECURITY_X,GlobalSettings.SECURITY_Y+GlobalSettings.DROP_SECURITY_Y);
					    
						_securityStay.stop();
						 Facade.starlingStage.removeChild(_securityStay);
						 Facade.starlingStage.removeChild(_securityChair);
						_securityDeath.visible = true;
						_securityDeath.play();
						_securityDeath.loop = false;
						_sensorSecurity.touchable = false;
				}
			}
			
		}
		//
		//MANAGER
		private function manager_touch(e:TouchEvent):void 
		{
			
			if (e.getTouch((e.target) as DisplayObject,TouchPhase.HOVER))
			{
				       if (!_stateFilter && _deathControlManager<7) 
					   {
						   Mouse.cursor = MouseCursor.BUTTON;
						  _glowFilter = new DropShadowFilter(4, 0.790, 0x000000, 0, 1, 1);  
						   Starling.juggler.tween(_glowFilter, 0.4 ,{alpha:1} );
						   _managerStay.filter = _glowFilter;// new BlurFilter();
						   _stateFilter = true;   
					   }
			}
			else 
			{
				Mouse.cursor = MouseCursor.ARROW;
				Starling.juggler.tween(_glowFilter, 0.4 ,{alpha:0} );
			    _stateFilter = false;
			}
		
			if(e.getTouch((e.target) as DisplayObject,TouchPhase.ENDED))
				
			    {
				trace('click');	
				_deathControlManager += 1;
				//temporaryDeath
				if (_deathControlManager < 7)
				{
				createStarsManager();
				//
				createManagerClips();
				_monet = new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("coin_"), 16,GlobalSettings.MANAGER_X+GlobalSettings.DROP_MANAGER_X,GlobalSettings.MANAGER_Y+GlobalSettings.DROP_MANAGER_Y,370);
				Starling.juggler.add(_monet);
				Facade.starlingStage.addChild(_monet);
				
				_monet.scaleX = _monet.scaleY = 0.4;
				_starExperience.scaleX = _starExperience.scaleY = 0.7;
				_monet.addEventListener(TouchEvent.TOUCH, monet_touch);
				_managerHit.visible = true;
				_managerStay.visible = false;
				_managerHit.play();
				_managerStay.stop();
				_managerHit.loop = false;
				_managerHit.addEventListener(Event.COMPLETE, managerHit_complete);
				}
				
				else
				{
					     createStarsManager();
				         //
				         createManagerClips();
						_monet = new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("coin_"), 16,GlobalSettings.MANAGER_X+GlobalSettings.DROP_MANAGER_X,GlobalSettings.MANAGER_Y+GlobalSettings.DROP_MANAGER_Y,370);
					  
						_managerStay.stop();
						Facade.starlingStage.removeChild(_managerTable);
						Facade.starlingStage.removeChild(_managerStay);
						_managerDeath.visible = true;
						_managerDeath.play();
						_managerDeath.loop = false;
						_sensorManager.touchable = false;
				}
			}
			
		}
		//
		//ADMIN m.e.
			private function admin_touch(e:TouchEvent):void 
		
			{
			
				if (e.getTouch((e.target) as DisplayObject,TouchPhase.HOVER))
			{
				       if (!_stateFilter && _deathControlAdmin<7) 
					   {
						   Mouse.cursor = MouseCursor.BUTTON;
						  _glowFilter = new DropShadowFilter(4, 0.790, 0x000000, 0, 1, 1);  
						   Starling.juggler.tween(_glowFilter, 0.4 ,{alpha:1} );
						   _adminStay.filter = _glowFilter;// new BlurFilter();
						   _stateFilter = true;   
					   }
			}
			
			    else 
			{
				Mouse.cursor = MouseCursor.ARROW;
				Starling.juggler.tween(_glowFilter, 0.4 ,{alpha:0} );
			    _stateFilter = false;
			}
		
			
			if(e.getTouch((e.target) as DisplayObject,TouchPhase.ENDED))
				
			    {
				trace('click');	
				_deathControlAdmin += 1;
				//temporaryDeath
				if (_deathControlAdmin < 7)
				{
				createStarsAdmin();
				//
				createAdminClips();
				_monet = new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("coin_"), 16,GlobalSettings.ADMIN_X+GlobalSettings.DROP_ADMIN_X,GlobalSettings.ADMIN_Y+GlobalSettings.DROP_ADMIN_Y,370);
				Starling.juggler.add(_monet);
				Facade.starlingStage.addChild(_monet);
				
				_monet.scaleX = _monet.scaleY = 0.4;
				_starExperience.scaleX = _starExperience.scaleY = 0.7;
				_monet.addEventListener(TouchEvent.TOUCH, monet_touch);
				_adminHit.visible = true;
				_adminStay.visible = false;
				_adminHit.play();
				_adminStay.stop();
				_adminHit.loop = false;
				_adminHit.addEventListener(Event.COMPLETE, adminHit_complete);
				}
				
				else
				
				{
					     createStarsAdmin();
				         //
				         createAdminClips();
						_monet = new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("coin_"), 16,GlobalSettings.MANAGER_X+GlobalSettings.DROP_MANAGER_X,GlobalSettings.MANAGER_Y+GlobalSettings.DROP_MANAGER_Y,370);
					    
						_adminStay.stop();
						Facade.starlingStage.removeChild(_adminStay);
						_adminDeath.visible = true;
						_adminDeath.play();
						_adminDeath.loop = false;
						_sensorAdmin.touchable = false;
				}
			  }
		
				
			}
			//
			//BOSS m.e
	     	private function boss_touch(e:TouchEvent):void 
		
			{
			
				if (e.getTouch((e.target) as DisplayObject,TouchPhase.HOVER))
			{
				       if (!_stateFilter && _deathControlBoss<7) 
					   {
						   Mouse.cursor = MouseCursor.BUTTON;
						  _glowFilter = new DropShadowFilter(4, 0.790, 0x000000, 0, 1, 1);  
						   Starling.juggler.tween(_glowFilter, 0.4 ,{alpha:1} );
						   _bossStay.filter = _glowFilter;// new BlurFilter();
						  
						   _stateFilter = true;   
					   }
			}
			
			    else 
			{
				Mouse.cursor = MouseCursor.ARROW;
				Starling.juggler.tween(_glowFilter, 0.4 ,{alpha:0} );
			    _stateFilter = false;
			}
		
			
			if(e.getTouch((e.target) as DisplayObject,TouchPhase.ENDED))
				
			    {
				trace('click');	
				_deathControlBoss += 1;
				//temporaryDeath
				if (_deathControlBoss < 7)
				{
				createStarsBoss();
				//
				createAdminClips();
				_monet = new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("coin_"), 16,GlobalSettings.BOSS_X+GlobalSettings.DROP_BOSS_X,GlobalSettings.BOSS_Y+GlobalSettings.DROP_BOSS_Y,370);
				Starling.juggler.add(_monet);
				Facade.starlingStage.addChild(_monet);
				
				_monet.scaleX = _monet.scaleY = 0.4;
				_starExperience.scaleX = _starExperience.scaleY = 0.7;
				_monet.addEventListener(TouchEvent.TOUCH, monet_touch);
				_bossHit.visible = true;
				_bossStay.visible = false;
				_bossHit.play();
				_bossStay.stop();
				_bossHit.loop = false;
				_bossHit.addEventListener(Event.COMPLETE, bossHit_complete);
				
				}
				
				else
				
				{
					    createStarsBoss();
				         //
				         createAdminClips();
						_monet = new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("coin_"), 16,GlobalSettings.BOSS_X+GlobalSettings.DROP_BOSS_X,GlobalSettings.BOSS_Y+GlobalSettings.DROP_BOSS_Y,370);
						 Facade.starlingStage.removeChild(_bossStay);
						 Facade.starlingStage.removeChild(_bossChair);
						_bossDeath.visible = true;
						_bossDeath.play();
						_bossDeath.loop = false;
						_sensorBoss.touchable = false;
				}
			 }
		
				
			}
		
		//hits
		private function securityHit_complete(e:Event):void 
		{
			    _securityHit.visible = false
				_securityStay.visible = true;
				_securityHit.stop();
				_securityStay.play();
				_securityHit.removeEventListener(Event.COMPLETE, secretHit_complete);
		}
		//secretary
		private function secretHit_complete(e:Event):void 
		{
			    _secretHit.visible = false
				_secretStay.visible = true;
				_secretHit.stop();
				_secretStay.play();
				_secretHit.removeEventListener(Event.COMPLETE, secretHit_complete);
				
		}
		//manager
		private function managerHit_complete(e:Event):void 
		{
			    _managerHit.visible = false
				_managerStay.visible = true;
				_managerHit.stop();
				_managerStay.play();
				_managerHit.removeEventListener(Event.COMPLETE, managerHit_complete);		
		}
		//admin
		private function adminHit_complete(e:Event):void 
		{
			    _adminHit.visible = false
				_adminStay.visible = true;
				_adminHit.stop();
				_adminStay.play();
				_adminHit.removeEventListener(Event.COMPLETE, adminHit_complete);		
		}
		//boss
		private function bossHit_complete(e:Event):void 
		{
			    _bossHit.visible = false
				_bossStay.visible = true;
				_bossHit.stop();
				_bossStay.play();
				_bossHit.removeEventListener(Event.COMPLETE, bossHit_complete);		
		}
		
		
		//stars
		private function createStarsSecret():void 
		{
				for (var i:int = 0; i < 5; i++) 
					{
						_starExperience = new dropThingImage(AssetsDrop.getTexture("_starCl"),GlobalSettings.SECRETARY_X+GlobalSettings.DROP_SECRETARY_X,GlobalSettings.SECRETARY_Y+GlobalSettings.DROP_SECRETARY_Y);	
						Facade.starlingStage.addChild(_starExperience);
						//experienceViews.push(_starExperience);
						_starExperience.addEventListener(TouchEvent.TOUCH, starExperience_touch);
					}
					
			    for (var j:int = 0; j < 2; j++) 
			        {
				//_starExperience = new Image(Texture.fromBitmap(new _starCl()));
				_starExperience = new dropThingImage(AssetsDrop.getTexture("_starCl"),GlobalSettings.SECRETARY_X+GlobalSettings.DROP_SECRETARY_X,GlobalSettings.SECRETARY_Y+GlobalSettings.DROP_SECRETARY_Y);
				Facade.starlingStage.addChild(_starExperience); 
				_starExperience.scaleX = _starExperience.scaleY = 0.7;
                _starExperience.addEventListener(TouchEvent.TOUCH, starExperience_touch);
			        }
		}
		//security
		private function createStarsSecu():void 
		{
				for (var i:int = 0; i < 5; i++) 
					{
						_starExperience = new dropThingImage(AssetsDrop.getTexture("_starCl"),GlobalSettings.SECURITY_X+GlobalSettings.DROP_SECURITY_X,GlobalSettings.SECURITY_Y+GlobalSettings.DROP_SECURITY_Y,430);	
						Facade.starlingStage.addChild(_starExperience);
						//experienceViews.push(_starExperience);
						_starExperience.addEventListener(TouchEvent.TOUCH, starExperience_touch);
					}
					for (var j:int = 0; j< 2; j++) 
			{
				//_starExperience = new Image(Texture.fromBitmap(new _starCl()));
				_starExperience = new dropThingImage(AssetsDrop.getTexture("_starCl"),GlobalSettings.SECURITY_X+GlobalSettings.DROP_SECURITY_X,GlobalSettings.SECURITY_Y+GlobalSettings.DROP_SECURITY_Y,430);
				Facade.starlingStage.addChild(_starExperience); 
				_starExperience.scaleX = _starExperience.scaleY = 0.7;
                _starExperience.addEventListener(TouchEvent.TOUCH, starExperience_touch);
			}
		}
		//manager
		private function createStarsManager():void 
		{
				for (var i:int = 0; i < 5; i++) 
					{
						_starExperience = new dropThingImage(AssetsDrop.getTexture("_starCl"),GlobalSettings.MANAGER_X+GlobalSettings.DROP_MANAGER_X,GlobalSettings.MANAGER_Y+GlobalSettings.DROP_MANAGER_Y,370);	
						Facade.starlingStage.addChild(_starExperience);
						//experienceViews.push(_starExperience);
						_starExperience.addEventListener(TouchEvent.TOUCH, starExperience_touch);
					}
		}
		//adm
		private function createStarsAdmin():void 
		{
				for (var i:int = 0; i < 5; i++) 
					{
						_starExperience = new dropThingImage(AssetsDrop.getTexture("_starCl"),GlobalSettings.ADMIN_X+GlobalSettings.DROP_ADMIN_X,GlobalSettings.ADMIN_Y+GlobalSettings.DROP_ADMIN_Y,450);	
						Facade.starlingStage.addChild(_starExperience);
						//experienceViews.push(_starExperience);
						_starExperience.addEventListener(TouchEvent.TOUCH, starExperience_touch);
					}
		}
		//boss
		private function createStarsBoss():void 
		{
				for (var i:int = 0; i < 5; i++) 
					{
						_starExperience = new dropThingImage(AssetsDrop.getTexture("_starCl"),GlobalSettings.BOSS_X+GlobalSettings.DROP_BOSS_X,GlobalSettings.BOSS_Y+GlobalSettings.DROP_BOSS_Y,430);	
						Facade.starlingStage.addChild(_starExperience);
						//experienceViews.push(_starExperience);
						_starExperience.addEventListener(TouchEvent.TOUCH, starExperience_touch);
					}
		}
		
		//clips
		
		private function createClip():void 
		{
		
			//_monet = new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("coin_"), 16);
			skr=new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("skrepka_"), 8,GlobalSettings.SECRETARY_X+GlobalSettings.DROP_SECRETARY_X,GlobalSettings.SECRETARY_Y+GlobalSettings.DROP_SECRETARY_Y);
			//_animationBackX = new FPTween( { duration:1.5, property:FPTProperties.SCALEX, ease:FPTEaseTypes.ELASTIC_IN_OUT, target:_backGround, finish:0.01 } );
			//directorStay.scaleX = directorStay.scaleY = 1;
		
			skr.scaleX = skr.scaleY = 0.55;
			
			Starling.juggler.add(skr);
			Facade.starlingStage.addChild(skr);
			skr.addEventListener(TouchEvent.TOUCH, skr_touch);
			
			
		}
		
		//secy
		private function createClipSecu():void 
		{
			skr=new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("skrepka_"), 8,GlobalSettings.SECURITY_X+GlobalSettings.DROP_SECURITY_X,GlobalSettings.SECURITY_Y+GlobalSettings.DROP_SECURITY_Y,430);
			skr.scaleX = skr.scaleY = 0.55;
			Starling.juggler.add(skr);
			Facade.starlingStage.addChild(skr);
			skr.addEventListener(TouchEvent.TOUCH, skr_touch);	
		}
		//manag
		private function createManagerClips():void 
		{
			skr=new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("skrepka_"), 8,GlobalSettings.MANAGER_X+GlobalSettings.DROP_MANAGER_X,GlobalSettings.MANAGER_Y+GlobalSettings.DROP_MANAGER_Y,370);
			skr.scaleX = skr.scaleY = 0.55;
			Starling.juggler.add(skr);
			Facade.starlingStage.addChild(skr);
			skr.addEventListener(TouchEvent.TOUCH, skr_touch);
		}
		
		private function createAdminClips():void 
		{
			skr=new dropThingMC(AssetsDrop.getCoinAtlas().getTextures("skrepka_"), 8,GlobalSettings.MANAGER_X+GlobalSettings.DROP_MANAGER_X,GlobalSettings.MANAGER_Y+GlobalSettings.DROP_MANAGER_Y,370);
			skr.scaleX = skr.scaleY = 0.55;
			Starling.juggler.add(skr);
			Facade.starlingStage.addChild(skr);
			skr.addEventListener(TouchEvent.TOUCH, skr_touch);
		}
		private function skr_touch(e:TouchEvent):void 
		{
					if (e.getTouch((e.target) as DisplayObject, TouchPhase.HOVER))
			{
				(e.target as dropThingMC).turnReverseClip();
				
			  //  e.target.removeEventListener(TouchEvent.TOUCH, starExperience_touch);
			}
		}
		
		private function starExperience_touch(e:TouchEvent):void 
		{
			if (e.getTouch((e.target) as DisplayObject, TouchPhase.HOVER))
			{
				(e.target as dropThingImage).turnReverse();
				
			  //  e.target.removeEventListener(TouchEvent.TOUCH, starExperience_touch);
			}
		}
		
		private function monet_touch(e:TouchEvent):void 
		
		{
			if (e.getTouch((e.target) as DisplayObject, TouchPhase.HOVER))
			{
				(e.target as dropThingMC).turnReverseGold();
				
			  //  e.target.removeEventListener(TouchEvent.TOUCH, starExperience_touch);
			}
		}
		
		public function update(x:Number,y:Number):void 
		{
		
			
		}
		public function disposeMain():void 
		{
		    Facade.starlingStage.removeChildren();	
		}
		
	}

}