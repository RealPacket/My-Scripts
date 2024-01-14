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

local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = UILib:MakeWindow({
	Name = "Tapping Simulator",
	HidePremium = false,
	SaveConfig = true,
	ConfigFolder = "OrionTest",
	IntroEnabled = true,
	IntroText = "public static void main string args",
})

local PTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false,
})
PTab:AddSlider({
	Name = "WalkSpeed",
	Min = 25,
	Max = 60,
	Default = 5,
	Color = Color3.fromRGB(255, 255, 255),
	Increment = 1,
	ValueName = "",
	Callback = function(WSpeed)
		local Players = game.Players
		local LPlayer = Players.LocalPlayer
		LPlayer.Character.Humanoid.WalkSpeed = WSpeed
	end,
})
local GTab = Window:MakeTab({
	Name = "Game",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false,
})
local MTab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false,
})
MTab:AddButton({
	Name = "Test",
	Callback = function()
		game:GetService("ReplicatedStorage").Events.SetNickname:InvokeServer()
	end,
})
MTab:AddButton({
	Name = "Uninject",
	Callback = function()
		print("Uninjecting! (0/3)")
		print("Setting Uninjecting var to true! (1/3)")
		UILib:Destroy()
		print("Destroyed UI! (3/3)")
	end,
})

--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]
local GSec = GTab:AddSection({
	Name = "Auto Tap",
})
local toggled = false
--[[
Name = <string> - The name of the section.
]]
GSec:AddToggle({
	Name = "Auto Tap",
	Default = false,
	Callback = function(toggled2)
		toggled = toggled2
		while toggled do
			game:GetService("ReplicatedStorage").Events.Tap:FireServer()
			task.wait()
		end
	end,
})
