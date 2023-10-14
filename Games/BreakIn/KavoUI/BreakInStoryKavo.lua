-- Updated because I decided to finally play the garbage game again (impossible)
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

-- For script not being executed more than 1 time
local UITheme = "BloodTheme"
local Prefix = "[Break In Script]"
--	if getgenv().is Loaded then
--	error("This script is already loaded!")
--  end

getgenv().is_Loaded = true

-- Other Vars
local runFn = task.spawn
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local sGUI = game:GetService("StarterGui")
local RemoteEvents = ReplicatedStorage.RemoteEvents
-- Variables for Game Tab, Door Section
local selectedDoor
-- Variables for Item Tab, Shop Section
local selectedShopItem
-- Variables for Game Tab, Laggers Section
local selectedLagger
-- Variables for Item Tab
local selectedItem
local SIBasement
local SPKitchen
-- Vars for TPStuff
local selectedTP

local TPs = {
	["Hiding Spot 1"] = CFrame.new(-47, 3, -194),
	["Hiding Spot 2"] = CFrame.new(-3, 3, -209),
	["Hiding Spot 3"] = CFrame.new(-43, 3, -224),
	Shop = CFrame.new(-434, 5, -124),
	["Uncle Pete Backyard"] = CFrame.new(-20, 3, 69),
	["Uncle Pete House"] = CFrame.new(46, 3, -92),
	Backyard = CFrame.new(82, 3, -204),
	["TV Room"] = CFrame.new(8, 3, -220),
	["Blue Room"] = CFrame.new(-48, 19, -206),
	["Pink Room"] = CFrame.new(7, 19, -227),
	["Green Room"] = CFrame.new(6, 19, -197),
	Bathroom = CFrame.new(-15, 19, -190),
	Attic = CFrame.new(-19, 36, -214),
	Upstairs = CFrame.new(-21, 19, -227),
	["Main House"] = CFrame.new(-25, 3, -217),
	["Blue Porch"] = CFrame.new(-38, 19, -178),
	["Roof XD"] = CFrame.new(-20, 44, -217),
	["Easter Ending Place"] = CFrame.new(2977, 4334, -2265),
	["Charlie XD"] = CFrame.new(2926, 4386, -2208),
	["Easter Ending High Ground"] = CFrame.new(2909, 4469, -2264),
	Egg = CFrame.new(3043, 4357, -2259),
}
local PlayerList = {}
for _, P in Players:GetPlayers() do
	table.insert(PlayerList, P)
end
-- Functions (Refined from for loops to actual decent code)
function doAllGameEnhancements()
	local Events2Destroy = {
		RemoteEvents:FindFirstChild("Knockback"),
		RemoteEvents:FindFirstChild("ToxicDrown"),
		RemoteEvents:FindFirstChild("IceSlip"),
		RemoteEvents:FindFirstChild("CantGetUp"),
		RemoteEvents:FindFirstChild("FadeBlack"),
		RemoteEvents:FindFirstChild("FadeToWhite"),
	}
	for _, Event in Events2Destroy do
		if Event then
			print("DEBUG: Destroyed", Event)
			Event:Destroy()
		end
	end
end
function getDialogText()
	-- ok
	fireclickdetector(workspace.Neighbours.Crazy[""].ClickDetector)
end
function getAtticItem()
	local Item = {
		["Name"] = "",
		["Item"] = nil,
		["ClickDetector"] = nil,
	}
	if workspace.Attic:FindFirstChild("BloxyPack") then
		Item.Name = "Bloxy Pack"
		Item.Item = workspace.Attic.BloxyPack
		Item.ClickDetector = Item.Item.ClickDetector
	elseif workspace.Attic:FindFirstChild("PieDish") then
		Item.Name = "Pie Dish"
		Item.Item = workspace.Attic.PieDish
		Item.ClickDetector = Item.Item.ClickDetector or workspace.Attic.PieDish.ClickDetector
	end
	if Item.Item then
		sGUI:SetCore("SendNotification", {
			Title = "Attic Item Stealer",
			Duration = 1,
			Text = "Found a " .. Item.Name or "Nothing lol" .. "!",
		})
	end
