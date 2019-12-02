package discordAS.client.http {
	import discordAS.client.Client;
	import discordAS.event.ClientEvent;

	public class HTTP {
		private var _client: Client;
		private var _manager: HTTPManager;


		public function get manager(): HTTPManager {
			return _manager;
		}

		public function HTTP(client: Client) {
			_client = client;
			_manager = new HTTPManager(client);
			_client.addEventListener(ClientEvent.LOGIN, gatewayHandler);
		}

		private function gatewayHandler(e: ClientEvent): void {
			_manager.gatewayRequest(e.token);
		}

	}

}