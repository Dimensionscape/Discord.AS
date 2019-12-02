package discordAS.client {
	import discordAS.terminal.Console;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class Client extends EventDispatcher{
		private var _console: Console;
		public static const INIT:String = "init";

		public function Client(stage: Stage) {
			_console = new Console(stage);
			_console.addEventListener(Console.CONSOLE_LOADED, consoleInit);

		}
		private function consoleInit(e:Event):void{
			_console.removeEventListener(Console.CONSOLE_LOADED, consoleInit);	
			this.dispatchEvent(new Event(INIT));
			
		}

	}

}