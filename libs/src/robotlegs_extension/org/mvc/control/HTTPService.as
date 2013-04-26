package org.mvc.control {

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	import org.mvc.control.commands.IUResponder;

	import flash.events.SecurityErrorEvent;


	public class HTTPService {

		private var responders : Dictionary = new Dictionary ();


		public function getService ( url : String, responder : IUResponder, urlRequestHeader : Array = null ) : UURLLoader {
			var loader : UURLLoader = new UURLLoader ( url, urlRequestHeader );
			loader.addEventListener ( Event.COMPLETE, complete );
			loader.addEventListener ( IOErrorEvent.IO_ERROR, error );
			loader.addEventListener ( SecurityErrorEvent.SECURITY_ERROR, securityHandler );
			responders[loader] = responder;

			return loader;
		}

		private function complete ( event : Event ) : void {
			var loader : URLLoader = event.target as URLLoader;
			responders[loader].result ( loader.data );
		}

		private function error ( event : IOErrorEvent ) : void {
			responders[event.target].fault ( event );
		}

		private function securityHandler ( event : SecurityErrorEvent ) : void {
			responders[event.target].fault ( event );
		}
	}
}