
package com.youdo.ad.core {

	/**
	 * @author shsun
	 */
	public class XAdSlotType {

		/**
		 * 
		 */
		static public const PREOLL : XAdSlotType = new XAdSlotType( "preroll" );
		/**
		 * 
		 */
		static public const MIDROLL : XAdSlotType = new XAdSlotType( "midroll" );
		/**
		 * 
		 */
		static public const POSTROLL : XAdSlotType = new XAdSlotType( "postroll" );
		/**
		 * 
		 */
		static public const OVERLAY : XAdSlotType = new XAdSlotType( "overaly" );
		/**
		 * 
		 */
		static public const PAUSEROLL : XAdSlotType = new XAdSlotType( "pauseroll" );
		
		/**
		 * 
		 */
		static public const EXTERNAL_VIDEO_DISPLAY : XAdSlotType = new XAdSlotType( "external_video_display" );
		/**
		 * 
		 */
		static public const EXTERNAL_PAGE_DISPLAY : XAdSlotType = new XAdSlotType( "external_page_display" );
		//
		//

		//
		//
		/**
		 * 
		 */
		public function XAdSlotType(type : String) {
			this._type = type;
		}


		private var _type : String;


		public function get type() : String {
			return this._type;
		}
	}
}
