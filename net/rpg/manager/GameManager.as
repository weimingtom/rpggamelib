package net.rpg.manager 
{
	import net.rpg.core.display.map.Map;
	import net.rpg.core.display.map.MapDataLoad;
	import net.rpg.core.display.map.MapStruct;
	import net.rpg.core.loader.ResQuery;
	import net.rpg.core.message.MSG;
	/**
	 * 游戏图层控制器
	 * @author 随风展翅
     * QQ:343717442
	 */
	public class GameManager
	{
		/**
		 *单利句柄
		 */
		private static var instance:GameManager = null;
		
		/**=========================================消息开始==================================================**/
		
		/**
		 * 地图初始化消息
		 */
		public static const GM_MAP_INIT:String = "gm_map_init";
		
		
		/**=========================================消息结束==================================================**/
		
		public function GameManager(access:Private) 
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
		public static function get getinstance():GameManager
		{
			if (instance==null)
			{
				instance=new GameManager(new Private());
			}
			return instance;
		}
		/**
		 *寻路 
		 * @param endx
		 * @param endy
		 * 
		 */
		private function getPath(endx:int,endy:int):void
		{
			
		}
		/**
		 * 初始化消息监听
		 */
		public function initmsg():void
		{
			MSG.getinstance.listens(GM_MAP_INIT, mapinit);
			MSG.getinstance.listens(MapDataLoad.MD_MAP_LOAD_COMPLETE, initComplete);
		}
		private function mapinit(id:String):void
		{ 
			initMPStruct(id);
			MapDataLoad.getinstance.load();
		}
		/**
		 * 加载完成
		 */
		private function initComplete():void
		{
			
		}
		/**
		 * 地图结构填充
		 * 
		 */
		private function initMPStruct(id:String):void
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
			Map.getinstance.init();
		}
	}

}class Private{}