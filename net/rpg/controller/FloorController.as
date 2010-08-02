package net.rpg.controller 
{
	import net.rpg.core.display.layer.FloorLayer;
	import net.rpg.core.display.map.Map;
	import net.rpg.manager.FloorManager;
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class FloorController
	{
		/**
		 *单利句柄
		 */
		private static var instance:FloorController = null;
		/**
		 * 地面对象
		 */
		private var _floor:FloorLayer = null;
		/**
		 * 地图对象
		 */
		private var _map:Map = null;
		
		
		
		public function FloorController(access:Private) 
		{
			if(access==null)
			{
				throw new Error("no access the Class");
			}
			_map = new Map();
			_floor = new FloorLayer();
		}
		/**
		 *获取实例 
		 * @return 
		 * 
		 */
		public static function get getinstance():FloorController
		{
			if (instance==null)
			{
				instance=new FloorController(new Private());
			}
			return instance;
		}
		/**
		 * 初始化
		 */
		public function init():void
		{
			_map.pushList = _floor;
			FloorManager.getinstance.initmsg();
		}
		/**
		 * 返回Map对象
		 */
		public function get map():Map
		{
			return _map;
		}
		/**
		 * 返回FloorLayer对象
		 */
		public function get floor():FloorLayer
		{
			return _floor;
		}
	}

}class Private{}