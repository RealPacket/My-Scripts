--!strict

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
-- if the chat system version isn't Enum.ChatVersion.TextChatService,
-- true, else, false
local isLegacy = TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService
local ChatVersion = TextChatService.ChatVersion
if getgenv().__destroy_bot then
	getgenv().__destroy_bot(true)
	task.wait()
end
local ChatEvent: RemoteEvent?
if isLegacy then
	local ChatEvents: Folder? = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
	ChatEvent = ChatEvents:FindFirstChild("SayMessageRequest")
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

---@param str string The string to escape
---@return string escaped The escaped version of the string.
local function unescapeHTML(str)
	str = str:gsub("&amp;", "&")
	str = str:gsub("&lt;", "<")
	str = str:gsub("&gt;", ">")
	str = str:gsub("&quot;", '"')
	str = str:gsub("&#39;", "'")
	return str
end

-- Some configurations you can change.
local config = {
	-- show debug logs (if any)?
	debug = true,
	-- the debug function.
	debugFn = warn,
	-- The prefix every message that runs a command will start with.
	prefix = ">",
	-- determines if the whitelist is enabled.
	whitelistedEnabled = false,
	-- formats for certain messages that the bot says.
	MessageFormats = {
		StartMessage = "[INFO]: Started bot in {MODE} mode! "
			.. 'Prefix is "{PREFIX}", '
			.. 'Use "{PREFIX}cmds" for a list of commands!',
		UnknownCommandMessage = "Unknown command " .. '"{COMMAND}"! Try using "{PREFIX}cmds" for a list of commands.',
	},
}

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

local function format(str, argsTable)
	if not str then
		error("Unable to format - no string provided.")
	end
	if type(str) ~= "string" then
		error('Unable to format - expected "string", got "' .. type(str) .. '" instead for argument #1.')
	end
	if not argsTable then
		error("Unable to format - no argument(s) table provided")
	end
	if type(argsTable) ~= "table" then
		error('Unable to format - expected "table", got "' .. type(argsTable) .. '" for argument #2.')
	end
	for name, value in argsTable do
		if not str:find("{" .. name .. "}") then
			continue
		end
		str = str:gsub("{" .. name .. "}", value)
	end
	return str
end

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

