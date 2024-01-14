--!strict

-- [[  Services and variables  ]] --

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local ChatVersion = TextChatService.ChatVersion
local isLegacy = ChatVersion == Enum.ChatVersion.LegacyChatService
local runFn = task.spawn
if getgenv().__destroy_bot then
	getgenv().__destroy_bot(true)
	task.wait()
end

-- [[  Typings. (only exported stuff)  ]] --

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
	disabledTypes: { "number" | "string" | "boolean" },
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
	--- Formats a string like "{PREFIX}cmds" (which called with ">" as the prefix will result in ">cmds")
	Format: () -> (),
	--- Logs a message into the console if config.debug is set to true
	Log: (...any) -> (),
}

-- [[  End Typings.  ]] --

-- [[  Utils.  ]] --

-- Simple signal util, made because roblox bindable events do the monkey with tables
-- (they re-create tables when passing into the callback :skull:)

--- An object that represents a connection that is connected to a signal.
--- @class Connection
--- @field connected boolean
--- @field callback function
local Connection
do
	Connection = setmetatable({}, {
		__tostring = function()
			return "Connection"
		end,
	})
	Connection.__index = Connection
	--- Creates a new connection
	function Connection.new(...)
		local self = setmetatable({}, Connection)
		return self:constructor(...) or self
	end
	--- Constructs a connection.
	function Connection:constructor(target, callback)
		--- Boolean that determines if the connection is connected,
		-- set to false when you call disconnect.
		self.connected = true
		--- Callback that should be ran once its target gets fired
		self.callback = callback
		--- The Signal that this connection is connected to
		self.target = target
	end
	--[=[
        Sets connected to false and
	    disconnects this connection from the signal it was connected from.
    ]=]
	function Connection:Disconnect()
		self.connected = false
		local connIndex = table.find(self.target.conns, self)
		if not connIndex then
			error("Connection index seems to be invalid. (" .. tostring(connIndex) .. ")")
		end
		table.remove(self.target.conns, connIndex)
	end
end
--[==[
	provides a way for user-defined functions,
	called listeners,
	to call when something happens in the game.
	When an event happens, the Signal fires and calls any listeners that are connected to it.
	An Signal may also pass arguments to each listener to provide extra information about the event.
]==]
---@class Signal
---@field conns Connection[]
---@field name string?
local Signal: SignalUtil
do
	Signal = setmetatable({}, {
		__tostring = function()
			return "Signal"
		end,
	})
	Signal.__index = Signal
	--- Creates a new Signal instance.
	function Signal.new(...): SignalInstance
		local self = setmetatable({}, {
			__tostring = function(self: SignalInstance)
				return self.name and ("%s (Signal)"):format(self.name) or "Signal"
			end,
			__index = Signal,
		})
		return self:constructor(...) or self
	end
	--- Constructs a new Signal instance
	---@return Signal
	function Signal:constructor(name: string?)
		self.conns = {}
		if name then
			self.name = name
		end
	end
	--- Connects to this signal and returns the connection object representing this connection.
	---@param callback function
	function Signal:Connect(callback: (...any) -> ()): SignalInstance
		local conn = Connection.new(self, callback)
		table.insert(self.conns, conn)
		return conn
	end
	--- Fires all connections connected to this signal instance.
	function Signal:Fire(...)
		for _, conn in self.conns do
			conn.callback(...)
		end
	end
	--- Yields the current thread until the signal is fired, and returns the arguments that were fired.
	function Signal:Wait()
		local waitingCoroutine = coroutine.running()
		local conn
		conn = self:Connect(function(...)
			conn:Disconnect()
			task.spawn(waitingCoroutine, ...)
		end)
		return coroutine.yield()
	end
	--[==[
        Creates a connection
	    that immediately calls the callback
	    and disconnects from the signal as soon as the connection is triggered,
	    only allowing the callback to be executed once.
	    Returns the connection object representing the connection.
    ]==]
	function Signal:Once(callback: (...any) -> ())
		local conn
		conn = self:Connect(function(...)
			callback(...)
			conn:Disconnect()
		end)
		return conn
	end
	--- Disconnects all connected Connections.
	function Signal:Destroy()
		for _, conn in self.conns do
			conn:Disconnect()
		end
	end
