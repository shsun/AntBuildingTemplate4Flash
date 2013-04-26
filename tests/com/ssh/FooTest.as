
package com.ssh {

	import org.flexunit.asserts.assertEquals;

	import com.ssh.Foo;

	public class FooTest {

		public var classRef : Foo;


		[Before]
		public function setUp() : void {
			this.classRef = new Foo();
		}

		[After]
		public function tearDown() : void {
			this.classRef = null;
		}

		[Test]
		public function testAdd() : void {
			var r : Number = this.classRef.add( 1, 4 );
			assertEquals( "FooTest result should be 5", r, 5 );
		}


		
		[Test]
		public function testAdd2() : void {
			var r : Number = this.classRef.add( 1, 4 );
			assertEquals( "FooTest result should be 5", r, 5 );
		}


		
		[Test]
		public function testAdd3() : void {
			var r : Number = this.classRef.add( 1, 4 );
			assertEquals( "FooTest result should be 5", r, 5 );
		}
	}
}