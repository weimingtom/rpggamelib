package net.rpg.utils
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import net.rpg.core.display.cell.lived.GLived;
	
	/**
	 * 精确选择
	 * ...
	 * @author 曹贤 QQ:343717442
	 */
	public class SelectObj 
	{
		
		private static var Instance:SelectObj;
		private var map:BitmapData;
		private var mx:Matrix;
		private var re:Rectangle;
		private var color:ColorTransform;
		public static var getobj:GLived;
		/**
		 * 构造函数
		 * @param	access
		 */
		public function SelectObj(access:Private) 
		{
			super();
			if(access==null)
			{
				throw new Error("no access the Class:SelectObj");
			}
			color = new ColorTransform();
			map = new BitmapData(1, 1);
			mx = new Matrix();
			re = new Rectangle(0, 0, 1, 1);
		}
		/**
		 * 选择物体
		 * @param	container
		 * @return
		 */
		public static function Select(container:DisplayObjectContainer):Boolean
		{
			if (container.numChildren <= 0) return false;
			var index:Array = [];
			var arr:Array = [];
			var key:int;
			if ( Instance==null )
			{
				Instance=new SelectObj(new Private());
			}
			for (var i:int = 0; i < container.numChildren; i++ ) {
				arr.push(container.getChildAt(i));
				Instance.color.color = container.getChildIndex(arr[i]);
				index.push(arr[i].transform.colorTransform);
				arr[i].transform.colorTransform = Instance.color;
			}
			Instance.mx.tx = -int(container.stage.mouseX);
			Instance.mx.ty = -int(container.stage.mouseY);
			Instance.map.fillRect(Instance.re, 0xFFFFFFFF);
			Instance.map.draw(container.stage, Instance.mx, null, null, Instance.re);
			for (var o:int = 0; o < arr.length; o++ ) {
				arr[o].transform.colorTransform = index[o];
			}
			key = Instance.map.getPixel(0, 0);
			if (key < container.numChildren ) {
				getobj = arr[key] as GLived;
				return true;
			}else {
				return false;
			}
		}
		
	}
	
}
class Private{}