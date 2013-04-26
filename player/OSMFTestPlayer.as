// **************************************************************************************
//
//
// 			                      ______
// 			                   .-"      "-.
// 			                  /    SSH     \
// 			                 |              |
// 			                 |,  .-.  .-.  ,|
// 			                 | )(__/  \__)( |
// 			                 |/     /\     \|
// 			       (@_       (_     ^^     _)
// 			  _     ) \_______\__|IIIIII|__/__________________________
// 			 (_)@8@8{}<________|-\IIIIII/-|___________________________>
// 			        )_/        \          /
// 			       (@           `--------`                    
//
// 
// **************************************************************************************
package {

	import flash.external.ExternalInterface;
	import com.devnet.osmf.events.MediaEvent;
	import com.youdo.ad.core.XAdSlotType;
	import com.youdo.ad.core.XAdSlot;
	import flash.geom.Rectangle;
	import com.youdo.ad.events.XAdManagerEvent;
	import com.youdo.ad.loader.XAdManagerLoader;
	import com.youdo.ad.core.XAdManager;
	import com.youdo.ad.vo.XPlayerProfile4SDK;

	import flash.events.Event;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.system.Security;
	import flash.display.Sprite;

	/**
	 * @author shsun
	 */
	public class OSMFTestPlayer extends Sprite {
		static public var playerProfile : XPlayerProfile4SDK;
		private var theXAdManagerLoader : XAdManagerLoader;
		private var theXAdManager : XAdManager;
		//
		static public const NAME : String = 'TuDou_Homer';
		static public const VERSION : String = 'TuDou-Player V-1.4.6';
		//
		static private const VIDEO_URL : String = "video.flv";
		//
		private var controlBar :ControlBar;


		//
		[SWF(width=1000, height=497, frameRate=25, backgroundColor=0x000000)]
		public function OSMFTestPlayer() {
			// TODO

			Security.allowDomain('*');
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			//
			this.addEventListener(Event.ADDED_TO_STAGE, this.handleAdded2Stage);
		}

		private function handleAdded2Stage(event : Event) : void {
			this.removeEventListener(Event.ADDED_TO_STAGE, this.handleAdded2Stage);
			//
			this.drawbackground(1000, 497);
			
			//
			this.theXAdManagerLoader = new XAdManagerLoader();
			this.theXAdManagerLoader.loadAdManager( this.handleXAdManagerLoad , this , './AdManager.swf' , Math.random() );
			
			// ====================================================================================
			//OSMF Player
			var mediaDispaly:MediaDisplay = new MediaDisplay();
			this.addChild(mediaDispaly);
			//
			this.controlBar = new ControlBar();
			this.addChild(this.controlBar);			
			//
			//
			this.controlBar.width = mediaDispaly.width = 596;
			this.controlBar.height = 460;
			mediaDispaly.height = 460 - (453.50-428);
			this.controlBar.x = mediaDispaly.x = (this.stage.stageWidth - this.controlBar.width)/2;			
			this.controlBar.y = mediaDispaly.y = 0;
			//
			//
			this.controlBar.mediaPlayer = mediaDispaly;
			this.controlBar.mediaPlayer.addEventListener(MediaEvent.PLAYHEAD_UPDATE, this.handlePlayheadUpdate);
			this.controlBar.mediaPlayer.addEventListener(MediaEvent.STATE_CHANGE, this.handleStateChange);
			this.controlBar.mediaPlayer.scaleMode = 'stretch';//none,letterbox,stretch,zoom
			this.controlBar.mediaPlayer.source = VIDEO_URL;
			this.controlBar.mediaPlayer.autoPlay = false;
		}
		private function handlePlayheadUpdate(event : MediaEvent) : void {
		}
		private function handleStateChange(event : MediaEvent) : void {
			this.log('handleStateChange. state='+event.state);
		}
		
		private function handleXAdManagerLoad( success : Boolean) : void {
			if (success) {
				this.createXAdManagerAndRequestAd();
			} else {  
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
			this.theXAdManager.registerVideoAssetSlot( null , new Rectangle( this.controlBar.mediaPlayer.x , this.controlBar.mediaPlayer.y , this.controlBar.mediaPlayer.width , this.controlBar.mediaPlayer.height ) );
			//this.theXAdManager.setVideoAssetSlotRect( new Rectangle( this.playback.x , this.playback.y , this.playback.width , this.playback.height ) );
			this.theXAdManager.setAdVolume( 0 );
			this.theXAdManager.playerProfile = playerProfile;
			this.theXAdManager.setPlayerName(NAME);
			this.theXAdManager.setPlayerVersion(VERSION);
			//this.theXAdManager.setServer( "./r.xml" );
			//this.theXAdManager.setServer( "./only-1-placard.xml" );
			//this.theXAdManager.setServer( "./1-placard-2-video.xml" );
			//this.theXAdManager.setServer( "./1-cpt-1-cpm-1videoad-1-bgad.xml" );
			//(this.loaderInfo.parameters.response != null) "./preroll-companion-as.xml"?
			this.theXAdManager.setServer( this.loaderInfo.parameters.response );
			// submit request
			this.theXAdManager.request( 1000 * 1 );
		}
		
		private function handleXAdManagerEvent( event : XAdManagerEvent) : void {
			switch(event.type) {
				case XAdManagerEvent.REQUEST_COMPLETED :
					if (event.success) {
						var slot : XAdSlot = this.theXAdManager.getPreroll();
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
					if (event.slot.getType() == XAdSlotType.MIDROLL || event.slot.getType() == XAdSlotType.PAUSEROLL) {
						this.pauseMainVideo();
					}
					break;
				case XAdManagerEvent.SLOT_ENDED :
					if (event.slot.getType() == XAdSlotType.PREOLL || event.slot.getType() == XAdSlotType.MIDROLL) {
						this.playMainVideo();
					} else if (event.slot.getType() == XAdSlotType.POSTROLL) {
					}
					break;
				default :
					break;
			}
		}
		
		public function playMainVideo() : void {
			if (this.controlBar.mediaPlayer.paused) {
				this.controlBar.mediaPlayer.play();
			} else {
				this.controlBar.mediaPlayer.source = VIDEO_URL;
			}
		}

		private function handleVideoPlayerStateChanged( event : Event) : void {
			/*
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
			*/
		}

		public function pauseMainVideo() : void {
			this.controlBar.mediaPlayer.pause();
		}
		
		private function drawbackground(w:Number, h:Number):void {
			this.graphics.clear();
			this.graphics.beginFill( 0x000000 , 0.5 );
			this.graphics.drawRect( 0 , 0 , w , h );
			//this.graphics.drawRect( 0 , 0 , 1000 , 497 );
			this.graphics.endFill();
		}
		private function log(msg : *) : void {
			trace('P --> ' + msg);
			ExternalInterface.call('console.log', 'P --> ' + msg);
		}				
	}
}
