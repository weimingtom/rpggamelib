package net.rpg.controller 
{
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class GobjectController
	{
		/**
		 *单利句柄
		 */
		private static var instance:GobjectController = null;
		
		
		/**=========================================消息开始==================================================**/
		//public static const RQ_LOADE_OK:String = "rq_loade_ok";
		
		/**=========================================消息结束==================================================**/
		
		
		public function GobjectController(access:Private)
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
		public static function get getinstance():GobjectController
		{
			if (instance==null)
			{
				instance=new GobjectController(new Private());
			}
			return instance;
		}
		
	}

}class Private{}