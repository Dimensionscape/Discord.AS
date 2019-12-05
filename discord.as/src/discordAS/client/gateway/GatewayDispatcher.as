package discordAS.client.gateway {
	import flash.events.EventDispatcher;
	import discordAS.client.Client;
	import flash.events.Event;
	import discordAS.event.DiscordEvent;
	
	public class GatewayDispatcher extends EventDispatcher {
		private var _client:Client;
		public function GatewayDispatcher(client:Client) {
			_client = client;
		}
		
		internal function dispatchDiscordEvent(data:Object):void{
			print(data.t);
			if(DiscordEvent[data.t]) _client.dispatchEvent(new DiscordEvent(DiscordEvent[data.t],data));
			else print("Unknown discord event" + data.t);
		}

	}
	
}
