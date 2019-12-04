package discordAS.client {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;


	public class FrameCycle extends MovieClip {
		private var _client: Client;

		public function FrameCycle(client:Client) {
			_client = client;
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		public function loop(e: Event): void {
			this.dispatchEvent(new Event("ENTER_FRAME"));
			_client.manager._heartbeat.rest();	
		}

	}

}