package org.mvc.control {

	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;


	// import flash.system.System;
	public class UURLLoader extends URLLoader {

		private var _request : String;
		private var requestHeads : Array;


		public function UURLLoader ( request : String = null, urlRequestHeader : Array = null ) {
			super ( null );

			if (urlRequestHeader) {
				requestHeads = new Array ( new URLRequestHeader ( urlRequestHeader[0], urlRequestHeader[1] ) );
			}
			_request = request;
		}

		public function get request () : String {
			return _request;
		}

		public function set request ( value : String ) : void {
			_request = value;
		}

		public function send ( obj : Object = null ) : void {
			if (_request) {
				var request : String = _request;
				if (obj) {
					request += "?";
					var p : Array = new Array ();
					for (var i:String in obj) {
						p.push ( i + "=" + obj[i] );
					}
					request += p.join ( "&" );
				}
				try {
					var ur : URLRequest = new URLRequest ( request );
					if (requestHeads) ur.requestHeaders = requestHeads;
					load ( ur );
				} catch(e : *) {
					trace ( "error" );
				}
			}
		}
	}
}