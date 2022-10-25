local URLs = {
	-- Notifications
	"https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/BreakIn/DiscordUI/BreakInWiP.lua",
	-- NO Notifications (Use EVON instead of Krnl cause I fucked up something lol)
	"https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/BreakIn/DiscordUI/BreakInWiP2.lua",
	-- KAVO UI
	"https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/BreakIn/KavoUI/BreakInStoryKavo.lua"
}




-- Dropdown Vars
local selectedKit
local selectedQueue = "NONE"

-- UI Library
local DiscordLib =
    loadstring(game:HttpGet"https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord")()

local win = DiscordLib:Window("Break In Script | Loader")

local serv = win:Server("Main", "")
local UIVers = serv:Channel("Versions")
local selectedVersion = "NONE"
UIVers:Dropdown(
    "Version to load",
    {"Discord Lib (With Notifications)", "Discord Lib (Without notifications)", "Kavo UI", "Orion UI"},
    function(bool)
		selectedVersion = bool
        print("User Selected UI Version:", bool)
    end)
UIVers:Button("Load Selected UI", function() loadVersion(selectedVersion) end)
	function loadVersion(string_version)
	if string_version == "Discord Lib (With Notifications)" then loadstring(game:HttpGet(URLs[1]))() end
	if string_version == "Discord Lib (Without notifications)" then loadstring(game:HttpGet(URLs[2]))() end
	if then end
	
	end