end
function AutoPieF(PieType)
	--{"Glazed Apple", "Bloxy Sludge", "Apple", "Cookie"}
	if PieType then
		if PieType == "Glazed Apple" then
			RemoteEvents.AddIngredient:FireServer("Apple")
			RemoteEvents.AddIngredient:FireServer("BloxyCola")
			RemoteEvents.AddIngredient:FireServer("BloxyCola")
			print("Wait for 0.3 milliseconds has started")
			task.wait(0.3)
			print("Wait for 0.3 milliseconds has finished")
			fireclickdetector(workspace.TheHouse["Kitchen Sink"].Pan1.ClickDetector)
			print("Interacted with Pie Dish, waiting 5.88...")
			task.wait(5.88)
			print("5.88 seconds.milliseconds has passed, interacting with Oven...")
			mouse1click()
			fireclickdetector(workspace.TheHouse.Oven.ClickDetector)
			print("Done!")
		end
		if PieType == "Cookie" then
			RemoteEvents.AddIngredient:FireServer("Cookie")
			RemoteEvents.AddIngredient:FireServer("Cookie")
			RemoteEvents.AddIngredient:FireServer("Cookie")
			print("Wait for 0.3 milliseconds has started")
			task.wait(0.3)
			print("Wait for 0.3 milliseconds has finished")
			fireclickdetector(workspace.TheHouse["Kitchen Sink"].Pan1.ClickDetector)
			print("Interacted with Pie Dish, waiting 7.62...")
			task.wait(7.62)
			print("7.62 seconds.milliseconds has passed, interacting with Oven")
			fireclickdetector(workspace.TheHouse.Oven.ClickDetector)
			print("Done!")
		end
		if PieType == "Apple" then
			RemoteEvents.AddIngredient:FireServer("Apple")
			RemoteEvents.AddIngredient:FireServer("Apple")
			RemoteEvents.AddIngredient:FireServer("Apple")
			print("Wait for 0.3 milliseconds has started")
			task.wait(0.3)
			print("Wait for 0.3 milliseconds has finished")
			fireclickdetector(workspace.TheHouse["Kitchen Sink"].Pan1.ClickDetector)
			print("Interacted with Pie Dish, waiting 7.62...")
			task.wait(7.62)
			print("7.62 seconds.milliseconds has passed, interacting with Oven")
			fireclickdetector(workspace.TheHouse.Oven.ClickDetector)
			print("Done!")
		end
		if PieType == "Bloxy Sludge" then
			RemoteEvents.AddIngredient:FireServer("BloxyCola")
			RemoteEvents.AddIngredient:FireServer("BloxyCola")
			RemoteEvents.AddIngredient:FireServer("BloxyCola")
			print("Wait for 0.3 milliseconds has started")
			task.wait(0.3)
			print("Wait for 0.3 milliseconds has finished")
			fireclickdetector(workspace.TheHouse["Kitchen Sink"].Pan1.ClickDetector)
			print("Interacted with Pie Dish, waiting 7.62...")
			task.wait(7.62)
			print("7.62 seconds.milliseconds has passed, interacting with Oven")
			fireclickdetector(workspace.TheHouse.Oven.ClickDetector)
			print("Done!")
		end
	end
end
function doPurchaseItem(Item)
	if Item == "Pan" then
		RemoteEvents.BuyItem:FireServer("Pan")
		fireclickdetector(workspace.ShopItems.Pan.ClickDetector)
	end
	if Item == "Cookie" then
		fireclickdetector(workspace.ShopItems.Cookie.ClickDetector)
	end
	if Item == "Cola" then
		fireclickdetector(workspace.ShopItems.BloxyCola.ClickDetector)
	end
	if Item == "Sewer Bloxy Cola" then
		fireclickdetector(workspace.ShopItems.ExpiredBloxyCola.ClickDetector)
	end
	if Item == "Med Kit" then
		fireclickdetector(workspace.ShopItems.MedKit.ClickDetector)
	end
