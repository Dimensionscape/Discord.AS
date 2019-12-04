package discordAS.event{
	import flash.events.Event;

	public class WebSocketEvent extends Event {

		public static const NEW_MESSAGE:String = "newMessage";
		
		public var data: Object;
		public var opCode:int;

		public function WebSocketEvent(type: String, data: Object, opCode:int, bubbles: Boolean = false, cancelable: Boolean = false) {
			super(type, bubbles, cancelable);
			this.data = data;
			this.opCode = opCode;
		}

		public override function clone(): Event {
			return new WebSocketEvent(type, data, opCode, bubbles, cancelable);
		}

	}

}