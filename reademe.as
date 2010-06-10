package  
{
	/**
	 * 消息规则
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class reademe
	{
		/**
		 * C  -------------> S   连接操作
		 * C <-------------  S   返回地图数据 GM_MAP_INIT
		 * C  -------------> S   地图初始化完成 GM_MAP_INIT_COMPLETE
		 * C <-------------  S   发送角色数据   GOM_PLAYER_INFO
		 */
		 
		 
		 
		 /**
		  * 
		  * 消息头
		  * 消息 消息ID [两个字节]
		  * 
		  */
		 
		 
		 
		 /**
		  * 消息的定义
		  * 
		  * C  -------------> S  登陆  				10010    user[32] pwd[32]
		  * S ------------->  C  登陆失败			10011    state[1]
		  * S ------------->  C  登陆成功选择角色   10012    level[1] name[16] race_race[1]
		  */
	}

}