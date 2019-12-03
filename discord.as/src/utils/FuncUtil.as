package utils {
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class FuncUtil {

		public static function delayedCall(func: Function, params: Array, delay: int = 350, repeat: int = 1): void {
			var f: Function;
			var timer: Timer = new Timer(delay, repeat);
			timer.addEventListener(TimerEvent.TIMER, f = function (): void {
				func.apply(null, params);
				if (timer.currentCount == repeat) {
					timer.removeEventListener(TimerEvent.TIMER, f);
					timer = null;
				}
			});
			timer.start();
		}
	}

}

