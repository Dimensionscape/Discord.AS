package discordAS.event{
	import flash.events.Event;

	public class DiscordEvent extends Event {

		public static const IDENTIFY: String = "identify";
		public static const RESUME: String = "resume";
		public static const HEARTBEAT: String = "heartbeat";
		public static const REQUEST_GUILD_MEMBERS: String = "requestGuildMembers";
		public static const UPDATE_VOICE_STATE: String = "updateVoiceState";
		public static const UPDATE_STATUS: String = "updateStatus";
		public static const HELLO: String = "hello";
		public static const READY: String = "ready";
		public static const RESUMED: String = "resumed";
		public static const CHANNEL_CREATE: String = "channelCreate";
		public static const CHANNEL_UPDATE: String = "channelUpdate";
		public static const CHANNEL_DELETE: String = "channelDelete";
		public static const CHANNEL_PINS_UPDATE: String = "channelPinsUpdate";
		public static const GUILD_CREATE: String = "guildCreate";
		public static const GUILD_UPDATE: String = "guildUpdate";
		public static const GUILD_DELETE: String = "guildDelete";
		public static const GUILD_BAN_ADD: String = "guildBanAdd";
		public static const GUILD_BAN_REMOVE: String = "guildBanRemove";
		public static const GUILD_EMOJIS_UPDATE: String = "guildEmojisUpdate";
		public static const GUILD_INTEGRATIONS_UPDATE: String = "guildIntegrationsUpdate";
		public static const GUILD_MEMBER_ADD: String = "guildMemberAdd";
		public static const GUILD_MEMBER_REMOVE: String = "guildMemberRemove";
		public static const GUILD_MEMBER_UPDATE: String = "guildMemberUpdate";
		public static const GUILD_MEMBERS_CHUNK: String = "guildMembersChunk";
		public static const GUILD_ROLE_CREATE: String = "guildRoleCreate";
		public static const GUILD_ROLE_UPDATE: String = "guildRoleUpdate";
		public static const GUILD_ROLE_DELETE: String = "guildRoleDelete";
		public static const MESSAGE_CREATE: String = "messageCreate";
		public static const MESSAGE_UPDATE: String = "messageUpdate";
		public static const MESSAGE_DELETE: String = "messageDelete";
		public static const MESSAGE_DELETE_BULK: String = "messageDeleteBulk";
		public static const MESSAGE_REACTION_ADD: String = "messageReactionAdd";
		public static const MESSAGE_REACTION_REMOVE: String = "messageReactionRemove";
		public static const MESSAGE_REACTION_REMOVE_ALL: String = "messageReactionRemoveAll";
		public static const PRESENCE_UPDATE: String = "presenceUpdate";
		public static const PRESENCE_REPLACE:String = "presenceReplace";
		public static const CLIENT_STATUS_OBJECT: String = "clientStatusObject";
		public static const ACTIVITY_OBJECT: String = "activityObject";
		public static const TYPING_START: String = "typingStart";
		public static const USER_UPDATE: String = "userUpdate";
		public static const VOICE_STATE_UPDATE: String = "voiceStateUpdate";
		public static const VOICE_SERVER_UPDATE: String = "voiceServerUpdate";
		public static const WEBHOOKS_UPDATE: String = "webHooksUpdate";

		public var data: Object;

		public function DiscordEvent(type: String, data: Object , bubbles: Boolean = false, cancelable: Boolean = false) {
			super(type, bubbles, cancelable);
			this.data = data;
		}
		public override function clone(): Event {
			return new DiscordEvent(type, data, bubbles, cancelable);
		}

	}

}