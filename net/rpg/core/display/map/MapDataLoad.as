package net.rpg.core.display.map 
{
	import com.qngame.tlzf.display.LoaderBar;
	import com.qngame.tlzf.facades.ViewFacade;
	import com.qngame.tlzf.utils.GetClass;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 *地图数据加载 
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class MapDataLoad
	{
		
		public static const MAPDATA_CP:String="mapdata_cp";
		
		private static const LOADSIZE:int=2;
		/**
		 *单例句柄 
		 */
		private static var instance:MapDataLoad=null;
		
		private var urlLoad:URLLoader=null;
		
		private var swfLoad:Loader=null;
		
		private var counter:int=0;
		
		private var lb:LoaderBar=null;
		
		private var tileFDB:ByteArray=null;
		
		private var unitFDB:LoaderInfo=null;
		
		private var unitList:Dictionary=new Dictionary();
		
		
		public function MapDataLoad(access:Private)
		{
			if(access==null)
			{
				throw new Error("no access the Class");
			}
			urlLoad = new URLLoader();
			swfLoad = new Loader();
			urlLoad.dataFormat="binary";
			urlLoad.addEventListener(Event.COMPLETE,loadComplete);
			urlLoad.addEventListener(IOErrorEvent.IO_ERROR,ioErr);
			urlLoad.addEventListener(ProgressEvent.PROGRESS,tilefprogress);
			swfLoad.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			swfLoad.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,ioErr);
			swfLoad.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,unitfprogress);
		}
		
		/**
		 *获取实例 
		 * @return 
		 * 
		 */
		public static function get getinstance():MapDataLoad
		{
			if ( instance==null )
			{
				instance=new MapDataLoad(new Private());
			}
			return instance;
		}
		
		/**
		 *开始加载 
		 * @param tilep 地图数据
		 * @param unitp 地图遮挡资源
		 * 
		 */
		public function load(tilep:String,unitp:String):void
		{
			destroy();
			urlLoad.load(new URLRequest(tilep));
			swfLoad.load(new URLRequest(unitp));
		}
		
		/**
		 *加载完成 
		 * @param e
		 * 
		 */
		private function loadComplete(e:Event):void
		{
			counter++;
			
			if("flash.net::URLLoader"==getQualifiedClassName(e.currentTarget)){
				tileFDB=e.currentTarget.data as ByteArray;
			}else{
				unitFDB=e.currentTarget as LoaderInfo;
			}
			if(counter>=LOADSIZE){
				counter=0;
				ViewFacade.getInstance.dispatchNotification(MAPDATA_CP);
			}
		}
		
		/**
		 *返回其中的某个元素 
		 * @param cname
		 * @return 
		 * 
		 */
		public function getone(cname:String):BitmapData
		{
			var btc:Class=null;
			if(unitList[cname]==null || unitList[cname]==undefined){
				btc=GetClass.getClass(unitFDB,cname);
				unitList[cname]=new btc(0,0);
			}
			
			return unitList[cname];
		}
		
		/**
		 *销毁处理
		 * 
		 */
		public function destroy():void
		{
			for (var key:String in unitList) 
			{ 
				unitList[key]=null;
				delete unitList[key];
				
			}
			if(unitFDB!=null)unitFDB.loader.unload();
			if(tileFDB!=null)tileFDB.clear();
		}
		
		/**
		 *返回 tileFDB 
		 * @return 
		 * 
		 */
		public function get db():ByteArray
		{
			return tileFDB;
		}
		
		private function ioErr(e:IOErrorEvent):void
		{
		
		}
		
		private function tilefprogress(e:ProgressEvent):void
		{
		
		}
		
		private function unitfprogress(e:ProgressEvent):void
		{
		
		}
	}
}class Private{}