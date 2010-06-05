package net.rpg.core.display.layer 
{
	import net.rpg.core.display.Gobj;
	import net.rpg.core.message.MSG;
	import net.rpg.core.net.NetConnect;
	import org.aswing.AsWingManager;
	import org.aswing.event.AWEvent;
	import org.aswing.FlowLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	/**
	 * ...
	 * @author 随风展翅
     * QQ:343717442
	 */
	public class UILayer extends Gobj implements IUILayer
	{
		
		/**
		 *单利句柄
		 */
		private static var instance:UILayer = null;
		
		public function UILayer(access:Private) 
		{
			if(access==null)
			{
				throw new Error("no access the Class");
			}
			init();
		}
		/**
		 *获取实例 
		 * @return 
		 * 
		 */
		public static function get getinstance():UILayer
		{
			if (instance==null)
			{
				instance=new UILayer(new Private());
			}
			return instance;
		}
		/**
		 * 初始化GUI
		 */
		private function init():void
		{
			AsWingManager.initAsStandard(this);
			
			var f:JFrame = new JFrame(this, "GUI控制面板");
			var initmap:JButton = new JButton("GM_MAP_INIT");
			initmap.addActionListener(onclick);
			
			var mapok:JButton = new JButton("GM_MAP_INIT_COMPLETE");
			mapok.addActionListener(click);
			
			var playerinfo:JButton = new JButton("GOM_PLAYER_INFO");
			
			
			f.setSizeWH(400, 300);
			f.getContentPane().setLayout(new FlowLayout());
			f.getContentPane().appendAll(initmap,mapok,playerinfo);
			f.show();
		}
		
		private function onclick(e:AWEvent):void
		{
			MSG.getinstance.dispatch("gm_map_init", 0);
		}
		private function click(e:AWEvent):void
		{
			NetConnect.getinstance.getNet().writeUTF("c");
			NetConnect.getinstance.getNet().flush();
		}
	}

}class Private{}