package net.rpg.utils 
{
	import flash.display.LoaderInfo;
	/**
	 * ...
	 * @author 曹贤 
	 * QQ:343717442
	 */
	public class GetClass 
	{
		private static var my_class:Class;
		public static function getClass (L:LoaderInfo,className:String):Class
		{
			my_class = (L.applicationDomain.getDefinition(className) as Class);
			if (my_class == null) {
				return null;
			}
			return my_class;
		}
		
	}
}