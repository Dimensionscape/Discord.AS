package discordAS.client {
	import discordAS.client.gateway.Gateway;
	import discordAS.client.http.HTTPManager;
	import discordAS.client.http.HTTP;

	public class ClientManager {
		private var _client: Client;
		private var _gateway: Gateway;
		internal var _http:HTTP;
		
		public function ClientManager(client: Client) {
			_client = client;
			_gateway = new Gateway(_client);
			_gateway.addEventListener(Gateway.CONNECTED, setConnect);

			_http = new HTTP(_client);

		}

		private function setConnect(): void {
			_client._connected = false;
		}

	}

}