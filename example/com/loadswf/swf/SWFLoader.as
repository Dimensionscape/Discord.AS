package com.loadswf.swf {
	import flash.system.LoaderContext;
	import flash.display.Loader;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import flash.events.EventDispatcher;
	import com.loadswf.events.SWFLoaderEvent;

	public class SWFLoader extends EventDispatcher {
		private var loader: Loader;
		private var swfObj: Object;
		private var filePath: String;
		private var compressed: Boolean;


		public function SWFLoader(filePath: String) {
			this.filePath = filePath;
		}

		public function load(): void {
			var file: File = new File(this.filePath);
			var fileStream: FileStream = new FileStream();
			fileStream.addEventListener(Event.COMPLETE, swfLoaded);
			fileStream.openAsync(file, FileMode.READ);
		}

		private function swfLoaded(e: Event): void {
			e.currentTarget.removeEventListener(Event.COMPLETE, swfLoaded);

			var swf: ByteArray = new ByteArray()
			FileStream(e.currentTarget).readBytes(swf);

			var context: LoaderContext = new LoaderContext(false);
			context.allowCodeImport = true;
			loader = new Loader();



			loader.addEventListener(Event.ADDED, returnSWF);
			loader.loadBytes(swf, context);
			e.currentTarget.close();
		}

		private function returnSWF(e: Event): void {
			loader.removeEventListener(Event.ADDED, returnSWF);
			dispatchEvent(new SWFLoaderEvent(SWFLoaderEvent.SWF_LOADED, loader.content));
		}
	}

}