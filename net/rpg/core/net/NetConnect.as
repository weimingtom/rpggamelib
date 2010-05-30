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
			if((typeof Hsock[ip])=="object" && Hsock[ip].port==port) throw new Error("Socket:" + ip + " Socket创建失败,该连接已存在");
			Hsock[ip] = new GSocket(ip,port);
		}
		
		
	}

}class Private{}