end

-- [[  End Utils.  ]] --

-- [[  Initialize Betabot (not as a global yet), APIs, Utils, and other things. (PART 1)  ]] --

local Betabot: Betabot = {
	Loaded = false,
}

Betabot.Connections = {}

Betabot.API = {
	GithubAPI = {},
	CommandAPI = {},
	PermissionsAPI = {
		Permissions = {},
		PermissionAdded = Signal.new("Permission Added"),
		PermissionRemoving = Signal.new("Permission Removing"),
	},
}
Betabot.Events = {
	--- Gets fired once getgenv().__destroy_bot gets called
	OnDestroy = Signal.new("Destroy"),
	OnReload = Signal.new("Reload"),
	OnLoad = Signal.new("Load"),
}
Betabot.Commands = {}
Betabot.Utils = {
	Chat = function() end,
	GetPlayerByName = function() end,
	Signal = Signal,
}
Betabot.Logs = {
	-- yes
	Console = {
		Errors = {},
		Warnings = {},
		Logs = {},
	},
	Game = {
		Chat = {},
	},
	Bot = {
		Commands = {},
	},
}
Betabot.Utils.Chat = function() end
Betabot.Utils.Format = function() end

local ChatEvent: RemoteEvent?
if isLegacy then
	local ChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
	ChatEvent = ChatEvents:FindFirstChild("SayMessageRequest")
end

if not ChatEvent and isLegacy then
	warn("Chat event not found, this game may be using a custom chat system.")
end

-- Bing wrote me this,
-- it's for escaping the prefix
-- if it contains some characters that TextChatService escapes into HTML entities
-- I really hate the escaping, but this is a work-around.
---@param str string The string to escape
---@return string The escaped version of the string.
local function escapeHTML(str)
	str = str:gsub("&", "&amp;")
	str = str:gsub("<", "&lt;")
	str = str:gsub(">", "&gt;")
	str = str:gsub('"', "&quot;")
	str = str:gsub("'", "&#39;")
	return str
end

---Does the opposite of escapeHTML.
---@param str string The string to unescape
---@return string unescaped The unescaped version of the string.
local function unescapeHTML(str)
	str = str:gsub("&amp;", "&")
	str = str:gsub("&lt;", "<")
	str = str:gsub("&gt;", ">")
	str = str:gsub("&quot;", '"')
	str = str:gsub("&#39;", "'")
	return str
end

-- Some configurations you can change.
local config: config = table.freeze({
	-- show debug logs (if any)?
	debug = true,
	-- the debug function.
	debugFn = warn,
	-- The prefix every message that runs a command will start with.
	prefix = ">",
	-- determines if the whitelist is enabled.
	whitelistEnabled = false,
	-- formats for certain messages that the bot says.
	MessageFormats = {
		---The message that gets sent when the bot script is executed.
		StartMessage = "[INFO]: Started bot in {MODE} mode! "
			.. 'Prefix is "{PREFIX}", '
			.. 'Use "{PREFIX}cmds" for a list of commands!',
		---The message that gets sent when a player tries to run a command that doesn't exist.
		UnknownCommandMessage = "Unknown command " .. '"{COMMAND}"! Try using "{PREFIX}cmds" for a list of commands.',
	},
})

-- debug-logs some variables.
local function log(t: { { name: string, value: any } })
	if not config.debug then
		return
	end
	local message = ""
	for _, tab in t do
		message ..= "\n" .. tab.name .. ": " .. tostring(tab.value)
	end
	if config.debugFn then
		config.debugFn(message)
	else
		warn("[BOT] Debug - " .. message)
	end
