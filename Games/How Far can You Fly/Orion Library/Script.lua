for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
	if v.name == "PlrAccountCheck" or v.Name == "PlrAccountAgeCheck" or v.name == "PlrAccountAgeCheck" or v.name == "plrAccountAgeCheck" then
		v:Destroy()
		if v.name then
		print("[AntiAccountAgeCheck]", "Destroyed", v.name, "!")
		elseif v.Name then
			print("[AntiAccountAgeCheck]", "Destroyed", v.Name, "!")
			wait()
			break
		end
	end
end
local Players = game:GetService("Players")
local LPlayer = Players.LocalPlayer
print(LPlayer.Character.Humanoid.JumpHeight)
-- This is the new How Far Can You Fly game script
getgenv().AutoFarm = false
local selectedDelay = 7
function TPTO(placeCFrame)
local Players = game:GetService("Players")
local LPlayer = Players.LocalPlayer
if LPlayer.Character then
	LPlayer.Character.HumanoidRootPart.CFrame = placeCFrame
end
end
function doAutoFarmTP()
local Players = game:GetService("Players")
local LPlayer = Players.LocalPlayer
if LPlayer.Character then
	LPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6, 2, -137382)
	elseif not LPlayer.Character.HumanoidRootPart.CFrame == CFrame.new(-6, 2, -137382) then
		
end
end
local PHead = game.Players.LocalPlayer.Character.Head
local BetaTest = false
local DebugMode = false
local rebirthLevel = 0
local Uninjecting = false
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Color4UI = Color3.fromRGB(255, 255, 255)
local wasAntiExploitCheckPartDestroyed = false
local Lib = OrionLib:MakeWindow({Name = "How Far Can You Fly Script", HidePremium = false, SaveConfig = true, ConfigFolder = "Orion"})
for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
	if v.name == "PlrAcountAgeCheck" or v.Name == "PlrAcountAgeCheck" then
		print("Destroyed", v.Name)
		v:Destroy()
	end
