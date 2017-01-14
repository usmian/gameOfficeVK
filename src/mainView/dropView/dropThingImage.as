package mainView.dropView 
{
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.TouchPhase;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ф
	 */
	public class dropThingImage extends Image 
	{
		private var startPosition:Point;
		private var lenght:Number;
		private var gravity:Point;
		private var angle:Number;
		private var direction:Point;
		
		private const LENGHT:Number = 320;
		private const ANGLE:Number = 270;
		private var startX:Number ;//надо передавать из инит
		private var startY:Number;
		private var finishY:Number;
		private var onRemove:DisplayObject;
		public function dropThingImage(texture:Texture,$startX:Number=485,$startY:Number=232,$finishY:Number = 460) 
		{
			super(texture);
			startX = $startX;
			startY = $startY;
			finishY = $finishY;
			finishY += Math.random() * 30;
			onRemove = this;
			startAnimation();
			this.addEventListener(Event.ENTER_FRAME, this_enterFrame);
		}
		private function startAnimation():void 
		{
			startPosition = new Point(startX, startY);
			gravity = new Point(0, 0.17);
			angle = ANGLE + Math.random() * 230;
			direction = getStartDirection(LENGHT, angle);
			this.x = startPosition.x;
			this.y = startPosition.y;
			
		}
		private function this_enterFrame(e:Event):void 
		{	
			 
            //
            // применяем к текущему вектору напрвления гравитацию
            // и получаем новый вектор направления
		     if (this.y<finishY) 
			 {
				 
				 this.x += direction.x;
				 this.y += direction.y;	 
			 }
			 direction = addVector(direction, gravity);
			/*if (this.y>=FINISHY) 
			{
				startAnimation();
			}*/
			
		}
		
			public function turnReverse():void
		{
				 if(this.y>=finishY)
			 {
				    //_endFly = true;
					
					var tw:Tween = new Tween(this, 0.9,"easeInOut");
			        var r:int = Math.floor(Math.random() * 40);
			        tw.moveTo(GlobalSettings.EXPERIENCE_X, GlobalSettings.INDICATOR_Y);
		            Starling.juggler.add(tw);
					tw.onComplete = function():void { trace("thisIsSparta"); Facade.starlingStage.removeChild(onRemove); };
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