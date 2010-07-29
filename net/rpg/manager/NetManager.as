package net.rpg.manager 
{
	import net.rpg.core.message.MessageType;
	import net.rpg.core.message.MSG;
	import net.rpg.core.net.NetConnect;
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class NetManager
	{
		/**
		 *单利句柄
		 */
		private static var instance:NetManager = null;
		
		
		
		/**=========================================消息开始==================================================**/
		
		
		/**=========================================消息结束==================================================**/
		
		
		public function NetManager(access:Private) 
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
		public static function get getinstance():NetManager
		{
			if (instance==null)
			{
				instance=new NetManager(new Private());
			}
			return instance;
		}
		/**
		 * 初始化消息监听
		 */
		public function initmsg():void
		{
			MSG.getinstance.listens(MessageType.CMT_CONNECT, connect);
		}
			
		//======================================一下是逻辑处理部分===================================================
		 
		/**
		 * 连接服务器
		 */
		private function connect():void
		{
			NetConnect.getinstance.createSockte("192.168.1.3", 2012);
			MSG.getinstance.remove(MessageType.CMT_CONNECT);
		}
		
	}

}class Private{}