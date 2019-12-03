package discordAS.client.gateway {
	import discordAS.client.Client;
	import discordAS.client.http.HTTP;
	import flash.events.Event;
	import discordAS.event.ClientEvent;
	import discordAS.client.ws.WebSocket;


	public class GatewayManager {
		private var _client: Client;
		private var _webSocket:WebSocket;
		

		public function GatewayManager(client: Client) {
			_client = client;
			_client.addEventListener(ClientEvent.LOGIN, onLogin);
		}

		private function onLogin(e: ClientEvent): void {
			_client.removeEventListener(ClientEvent.LOGIN, onLogin);
			_client.manager.gateway._http.manager.addEventListener("GATEWAY_REPLY", webSocketInit);
		}

		private function webSocketInit(event: Event) {
			_webSocket = new WebSocket(_client.manager.gateway._http.manager.wssAddress);
		}

	}

}