package net.rpg.controller 
{
	import net.rpg.core.display.Game;
	import net.rpg.core.display.IGMain;
	import net.rpg.core.display.layer.UILayer;
	import net.rpg.manager.GameManager;
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class GameController
	{
		
		/**
		 *单利句柄
		 */
		private static var instance:GameController = null;
		
		/**
		 * 客户端窗口对象
		 */
		private var client:IGMain = null;
		/**
		 * 游戏窗体
		 */
		private var game:Game = null;
		
		
		
		public function GameController(access:Private)
		{
			if(access==null)
			{
				throw new Error("no access the Class");
			}
			game = new Game();
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
		public function initMode(gmain:IGMain):void
		{
			/**
			 * 初始化网络
			 */
			NetController.getinstance.init();
			/**
			 * 初始化游戏管理器
			 */
			GameManager.getinstance.init();
			/**
			 * 初始地图
			 */
			FloorController.getinstance.init();
			/**
			 * 初始化场景
			 */
			SceneController.getinstance.init();
			
			
			
			/**
			 * 初始化视图
			 */
			client = gmain;
			client.addChild(UILayer.getinstance);
			game.addChild(FloorController.getinstance.floor);
			game.addChild(SceneController.getinstance.scene);
			client.addChild(game);
			
		}
	}

}class Private{}