package org.mvc.control.events {

	import flash.events.Event;
	import flash.events.EventDispatcher;


	public class UEventDispatcher extends EventDispatcher {

		static private var __instance : UEventDispatcher = null;


		static public function getInstance () : UEventDispatcher {
			if (__instance == null) {
				__instance = new UEventDispatcher ();
			}
			return __instance;
		}
	}
}