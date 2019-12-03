package discordAS.client {
	import discordAS.terminal.Console;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	import discordAS.event.ClientEvent;

	public class Client extends EventDispatcher {
		public static const INIT: String = "init";
		private var _console: Console;
		private var _token: String;
		internal var _connected: Boolean;
		private var _authenticated: Boolean;
		private var _heartbeatInterval: int;
		private var _bot: Boolean;
		private var _operatingSystem: String;
		private var _runtime: String;
		private var _discriminator: String;
		private var _verified: Boolean;
		private var _guild: String;
		private var _channel: String;
		private var _manager:ClientManager;
		
		public function get manager():ClientManager {
			return _manager;
		}
		
		public function get token():String{
			return _token;
		}
		public function set token(token:String):void{
			_token = token;
		}
		public function get connected():Boolean{
			return _connected;
		}

		public function Client(stage: Stage) {
			_manager = new ClientManager(this);
			_connected = false;
			_authenticated = false;
			_operatingSystem = Capabilities.os;
			_runtime = Capabilities.manufacturer;
			_console = new Console(stage);
			_console.addEventListener(Console.CONSOLE_LOADED, consoleInit);
			
		}
		private function consoleInit(e: Event): void {
			_console.removeEventListener(Console.CONSOLE_LOADED, consoleInit);
			this.dispatchEvent(new Event(INIT));

		}

		public function login(token: String): void {
			this.token = token;
			this.dispatchEvent(new ClientEvent(ClientEvent.LOGIN, token));

		}
		
		public function on(reference: String, onFunction: Function): void {
		//	_manager.gateway.addEventListener(reference.toUpperCase(), onFunction);

		}

	}

}