end
function doAutoWin()
	if not workspace:FindFirstChild("LarrysHouse") then
		print("House not found.")
		return
	end
	-- TODO
end
function openSafe()
	if not workspace:FindFirstChild("CodeNote") then
		print("Code Note not found.")
		return
	end
	if not workspace:FindFirstChild("CodeNote"):FindFirstChild("SurfaceGui") then
		print("Code Note Surface GUI not found.")
		return
	end
	local CodeNote = workspace.CodeNote
	local paintingIds = {
		"http://www.roblox.com/asset/?id=363240671",
		"rbxassetid://3195645922",
		"http://www.roblox.com/asset/?id=178210631",
		"http://www.roblox.com/asset/?id=3246691515",
		"rbxassetid://3195645674",
	}
	for _, paintingId in paintingIds do
		RemoteEvents.PaintingClicked:FireServer(paintingId)
	end
	sGUI:SetCore("SendNotification", {
		Title = "Code Finder",
		Duration = 5,
		Text = "Code is: " .. CodeNote.SurfaceGui.TextLabel.Text,
	})
	RemoteEvents.Safe:FireServer(workspace.CodeNote.SurfaceGui.TextLabel.Text)
end
function findSafeCode()
	local codeNote = workspace:FindFirstChild("CodeNote")
	if not codeNote then
		sGUI:SetCore("SendNotification", {
			Title = "Code Finder",
			Duration = 3,
			Text = "Code note wasn't found!",
		})
		return
	end
	sGUI:SetCore("SendNotification", {
		Title = "Code Finder",
		Duration = 5,
		Text = "Code is: " .. codeNote.SurfaceGui.TextLabel.Text,
	})
	return tonumber(codeNote.SurfaceGui.TextLabel.Text)
end
function lag(laggerOption)
	local laggerEvent
	if laggerOption == "Cat" then
		laggerEvent = RemoteEvents.Cattery
	elseif laggerOption == "Basement" then
		laggerEvent = RemoteEvents.UnlockDoor
	elseif laggerOption == "Ending" then
		laggerEvent = RemoteEvents.GetKeys
	end
	laggerEvent:FireServer()
end
function giveItem(selectedItem)
	if selectedItem == "Planks" then
		RemoteEvents.GiveTool:FireServer("Plank")
	else
		RemoteEvents.GiveTool:FireServer(selectedItem)
	end
	if selectedItem == "Basement Key" then
		RemoteEvents.GiveTool:FireServer("Key")
	end
end
function GBasementItem(SIBasement)
	if SIBasement then
		if SIBasement == "Sword (Also Paid)" then
			print(Prefix, "User selected: ", SIBasement)
			RemoteEvents.BasementWeapon:FireServer(table.unpack({
				[1] = true,
				[2] = "Sword",
			}))
		elseif SIBasement == "Gun (Paid)" then
			print(Prefix, "User selected: ", SIBasement)
			RemoteEvents.BasementWeapon:FireServer(table.unpack({
				[1] = true,
				[2] = "Gun",
			}))
		elseif SIBasement == "LinkedSword" then
			RemoteEvents.BasementWeapon:FireServer(table.unpack({
				[1] = true,
				[2] = "LinkedSword",
			}))
		elseif SIBasement == "Machine Gun (Paid)" then
			RemoteEvents.BasementWeapon:FireServer(table.unpack({
				[1] = true,
				[2] = "SwatGun",
			}))
			print(Prefix, "User Selected A Item")
		end
	end
