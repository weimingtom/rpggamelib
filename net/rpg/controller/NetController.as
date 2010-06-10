package net.rpg.controller 
{
	import net.rpg.manager.NetManager;
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class NetController
	{
		
		/**
		 *单利句柄
		 */
		private static var instance:NetController = null;
		
		/**
		 * 连接控制器
		 */
		public function NetController(access:Private) 
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
		public static function get getinstance():NetController
		{
			if (instance==null)
			{
				instance=new NetController(new Private());
			}
			return instance;
		}
		
		public function init():void
		{
			NetManager.getinstance.initmsg();
		}
		
	}

}class Private{}