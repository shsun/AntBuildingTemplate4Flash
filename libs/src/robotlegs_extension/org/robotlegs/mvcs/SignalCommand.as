package org.robotlegs.mvcs
{

	import org.robotlegs.core.ISignalCommandMap;
	import org.robotlegs.mvcs.Command;


    public class SignalCommand extends Command
    {
        [Inject]
        public var signalCommandMap:ISignalCommandMap;
    }
}