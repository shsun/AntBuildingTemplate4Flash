package org.mvc.control.commands {
	public interface IUResponder {

		function result ( data : Object ) : void;

		function fault ( info : Object ) : void;
	}
}