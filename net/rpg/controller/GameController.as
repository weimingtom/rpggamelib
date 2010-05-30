package net.rpg.controller 
{
	import net.rpg.core.display.IGMain;
	import net.rpg.core.display.layer.FloorLayer;
	import net.rpg.core.display.layer.UILayer;
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class GameController
	{
		/**
		 * 客户端窗口对象
		 */
		private var client:IGMain = null;
		
		/**
		 *单利句柄
		 */
		private static var instance:GameController = null;
		
		
		/**=========================================消息开始==================================================**/
		//public static const RQ_LOADE_OK:String = "rq_loade_ok";
		
		/**=========================================消息结束==================================================**/
		
		public function GameController(access:Private)
		{
			if(access==null)
			{
				throw new Error("no access the Class");
			}
		}
		/**
		 *获取实例 
		 * @return 
		 * 
		 */
		public static function get getinstance():GameController
		{
			if (instance==null)
			{
				instance=new GameController(new Private());
			}
			return instance;
		}
		/**
		 *初始化游戏控制器 
		 * @param gmain
		 * 
		 */
		public function init(gmain:IGMain):void
		{
			client = gmain;
			client.addChild(FloorLayer.getinstance);
			client.addChild(UILayer.getinstance);
		}
	}

}class Private{}