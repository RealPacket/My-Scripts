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
local AutoClick = true
local library =
	loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3"))()

local w = library:CreateWindow("Clicking Sim") -- Creates the window
local b = w:CreateFolder("Farming") -- Creates the folder(U will put here your buttons,etc)
local c = w:CreateFolder("Tests")
local d = w:CreateFolder("TPs")
b:Label("Farming", {
	TextSize = 25, -- Self Explaining
	TextColor = Color3.fromRGB(255, 255, 255), -- Self Explaining
	BgColor = Color3.fromRGB(69, 69, 69), -- Self Explaining
})

c:label(2, {
	TextSize = 25,
	TextColor = Color3.fromRGB(255, 255, 255),
	BgColor = Color3.fromRGB(69, 69, 69),
})
b:Button("Toggle", function(bool)
	AutoClick = bool
	print("Auto Clicker is'", bool)
end)

b:Toggle("Toggle", function(bool)
	shared.toggle = bool
	print(shared.toggle)
end)

b:Slider("Slider", {
	min = 10, -- min value of the slider
	max = 50, -- max value of the slider
	precise = true, -- max 2 decimals
}, function(value)
	print(value)
end)

b:Dropdown(
	"Dropdown",
	{ "A", "B", "C" },
	true,
	function(mob) -- true/false, replaces the current title "Dropdown" with the option that t
		print(mob)
	end
)

b:Bind("Bind", Enum.KeyCode.C, function() -- Default bind
	print("Yes")
end)

b:ColorPicker("ColorPicker", Color3.fromRGB(255, 0, 0), function(color) -- Default color
	print(color)
end)

b:Box("Box", "number", function(value) -- "number" or "string"
	print(value)
end)

b:DestroyGui()

--[[
How to refresh a dropdown:
1)Create the dropdown and save it in a variable
local yourvariable = b:Dropdown("Hi",yourtable,function(a)
    print(a)
end)
2)Refresh it using the function
yourvariable:Refresh(yourtable)
How to refresh a label:
1)Create your label and save it in a variable
local yourvariable = b:Label("Pretty Useless NGL",{
    TextSize = 25; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255);
    BgColor = Color3.fromRGB(69,69,69);
})
2)Refresh it using the function
yourvariable:Refresh("Hello") It will only change the text ofc
]]
-- impossible to fix
function Tap()
	spawn(function()
		while AutoClick == true do
			game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.ClickService.Click:FireServer(1)
			wait()
		end
	end)
end

function TPTo(placeCFrame)
	local plr = game.Players.LocalPlayer
	if plr.Character then
		plr.Character.HumanoidRootPart.CFrame = placeCFrame
	end
end

function GCPPOS()
	local plr = game.Players.LocalPlayer
	if plr.Character then
		return plr.Character.HumanoidRootPart.Position
	end
	return false
end
--[[
-- for when you want to add more features to the script
local settings = {
   saveCalls = false,
   maxCallsSaved = 1000,
   saveOnlyLastCall = true,
   maxTableDepth = 100,
   minimizeBind = Enum.KeyCode.RightAlt,
   newFunctionMethod = true,
   blacklistedNames = {"Begin","PopupEffect","RenderCursor","PromptTradeRequest","NewPlayerCanManageDetails"}
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/joeengo/engospy/main/source.lua"))(settings)
--]]
