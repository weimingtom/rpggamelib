package net.rpg.utils 
{
	import flash.utils.ByteArray;
	
	/**
	 * G字节数组
	 * ...
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class GByteArray extends ByteArray
	{
		
		public function GByteArray() 
		{
			super();
			endian = "littleEndian";
		}
		
	}

}