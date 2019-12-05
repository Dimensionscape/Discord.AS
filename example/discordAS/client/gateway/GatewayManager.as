package discordAS.client.gateway {
	import discordAS.client.Client;
	import discordAS.client.http.HTTP;
	import flash.events.Event;
	import discordAS.event.ClientEvent;
	import discordAS.client.ws.WebSocket;
	import discordAS.event.WebSocketEvent;


	public class GatewayManager {
		private var _client: Client;
		internal var _webSocket:WebSocket;
		internal var _gatewayDispatcher:GatewayDispatcher;
		

		public function GatewayManager(client: Client) {
			_client = client;
			_client.addEventListener(ClientEvent.LOGIN, onLogin);
			_gatewayDispatcher = new GatewayDispatcher(_client);
		}

		private function onLogin(e: ClientEvent): void {
			_client.removeEventListener(ClientEvent.LOGIN, onLogin);
			_client.manager.gateway._http.manager.addEventListener("GATEWAY_REPLY", webSocketInit);
		}

		private function webSocketInit(event: Event) {
			_webSocket = new WebSocket(_client.manager.gateway._http.manager.wssAddress);
			_webSocket.addEventListener(WebSocketEvent.NEW_MESSAGE, _client.manager.gateway.opDispatcher);
		}

	}

}