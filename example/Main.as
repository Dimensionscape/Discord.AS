﻿package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import discordAS.client.Client;
	import discordAS.event.DiscordEvent;
	import discordAS.structure.Guild;

	public class Main extends MovieClip {
		private var _client:Client;	

		public function Main() {
		_client = new Client(this.stage);
		_client.addEventListener(Client.INIT, init);
		}

		private function init(e: Event): void {
			print("Hello Bot");
			_client.login("<YOUR-TOKEN-HERE>");
			_client.addEventListener(DiscordEvent.MESSAGE_CREATE, messageCreate);
		}
		
		private function messageCreate(e:DiscordEvent):void{
			var message:Object = e.data.d;
			if(message.content == "!Hello"){
				_client.send("World", message.channel_id);
			}
		}
		
	
	}
}

	
