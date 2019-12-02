# Discord.AS
Discord Bot API for Adobe AIR and AS3
Usage case as included in example:

```actionscript3
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import discordAS.client.Client;

	public class Main extends MovieClip {
		private var _client:Client;	

		public function Main() {
		_client = new Client(this.stage);
		_client.addEventListener(Client.INIT, init);
		}

		private function init(e: Event): void {
			print("Hello World");			
		}
	}
}
```
