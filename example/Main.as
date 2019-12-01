package {
	import flash.trace.Trace;
	import flash.display.MovieClip;


	public class Main extends MovieClip {


		public function Main() {
			trace("test");

		}

		public static function test(args:Object):void{
			trace("test");
		}



	}
	
}

function trace(args: Object): void {
		Main.test(args);
	}