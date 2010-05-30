package net.rpg.core.display.map 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	/**
	 * 地图切块类主要负责地图里的切块处理 (地图是有一个个切块组织起来拼成一个大的场景)
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class Elment extends Loader
	{
		
		/**
		 *当前切块的使用状态 
		 */
		private var _inUse:Boolean = false;
		
		public function Elment(obj:Object)
		{
			super();

			LThread.count++;
			contentLoaderInfo.addEventListener(Event.COMPLETE, lok);
			contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, err);
			parameter = obj;
		}
		
		/**
		 * get 使用状态
		 */
		public function get isUse():Boolean{
			return _inUse;
		}
		
		/**
		 * set 使用状态
		 */
		public function set isUse(u:Boolean):void{
			_inUse = u;
		}
		
		/**
		 * set 对象数据
		 */
		public function set parameter(d:Object):void
		{
			this.isUse = true;
			this.name = d.x + "_" + d.y;
			this.x = d.x * 256;
			this.y = d.y * 256;
			this.load(new URLRequest(d.url));
		}
		
		/**
		 * 错误处理 
		 * @param e
		 * 
		 */
		private function err(e:IOErrorEvent):void
		{
			destroy();
			throw new Error(e.text);
		}
		
		/**
		 *加载完成后的处理 
		 * @param e
		 * 
		 */
		private function lok(e:Event):void
		{
			if (LThread.count >= LThread.s_iis) {
				LThread.count = 0;
				LThread.run();
			}
			contentLoaderInfo.removeEventListener(Event.COMPLETE, lok);
			contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, err);
		}
		
		/**
		 *销毁处理 
		 * 
		 */
		public function destroy():void
		{
			unloadAndStop
		}
	}
}