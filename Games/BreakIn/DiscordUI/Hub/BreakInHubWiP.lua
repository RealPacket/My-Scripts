--Hub BreakIn Script (dead/depricated)
game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole:FireServer(table.unpack({
    [1] = "LinkedSword",
    [2] = false,
}))
local DiscordLib =
    loadstring(game:HttpGet "https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord")()

local win = DiscordLib:Window("Break In Script | Hub")

local serv = win:Server("Main", "")

local Kits = serv:Channel("Kits")
Kits:Label("This is where you can get Kits for the game!")
    Kits:Dropdown(
    "Kits",
    {"Hardcore mode (Guest)", "MedKit", "The Scared", "The Hungry", "The Hyper"},
    function(bool)
        print("User Selected Kit: ", bool)
    end)
	--This button will have the ugliest code prob
	Kits:Button(
		"Use selected Kit",
		function()
			if bool == "Hardcore mode (Guest)" then
				game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole:FireServer(table.unpack({
    [1] = "LinkedSword",
    [2] = false,
}))
elseif bool == "MedKit" then
	print("Setting user's Kit to MedKit")
	game:GetService("ReplicatedStorage").RemoteEvents.MakeRole:FireServer(table.unpack({
    [1] = "MedKit",
    [2] = false,
    [3] = false,
}))
elseif bool == "The Scared" then
	        print("Setting user's Kit to The Scared")
			game:GetService("ReplicatedStorage").RemoteEvents.MakeRole:FireServer(table.unpack({
    [1] = "TeddyBloxpin",
    [2] = true,
    [3] = false,
}))
print("Done!")
elseif bool == "The Hungry" then
	game:GetService("ReplicatedStorage").RemoteEvents.MakeRole:FireServer(table.unpack({
    [1] = "Chips",
    [2] = true,
    [3] = false,
}))
			end
		end
	)
--[[
	--Adult, The Healer/MedKit
game:GetService("ReplicatedStorage").RemoteEvents.MakeRole:FireServer(table.unpack({
    [1] = "MedKit",
    [2] = false,
    [3] = false,
}))
--Kid, The Scared
game:GetService("ReplicatedStorage").RemoteEvents.MakeRole:FireServer(table.unpack({
    [1] = "TeddyBloxpin",
    [2] = true,
    [3] = false,
}))

--Kid, The Hungry
game:GetService("ReplicatedStorage").RemoteEvents.MakeRole:FireServer(table.unpack({
    [1] = "Chips",
    [2] = true,
    [3] = false,
}))
--Adult, The Guest/Hardcore mode
game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole:FireServer(table.unpack({
    [1] = "LinkedSword",
    [2] = false,
}))
--Kid, The Hyper
game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole:FireServer(table.unpack({
    [1] = "Lollipop",
    [2] = false,
}))
]]
