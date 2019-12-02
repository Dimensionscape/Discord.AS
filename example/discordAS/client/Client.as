package discordAS.client {
	import discordAS.terminal.Console;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class Client extends EventDispatcher{
		public static const INIT:String = "init";
		private var _console: Console;
		private var _token:String;
		private var _connected:Boolean;
		private var _authenticated:Boolean;
		private var _heartbeatInterval: int;
		private var _bot: Boolean;
		private var _runtime: String;
		private var _username: String;
		private var _discriminator: String;
		private var _email: String;
		private var _verified: Boolean;
		private var _guild:String;
		private var _channel:String;

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