package net.rpg.manager 
{
	import flash.geom.Point;
	import net.rpg.controller.FloorController;
	import net.rpg.core.display.map.MapDataLoad;
	import net.rpg.core.message.MSG;
	import net.rpg.core.message.msgtype.Login;
	/**
	 * 游戏图层控制器
	 * @author 随风展翅
     * QQ:343717442
	 */
	public class GameManager
	{
		/**
		 *单利句柄
		 */
		private static var instance:GameManager = null;
		
		/**=========================================消息开始==================================================**/
		
		
		
		
		/**=========================================消息结束==================================================**/
		
		public function GameManager(access:Private) 
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
		public static function get getinstance():GameManager
		{
			if (instance==null)
			{
				instance=new GameManager(new Private());
			}
			return instance;
		}
		/**
		 * 初始化
		 */
		public function init():void
		{
			initmsg();
			initMSGMode();
		}
		/**
		 * 初始化通讯模块
		 */
		private function initMSGMode():void
		{
			Login.getinstance.initmsg();
		}
		/**
		 *寻路 
		 * @param endx
		 * @param endy
		 * 
		 */
		private function getPath(endx:int,endy:int):void
		{
			
		}
		/**
		 * 初始化消息监听
		 */
		private function initmsg():void
		{
			MSG.getinstance.listens(MapDataLoad.MD_MAP_LOAD_COMPLETE, initComplete);
		}
		/**
		 * 加载完成
		 */
		private function initComplete():void
		{
			FloorController.getinstance.map.setUrl=FloorController.getinstance.map.achieveTile(new Point(80,90));
		}
		
	}

}class Private{}