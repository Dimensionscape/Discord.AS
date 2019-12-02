﻿package discordAS.client.gateway {
	import discordAS.client.Client;
	import flash.events.EventDispatcher;
	import flash.events.Event;


	public class Gateway extends EventDispatcher {
		private var _client:Client;
		private var _gatewayManager:GatewayManager;
		public static const CONNECTED:String = "connected";
		
		public function get gatewayManager():GatewayManager{
			return _gatewayManager;
		}
		public function Gateway(client:Client) {
			_client = client;
			_gatewayManager = new GatewayManager(_client);
		}

		public function opDelivery(data: Object, dataType: String) {
			if (dataType == "utf8") {

			} else
			if (dataType == "binary") {
				print("Can't process binary packets yet!");
			}
			switch (data.op) {
				case 0:
					//_client.manager.gatewayDispatcher.eventDispatcher(data);
					break;
				case 1:
					//
					break;
				case 2:
					//
					break;
				case 3:
					//
					break;
				case 4:
					//
					break;
				case 5:
					//
					break;
				case 6:
					//
					break;
				case 7:
					//
					break;
				case 8:
					//
					break;
				case 9:
					print("ERROR: Invalid Session, Please Try Again.");
					break;
				case 10:
					hello(data);
					break;
				case 11:
					heartbeatAck();
					break;
			}
		}
		public function hello(data): void {
			this.dispatchEvent(new Event(CONNECTED));
			//_client.heartbeatInterval = data.d.heartbeat_interval;
			//_client.gatewayDispatcher.handshake();
		}
		public function heartbeatAck(): void {
			print("heartbeat");
		}

	}

}