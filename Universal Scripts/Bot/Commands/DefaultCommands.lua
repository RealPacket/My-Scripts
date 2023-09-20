local UserInputService = game:GetService("UserInputService")
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
			Chat("_\tMessage: " .. chatLog.Message)
			task.wait(3)
			Chat("_\tAuthor: " .. chatLog.Author.DisplayName)
			task.wait(4)
			Chat("_\tTime: " .. chatLog.timeStamp:FormatUniversalTime("MMM D H:MM:SS", "en-us"))
			task.wait(3)
		end
	end,
})

runFn(function()
	local help = createCommand("help", {
		description = "Lists all commands, " .. "descriptions, and examples (if provided)",
	})
	local helping = false
	function help.callback()
		if helping then
			return Chat(":skull:")
		end
		Chat("Commands:")
		helping = true
		for name, cmd in commands do
			Chat(name .. ":")
			task.wait()
			Chat("_     - " .. (if cmd.description then cmd.description else "No description provided"))
			task.wait(2.4)
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
	})
	function follow.callback(user, args)
		if not args[1] and not follow.followingPlayer then
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
end)
