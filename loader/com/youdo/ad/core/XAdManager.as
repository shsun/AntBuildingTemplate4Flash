package com.youdo.ad.core {

	import com.youdo.ad.vo.XPlayerProfile4SDK;
	import flash.system.Security;

	import com.youdo.ad.logger.XLogger;

	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;

	import com.youdo.ad.events.XAdManagerEvent;

	/**
	 * @author shsun
	 */
	public class XAdManager extends EventDispatcher {
		private var adSlotHashMap : Dictionary;
		//
		private var proxied : Object;

		/**
		 * 
		 */
		public function XAdManager( proxiedObj : Object) {
			Security.allowDomain( '*' );
			//
			this.adSlotHashMap = new Dictionary();
			//
			this.proxied = proxiedObj;
			this.proxied.addEventListener( XAdManagerEvent.REQUEST_COMPLETED , this.handleXAdManagerRequestCompleted );
			this.proxied.addEventListener( XAdManagerEvent.SLOT_STARTED , this.handleSlotStart );
			this.proxied.addEventListener( XAdManagerEvent.SLOT_ENDED , this.handleSlotEnded );
		}

		private function handleXAdManagerRequestCompleted( event : *) : void {
			this.dispatchEvent( this.convert2XAdManagerEvent( event ) );
		}

		private function handleSlotStart( event : *) : void {
			this.dispatchEvent( this.convert2XAdManagerEvent( event ) );
		}

		private function handleSlotEnded( event : *) : void {
			this.dispatchEvent( this.convert2XAdManagerEvent( event ) );
		}

		private function convert2XAdManagerEvent( event : *) : XAdManagerEvent {
			var evt : XAdManagerEvent = new XAdManagerEvent( event.type );
			evt.slot = this.convert2AdSlot( event.slot );
			evt.success = event.success as Boolean;
			return evt;
		}
		
		/**
		 * set the player profile
		 * 
		 * @param playerProfile
		 */
		public function set playerProfile(playerProfile : XPlayerProfile4SDK) : void {			
			this.proxied.playerProfile = playerProfile;
		}
		
		/**
		 * the playhead time of video player.
		 */
		public function set playheadTime(time : Number):void {
			this.proxied.playheadTime = time;
		}
		
		/**
		 * set the player name for SDK
		 * @param name
		 * @example
		 * <listing version="3.0">
		 * var theXAdManager:XAdManager = theXAdManagerLoader.newAdManager();
		 * theXAdManager.setPlayerName('TuDou_Homer');
		 * </listing>
		 */
		public function setPlayerName( name : String) : void {
			this.proxied.setPlayerName( name );
		}
		
		/**
		 * set the version of player for SDK
		 * @param version
		 * @example
		 * <listing version="3.0">
		 * var theXAdManager:XAdManager = theXAdManagerLoader.newAdManager();
		 * theXAdManager.setPlayerVersion('土豆主站 V1.8.1.1');
		 * </listing>
		 */
		public function setPlayerVersion( version : String) : void {
			this.proxied.setPlayerVersion( version );
		}

		public function setVideoPlayerStatus( status : XVideoPlayerStatus) : void {
			this.proxied.setVideoPlayerStatus( status.type );
		}

		/**
		 * @param parameters used for ad-request. (like: juid, rnd, ....)
		 * 
		 * @example
		 * <listing version="3.0">
		 * var theXAdManagerLoader:XAdManagerLoader = new XAdManagerLoader();
		 * theXAdManagerLoader.loadAdManager( handleXAdManagerLoad , 'http://127.0.0.1/a/AdManager.swf?' , Math.random() );
		 * function handleXAdManagerLoad( success : Boolean) : void {
		 * 		if (success) {
		 * 			// create XAdManager for ad-requesting if load success.
		 * 			var theXAdManager:XAdManager = theXAdManagerLoader.newAdManager();
		 * 			var p:Object = {juid:this.root.loaderInfo.parameters.juid,
		 * 				rnd:this.root.loaderInfo.parameters.rnd,
		 * 				tpa:this.root.loaderInfo.parameters.tpa, 
		 * 				....};
		 * 			theXAdManager:XAdManager.setAdRequestParameters( p );
		 * 		} else { 			
		 * 			// play video if load failed
		 * 			// TODO
		 * 		}
		 * }
		 * </listing>
		 */
		public function setAdRequestParameters( parameters : Object) : void {
			this.proxied.setAdRequestParameters( parameters );
		}

		/**
		 * Set the url of ad-server.
		 * 
		 * @param url the server-url
		 */
		public function setServer( url : String) : void {
			this.proxied.setServer( url );
		}

		/**
		 * 
		 * @see #getVideoPlayerNonTemporalSlots()
		 * @see #getSiteSectionNonTemporalSlots
		 * @see #getSlotById()
		 * @see #getActiveSlots()
		 * 
		 * @return All temporal slots
		 */
		/*
		public function getTemporalSlots() : Vector.<XAdSlot> {
		var results : Vector.<XAdSlot> = new Vector.<XAdSlot>();
		var slots : Array = this.proxied.getTemporalSlots().slice();
		while (slots.length) {
		results.push( this.convert2AdSlot( slots.pop() ) );
		}
		return results;
		}
		 */
		/**
		 * @see #getPauseroll
		 * @see #getPostroll
		 */
		public function getPreroll() : XAdSlot {
			return this.convert2AdSlot( (this.proxied.getPreroll as Function).apply( this ) );
		}

		/**
		 * @see #getPauseroll
		 * @see #getPreroll
		 */
		public function getPostroll() : XAdSlot {
			// (this.proxied.getPostroll as Function).apply( this , [] )
			return this.convert2AdSlot( this.proxied.getPostroll() );
		}

		/**
		 * @see #getPreroll
		 * @see #getPostroll
		 */
		public function getPauseroll() : XAdSlot {
			// (this.proxied.getPauseroll as Function).apply( this , [] )
			return this.convert2AdSlot( this.proxied.getPauseroll() );
		}
		
		/**
		 * 
		 */
		public function get isRequestSuccess():Boolean {
			return (this.proxied.isRequestSuccess as Boolean);
		}

		/**
		 * @see #getTemporalSlots
		 * @see #getSiteSectionNonTemporalSlots
		 * @see #getSlotById()
		 * @see #getActiveSlots()
		 */
		/*
		public function getVideoPlayerNonTemporalSlots() : Vector.<XAdSlot> {
		var results : Vector.<XAdSlot> = new Vector.<XAdSlot>();
		var slots : Array = this.proxied.getVideoPlayerNonTemporalSlots().slice();
		while (slots.length) {
		results.push( this.convert2AdSlot( slots.pop() ) );
		}
		return results;
		}
		 */
		/**
		 * @see #getTemporalSlots
		 * @see #getVideoPlayerNonTemporalSlots()
		 * @see #getSlotById()
		 * @see #getActiveSlots()
		 */
		/*
		public function getSiteSectionNonTemporalSlots() : Vector.<XAdSlot> {
		var results : Vector.<XAdSlot> = new Vector.<XAdSlot>();
		var slots : Array = this.proxied.getSiteSectionNonTemporalSlots().slice();
		while (slots.length) {
		results.push( this.convert2AdSlot( slots.pop() ) );
		}
		return results;
		}
		 */
		/**
		 * play page slots
		 */
		/*
		public function playAllSiteSectionNonTemporalSlots() : void {
		var slots : Vector.<XAdSlot> = this.getSiteSectionNonTemporalSlots();
		for (var i : int = 0; i < slots.length; i++) {
		slots[i].play();
		}
		}
		 */
		public function setAdVolume( vol : Number) : void {
			this.proxied.setAdVolume( vol );
		}

		/*
		public function getAdVolume() : uint {
		return this.proxied.getAdVolume();
		}
		 */
		/**
		 * 
		 * 
		 * @param container
		 * @param slotRect
		 * 
		 * @see #registerVideoPlayerNonTemporalSlot
		 */
		public function registerVideoAssetSlot( container : DisplayObjectContainer = null, slotRect : Rectangle = null) : void {
			this.proxied.registerVideoAssetSlot( container , slotRect );
		}


		/**
		 * 
		 * @param id
		 * @param container			ad-container.
		 * @param slotRect			the {x,y,width,height} of ad 
		 * @param acceptCompanion	true indicate can be companionAd, otherwise not.
		 * 
		 * @see #registerVideoAssetSlot
		 */
		public function registerVideoPlayerNonTemporalSlot( id : String, container : DisplayObjectContainer = null, slotRect : Rectangle = null, acceptCompanion : Boolean = true) : void {
			this.proxied.registerVideoPlayerNonTemporalSlot( id , container , slotRect , acceptCompanion );
		}

		/**
		 * 
		 */
		public function setVideoAssetSlotRect( slotRect : Rectangle = null, videoRect : Rectangle = null) : void {
			//this.registerVideoAssetSlot( null , slotRect );
			this.proxied.setVideoAssetSlotRect( slotRect , videoRect );
			
		}

		/**
		 * scan page solts
		 * 
		 * @param timeout
		 */
		/*
		public function scanPageSlots( timeout : Number = 0) : void {
		this.proxied.scanPageSlots( timeout );
		}
		 */
		/**
		 * 
		 * @param cb the playhead-time of video-player.
		 */
		public function registerPlayheadTimeCallback( cb : Function) : void {
			this.proxied.registerPlayheadTimeCallback( cb );
		}

		/**
		 * request response from ad-server.
		 */
		public function request( timeout : uint = 0) : void {
			
			
			
			(this.proxied.request as Function).apply( this , [timeout] );
		}

		private function convert2AdSlot( slot : *) : XAdSlot {
			if (slot) {
				if (!adSlotHashMap[slot]) {
					adSlotHashMap[slot] = new XAdSlot( slot );
				}
				return (adSlotHashMap[slot] as XAdSlot);
			} else {
				return null;
			}
		}

		/**
		 * get AdManager Version.
		 */
		public function getVersion() : uint {
			return this.proxied.getVersion();
		}

		/**
		 * dispose 
		 */
		public function dispose() : void {
			this.proxied.dispose();
			//
			var pro : Object;
			for (pro in adSlotHashMap) {
				adSlotHashMap[pro].proxied = null;
				delete adSlotHashMap[pro];
			}
			proxied = null;
		}
	}
}
