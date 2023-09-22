local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

LocalPlayer.CharacterAdded:Connect(function(c)
	Character = c
end)

local runFn = task.spawn

createCommand("test", {
	description = "A testing command.",
	callback = function(_, args)
		Chat("Args: " .. table.concat(args, ", "))
	end,
})

createCommand("autoconverttesting", {
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
		Chat(chatString)
	end,
})

createCommand("re", {
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
createCommand("vclip", {
	description = "vertically clips the bot's HumanoidRootPart position up.",
	options = {
		autoConvert = true,
	},
	callback = function(user, args)
		if type(args[1]) ~= "number" then
			Chat("@" .. user.DisplayName .. " I can't VClip, as you haven't provided the 1st required argument.")
			return
		end

		if args[1] >= 4e5 then
			Chat("Nah.")
			return
		end
		if args[1] <= -513 then
			Chat("VClipping down more than -513 will lag me back up, so I will not.")
			return
		end
		local direction = if args[1] <= -1 then "down" else "up"
		Character:PivotTo(Character:GetPivot() + Vector3.new(0, args[1], 0))
		Chat("VClipped " .. direction .. "!")
	end,
})
createCommand("shiftlock", {
	description = "Toggles shift-lock (or set the state manually).",
	options = {
		autoConvert = true,
	},
	callback = function(_, args)
		local state = args[1] and Enum.MouseBehavior.Default
			or UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter

		UserInputService.MouseBehavior = state and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default

		Chat("Toggled shift-lock " .. (if state then "on" else "off") .. "!")
	end,
})
createCommand("spin", {
	description = "spin around! (speed defaults to 20)",
	callback = function(_, args)
		local speed = tonumber(args[1]) or 20
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local RootPart = Humanoid.RootPart

		if speed == 0 and RootPart:FindFirstChild("Spinning") then
			RootPart:FindFirstChild("Spinning"):Destroy()
			return
		end
		if speed >= 800 then
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
})
createCommand("hipheight", {
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
})

createCommand("getlogs", {
	description = "Lists all logged messages.",
	callback = function()
		local chatLogs: { ChatLog } = table.clone(logs.Game.Chat)
		Chat("Logs:")
		task.wait()
		for _, chatLog in chatLogs do
			-- legacy chat service is gay so I have to use space instead of tabs
			Chat("_     Message: " .. chatLog.Message)
			task.wait(1)
			Chat("_     Author: " .. chatLog.Author.DisplayName)
			task.wait()
			Chat("_     Time: " .. chatLog.timeStamp:FormatUniversalTime("MMM D H:MM:SS", "en-us"))
			task.wait(3)
		end
	end,
})

runFn(function()
	local help = createCommand("help", {
		description = "Lists all commands, " .. "descriptions, and examples (if provided)",
	})
	local helping = false
	function help.callback(_, args)
		if helping then
			return Chat(":skull:")
		end
		helping = true
		if not args[1] then
			Chat("Commands:")
			for name, cmd in commands do
				Chat(name .. ":")
				task.wait(2.4)
				Chat("_     - " .. (if cmd.description then cmd.description else "No description provided"))
				task.wait(2.6)
			end
		else
			local command = commands[args[1]]
			if not command then
				Chat(('Command "%s" ' .. " doesn't exist!"):format(args[1]))
				return
			end
			Chat(
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
	local speed = createCommand("speed", {
		description = "Sets the bot's speed. (1 arg required)",
	})
	local oldSpeed = Character:FindFirstChildOfClass("Humanoid").WalkSpeed
	function speed.callback(_, args)
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
end)
runFn(function()
	local cmds = createCommand("cmds", {
		description = "stripped-down help command.",
	})
	function cmds.callback()
		Chat("Commands:")
		task.wait(2.4)
		local names = {}
		for name, _ in commands do
			table.insert(names, name)
		end
		Chat(table.concat(names, ", "))
	end
end)

runFn(function()
	local follow = createCommand("follow", {
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
		local target = GetPlayerByName(args[1], true, user)

		if not target then
			return Chat("Player you specified does not appear to exist.")
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

createCommand("quandaledingle", {
	description = "What's up guys, It's quandale dingle here.",
	callback = function()
		task.wait()
		Chat([[
What's up guys,
It's quandale dingle here.
The hive network has
skidded disepi's Anti Cheat again.
He now has a full disabler,
		]])
		task.wait()
		Chat(
			"I am calling on all Japanese skidders to help develop the best hack called borion to help take down aeolus client."
		)
	end,
})

-- createCommand("say", {
-- 	description = "Obvious.",
-- 	callback = function(_, args)
-- 		if not args[1] then
-- 			Chat("You didn't provide the first argument (which is what I will say)")
-- 		end
-- 		local str = args[1]
-- 		table.remove(args, 1)
-- 		task.wait()
-- 		for _, part in args do
-- 			str ..= " " .. part
-- 		end
-- 		Chat(str)
-- 	end,
-- })

-- createCommand("fakesay", {
-- 	description = "uhh yes (args (2): name and msg)",
-- 	callback = function(_, args)
-- 		local a = "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
-- 		return Chat(a .. ((args[1] or "System") .. ": ") .. (args[2] or "Shutting down in 69 seconds.."))
-- 	end,
-- })

runFn(function()
	local targetStrafe = createCommand("targetstrafe", {
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
		if not strafeDistance and strafeDistance ~= 0 then
			strafeDistance = 7
		end
		if not targetCharacter then
			return
		end

		local targetPosition = targetCharacter:GetPivot()

		-- Calculate the position to move to
		local angle = speed ~= 0 and math.rad(tick() * 360 / speed) or math.rad(tick() * 360) -- Change 5 to adjust the speed of strafing
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
			return Chat("Invalid 1st argument: expected a string, got " .. type(args[1]))
		end
		if args[2] and type(args[2]) ~= "boolean" then
			return Chat("Invalid 2nd argument: expected a boolean, got " .. type(args[2]))
		end
		if args[3] and type(args[3]) ~= "number" then
			return Chat("Invalid 3rd argument: expected a number, got " .. type(args[3]))
		end
		if args[4] and type(args[4]) ~= "number" then
			return Chat("Invalid 4th argument: expected a number, got " .. type(args[4]))
		end
		local suc, target = pcall(GetPlayerByName, args[1], true, user)
		if not suc then
			return Chat("[ERROR] GetPlayerByName - " .. tostring(target))
		end
		targetStrafe.target = target
		targetStrafe.strafing = true
		while targetStrafe.strafing do
			strafeAroundPlayer(targetStrafe.target, args[2], args[3], args[4])
			task.wait()
		end
	end
end)
