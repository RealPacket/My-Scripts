--!strict

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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
local function escapeHTML(str)
	str = str:gsub("&", "&amp;")
	str = str:gsub("<", "&lt;")
	str = str:gsub(">", "&gt;")
	str = str:gsub('"', "&quot;")
	str = str:gsub("'", "&#39;")
	return str
end

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
			.. 'Use "{PREFIX}help" for a list of commands!',
	},
}

-- debug-logs some variables.
local function debug(t: { { name: string, value: any } })
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

-- general logs.
local logs = {
	-- yes
	Console = {
		Errors = {},
		Warnings = {},
		Prints = {},
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
local connections: { { RBXScriptConnection } } = {
	Chat = nil,
}

function connections:getConnections()
	local conns: { RBXScriptConnection } = {}
	for _, connHolder: { { RBXScriptConnection } } in connections do
		if type(connHolder) ~= "table" then
			continue
		end
		for _, conn in connHolder do
			table.insert(conns, conn)
		end
	end
	return conns
end

local LocalPlayer = Players.LocalPlayer

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

LocalPlayer.CharacterAdded:Connect(function()
	LocalPlayer.CharacterAdded:Wait()
	game:GetService("RunService").PostSimulation:Wait()
	task.wait()
	Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
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
local function isWhitelisted(player: Player, commandName: string?)
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
local function Chat(message: string, broadcast: boolean, target: Player)
	if broadcast == nil or type(broadcast) ~= "boolean" then
		broadcast = true
	end
	if isLegacy then
		ChatEvent:FireServer(message, if broadcast then "All" else "To " .. target)
	else
		local inputBarConfiguration: ChatInputBarConfiguration = TextChatService.ChatInputBarConfiguration
		task.spawn(inputBarConfiguration.TargetTextChannel.SendAsync, inputBarConfiguration.TargetTextChannel, message)
	end
end

type command = {
	description: string?,
	callback: (user: Player, args: { string | number | boolean }) -> (),
}

type commands = { [string]: command }

local commands: commands = {
	autoconverttesting = {
		description = "For testing auto-converting",
		options = {
			autoConvert = true,
		},
		callback = function(_, args)
			local chatString = "Args: "
			for i, arg in args do
				chatString ..= tostring(arg) .. " (" .. type(arg) .. ")" .. (i ~= #args and ", " or "")
			end
			Chat(chatString)
		end,
	},
	test = {
		description = "A testing command.",
		callback = function(_, args)
			Chat("Args: " .. table.concat(args, ", "))
		end,
	},
	vclip = {
		description = "vertically clips the bot's HumanoidRootPart position up.",
		callback = function(user, args)
			if not args[1] then
				Chat("@" .. user.DisplayName .. " I can't VClip, as you haven't provided the 1st required argument.")
				return
			end

			if not tonumber(args[1]) then
				Chat(
					"@"
						.. user.DisplayName
						.. " I can't VClip,"
						.. "as you haven't provided a valid number"
						.. "for the 1st required argument (e.x. 1)."
				)
				return
			end
			if tonumber(args[1]) >= math.huge then
				Chat("@" .. user.DisplayName .. " No")
				return
			end
			local direction = if tonumber(args[1]) <= -1 then "down" else "up"

			Character:PivotTo(Character:GetPivot() + Vector3.new(0, tonumber(args[1]), 0))
			Chat("VClipped " .. direction .. "!")
		end,
	},
	shiftlock = {
		description = "Toggles shift-lock (or set the state manually).",
		callback = function(_, args)
			local state = if args[1] ~= nil
				then true
				else UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter

			UserInputService.MouseBehavior = state and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default

			Chat("Toggled shift-lock " .. (if state then "on" else "off") .. "!")
		end,
	},
	say = {
		description = "Obvious.",
		callback = function(_, args)
			if not args[1] then
				Chat("You didn't provide the first argument (which is what I will say)")
			end
			local str = args[1]
			table.remove(args, 1)
			task.wait()
			for _, part in args do
				str ..= " " .. part
			end
			Chat(str)
		end,
	},
	help = {
		description = "Lists all commands, " .. "descriptions, and examples (if provided)",
	},
	spin = {
		description = "spin around! (speed defaults to 20)",
		callback = function(_, args)
			if args[1] and not tonumber(args[1]) then
				Chat("Invalid number, please enter a valid number (e.x. 1).")
			end
			local speed = tonumber(args[1]) or 20
			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			local RootPart = Humanoid.RootPart

			if speed == 0 and RootPart:FindFirstChild("Spinning") then
				RootPart:FindFirstChild("Spinning"):Destroy()
				return
			end
			if speed >= math.huge then
				return Chat("No.")
			end
			if RootPart:FindFirstChild("Spinning") then
				RootPart.Spinning.AngularVelocity = Vector3.new(0, speed, 0)
				return
			end
			local Spin = Instance.new("BodyAngularVelocity")
			Spin.Name = "Spinning"
			Spin.Parent = RootPart
			Spin.MaxTorque = Vector3.new(0, math.huge, 0)
			Spin.AngularVelocity = Vector3.new(0, speed, 0)
		end,
	},
	hipheight = {
		description = "Set the bot's hip height!",
		callback = function(_, args)
			if not args[1] then
				Chat("I need 1 argument, but I got none.")
				return
			end
			if not tonumber(args[1]) then
				Chat("I got 1 argument, but it's not a valid number.")
				return
			end

			Character:FindFirstChildOfClass("Humanoid").HipHeight = tonumber(args[1])
		end,
	},
	fakesay = {
		description = "uhh yes (args (2): name and msg)",
		callback = function(_, args)
			local a = "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
			return Chat(a .. ((args[1] .. ": ") or "System: ") .. (args[2] or "Shutting down in 69 seconds.."))
		end,
	},
	figlet = {
		description = "Turns some normal ASCII text " .. "into a message that uses symbols.",
		callback = function(user, args)
			if not args[1] then
				Chat("@" .. user.Name .. " You didn't provide any arguments." .. "Please try again.")
				return
			end
			local messages = figlet(args[1])
			for _, msg in pairs(messages) do
				Chat(msg)
			end
		end,
	},
	speed = {
		description = "Sets the bot's speed. (1 arg required)",
	},
	cmds = {
		description = "stripped-down help command.",
	},
	follow = {
		description = "follows a player. (1 arg required, if not specified, it will stop following)",
		followingPlayer = false,
		target = nil,
	},
}

function commands.follow.callback(user, args)
	if not args[1] and not commands.follow.followingPlayer then
		return Chat("No player specified", true)
	end
	-- GetPlayerByName(name: string, caseInsensitive: boolean?, requestingPlayer: Player?): Player?
	local target = GetPlayerByName(args[1], true, user)

	if not target then
		return Chat(
			"Player you specified does not appear to exist, this "
				.. 'Only supports (actual) names ("me is a exception, it\'ll refer to you.")',
			true
		)
	end
	print(target)
	local targetCharacter = target.Character or target.CharacterAdded:Wait()
	print(targetCharacter)

	Character:FindFirstChildOfClass("Humanoid"):MoveTo(targetCharacter:GetPivot().Position)
end
function commands.help.callback()
	Chat("Commands:")
	for name, cmd in commands do
		Chat(name .. ":")
		task.wait()
		Chat("_     - " .. (if cmd.description then cmd.description else "No description provided"))
		task.wait(2.4)
	end
end

function commands.cmds.callback()
	Chat("Commands:")
	task.wait(2.4)
	local names = {}
	for name, _ in commands do
		table.insert(names, name)
	end
	Chat(table.concat(names, ", "))
end

local oldSpeed = Character:FindFirstChildOfClass("Humanoid").WalkSpeed

function commands.speed.callback(_, args)
	if not args[1] then
		return Chat('Argument #1 not provided for command "speed".')
	end
	if not tonumber(args[1]) then
		return Chat("Argument #1 seems to not be a number.")
	end

	if tonumber(args[1]) <= 0 then
		Character:FindFirstChildOfClass("Humanoid").WalkSpeed = oldSpeed
	end
	oldSpeed = Character:FindFirstChildOfClass("Humanoid").WalkSpeed
	Character:FindFirstChildOfClass("Humanoid").WalkSpeed = tonumber(args[1])
end

local function handler(msg: string, player: Player)
	local commandName = msg:gsub(
		if not isLegacy
			then escapeHTML(config.prefix) -- TCS/TextChatService escapes some HTML characters,
			else config.prefix,
		"" -- and LCS/LegacyChatService doesn't escape any HTML characters.
	)
		:split(" ")[1]
	-- are they whitelisted?
	if not isWhitelisted(player, commandName) then
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
	local isValid = commands[commandName] ~= nil
	if not isValid then
		return Chat('Invalid command "' .. commandName .. '"' .. "!")
	end

	if commands[commandName].options and commands[commandName].options.autoConvert then
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
		return Chat('Command "' .. commandName .. '"' .. " Doesn't seem to have a callback!")
	end
	-- run it!
	callback(player, args)
end

local function registerChattedEventLCS()
	connections.Chat = Players.PlayerChatted:Connect(function(chatType, player, message, targetPlayer)
		debug({ { name = "msg", value = message }, { name = "recip", value = targetPlayer or "nil" } })
		if message:sub(1, 1) ~= config.prefix then
			table.insert(logs.Game.Chat, {
				Author = player,
				msg = message,
				recipient = targetPlayer,
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
				msg = msg.Text,
				recipient = nil,
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
	for _, connection in connections:getConnections() do
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
