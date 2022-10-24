--[[ TODO:
     (DONE) 1. Add AntiKB (Remote Event in ReplicatedStorage/RemoteEvents/Knockback)
	 (DONE) 2. Add NoSlip (Remote Event in ReplicatedStorage/RemoteEvents/IceSlip)
      (WORKING ON) 3. Add AutoEnding (Adds All Endings By collecting, firing remote events, and other stuff)
	  4. Improve Auto Pie and make it automatically click at the end of green stage thingy
	  OVEN LOCATION IN Workspace / Oven
]]
--[[
	THEMES (Name of theme [Theme Value (what you replace in the UITheme statement)]):
    Light [LightTheme]
    Dark [DarkTheme]
    Grape [GrapeTheme]
    Blood [BloodTheme]
    Ocean [Ocean]
    Midnight [Midnight]
    Sentinel [Sentinel]
    Synapse [Synapse]
    Serpent [Serpent]
	I will add Orion lib to the Collections of Break In Story Scripts
	]]
	-- This is what you Change for a different UI Theme
	local UITheme = "BloodTheme"
    -- NEW: Prefixes
    local Prefix = "[Break In Script]"
	--print(decompile(game:GetService()))












local sGUI = game.StarterGui
local Cat = true -- test
-- Vars for Game Tab, Door Section
local selectedDoor
-- Vars for Game Tab, Shop Section 
local selectedShopItem
-- Variables for Item Tab
local selectedItem
local SIBasement
local SPKitchen
-- Vars for TPStuff
local selectedTP
local TPs = {
    ['Hiding_Spot1'] = CFrame.new(-47, 3, -194),
    ['Hiding_Spot2'] = CFrame.new(-3, 3, -209),
    ['Hiding_Spot3'] = CFrame.new(-43, 3, -224),
    ['Shop'] = CFrame.new(-434, 5, -124),
    ['Uncle_Pete_Backyard'] = CFrame.new(-20, 3, 69),
    ['Uncle_Pete_House'] = CFrame.new(46, 3, -92),
    ['Backyard'] = CFrame.new(82, 3, -204),
    ['TV_Room'] = CFrame.new(8, 3, -220),
    ['Blue_Room'] = CFrame.new(-48, 19, -206),
    ['Pink_Room'] = CFrame.new(7, 19, -227),
    ['Green_Room'] = CFrame.new(6, 19, -197),
    ['Bathroom'] = CFrame.new(-15, 19, -190),
    ['Attic'] = CFrame.new(-19, 36, -214),
    ['Upstairs'] = CFrame.new(-21, 19, -227),
    ['Main_House'] = CFrame.new(-25, 3, -217),
    ['Blue_Porch'] = CFrame.new(-38, 19, -178),
    ['Roof_XD'] = CFrame.new(-20, 44, -217),
    ['Easter_Ending_Place'] = CFrame.new(2977, 4334, -2265),
    ['Charlie_xd'] = CFrame.new(2926, 4386, -2208),
    ['Easter_Ending_High_Ground'] = CFrame.new(2909, 4469, -2264),
    ['Egg'] = CFrame.new(3043, 4357, -2259)
}
-- Functions
function doAllGameEnhancements()
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v.name == "Knockback" or v.Name == "Knockback" or v.name == "Knockback" or v.Name == "Knockback" then
			v:Destroy()
		print("No More KB")
		end
	end
	wait()
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v.name == "ToxicDrown" or v.Name == "ToxicDrown" or v.name == "CatDrown" or v.Name == "CatDrown" then
			v:Destroy()
			print("No More Drowning")
		end
	end
		wait()
		for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v.name == "IceSlip" or v.Name == "IceSlip" or v.name == "IceSlip" or v.Name == "IceSlip" or v.name == "FadeToWhite" or v.Name == "IceSlip" then
			v:Destroy()
		print("No More Slipping, Deleted", v.Name)
		end
		wait()
	end
	end
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v.name == "CantGetUp" or v.Name == "CantGetUp" or v.name == "CantGetUp" or v.Name == "CantGetUp" then
			v:Destroy()
			print("No More Not being able to get up")
		end
	end
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v.name == "Fade" or v.Name == "Fade" or v.name == "FadeBlack" or v.Name == "FadeBlack" or v.name == "FadeToWhite" or v.Name == "FadeToWhite" then
			v:Destroy()
		print("No More Fading, Deleted", v.Name)
		end
	end
