package net.rpg.core.display.cell.lived 
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.utils.Timer;
	import net.rpg.core.display.cell.GCell;
	import net.rpg.core.display.Gobj;
	import net.rpg.utils.SelectObj;
	
	/**
	 * 具有生命力的现实对象
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class GLived extends GCell implements IGLived
	{
		protected var stime:Timer = null;
		protected var colorover:ColorMatrixFilter = null;
		protected var colorout:ColorMatrixFilter = null;
		private var _skin:Gobj = null;
		public function GLived() 
		{
			addEventListener(MouseEvent.MOUSE_MOVE, move);
			addEventListener(MouseEvent.MOUSE_OVER, over);
			addEventListener(MouseEvent.MOUSE_OUT, out);
			addEventListener(MouseEvent.CLICK, click);
			
			colorover = new ColorMatrixFilter([1.18,0,0,0,6.27,0,1.18,0,0,6.27,0,0,1.18,0,6.27,0,0,0,1,0]);
			colorout = new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0]);
			_skin = new Gobj();
			stime = new Timer(500);
			stime.addEventListener(TimerEvent.TIMER, select);
		}
		
		/**
		 * 鼠标进入
		 */
		public function over(e:MouseEvent):void
		{
			stime.start();
		}
		
		/**
		 * 鼠标移出
		 */
		public function out(e:MouseEvent):void
		{
			if(SelectObj.getobj==null)return;
			SelectObj.getobj.filters = [colorout];
			stime.stop();
			
		}
		/**
		 * 鼠标移动
		 */
		public function move(e:MouseEvent):void
		{
			isMove = true;
		}
		/**
		 * 选择对象
		 */
		public function select(e:TimerEvent):void
		{
			var rpk:GLived=null;
			if (isMove == false) return;
			isOver = SelectObj.Select(this.parent);
			if(SelectObj.getobj==null)return;
			if (isOver == true)
			{
				SelectObj.getobj.skin.filters = [colorover];
			} else {
				SelectObj.getobj.skin.filters = [colorout];
			};
			isMove = false;
		}
		
		/**
		 * 单击处理
		 */
		public function click(e:MouseEvent):void
		{
			if (isOver)
			{
				
			}else {
				
			}
		}
		/**
		 * 销毁对象
		 */
		public function destroy():void
		{
			stime.stop();
			stime.removeEventListener(TimerEvent.TIMER, select);
			stime = null;
			removeEventListener(MouseEvent.MOUSE_MOVE, move);
			removeEventListener(MouseEvent.MOUSE_OVER, over);
			removeEventListener(MouseEvent.MOUSE_OUT, out);
			removeEventListener(MouseEvent.CLICK, click);
			colorover = null;
			colorout = null;
			SelectObj.getobj = null;
		}
		/**
		 * 返回皮肤容器
		 */
		public function get skin():Gobj { return _skin; }
		
	}

}