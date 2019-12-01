package discordAS.terminal {
	import flash.display.Stage;
	import com.loadswf.events.SWFLoaderEvent;
	import com.loadswf.swf.SWFLoader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Console extends EventDispatcher{
		[Embed(source = "/discordAS/terminal/Console.swf", mimeType = "application/octet-stream")]
		protected static const Terminal: Class;
		public static var console;
		public static const CONSOLE_LOADED:String = "consoleLoaded";

		private var _stage: Stage;

		public function Console(stage: Stage) {
			_stage = stage;
			var swfLoader: SWFLoader = new SWFLoader(Terminal);
			swfLoader.addEventListener(SWFLoaderEvent.SWF_LOADED, consoleLoaded);
			swfLoader.load();
		}

		private function consoleLoaded(e: SWFLoaderEvent): void {
			console = e.swf
			_stage.addChild(console);
			console.addEventListener(Event.ADDED_TO_STAGE, init);

		}

		private function init(e: Event): void {
			console.removeEventListener(Event.ADDED_TO_STAGE, init);
			this.dispatchEvent(new Event(CONSOLE_LOADED));
		}

	}

}