-- general logs.
local logs: logs = {
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

local function req(opt)
	local fn = if Fluxus then Fluxus.request elseif request then request elseif syn then syn.request else nil
	if fn then
		return fn(opt)
	end
end
function figlet(msg)
	local res = req({
		Url = "https://uploadbeta.com/api/figlet/?cached&msg=" .. HttpService:UrlEncode(msg),
		Method = "GET",
	})
	local decoded = HttpService:JSONDecode(res.Body)
	if type(decoded) ~= "string" then
		return nil
	end
	local messages
	if decoded:find("\n") then
		messages = decoded:split("\n")
	else
		messages = { decoded }
	end
	return messages
end
local connections: { RBXScriptConnection } = {
	Chat = nil,
}

local LocalPlayer = Players.LocalPlayer

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

LocalPlayer.CharacterAdded:Connect(function()
	RunService.PostSimulation:Wait()
	task.wait()
	Character = LocalPlayer.Character
end)

--[[
    all userIDs of the whitelisted players, can be deleted.
    Don't forget to modify the function
    if you do remove the whitelist table!
]]
local whitelisted: { number } = {
	4793611397,
}

--[[
    Check if the user is whitelisted

    @param commandName the name of the command (TODO: make it command obj)

    @param player the Player trying to run the command.

    @returns If the player can run the command
]]
local function canPlayerUseCommand(player: Player, command: command)
	if config.whitelistEnabled then
		return table.find(whitelisted, player.UserId) ~= nil
	end
	return true
end

local function GetPlayerByName(name: string, caseInsensitive: boolean?, requestingPlayer: Player?): Player?
	if not caseInsensitive then
		caseInsensitive = true
	end
	if requestingPlayer and name == "me" then
		return requestingPlayer
	end
	for _, player in Players:GetPlayers() do
		if
			(caseInsensitive and player.Name:lower() == name:lower()) or (not caseInsensitive and player.Name == name)
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
-- send a message in Chat.
---@param message string
---@param broadcast boolean
---@param target Player
---@return TextChatMessage|nil
local function Chat(message: string, broadcast: boolean, target: Player)
	if broadcast == nil or type(broadcast) ~= "boolean" then
		broadcast = true
	end
	if isLegacy then
		ChatEvent:FireServer(message, if broadcast then "All" else "To " .. target)
	else
		local inputBarConfiguration: ChatInputBarConfiguration = TextChatService.ChatInputBarConfiguration
		-- return inputBarConfiguration.TargetTextChannel:SendAsync(message)
		return task.spawn(
			inputBarConfiguration.TargetTextChannel.SendAsync,
			inputBarConfiguration.TargetTextChannel,
			message
		)
	end
end
type command = {
	description: string?,
	options: {
		autoConvert: boolean?,
		extraRawArgsParam: boolean?,
	}?,
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

-- for commands, look in Commands/DefaultCommands.lua, the commands are registered there.
-- also: the commands get registered at runtime.
local commands: commands = {}

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
}

local base = "https://raw.githubusercontent.com/RealPacket/My-Scripts/main/"
	.. HttpService:UrlEncode("Universal Scripts")
	.. "/Bot/"

---@param path string
---@return string
local function githubRequest(path)
	if not isfile("Betabot/" .. path) then
		local suc, res
		suc, res = pcall(function()
			return game:HttpGet(base .. path, true)
		end)
		if not suc or res == "404: Not Found" then
			error(res)
		end
		writefile("Betabot/" .. path, res)
	end
	return readfile("Betabot/" .. path)
end

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
	if commands[name] then
		warn("Command " .. '"', name .. '"' .. "was created before this call of createCommand, overriding.")
	end
	commands[name] = command

	return command
end

-- exported variables/symbols/etc
local exports = {
	createCommand,
	Chat,
	GetPlayerByName,
	req,
	commands = commands,
	logs = logs,
	Character = Character,
}

-- local info = debug.getinfo
---@param file string
local function runCommandScript(file)
	local f, err = loadstring(readfile(file), "[Betabot Command] " .. file)
	if not f then
		warn("[Betabot] file " .. file .. " loadstring error:", err)
		return
	end
	for name, export in exports do
		if type(export) == "function" then
			getgenv()[debug.info(export, "n")] = export
		else
			getgenv()[name] = export
		end
	end
	f()
	for name, export in exports do
		if type(export) == "function" then
			getgenv()[debug.info(export, "n")] = export
		else
			getgenv()[name] = export
		end
	end
end

if #(listfiles("Betabot/Commands")) > 1 then
	for _, file in listfiles("Betabot/Commands") do
		runCommandScript(file)
	end
else
	runCommandScript("Betabot/Commands/DefaultCommands.lua")
end

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
	if not canPlayerUseCommand(player, commandName) then
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
	local commandExists = commands[commandName] ~= nil
	if not commandExists then
		return Chat(format(config.MessageFormats.UnknownCommandMessage, {
			PREFIX = config.prefix,
			COMMAND = commandName,
		}))
	end
	local command = commands[commandName]
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
	local callback = commands[commandName].callback
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

local function registerChattedEventLCS()
	connections.Chat = Players.PlayerChatted:Connect(function(_, player, message, targetPlayer)
		log({ { name = "msg", value = message }, { name = "recip", value = targetPlayer or "nil" } })
		if message:sub(1, 1) ~= config.prefix then
			table.insert(logs.Game.Chat, {
				Author = player,
				Message = message,
				Recipient = targetPlayer,
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
		if author == LocalPlayer then
			return
		end
		if msg.Text:sub(1, #escapeHTML(config.prefix)) ~= escapeHTML(config.prefix) then
			table.insert(logs.Game.Chat, {
				Author = author,
				Message = msg.Text,
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

getgenv().__destroy_bot = function(isReboot)
	getgenv().__destroy_bot = nil
	for _, connection in connections do
		-- stop listening to other connections
		connection:Disconnect()
	end
	if not isReboot then
		Chat("[INFO]: Bot has been stopped (destroy_bot function ran)!", true)
	end
end

Chat(
	format(config.MessageFormats.StartMessage, {
		MODE = ChatVersion.Name,
		PREFIX = config.prefix,
	}),
	true
)