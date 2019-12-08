package discordAS.client {
	import discordAS.terminal.Console;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	import discordAS.event.ClientEvent;
	import flash.utils.Dictionary;
	import discordAS.util.Snowflake;
	import discordAS.collection.GuildCollection;
	import discordAS.event.DiscordEvent;

	public class Client extends EventDispatcher {
		public static const INIT: String = "init";
		private var _console: Console;
		private var _token: String;
		internal var _connected: Boolean;
		private var _authenticated: Boolean;
		private var _bot: Boolean;
		private var _operatingSystem: String;
		private var _runtime: String;
		private var _verified: Boolean;
		private var _channels: Dictionary;
		private var _guilds: GuildCollection;
		private var _manager: ClientManager;

		public function get manager(): ClientManager {
			return _manager;
		}

		public function get token(): String {
			return _token;
		}
		public function get operatingSystem(): String {
			return _operatingSystem;
		}
		public function get runtime(): String {
			return _runtime;
		}
		public function get connected(): Boolean {
			return _connected;
		}
		public function get guilds():GuildCollection{
			return _guilds;
		}

		public function Client(stage: Stage) {
			_manager = new ClientManager(this);
			_connected = false;
			_authenticated = false;
			_operatingSystem = Capabilities.os;
			_runtime = Capabilities.manufacturer;
			_console = new Console(stage);
			_console.addEventListener(Console.CONSOLE_LOADED, consoleInit);
			_guilds = new GuildCollection(this);
			addEventListener(DiscordEvent.GUILD_CREATE, addGuild);
		}
		private function addGuild(e:DiscordEvent):void{
			_guilds.add(e.data.id.string, e.data)
		}
		public function send(content:String, id:String, type:String = "channel"){
			_manager._http.manager.sendMessageToChannel(content, id);
		}
		private function consoleInit(e: Event): void {
			_console.removeEventListener(Console.CONSOLE_LOADED, consoleInit);
			this.dispatchEvent(new Event(INIT));
		}

		public function login(token: String): void {
			this._token = token;
			this.dispatchEvent(new ClientEvent(ClientEvent.LOGIN, token));

		}

		public function on(reference: String, onFunction: Function): void {
			//	_manager.gateway.addEventListener(reference.toUpperCase(), onFunction);

		}

	}

}