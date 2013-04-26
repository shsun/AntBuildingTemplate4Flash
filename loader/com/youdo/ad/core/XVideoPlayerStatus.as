package com.youdo.ad.core {

	import flash.utils.Dictionary;

	/**
	 * @author shsun
	 */
	public class XVideoPlayerStatus {
		/**
		 * 
		 */
		static public const PLAYING : XVideoPlayerStatus = new XVideoPlayerStatus( "1" );
		/**
		 * 
		 */
		static public const PAUSED : XVideoPlayerStatus = new XVideoPlayerStatus( "2" );
		/**
		 * 
		 */
		static public const BUFFERING : XVideoPlayerStatus = new XVideoPlayerStatus( "3" );
		//

		//
		//
		/**
		 * 
		 */
		public function XVideoPlayerStatus( type : String) {
			this._type = type;
		}

		

		private var _type : String;

		public function get type() : String {
			return this._type;
		}
	}
}
