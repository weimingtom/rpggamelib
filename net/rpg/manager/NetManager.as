package net.rpg.manager 
{
	import flash.utils.ByteArray;
	import net.rpg.core.message.MSG;
	import net.rpg.core.net.NetConnect;
	import net.rpg.utils.md5.MD5;
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
		/**
		 * 连接服务器
		 */
		public static const NM_TO_CONNECT:String = "nm_to_connect";
		/**
		 * 登陆服务器
		 */
		public static const NM_TO_LOGIN:String = "nm_to_login";
		
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
			MSG.getinstance.listens(NetManager.NM_TO_CONNECT, connect);
			MSG.getinstance.listens(NetManager.NM_TO_LOGIN,login);
		}
			
		//======================================一下是逻辑处理部分===================================================
		 
		/**
		 * 连接服务器
		 */
		private function connect():void
		{
			NetConnect.getinstance.createSockte("192.168.1.3", 2012);
			MSG.getinstance.remove(NetManager.NM_TO_CONNECT);
		}
		/**
		 * 登陆服务器
		 */
		private function login(user:String,pwd:String,word:int=00010):void
		{
			var db:ByteArray = new ByteArray();
			db.writeShort(word);
			db.writeUTFBytes(MD5.hash(user));
			db.writeUTFBytes(MD5.hash(pwd));
			NetConnect.getinstance.getNet().writeBytes(db);
			NetConnect.getinstance.getNet().flush();
			db.clear();
			db = null;
			/**
			 * NetConnect.getinstance.getNet().writeBoolean(false);
			 * NetConnect.getinstance.getNet().flush();
			 */
		}
	}

}class Private{}