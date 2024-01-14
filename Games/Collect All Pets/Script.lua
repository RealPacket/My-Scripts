--[[
     This file is part of RealPacket/My-Scripts, a collection of scripts licensed under AGPL.
    My-Scripts is 100% free scripts:
        you can redistribute it and/or modify it under
        the terms of the GNU Affero General Public License as published by the Free Software Foundation,
        either version 3 of the License, or (at your option) any later version.

    My-Scripts is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY;
        without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
        See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with My-Scripts.
    If not, see <https://www.gnu.org/licenses/>.
]]
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Lib = OrionLib:MakeWindow({
	Name = "Collect all Pets Script | Orion Lib | " .. identifyexecutor() .. "",
	HidePremium = false,
	SaveConfig = true,
	ConfigFolder = "HowFarCanYouFly",
	IntroText = "Collect All Pets Script by betapacketdlldink.nodllforyou#5608",
})
function loadScript(ScriptName)
	if not ScriptName then
		OrionLib:MakeNotification({
			Name = "Select A Script!",
			Content = "You need to Select a Script to load.",
			Image = "rbxassetid://4483345998",
			Time = 1,
		})
		print("DEBUG:", ScriptName)
	end
	if ScriptName == "Vape" then
		loadstring(
			game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true)
		)()
	end
	if ScriptName == "EngoSpy" then
		local settings = {
			saveCalls = false,
			maxCallsSaved = 1000,
			saveOnlyLastCall = true,
			maxTableDepth = 100,
			minimizeBind = Enum.KeyCode.RightShift,
			newFunctionMethod = false,
			blacklistedNames = {},
		}
		loadstring(game:HttpGet("https://raw.githubusercontent.com/joeengo/engospy/main/source.lua"))(settings)
	end
end
local PTab = Lib:MakeTab({
	Name = "Player Mods",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false,
})
local STab = Lib:MakeTab({
	Name = "Other Scripts",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false,
})

STab:AddButton({
	Name = "Load Selected",
	Callback = function()
		loadScript(selectedScript)
	end,
})
STab:AddDropdown({
	Name = "Script",
	Default = "Vape",
	Options = { "Vape", "EngoSpy", "Dex" },
	Callback = function(val)
		selectedScript = val
	end,
})
--[[
Name = <string> - The name of the dropdown.
Default = <string> - The default value of the dropdown.
Options = <table> - The options in the dropdown.
Callback = <function> - The function of the dropdown.
]]
PTab:AddSlider({
	Name = "Walk Speed",
	Min = 18,
	Max = 69,
	Default = 5,
	Color = Color3.fromRGB(255, 255, 255),
	Increment = 1,
	ValueName = "",
	Callback = function(WSpeed)
		local Players = game:GetService("Players")
		local LPlayer = Players.LocalPlayer
		LPlayer.Character.Humanoid.WalkSpeed = WSpeed
	end,
})

local GTab = Lib:MakeTab({
	Name = "Game Mods",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false,
})
local GExploit = Lib:MakeTab({
	Name = "Game Exploits",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false,
})
local MTab = Lib:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false,
})
MTab:AddButton({
	Name = "Destroy Script",
	Callback = function()
		OrionLib:MakeNotification({
			Name = "Uninject Script Button",
			Content = "Uninjected!",
			Image = "rbxassetid://4483345998",
			Time = 1,
		})
		print("Starting to Destroy Script... (0/4)")
		Uninjecting = true
		print("Uninjecting State Set to true! (1/4)")
		print("Destroying GUI Library And setting Player Speed to default... (2/4)")
		wait(1)
		OrionLib:Destroy()
		LPlayer.Character.Humanoid.WalkSpeed = 16
		print("Destroy Script done! (3/4)")
	end,
})
MTab:AddButton({
	Name = "Claim all Codes",
	Callback = function()
		OrionLib:MakeNotification({
			Name = "",
			Content = "Claiming codes (1/3)",
			Image = "rbxassetid://4483345998",
			Time = 1,
		})
		game:GetService("ReplicatedStorage").Remotes.RedeemCode:FireServer("SticksAndStonesAndLevers")
		OrionLib:MakeNotification({
			Name = "",
			Content = "Claiming Code 'SticksAndStonesAndLevers' (2/3)",
			Image = "rbxassetid://4483345998",
			Time = 2,
		})
		game:GetService("ReplicatedStorage").Remotes.RedeemCode:FireServer("FirstCodeEver")
		OrionLib:MakeNotification({
			Name = "",
			Content = "Claiming Code 'FirstCodeEver' (3/3)",
			Image = "rbxassetid://4483345998",
			Time = 3,
		})
	end,
})
