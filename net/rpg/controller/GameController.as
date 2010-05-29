package net.rpg.controller 
{
	import net.rpg.core.display.IGMain;
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
		public static function getinstance():GameController
		{
			if ( instance==null )
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
		}
	}

}class Private{}