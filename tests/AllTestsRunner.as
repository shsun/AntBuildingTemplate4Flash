package {
	import org.flexunit.listeners.TextListener;
	import org.flexunit.listeners.FlexCoverListener;

	import flexunit.framework.TestListener;
	import flexunit.flexui.FlexUnitTestRunnerUIAS;
	import flexunit.flexui.FlexUnitTestRunnerUI;

	import org.flexunit.listeners.UIListener;
	import org.flexunit.flexui.TestRunnerBase;
	import org.flexunit.internals.TraceListener;
	import org.flexunit.listeners.CIListener;
	import org.flexunit.runner.FlexUnitCore;

	import flash.display.Sprite;

	[SWF(backgroundColor="#0000FF", frameRate="31", width="640", height="480")]
	public class AllTestsRunner extends Sprite {
		private var core : FlexUnitCore;

		public function AllTestsRunner() {
			var base : TextListener = new TextListener();
			this.addChild(base);

			core = new FlexUnitCore();
			core.addListener(new CIListener());
			// core.addListener(new FlexCoverListener());
			// core.addListener( new TraceListener() );
			core.addListener(new UIListener(base));
			core.run(AllTests);

			this.graphics.clear();
			this.graphics.beginFill(0x000000, 0.5);
			this.graphics.drawRect(0, 0, 800, 600);
		}
	}
}