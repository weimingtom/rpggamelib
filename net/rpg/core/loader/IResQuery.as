package net.rpg.core.loader 
{
	import flash.display.LoaderInfo;

	/**
	 *资源加载控制接口 
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public interface IResQuery
	{
		/**
		 *返回系统集合中的某一项
		 * @param id 对应的资源id
		 * @return 
		 * 
		 */
		function getsys(id:String):LoaderInfo;
		/**
		 * 返回绘图集合中的某一项
		 * @param id 对应的资源id
		 * @return 
		 * 
		 */
		function getdraw(id:String):LoaderInfo;
		/**
		 * 返回动画集合中的某一项
		 * @param id 对应的资源id
		 * @return 
		 * 
		 */
		function getfilm(id:String):LoaderInfo;
		/**
		 *返回文本集合中的某一项
		 * @param id 对应的资源id
		 * @return 
		 * 
		 */
		function getbin(id:String):LoaderInfo;
		/**
		 * 启动加请求器
		 */
		function path(url:String):void;
		/**
		 * 读取xml数据 
		 * @return 
		 * 
		 */
		function get xml():XML;
		
		/**
		 *返回地图的数据
		 * @param id
		 * @return Object.id,Object.width,Object.height,Object.path
		 * 
		 */
		function getMapData(id:String):Object
	}
}