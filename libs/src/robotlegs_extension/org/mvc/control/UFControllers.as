package org.mvc.control {

	import flash.utils.Dictionary;

	import org.mvc.control.commands.IUCommand;
	import org.mvc.control.events.UEvent;
	import org.mvc.control.events.UEventDispatcher;


	public class UFControllers {

		private var commands : Dictionary = new Dictionary ();


		public function addCommand ( eventName : String, command : Class, useWeakReference : Boolean = true ) : void {
			if (commands[eventName])
				return;
			commands[eventName] = command;
			UEventDispatcher.getInstance ().addEventListener ( eventName, executeHandler, false, 0, useWeakReference );
		}

		public function removeCommand ( eventName : String ) : void {
			if (!commands[eventName])
				return;
			UEventDispatcher.getInstance ().removeEventListener ( eventName, executeHandler );
			commands[eventName] = null;
			delete commands[eventName];
		}

		private function executeHandler ( event : UEvent ) : void {
			var commandClass : Class = commands[event.type];
			var command : IUCommand = new commandClass ();
			command.execute ( event );
		}
	}
}