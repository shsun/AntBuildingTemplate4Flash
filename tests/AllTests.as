package {
	import com.ssh.FooTest;
	import com.ssh.FooATest;
	import com.ssh.b.FooBTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AllTests {
		public var fooTest : FooTest;
		public var fooATest : FooATest;
		public var fooBTest : FooBTest;
	}
}