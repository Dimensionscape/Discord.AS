package console {

	import flash.display.MovieClip;
	import flash.text.TextField;
	import fl.controls.UIScrollBar;
	import flash.events.Event;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class UI extends MovieClip {

		private var _console: TextField;
		private var _scrollBar: UIScrollBar;
		private var _traceLogs: Boolean = false;

		public function UI() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			_console = new TextField();
			_console.selectable = true;
			_console.multiline = true;
			_console.wordWrap = true;
			_console.border = true;
			_console.background = true;
			_console.backgroundColor = 0x000000;
			_console.textColor = 0xFFFFFF;
			_console.name = "console";
			_console.type = "input";
			_console.x = 0;
			_console.y = 0;
			_console.width = stage.stageWidth;
			_console.height = stage.stageHeight;
			_console.addEventListener(Event.CHANGE, update);
			stage.addChild(_console);

			_scrollBar = new UIScrollBar();
			_scrollBar.x = _console.width - 14;
			_scrollBar.y = 0;
			_scrollBar.height = _console.height;
			_scrollBar.scrollTarget = _console;
			_scrollBar.visible = false;
			stage.nativeWindow.addEventListener(Event.RESIZE, resize);
			stage.addChild(_scrollBar);
			
		}

		public function log(...args): void {
			_console.appendText(args.toString() + "\n");
			update();
			if(_traceLogs) trace(args);
		}

		private function update(e: Event = null): void {
			if (_console.maxScrollV > 1) {
				_scrollBar.visible = true;
			} else {
				_scrollBar.visible = false;
			}
		}

		private function resize(e: Event): void {
			_console.width = stage.stageWidth;
			_console.height = stage.stageHeight;
			_scrollBar.height = _console.height;
			_scrollBar.x = _console.width - 14;

		}


	}

}