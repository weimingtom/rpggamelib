package net.rpg.core.net 
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class NetConnect
	{
		/**
		 *单利句柄
		 */
		private static var instance:NetConnect = null;
		
		/**
		 * 临时服务器名
		 */
		private var sname:String = "";
		/**
		 * 链接数
		 */
		private var length:int = 0;
		/**
		 * 链接句柄
		 */
		private var Hsock:Dictionary = null;
		/**=========================================消息开始==================================================**/
		
		/**
		 * 加载完成
		 */
		//public static const MD_MAP_LOAD_COMPLETE:String = "md_map_load_complete";
		
		/**=========================================消息结束==================================================**/
		
		public function NetConnect(access:Private) 
		{
			if(access==null)
			{
				throw new Error("no access the Class");
			}
			Hsock = new Dictionary();
		}
		/**
		 *获取实例 
		 * @return 
		 * 
		 */
		public static function get getinstance():NetConnect
		{
			if (instance==null)
			{
				instance=new NetConnect(new Private());
			}
			return instance;
		}
		/**
		 * 创建一个Socket连接
		 * @param	ip
		 * @param	port
		 */
		public function createSockte(ip:String,port:int):void
		{
			sname = ip + port;
			if((typeof Hsock[sname])=="object") throw new Error("Socket:" + ip + " Socket创建失败,该连接已存在");
			Hsock[sname] = new GSocket(ip, port);
			length++;
		}
		/**
		 * 关闭Socket连接 只有一个连接的情况下可不传递参数
		 * @param	ip
		 * @param	port
		 */
		public function close(ip:String="",port:int=0):void
		{
			if (length > 1) {
				if (ip == "" || port == 0) throw new Error("Socket:Socket连接数大于1请传递参数");
				sname = ip + port;
			}
			if (Hsock[sname] == "undefined" || Hsock[sname] == null) throw new Error("Socket:" + ip + "Socket关闭失败,该连接不存在");
			Hsock[sname].netClose();
			Hsock[sname] = null;
			delete Hsock[sname];
		}
		
		public function getNet(ip:String = "", port:int = 0):GSocket
		{
			if (length > 1) {
				if (ip == "" || port == 0) throw new Error("Socket:Socket连接数大于1请传递参数");
				sname = ip + port;
			}
			if (Hsock[sname] == "undefined" || Hsock[sname] == null) throw new Error("Socket:" + ip + "Socket获取失败,该连接不存在");
			return Hsock[sname];
		}
		
	}

}class Private{}