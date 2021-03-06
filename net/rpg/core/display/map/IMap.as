package net.rpg.core.display.map 
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.geom.Rectangle;


	/**
	 * 地图抽象类 
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public interface IMap
	{
		
		/**
		 * 初始化场景数据 
		 * @param iis		队列并发加载数
		 * 
		 */
		function init(iis:int=2):void;
		
		/**
		 * 设置被添加的显示列表
		 * @param dobj
		 * 
		 */
		function set pushList(dobj:DisplayObjectContainer):void;
		
		/**
		 *返回客户端切块矩阵 
		 * @param p 目标点
		 * @return 
		 * 
		 */
		function achieveTile(p:Point):Rectangle;
			
		/**
		 * 列出需要加载的背景切块地址
		 * @param re
		 * 
		 */
		function set setUrl(re:Rectangle):void
		
		/**
		 * 移动场景
		 * @param p
		 * 
		 */
		function moveMap(p:Point):void;
		
		/**
		 * 设置客户端窗口大小
		 * @param width  宽度
		 * @param heidht 高度
		 * 
		 */
		function setCWH(width:int,heidht:int):void;
	}
}