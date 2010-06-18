package net.rpg.core.message.msgtype 
{
	import net.rpg.core.message.MessageType;
	import net.rpg.core.message.MSG;
	import net.rpg.utils.GByteArray;
	/**
	 * ...
	 * @author ...
	 */
	public class Login
	{
		/**
		 *单利句柄
		 */
		private static var instance:Login = null;
		
		/**=========================================消息开始==================================================**/
		
		/**
		 * 地图初始化消息
		 */
		public static const GM_MAP_INIT:String = "gm_map_init";
		
		
		/**=========================================消息结束==================================================**/
		public function Login(access:Private) 
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
		public static function get getinstance():Login
		{
			if (instance==null)
			{
				instance=new Login(new Private());
			}
			return instance;
		}
		/**
		 * 初始化消息监听
		 */
		public function initmsg():void
		{
			MSG.getinstance.listens(MessageType.SMT_LOGIN, isLogin);
		}
		
		private function isLogin(db:GByteArray):void
		{
			
		}
	}

}class Private{}