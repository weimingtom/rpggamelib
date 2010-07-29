package net.rpg.core.net 
{
	import net.rpg.core.message.MSG;
	import net.rpg.utils.GByteArray;
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class NetPack
	{
		/**
		 *单利句柄
		 */
		private static var instance:NetPack = null;
		
		/**
		 * 标志当前状态
		 */
		private var isComplete:Boolean = true;
		/**
		 * 锁
		 */
		private var lock:Boolean = false;
		/**
		 * 包头表示一个包的长度
		 */
		private var packHead:int = 0;
		
		/**
		 * 消息类型
		 */
		private var type:int = 0;
		
		public function NetPack(access:Private) 
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
		public static function get getinstance():NetPack
		{
			if (instance==null)
			{
				instance=new NetPack(new Private());
			}
			return instance;
		}
		/**
		 * 读取包
		 * @return
		 */
		public function getPacks(gs:GSocket):void
		{
			var ret:Array = [];
			var temp:GByteArray = null;
			if (isComplete == false) return;
			while(gs.bytesAvailable >= 2){
				if (gs.bytesAvailable >= 2 && lock == false) {
					lock = true;
					packHead = gs.readShort();
				}
				if (gs.bytesAvailable >= packHead && lock == true) {
					lock = false;
					temp = new GByteArray();
					gs.readBytes(temp, 0, packHead);
					ret.push(temp);
				}
				
			}
			isComplete = true;
			conveyGMSG(ret);
		}
		/**
		 * 传递消息处理
		 * @param	arr
		 */
		private function conveyGMSG(arr:Array):void
		{
			if (!isComplete) return;
			var onePack:GByteArray = null;
			while (arr.length > 0){
				onePack = (arr.shift() as GByteArray);
				type = onePack.readShort();
				MSG.getinstance.dispatch(type.toString(),onePack);
			}
			onePack = null;
		}
		
		/**
		 * 读包状态
		 */
		public function get isOk():Boolean
		{
			return isComplete;
		}
		
	}

}class Private{}