
package com.ssh.b {

	import org.flexunit.asserts.assertEquals;

	import com.ssh.b.FooB;

	public class FooBTest {

		public var classRef : FooB;


		[Before]
		public function setUp() : void {
			this.classRef = new FooB();
		}

		[After]
		public function tearDown() : void {
			this.classRef = null;
		}

		[Test]
		public function testAdd() : void {
			var r : Number = this.classRef.add( 1, 4 );
			assertEquals( "FooBTest result should be 5", r, 3 );
		}


		
		[Test]
		public function testAdd2() : void {
			var r : Number = this.classRef.add( 1, 4 );
			assertEquals( "FooBTest result should be 5", r, 5 );
		}


		
		[Test]
		public function testAdd3() : void {
			var r : Number = this.classRef.add( 1, 4 );
			assertEquals( "FooBTest result should be 5", r, 5 );
		}
	}
}