end
function getAllEndings()
	-- for i, v in pairs() do
	-- 	RemoteEvents.EggHuntEvent:FireServer(table.unpack({
	-- 		[1] = 1,
	-- 		[2] = "IcePart8",
	-- 	}))
	-- end
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Break In GUI | Kavo UI | " .. identifyexecutor() .. "", UITheme)
local PTab = Window:NewTab("Player")
local PSec = PTab:NewSection("Movement")

PSec:NewSlider("Walking Speed", "Changes your WalkSpeed", 89, 16, function(wSpeed) -- 500 (MaxValue) | 0 (MinValue)
	LocalPlayer.Humanoid.WalkSpeed = wSpeed
end)
PSec:NewSlider("Jump Height", "Makes you be able to jump Higher", 89, 16, function(jHeight)
	LocalPlayer.JumpPower = jHeight
end)
PSec:NewSlider("Hip Height", "Makes you walk higher", 89, 2.2, function(hHeight)
	if hHeight == 2 then
		p = game:GetService("Players").LocalPlayer.Character
		p:FindFirstChild("Humanoid").HipHeight = 2.2
	end
	p = game:GetService("Players").LocalPlayer.Character
	p:FindFirstChild("Humanoid").HipHeight = hHeight
end)
local ITab = Window:NewTab("Items")
local ISec = ITab:NewSection("Main")
local ISec2 = ITab:NewSection("Weapons")
local ISec3 = ITab:NewSection("Auto Pie")
local ISec4 = ITab:NewSection("Shop")
local GStuff = Window:NewTab("Game")
local GSec = GStuff:NewSection("Main")
local GSec2 = GStuff:NewSection("Teleports")
local GSec3 = GStuff:NewSection("Safe")
local GSec4 = GStuff:NewSection("Misc")
local GSec6 = GStuff:NewSection(--[[Name: ]] "Ending Stuff (WiP)")
local GSec5 = GStuff:NewSection("Door Toggle Thingy")
local GSec8 = GStuff:NewSection("Basement Things")
local GSec9 = GStuff:NewSection("Laggers")
local OUIs = Window:NewTab("Scripts & UIs")
local OUISec = OUIs:NewSection("Discord Lib Versions")
local OUISec2 = OUIs:NewSection("Other Scripts")
-- Auto Pie
ISec3:NewDropdown(
	"Auto Pie Type",
	"Select A Pie From the Dropdown",
	{ "Glazed Apple", "Bloxy Sludge", "Apple", "Cookie" },
	function(sPie)
		print(Prefix, "User selected:", sPie, "To be made with auto pie")
		SPKitchen = sPie
	end
)
ISec3:NewButton("Auto Pie", "Puts Ingredients In the Pan", function()
	-- Check AutoPieF in @ da functions comment
	AutoPieF(SPKitchen)
end)
GSec5:NewDropdown("Door To Toggle", "Select A Door To Be Toggled", {
	"Front",
	"Basement",
}, function(sDoor)
	print(Prefix, "User selected:", sDoor, "To be toggled")
	selectedDoor = sDoor
end)
GSec5:NewButton("Toggle Door", "Toggles The Selected Door", function()
	RemoteEvents.Door:FireServer(selectedDoor)
end)
ISec4:NewDropdown("Item to Buy", "Select A Pie From the Dropdown", {
	"Apple",
	"Cookie",
	"Med Kit",
	"Pan",
	"Cola",
	"Sewer Bloxy Cola",
}, function(sSitem)
	print(Prefix, "User selected:", sSitem, "To be purchased.")
	selectedShopItem = sSitem
end)

