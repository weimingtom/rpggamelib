package net.rpg.core.message.msgtype 
{
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class GameMap
	{
		/**
		 *单利句柄
		 */
		private static var instance:GameMap = null;
		
		/**=========================================消息开始==================================================**/
		
		
		
		
		/**=========================================消息结束==================================================**/
		public function GameMap(access:Private) 
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
		public static function get getinstance():GameMap
		{
			if (instance==null)
			{
				instance=new GameMap(new Private());
			}
			return instance;
		}
		/**
		 * 初始化消息监听
		 */
		public function initmsg():void
		{
			
		}
		
	}

}class Private{}