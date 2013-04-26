package org.mvc.control.events {

	import flash.events.Event;


	public class UEvent extends Event {

		private var _data : Object;


		public function UEvent ( eventName : String, data : Object = null ) {
			super ( eventName, false, false );
			_data = data;
		}

		public function set data ( data : Object ) : void {
			_data = data;
		}

		public function get data () : Object {
			return _data;
		}

		override public function clone () : Event {
			return new UEvent ( this.type, _data );
		}
	}
}