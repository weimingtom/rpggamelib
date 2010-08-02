package net.rpg.controller 
{
	import net.rpg.core.display.layer.SceneLayer;
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class SceneController
	{
		/**
		 *单利句柄
		 */
		private static var instance:SceneController = null;
		
		private var _scene:SceneLayer = null;
		
		public function SceneController(access:Private) 
		{
			if(access==null)
			{
				throw new Error("no access the Class");
			}
			_scene = new SceneLayer();
		}
		/**
		 *获取实例 
		 * @return 
		 * 
		 */
		public static function get getinstance():SceneController
		{
			if (instance==null)
			{
				instance=new SceneController(new Private());
			}
			return instance;
		}
		/**
		 * 初始化
		 */
		public function init():void
		{
			
		}
		/**
		 * 返回SceneLayer对象
		 */
		public function get scene():SceneLayer
		{
			return _scene;
		}
	}

}class Private{}