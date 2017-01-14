package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ф
	 */
	public class GameEvent extends Event 
	{
		public var params:Object
		public function GameEvent(type:String,$params:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			params = $params;
		}
		
	}

}