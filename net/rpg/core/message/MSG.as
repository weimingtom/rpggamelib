package net.rpg.core.message 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class MSG
	{
		/**
		 *单利句柄
		 */
		private static var instance:MSG = null;
		private var handle:Dictionary = null;
		public function MSG(access:Private) 
		{
			if(access==null)
			{
				throw new Error("no access the Class");
			}
			handle = new Dictionary();
		}
		/**
		 *获取实例 
		 * @return 
		 * 
		 */
		public static function get getinstance():MSG
		{
			if (instance==null)
			{
				instance=new MSG(new Private());
			}
			return instance;
		}
		/**
		 * 监听消息
		 * @param	msg 消息名
		 * @param	action  处理方法
		 */
		public function listens(msg:String,action:Function):void
		{
			if((typeof handle[msg])=="function") throw new Error("消息:"+msg+"消息监听失败,该消息重复监听");
			handle[msg] = action;
		}
		/**
		 * 派遣消息
		 * @param	msg 消息名
		 * @param	... rest 参数
		 */
		public function dispatch(msg:String,... rest):void
		{
			if (handle[msg] == "undefined" || handle[msg] == null) throw new Error("消息:" + msg + "消息派发失败,未监听过该消息");
			handle[msg].apply(NaN,rest);
		}
		/**
		 * 移除消息
		 * @param	msg
		 */
		public function remove(msg:String):void
		{
			if (handle[msg] == "undefined" || handle[msg] == null) throw new Error("消息:" + msg + "消息删除失败,该消息不存在");
			handle[msg] = null;
			delete handle[msg];
		}
	}

}class Private{}