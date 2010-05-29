package net.rpg.core.display 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * 游戏入口 
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public interface IGMain 
	{
		function addChild(child:DisplayObject):DisplayObject;
		
		function get width():Number;
		function get height():Number;
		function get parent():DisplayObjectContainer;
	}
	
}