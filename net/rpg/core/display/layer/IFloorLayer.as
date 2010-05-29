package net.rpg.core.display.layer 
{
	import flash.events.MouseEvent;
	
	/**
	 * 地面接口
	 * @author 随风展翅 
     *QQ:343717442
	 */
	public interface IFloorLayer 
	{
		/**
		 * 地图移动
		 * 
		 */
		function setPoint(tx:int,ty:int):void
		/**
		 *地图跳转 
		 * @param obj
		 * 
		 */
		function mapJump():void;
		/**
		 * 鼠标点击事件
		 * @param	e
		 */
		function onClick(e:MouseEvent):void
	}
	
}