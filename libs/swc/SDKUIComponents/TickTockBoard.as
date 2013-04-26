package {

	import flash.display.*;
	import flash.text.*;

	/**
	 * @author shsun
	 */
	public class TickTockBoard extends MovieClip {
		/**
		 * 
		 */
		public function TickTockBoard( ) {
		}

		public function set remainTime( time : String) : void {
			this.textField.text = this.buildTip( '' + time );
			this.formatText();
		}

		private function buildTip( t : String) : String {
			return '广告还剩余 ' + t + ' 秒';
		}

		private function formatText() : void {
			var format : TextFormat = new TextFormat();
			this.textField.setTextFormat( format );
		}
		
		public function dispose() : void {
			if (this.textField) {
				this.removeChild( this.textField );
				this.textField = null;
			}
		}
	}
}
