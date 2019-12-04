package discordAS.client.gateway {
	import discordAS.client.Client;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import discordAS.event.WebSocketEvent;
	import discordAS.client.http.HTTP;


	public class Gateway extends EventDispatcher {
		private var _client: Client;
		internal var _http: HTTP;
		private var _manager: GatewayManager;
		private var _switchBoard: Array = [messageDispatcher, null, null, null, null, null, null, null, null, errorHandler, hello, heartbeatAck];
		private var _heartbeatInterval: int;

		public static const CONNECTED: String = "connected";

		public function get manager(): GatewayManager {
			return _manager;
		}
		
		public function get heartbeatInterval():int{
			return _heartbeatInterval;
		}

		public function Gateway(client: Client, http: HTTP) {
			_client = client;
			_http = http;
			_manager = new GatewayManager(_client);
		}

		internal function opDispatcher(e: WebSocketEvent): void {	
			_switchBoard[e.opCode](e.data);
		}

		private function messageDispatcher(data: Object): void {
		print(JSON.stringify(data));

		}

		private function errorHandler(): void {
			print("ERROR");
		}

		private function hello(data: Object): void {
			this.dispatchEvent(new Event(CONNECTED));
			_heartbeatInterval = data.heartbeat_interval;
			handshake();
		}

		private function handshake(): void {
			print("Initiating Discord Handshake");
			var message: Object = {
				"op": 2,
				"d": {
					"token": _client.token,
					"properties": {
						"$os": _client.operatingSystem,
						"$browser": _client.runtime,
						"$device": "Discord.AS",
						"$referrer": "",
						"$referring_domain": ""
					},
					"compress": false,
					"large_threshold": 250,
					"shard": [0, _http.manager.shards]
				}
			}
			manager._webSocket.send(message);
		}
		
	


	private function heartbeatAck(data:Object = null): void {
		//print("heartbeat");
	}

}

}