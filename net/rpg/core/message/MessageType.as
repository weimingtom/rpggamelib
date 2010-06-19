package net.rpg.core.message 
{
	/**
	 * 消息类型常量
	 * ...
	 * @author ...
	 */
	public class MessageType
	{
		/**
		 * 连接服务器
		 * 无参数
		 */
		public static const CMT_CONNECT:String = "10000";
		/**
		 * 登陆
		 * 消息(U2) 账号(32) 密码(32)
		 **/
		public static const CMT_LOGIN:String = "10010";
		/**
		 * 返回登陆状态
		 * 消息(U2) 状体(UChar1)   0为密码错误 1用户名错误 2为验证码错误 3为登陆成功
		 */
		public static const SMT_LOGIN:String = "10011";
		/**
		 * 返回选择列表
		 * 消息(U2) 角色的个数(1) [ID(UInt4) 种族(UChar1) 性别(UChar1) 名称(14)]
		 */
		public static const SMT_POST_SELECT_ROLE:String = "10012";
		/**
		 * 选择成功
		 * 消息(U2) 角色ID(UInt4)
		 */
		public static const CMT_SLECT_ROLE_OK:String = "10013";
		/**
		 * 角色所在地图
		 * 消息(U2) 地图ID(UChar1)
		 */
		public static const SMT_POST_MAPID:String = "10014";
	}

}