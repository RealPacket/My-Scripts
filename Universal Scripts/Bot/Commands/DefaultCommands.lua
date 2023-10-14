local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

LocalPlayer.CharacterAdded:Connect(function(c)
	Character = c
end)

local runFn = task.spawn

Betabot.API.CommandAPI.CreateCommand("test", {
	description = "A testing command.",
	callback = function(_, args)
		Betabot.Utils.Chat("Args: " .. table.concat(args, ", "))
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
			chatString ..= tostring(arg) .. " / raw: " .. rawArgs[i] .. " (" .. type(arg) .. ")" .. (i ~= #args and ", " or "")
		end
		Betabot.Utils.Chat(chatString)
	end,
})

Betabot.API.CommandAPI.CreateCommand("re", {
	description = "resets the bot's character.",
	callback = function()
		if not Character then
			return
		end
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if not Humanoid then
			return
		end
		Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
	end,
})

Betabot.API.CommandAPI.CreateCommand("vclip", {
	description = "vertically clips the bot's HumanoidRootPart position up.",
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
		if args[1] <= -513 then
			Betabot.Utils.Chat("VClipping down more than 513 studs will lag me back up, so I will not.")
			return
		end
		local direction = if args[1] <= -1 then "down" else "up"
		Character:PivotTo(Character:GetPivot() + Vector3.new(0, args[1], 0))
		Betabot.Utils.Chat("VClipped " .. direction .. "!")
	end,
})
Betabot.API.CommandAPI.CreateCommand("shiftlock", {
	description = "Toggles shift-lock (or set the state manually).",
	options = {
		autoConvert = true,
	},
	callback = function(_, args)
		local state = args[1] and Enum.MouseBehavior.Default
			or UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter

		UserInputService.MouseBehavior = state and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default

		Betabot.Utils.Chat("Toggled shift-lock " .. (if state then "on" else "off") .. "!")
	end,
})
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
			-- legacy chat service is gay so I have to use space instead of tabs
			Betabot.Utils.Chat("_     Message: " .. chatLog.Message)
			task.wait(1)
			Betabot.Utils.Chat("_     Author: " .. chatLog.Author.DisplayName)
			task.wait()
			Betabot.Utils.Chat("_     Time: " .. chatLog.timeStamp:FormatUniversalTime("MMM D H:MM:SS", "en-us"))
			task.wait(3)
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
				Betabot.Utils.Chat(name .. ":")
				task.wait(2.4)
				Betabot.Utils.Chat(
					"_     - " .. (if cmd.description then cmd.description else "No description provided")
				)
				task.wait(2.6)
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
		Betabot.Utils.Chat("Commands:")
		task.wait(2.4)
		local names = {}
		for name, _ in Betabot.Commands do
			table.insert(names, name)
		end
		Betabot.Utils.Chat(table.concat(names, ", "))
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
-- 		end
-- 		local str = args[1]
-- 		table.remove(args, 1)
-- 		task.wait()
-- 		for _, part in args do
-- 			str ..= " " .. part
-- 		end
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

	---Function to strafe around a target player
	---@param targetPlayer Player
	---@param lookAtTarget boolean
	---@param strafeDistance number
	---@param speed number
	local function strafeAroundPlayer(targetPlayer, lookAtTarget, strafeDistance, speed)
		local targetCharacter = targetPlayer.Character
		if type(lookAtTarget) ~= "boolean" then
			lookAtTarget = false
		end
		if type(strafeDistance) ~= "number" then
			strafeDistance = 7
		end
		if not speed then
			speed = 0
		end
		if not targetCharacter then
			return
		end

		local targetPosition = targetCharacter:GetPivot()

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

		-- Move to the new position
		Character:PivotTo(newPosition)
	end

	function targetStrafe.callback(user, args)
		if #args < 1 then
			targetStrafe.strafing = false
			targetStrafe.target = nil
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
		while targetStrafe.strafing do
			strafeAroundPlayer(targetStrafe.target, args[2], args[3], args[4])
			task.wait()
		end
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
