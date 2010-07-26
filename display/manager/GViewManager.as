package display.manager 
{
	/**
	 * ...
	 * @author ...
	 */
	public class GViewManager
	{
		/**
		 *单利句柄
		 */
		private static var instance:GViewManager = null;
		
		public function GViewManager(access:Private) 
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
		public static function get getinstance():GViewManager
		{
			if (instance==null)
			{
				instance=new GViewManager(new Private());
			}
			return instance;
		}
		
	}

}class Private{}