function AutoPieF(PieType)
--{"Glazed Apple", "Bloxy Sludge", "Apple", "Cookie"}
    if PieType then
    if PieType ==  "Glazed Apple" then
							game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Apple")
						game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("BloxyCola")
						game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("BloxyCola")
	end
	if PieType == "Cookie" then
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Cookie")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Cookie")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Cookie")
	end
	if PieType == "Apple" then
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Apple")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Apple")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Apple")
end
if PieType == "Bloxy Sludge" then
	game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("BloxyCola")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("BloxyCola")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("BloxyCola")
end
	end
end
function doPurchaseItem(Item)
	if Item == "Pan" then
game:GetService("ReplicatedStorage").RemoteEvents.BuyItem:FireServer("Pan")
	end
		if Item == "Cookie" then
game:GetService("ReplicatedStorage").RemoteEvents.BuyItem:FireServer("Cookie")
	if Item == "BloxyCola" then
game:GetService("ReplicatedStorage").RemoteEvents.BuyItem:FireServer("BloxyCola")
	end
	end
end
function collectAllMoney()
for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v.Name == "Money"  or v.Name == "Money2" or v.Name == "Money2" or v.Name == "Money3" or v.Name == "Money4"or v.Name == "Money5" or v.Name == "Money6" and v.Parent then
			fireclickdetector(v.ClickDetector)
			game:GetService("ReplicatedStorage").RemoteEvents.FoundMoney:FireServer(v)
			game.StarterGui:SetCore("SendNotification", {
                Title = "Money thingy",
                Duration = 1,
                Text = "Found "..v.Name..""
            })
		end
	end
end
function doAutoWin()
	local LarryzHouse = workspace.LarrysHouse
	if not LarryzHouse then
		print("No")
		return
	end
end if LarryzHouse then
for i, v in pairs(workspace.LarrysHouse.Destructable:GetDescendants()) do
	local vName = v.Name
	game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(game:GetService("Workspace").LarrysHouse.Destructable.v.Name)
	break
end
end
function openSafe()
	for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v.Name == "CodeNote" then
			
			--v.SurfaceGui.TextLabel.Text
game.StarterGui:SetCore("SendNotification", {
                Title = "Code Finder",
                Duration = 5,
                Text = "Code is: "..v.SurfaceGui.TextLabel.Text..", Sending Remote Event With parameter with the code.."
				})
	game:GetService("ReplicatedStorage").RemoteEvents.Safe:FireServer(v.SurfaceGui.TextLabel.Text)
			
		end
end
end
function findSafeCode()
	for i, v in pairs(game:GetService("Workspace"):GetDescendants()) do
		if v.Name == "CodeNote" then
			
			--v.SurfaceGui.TextLabel.Text
game.StarterGui:SetCore("SendNotification", {
                Title = "Code Finder",
                Duration = 5,
                Text = "Code is: "..v.SurfaceGui.TextLabel.Text..""
            })
			
		end
end
end
function TPfunc(CFrame)
local plr = game.Players.LocalPlayer
 if plr.Character then
 plr.Character.HumanoidRootPart.CFrame = selectedTP
 end
end
function giveItem(selectedItem)
if selectedItem == "Planks" then
game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer("Plank")
else
game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer(selectedItem)	
end
if selectedItem == "Basement Key" then
	game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer("Key")
end
end
function GBasementItem(SIBasement)
if SIBasement then
		if SIBasement == "Sword (Also Paid)" then
		print(Prefix, "User selected: ", SIBasement)
