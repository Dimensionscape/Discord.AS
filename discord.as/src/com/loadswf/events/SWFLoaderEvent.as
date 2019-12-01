package com.loadswf.events{
	import flash.events.Event;

	public class SWFLoaderEvent extends Event {


		public static const SWF_LOADED: String = "swfLoaded";

		public var swf: Object;

		public function SWFLoaderEvent(type: String, swf: Object, bubbles: Boolean = false, cancelable: Boolean = false) {
			super(type, bubbles, cancelable);
			this.swf = swf;
		}

		// always create a clone() method for events in case you want to redispatch them.
		public override function clone(): Event {
			return new SWFLoaderEvent(type, swf, bubbles, cancelable);
		}

	}

}