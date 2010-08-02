package net.rpg.core.display.layer 
{
	import flash.events.MouseEvent;
	import net.rpg.core.display.Gobj;
	import net.rpg.core.display.map.Map;
	import net.rpg.core.display.layer.IFloorLayer;
	/**
	 * ...
	 * @author 随风展翅
     * QQ:343717442
	 */
	public class FloorLayer extends Gobj implements IFloorLayer
	{
		public function FloorLayer()
		{
			super();
		}
		/**
		 *初始化地图 
		 * 
		 */
		public function init():void
		{
			addEventListener(MouseEvent.CLICK,onClick);
		}
		/**
		 * 地图移动
		 * 
		 */
		public function setPoint(tx:int, ty:int):void
		{
			
		}
		/**
		 *地图跳转 
		 * @param obj
		 * 
		 */
		public function mapJump():void
		{
			
		}
		/**
		 * 鼠标点击事件
		 * @param	e
		 */
		public function onClick(e:MouseEvent):void
		{
		
		}
		
	}

}