game:GetService("ReplicatedStorage").RemoteEvents.BasementWeapon:FireServer(table.unpack({
    [1] = true,
    [2] = "Sword",
}))
    elseif SIBasement == "Gun (Paid)" then
		print(Prefix, "User selected: ", SIBasement)
game:GetService("ReplicatedStorage").RemoteEvents.BasementWeapon:FireServer(table.unpack({
    [1] = true,
    [2] = "Gun",
}))
elseif SIBasement == "LinkedSword" then
    game:GetService("ReplicatedStorage").RemoteEvents.BasementWeapon:FireServer(table.unpack({
    [1] = true,
    [2] = "LinkedSword",
}))
elseif SIBasement == "Machine Gun" then
	game:GetService("ReplicatedStorage").RemoteEvents.BasementWeapon:FireServer(table.unpack({
    [1] = true,
    [2] = "SwatGun",
}))
print(Prefix, "User Selected A Item")
end
   end
		end
		function getAllEndings()
			for i, v in pairs() do
game:GetService("ReplicatedStorage").RemoteEvents.EggHuntEvent:FireServer(table.unpack({
    [1] = 1,
    [2] = "IcePart8",
}))
			end
		end








local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Break In GUI | Kavo UI | "..identifyexecutor().."", UITheme)
if identifyexecutor() == "Krnl" then
	print("Executor IS Krnl")
end
local PTab = Window:NewTab("Player")
local PSec = PTab:NewSection("Movement")


PSec:NewSlider("Walking Speed", "Changes your WalkSpeed", 89, 16, function(wSpeed) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = wSpeed
end)
PSec:NewSlider("Jump Height", "Makes you be able to jump Higher", 89, 16, function(jHeight)
    game.Players.LocalPlayer.Character.Humanoid.CharacterJumpDistance = jHeight
end)
PSec:NewSlider("Hip Height", "Makes you walk higher", 89, 2.2, function(hHeight)
if hHeight == 2 then
	p=game:GetService("Players").LocalPlayer.Character
	p:FindFirstChild("Humanoid").HipHeight = 2.2
	
end
	p=game:GetService("Players").LocalPlayer.Character
	p:FindFirstChild("Humanoid").HipHeight = hHeight
end)
--entity.character.HumanoidRootPart.CFrame = entity.character.HumanoidRootPart.CFrame + flypos
local ITab = Window:NewTab("Items")
local ISec = ITab:NewSection("Main")
local ISec2 = ITab:NewSection("Weapons")
local ISec3 = ITab:NewSection("Auto Pie")
local GStuff = Window:NewTab("Game")
local GSec = GStuff:NewSection("Main")
local GSec2 = GStuff:NewSection("Teleports")
local GSec7 = GStuff:NewSection(--[[Name: ]] "Ending Stuff (WiP)")
local GSec3 = GStuff:NewSection("Safe")
local GSec4 = GStuff:NewSection("Misc")
local GSec5 = GStuff:NewSection("Shop")
local GSec6 = GStuff:NewSection("Door Toggle Thingy")
local GSec8 = GStuff:NewSection("Basement Things")
local OUIs = Window:NewTab("Scripts & UIs")
local OUISec = OUIs:NewSection("Discord Lib Versions")
local OUISec2 = OUIs:NewSection("Other Scripts")
--[[GSec4:NewButton(
    "Heal All", "Heals all of the players",
    function()
end)
--]]
-- Auto Pie
ISec3:NewDropdown("Auto Pie Type", "Select A Pie From the Dropdown", {"Glazed Apple", "Bloxy Sludge", "Apple", "Cookie"}, function(sPie)
    print(Prefix, "User selected:", sPie, "To be made with auto pie")
	SPKitchen = sPie
end)
ISec3:NewButton(
    "Auto Pie", "Puts Ingredients In the Pan",
    function()
	-- Check AutoPieF in @ da functions comment
	AutoPieF(SPKitchen)
end)
GSec6:NewDropdown("Door To Toggle", "Select A Door To Be Toggled", {
	"Front",
	"Basement"
}, function(sDoor)
    print(Prefix, "User selected:", sDoor, "To be toggled")
    selectedDoor = sDoor
end)
GSec8:NewButton(
    "Toggle Door", "Toggles The Selected Door",
    function()
game:GetService("ReplicatedStorage").RemoteEvents.Door:FireServer(selectedDoor)
end)
GSec5:NewDropdown("Item To Buy", "Select A Pie From the Dropdown", {
	"Apple", 
	"Cookie", 
	"MedKit", 
	"Pan",
	"BloxyCola"
	}, function(sSitem)
    print(Prefix, "User selected:", sSitem, "To be purchased.")
	selectedShopItem = sSitem
end)

