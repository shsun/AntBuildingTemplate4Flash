package com.youdo.ad.events {

	import com.youdo.ad.core.XAdSlot;

	import flash.events.Event;

	/**
	 * @author shsun
	 */
	public class XAdManagerEvent extends Event {
		/**
		 * 
		 */
		static public const REQUEST_COMPLETED : String = 'requestAdServerCompleted';
		/**
		 */
		static public const SLOT_STARTED : String = 'playSlotStarted';
		/**
		 */
		static public const SLOT_ENDED : String = 'playSlotEnded';
		// =====================================================================================================================
		/**
		 * 
		 */
		public var success : Boolean;
		/**
		 * 
		 */
		public var slot : XAdSlot;

		/**
		 * 
		 */
		public function XAdManagerEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super( type , bubbles , cancelable );
		}
	}
}
