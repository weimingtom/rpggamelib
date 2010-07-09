package net.rpg.core.display.cell 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public interface IGCell 
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