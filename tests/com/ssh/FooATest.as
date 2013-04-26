
package com.ssh {

	import org.flexunit.asserts.assertEquals;

	import com.ssh.FooA;

	public class FooATest {

		public var classRef : FooA;


		[Before]
		public function setUp() : void {
			this.classRef = new FooA();
		}

		[After]
		public function tearDown() : void {
			this.classRef = null;
		}

		[Test]
		public function testAdd() : void {
			var r : Number = this.classRef.add( 1, 4 );
			assertEquals( "FooATest result should be 5", r, 5 );
		}


		
		[Test]
		public function testAdd2() : void {
			var r : Number = this.classRef.add( 1, 4 );
			assertEquals( "FooATest result should be 5", r, 5 );
		}


		
		[Test]
		public function testAdd3() : void {
			var r : Number = this.classRef.add( 1, 4 );
			assertEquals( "FooATest result should be 5", r, 5 );
		}
	}
}