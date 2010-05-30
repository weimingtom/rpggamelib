package net.rpg.manager 
{
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class GobjectManager
	{
		/**
		 *单利句柄
		 */
		private static var instance:GobjectManager = null;
		
		public function GobjectManager(access:Private) 
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
		public static function get getinstance():GobjectManager
		{
			if (instance==null)
			{
				instance=new GobjectManager(new Private());
			}
			return instance;
		}
		
	}

}class Private{}