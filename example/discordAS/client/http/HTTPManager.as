package discordAS.client.http {
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLRequestHeader;
	import flash.net.URLVariables;
	import flash.events.EventDispatcher;
	import discordAS.client.Client;

	public class HTTPManager extends EventDispatcher {
		private var _client: Client
		private var _wssAddress: String;
		private var _shards:int;
		
		public function get shards():int{
			return _shards;
		}
		public function get wssAddress():String{
			return _wssAddress;
		}
		public function HTTPManager(client: Client) {
			_client = client;
		}

		internal function gatewayRequest(token: String) {
			var httpLoader = new URLLoader;
			var httpRequest: URLRequest = new URLRequest();
			var header: URLRequestHeader;
			httpRequest.method = "GET";
			if (token !== null) {
				header = new URLRequestHeader("Authorization", "Bot" + " " + token);
				httpRequest.requestHeaders.push(header);
				httpRequest.url = "https://discordapp.com/api/gateway/bot";
				//.client.bot = true;;
			} else {
				header = new URLRequestHeader("Authorization", "Bot" + " " + token);
				httpRequest.requestHeaders.push(header);
				httpRequest.url = "https://discordapp.com/api/gateway";
				//.client.bot = false;
			}

			httpLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			httpLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, httpResponseStatusHandler);
			httpLoader.addEventListener(Event.COMPLETE, gatewayReply);

			httpLoader.load(httpRequest)

		}


		private function httpStatusHandler(event: HTTPStatusEvent): void {

			print("httpStatusHandler: " + event);
			print("status: " + event.status);

		}


		private function httpResponseStatusHandler(event: HTTPStatusEvent): void {

			print("httpResponseStatusHandler: " + event);
			print("status: " + event.status);

			for each(var object: Object in event.responseHeaders) {
				print(object.name + " : " + object.value);
			}

		}

		private function gatewayReply(event: Event): void {
			print("Incoming Gateway Response");
			_wssAddress = JSON.parse(event.target.data).url;
			_shards = JSON.parse(event.target.data).shards;
			if (_wssAddress == null) {
				print("ERROR: Connection failed. Try Again.");
			} else {
				this.dispatchEvent(new Event("GATEWAY_REPLY"));
			}

		}


	}

}