ISec4:NewButton("Purchase", "Buys the Item", function()
	doPurchaseItem(selectedShopItem)
end)
GSec4:NewButton("Anti Drown", "Stops the remote event from executing if args are empty", function()
	local AntiDrown
	AntiDrown = hookmetamethod(game, "__namecall", function(self, ...)
		local method = getnamecallmethod()
		local args = { ... }

		if
			not checkcaller() and self.Name == "Drown" and method == "FireServer"
			or self.Name == "Drown" and method == "FireServer" and not args[1]
		then
			return
		end
		return AntiDrown(self, ...)
	end)
end)
GSec4:NewButton("Attic Unlocker", "T", function()
	fireclickdetector(workspace.Basement.Ladder.ClickDetector)
end)
GSec4:NewButton("Attic Item Grabber", "T", function()
	getAtticItem()
end)
GSec4:NewButton("Anti Can'tGetUp", "Removes the Drown remote Event so It calls nil instead of the function", function()
	if not RemoteEvents:FindFirstChild("CantGetUp") then
		sGUI:SetCore("SendNotification", {
			Title = "Anti Can't Get Up",
			Duration = 3,
			Text = "Failed to find the event, you probably used anti can't get up already.",
		})
		return
	end
	RemoteEvents.CantGetUp:Destroy()
end)
GSec6:NewButton("Auto Win", "Auto Win for Final Ending", function()
	doAutoWin()
	task.wait(5)
end)
GSec6:NewButton("Cat", "The First step for getting the Ending", function() end)
GSec:NewButton("Collect All Money", "Collects All of the money", function()
	-- collectAllMoney()
	task.wait(5)
	print("Done")
end)
GSec4:NewButton("Apply All Enhancers", "Applies all of the Game Enhancers at once", function()
	doAllGameEnhancements()
end)
GSec4:NewButton("Anti KB", "Removes the KB remote Event so It calls nil instead of the function", function()
	-- for i, v in pairs(ReplicatedStorage:GetDescendants()) do
	-- 	if or v.Name == "Knockback" then
	-- 		v:Destroy()
	-- 		print("No More KB")
	-- 	end
	-- end
end)
GSec4:NewButton("Anti Fade", "Removes the Fade remote Event so It calls nil instead of the function", function()
	local Events = {
		RemoteEvents:FindFirstChild("FadeBlack"),
		RemoteEvents:FindFirstChild("FadeWhite"),
	}
	for _, event in Events do
		if not event then
			continue
		end
		event:Destroy()
	end
end)
runFn(function()
	local state = false
	local oldMat
	GSec4:NewToggle(
		"Anti Slip",
		"Hooks into the mat function and makes it do nothing. This reverses once you disable this.",
		function(newState)
			state = newState
			local iceScript = require(LocalPlayer.PlayerScripts.BlackIce)
			oldMat = iceScript.mat
			iceScript.mat = function() end
		end
	)
end)
runFn(function()
	local state = false

	GSec:NewToggle("Boss Aura", "Kills Bosses Around you", function(newState)
		state = newState
		if state then
			while state do
				RemoteEvents.HitEggBoss:FireServer()
				task.wait()
			end
		end
	end)
end)

GSec9:NewDropdown(
	"Lagger Type",
	"Select a Lagger Type to use",
	{ "Cat Tame Lagger", "Basement Lagger", "Ending Lagger (Not the best)" },
	function(sLgr)
		if sLgr == "Cat Tame Lagger" then
			selectedLagger = "Cat"
		elseif sLgr == "Basement Lagger" then
			selectedLagger = "Basement"
		elseif sLgr == "Ending Lagger (Not the best)" then
			selectedLagger = "Ending"
		end
	end
)
runFn(function()
	local state = false
	local SmallNotifs = require(LocalPlayer.PlayerScripts.SmallNotifications)
	local oldNewMessage = SmallNotifs.NewMessage

	GSec9:NewToggle(
		"Lagger",
		"Lags players (AND YOU) with constant remote event & Notification spamming",
		function(newState)
			state = newState
			if not state then
				SmallNotifs.NewMessage = oldNewMessage
				return
			end
			SmallNotifs.NewMessage = function() end
			while state do
				lag(selectedLagger)
				task.wait()
			end
		end
	)
end)
local TPOptions = {}
for _, v in TPs do
	table.insert(TPOptions, k)
