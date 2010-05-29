package net.rpg.core.loader 
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import net.rpg.core.message.MSG;
	import net.rpg.utils.GetSharedObject;
	

	/**
	 *资源加载控制器 
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class ResQuery implements IResQuery
	{
		
		private static var instance:ResQuery=null;
		
		/**
		 * 加载xml用的URLLoader对象
		 */
		private var query:URLLoader=null;
		
		/**
		 * URL 对象
		 */
		private var http:URLRequest=null;
		
		/**
		 * 加载成功的XML
		 */
		private var _xml:XML=null;
		
		/**
		 *服务器临时表 
		 */
		private var serverList:Array=[];
		
		/**
		 *选择服务器用的临时表 
		 */
		private var serverArr:Array=[];
		
		/**
		 *xml数据开关 
		 */
		private var ondata:Boolean=false;
		
		/**
		 *临时obj 
		 */
		private var temobj:Object=null;
		
		/**
		 *测试服务器速度的timer值 
		 */
		private var timer:int=0;
		
		/**
		 *最终的服务器ip 
		 */
		private var ip:String="";
		
		/**
		 *系统所用的资源集合 
		 */
		private var syspack:Dictionary=null;
		
		/**
		 *绘图所用的资源集合 
		 */
		private var drawpack:Dictionary=null;
		
		/**
		 *动画所用的资源集合 
		 */
		private var filmpack:Dictionary=null;
		
		/**
		 *文本所用的资源集合
		 */
		private var binpack:Dictionary=null;
		
		/**
		 *临时列表 
		 */
		private var tempList:Array=[];
		
		/**
		 *betimes列表
		 */
		private var betimesList:Object={};
		
		private var isRun:Boolean=false;
		
		/**
		 *当前加载的对象句柄 
		 */
		private var lObj:Object=null;
		
		
		/**=========================================消息开始==================================================**/
		public static const RQ_LOADE_OK:String = "rq_loade_ok";
		
		/**=========================================消息结束==================================================**/
		
		public function ResQuery(access:Private)
		{
			if(access==null)
			{
				throw new Error("no access the Class");
			}
			syspack=new Dictionary();
			drawpack=new Dictionary();
			filmpack=new Dictionary();
			binpack=new Dictionary();
			
			query = new URLLoader();
			query.dataFormat = "text";
			query.addEventListener(Event.COMPLETE,initToRun);
			query.addEventListener(IOErrorEvent.IO_ERROR,err);
		}
		
		public static function getinstance():ResQuery
		{
			if ( instance==null )
			{
				instance=new ResQuery(new Private());
			}
			return instance;	
		}
		
		
		public function getsys(id:String):LoaderInfo
		{
			if(syspack[id]==null){
				betimesLoad(id);
				return null;
			}
			return syspack[id];
		}
		
		public function getdraw(id:String):LoaderInfo
		{
			if(drawpack[id]==null){
				betimesLoad(id);
				return null;
			}
			return drawpack[id];
		}
		
		public function getfilm(id:String):LoaderInfo
		{
			if(filmpack[id]==null){
				betimesLoad(id);
				return null;
			}
			return filmpack[id];
		}
		
		public function getbin(id:String):LoaderInfo
		{
			if(binpack[id]==null){
				betimesLoad(id);
				return null;
			}
			return binpack[id];
		}
		
		public function path(url:String):void
		{
			http = new URLRequest(url);
			http.method = "GET";
			query.load(http);
		}
		
		public function get xml():XML
		{
			return _xml;
		} 
		
		public function getMapData(id:String):Object
		{
			var obj:Object={
				id:xml.maps.children()[int(id)].@id.toString(),
				width:xml.maps.children()[int(id)].@width.toString(),
				height:xml.maps.children()[int(id)].@height.toString(),
				fixwidth:xml.maps.children()[int(id)].@fixwidth.toString(),
				fixheight:xml.maps.children()[int(id)].@fixheight.toString(),
				path:ip+xml.maps.children()[int(id)].@path.toString(),
				tilef:xml.maps.children()[int(id)].@tilef.toString(),
				unitf:xml.maps.children()[int(id)].@unitf.toString()
			}
				if(id!=obj.id)throw new Error("地图数据不正确");
			return obj;
		}
		
		/**
		 * 初始化并启动
		 * @param e
		 * 
		 */
		private function initToRun(e:Event):void
		{
			
			if(ondata==false){
				if(query.data==null)throw new Error("初始化XML字符数据为空!");
				_xml = new XML(query.data);
				ip=GetSharedObject.getinstance().getfield("ResIP");
				if(ip){
					//TODO
					listFormat();
					return;
				}
				ondata=true;
				serverPath();
			}else{
				
				temobj.timer = getTimer()-timer;
				serverArr.push(temobj);
				
				if(serverList.length!=0){
					
					testServer();
				}else{
					
					selectServer();
					
				}
			}
		}
		
		/**
		 *初始化服务器地址 
		 * 
		 */
		private function serverPath():void
		{
			if(xml.server.http.length()>1){
				for(var i:int=0;i<xml.server.http.length();i++){
					serverList.push({ip:xml.server.http[i].@url.toString(),file:xml.server.http[i].@file.toString()+"?r="+Math.random(),timer:0});
				}
				testServer();
			}else{
				ip = xml.server.http[0].@url.toString();
				//TODO
				listFormat();
			}
		}
		
		/**
		 *测试服务器 
		 * 
		 */
		private function testServer():void
		{
			temobj=serverList.shift();
			http.url=temobj.ip+temobj.file;
			timer = getTimer();
			query.load(http);
		}
		
		/**
		 *选择服务器 
		 * 
		 */
		private function selectServer():void
		{
			var obj:Object=null;
			for(var i:int=0;i<serverArr.length;i++){
				if(obj==null){
					obj=serverArr[i];
				}else{
					if(obj.timer>serverArr[i].timer)obj=serverArr[i];
				}
			}
			ip = obj.ip;
			query.removeEventListener(Event.COMPLETE,initToRun);
			query.removeEventListener(IOErrorEvent.IO_ERROR,err);
			
			if(GetSharedObject.getinstance().getfield("ResIP")==null)GetSharedObject.getinstance().flushfield("ResIP",ip);
			//TODO
			listFormat();
			
		}
		
		/**
		 *XML IO错误处理 
		 * @param e
		 * 
		 */
		private function err(e:IOErrorEvent):void{
			throw new Error("初始化Config失败!");
		}
		
		/**
		 * 列表格式化
		 * 
		 */
		private function listFormat():void
		{
			var temxml:XML=null;
			
			for(var i:int=0;i<xml.resources.top.children().length();i++){
				
				temxml = xml.resources.top.children()[i];
				
				for(var $i:int=0;$i<temxml.children().length();$i++){
					tempList.push({
						id:temxml.children()[$i].@id.toString(),
						name:temxml.name().toString(),
						path:(ip+temxml.children()[$i].@path.toString()),
						txt:temxml.children()[$i].@txt.toString()
					});
				}
				
			}
			
			
			for(var ii:int=0;ii<xml.resources.betimes.children().length();ii++){
				
				temxml = xml.resources.betimes.children()[ii];
				
				for(var $ii:int=0;$ii<temxml.children().length();$ii++){
					betimesList[temxml.children()[$ii].@id.toString()]={
						name:temxml.name().toString(),
						path:(ip+temxml.children()[$ii].@path.toString()),
						state:false
					};
				}
				
			}
			
			onTopLoad(null);
			
		}
		
		/**
		 * 加载队列 
		 * @param db
		 * 
		 */
		private function onTopLoad(db:Object):void
		{
			isRun=true;
			if(db!=null){
				
				switch(db.name){
					case "syspack":
							syspack[db.id]=db.data;
						break;
					case "drawpack":
							drawpack[db.id]=db.data;
						break;
					case "filmpack":
							filmpack[db.id]=db.data;
						break;
					case "binpack":
							binpack[db.id]=db.data;
						break;
				}
			}
			
			
			if(tempList.length==0){
				isRun=false;
				MSG.getinstance.dispatch(RQ_LOADE_OK);
				MSG.getinstance.remove(RQ_LOADE_OK);
				return;
			}
			
			lObj = tempList.shift();
			
			LibQuery.getinstance().onLoad(onTopLoad,lObj);
			
		}
		
		/**
		 *动态加载 
		 * @param id 对应的资源id
		 * 
		 */
		private function betimesLoad(id:String):void
		{
			if(betimesList[id].state==true)return;
			betimesList[id].state=true;
			tempList.push(betimesList[id]);
			if(isRun==false)onTopLoad(null);
		}
		

	}
}
class Private{}