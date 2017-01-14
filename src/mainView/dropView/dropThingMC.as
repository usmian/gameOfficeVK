package mainView.dropView 
{
	import flash.geom.Point;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.display.Sprite;
	import starling.events.TouchPhase;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.display.DisplayObject;
	import starling.animation.Tween;
	import starling.core.Starling;
	/**
	 * ...
	 * @author ф
	 */
	public class dropThingMC extends MovieClip 
	{
		private var startPosition:Point;
		private var lenght:Number;
		private var gravity:Point;
		private var angle:Number;
		private var direction:Point;
		private var _endFly:Boolean = false;
		
		private const LENGHT:Number = 220;
		private const ANGLE:Number = 245;
		private var startX:Number;//надо передавать из инит
		private var startY:Number;
		private var finishY:Number;
		private var onRemove:DisplayObject;
		
		public function dropThingMC(textures:Vector.<Texture>, fps:Number=60,$startX:Number=485,$startY:Number=232,$finishY:Number = 460) 
		{
			super(textures, fps);
			startX = $startX;
			startY = $startY;
			finishY = $finishY;
			finishY += Math.random() * 30;
			startAnimation(startX,startY);
			this.addEventListener(Event.ENTER_FRAME, this_enterFrame);
			onRemove = this;//чтобы удалять из ссамого себя после ококнчания анимации
		}
		
		
		//animation of drop thing
		private function startAnimation($startX:Number,$startY:Number,$gravity:Number=0.17):void //gravity for more speed
		{
			startX = $startX;
			startY = $startY;
			startPosition = new Point(startX, startY);
			gravity = new Point(0,  $gravity);//x for amplitude
			angle = ANGLE + Math.random() * 230;
			direction = getStartDirection(LENGHT, angle);
			this.x = startPosition.x;
			this.y = startPosition.y;
			
		}
		private function this_enterFrame(e:Event):void 
		{	
			
			
			if (this.y<=finishY && !_endFly) 
			 {
				 this.x += direction.x;//amplitude!!!
				 this.y += direction.y;
				 
				 //trace(this.y);
			 }
			 direction = addVector(direction, gravity);
		
			 /*if (_isOn) 
			 {
				 startAnimation(this.x, this.y);
				 finishY = 100;
				 _isOn = false;
			 }*/
			
            //
            // применяем к текущему вектору напрвления гравитацию
            // и получаем новый вектор направления
			/*if (this.y>=FINISHY) 
			{
				startAnimation();
			}*/
			
		}
		public function turnReverseGold():void
		{
				 if(this.y>=finishY)
			 {
				    
				    _endFly = true;
					var tw:Tween = new Tween(this, 0.9,"easeInOut");
			        var r:int = Math.floor(Math.random() * 40);
			        tw.moveTo(GlobalSettings.GOLD_X,GlobalSettings.INDICATOR_Y );
		            Starling.juggler.add(tw)
					tw.onComplete = function():void { trace("thisIsSparta"); Facade.starlingStage.removeChild(onRemove); };
					 /* startAnimation(this.x, this.y,-0.18);
					 _targetDot = !_targetDot;
					 _hover = !_hover;*/ 
				
				/* this.x -= direction.x;
				 this.y -= direction.y*/;
			 }
		}
		
		public function turnReverseClip():void
		{
				 if(this.y>=finishY)
			 {
				    
				    _endFly = true;
					var tw:Tween = new Tween(this, 0.9,"easeInOut");
			        var r:int = Math.floor(Math.random() * 40);
			        tw.moveTo(GlobalSettings.CLIP_X, GlobalSettings.INDICATOR_Y);
		            Starling.juggler.add(tw);
					
					tw.onComplete = function():void { Facade.starlingStage.removeChild(onRemove); };
					 /* startAnimation(this.x, this.y,-0.18);
					 _targetDot = !_targetDot;
					 _hover = !_hover;*/ 
				
				/* this.x -= direction.x;
				 this.y -= direction.y*/;
			 }
		}
		   private function getStartDirection($length:Number, $angle:Number):Point
        {
            lenght = $length;
			angle = $angle;
			// вычисляем угол в радианах
            var aRad:Number = angle*Math.PI/180;
            // вычисляем значение X вектора
            var xpos:Number = length * Math.cos(aRad);
            // вычисляем значение Y вектора
            var ypos:Number = -length * Math.sin(aRad);
            return new Point(xpos, ypos);
        }
		private function addVector(v1:Point, v2:Point):Point
		{
			 return new Point(v1.x+v2.x, v1.y+v2.y);
		}
		
	}

}