package discordAS.collection {
	import discordAS.structure.Guild;
	
	public dynamic class GuildChannelCollection extends DataCollection {

		public function GuildChannelCollection(guild:Guild ,data:Object) {
			
			
			super(guild.client);
			for each(var channel:Object in data.channels){
				add(channel.id, channel);
			}			
		}
		
		public function getChannelByID(id:String):Object{
			return this.getValueByKey(id);
		}

	}
	
}