GSec5:NewButton(
    "Purchase", "Buys the Item",
    function()
    doPurchaseItem(selectedShopItem)
end)
GSec4:NewButton(
    "Anti Drown", "Removes the Drown remote Event and ToxicObby Script so It calls nil instead of the function",
    function()
	for i, v in pairs(game:GetService("Players").LocalPlayer.Scripts:GetDescendants()) do
		if v.Name == "ToxicObby" then
		v:Destroy()
		print("Destroyed Script", v.Name)
		end
	end
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v.Name == "ToxicDrown" or v.Name == "CatDrown" and v.Parent then
			v:Destroy()
			print("No More Drowning")
		end
	end
end)
GSec4:NewButton(
    "Anti Can'tGetUp", "Removes the Drown remote Event so It calls nil instead of the function",
    function()
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v.Name == "CantGetUp" then
			v:Destroy()
			print("No More Not being able to get up")
		end
	end
end)
GSec7:NewButton(
    "Auto Win", "Auto Win for Final Ending",
    function()
	doAutoWin()
	wait(5)
    game:GetService("ReplicatedStorage").RemoteEvents.Cattery:FireServer()
	print("Done")
end)GSec7:NewButton(
    "Cat", "The First step for getting the Ending",
    function()
	game:GetService("ReplicatedStorage").RemoteEvents.Cattery:FireServer()
end)
GSec:NewButton(
    "Collect All Money", "Collects All of the money",
    function()
	collectAllMoney()
	wait(5)
	print("Done")
end)
GSec4:NewButton(
    "Apply All Enhancers", "Applies all of the Game Enhancers at once",
    function()
	doAllGameEnhancements()
end)
GSec4:NewButton(
    "Anti KB", "Removes the KB remote Event so It calls nil instead of the function",
    function()
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v.name == "Knockback" or v.Name == "Knockback" or v.name == "Knockback" or v.Name == "Knockback" then
			v:Destroy()
		print("No More KB")
		end
	end
end)
GSec4:NewButton(
    "Anti Fade", "Removes the Fade remote Event so It calls nil instead of the function",
    function()
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v.name == "Fade" or v.Name == "Fade" or v.name == "FadeBlack" or v.Name == "FadeBlack" or v.name == "FadeToWhite" or v.Name == "FadeToWhite" then
			v:Destroy()
		print("No More Fading, Deleted", v.Name)
		end
	end
end)
GSec4:NewButton(
    "Anti Slip", "Removes the Slip remote Event so It calls nil instead of the function",
    function()
	for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if v.name == "IceSlip" or v.Name == "IceSlip" or v.name == "IceSlip" or v.Name == "IceSlip" or v.name == "FadeToWhite" or v.Name == "IceSlip" then
			v:Destroy()
		print("No More Slipping, Deleted", v.Name)
		end
	end
end)
GSec:NewToggle("Boss Aura", "Kills Bosses Around you", function(state)
    if state then
		while state == true do
game:GetService("ReplicatedStorage").RemoteEvents.HitEggBoss:FireServer()
		wait()
		end
    end
end)
GSec2:NewDropdown("Teleports", "Select A Teleport From the Dropdown", {"Hiding_Spot1", "Hiding_Spot2"}, function(sTP)
    print(Prefix, "User selected:", sTP, "To Be Teleported To")
	selectedTP = sTP
end)
GSec3:NewButton(
    "Find & Open Safe", "Finds the code, the safe, and opens the safe",
    function()
	openSafe()
end)
GSec2:NewButton(
    "Teleport to Selected", "TPs you to the selected Location",
    function(selectedTP)
    if selectedTP then
    TPfunc(TPs.selectedTP)
    end
    end)
	GSec:NewToggle("Kill Aura", "Kills Bad Guys Around you", function(state)
    if state then
		while state == true do
			for i, v in pairs(game:GetService("Workspace").Badguys:GetDescendants()) do
game:GetService("ReplicatedStorage").RemoteEvents.HitBadguy:FireServer(table.unpack({
    [1] = workspace.BadGuys[" "],
    [2] = i,
}))
        wait()
		break
		end
		end
    else
    end
end)
OUISec:NewButton(
	"Load w/ notifications",
	"Loads Original UI For Break In Story Script with Notifs on",
	function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/RealPacket/Break-In-Script/Discord-UI/Script.lua"))
	end)
    OUISec2:NewButton(
	"Vape V4", "Loads Vape V4 Script",
	function()
	   loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
	end)
    OUISec2:NewButton(
        "Developer Scripts", "Loads Engospy and A pos Grabber (Engospy: For looking at remote events p grabber: For getting your CFrame Position)",
        function()
        local settings = {
   saveCalls = false,
   maxCallsSaved = 1000,
   saveOnlyLastCall = true,
   maxTableDepth = 100,
   minimizeBind = Enum.KeyCode.RightAlt,
   newFunctionMethod = true,
   blacklistedNames = {}
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/joeengo/engospy/main/source.lua"))(settings)
loadstring(game:HttpGet("https://raw.githubusercontent.com/RealPacket/Position-Grabber/main/posGrabber"))
        end)
GSec:NewButton(
	"Give Key", "Gives you the key for the Final ending", 
	function()
		 game:GetService("ReplicatedStorage").RemoteEvents.GetKeys:FireServer()
	end)


	GSec8:NewButton(
		"Unlock Basement", "Turns on the basement Lights and Gives you the key",
		function()
			game:GetService("ReplicatedStorage").RemoteEvents.BasementMission:FireServer()
			game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer("Key")
			fireclickdetector(game:GetService("Workspace").Doors.Basement.Closed)
		end)
--[[

]]
ISec:NewDropdown("Items", "Select a Item from here to give yourself", {"Cookie", "Apple", "BloxyCola", "Pizza2", "Pizza3", "Planks", "Cure"}, function(sItem)
    print(Prefix, "User Selected", sItem)
	selectedItem = sItem
end)
ISec:NewButton("Give Item", "Gives the Current Selected Item Option from the dropdown", function()
    if selectedItem then
	giveItem(selectedItem)
	print(Prefix, "Gave User:", selectedItem)
	else
		print(Preifx, "User Didn't select A Item")
		ISec:UpdateSection("You Didn't Select a Item!")
		wait(4)
		ISec:UpdateSection("Main")
	end
end)
ISec2:NewDropdown("Weapon", "Drop down for Give Weapon button", {"Gun (Paid)", "Sword (Also Paid)", "LinkedSword", "Machine Gun"}, function(WeaponBool)
 SIBasement = WeaponBool
 print(Prefix, "User selected:", WeaponBool)
	end)
	-- Button after the Dropdown
	ISec2:NewButton(
		"Give Weapon",
		"Gives you the Weapon that you selected from the dropdown above",
		function()
		GBasementItem(SIBasement)
        info(Prefix, "Gave User", SIBasement)
  end)
  
