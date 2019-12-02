package {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import com.loadswf.events.SWFLoaderEvent;
	import com.loadswf.swf.SWFLoader;
	import flash.events.Event;
	import discordAS.client.Client;
	import discordAS.terminal.Console;

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

	
