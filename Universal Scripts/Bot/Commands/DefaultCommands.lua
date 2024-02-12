local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local runFn = task.spawn
local Betabot: Betabot

-- in an actual exploit environment.
if getgenv then
	Betabot = getgenv().Betabot
end

Betabot.Connections.CharacterAdded = LocalPlayer.CharacterAdded:Connect(function(c)
	Character = c
end)

Betabot.API.CommandAPI.CreateCommand("test", {
	description = "A testing command.",
	callback = function(_, args)
		Betabot.Utils.Chat("Args: " .. table.concat(args, ", "))
	end,
})
Betabot.API.CommandAPI.CreateCommand("goto", {
	description = "Teleports to a player.",
	callback = function(user, args)
		local suc, target = pcall(Betabot.Utils.GetPlayerByName, args[1], true, user)
		if not suc then
			return Betabot.Utils.Chat("[ERROR] GetPlayerByName - " .. tostring(target))
		end
		if not target.Character then
			return Betabot.Utils.Chat("The player you specified doesn't have a character yet.")
		end
		Character:PivotTo(target.Character:GetPivot())
	end,
})

Betabot.API.CommandAPI.CreateCommand("autoconverttesting", {
	description = "For testing auto-converting",
	options = {
		autoConvert = true,
		extraRawArgsParam = true,
	},
	callback = function(_, args, rawArgs)
		local chatString = "Args: "
		for i, arg in args do
			local raw = rawArgs[i]
			local str = tostring(arg)
			chatString ..= str .. raw ~= str and " / raw: " .. raw or "" .. " (" .. type(arg) .. ")" .. (i ~= #args and ", " or "")
		end
		Betabot.Utils.Chat(chatString)
	end,
})

Betabot.API.CommandAPI.CreateCommand("re", {
	description = "resets the bot's character.",
	callback = function()
		if not Character then
			Betabot.Utils.Chat(
				"I don't have a character yet (most likely from someone using re), so I'll just wait for me to respawn"
			)
			LocalPlayer.CharacterAdded:Wait()
		end
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if not Humanoid then
			Betabot.Utils.Chat("I don't have a humanoid yet (most likely from someone using re), so I'll just wait.")
			Humanoid = Character:WaitForChild("Humanoid")
		end
		Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
	end,
})

Betabot.API.CommandAPI.CreateCommand("hclip", {
	description = "clips the bot's Character position forward (uses PivotTo btw).",
	options = {
		autoConvert = true,
	},
	callback = function(_, args)
		if type(args[1]) ~= "number" then
			Betabot.Utils.Chat(
				"I can't HClip, as you haven't provided the 1st required argument (or it's not a number)."
			)
			return
		end

		-- if args[1] >= 4e5 then
		-- 	Betabot.Utils.Chat("HClipping up more than 4e5 studs will lag me back down, so I will not.")
		-- 	return
		-- end
		if args[1] >= 1e5 then
			Betabot.Utils.Chat("My sincerest reaction to how big that number is: I will not HClip.")
			return
		end
		local direction = if args[1] <= -1 then "backward" else "forward"
		local camera = workspace.CurrentCamera
		local vec = direction == "forward" and camera.CFrame.LookVector * (Vector3.new(args[1], 0, args[1]))
			or -camera.CFrame.LookVector * (Vector3.new(-args[1], 0, -args[1]))
		local pos = (Character:GetPivot() + vec).Position
		-- pos = Vector3.new(pos.X, Character:GetPivot().Y, pos.Z)
		Character:PivotTo(CFrame.lookAt(pos, pos + vec))
		Betabot.Utils.Chat("HClipped " .. direction .. "!")
	end,
})
Betabot.API.CommandAPI.CreateCommand("vclip", {
	description = "clips the bot's Character position up (uses PivotTo btw).",
	options = {
		autoConvert = true,
	},
	callback = function(user, args)
		if type(args[1]) ~= "number" then
			Betabot.Utils.Chat(
				"@" .. user.DisplayName .. " I can't VClip, as you haven't provided the 1st required argument."
			)
			return
		end

		if args[1] >= 4e5 then
			Betabot.Utils.Chat("VClipping up more than 4e5 studs will lag me back down, so I will not.")
			return
		end
		if args[1] >= 1e5 then
			Betabot.Utils.Chat("My sincerest reaction to how big that number is: I will not VClip.")
			return
		end
		if args[1] <= -513 then
			Betabot.Utils.Chat("VClipping down more than 513 studs will lag me back up, so I will not.")
			return
		end
		local direction = if args[1] <= -1 then "down" else "up"
		Character:PivotTo(Character:GetPivot() + Vector3.new(0, args[1], 0))
		Betabot.Utils.Chat("VClipped " .. direction .. "!")
	end,
})
runFn(function()
	local conn
	local shiftlock = Betabot.API.CommandAPI.CreateCommand("shiftlock", {
		description = "Toggles shift-lock (or set the state manually).",
		options = {
			autoConvert = true,
		},
	})

	function shiftlock.callback(_, args)
		local state = args[1] and args[1] or UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter
		local states = {
			[false] = { mouseIcon = "", cameraOffset = Vector3.zero },
			[true] = { mouseIcon = "rbxasset://textures/MouseLockedCursor.png", cameraOffset = Vector3.new(1.7) },
		}
		-- shift lock rotates your player relative to the camera
		UserGameSettings.RotationType = state and Enum.RotationType.CameraRelative or Enum.RotationType.MovementRelative
		-- it also locks your mouse to the center of the window.
		UserInputService.MouseBehavior = state and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default
		-- get info about what mouse icon to use & the camera offset.
		local currentState = states[state]
		UserInputService.MouseIcon = currentState.mouseIcon
		if state then
			conn = LocalPlayer.CharacterAdded:Connect(function()
				Character:WaitForChild("Humanoid").CameraOffset = currentState.cameraOffset
			end)
			Betabot.Connections.ShiftLock_CharacterAdded = conn
		else
			if conn then
				conn:Disconnect()
			end
			if Betabot.Connections.ShiftLock_CharacterAdded then
				Betabot.Connections.ShiftLock_CharacterAdded = nil
			end
			Character:FindFirstChildOfClass("Humanoid").CameraOffset = Vector3.new()
		end

		Betabot.Utils.Chat("Toggled shift-lock " .. (if state then "on" else "off") .. "!")
	end
end)
Betabot.API.CommandAPI.CreateCommand("spin", {
	description = "spin around! (speed defaults to 20)",
	options = {
		autoConvert = true,
	},
	callback = function(_, args)
		local speed = tonumber(args[1]) or 20
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local RootPart = Humanoid.RootPart -- humanoid root part is gay; change my mind
		if speed == 0 and RootPart:FindFirstChild("Spinning") then
			RootPart:FindFirstChild("Spinning"):Destroy()
			Humanoid.AutoRotate = true
			return
		end
		if speed >= 800 then
			return Betabot.Utils.Chat("No.")
		end
		if RootPart:FindFirstChild("Spinning") then
			RootPart.Spinning.AngularVelocity = Vector3.new(0, speed, 0)
			return
		end
		Humanoid.AutoRotate = false
		local Spin = Instance.new("BodyAngularVelocity", RootPart)
		Spin.Name = "Spinning"
		Spin.MaxTorque = Vector3.new(0, math.huge, 0)
		Spin.AngularVelocity = Vector3.new(0, speed, 0)
	end,
})
Betabot.API.CommandAPI.CreateCommand("hipheight", {
	description = "Set the bot's hip height!",
	options = {
		autoConvert = true,
	},
	callback = function(_, args)
		if not args[1] then
			Betabot.Utils.Chat("I need 1 argument, but I got none.")
			return
		end
		if type(args[1]) ~= "number" then
			Betabot.Utils.Chat("I got 1 argument, but it's not a number.")
			return
		end
		if args[1] >= 9e9 then
			return Betabot.Utils.Chat("no")
		end

		Character:FindFirstChildOfClass("Humanoid").HipHeight = args[1]
	end,
})

Betabot.API.CommandAPI.CreateCommand("getlogs", {
	description = "Lists all logged messages.",
	callback = function()
		local chatLogs: { ChatLog } = table.clone(Betabot.Logs.Game.Chat)
		Betabot.Utils.Chat("Logs:")
		task.wait()
		for _, chatLog in chatLogs do
			Betabot.Utils.Chat(chatLog.message)
			Betabot.Utils.Chat("_     Time (UTC): " .. chatLog.timeStamp:FormatUniversalTime("H:MM:SS", "en-us"))
			task.wait()
		end
	end,
})

runFn(function()
	local help = Betabot.API.CommandAPI.CreateCommand("help", {
		description = "Lists all commands, " .. "descriptions, and examples (if provided)",
	})
	local helping = false
	function help.callback(_, args)
		if helping then
			return
		end
		helping = true
		if not args[1] then
			Betabot.Utils.Chat("Commands:")
			for name, cmd in Betabot.Commands do
				Betabot.Utils.Chat(name .. ":" .. cmd.description or "no description")
			end
		else
			local command = Betabot.Commands[args[1]]
			if not command then
				Betabot.Utils.Chat(('Command "%s" ' .. " doesn't exist!"):format(args[1]))
				return
			end
			Betabot.Utils.Chat(
				("%s: %s"):format(
					args[1],
					(if command.description then command.description else "No description provided")
				)
			)
		end
		helping = false
	end
end)

runFn(function()
	local speed = Betabot.API.CommandAPI.CreateCommand("speed", {
		description = "Sets the bot's speed. (1 arg required)",
	})
	local oldSpeed = Character:FindFirstChildOfClass("Humanoid").WalkSpeed
	function speed.callback(_, args)
		if not args[1] then
			return Betabot.Utils.Chat('Argument #1 not provided for command "speed".')
		end
		if not tonumber(args[1]) then
			return Betabot.Utils.Chat("Argument #1 seems to not be a number.")
		end

		if tonumber(args[1]) <= 0 then
			Character:FindFirstChildOfClass("Humanoid").WalkSpeed = oldSpeed
		end
		oldSpeed = Character:FindFirstChildOfClass("Humanoid").WalkSpeed
		Character:FindFirstChildOfClass("Humanoid").WalkSpeed = tonumber(args[1])
	end
end)
runFn(function()
	local cmds = Betabot.API.CommandAPI.CreateCommand("cmds", {
		description = "stripped-down help command.",
	})
	local listing = false
	function cmds.callback()
		if listing then
			return
		end
		listing = true
		local names = {}
		for name, _ in Betabot.Commands do
			table.insert(names, name)
		end
		local BATCH_SIZE = 5
		Betabot.Utils.Chat(("Commands (%d, BATCH_SIZE=%d):"):format(#names, BATCH_SIZE))
		for i = 1, #names, BATCH_SIZE do
			local j = i + BATCH_SIZE
			print("i=", i)
			print(("sending names from index i (%d) to j (%d)"):format(i, j))
			Betabot.Utils.Chat(table.concat(names, ", ", i, j))
		end
		task.wait(1)
		listing = false
	end
end)

runFn(function()
	local follow = Betabot.API.CommandAPI.CreateCommand("follow", {
		description = "follows a player. (1 arg required, if not specified, it will stop following)",
		followingPlayer = false,
		target = nil,
		options = {
			autoConvert = true,
		},
	})
	function follow.callback(user, args)
		if not args[1] and follow.followingPlayer then
			follow.followingPlayer = false
			return
		end
		local target = Betabot.Utils.GetPlayerByName(args[1], true, user)

		if not target then
			return Betabot.Utils.Chat("Player you specified does not appear to exist.")
		end

		local targetCharacter = target.Character or target.CharacterAdded:Wait()
		local humanoid = Character:FindFirstChildOfClass("Humanoid")
		follow.followingPlayer = true

		while follow.followingPlayer do
			humanoid = humanoid.Parent and Character:FindFirstChildOfClass("Humanoid")
			-- garbage prediction attempt
			-- local pos = targetCharacter:GetPivot().Position
			-- local targetHumanoid = targetCharacter:FindFirstChildOfClass("Humanoid")
			-- if targetHumanoid and targetHumanoid.MoveDirection ~= Vector3.zero then
			-- 	pos += targetHumanoid.MoveDirection + Vector3.new(10, 0, 10)
			-- end
			humanoid:MoveTo(targetCharacter:GetPivot().Position)
			task.wait()
		end
	end
end)

-- made because funny

Betabot.API.CommandAPI.CreateCommand("quandaledingle", {
	description = "What's up guys, It's quandale dingle here.",
	callback = function()
		task.wait()
		Betabot.Utils.Chat([[
What's up guys,
It's quandale dingle here.
The hive network has
skidded disepi's Anti Cheat again.
He now has a full disabler,
		]])
		task.wait()
		Betabot.Utils.Chat(
			"I am calling on all Japanese skidders to help develop the best hack called borion to help take down aeolus client."
		)
	end,
})

-- uncomment if you want the say and fakesay command
-- (commented because someone
-- could just say something
-- that is reportable and report you as if you sent it.)

-- createCommand("say", {
-- 	description = "Obvious.",
-- 	callback = function(_, args)
-- 		if not args[1] then
-- 			Betabot.Utils.Chat("You didn't provide the first argument (which is what I will say)")
-- end
-- local str = args[1]
-- table.remove(args, 1)
-- task.wait()
-- for _, part in args do
-- 	str ..= " " .. part
-- end
-- 		Betabot.Utils.Chat(str)
-- 	end,
-- })

-- createCommand("fakesay", {
-- 	description = "uhh yes (args (2): name and msg)",
-- 	callback = function(_, args)
-- 		local a = "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
-- 		return Betabot.Utils.Chat(a .. ((args[1] or "System") .. ": ") .. (args[2] or "Shutting down in 69 seconds.."))
-- 	end,
-- })

-- main target strafe semi-generated by bing chat
-- (I modified it some to make it look better & be more customizable)
runFn(function()
	local targetStrafe = Betabot.API.CommandAPI.CreateCommand("targetstrafe", {
		description = "Strafes around the specified player!",
		strafing = false,
		target = nil,
		options = {
			autoConvert = true,
		},
	})

	---Function to strafe around a target player (call it every heartbeat)
	---@param targetPlayer Player
	---@param lookAtTarget boolean
	---@param strafeDistance number The distance in studs
	---@param speed number
	local function strafeAroundPlayer(targetPlayer, lookAtTarget, strafeDistance, speed)
		if not targetPlayer then
			targetStrafe.strafing = false
			targetStrafe.target = nil
		end
		local targetCharacter = targetPlayer.Character
		if not targetCharacter then
			return
		end
		if type(lookAtTarget) ~= "boolean" then
			lookAtTarget = false
		end
		if type(strafeDistance) ~= "number" then
			strafeDistance = 7
		end
		if not speed then
			speed = 0
		end

		local targetPosition = targetCharacter:GetPivot()
		local extents = Character:GetExtentsSize() * Character:GetScale()
		local groundParams = RaycastParams.new()
		local direction = -(extents + (Vector3.one * Character.Humanoid.HipHeight))
		groundParams.RespectCanCollide = true
		groundParams.FilterType = Enum.RaycastFilterType.Exclude
		groundParams.FilterDescendantsInstances = { Character }

		-- Calculate the position to move to
		local angle = speed ~= 0 and math.rad(tick() * 360 / speed) or math.rad(tick() * 360)
		local pos = Vector3.new(
			targetPosition.X + strafeDistance * math.cos(angle),
			Character:GetPivot().Y,
			targetPosition.Z + strafeDistance * math.sin(angle)
		)
		local newPosition = lookAtTarget
				and CFrame.lookAt(pos, Vector3.new(targetPosition.X, Character:GetPivot().Y, targetPosition.Z))
			or CFrame.new(pos) * CFrame.Angles(Character:GetPivot():ToEulerAnglesXYZ())
		-- try to not teleport in air so it doesn't fall
		local result = workspace:Raycast(newPosition.Position, direction, groundParams)
		if not result then
			pos = Vector3.new(pos.X, targetPosition.Y, pos.Z)
			newPosition = lookAtTarget
					and CFrame.lookAt(pos, Vector3.new(targetPosition.X, Character:GetPivot().Y, targetPosition.Z))
				or CFrame.new(pos) * CFrame.Angles(Character:GetPivot():ToEulerAnglesXYZ())
		end
		-- Move to the new position
		Character:PivotTo(newPosition)
	end

	function targetStrafe.callback(user, args)
		if #args < 1 then
			targetStrafe.strafing = false
			targetStrafe.target = nil
			Betabot.Connections.TargetStrafe_Heartbeat:Disconnect()
			Betabot.Connections.TargetStrafe_Heartbeat = nil
			return
		end
		if type(args[1]) ~= "string" then
			return Betabot.Utils.Chat("Invalid 1st argument: expected a string, got " .. type(args[1]))
		end
		if args[2] and type(args[2]) ~= "boolean" then
			return Betabot.Utils.Chat("Invalid 2nd argument: expected a boolean, got " .. type(args[2]))
		end
		if args[3] and type(args[3]) ~= "number" then
			return Betabot.Utils.Chat("Invalid 3rd argument: expected a number, got " .. type(args[3]))
		end
		if args[4] and type(args[4]) ~= "number" then
			return Betabot.Utils.Chat("Invalid 4th argument: expected a number, got " .. type(args[4]))
		end
		local suc, target = pcall(Betabot.Utils.GetPlayerByName, args[1], true, user)
		if not suc then
			return Betabot.Utils.Chat("[ERROR] GetPlayerByName - " .. tostring(target))
		end
		targetStrafe.target = target
		targetStrafe.strafing = true
		Betabot.Connections.TargetStrafe_Heartbeat = RunService.Heartbeat:Connect(function()
			if not targetStrafe.target or not targetStrafe.strafing then
				if Betabot.Connections.TargetStrafe_Heartbeat then
					Betabot.Connections.TargetStrafe_Heartbeat:Disconnect()
				end
				targetStrafe.target = nil
				targetStrafe.strafing = false
			end
			strafeAroundPlayer(targetStrafe.target, args[2], args[3], args[4])
		end)
		-- while targetStrafe.strafing do
		-- 	strafeAroundPlayer(targetStrafe.target, args[2], args[3], args[4])
		-- 	task.wait()
		-- end
	end
end)

Betabot.API.CommandAPI.CreateCommand("floodDetectorBypassTest", {
	callback = function()
		local max = 30
		-- NOTE: the chat function bypasses the flood detector. Not this command
		for i = 1, max do
			task.spawn(function()
				Betabot.Utils.Chat("Message index: " .. tostring(i) .. " out of " .. tostring(max))
			end)
			task.wait()
		end
	end,
})

runFn(function()
	local function characters(str)
		local chars = {}
		for i = 1, str:len() do
			local c = str:sub(i, i)
			table.insert(chars, c)
		end
		return chars
	end
	local function altCaps(str)
		local new = ""
		for i, c in characters(str) do
			if (i - 1) % 2 == 0 then
				new ..= c:upper()
			else
				new ..= c:lower()
			end
		end
		return new
	end
	-- no need for autoconvert
	Betabot.API.CommandAPI.CreateCommand("altcaps", {
		description = "alternates between uppercase and lowercase",
		callback = function(_, args)
			local str = args[1]
			table.remove(args, 1)
			for _, part in args do
				str ..= " " .. part
			end
			Betabot.Utils.Chat(altCaps(str))
		end,
	})
end)

-- credits command (don't remove)

Betabot.API.CommandAPI.CreateCommand("credits", {
	callback = function()
		Betabot.Utils.Chat("Bot is open source and made by @RealPacket on GitHub. Licensed under the AGPL license.")
		Betabot.Utils.Chat("Source Code is available at: RealPacket/My-Scripts/Universal Scripts/Bot (on GitHub)")
		Betabot.Utils.Chat("Proudly not made in China.")
	end,
})

runFn(function()
	local function getVectorsFromN(n: number)
		local camera = workspace.CurrentCamera
		local forward = camera.CFrame.LookVector * n
		local backward = -camera.CFrame.LookVector * n
		local right = -camera.CFrame.RightVector * n
		local left = camera.CFrame.RightVector * n
		return {
			forward = forward,
			backward = backward,
			right = right,
			left = left,
		}
	end

	Betabot.API.CommandAPI.CreateCommand("move", {
		description = "moves the bot in a direction. example: move forward 1 right 4",
		callback = function(_, args)
			-- increment by 2
			for i = 1, #args, 2 do
				local arg = args[i + 1]
				local direction = args[i]
				local vec = getVectorsFromN(arg)[direction]
				if not vec then
					return Betabot.Utils.Chat(('Unknown direction "%s"!'):format(direction))
				end
				Character.Humanoid:MoveTo(Character:GetPivot().Position + vec)
			end
			-- local str = args[1]
			-- table.remove(args, 1)
			-- for _, part in args do
			-- 	str ..= "\n" .. part
			-- end
			-- local parsed = parse(str)
			-- for _, block in parsed do
			-- 	if block.targetName ~= "strafe" then
			-- 		local vec = getVectorsFromN(block.args[1])[block.targetName]
			-- 		if not vec then
			-- 			return Betabot.Utils.Chat(('Unknown direction "%s"!'):format(block.targetName))
			-- 		end
			-- 		Character.Humanoid:MoveTo(Character:GetPivot().Position + vec)
			-- 	else
			-- 		local dir = block.args[1]
			-- 		local vec = getVectorsFromN(block.args[2])[dir]
			-- 		if not vec then
			-- 			return Betabot.Utils.Chat(('Unknown direction "%s"!'):format(dir))
			-- 		end
			-- 		Character.Humanoid:MoveTo(Character:GetPivot().Position + vec)
			-- 	end
			-- end
		end,
	})
end)

Betabot.API.CommandAPI.CreateCommand("stop", {
	description = "stops the bot",
	callback = function()
		Betabot.Utils.Chat("Goodbye!")
		getgenv().__destroy_bot()
	end,
})

Betabot.API.CommandAPI.CreateCommand("sit", {
	description = "Sit down right now!",
	-- options = {
	-- 	autoConvertArgs = true
	-- },
	callback = function()
		Character.Humanoid:ChangeState(Enum.HumanoidStateType.Seated)
	end,
})

Betabot.API.CommandAPI.CreateCommand("reload", {
	description = "reloads the bot",
	callback = function()
		getgenv().__destroy_bot(true)
		loadstring(readfile("Betabot/Bot.lua"), "Bot.lua")()
	end,
})

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
}

-- [[  End Typings.  ]] --
