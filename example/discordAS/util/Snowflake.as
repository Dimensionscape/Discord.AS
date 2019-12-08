package discordAS.util {

	public class Snowflake {

		protected var _snowflake: String;
		public function Snowflake(snowflake: String): void {
			_snowflake = snowflake;
		}
		public function get string(): String {
			return _snowflake;
		}



	}

}