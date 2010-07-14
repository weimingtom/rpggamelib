package net.rpg.core.message.msgtype 
{
	import net.rpg.core.message.MessageType;
	import net.rpg.core.message.MSG;
	import net.rpg.core.net.NetConnect;
	import net.rpg.utils.GByteArray;
	import net.rpg.utils.md5.MD5;
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
			MSG.getinstance.listens(MessageType.CMT_LOGIN, login);
			MSG.getinstance.listens(MessageType.SMT_LOGIN, isLogin);
			MSG.getinstance.listens(MessageType.SMT_POST_SELECT_ROLE, selectRole);
		}
		/**
		 * 登陆服务器
		 */
		private function login(user:String,pwd:String):void
		{
			var cdb:GByteArray = new GByteArray();
			cdb.writeShort(int(MessageType.CMT_LOGIN));
			//trace(MD5.hash(user));
			cdb.writeUTFBytes(MD5.hash(user));
			//trace(MD5.hash(pwd));
			cdb.writeUTFBytes(MD5.hash(pwd));
			NetConnect.getinstance.getNet().writeBytes(cdb);
			NetConnect.getinstance.getNet().flush();
			cdb.clear();
			cdb = null;
			/**
			 * NetConnect.getinstance.getNet().writeBoolean(false);
			 * NetConnect.getinstance.getNet().flush();
			 */
		}
		private function isLogin(sdb:GByteArray):void
		{
			
			var islg:int = sdb.readUnsignedByte();
			switch(islg) {
				case 0:
					trace("登陆成功");
				break;
				case 1:
					
				break;
				case 2:
					
				break;
				case 3:
					
				break;
			}
		}
		
		private function selectRole(sdb:GByteArray):void
		{
			trace("解析角色");
		}
	}

}class Private{}