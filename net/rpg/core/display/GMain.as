package net.rpg.core.display
{
	import net.rpg.controller.GameController;
	import net.rpg.core.loader.ResQuery;
	import net.rpg.core.message.MSG;
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	[SWF(width = "800", height = "600", frameRate = "24")]
	public class GMain extends Gobj implements IGMain
	{
		
		public function GMain() 
		{
			MSG.getinstance.listens(ResQuery.RQ_LOADE_OK,start);
			ResQuery.getinstance().path("http://192.168.1.250/config.xml?r="+Math.random());
		}
		
		private function start():void
		{
			GameController.getinstance().init(this);
		}
	}

}