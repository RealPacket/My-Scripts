local URLs = {
	-- Notifications
	"https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/BreakIn/DiscordUI/BreakInWiP.lua",
	-- NO Notification
	"https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/BreakIn/DiscordUI/BreakInWiP2.lua",
	-- KAVO UI
	"https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/BreakIn/KavoUI/BreakInStoryKavo.lua"
}
-- Function for loading
function loadVersion(string_version)
	if string_version == "Discord Lib (With Notifications)" then loadstring(game:HttpGet(URLs[1]))() end
	if string_version == "Discord Lib (Without notifications)" then loadstring(game:HttpGet(URLs[2]))() end
	if string_version == "Kavo UI" then loadstring(game:HttpGet(URLs[3]))() end
	end


-- Dropdown Vars
local selectedKit
local selectedQueue = "NONE"

-- UI Library
local DiscordLib =
    loadstring(game:HttpGet"https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord")()

local win = DiscordLib:Window("Break In Script | Loader")

local serv = win:Server("Loader", "")
-- Channels
local UIVers = serv:Channel("Versions")
local Kits = serv:Channel("Kits")
local selectedVersion = "NONE"
UIVers:Dropdown(
    "Version to load",
    {"Discord Lib (With Notifications)", "Discord Lib (Without notifications)", "Kavo UI", "Orion UI"},
    function(bool)
		selectedVersion = bool
        print("User Selected UI Version:", bool)
    end)
UIVers:Button("Load Selected UI", function() loadVersion(selectedVersion) end)
-- Dropdown Vars
local selectedKit
local selectedQueue = "NONE"
Kits:Label("This is where you can get Kits for the game!")
    Kits:Dropdown(
    "Kits",
    {"Hardcore mode (Guest)", "MedKit", "The Scared", "The Hungry", "The Hyper"},
    function(bool)
		selectedKit = bool
        print("User Selected Kit:", bool)
    end)
	--This button will have the ugliest code prob
	Kits:Button(
		"Use selected Kit",
		function() equipKit(selectedKit) end
	)
function equipKit(KitName)
if KitName then
			if KitName == "Hardcore mode (Guest)" then
				game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole:FireServer(table.unpack({
    [1] = "LinkedSword",
    [2] = false,
}))
elseif KitName == "MedKit" then
	print("Setting user's Kit to MedKit")
	game:GetService("ReplicatedStorage").RemoteEvents.MakeRole:FireServer(table.unpack({
    [1] = "MedKit",
    [2] = false,
    [3] = false,
}))
elseif KitName == "The Scared" then
	        print("Setting user's Kit to The Scared")
			game:GetService("ReplicatedStorage").RemoteEvents.MakeRole:FireServer(table.unpack({
    [1] = "TeddyBloxpin",
    [2] = true,
    [3] = false,
}))
print("Done!")
elseif KitName == "The Hungry" then
	game:GetService("ReplicatedStorage").RemoteEvents.MakeRole:FireServer(table.unpack({
    [1] = "Chips",
    [2] = true,
    [3] = false,
}))
elseif KitName == "The Hyper" then
	game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole:FireServer(table.unpack({
    [1] = "Lollipop",
    [2] = false,
}))
	end
end
	end
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
