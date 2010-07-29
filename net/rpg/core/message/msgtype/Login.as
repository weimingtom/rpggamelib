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
			MSG.getinstance.listens(MessageType.SMT_LOGIN_INIT_EOLE_LIST, initRoleList);
			MSG.getinstance.listens(MessageType.CMT_LOGIN_SLECT_ROLE_OK, selectRoleOk);
			MSG.getinstance.listens(MessageType.SMT_POST_MAPID, getMapId);
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
		/**
		 * 判断是否登录成功
		 * @param	sdb
		 */
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
			sdb.clear();
			sdb = null;
		}
		/**
		 * 初始化角色列表
		 * @param	sdb
		 */
		private function initRoleList(sdb:GByteArray):void
		{
			var len:int = sdb.readUnsignedByte();
			var arr:Array = [];
			var obj:Object = {id:0,race:0,sex:0,name:"" };
			for (var i:int = 0; i < len; i++ ) {
				obj.id = sdb.readUnsignedInt();
				obj.race = sdb.readUnsignedByte();
				obj.sex = sdb.readUnsignedByte();
				obj.name = sdb.readUTFBytes(14);
				arr.push(obj);
				sdb.clear();
				sdb = null;
			}
			trace(arr[0].id,arr[0].race,arr[0].sex,arr[0].name);
		}
		/**
		 * 发送选择的角色id
		 */
		private function selectRoleOk(id:uint):void
		{
			var cdb:GByteArray = new GByteArray();
			cdb.writeShort(int(MessageType.CMT_LOGIN_SLECT_ROLE_OK));
			cdb.writeUnsignedInt(id);
			NetConnect.getinstance.getNet().writeBytes(cdb);
			NetConnect.getinstance.getNet().flush();
			cdb.clear();
			cdb = null;
		}
		/**
		 * 接收服务器发送的角色所在地图ID
		 */
		private function getMapId(sdb:GByteArray):void
		{
			var mapid:int = sdb.readUnsignedShort();
			trace(mapid);
			sdb.clear();
			sdb = null;
			
		}
	}

}class Private{}