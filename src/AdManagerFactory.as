package {
	import flash.geom.Rectangle;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.system.Security;
	import flash.external.ExternalInterface;
	//
	import com.youdo.utils.DisplayObjectContainerUtil;
	import com.youdo.sdk.Config;
	import com.youdo.sdk.core.AdManager;

	/**
	 * 
	 */
	public class AdManagerFactory extends MovieClip {
		//
		static public const TAG:String = 'trunk';
		static public const REVERSION:String = '315';
		static public const TIME_STAMP:String = '20120808132601';
		static public const BUILD_VERSION : String = "Runtime-" + TAG + "-" + REVERSION + "-" + TIME_STAMP;
		static public const DEBUG:Boolean = true;

		/**
		 * 
		 */
		public function AdManagerFactory() {
			trace("SDK -- new AdManagerFactory() " + BUILD_VERSION);
			ExternalInterface.call('console.log', "SDK -- new AdManagerFactory() " + BUILD_VERSION);
			//
			Security.allowDomain('*');
			//
			Config.DEBUG = DEBUG;
			//
			DisplayObjectContainerUtil.drawRectBackground(this, new Rectangle(0, 0, 25, 25), 0xFF00FF, (Config.DEBUG ? 0.5 : 0));
		}

		public function getNewInstance(swcVer : int, view : DisplayObjectContainer) : com.youdo.sdk.core.AdManager {
			return new com.youdo.sdk.core.AdManager(view, swcVer, TAG);
		}
	}
}
