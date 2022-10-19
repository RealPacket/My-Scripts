-- NEW: SETTINGS
local DelaySetting = 0
local Uninjecting = false
local ModifiedSpeed = false
local Speed = 25


local UILib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = UILib:MakeWindow({Name = "Tapping Simulator", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest", IntroEnabled = true, IntroText = "public static void main string args"})

--[[
Name = <string> - The name of the UI.
HidePremium = <bool> - Whether or not the user details shows Premium status or not.
SaveConfig = <bool> - Toggles the config saving in the UI.
ConfigFolder = <string> - The name of the folder where the configs are saved.
IntroEnabled = <bool> - Whether or not to show the intro animation.
IntroText = <string> - Text to show in the intro animation.
IntroIcon = <string> - URL to the image you want to use in the intro animation.
Icon = <string> - URL to the image you want displayed on the window.
CloseCallback = <function> - Function to execute when the window is closed.
]]
local PTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
PTab:AddSlider({
	Name = "WalkSpeed",
	Min = 25,
	Max = 60,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
	Callback = function(WSpeed)
	local Players = game.Players
	local Players2 = game:GetService("Players")
	local LPlayer = Players.LocalPlayer
	LPlayer.Character.Humanoid.WalkSpeed = WSpeed
	ModifiedSpeed = true
	Speed = WSpeed
	end    
})
--[[
Name = <string> - The name of the slider.
Min = <number> - The minimal value of the slider.
Max = <number> - The maxium value of the slider.
Increment = <number> - How much the slider will change value when dragging.
Default = <number> - The default value of the slider.
ValueName = <string> - The text after the value number.
Callback = <function> - The function of the slider.
]]
local GTab = Window:MakeTab({
	Name = "Game",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local MTab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
MTab:AddButton({
	Name = "Test",
	Callback = function()
   game:GetService("ReplicatedStorage").Events.SetNickname:InvokeServer()
  	end    
})
MTab:AddButton({
	Name = "Uninject",
	Callback = function()
	print("Uninjecting! (0/3)")
	print("Setting Uninjecting var to true! (1/3)")
	Uninjecting = true
	print("Uninjecting Var is now true!")
	UILib:Destroy()
	print("Destroyed UI! (3/3)")
  	end    
})

--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]
local GSec = GTab:AddSection({
	Name = "Auto Tap"
})

--[[
Name = <string> - The name of the section.
]]
GSec:AddToggle({
	Name = "Auto Tap",
	Default = false,
	Callback = function(toggled2)
	getgenv().toggled = toggled2
	while getgenv().toggled == true do
		game:GetService("ReplicatedStorage").Events.Tap:FireServer()
		wait()
	end
	end    
})

--[[
Name = <string> - The name of the toggle.
Default = <bool> - The default value of the toggle.
Callback = <function> - The function of the toggle.
]]

--[[
Name = <string> - The name of the toggle.
Default = <bool> - The default value of the toggle.
Callback = <function> - The function of the toggle.
]]