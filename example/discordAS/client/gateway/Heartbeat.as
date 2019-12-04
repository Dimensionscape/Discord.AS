package discordAS.client.gateway {
	import discordAS.client.Client;

	public class Heartbeat {

		private var _client:Client;
		public var date: Number
		public var timeBuffer: Number
		public var timeCache: Number
		public var time: Number

		public function Heartbeat(client:Client) {
			_client = client;
			timeBuffer = 0;
			timeCache = 0;
			time = 0;
		}

		public function rest(): void {
			if (_client.connected == true) {
				date = new Date().getTime();
				timeBuffer = (date - time)
				time = date;
				if (timeCache < _client.manager.gateway.heartbeatInterval) {
					timeCache += timeBuffer;
				} else {
					pulse();
					timeCache = 0;
				}
			}
		}
		public function pulse(): void {
			var message: Object = {
				"op": 1,
				"d": date
			}
			_client.manager.gateway.manager._webSocket.send(message);

		}
	}

}