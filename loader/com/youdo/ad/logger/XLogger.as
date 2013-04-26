package com.youdo.ad.logger {
	import flash.external.ExternalInterface;
	/**
	 * @author shsun
	 */
	public class XLogger {
		
		static public function log(msg:*):void {
			trace('X --> '+msg);
			ExternalInterface.call('console.log', 'X --> '+msg);
		}
		
	}
}
