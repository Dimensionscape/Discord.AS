package discordAS.collection {
	import discordAS.client.Client;
	import discordAS.util.Snowflake;
	import discordAS.structure.Guild;

	public dynamic class GuildCollection extends DataCollection {

		public function GuildCollection(client:Client) {
			super(client);
			
		}
		
		public function getGuildByID(id:String):Guild{
			return this.getValueByKey(id);
		}
	}

}