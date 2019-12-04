package discordAS.client {
	import discordAS.client.gateway.Gateway;
	import discordAS.client.http.HTTPManager;
	import discordAS.client.http.HTTP;
	import discordAS.client.gateway.Heartbeat;

	public class ClientManager {
		private var _client: Client;
		internal var _gateway: Gateway;
		internal var _http:HTTP;
		internal var _heartbeat:Heartbeat;
		internal var _frameCycle:FrameCycle;
		
		public function get gateway():Gateway{
			return _gateway;
		}
		
		public function ClientManager(client: Client) {
			_client = client;
			_http = new HTTP(_client);
			_gateway = new Gateway(_client, _http);
			_gateway.addEventListener(Gateway.CONNECTED, setConnect);
			
			_heartbeat = new Heartbeat(_client);
			_frameCycle = new FrameCycle(_client);

			

		}

		private function setConnect(bool:Boolean): void {
			_client._connected = bool;
		}
		
	}

}