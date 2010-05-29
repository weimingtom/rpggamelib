package net.rpg.utils 
{
	import flash.events.AsyncErrorEvent;
	import flash.net.SharedObject;

	/**
	 * SharedObject 类的封装
	 * @author Administrator
	 * 
	 */
	public class GetSharedObject
	{
		private static var instance:GetSharedObject=null;
		
		/**
		 *so实例 
		 */
		private var so:SharedObject=null;
		public function GetSharedObject(access:Private)
		{
			if(access==null)
			{
				throw new Error("no access the Class");
			}
			so = SharedObject.getLocal("sys");
			if(so!=null)so.addEventListener(AsyncErrorEvent.ASYNC_ERROR,onerr);
		}
		public static function get getinstance():GetSharedObject
		{
			if (instance==null)
			{
				instance=new GetSharedObject(new Private());
			}
			return instance;	
		}
		
		/**
		 * 返回一个字段 
		 * @param field 字段
		 * @return 
		 * 
		 */
		public function getfield(field:String):String
		{
			if(so!=null){
				return so.data[field];
			}
			return "";
		}
		
		/**
		 *写入数据
		 * @param field 字段
		 * @param value 值
		 * 
		 */
		public function flushfield(field:String,value:*):void
		{
			so.data[field]=value;
			so.flush();
		}
		
		/**
		 *删除sol 
		 * 
		 */
		public function delSol():void 
		{
			if(so!=null) { 
				so.clear();
			}  
		}

		/**
		 *错误处理 
		 * @param e
		 * 
		 */
		private function onerr(e:AsyncErrorEvent):void
		{
		
		}
	}
}class Private{}