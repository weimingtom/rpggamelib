package net.rpg.manager 
{
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
		 *寻路 
		 * @param endx
		 * @param endy
		 * 
		 */
		private function getPath(endx:int,endy:int):void
		{
			
		}
		/**
		 * 地图结构填充
		 * 
		 */
		private function initMPStruct(id:String):void
		{
			
		}
	}

}class Private{}