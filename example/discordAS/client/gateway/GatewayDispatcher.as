package discordAS.client.gateway {
	import flash.events.EventDispatcher;
	import discordAS.client.Client;
	import flash.events.Event;
	import discordAS.event.DiscordEvent;
	import discordAS.structure.Guild;
	
	public class GatewayDispatcher extends EventDispatcher {
		private var _client:Client;
		public function GatewayDispatcher(client:Client) {
			_client = client;
		}
		
		internal function dispatchDiscordEvent(data:Object):void{
			var dispatchData:* = data;
			trace(JSON.stringify(data));
			if(data.t == "GUILD_CREATE")dispatchData = new Guild(_client, data.d);
				

			if(DiscordEvent[data.t]) _client.dispatchEvent(new DiscordEvent(DiscordEvent[data.t],dispatchData));
			else print("Unknown discord event: " + data.t);
		}

	}
	
}
