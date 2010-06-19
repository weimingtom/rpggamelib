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
		}
		/**
		 * 登陆服务器
		 */
		private function login(user:String,pwd:String,word:int=10010):void
		{
			var db:GByteArray = new GByteArray();
			db.endian = "littleEndian";
			db.writeShort(word);
			//trace(MD5.hash(user));
			db.writeUTFBytes(MD5.hash(user));
			//trace(MD5.hash(pwd));
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
		private function isLogin(db:GByteArray):void
		{
			db.position = 0;
			var islg:int = db.readUnsignedByte();
			switch(islg) {
				case 0:
					
				break;
				case 1:
				
				break;
				case 2:
				
				break;
				case 3:
				
				break;
			}
		}
	}

}class Private{}