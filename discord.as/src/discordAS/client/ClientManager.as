package discordAS.client {
	import discordAS.client.gateway.Gateway;
	import discordAS.client.http.HTTPManager;
	import discordAS.client.http.HTTP;

	public class ClientManager {
		private var _client: Client;
		internal var _gateway: Gateway;
		internal var _http:HTTP;
		
		public function get gateway():Gateway{
			return _gateway;
		}
		
		public function ClientManager(client: Client) {
			_client = client;
			_http = new HTTP(_client);
			_gateway = new Gateway(_client, _http);
			_gateway.addEventListener(Gateway.CONNECTED, setConnect);

			

		}

		private function setConnect(): void {
			_client._connected = false;
		}
		
	}

}