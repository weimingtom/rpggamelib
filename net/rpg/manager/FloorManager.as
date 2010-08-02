package net.rpg.manager 
{
	import net.rpg.controller.FloorController;
	import net.rpg.core.display.map.MapDataLoad;
	import net.rpg.core.display.map.MapStruct;
	import net.rpg.core.loader.ResQuery;
	import net.rpg.core.message.MSG;
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class FloorManager
	{
		/**
		 *单利句柄
		 */
		private static var instance:FloorManager = null;
		
		
		/**=========================================消息开始==================================================**/
		
		/**
		 * 地图初始化消息
		 */
		public static const GM_MAP_INIT:String = "gm_map_init";
		
		
		/**=========================================消息结束==================================================**/
		
		
		
		public function FloorManager(access:Private) 
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
		public static function get getinstance():FloorManager
		{
			if (instance==null)
			{
				instance=new FloorManager(new Private());
			}
			return instance;
		}
		/**
		 * 初始化消息
		 */
		public function initmsg():void
		{
			MSG.getinstance.listens(GM_MAP_INIT, initMPStruct);
		}
		/**
		 * 填充地图结构体
		 * @param	id
		 */
		public function initMPStruct(id:String):void
		{
			var mapinfo:Object=ResQuery.getinstance.getMapData(id);
			MapStruct.id=mapinfo.id;
			MapStruct.width=mapinfo.width;
			MapStruct.height=mapinfo.height;
			MapStruct.path=mapinfo.path;
			MapStruct.cwidth=800;
			MapStruct.cheight = 600;
			MapStruct.tilef=(mapinfo.path+"/"+mapinfo.tilef);
			MapStruct.unitf=(mapinfo.path+"/"+mapinfo.unitf);
			//TODO
			MapStruct.focus.x=int(MapStruct.cwidth/2);
			MapStruct.focus.y=int(MapStruct.cheight/2);
			MapStruct.SetBroder(mapinfo.fixwidth,mapinfo.fixheight);
			MapStruct.MapDataInit();
			FloorController.getinstance.map.init();
			MapDataLoad.getinstance.load();
		}
	}

}class Private{}