package display.controller 
{
	/**
	 * ...
	 * @author ...
	 */
	public class GViewController
	{
		/**
		 *单利句柄
		 */
		private static var instance:GViewController = null;
		
		
		public function GViewController(access:Private) 
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
		public static function get getinstance():GViewController
		{
			if (instance==null)
			{
				instance=new GViewController(new Private());
			}
			return instance;
		}
	}

}class Private{}