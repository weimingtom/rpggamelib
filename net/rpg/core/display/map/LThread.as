package net.rpg.core.display.map 
{
	/**
	 * 模拟线程加载地图切块 
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class LThread
	{
		
		/**
		 *引用url 
		 */
		private static var s_turl:Array = null;
		
		/**
		 * 加载开关
		 */
		private static var s_go:Boolean = false;
		
		/**
		 *添加回调 
		 */
		private static var s_addaction:Function = null;
		
		/**
		 *移除回调 
		 */
		private static var s_endaction:Function = null;
		
		/**
		 *并发线程 
		 */
		public static var s_iis:int = 0;
		
		/**
		 *计数器统计 
		 */		
		public static var count:int = 0;
		
		/**
		 *初始化函数 
		 * @param url 			引用url 
		 * @param add			添加回调
		 * @param endaction		移除回调
		 * @param threadSum		并发线程
		 * 
		 */
		public static function init(url:Array, add:Function = null, endaction:Function = null, threadSum:Number = 2):void
		{
			s_turl = url;
			s_addaction = add;
			s_endaction = endaction;
			s_iis = threadSum;
			run();
		}
		
		/**
		 * 启动器
		 */
		public static function run():void
		{
			
			for (var i:int = 0; i < s_iis; i++ ) {
				if (s_turl.length > 0) {
					getURL();
				}else {
					s_go = true;	
					s_endaction();
				}
			}
		}
		
		/**
		 * 加载实例
		 */
		private static function getURL():void
		{	
			s_go = false;	
			s_addaction(new Elment(s_turl.shift()));
			
		}
	}
}