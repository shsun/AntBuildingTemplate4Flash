package {
	import flash.display.*;
	import flash.events.*;

	public class AdVolumeController extends MovieClip {

		//static public const ON:String = 'turn on ad-sound';
		//static public const OFF:String = 'turn off ad-sound';

		public function AdVolumeController() {
			this.openButton.addEventListener(MouseEvent.CLICK, this.handleOpenButtonClick);
			this.closeButton.addEventListener(MouseEvent.CLICK, this.handleCloseButtonClick);
			this.displayOpenSoundButton(false);
		}
		
		public function set isOnMode(b:Boolean):void {
			this.displayOpenSoundButton(!b);
		}
		
		public function get isOnMode():Boolean {
			return this.closeButton.visible;
		}

		private function handleOpenButtonClick(event:MouseEvent):void {
			this.displayOpenSoundButton(false);
			//this.dispatchEvent(new Event(AdVolumeController.ON));
			this.dispatchEvent(event.clone());
		}

		private function handleCloseButtonClick(event:MouseEvent):void {
			this.displayOpenSoundButton(true);
			//this.dispatchEvent(new Event(AdVolumeController.OFF));
			this.dispatchEvent(event.clone());
		}

		private function displayOpenSoundButton(b:Boolean):void {
			this.openButton.visible = b;
			this.closeButton.visible = !b;
		}

		public function dispose():void {
			this.openButton.removeEventListener(MouseEvent.CLICK, this.handleOpenButtonClick);
			this.closeButton.removeEventListener(MouseEvent.CLICK, this.handleCloseButtonClick);
		}
	}
}