package net.rpg.core.net 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	/**
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class GSocket extends Socket implements IGSocket
	{
		/**
		 * 地址
		 */
		private var _ip:String = "";
		/**
		 * 端口
		 */
		private var _port:int = 0;
		
		/**=========================================消息开始==================================================**/
		
		/**
		 * 连接成功消息
		 */
		public static const G_SOCKET_CONNECT:String = "g_socket_connect";
		
		/**
		 * IO错误消息
		 */
		public static const G_SOCKET_IOERR:String = "g_socket_ioerr";
		
		/**
		 * 安全沙箱消息
		 */
		public static const G_SOCKET_SECURITYERR:String = "g_socket_securityerr";
		
		/**
		 * 收到数据消息
		 */
		public static const G_SOCKET_DATA:String = "g_socket_data";
		
		/**=========================================消息结束==================================================**/
		
		
		public function GSocket(gip:String,gport:int) 
		{
			super(gip, gport);
			_ip = gip;
			_port = gport;
			addEventListener(Event.CONNECT, onConnect);
			addEventListener(IOErrorEvent.IO_ERROR, ioErr);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			addEventListener(ProgressEvent.SOCKET_DATA, onData);
			addEventListener(Event.CLOSE, onClose);
		}
		
		public function netClose():void
		{
			close();
		}
		
		/**
		 * 地址返回
		 */
		public function get ip():String { return _ip; }
		/**
		 * 端口返回
		 */
		public function get port():int { return _port; }
		/**
		 * 连接成功
		 * @param	e
		 */
		private function onConnect(e:Event):void
		{
			trace(_ip,":连接成");
		}
		/**
		 * IO错误
		 * @param	e
		 */
		private function ioErr(e:IOErrorEvent):void
		{
			throw new Error(_ip+":IO"+e.text);
		}
		/**
		 * 安全沙箱错误
		 * @param	e
		 */
		private function securityError(e:SecurityErrorEvent):void
		{
			throw new Error(_ip+":安全沙箱");
		}
		/**
		 * 收到数据
		 * @param	e
		 */
		private function onData(e:ProgressEvent):void
		{
			trace(_ip,":数据");
		}
		/**
		 * 关闭连接
		 * @param	e
		 */
		private function onClose(e:Event):void
		{
			trace(_ip,":关闭");
		}
	}

}