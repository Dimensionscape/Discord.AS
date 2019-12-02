package discordAS.event{
	import flash.events.Event;

	public class ClientEvent extends Event {

		public static const LOGIN: String = "login";

		public var token: String;

		public function ClientEvent(type: String, token: String, bubbles: Boolean = false, cancelable: Boolean = false) {
			super(type, bubbles, cancelable);
			this.token = token;
		}

		public override function clone(): Event {
			return new ClientEvent(type, token, bubbles, cancelable);
		}

	}

}