end
local PTab = Lib:MakeTab({
	Name = "Player Mods",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local ATab = Lib:MakeTab({
	Name = "AutoFarm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local STab = Lib:MakeTab({
	Name = "Other Scripts",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local BTab = Lib:MakeTab({
	Name = "Beta Tests",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local GTab = Lib:MakeTab({
	Name = "Game Mods",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local GExploit = Lib:MakeTab({
	Name = "Game Exploits",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local MTab = Lib:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
PTab:AddSlider({
	Name = "Walk Speed",
	Min = 18,
	Max = 69,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
	Callback = function(WSpeed)
	local Players = game:GetService("Players")
    local LPlayer = Players.LocalPlayer
	LPlayer.Character.Humanoid.WalkSpeed = WSpeed
	end    
})
PTab:AddSlider({
	Name = "Jump Height",
	Min = 1.199999809265137,
	Max = 69,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "",
	Callback = function(JHeight)
	local Players = game:GetService("Players")
    local LPlayer = Players.LocalPlayer
	LPlayer.Character.Humanoid.JumpHeight = JHeight
	end    
})
GTab:AddToggle({
	Name = "Regular Coin Farm",
	Default = false,
	Callback = function(val)
	getgenv().boolean = val
	local Players = game:GetService("Players")
	local LPlayer = Players.LocalPlayer
	while  getgenv().boolean == true and Uninjecting == false and BetaTest == true do
		for i, v in pairs(game:GetService("Workspace").BasicCoins:GetDescendants()) do
			local oldCFrame = nil
			if v.Name == "TouchInterest" and v.Parent then
				firetouchinterest(LPlayer.Character.Head, v.Parent, 0)
				TPTO(v.CFrame)
				print("Touched", v.name)
				firetouchinterest(LPlayer.Character.Head, v.Parent, 1)
			end
		end
		wait()
	end
	end
})
GTab:AddToggle({
	Name = "VIP Coin Farm",
	Default = false,
	Callback = function(val)
	getgenv().boolean = val
	local Players = game:GetService("Players")
	local LPlayer = Players.LocalPlayer
	while  getgenv().boolean == true and Uninjecting == false and BetaTest == true do
		for i, v in pairs(game:GetService("Workspace").VIP.VipCoins:GetDescendants()) do
			if v.name and v.Parent and wasAntiExploitCheckPartDestroyed == true then
				firetouchinterest(LPlayer.Character.Head, v.Parent, 0)
				TPTO(v.CFrame)
				print("Touched", v.name)
				wait()
				firetouchinterest(LPlayer.Character.Head, v.Parent, 1)
				break
			end
		end
	end
	wait()
	end
})
GTab:AddToggle({
	Name = "Anti Account Age Check (only applies to this instance)",
	Default = false,
	Callback = function(val)
	getgenv().boolean = val
	local Players = game:GetService("Players")
	local LPlayer = Players.LocalPlayer
	for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
	if v.name == "PlrAccountCheck" or v.Name == "PlrAccountAgeCheck" or v.name == "PlrAccountAgeCheck" or v.name == "plrAccountAgeCheck" or v.Name == "PlrAcountAgeCheck" then
		v:Destroy()
		if v.name then
		print("[AntiAccountAgeCheck]", "Destroyed", v.name, "!")
		elseif v.Name then
			print("[AntiAccountAgeCheck]", "Destroyed", v.Name, "!")
			wait()
			break
		end
	end
 end
end
})
GTab:AddToggle({
	Name = "Uhh Very normal Toggle",
	Default = false,
	Callback = function(val)
	getgenv().boolean = val
	local Players = game:GetService("Players")
	local LPlayer = Players.LocalPlayer
	while getgenv().boolean == true and Uninjecting == false do
	for i, v in pairs(game:GetService("Players").LocalPlayer.leaderstats:GetDescendants()) do
	if v.name == "SM" or v.Name == "Rebirths" or v.name == "Coins"then
		v.Value = v.Value + 3000000000
		wait()
		end
	end
	wait()
 end
	end
})
GExploit:AddButton({
	Name = "Disable AC (UNPATCHED AS OF 10/26/2022 & 10/27/2022, GOT PATCHED)",
	Callback = function()
		OrionLib:MakeNotification({
	Name = "AC Disabler is back!",
	Content = "it got patched, but I made a comeback :), and it got patched again. What a ass end to a disabler.",
	Image = "rbxassetid://4483345998",
	Time = 6
	})
	for i, v in pairs(game:GetService("Workspace").VIP:GetDescendants()) do
	if v.Name == "Part" or v.Name == "D" and v.Parent then
		v:Destroy()
		print("[AntiAC] Destroying", v.Name)
	OrionLib:MakeNotification({
		Name = "AC Disabler",
		Content = "Destroyed "..v.Name.."",
		Image = "rbxassetid://4483345998",
		Time = 6
	})
	end
end
end
})
ATab:AddToggle({
	Name = "AutoFarm (Doesn't Work lol)",
	Default = false,
	Callback = function(val)
	getgenv().boolean = val
	local Players = game:GetService("Players")
	local LPlayer = Players.LocalPlayer
		while boolean == true and Uninjecting == false do
	-- OLD:
	if BetaTest == false then
	TPTO(CFrame.new(-6, 2, -137382))
	elseif BetaTest == true then
		doAutoFarmTP()
	end
	
	wait(selectedDelay)
	end
	end
})
MTab:AddToggle({
	Name = "Allow Beta Tests",
	Default = false,
	Callback = function(val)
	getgenv().boolean = val
	if boolean == true and Uninjecting == false then
		BetaTest = true
		elseif boolean == false and Uninjecting == false then
			BetaTest = false
	end
	end
})
MTab:AddToggle({
	Name = "Debug Mode",
	Default = false,
	Callback = function(val)
	getgenv().boolean = val
	if getgenv().boolean == true then
		DebugMode = true
		else
		DebugMode = false
	end
	end
})
MTab:AddColorpicker({
	Name = "Colorpicker (Useless)",
	Default = Color3.fromRGB(255, 0, 0),
	Callback = function(Color)
	Color4UI = Color
	end	  
})
ATab:AddSlider({
	Name = "Delay for Auto Farm",
	Min = 0,
	Max = 20,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Delay",
	Callback = function(Delay)
	selectedDelay = Delay
	if DebugMode == true then
	print("Delay:", Delay)
	end
	end    
})
MTab:AddButton({
	Name = "Anti Bad Tiles",
	Callback = function()
end
})
MTab:AddButton({
	Name = "Destroy Script",
	Callback = function()
	OrionLib:MakeNotification({
	Name = "Uninject Script Button",
	Content = "Uninjected!",
	Image = "rbxassetid://4483345998",
	Time = 1 
})
    print("Starting to Destroy Script... (0/4)")
	Uninjecting = true
	print("Uninjecting State Set to true! (1/4)")
	print("Destroying GUI Library And setting Player Speed to default... (2/4)")
	wait(1)
	OrionLib:Destroy()
	LPlayer.Character.Humanoid.WalkSpeed = 18
	print("Destroy Script done! (3/4)")
  	end    
})
STab:AddButton({
	Name = "Load Vape V4",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
  	end    
})

STab:AddButton({
	Name = "Load Dex Explorer",
	Callback = function()
	loadstring(game:HttpGet("https://gist.githubusercontent.com/DinosaurXxX/b757fe011e7e600c0873f967fe427dc2/raw/ee5324771f017073fc30e640323ac2a9b3bfc550/dark%2520dex%2520v4", true))()
  	end    
})

--local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/RealPacket/Orion-Backup/main/source")))()
