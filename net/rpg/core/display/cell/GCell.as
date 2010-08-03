package net.rpg.core.display.cell 
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import net.rpg.core.display.Gobj;
	
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class GCell extends Gobj implements IGCell
	{
		
		private var _pak:DisplayObjectContainer = null;
		
		public function GCell() 
		{
			super();
		}
		/**
		 * 当前网格坐标
		 */
		public function get tile():Point
		{
			
		}
		/**
		 * 返回深度索引
		 */
		public function get index():int
		{
			
		}
		/**
		 * 皮肤特效包
		 */
		public function get pak():DisplayObjectContainer {
			if (_pak == null) {
				_pak = new DisplayObjectContainer();
				pakRenew();
				addChild(_pak);
			}
			return _pak;
		}
		/**
		 * 恢复皮肤包层默认位置
		 */
		public function pakRenew():void
		{
			_pak.x = -75;
			_pak.y = -150;
		}
	}

}