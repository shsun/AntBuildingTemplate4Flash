package com.youdo.ad.core {
	import com.youdo.ad.logger.XLogger;
	import flash.geom.Rectangle;

	/**
	 * @author shsun
	 */
	public class XAdSlot {
		private var proxied : *;

		/**
		 * 
		 */
		public function XAdSlot( proxiedObj : *) {
			//
			this.proxied = (proxiedObj != null) ? proxiedObj : {};
		}
		/*
		public function hide() : void {
			this.proxied.hide();
		}
		*/
		
		/*
		public function display() : void {
			this.proxied.display();
		}
		*/
		
		/**
		 * 
		 */
		/*
		public function getId() : String {
			return this.proxied.getId() as String;
		}
		*/

		/**
		 * preload
		 * 
		 * @see play()
		 */
		/*
		public function preload() : void {
			this.proxied.preload();
		}
		*/

		/**
		 * play ad slot
		 * 
		 * @see preload()
		 * @see stop()
		 * @see pause()
		 */
		public function play() : void {
			this.proxied.play();
		}

		/**
		 * stop slot
		 * 
		 * @see play()
		 * @see pause()
		 */
		public function stop() : void {
			this.proxied.stop();
		}

		/**
		 * pause slot
		 * 
		 * @see play()
		 * @see stop()
		 */
		/*
		public function pause() : void {
			this.proxied.pause();
		}
		*/

		/**
		 * @return true indicate has companion ads, otherwise no.
		 */
		/*
		public function hasCompanion() : Boolean {
			return this.proxied.hasCompanion();
		}
		*/

		/**
		 * 
		 * @param estimate
		 * @return total duration of slot
		 */
		public function getTotalDuration( estimate : Boolean = false) : int {
			return this.proxied.getTotalDuration( estimate );
		}

		/**
		 * 
		 */
		/*
		public function getTotalBytes( estimate : Boolean = false) : int {
			return this.proxied.getTotalBytes( estimate )
		}
		*/

		/**
		 * 
		 */
		/*
		public function getBytesLoaded( estimate : Boolean = false) : int {
			return this.proxied.getBytesLoaded( estimate );
		}
		*/

		/**
		 * time position of slot
		 * 
		 * @return -1 indicate it's non-temporal slot, otherwise return the time position of the slot
		 */
		/*
		public function getTimePosition() : int {
			return this.proxied.getTimePosition();
		}
		*/

		/**
		 * get the rectangle info of slot.
		 * return {x,y,width,height}
		 */		
		public function getRectangle() : Rectangle {
			return this.proxied.getRectangle();
		}

		/**
		 * 
		 */
		/*
		public function getAdInstances() : Vector.<XAdInstance> {
			var results : Vector.<XAdInstance> = new Vector.<XAdInstance>();
			var arr : Array = this.proxied.getAdInstances();
			for (var i : int = 0; i < arr.length;i++) {
				results.push( new XAdInstance( arr[i] ) );
			}
			return results;
		}
		*/

		/**
		 * @see com.youdo.ad.core.AdSlotType
		 */
		public function getType() : XAdSlotType {
			var type : XAdSlotType;
			switch (this.proxied.getSlotType().type) {
				case XAdSlotType.PREOLL.type :
					type = XAdSlotType.PREOLL;
					break;
				case XAdSlotType.PAUSEROLL.type :
					type = XAdSlotType.PAUSEROLL;
					break;
				case XAdSlotType.POSTROLL.type :
					type = XAdSlotType.POSTROLL;
					break;
				case XAdSlotType.OVERLAY.type :
					type = XAdSlotType.OVERLAY;
					break;
				case XAdSlotType.EXTERNAL_PAGE_DISPLAY.type :
					type = XAdSlotType.EXTERNAL_PAGE_DISPLAY;
					break;
				case XAdSlotType.EXTERNAL_VIDEO_DISPLAY.type :
					type = XAdSlotType.EXTERNAL_VIDEO_DISPLAY;
					break;
			}
			return type;
		}

		/**
		 * get ad count
		 */
		/*
		public function getAdCount() : uint {
			return this.proxied.getAdCount();
		}
		*/
		/**
		 * get playhead time of slot
		 */
		public function getPlayheadTime( ) : Number {
			return this.proxied.getPlayheadTime();
		}

		/**
		 * play companion ads
		 */
		/*
		public function playCompanion() : void {
			this.proxied.playCompanion();
		}
		*/

		/**
		 * ignore current Ad and keep playing if has next ad
		 */
		/*
		public function skipCurrentAd() : void {
			this.proxied.skipCurrentAd();
		}
		*/
	}
}
