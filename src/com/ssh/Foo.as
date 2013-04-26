
package com.ssh {
	
	import com.ssh.b.FooB;

	/**
	 * @author Administrator
	 */
	public class Foo extends Object {

		public function Foo() {
		}

		/**
		 * Add Operation
		 * @param a 		
		 * @param b 	
		 * @return the result of adding
		 * @example	below is the e.g
		 * <listing version='1.0'>
		 * var f:Foo = new Foo();
		 * var r:Number = f.add(1, 5);
		 * trace(r);	// output is 6
		 * </listing>
		 * @see #devide()
		 * @see FooA#devide()
		 * @see com.ssh.b.FooB#devide()
		 * @throws Error
		 */
		public function add(a : Number, b : Number) : Number {
			return a + b;
		}

		public function devide(a : Number, b : Number) : Number {
			return a / b;
		}
	}
}
