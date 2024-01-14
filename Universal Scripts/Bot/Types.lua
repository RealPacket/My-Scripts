-- NOTE: please update this file every time you make an API change (e.x. rename something or change it in a way)

type Events = {
	--- Gets fired once the bot gets unloaded
	OnDestroy: SignalInstance,
	--- Fired when the bot is Loaded
	OnLoad: SignalInstance,
	[string]: SignalInstance,
}

type Betabot = {
	--- Some utilities that you'll probably use some time
	Utils: Utils,
	API: APIs,
	Commands: commands,
	Logs: logs,
	Config: config,
	Events: Events,
	Loaded: boolean,
	--- A table containing connections.
	Connections: { [string]: Connection },
}

type config = {
	--- A set of readonly message formats that you can set.
	MessageFormats: { [string]: string },
	debug: boolean,
	debugFn: (...any) -> (),
	prefix: string,
	whitelistEnabled: boolean,
}

type autoConvertSettingsOption = {
	--- A list of types that shouldn't be automatically converted.
	disabledTypes: { "number" | "string" | "boolean" }?,
	--- A list of types that should be converted (e.x. Player (it's not enabled by default))
	enabledTypes: { "Player" },
}

type commandOptions = {
	autoConvert: boolean?,
	autoConvertSettings: autoConvertSettingsOption,
	extraRawArgsParam: boolean?,
}?

type command = {
	--- An optional description of what the command does.
	description: string?,
	--- Some options that you can toggle on and off.
	options: commandOptions,
	callback: (
		---player that ran the command
		user: Player,
		---arguments (only strings if options.autoConvert is false)
		args: { string | number | boolean },
		---only if options.extraRawArgsParam is set to true
		rawArgs: { string }?
	) -> (),
}

type commands = { [string]: command }

type ChatLog = {
	Author: Player,
	Message: string,
	Recipient: Player,
	timeStamp: DateTime,
}

type ConsoleLogs = {
	Errors: { string },
	Warnings: { string },
	Logs: { string },
}

type GameLogs = {
	Chat: { ChatLog },
}

type CommandLog = {
	args: {},
	command: command,
	time: DateTime,
}

type BotLogs = {
	Commands: { CommandLog },
}

type logs = {
	Console: ConsoleLogs,
	Game: GameLogs,
	Bot: BotLogs,
}

type GithubAPI = {
	---Fetches content from the specified path
	---@example Commands/DefaultCommands.lua
	Request: (path: string) -> string,
}

type APIs = {
	--- An API which allows you to create certain permissions and revoke/grant it from/to players.
	PermissionsAPI: PermissionsAPI,
	--- An API which allows you to create new commands.
	CommandAPI: CommandAPI,
	--- An API which allows you to interact with the bot's github folder
	GithubAPI: GithubAPI,
}

type CommandAPI = {
	CreateCommand: (name: string, cmd: command) -> command,
}

type Permission = {
	--- Gets fired once the permission gets granted to a player.
	OnGrantedToPlayer: SignalInstance,
	--- Gets fired once the permission gets revoked from a player.
	OnRevokedFromPlayer: SignalInstance,
	--[=[
		Grants this permission to a player, fires the OnGrantedToPlayer event.
	]=]
	GrantToPlayer: (self: Permission, target: Player) -> Player,
	--[=[
		Revokes this permission from a player, fires the OnRevokedFromPlayer event.
	]=]
	RevokeFromPlayer: (self: Permission, target: Player) -> (),
	--[=[
		Returns true if the player specified has been granted this permission.
	]=]
	IsGrantedToPlayer: (self: Permission, player: Player) -> boolean,
}

type PermissionsAPI = {
	--- Gets fired once a permission is added.
	PermissionAdded: SignalInstance,
	--- Gets fired once a permission is about to be removed.
	PermissionRemoving: SignalInstance,
	--- Gets a permission with the specified
	--- If a permission doesn't exist, an error gets thrown.
	GetPermission: (self: PermissionsAPI, name: string) -> Permission,
	--- Creates/Adds a permission with the specified
	--- If the permission specified was
	-- created before this call of CreatePermission,
	--- A warning will be emitted.
	CreatePermission: (self: PermissionsAPI, name: string) -> Permission,
	--- A list of permissions
	Permissions: { [string]: Permission },
}

--[=[
   An object that represents a connection that is connected to a signal.
--]=]
type Connection = {
	connected: boolean,
	target: SignalInstance,
	--- Disconnects the connection from the remote event that it was connected to.
	Disconnect: (self: Connection) -> (),
}

--[=[
	An instance of the Signal class.
]=]
type SignalInstance = {
	--- Connects to this signal and returns the connection object representing this connection.
	Connect: (self: SignalInstance, callback: (...any) -> ()) -> Connection,
	--- Fires all connections connected to this signal instance.
	Fire: (self: SignalInstance, ...any) -> (),
	--[=[
        Creates a connection
	    that immediately calls the callback
	    and disconnects from the signal as soon as the connection is triggered,
	    only allowing the callback to be executed once.
	    Returns the connection object representing the connection.
    ]=]
	Once: (self: SignalInstance, callback: (...any) -> ()) -> Connection,
	--- Yields the current thread until the signal is fired, and returns the arguments that were fired.
	Wait: (self: SignalInstance) -> ...any,
	--- Disconnects all connections connected to the current signal.
	Destroy: (self: SignalInstance) -> (),
}

--[==[
	A class that provides a way for user-defined functions, called listeners,
	to call when something happens in the game.
	When an event happens, the Signal fires and calls any listeners that are connected to it.
	An Signal may also pass arguments to each listener to provide extra information about the event.
	@class
]==]
type SignalUtil = {
	new: (name: string?) -> SignalInstance,
	constructor: (self: SignalInstance, name: string?) -> (),
}

--[==[
	Some utilities that you can use in your command scripts.
]==]
type Utils = {
	GetPlayerByName: (name: string, caseInsensitive: boolean?, requestingPlayer: Player?) -> Player?,
	Chat: (message: string, broadcast: boolean, target: Player) -> TextChatMessage?,
	Signal: SignalUtil,
}

-- [[  End Typings.  ]] --
