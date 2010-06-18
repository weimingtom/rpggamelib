package net.rpg.core.display.layer 
{
	import net.rpg.core.display.Gobj;
	import net.rpg.core.message.MSG;
	import net.rpg.manager.NetManager;
	import org.aswing.AsWingManager;
	import org.aswing.event.AWEvent;
	import org.aswing.FlowLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JTextField;
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
		
		private var user:JTextField=null;
		
		private var pwd:JTextField=null;
		
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
			
			var f:JFrame = new JFrame(null, "GUI控制面板");
			var enter:JButton = new JButton("连接服务器");
			enter.name = "enter";
			enter.addActionListener(click);
			var initmap:JButton = new JButton("GM_MAP_INIT");
			//GM_MAP_INIT_COMPLETE
			var mapok:JButton = new JButton("发送2");
			mapok.name = "mapok";
			mapok.addActionListener(click);
			var playerinfo:JButton = new JButton("GOM_PLAYER_INFO");
			
			user = new JTextField("test001",15);
			
			pwd = new JTextField("test001", 15);
			
			var post:JButton = new JButton(" 登 陆 ");
			post.name = "post";
			post.addActionListener(click);
			
			pwd.setDisplayAsPassword(true);
			f.setSizeWH(435, 300);
			f.getContentPane().setLayout(new FlowLayout());
			f.getContentPane().appendAll(enter,initmap,mapok,playerinfo,user,pwd,post);
			f.show();
		}
		private function click(e:AWEvent):void
		{
			switch(e.currentTarget.name) {
				case "enter":
					MSG.getinstance.dispatch(NetManager.NM_TO_CONNECT);
				break;
				case "mapok":
					
				break;
				case "post":
					MSG.getinstance.dispatch(NetManager.NM_TO_LOGIN,user.getText(),pwd.getText());
				break;
				
			}
		}
	}

}class Private{}