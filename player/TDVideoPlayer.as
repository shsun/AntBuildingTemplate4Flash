package {

	import com.youdo.ad.vo.XPlayerProfile4SDK;
	import flash.system.Capabilities;
	import flash.events.FullScreenEvent;
	import fl.video.VideoState;
	import fl.video.VideoScaleMode;

	import flash.geom.Rectangle;

	import fl.video.FLVPlayback;

	import flash.system.Security;

	import com.youdo.ad.events.XAdManagerEvent;
	import com.youdo.ad.core.XAdSlotType;
	import com.youdo.ad.core.XAdSlot;
	import com.youdo.ad.core.XAdManager;
	import com.youdo.ad.loader.XAdManagerLoader;

	import flash.events.Event;
	import flash.display.*;
	import flash.external.ExternalInterface;

	import fl.video.VideoEvent;

	/**
	 * @author shsun
	 */
	public class TDVideoPlayer extends Sprite {
		static public var playerProfile : XPlayerProfile4SDK;		
		private var theXAdManagerLoader : XAdManagerLoader;
		private var theXAdManager : XAdManager;
		//
		static public const NAME : String = 'TuDou_Homer';		
		static public const VERSION : String = 'TuDou-Player V-1.4.6';
		//
		static private const VIDEO_URL : String = "video.flv";
		private var playback : FLVPlayback;
		private var playbackIndex : int;
		
		//[SWF(width=800, height=340, frameRate=25, backgroundColor=0x000000)]
		[SWF(width=1000, height=497, frameRate=25, backgroundColor=0x000000)]
		public function TDVideoPlayer() {
			Security.allowDomain( '*' );  
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// 
			playerProfile = new XPlayerProfile4SDK();
			playerProfile.sourceId = '81000';
			
			//
			this.addEventListener( Event.ADDED_TO_STAGE , this.handleAdded2Stage );
		}

		private function handleAdded2Stage( event : Event) : void {
			this.removeEventListener( Event.ADDED_TO_STAGE , this.handleAdded2Stage );
			
			this.stage.addEventListener(FullScreenEvent.FULL_SCREEN, this.handleFullScreen);
			
			// 
			this.drawbackground(1000, 497);
			// XAdManagerLoader used to load AdManager.swf
			this.theXAdManagerLoader = new XAdManagerLoader();
			this.theXAdManagerLoader.loadAdManager( this.handleXAdManagerLoad , this , './AdManager.swf' , Math.random() );
			
			// 
			this.playback = new FLVPlayback();
			this.playback.addEventListener( fl.video.VideoEvent.STATE_CHANGE , this.handleVideoPlayerStateChanged );
			this.playback.skin = 'SkinUnderAllNoCaption.swf';
			this.playback.autoPlay = true;
			this.playback.volume = 0;
			//this.playback.fullScreenTakeOver = false;
			this.playback.width = 596;
			this.playback.height = 460;
			this.playback.x = (this.stage.stageWidth - this.playback.width)/2;
			this.playback.y = 0;
			this.playback.scaleMode = VideoScaleMode.EXACT_FIT;
			this.playback.alpha = 0.5;
			this.addChild( this.playback );
			this.playbackIndex = this.getChildIndex(this.playback);
		}
		private function handleFullScreen(event : FullScreenEvent) : void {
			//this.playback.visible = false;
			
			ExternalInterface.call('console.log', 'handleFullScreen  '+this.stage.displayState+"  playback.w="+this.playback.width+', playback.h='+this.playback.height);
			
			if (this.theXAdManager) {
				if ( this.stage.displayState == StageDisplayState.FULL_SCREEN ) {					
					this.drawbackground(Capabilities.screenResolutionX, Capabilities.screenResolutionY);
					this.theXAdManager.setVideoAssetSlotRect(new Rectangle(0, 0, Capabilities.screenResolutionX, Capabilities.screenResolutionY));
				} else {
					// this.theXAdManager.setVideoAssetSlotRect(new Rectangle(this.playback.x, this.playback.y, this.playback.width, this.playback.height));
					this.theXAdManager.setVideoAssetSlotRect(new Rectangle(this.playback.x, this.playback.y, 596, 460));
				}
			}
		}
		private function setFullscreenMode() : void {
			//this.stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		private function resizeAd(x:Number, y:Number, w:Number, h:Number) : void {
			ExternalInterface.call('eval', 'alert("'+'resizeAd('+arguments+')")');
			
		}	
		private function handleXAdManagerLoad( success : Boolean) : void {
			ExternalInterface.call('console.log', 'handleXAdManagerLoad .resize '+this.width+', '+this.height);
			
			if (success) {
				// create XAdManager for ad-requesting if load success.
				this.createXAdManagerAndRequestAd();
			} else {
				// play video if load failed
				this.playMainVideo();
			}
		}

		private function createXAdManagerAndRequestAd() : void {
			//
			if ( this.theXAdManager ) {
				this.theXAdManager.dispose();
				this.theXAdManager = null;
			}
			// 
			this.theXAdManager = this.theXAdManagerLoader.newAdManager(this);
			this.theXAdManager.addEventListener( XAdManagerEvent.REQUEST_COMPLETED , this.handleXAdManagerEvent );
			this.theXAdManager.addEventListener( XAdManagerEvent.SLOT_STARTED , this.handleXAdManagerEvent );
			this.theXAdManager.addEventListener( XAdManagerEvent.SLOT_ENDED , this.handleXAdManagerEvent );
			var p : Object = {playerName:VERSION, juid:this.root.loaderInfo.parameters.juid, rnd:this.root.loaderInfo.parameters.rnd, tpa:this.root.loaderInfo.parameters.tpa};
			// this.theXAdManager.setAdRequestParameters( p );
			this.theXAdManager.registerPlayheadTimeCallback( this.getPlayheadTime );
			this.theXAdManager.registerVideoAssetSlot( null , new Rectangle( this.playback.x , this.playback.y , this.playback.width , this.playback.height ) );
			//this.theXAdManager.setVideoAssetSlotRect( new Rectangle( this.playback.x , this.playback.y , this.playback.width , this.playback.height ) );
			this.theXAdManager.setAdVolume( 0 );
			this.theXAdManager.playerProfile = playerProfile;
			this.theXAdManager.setPlayerName(NAME);
			this.theXAdManager.setPlayerVersion(VERSION);
			this.theXAdManager.setServer( "./r.xml" );
			//this.theXAdManager.setServer( this.loaderInfo.parameters.response );
			
			// submit request
			this.theXAdManager.request( 1000 * 1 );
		}

		private function handleXAdManagerEvent( event : XAdManagerEvent) : void {
			ExternalInterface.call('console.log', 'handleXAdManagerEvent .resize '+this.width+', '+this.height);
			switch(event.type) {
				case XAdManagerEvent.REQUEST_COMPLETED :
					if (event.success) {
						var slot : XAdSlot = this.theXAdManager.getPreroll();
						this.log( "handleXAdManagerEvent slot" + slot );
						if (slot) {
							slot.play();
						} else {
							this.playMainVideo();
						}
					} else {
						this.playMainVideo();
					}
					break;
				case XAdManagerEvent.SLOT_STARTED :
					this.log( "handleXAdManagerEvent SLOT_STARTED type="+event.slot.getType().type );
					if (event.slot.getType() == XAdSlotType.MIDROLL || event.slot.getType() == XAdSlotType.PAUSEROLL) {
						this.pauseMainVideo();
					}
					break;
				case XAdManagerEvent.SLOT_ENDED :
					this.log( "handleXAdManagerEvent SLOT_ENDED type="+event.slot.getType().type );
					if (event.slot.getType() == XAdSlotType.PREOLL || event.slot.getType() == XAdSlotType.MIDROLL) {
						this.playMainVideo();
					} else if (event.slot.getType() == XAdSlotType.POSTROLL) {
						/*
						if (this.theXAdManagerLoader.isLoaded) {
							this.createXAdManagerAndRequestAd();
						}
						*/
					}
					break;
				default :
					this.log( "handleXAdManagerEvent( ) default  fuck" );
					break;
			}
		}

		private function getPlayheadTime() : Number {
			return this.playback.playheadTime ? this.playback.playheadTime : 0;
		}

		public function playMainVideo() : void {
			this.log( "playMainVideo" );
			
			if (this.playback.paused)
				this.playback.play();
			else
				this.playback.play(VIDEO_URL);
		}

		private function handleVideoPlayerStateChanged( event : fl.video.VideoEvent) : void {
			if (this.theXAdManager && this.theXAdManager.isRequestSuccess) {
				var slot : XAdSlot;
								
				this.log('TDVideoPlayer.handleVideoPlayerStateChanged(' + event + ')'+ ",  event.state=" + event.state);
				if (event.state == fl.video.VideoState.PAUSED) {
					slot = this.theXAdManager.getPauseroll();
					if (slot && slot.getType() == XAdSlotType.PAUSEROLL) {
						slot.play();
					}
				} else if (event.state == fl.video.VideoState.PLAYING) {
					if (slot && slot.getType() == XAdSlotType.PAUSEROLL) {
						slot.stop();
					}
				}

				//
				if (event.state == fl.video.VideoState.STOPPED) {
					slot = this.theXAdManager.getPostroll();
					slot.play();
				}
			}
		}

		public function pauseMainVideo() : void {
			this.playback.pause();
		}

		private function drawbackground(w:Number, h:Number):void {
			this.graphics.clear();
			this.graphics.beginFill( 0x000000 , 1 );
			this.graphics.drawRect( 0 , 0 , w , h );
			//this.graphics.drawRect( 0 , 0 , 1000 , 497 );
			this.graphics.endFill();
		}

		private function log( msg : *) : void {
			trace('P --> ' + msg);
			ExternalInterface.call( 'console.log' , 'P --> ' + msg );
		}
	}
}
// ----------------------------------------------------------------------------------
import flash.display.DisplayObjectContainer;
import flash.display.DisplayObject;
internal class PlayerUtils {
		public static function bringToBottom( mc : DisplayObject) : DisplayObject {
			var parent : DisplayObjectContainer = mc.parent;
			if (parent == null) {
				return mc;
			}
			if (parent.getChildIndex( mc ) != 0) {
				parent.setChildIndex( mc , 0 );
			}
			return mc;
		}
}