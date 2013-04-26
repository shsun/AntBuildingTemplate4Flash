package com.youdo.ad.loader {

	import flash.display.Stage;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.describeType;

	import com.youdo.ad.logger.XLogger;
	import com.youdo.ad.core.XAdManager;

	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;

	/**
	 * @author shsun
	 */
	public class XAdManagerLoader extends MovieClip {
		private static const DEFAULT_AD_MANAGER_URL : String = "http://v2.tudou.com/flashsdk/AdManager.swf";
		//
		//
		private var _amFactory : Object;
		//
		//
		// Security.LOCAL_WITH_FILE,Security.LOCAL_WITH_NETWORK, Security.LOCAL_TRUSTED
		private var _isLocalLoadMode : Boolean;
		//
		private var _container : DisplayObjectContainer;
		//
		private var _loader : Loader;
		private var _isLoaded : Boolean = false;
		//
		private var _callback : Function;

		//
		/**
		 * 
		 */
		public function XAdManagerLoader() {
			Security.allowDomain( '*' );

			this._isLocalLoadMode = false;
			this._isLoaded = false;
		}

		/**
		 * load AdManager.swf
		 * 
		 * @param callback		will be fired with a boolean parameter when load complete
		 * @param url			url of AdManager.swf
		 * @param cacheBuster	cache buster.
		 * @example
		 * <listing version="3.0">
		 * var theXAdManagerLoader:XAdManagerLoader = new XAdManagerLoader();
		 * // output is false
		 * trace(theXAdManagerLoader.isLoaded);
		 * theXAdManagerLoader.loadAdManager( handleXAdManagerLoad , this.stage, 'http://127.0.0.1/a/AdManager.swf?' , Math.random() );
		 * 
		 * function handleXAdManagerLoad( success : Boolean) : void {
		 * 		if (success) {
		 * 			// output is true
		 * 			trace(theXAdManagerLoader.isLoaded);
		 * 			
		 * 			// create XAdManager for ad-requesting if load success.
		 * 			var theXAdManager:XAdManager = theXAdManagerLoader.newAdManager();
		 * 		} else {
		 * 			// output is false
		 * 			trace(theXAdManagerLoader.isLoaded);
		 * 			
		 * 			// play video if load failed
		 * 			// TODO
		 * 		}
		 * }
		 * </listing>
		 */
		public function loadAdManager( callback : Function, container : DisplayObjectContainer = null, url : String = null, cacheBuster : Number = 1) : void {
			//
			this._callback = callback;
			this._container = container;
			//
			url = url == null ? DEFAULT_AD_MANAGER_URL : url;
			if (Security.sandboxType == Security.REMOTE) {
				url += '?';
			}

			if (URLUtil.isHTTP( url )) {
				Security.allowDomain( URLUtil.getDomain( url ) );
			}
			if (Security.sandboxType == Security.REMOTE) {
				if (!isNaN( cacheBuster )) {
					url = url + ("cb=" + cacheBuster);
				}
			} else {
				this._isLocalLoadMode = true;
			}
			trace( "XAdManagerLoader.loadAdManager() url=" + url );
			//
			this._loader = new Loader();
			this._loader.contentLoaderInfo.addEventListener( Event.COMPLETE , this.handleLoadCompleted );
			this._loader.contentLoaderInfo.addEventListener( Event.INIT , this.handleLoadInit );
			this._loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR , this.handleIOError );
			this._loader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR , this.handleSecurityError );
			//
			var ctx : LoaderContext = new LoaderContext();
			ctx.applicationDomain = new ApplicationDomain( ApplicationDomain.currentDomain );
			// ctx.applicationDomain = ApplicationDomain.currentDomain;
			XLogger.log( "Security.sandboxType=" + Security.sandboxType );
			switch(Security.sandboxType) {
				case Security.LOCAL_TRUSTED:
				case Security.LOCAL_WITH_FILE:
				case Security.LOCAL_WITH_NETWORK:
					this._loader.load( new URLRequest( url ) , ctx );
					break;
				case Security.REMOTE:
					ctx.securityDomain = SecurityDomain.currentDomain;
					this._loader.load( new URLRequest( url ) , ctx );
				default:
					break;
			}
		}

		/**
		 * new XAdManager
		 * 
		 * @return XAdManager
		 */
		public function newAdManager(view : DisplayObjectContainer) : com.youdo.ad.core.XAdManager {
			var wrapper : XAdManager = null;
			var proxied : * = null;
			if (this._amFactory) {
				proxied = this._amFactory.getNewInstance(1, view);
				wrapper = new com.youdo.ad.core.XAdManager(proxied);
			}
			return wrapper;
		}

		public function get isLoaded() : Boolean {
			return this._isLoaded;
		}

		/*
		public function getVersion() : uint {
		return 1;
		}
		*/
		private function handleLoadInit( event : Event) : void {
		}

		private function handleLoadCompleted( event : Event) : void {
			// 
			this._amFactory = ( event.target.content as MovieClip);
			if (this._container) {
				(this._amFactory as DisplayObject).addEventListener( Event.ADDED_TO_STAGE , this.handleAdded2Stage );
				this._container.addChild( this._amFactory as DisplayObject );
			} else {
				this.handleAdded2Stage( null );
			}
			
			// dispose loader.
			this._loader.contentLoaderInfo.removeEventListener( Event.COMPLETE , this.handleLoadCompleted );
			this._loader.contentLoaderInfo.removeEventListener( Event.INIT , this.handleLoadInit );
			this._loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR , this.handleIOError );
			this._loader.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , this.handleSecurityError );
			this._loader = null;
		}

		private function handleAdded2Stage( event : Event) : void {
			this._isLoaded = true;
			this._callback( this._isLoaded );
		}

		private function handleIOError( event : IOErrorEvent) : void {
			this._isLoaded = false;
			this._callback( this._isLoaded );
		}

		private function handleSecurityError( event : SecurityErrorEvent) : void {
			this._isLoaded = false;
			this._callback( this._isLoaded );
		}
	}
}

internal class URLUtil {
	public static function isHTTP( url : String) : Boolean {
		if (url == null) {
			return false;
		}
		//
		return url.toLocaleLowerCase().indexOf( "http:" ) == 0;
	}

	public static function getDomain( url : String) : String {
		if (url == null) {
			return null;
		}

		var tmpURL : String = url;
		if (tmpURL.lastIndexOf( "/" ) > 8) {
			tmpURL = tmpURL.substr( 0 , tmpURL.indexOf( "/" , 8 ) );
			if (tmpURL.indexOf( "/" ) > -1) {
				tmpURL = tmpURL.substr( (tmpURL.lastIndexOf( "/" ) + 1) );
			}
		}
		return tmpURL;
	}
}