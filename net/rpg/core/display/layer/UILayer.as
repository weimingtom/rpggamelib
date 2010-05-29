package net.rpg.core.display.layer 
{
	import net.rpg.core.display.Gobj;
	
	/**
	 * ...
	 * @author 随风展翅
     * QQ:343717442
	 */
	public class UILayer extends Gobj implements IUILayer
	{
		
		/**
		 *单利句柄
		 */
		private static var instance:UILayer = null;
		
		public function UILayer(access:Private) 
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
		public static function get getinstance():UILayer
		{
			if (instance==null)
			{
				instance=new UILayer(new Private());
			}
			return instance;
		}
	}

}class Private{}