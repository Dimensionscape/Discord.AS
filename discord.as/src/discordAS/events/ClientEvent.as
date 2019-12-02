package discordAS.event{
	import flash.events.Event;

	public class ClientEvent extends Event {


		public static const LOGIN: String = "login";

		private var _token: Object;

		public function loginEvent(type: String, token: Object, bubbles: Boolean = false, cancelable: Boolean = false) {
			super(type, bubbles, cancelable);
			this._token = token;
		}

		// always create a clone() method for events in case you want to redispatch them.
		public override function clone(): Event {
			return new loginEvent(type, _token, bubbles, cancelable);
		}

	}

}