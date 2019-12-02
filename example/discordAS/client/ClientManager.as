package discordAS.client {
	import discordAS.client.gateway.Gateway;
	import discordAS.client.http.HTTPManager;

	public class ClientManager {
		private var _client: Client;
		private var _gateway: Gateway;
		private var _httpManager: HTTPManager;


		public function ClientManager(client: Client) {
			_client = client;
			_gateway = new Gateway(_client);
			_gateway.addEventListener(Gateway.CONNECTED, setConnect);

		}
		internal function clientAuth(token: String): void {
			//httpManager.gatewayRequest(token);
			_client.token = token;
			//	httpManager.addEventListener("GATEWAY_REPLY", _gateway.gatewayManager.webSocketConnect);
		}
		private function setConnect(): void {
			_client._connected = false;
		}

	}

}