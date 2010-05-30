package net.rpg.core.display.cell.lived 
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import net.rpg.core.display.Gobj;
	
	/**
	 * 具有生命力的现实对象接口
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public interface IGLived 
	{
		/**
		 * 鼠标进入
		 */
		function over(e:MouseEvent):void;
		/**
		 * 鼠标移出
		 */
		function out(e:MouseEvent):void;
		/**
		 * 鼠标移动
		 */
		function move(e:MouseEvent):void;
		/**
		 * 单击处理
		 */
		function click(e:MouseEvent):void;
		/**
		 * 选择对象
		 */
		function select(e:TimerEvent):void;
		/**
		 * 返回皮肤容器
		 */
		function get skin():Gobj;
		/**
		 * 销毁对象
		 */
		public function destroy():void
	}
	
}