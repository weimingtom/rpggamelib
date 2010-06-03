package net.rpg.utils 
{
	/**
	 * 超快速排序算法
	 * @author 随风展翅
	 * QQ:343717442
	 */
	public class quickSort
	{
		
		public static function By(a:Array, low:int = 0, high:int = 17, k:int = 1048576):void
		{
			var i:int;
			var j:int;
			var x:int;
			i=low;
			j=high;
			while(i<j)
			{
				while(a[j]&k && i<j )j--;
				while((a[i]&k)==0 && i<j )i++;
				if(i<j)
				{
					
					x=a[j];
					a[j]=a[i];
					a[i]=x;
				}
				else
				{
					if(a[j]&k)i--;
					else j++;
					break;
				}
			}
			if(k>1)
			{
				if(low<i)By(a,low,i,k/2);
				if(j<high)By(a,j,high,k/2);
			}
		}
		
	}

}