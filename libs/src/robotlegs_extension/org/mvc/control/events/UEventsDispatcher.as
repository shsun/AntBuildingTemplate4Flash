package org.mvc.control.events {

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;


	public class UEventsDispatcher extends EventDispatcher {

		public function UEventsDispatcher ( target : IEventDispatcher = null ) {
			super ( target );
		}

		public function dispatchForView ( event : UEvent ) : Boolean {
			return dispatchEvent ( event );
		}

		public function dispatchForCommand ( event : UEvent ) : Boolean {
			return UEventDispatcher.getInstance ().dispatchEvent ( event );
		}

		public function dispatchForAll ( event : UEvent ) : void {
			dispatchEvent ( event.clone () );
			UEventDispatcher.getInstance ().dispatchEvent ( event );
		}
	}
}