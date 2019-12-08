package discordAS.collection {
	import discordAS.client.Client;
	import flash.utils.Dictionary;

	public dynamic
	class DataCollection extends Dictionary {

		protected var _client: Client;

		public function DataCollection(client: Client) {
			_client = client;
			super();

		}

		public function add(key: String, value: Object): void {
			this[key] = value;
		}

		public function getValueByKey(key: * ): * {
			var value: * = -1;
			if (this[key]) value = this[key];
			return value;

		}

		public function getValueByName(valueName: String): * {
			var value: * = -1;
			for each(var _value: * in this) {
				if (_value.name === valueName) {
					value = _value;
					return value;
				}
			}
			return value;
		}

	}

}