end
GSec2:NewDropdown("Teleports", "Select A Teleport From the Dropdown", TPOptions, function(sTP)
	print(Prefix, "User selected:", sTP, "To Be Teleported To")
	selectedTP = sTP
end)
GSec3:NewButton("Find & Open Safe", "Finds the code, the safe, and opens the safe", function()
	openSafe()
end)
GSec2:NewButton("Teleport to Selected", "TPs you to the selected Location", function()
	if selectedTP then
		LocalPlayer.Character:PivotTo(TPs[selectedTP])
	end
end)
runFn(function()
	local state = false
	local BadGuys = {}
	local function handleBadGuy(badGuy)
		table.insert(BadGuys, badGuy)
		local c
		c = badGuy.Destroying:Connect(function()
			c:Disconnect()
			local index = table.find(BadGuys, badGuy)
			if not index then
				return
			end
			table.remove(BadGuys, index)
		end)
	end
	local conn
	GSec:NewToggle("Kill Aura", "Kills Bad Guys Around you", function(newState)
		state = newState
		if not state and conn then
			conn:Disconnect()
			BadGuys = {}
			return
		end
		for _, badGuy in workspace.BadGuys:GetChildren() do
			handleBadGuy(badGuy)
		end
		conn = workspace.BadGuys.ChildAdded:Connect(handleBadGuy)
		while state do
			task.wait()
			if #BadGuys <= 0 then
				continue
			end
			if #BadGuys > 1 then
				for _, badGuy in BadGuys do
					RemoteEvents.HitBadguy:FireServer(badGuy)
				end
			else
				RemoteEvents.HitBadguy:FireServer(BadGuys[1])
			end
		end
	end)
end)
OUISec2:NewButton("Vape V4", "Loads Vape V4 Script", function()
	loadstring(
		game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true)
	)()
end)
OUISec2:NewButton("Developer Scripts", "Loads Engospy", function()
	local settings = {
		saveCalls = false,
		maxCallsSaved = 1000,
		saveOnlyLastCall = true,
		maxTableDepth = 100,
		minimizeBind = Enum.KeyCode.RightAlt,
		newFunctionMethod = true,
		blacklistedNames = {},
	}
	loadstring(game:HttpGet("https://raw.githubusercontent.com/joeengo/engospy/main/source.lua"))(settings)
	-- loadstring(game:HttpGet("https://raw.githubusercontent.com/RealPacket/Position-Grabber/main/posGrabber"))()
end)
GSec:NewButton("Give Key", "Gives you the key for the Final ending", function()
	RemoteEvents.GetKeys:FireServer()
end)

GSec8:NewButton(
	"Unlock Basement",
	"Turns on the basement Lights and Unlocks the door by using Remote Events",
	function()
		RemoteEvents.BasementMission:FireServer()
		RemoteEvents.UnlockDoor:FireServer()
	end
)
ISec:NewDropdown(
	"Items",
	"Select a Item from here to give yourself",
	{ "Cookie", "Apple", "BloxyCola", "Pizza2", "Pizza3", "Planks", "Cure" },
	function(sItem)
		selectedItem = sItem
	end
)
ISec:NewButton("Give Item", "Gives the Current Selected Item Option from the dropdown", function()
	if selectedItem then
		giveItem(selectedItem)
	end
end)
ISec2:NewDropdown(
	"Weapon",
	"Drop down for Give Weapon button",
	{ "Gun (Paid)", "Sword (Also Paid)", "LinkedSword", "Machine Gun (Paid)" },
	function(WeaponBool)
		SIBasement = WeaponBool
		print(Prefix, "User selected:", WeaponBool)
	end
)
-- Button after the Dropdown
ISec2:NewButton("Give Weapon", "Gives you the Weapon that you selected from the dropdown above", function()
	GBasementItem(SIBasement)
	print(Prefix, "Gave User", SIBasement)
end)
