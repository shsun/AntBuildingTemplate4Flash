package org.mvc.control.commands {

	import org.mvc.control.events.UEvent;


	public interface IUCommand {

		function execute ( event : UEvent ) : void;
	}
}