end
local function format(str, args)
	if not str then
		error("Unable to format - no string provided.")
	end
	if type(str) ~= "string" then
		error('Unable to format - expected "string", got "' .. type(str) .. '" instead for argument #1.')
	end
	if not args then
		error("Unable to format - no argument(s) table provided")
	end
	if type(args) ~= "table" then
		error('Unable to format - expected "table", got "' .. type(args) .. '" for argument #2.')
	end
	for name, value in args do
		if not str:find("{" .. name .. "}") then
			continue
		end
		str = str:gsub("{" .. name .. "}", value)
	end
	return str
end

Betabot.Utils.Format = format

local connections: { RBXScriptConnection } = {
	Chat = nil,
}
Betabot.Connections = connections

local LocalPlayer = Players.LocalPlayer

--[=[
    all userIDs of the whitelisted players, can be deleted.
    Don't forget to modify the function
    if you do remove the whitelist table!
]=]
local whitelisted: { number } = {
	4793611397,
}

--[[
    Check if the user can run the command
    @param player the Player trying to run the command.
    @returns If the player can run the command
]]
local function canPlayerUseCommand(player: Player)
	if config.whitelistEnabled then
		return table.find(whitelisted, player.UserId) ~= nil
	end
	return true
end

runFn(function()
	-- later!
	-- type info = {
	-- 	-- selector: string,
	-- 	args: { string },
	-- 	flags: { [string]: boolean },
	-- 	requesting: Player?,
	-- }
	-- type basicSelectorHandler = (info) -> Player?
	-- type advancedSelectorHandler = {
	-- 	callback: basicSelectorHandler,
	-- 	aliases: { string }?,
	-- 	getFlags: (selector: string) -> { [string]: boolean },
	-- }
	-- type selectorHandler = advancedSelectorHandler | basicSelectorHandler
	-- type selectorHandlers = { [string]: selectorHandler }
	-- local selectorHandlers: selectorHandlers = {
	-- 	self = {
	-- 		callback = function(info)
	-- 			return info.requesting
	-- 		end,
	-- 		aliases = { "s", "me" },
	-- 	},
	-- 	display = {
	-- 		callback = function(info)
	-- 			for _, player in Players:GetPlayers() do
	-- 				if player.DisplayName == info.args[1] then
	-- 					return player
	-- 				end
	-- 			end
	-- 		end,
	-- 		aliases = { "displayname" },
	-- 	},
	-- 	name = {
	-- 		callback = function(info) end,
	-- 	},
	-- 	id = {},
	-- }
	local function GetPlayerBySelector(name: string, caseInsensitive: boolean?, requestingPlayer: Player?): Player?
		if not caseInsensitive then
			caseInsensitive = true
		end
		if requestingPlayer and name == "me" then
			return requestingPlayer
		end
		if name == "random" then
			local players = Players:GetPlayers()
			-- remove requesting player from the options.
			if requestingPlayer then
				local index = table.find(players, requestingPlayer)
				if index then
					table.remove(players, index)
				end
			end
			-- removes local player from options
			local index = table.find(players, LocalPlayer)
			if index then
				table.remove(players, index)
			end
			return players[math.random(1, #players)]
		end
		for _, player in Players:GetPlayers() do
			if
				(caseInsensitive and player.Name:lower() == name:lower())
				or (not caseInsensitive and player.Name == name)
			then
				return player
			elseif
				(caseInsensitive and player.DisplayName:lower() == name:lower())
				or (not caseInsensitive and player.DisplayName == name)
			then
				return player
			end
		end
		error(`No player with the name "{name}" was found.`)
		return nil
	end

	Betabot.Utils.GetPlayerByName = GetPlayerBySelector
end)

local FloodCheckInfo = {}
--- I could just rejoin same server but that would crash the game if you're using Fluxus.
--- (p.s. showerhead can't fix his exploit)
runFn(function()
	-- NOTE:
	--  DECAY_TIME_PERIOD and MESSAGES_ALLOWED are only 100% perfect on LegacyChatService,
	--  This is because I could find the values in the chat module,
	--  but in TextChatService, the flood detector is in the CoreGui.
	--  (it's not possible to get 100% accurate numbers,
	--    so I just incremented the number starting from 7 and ending at 20)

	--- TextChatService allows you to send ~20 messages before getting rate limited,
	--- LegacyChatService allows you to send 7 messages before getting rate limited
	FloodCheckInfo.MESSAGES_ALLOWED = not isLegacy and 20 or 7
	--- TextChatService requires you to wait ~30 seconds before you can send another message.
	--- LegacyChatService requires you to wait 15 seconds before you can send another message.
	FloodCheckInfo.DECAY_TIME_PERIOD = not isLegacy and 30 or 15
	FloodCheckInfo.floodCheckTable = {}

	---@param tbl table
	function FloodCheckInfo:EnterTimeIntoLog(tbl)
		table.insert(tbl, tick() + self.DECAY_TIME_PERIOD)
	end
end)
---send a message in Chat.
---@param message string
---@param broadcast boolean
---@param target Player
local function Chat(message: string, broadcast: boolean, target: Player): TextChatMessage?
	if type(broadcast) ~= "boolean" then
		broadcast = true
	end
	if isLegacy then
		ChatEvent:FireServer(message, if broadcast then "All" else "To " .. target)
	else
		---@type ChatInputBarConfiguration
		local inputBarConfiguration = TextChatService.ChatInputBarConfiguration
		local msg
		local now = tick()
		while #FloodCheckInfo.floodCheckTable > 0 and FloodCheckInfo.floodCheckTable[1] < now do
			table.remove(FloodCheckInfo.floodCheckTable, 1)
		end
		FloodCheckInfo:EnterTimeIntoLog(FloodCheckInfo.floodCheckTable)
		if #FloodCheckInfo.floodCheckTable < (FloodCheckInfo.MESSAGES_ALLOWED - 1) then
			msg = inputBarConfiguration.TargetTextChannel:SendAsync(message)
			FloodCheckInfo:EnterTimeIntoLog(FloodCheckInfo.floodCheckTable)
		else
			local timeDiff = math.ceil(FloodCheckInfo.floodCheckTable[1] - now)
			task.wait(timeDiff)
			msg = inputBarConfiguration.TargetTextChannel:SendAsync(message)
		end
		return msg
	end
end

Betabot.Utils.Chat = Chat

local folders = {
	"Betabot",
	"Betabot/Commands",
}

for _, folder in folders do
	if not isfolder(folder) then
		makefolder(folder)
	end
end

---@type string[]
local files = {
	"Commands/DefaultCommands.lua",
	"Bot.lua",
}

local base = "https://raw.githubusercontent.com/RealPacket/My-Scripts/main/"
	.. HttpService:UrlEncode("Universal Scripts")
	.. "/Bot/"
local baseFolder = "Betabot/"

---@param path string
---Fetches content from the specified path
---@example Commands/DefaultCommands.lua
---@return string
local function githubRequest(path)
	if not isfile(baseFolder .. path) then
		local suc, res = pcall(function()
			return game:HttpGet(base .. path, true)
		end)
		if not suc or res == "404: Not Found" then
			error(res)
		end
		writefile(baseFolder .. path, res)
	end
	return readfile(baseFolder .. path)
end

Betabot.API.GithubAPI.Request = githubRequest

---@param file string
for _, file in files do
	if not isfile("Betabot/" .. file) then
		writefile(file, githubRequest(file))
	end
end

---Creates a comment, and returns the command that was created.
local function createCommand(name: string, command: command): command
	if type(name) ~= "string" then
		error('Argument #1: expected a string for name, got "' .. tostring(name) .. '".')
	end
	if Betabot.Commands[name] then
		warn("Command " .. '"', name .. '"' .. "was created before this call of createCommand, overriding.")
	end
	Betabot.Commands[name] = command

	return command
end

Betabot.API.CommandAPI.CreateCommand = createCommand

-- [[  END Initialize Betabot (not as a global yet), APIs, Utils, and other things. (PART 1)  ]] --

-- [[  Initialize Betabot (not as a global yet), APIs, Utils, and other things. (PART 2)  ]] --

do
	---@class Permission
	---@field name string
	---@field OnGrantedToPlayer Signal
	---@field OnRevokedFromPlayer Signal
	---@field grantedPlayers Player[]
	local Permission: Permission
	do
		Permission = setmetatable({}, {
			__tostring = function()
				return "Permission"
			end,
		})
		Permission.__index = Permission
		function Permission.new(...)
			local self = setmetatable({}, Permission)
			return self:constructor(...) or self
		end
		---@param name string
		function Permission:constructor(name)
			--- The name of this permission.
			self.name = name
			--- Gets fired once the permission gets granted to a player.
			self.OnGrantedToPlayer = Signal.new()
			--- Gets fired once the permission gets revoked from a player.
			self.OnRevokedFromPlayer = Signal.new()
			--- A list of players that have been granted this permission
			self.grantedPlayers = {}
		end
		--[=[
			Grants this permission to a player, fires the OnGrantedToPlayer event.
		]=]
		---@param target Player
		function Permission:GrantToPlayer(target)
			if table.find(self.grantedPlayers, target) ~= nil then
				error(target.DisplayName .. (" has been granted " .. (self.name .. " already!")))
			end
			self.OnGrantedToPlayer:Fire(target)
			table.insert(self.grantedPlayers, target)
			return target
		end
		--[=[
			Revokes this permission from a player, fires the OnRevokedFromPlayer event.
		]=]
		---@param target Player
		function Permission:RevokeFromPlayer(target)
			local index = table.find(self.grantedPlayers, target)
			if not index then
				error(
					('Player "%s" ' .. "wasn't granted permissions for permission %s."):format(
						target.DisplayName,
						self.name
					)
				)
			end
			self.OnRevokedFromPlayer:Fire(target)
			table.remove(self.grantedPlayers, index)
		end
		---@param player Player
		function Permission:IsGrantedToPlayer(player)
			return table.find(self.grantedPlayers, player) ~= nil
		end
	end
	--- Creates/Adds a permission with the specified name.
	--- Emits a warning if the permission existed before this call, and overrides the old permission.
	---@param name string
	function Betabot.API.PermissionsAPI:CreatePermission(name): Permission
		if self.Permissions[name] then
			warn(('Permission "%s" existed before this call of CreatePermission. Overriding'):format(name))
		end
		local permission = Permission.new(name)
		self.PermissionAdded:Fire(name, permission)
		self.Permissions[name] = permission
		return permission
	end
	---@param name string
	function Betabot.API.PermissionsAPI:GetPermission(name): Permission
		local permission = self.Permissions[name]
		if not permission then
			error(('No permission named "%s" was found.'):format(name))
		end
		return permission
	end
	---@param name string
	function Betabot.API.PermissionsAPI:RemovePermission(name): Permission
		local permission = self.Permissions[name]
		if not permission then
			error(('No permission named "%s" was found.'):format(name))
		end
		self.PermissionRemoving:Fire(permission)
		permission[name] = nil
		return permission
	end
end

-- [[  Initialize Betabot, APIs, Utils, and other things. (PART 2)  ]] --

---@param file string
local function runCommandScript(file)
	local f, err = loadstring(readfile(file), "[Betabot Command] " .. file)
	if not f then
		warn("[Betabot] file " .. file .. " loadstring error:", err)
		return
	end
	getgenv().Betabot = Betabot
	f()
end

if #(listfiles("Betabot/Commands")) > 1 then
	--- enumerate through every file in the commands folder.
	for _, file in listfiles("Betabot/Commands") do
		runCommandScript(file)
	end
else
	-- for people who don't have other custom command scripts in the commands folder
	runCommandScript("Betabot/Commands/DefaultCommands.lua")
end

-- [[ message handler ]] --

---@param msg string
---@param player Player
local function handler(msg: string, player: Player)
	local commandName = msg:gsub(
		if not isLegacy
			then escapeHTML(config.prefix) -- TCS/TextChatService escapes some HTML characters,
			else config.prefix,
		"" -- and LCS/LegacyChatService doesn't escape any HTML characters.
	)
		:split(" ")[1]
	-- are they whitelisted?
	if not canPlayerUseCommand(player) then
		Chat("You aren't whitelisted, @" .. player.DisplayName .. ".")
		return
	end
	-- arguments
	local args = msg:split(" ")
	table.remove(args, 1)
	if not isLegacy then
		for i, arg in args do
			args[i] = unescapeHTML(arg)
		end
	end
	-- determines if the command is valid
	local commandExists = Betabot.Commands[commandName] ~= nil
	if not commandExists then
		return Chat(format(config.MessageFormats.UnknownCommandMessage, {
			PREFIX = config.prefix,
			COMMAND = commandName,
		}))
	end
	local command = Betabot.Commands[commandName]
	local rawArgs = table.clone(args)
	if command.options and command.options.autoConvert then
		-- auto-convert the arguments.
		for i, arg in args do
			-- number
			if tonumber(arg) then
				args[i] = tonumber(arg)
				-- skip other type conversions.
				continue
			end

			local boolMap = {
				yes = true,
				no = false,
				on = true,
				off = false,
				enabled = true,
				disabled = false,
				["false"] = false,
				["true"] = true,
			}
			if boolMap[arg] ~= nil then
				args[i] = boolMap[arg]
				continue
			end
			-- TODO: more types
		end
	end
	-- the command's callback (gets ran when a player triggers it).
	local callback = Betabot.Commands[commandName].callback
	if not callback then
		return Chat('Command "' .. commandName .. '"' .. " doesn't seem to have a callback!")
	end
	local params = { player, args }
	if command.options and command.options.extraRawArgsParam then
		table.insert(params, rawArgs)
	end
	-- run it!
	task.spawn(callback, unpack(params))
end

-- [[ END message handler ]] --

-- [[ Event Register Functions (for compatibility with multiple chat versions.) ]] --

local function registerChattedEventLCS()
	--- NOTE: PlayerChatted doesn't get fired if the sender is LocalPlayer
	connections.Chat = Players.PlayerChatted:Connect(function(_, player, message, targetPlayer)
		if message:sub(1, 1) ~= config.prefix then
			table.insert(Betabot.Logs.Game.Chat, {
				Author = player,
				Message = message,
				Channel = targetPlayer,
				timeStamp = DateTime.now(),
			})
			return
		end
		handler(message, player)
	end)
end

local function registerChattedEventTCS()
	connections.Chat = TextChatService.MessageReceived:Connect(function(msg)
		if not msg.TextSource then
			return
		end
		if not msg.TextSource.UserId then
			return
		end
		local author = Players:GetPlayerByUserId(msg.TextSource.UserId)
		-- if author == LocalPlayer then
		-- 	return
		-- end
		if msg.Text:sub(1, #escapeHTML(config.prefix)) ~= escapeHTML(config.prefix) then
			table.insert(Betabot.Logs.Game.Chat, {
				Author = author,
				Message = unescapeHTML(msg.Text),
				Channel = msg.TextChannel,
				timeStamp = DateTime.now(),
			})
			return
		end
		handler(msg.Text, author)
	end)
end

local function registerChattedEvent()
	return if isLegacy then registerChattedEventLCS() else registerChattedEventTCS()
end

registerChattedEvent()

-- [[ END Event Register Functions. ]] --

-- [[ Destroy bot function ]] --

getgenv().__destroy_bot = function(isReboot)
	getgenv().__destroy_bot = nil
	Betabot.Events.OnDestroy:Fire(isReboot)
	Betabot.Loaded = false
	getgenv().Betabot = nil
	for _, connection in connections do
		-- stop listening to other connections
		connection:Disconnect()
	end
	if not isReboot then
		Chat("[INFO]: Bot has been stopped (destroy_bot function ran)!")
	end
end

-- [[  END Destroy bot function  ]] --

-- [[  Start Message AND Set loaded to true  ]] --

Chat(
	format(config.MessageFormats.StartMessage, {
		MODE = ChatVersion.Name,
		PREFIX = config.prefix,
	}),
	true
)

Betabot.Loaded = true
Betabot.Events.OnLoad:Fire()

-- [[  END Start Message  ]] --
