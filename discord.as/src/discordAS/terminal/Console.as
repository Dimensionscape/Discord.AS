package discordAS.terminal {

	public class Console {
		[Embed(source = "/discordAS/terminal/Console.swf", mimeType = "application/octet-stream")]
		protected static const Terminal: Class;
		public static var console;

		private var _stage: Stage;

		public function Console(stage: Stage) {
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
			trace("Hello World");
		}

	}

}