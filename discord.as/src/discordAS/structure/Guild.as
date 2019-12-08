package discordAS.structure {
	import discordAS.collection.GuildMemberCollection;

	import discordAS.collection.RoleCollection;
	import discordAS.collection.PresenceCollection;
	import discordAS.collection.VoiceStateCollection;
	import discordAS.util.Snowflake;
	import discordAS.client.Client;
	import discordAS.collection.GuildChannelCollection;

	public class Guild {
		private var _members: GuildMemberCollection;
		private var _channels: GuildChannelCollection;
		private var _roles: RoleCollection;
		private var _presences: PresenceCollection;
		private var _voiceStates: VoiceStateCollection;
		private var _deleted: Boolean;
		private var _available: Boolean;
		private var _id: Snowflake;
		private var _shardID: Number
		private var _name: String;
		private var _icon: String;
		private var _splash: String;
		private var _region: String;
		private var _memberCount: Number;
		private var _large: Boolean;
		private var _features: Array;
		private var _applicationID: Snowflake;
		private var _afkTimeout: Number;
		private var _afkChannelID: Snowflake;
		private var _systemChannelID: Snowflake;
		private var _embedEnabled: Boolean;
		private var _premiumTier: Number;
		private var _premiumSubscriptionCount: Number;
		private var _widgetEnabled: Boolean;
		private var _widgetChannelID: String;
		private var _embedChannelID: String;
		private var _verificationLevel: Number;
		private var _explicitContentFilter: Number;
		private var _mfaLevel: Number;
		private var _joinedTimestamp: Number;
		private var _defaultMessageNotifications: Number;
		private var _maximumMembers: Number;
		private var _maximumPresenses: Number;
		private var _vanityURLCode: String;
		private var _description: String;
		private var _banner: String;

		private var _client: Client
		
		public function get client():Client{
			return _client;
		}
		public function get id():Snowflake{
			return _id;
		}

		public function get channels():GuildChannelCollection {
			return _channels;
		}

		public function Guild(client: Client, data: Object) {
			_client = client;
			_channels = new GuildChannelCollection(this, data);
			_id = new Snowflake(data.id);
			
		}

	}

}