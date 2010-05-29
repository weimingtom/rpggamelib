package net.rpg.core.loader 
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	/**
	 *加载器 
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class LibQuery
	{
		
		/**
		 *单例句柄 
		 */
		private static var instance:LibQuery=null;
		
		/**
		 *回调句柄 
		 */
		private var action:Function=null;
		
		/**
		 *加载地址 
		 */
		private var qurl:URLRequest=null;
		
		/**
		 *临时储存资源 
		 */
		private var temObj:Object=null;
		
		/**
		 *加载后的 LoaderInfo
		 */
		private var linfo:LoaderInfo=null;
		
		/**
		 *加载器 
		 */
		private var lQuery:Loader=null;
		
		/**
		 *超时计时器 
		 */
		private var time:Timer=null;
		
		
		public function LibQuery(access:Private)
		{
			if(access==null)
			{
				throw new Error("no access the Class");
			}
			qurl = new URLRequest();
			time = new Timer(60000);
			time.addEventListener(TimerEvent.TIMER,timeOut);
		}
		
		public static function get getinstance():LibQuery
		{
			if (instance==null)
			{
				instance=new LibQuery(new Private());
			}
			return instance;	
		}
		
		/**
		 *启动加载 
		 * @param ac 需要回调的函数
		 * @param obj 要加载的元素
		 * 
		 */
		public function onLoad(ac:Function,obj:Object):void
		{
			lQuery = new Loader();
			temObj=obj;
			qurl.url=obj.path;
			action = ac;
			time.start();
			
			lQuery.load(qurl);
			lQuery.contentLoaderInfo.addEventListener(Event.COMPLETE,complete);
			lQuery.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onErr);
		}
		
		/**
		 *加载完任务后的操作 
		 * @param e
		 * 
		 */
		private function complete(e:Event):void
		{
			lQuery.contentLoaderInfo.removeEventListener(Event.COMPLETE,complete);
			lQuery.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onErr);
			time.reset();
			linfo = (e.currentTarget as LoaderInfo);
			if(linfo==null)throw new Error("错误");
			temObj["data"]=linfo;
			if(action!=null)action(temObj);
		}
		
		/**
		 * IO出错处理 
		 * @param e
		 * 
		 */
		private function onErr(e:IOErrorEvent):void
		{
			time.reset();
		}
		
		/**
		 *超时处理 
		 * @param e
		 * 
		 */
		private function timeOut(e:TimerEvent):void
		{
			time.reset();
			lQuery.unload();
			time.start();
			lQuery.load(qurl);
		}
	}
}
class Private{}