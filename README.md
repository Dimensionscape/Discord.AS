# Discord.AS
Discord Bot API for Adobe AIR and AS3

Usage case as included in example:

```actionscript3
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import discordAS.client.Client;
	import discordAS.event.DiscordEvent;

	public class Main extends MovieClip {
		private var _client:Client;	

		public function Main() {
		_client = new Client(this.stage);
		_client.addEventListener(Client.INIT, init);
		}

		private function init(e: Event): void {
			print("Hello Bot");
			_client.login("<YOUR-SECRET-TOKEN-HERE>");
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

```
