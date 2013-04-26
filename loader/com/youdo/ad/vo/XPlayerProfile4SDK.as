package com.youdo.ad.vo {
	/**
	 * @author shsun
	 */
	public class XPlayerProfile4SDK {
		/**
		 * 
		 */
		public var PLAYER_NAME : String;
		/**
		 * 
		 */
		public var PLAYER_VERSION : String;
		// ------------------------------------------------------------------------------------------------------------------
		/**
		 * the rate type of main video. should be updated when rate changed
		 */
		public var currentRateType : int;
		/**
		 * TODO
		 */
		public var sourceId : String = '';
		/**
		 * userId and password
		 */
		public var password : String = '';
		public var userId : String = '';
		/**
		 * TODO
		 */
		public var stRate : String = '';
		/**
		 * href in browser.
		 */
		public var href : String = '';
		/**
		 * TODO
		 */
		public var v2priority : String = '';
		/**
		 * TODO
		 */
		public var noCache : String = '';

		// http://v2.tudou.com/v.action?si=&ui=10&vn=02&refurl=&st=1%2C2&it=127057989&hd=1&noCache=57260&sid=&pw=
		/*			
		parameters.si = baseInfo.sourceId;
		parameters.sid = baseInfo.sourceId;
		parameters.vn = "02";
		parameters.it = baseInfo.iid;
		parameters.pw = password;
		parameters.ui = baseInfo.userId;
		if(curRate!=-1) parameters.st = stRate;//currType.join(",")
		else parameters.st = currType.join(",");
		parameters.refurl = baseInfo.href;
		// 用来表示当前播放器默认播放的码流  1 - 低清256  2 - 高清360；当播放播放器码流+1即是其值  
		parameters.hd = baseInfo.currRateType+1;
		// 如果用户优先级有设置，则赋值
		if(!(!baseInfo.v2pr)) parameters.pr = baseInfo.v2pr;
		parameters.noCache = RandString.noCache;			
		 */
		// ==============================================================================================
		/**
		 * 
		 */
		public function XPlayerProfile4SDK() {
		}
	}
}
