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
		private var _loader: Loader;
		private var _bytes: ByteArray;


		public function SWFLoader(bytesClass: Class) {
			_bytes = new bytesClass();
		}

		public function load(): void {
			var context: LoaderContext = new LoaderContext(false,
				ApplicationDomain.currentDomain);
			context.allowCodeImport = true;
			_loader = new Loader();
			_loader.loadBytes(_bytes, context);
			_loader.addEventListener(Event.ADDED, returnSWF);
		}



		private function returnSWF(e: Event): void {
			_loader.removeEventListener(Event.ADDED, returnSWF);
			dispatchEvent(new SWFLoaderEvent(SWFLoaderEvent.SWF_LOADED, _loader.content));
		}
	}

}