package net.rpg.core.display.map 
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * 地图类的实现
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class Map implements IMap
	{
		/**
		 *地图切块的宽度
		 */
		public static const TILEW:int = 256;
		/**
		 *地图切块的高度
		 */
		public static const TILEH:int = 256;
		/**
		 * 地图id
		 */
		private var mid:int = 0;
		/**
		 * 地图宽度
		 */
		private var mwidth:int = 0;
		/**
		 * 地图高度
		 */
		private var mheight:int = 0;
		/**
		 * 客户端宽度
		 */
		private var cwidth:int = 0;
		/**
		 *客户端高度 
		 */
		private var cheight:int = 0;
		/**
		 *地图路径
		 */
		private var path:String = "";
		/**
		 *地图队列加载并发数 
		 */
		private var iis:int = 2;
		/**
		 *地图黑边框
		 */
		private var border:int =0;
		/**
		 * 须加载的 url 地址列表
		 */
		private var url:Array=[];
		
		
		/**
		 *使用切块临时表 
		 */		
		private var mapList:Dictionary=null;
		/**
		 * 客户端切块矩阵
		 */
		private var rect:Rectangle = null;
		/**
		 *中心点 
		 */
		private var focus:Point = null;
		/**
		 *目标点 
		 */
		private var goal:Point = null;
		
		/**
		 *背景对象的现实列表
		 */
		private var context:DisplayObjectContainer;
		
		/**
		 *中心点最大范围 
		 */
		private var maxfocus:Point = null;
		
		public function Map()
		{
			rect = new Rectangle();
			focus = new Point();
			maxfocus = new Point();
			goal = new Point();
			mapList = new Dictionary();
		}
		/**
		 * 初始化地图
		 * @param	iis
		 */
		public function init(iis:int=2):void
		{
			mid = MapStruct.id;
			mwidth = MapStruct.width;
			mheight = MapStruct.height;
			path = MapStruct.path;
			maxfocus.x=MapStruct.width-MapStruct.focus.x;
			maxfocus.y=MapStruct.height-MapStruct.focus.y;
			this.cwidth = MapStruct.cwidth;
			this.cheight = MapStruct.cheight;
			this.iis = iis;
			
		}
		
		public function set pushList(dobj:DisplayObjectContainer):void
		{
			context = dobj;
		}
		
		public function achieveTile(p:Point):Rectangle
		{
			getRect();
			goal = p;
			focus.x = p.x;
			focus.y = p.y;
			
			
			if(focus.x < MapStruct.focus.x)focus.x = MapStruct.focus.x;
			if(focus.y < MapStruct.focus.y)focus.y = MapStruct.focus.y;
			
			if(focus.x > maxfocus.x)focus.x=maxfocus.x;
			if(focus.y > maxfocus.y)focus.y=maxfocus.y;
			
			rect.x = Math.ceil(goal.x / TILEW)-rect.width+1;
			rect.y = Math.ceil(goal.y / TILEH)-rect.height+1;
			
			
			
			
			
			var mapTileW:int = int(mwidth / TILEW);
			var mapTileH:int = int(mheight / TILEH);
			if (rect.right >= mapTileW) rect.x = mapTileW - 1 - rect.width;
			if (rect.bottom >= mapTileH) rect.y = mapTileH - 1 - rect.height;
			
			if (rect.x < 0) rect.x = 0;
			if (rect.y < 0) rect.y = 0;
			
			return rect;
		}
		
		public function set setUrl(re:Rectangle):void
		{
			
			if(context==null)throw new Error("Error: pushList 为被初始化...");
			
			var temp:Elment;
			
			setIdle();
			
			
			for(var i:Number= re.left; i <= re.right; i++){
				
				for (var m:Number = re.top; m <= re.bottom; m++) {
					
					temp = mapList[i + "_" + m];
					
					if (temp== null)
					{
						url.push({ x:i, y:m, url:path + "/" + i + "_" + m + ".jpg"});
					}else {
						temp.isUse = true;
					}
					
				}
			}
			loadImage(url);
		}
		
		public function moveMap(p:Point):void
		{
			
		}
		
		public function setCWH(width:int, heidht:int):void
		{
			
		}
		
		public function get mfocus():Point
		{
			return focus;
		}
		/**
		 * 加载图片
		 * @param	Hurl
		 */
		private function loadImage(hurl:Array):void
		{
			if (hurl.length > 0) {
				LThread.init(hurl, addChild, removeChild, iis);
			}
		}
		
		/**
		 * 加入对象
		 * 
		 */
		private function addChild(de:Elment):void
		{
			mapList[de.name]=de;
			context.addChild(de);
		}
		
		/**
		 *移除对象 
		 * 
		 */
		private function removeChild():void
		{
			
			for each (var item:Elment in mapList) { 
				if (item.isUse == false) {
					context.removeChild(item);
					item.destroy();
					delete mapList[item.name];
				}
			}
		}
		
		/**
		 * 返回客户端切块
		 * 
		 */
		private function getRect():void
		{
			//TODO 有点问题
			rect.width = int(cwidth % TILEW == 0?cwidth / TILEW:cwidth / TILEW + 1)+1;
			rect.height = int(cheight % TILEH == 0?cheight / TILEH:cheight / TILEH + 1)+1;
		}
		
		/**
		 * 设置背景元素为空闲状态
		 * 
		 */
		private function setIdle():void
		{
			for each (var item:Elment in mapList) { 
				item.isUse=false;
			}
		}
		
		
		
		/**
		 * 根据网格坐标取得象素坐标
		 */
		public static function getMapPoint(tileX:int,tileY:int):Point
		{
			var tileCenter:int = (tileX * 64) + 64/2;
			var xPixel:int = tileCenter + (tileY&1) * 64/2;
			var yPixel:int = (tileY + 1) * 32/2;	
			return new Point(xPixel, yPixel);
		}
		
		
		
		/**
		 *返回Tile的坐标 
		 * @param px
		 * @param py
		 * @return 
		 * 
		 */
		public static function getTilePoint(px:int, py:int):Point
		{
			var xtile:int = 0;
			var ytile:int = 0;
			
			var cx:int, cy:int, rx:int, ry:int;
			cx = int(px / 64) * 64 + 64/2;
			cy = int(py / 32) * 32 + 32/2;
			
			rx = (px - cx) * 32/2;
			ry = (py - cy) * 64/2;
			
			if (Math.abs(rx)+Math.abs(ry) <= 64 * 32/4)
			{
			
				xtile = int(px / 64);
				ytile = int(py / 32) * 2;
			}
			else
			{
				px = px - 64/2;
		
				xtile = int(px / 64) + 1;
				
				py = py - 32/2;
				ytile = int(py / 32) * 2 + 1;
			}
			
			return new Point(xtile - (ytile&1), ytile);
		}
	}
}