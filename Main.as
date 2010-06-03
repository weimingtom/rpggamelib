package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.rpg.core.display.GMain;
	
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class Main extends Sprite 
	{
		private var game:GMain = null;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			game = new GMain();
			addChild(game);
			
		}
		
	}
	
}