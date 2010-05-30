package net.rpg.core.display.cell.lived 
{
	import flash.geom.Point;
	
	/**
	 * 具有生命力的现实对象接口
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public interface IGLived 
	{
		/**
		 * 当前网格坐标
		 */
		function get tile():Point;
		/**
		 * 返回深度索引
		 */
		function get index():int
	}
	
}