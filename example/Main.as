package {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import com.loadswf.events.SWFLoaderEvent;
	import com.loadswf.swf.SWFLoader;
	import flash.events.Event;
	import discordAS.client.Client;
	import discordAS.terminal.Console;

	public class Main extends MovieClip {
	
	public static var consoleClass:Class = Console;

		public function Main() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var console:Console = new Console(this.stage);
			console.addEventListener(Console.CONSOLE_LOADED, consoleInit);
			
		}
		
		private function consoleInit(e:Event):void{
			
		print("test");	
		}


	}

}

	
