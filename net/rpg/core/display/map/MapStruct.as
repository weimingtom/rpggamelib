package net.rpg.core.display.map 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 *地图数据结构
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class MapStruct
	{
		
		
		/**
		 *地图id 
		 */
		public static var id:int=0;
		
		
		/**
		 *地图宽度 
		 */
		public static var width:int=0;
		
		/**
		 *地图高度 
		 */
		public static var height:int=0;
		
		/**
		 *客户端宽度 
		 */
		public static var cwidth:int=0;
		
		/**
		 *客户端高度 
		 */
		public static var cheight:int=0;
		
		public static var border:Point=new Point();
		
		/**
		 *地图路径 
		 */
		public static var path:String = "";
		
		/**
		 * 遮挡数据
		 */
		public static var tilef:String = "";
		
		/**
		 * 遮挡资源
		 */
		public static var unitf:String = "";
		
		/**
		 *地图上边框转换后的坐标
		 */
		public static var mtop:Number=0;
		
		/**
		 *地图左边框转换后的坐标
		 */
		public static var mleft:Number=0;
		
		/**
		 *地图右边框转换后的坐标
		 */
		public static var mrigth:Number=0;
		
		/**
		 *地图下边框转换后的坐标
		 */
		public static var mbottom:Number=0;
		
		
		/**
		 *窗体的中心点 
		 */
		public static var focus:Point=new Point();
		
		/**
		 *换算地图边框坐标 
		 * 
		 */
		public static function MapDataInit():void
		{
			mtop=border.x*-1;
			mleft=border.y*-1;
			mrigth=cwidth-(width-border.x);
			mbottom=cheight-(height-border.y);
		}
		
		/**
		 *设置边框原始值 
		 * @param x
		 * @param y
		 * 
		 */
		public static function SetBroder(x:Number,y:Number):void
		{
			border.x=x;
			border.y=y;
		}
		
	}

}