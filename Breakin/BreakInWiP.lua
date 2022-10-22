
--[[
	How To Use (as of 0.1):
	1. Inject your Executor (This script was made with krnl, ps to sakpot: what makes a Executor "Level <Insert Level Here> is actually the API, for example. what if I were to steal the API DLL from synapse X? I would get the same Level as Synapse X becuase the API is the Main thing that makes a Executor "Level 5", "Level 1" (How lol), "Level 9", "Level 10", or "Level 8", so next time, do a Synapse X API DLL giveaway instead of a Synapse X Giveaway)
	2. Use the UI to get a Item
	3. Enjoy!
	(if It doesn't work for Synapse X users then I'm sorry go cry that you prob wasted 20$ mainly on this script not watching a review (It will prob 100% work with Synapse X tho as KRNL API is dogshit and Synapse X is literally god tier lmao)
   List of things you can Give yourself (Item, Name):
   Pizza (Pizza1, Pizza2, Pizza3, Pizza4?)
   Bloxy Cola (BloxyCola)
   Apple (Apple) 
   Cookie (Cookie)
   Pies (Pie?)
   
   
   
]]






--Code for God Mode (Not really, but it kind of is (NOTE: You still can die from scarry larry, Falling in the sewer, and prob more. so its 40% a god mode but not a God Mode)
local GodMode = getgenv().Invincible
getgenv().Table = {
	Invincible = false

}
function GodMode()
    getgenv().Table.Invincible = false
	while getgenv().Table.Invincible == true do
	game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer("BloxyCola")
game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer("BloxyCola")
game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer("BloxyCola")
game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer("BloxyCola")
wait() -- to not lag your device
    game:GetService("ReplicatedStorage").RemoteEvents.Energy:FireServer(table.unpack({
    [1] = 16, --You can't change the values of the healing amount :(
    [2] = "BloxyCola",
}))
    game:GetService("ReplicatedStorage").RemoteEvents.Energy:FireServer(table.unpack({
    [1] = 15,
    [2] = "BloxyCola",
}))
game:GetService("ReplicatedStorage").RemoteEvents.Energy:FireServer(table.unpack({
    [1] = 16, 
    [2] = "BloxyCola",
}))
  end
 end
-- Give Item Function
function GiveItem(selectedItem)
	game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer(selectedItem)
end





-- Loop-Give Item Function
local loopGiveItem = false
function LoopGiveItem(selectedItem)
   while loopGiveItem == true do
	game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer(LSelectItem)   
   wait()
   end
end
function AUnclePete(IBool)
game:GetService("ReplicatedStorage").RemoteEvents.AddCrazy:FireServer(IBool)
end

















-- [[
--GUI (ignore)
local DiscordLib = loadstring(game:HttpGet "https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord")()
local win = DiscordLib:Window("Break in GUI")
local serv = win:Server("Main", "")
local UPete = serv:Channel("Uncle Pete Shit")
local IBoolSelection
UPete:Label("Automation for Uncle Pete")
UPete:Dropdown(
	"Item to add",
	{"BloxyCola", "Cookie", "Apple"},
	function(IBool)
	AUnclePete()
	print("User selected: ", IBool, "To be given to uncle pete")
	IBoolSelection = IBool
	end)
UPete:Button(
	"Add Item",
	function()
	-- This was generated from engospy RemoteSpy tool.
game:GetService("ReplicatedStorage").RemoteEvents.AddCrazy:FireServer(IBoolSelection)
print("Adding ", IBoolSelection, " To Uncle pete's thing bar")
	end)
local btns = serv:Channel("Buttons")
local tgls = serv:Channel("Toggles")

tgls:Toggle(
    "Killaura",
    false,
    function(bool)
	while bool == true do
		game:GetService("ReplicatedStorage").RemoteEvents.HitBadguy:FireServer(table.unpack({
    [1] = workspace.BadGuys[" "],
    [2] = 15,
}))
wait()
	end

        DiscordLib:Notification("Killaura", "Killaura doesn't work lmao", "Bruh")
    end
)
local GodModeEnabled = false
btns:Toggle(
    "GodMode",
	false,
    function()
    if GodModeEnabled == true then
		GodMode()
	getgenv().Table.Invincible = true
	end
	
        DiscordLib:Notification("Notification", "God Mode Enabled", "WTFFFF")
    end)

local sldrs = serv:Channel("Sliders")

local sldr =
    sldrs:Slider(
    "Slide me!",
    0,
    1000,
    400,
    function(t) -- replace with walkspeed later
       print("Value selected: ", t)
    end
)

sldrs:Button(
    "Change to 50",
    function()
        sldr:Change(50)
    end
)

local drops = serv:Channel("Items")
local selectedItem
local drop =
    drops:Dropdown(
    "Choose What Item you Want to get in the Dropdown",
    {"Cookie", "Apple", "BloxyCola", "Pizza1", "Pizza2", "Pizza3", "Planks"}, -- More coming soon...
    function(bool)
        print("User selected: ", bool);
		selectedItem = bool
    end)
drops:Button(
    "Give Item",
	function()
	if selectedItem then
	GiveItem(selectedItem)
	DiscordLib:Notification("Notification", "Gave you the selected Item!", "Ok!")
	else
	DiscordLib:Notification("Notification", "You Did not select a Item!", "Ok! I will go select a Item")
	end
   end)
   local LselectedItem
 drops:Dropdown(
	 "Choose What Item you Want to loop-give yourself in the Dialog",
    {"Cookie", "Apple", "BloxyCola", "Pizza2", "Planks"}, -- More coming soon...
    function(bool2)
        print("User selected: ", bool2);
		LselectedItem = bool2
        loopGiveItem = true
		LoopGiveItem(LselectedItem)
		end
 )
	drops:Button(
		"Loop-Give Item",
		function(bool2)
			print("User Selected: ", bool2, " To be loop-given to them")
			LoopGiveItem(LselectedItem)
		end)
		drops:Dropdown(
			"Weapon Give (No need to press a button)",
			{"Bat", "Hammer", "Sword", "Gun", "LinkedSword", "MGun"},
			function(WBool)
			   print("User selected: ", WBool)
game:GetService("ReplicatedStorage").RemoteEvents.BasementWeapon:FireServer(table.unpack({
    [1] = true,
    [2] = WBool,
}))
			end
		)



local clrs = serv:Channel("Colorpickers")

clrs:Colorpicker(
    "ESP Color",
    Color3.fromRGB(255, 1, 1),
    function(t)
        print(t)
    end
)

local textbs = serv:Channel("Textboxes")

textbs:Textbox(
    "Gun power",
    "Type here!",
    true,
    function(t)
        print(t)
    end)
    local RBuy = serv:Channel("Buy Items")
    RBuy:Button(
        "Buy Pie Dish",
        function()
game:GetService("ReplicatedStorage").RemoteEvents.BuyItem:FireServer("Pan")
DiscordLib:Notification("Notification", "Bought Pie Dish!", "Ok!")
        end)
		RBuy:Button(
			"Buy MedKit",
			function()
				
game:GetService("ReplicatedStorage").RemoteEvents.BuyItem:FireServer("MedKit")
DiscordLib:Notification("Notification", "Bought MedKit", "Ok!")
			end)
			RBuy:Button(
			"Buy BloxyCola",
			function()
				
game:GetService("ReplicatedStorage").RemoteEvents.BuyItem:FireServer("BloxyCola")
DiscordLib:Notification("Notification", "Bought BloxyCola", "Ok!")
			end)
			RBuy:Button(
				"Buy Expired Bloxy Cola (from the sewer)",
				function()
game:GetService("ReplicatedStorage").RemoteEvents.BuyItem:FireServer("ExpiredBloxyCola")
				end
			)
local other = serv:Channel("Other Scripts")
other:Label("This is where scripts that inhance your experience alot are here")
other:Button(
	"Vape V4 Script",
	function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
	DiscordLib:Notification("Notification", "Vape V4 Loaded", "Thanks!")
	end)
	other:Button(
	"Engo spy (For devs)",
	function()
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
	DiscordLib:Notification("Notification", "Engospy loaded (for devs, test out if u want)", "Thanks!")
	end)
	local test = serv:Channel("Tests")
	test:Label("Tests for the script")
	test:Button(
		"yes",
		function()
game:GetService("ReplicatedStorage").RemoteEvents.DoDialogue:FireServer(table.unpack({
    [1] = 239,
    [2] = true,
}))
		end)
		test:Button(
			"Auto Basement Lights",
			function()
game:GetService("ReplicatedStorage").RemoteEvents.BasementMission:FireServer()
			end
		)
	test:Button(
		"Auto Key",
		function()
 game:GetService("ReplicatedStorage").RemoteEvents.GetKeys:FireServer()
		end
	)
	test:Button(
		"Allow Free Respawn",
		function()
			print("This is supposed to make you be able to respawn for free")
			DiscordLib:Notification("Allow Free Respawn", "This module doesn't work due to me not having Synapse X for dark hub so I can decompile scripts", "Bruh")
		end)
		test:Button(
			"Make Stealthy without kit (Doesn't work lol)",
			function()
game:GetService("ReplicatedStorage").RemoteEvents.MakeStealth:FireServer(20)
				end)
                    test:Button(
                        "MoneyThingy",
                        function()
game:GetService("ReplicatedStorage").RemoteEvents.FoundMoney:FireServer(workspace.Money2)
game:GetService("ReplicatedStorage").RemoteEvents.FoundMoney:FireServer(workspace.Money3)
game:GetService("ReplicatedStorage").RemoteEvents.FoundMoney:FireServer(workspace.Money3)
game:GetService("ReplicatedStorage").RemoteEvents.FoundMoney:FireServer(workspace.Money3)
game:GetService("ReplicatedStorage").RemoteEvents.FoundMoney:FireServer(workspace.Money3)
game:GetService("ReplicatedStorage").RemoteEvents.FoundMoney:FireServer(workspace.Money3)
game:GetService("ReplicatedStorage").RemoteEvents.FoundMoney:FireServer(workspace.Money3)
game:GetService("ReplicatedStorage").RemoteEvents.FoundMoney:FireServer(workspace.Money3)
game:GetService("ReplicatedStorage").RemoteEvents.FoundMoney:FireServer(workspace.Money3)
game:GetService("ReplicatedStorage").RemoteEvents.FoundMoney:FireServer(workspace.Money3)
game:GetService("ReplicatedStorage").RemoteEvents.FoundMoney:FireServer(workspace.Money3)

                        end)
			local TPs = serv:Channel("Teleports [WiP]")
			local f = serv:Channel("Mansion Ending shit")
			f:Button(
				"Destroy Scary larry's house",
				function()
				wait()
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)
wait()
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bannister1)
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bannister3)
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bannister2)
wait(2)
wait()
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Couch)
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)
wait()
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Mirror)
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
wait()
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
wait()
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
wait()
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)
wait()
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)
wait()
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)
wait()
-- This was generated from engospy RemoteSpy tool.

--Call #1:
wait()
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)
wait()
--Call #2:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bannister1)

--Call #3:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bannister3)

--Call #4:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bannister2)

--Call #5:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Couch)

--Call #6:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)
wait()
--Call #7:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #8:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Mirror)

--Call #9:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
wait()
--Call #10:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #11:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
wait()
--Call #12:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
wait()
--Call #13:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #14:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
wait()
--Call #15:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
wait()
--Call #16:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #17:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #18:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)
wait()
--Call #19:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)
wait()
--Call #20:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bannister1)
wait()
--Call #21:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bannister3)

--Call #22:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bannister2)
wait()
--Call #23:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)

--Call #24:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)

--Call #25:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)
wait()
--Call #26:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)
wait()
--Call #27:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Couch)

--Call #28:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #29:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #30:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Mirror)

--Call #31:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #32:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #33:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)
wait()
--Call #34:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #35:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #36:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #37:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #38:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #39:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #40:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)

--Call #41:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)

--Call #42:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)
wait()
--Call #43:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)

--Call #44:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)

--Call #45:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)

--Call #46:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Vase)

--Call #47:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)

--Call #48:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)

--Call #49:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bannister3)
wait()
--Call #50:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bannister1)

--Call #51:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)

--Call #52:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)

--Call #53:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #54:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #55:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Fridge)

--Call #56:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)
wait()
--Call #57:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #58:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #59:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #60:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Vase)
wait()
--Call #61:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)

--Call #62:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bannister1)

--Call #63:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #64:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bannister2)

--Call #65:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)
wait()
--Call #66:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #67:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #68:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #69:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.CardboardBoxOpen)

--Call #70:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Pants)

--Call #71:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)
wait()
--Call #72:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Vase)

--Call #73:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Vase)

--Call #74:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)

--Call #75:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)

--Call #76:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)

--Call #77:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Vase)

--Call #78:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)
wait()
--Call #79:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #80:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #81:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Vase)

--Call #82:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)

--Call #83:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)

--Call #84:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Vase)

--Call #85:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)

--Call #86:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Vase)

--Call #87:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Vase)

--Call #88:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)

--Call #89:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)
wait()
--Call #90:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Vase)

--Call #91:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)

--Call #92:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)

--Call #93:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)

--Call #94:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #95:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.SmallTable)

--Call #96:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.SmallTable)
wait()
--Call #97:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)

--Call #98:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)

--Call #99:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #100:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #101:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #102:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #103:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #104:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Vase)

--Call #105:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)

--Call #106:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)
wait()
--Call #107:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)

--Call #108:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)

--Call #109:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)

--Call #110:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)
wait()
--Call #111:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Couch)

--Call #112:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.VaseStand)

--Call #113:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Couch)

--Call #114:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Couch)
wait()
--Call #115:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Couch)

--Call #116:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Couch)

--Call #117:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #118:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.SmallTable)

--Call #119:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.SmallTable)

--Call #120:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #121:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #122:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)
wait()
--Call #123:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #124:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Painting)

--Call #125:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bed)
wait()
--Call #126:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bed)

--Call #127:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bed)

--Call #128:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.BadGuy)

--Call #129:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bed)

--Call #130:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bed)

--Call #131:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bed)

--Call #132:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bed)

--Call #133:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bed)

--Call #134:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bed)

--Call #135:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bed)

--Call #136:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bed)

--Call #137:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.SmallTable)

--Call #138:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.BadGuy)
wait()
--Call #139:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bed)

--Call #140:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #141:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #142:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #143:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.SmallTable)

--Call #144:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Bed)
wait()
--Call #145:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #146:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.BadGuy)

--Call #147:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #148:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #149:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #150:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #151:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #152:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #153:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #154:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #155:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #156:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #157:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #158:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)
wait()
--Call #159:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #160:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #161:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #162:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #163:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #164:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #165:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #166:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #167:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #168:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)
wait()
--Call #169:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #170:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #171:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #172:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #173:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #174:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #175:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #176:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)
wait()
--Call #177:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #178:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #179:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)
wait()
--Call #180:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #181:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Window)

--Call #182:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #183:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #184:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Fountain)

--Call #185:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #186:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)
wait()
--Call #187:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #188:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #189:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #190:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #191:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #192:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #193:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #194:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #195:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #196:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #197:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #198:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #199:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #200:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #201:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #202:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #203:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #204:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #205:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #206:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #207:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #208:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #209:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #210:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #211:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #212:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #213:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #214:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #215:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #216:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #217:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #218:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #219:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #220:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #221:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #222:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Plantpot)

--Call #223:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #224:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #225:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #226:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #227:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #228:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #229:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #230:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #231:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #232:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)
wait()
--Call #233:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #234:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #235:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #236:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #237:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #238:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #239:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #240:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)
wait()
--Call #241:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #242:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #243:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #244:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #245:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #246:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Gate)

--Call #247:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Rose)

--Call #248:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.GoldKey)

--Call #249:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.CardboardBoxOpen)
wait()
--Call #250:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.GoldKey)

--Call #251:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.GoldKey)

--Call #252:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.RandomTable)
wait()
--Call #253:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.GoldKey)

--Call #254:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.RandomTable)

--Call #255:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.YellowBucket)
wait()
--Call #256:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.CardboardBoxOpen)

--Call #257:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.RandomTable)

--Call #258:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.GoldKey)

--Call #259:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.GoldKey)

--Call #260:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.GoldKey)

--Call #261:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.YellowBucket)

--Call #262:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.RandomTable)

--Call #263:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.FridgeDoor)

--Call #264:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #265:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.FridgeDoor)

--Call #266:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #267:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #268:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #269:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #270:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #271:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #272:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.FridgeDoor)

--Call #273:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.DiningTable)

--Call #274:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Fan)

--Call #275:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Drawer)

--Call #276:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #277:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.OvenWindow)

--Call #278:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #279:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #280:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Drawer)

--Call #281:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Fan)

--Call #282:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.OvenWindow)

--Call #283:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #284:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Fridge)

--Call #285:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Drawer)

--Call #286:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Fan)

--Call #287:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Fridge)

--Call #288:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Fridge)

--Call #289:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.FridgeDoor)

--Call #290:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.PizzaBox)

--Call #291:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.FridgeDoor)

--Call #292:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.OvenWindow)

--Call #293:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Fridge)

--Call #294:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Vase)

--Call #295:
game:GetService("ReplicatedStorage").RemoteEvents.MansionHit:FireServer(workspace.LarrysHouse.Destructable.Chandelier)

					DiscordLib:Notification("NOTE:", "This is WiP, that means. This might not be the best, but will be able to knock out like ~40-50 Items. Don't expect alot from it.", "Ok!")
				end
			)
			local other2 = serv:Channel("Auto Pie")
			other2:Label("Automatically puts the Ingredients in the pie dish")
			other2:Button(
				"Bloxy Sludge",
				function()
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("BloxyCola")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("BloxyCola")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("BloxyCola")
DiscordLib:Notification("AutoPie", "Bloxy Sludge Pie ingredients should have been put into the Pie if you have a pie dish", "Thanks!")
				end)
				other2:Button(
					"Apple",
					function()
						game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("BloxyCola")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Apple")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Apple")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Apple")
					end)
					other2:Button(
					"Cookie",
					function()
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Cookie")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Cookie")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Cookie")
game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Cookie")
					end)
					other2:Button(
						"Glazed Apple",
						function()
						game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("Apple")
						game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("BloxyCola")
						game:GetService("ReplicatedStorage").RemoteEvents.AddIngredient:FireServer("BloxyCola")
						end)
						local Boarding = serv:Channel("Useless Boarding")
						Boarding:Label("For Boarding up the house (doesn't work)")
						Boarding:Button(
							"Good",
							function()
								-- This was generated from engospy RemoteSpy tool.

--Call #1:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-11.456995, 21.5984612, -174.116989, 4.37113883e-08, -3.82137093e-15, 1, -8.74227766e-08, -1, 0, 1, -8.74227766e-08, -4.37113883e-08),
    [2] = workspace.TheHouse.ww1,
}))

--Call #2:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-11.281004, 22.2050343, -174.116989, 4.37113883e-08, -0.909297407, -0.416146845, -8.74227766e-08, 0.416146845, -0.909297407, 1, 7.6127364e-08, -6.13029485e-08),
    [2] = workspace.TheHouse.ww1,
}))
wait()
--Call #3:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-11.3182507, 21.4950905, -174.116989, 4.37113883e-08, -0.279415488, 0.960170269, -8.74227766e-08, -0.960170269, -0.279415488, 1, -7.17271078e-08, -6.63976536e-08),
    [2] = workspace.TheHouse.ww1,
}))

--Call #4:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-11.3134155, 21.4438133, -174.116989, 4.37113883e-08, -0.958924294, 0.2836622, -8.74227766e-08, -0.2836622, -0.958924294, 1, 1.71173742e-08, -9.62310907e-08),
    [2] = workspace.TheHouse.ww1,
}))

--Call #5:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-11.3419485, 21.4624691, -174.116989, 4.37113883e-08, 0.756802499, -0.653643608, -8.74227766e-08, 0.653643608, 0.756802499, 1, 2.40624516e-08, 9.47334442e-08),
    [2] = workspace.TheHouse.ww1,
}))

--Call #6:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-11.3088398, 21.5192814, -174.116989, 4.37113883e-08, -0.756802499, -0.653643608, -8.74227766e-08, 0.653643608, -0.756802499, 1, 9.02242263e-08, -3.75901053e-08),
    [2] = workspace.TheHouse.ww1,
}))

--Call #7:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-11.446373, 21.4823914, -174.116989, 4.37113883e-08, -3.82137093e-15, 1, -8.74227766e-08, -1, 0, 1, -8.74227766e-08, -4.37113883e-08),
    [2] = workspace.TheHouse.ww1,
}))

--Call #8:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-11.3517036, 21.6372318, -174.116989, 4.37113883e-08, 0.958924294, 0.2836622, -8.74227766e-08, -0.2836622, 0.958924294, 1, -6.67144491e-08, 7.14325523e-08),
    [2] = workspace.TheHouse.ww1,
}))
wait()
--Call #9:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-11.4131374, 21.4642296, -174.116989, 4.37113883e-08, -0.909297407, -0.416146845, -8.74227766e-08, 0.416146845, -0.909297407, 1, 7.6127364e-08, -6.13029485e-08),
    [2] = workspace.TheHouse.ww1,
}))

--Call #10:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-11.0462837, 21.8190193, -174.116989, 4.37113883e-08, -0.841470957, 0.540302277, -8.74227766e-08, -0.540302277, -0.841470957, 1, -1.04528617e-08, -9.71810863e-08),
    [2] = workspace.TheHouse.ww1,
}))

--Call #11:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-22.3443203, 17.6190414, -192.682007, -8.74227766e-08, 0.989992499, -0.141120002, -1, -9.27164407e-08, -3.0936846e-08, -4.37113883e-08, 0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))
wait()
--Call #12:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-21.9667244, 17.5792599, -192.449997, -4.37113883e-08, 0.958924294, -0.2836622, -8.74227766e-08, -0.2836622, -0.958924294, -1, -1.71173742e-08, 9.62310907e-08),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #13:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-22.4921055, 17.6190414, -192.495239, -8.74227766e-08, 0.653643608, 0.756802499, -1, -2.40624516e-08, -9.47334442e-08, -4.37113883e-08, -0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #14:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-22.5009727, 17.6190414, -192.52742, -8.74227766e-08, -0.2836622, 0.958924294, -1, 6.67144491e-08, -7.14325523e-08, -4.37113883e-08, -0.958924294, -0.2836622),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #15:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-23.1368732, 17.6190414, -192.728485, -8.74227766e-08, -0.540302277, 0.841470957, -1, 8.4016591e-08, -4.99463653e-08, -4.37113883e-08, -0.841470957, -0.540302277),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #16:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-23.1147881, 17.6190414, -192.675613, -8.74227766e-08, 0.653643608, 0.756802499, -1, -2.40624516e-08, -9.47334442e-08, -4.37113883e-08, -0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #17:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-23.0906391, 17.6190414, -192.68132, -8.74227766e-08, -0.960170269, 0.279415488, -1, 9.61543876e-08, 1.75430959e-08, -4.37113883e-08, -0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))
wait()
--Call #18:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-22.981308, 17.6190414, -192.663239, -8.74227766e-08, 0.416146845, -0.909297407, -1, -7.6127364e-08, 6.13029485e-08, -4.37113883e-08, 0.909297407, 0.416146845),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #19:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-22.9194126, 17.6190414, -192.652771, -8.74227766e-08, -0.960170269, 0.279415488, -1, 9.61543876e-08, 1.75430959e-08, -4.37113883e-08, -0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #20:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-22.8975182, 17.6190414, -192.672165, -8.74227766e-08, 0.653643608, 0.756802499, -1, -2.40624516e-08, -9.47334442e-08, -4.37113883e-08, -0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #21:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-22.5416565, 17.6190414, -192.934708, -8.74227766e-08, -1, 0, -1, 8.74227766e-08, 4.37113883e-08, -4.37113883e-08, 3.82137093e-15, -1),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #22:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-22.170187, 17.6190414, -194.671555, -8.74227766e-08, 0.989992499, 0.141120002, -1, -8.03793441e-08, -5.56110464e-08, -4.37113883e-08, -0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #23:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-22.7777023, 17.6190414, -193.989197, -8.74227766e-08, 0.653643608, -0.756802499, -1, -9.02242263e-08, 3.75901053e-08, -4.37113883e-08, 0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #24:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-22.67033, 17.6190414, -193.928604, -8.74227766e-08, -0.960170269, 0.279415488, -1, 9.61543876e-08, 1.75430959e-08, -4.37113883e-08, -0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))
wait()
--Call #25:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-23.3896217, 17.6190414, -193.362106, -8.74227766e-08, -0.540302277, -0.841470957, -1, 1.04528617e-08, 9.71810863e-08, -4.37113883e-08, 0.841470957, -0.540302277),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #26:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-22.0344238, 17.6190414, -193.933609, -8.74227766e-08, -1, 0, -1, 8.74227766e-08, 4.37113883e-08, -4.37113883e-08, 3.82137093e-15, -1),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #27:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-23.5013046, 17.6190414, -193.501343, -8.74227766e-08, 0.653643608, 0.756802499, -1, -2.40624516e-08, -9.47334442e-08, -4.37113883e-08, -0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #28:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-23.399704, 17.6190414, -193.562836, -8.74227766e-08, 0.416146845, -0.909297407, -1, -7.6127364e-08, 6.13029485e-08, -4.37113883e-08, 0.909297407, 0.416146845),
    [2] = workspace.TheHouse.Toilet.ToiletSeat2,
}))

--Call #29:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 22.1221657, -198.190308, 1, -7.17271078e-08, -6.63976536e-08, -8.74227766e-08, -0.960170269, -0.279415488, -4.37113883e-08, 0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #30:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 21.9983158, -197.357391, 1, -6.67144491e-08, 7.14325523e-08, -8.74227766e-08, -0.2836622, 0.958924294, -4.37113883e-08, -0.958924294, -0.2836622),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #31:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 21.9651451, -221.551956, 1, -8.4016591e-08, 4.99463653e-08, -8.74227766e-08, -0.540302277, 0.841470957, -4.37113883e-08, -0.841470957, -0.540302277),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #32:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.6082516, -221.995438, 1, 8.03793441e-08, 5.56110464e-08, -8.74227766e-08, 0.989992499, 0.141120002, -4.37113883e-08, -0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #33:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.1260262, -220.931717, 1, -8.4016591e-08, 4.99463653e-08, -8.74227766e-08, -0.540302277, 0.841470957, -4.37113883e-08, -0.841470957, -0.540302277),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #34:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.2209759, -220.945816, 1, -3.36594042e-09, 9.76836603e-08, -8.74227766e-08, 0.416146845, 0.909297407, -4.37113883e-08, -0.909297407, 0.416146845),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #35:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.2165184, -220.951904, 1, -1.04528617e-08, -9.71810863e-08, -8.74227766e-08, -0.540302277, -0.841470957, -4.37113883e-08, 0.841470957, -0.540302277),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #36:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.0952492, -220.859894, 1, 1.71173742e-08, -9.62310907e-08, -8.74227766e-08, -0.2836622, -0.958924294, -4.37113883e-08, 0.958924294, -0.2836622),
    [2] = workspace.TheHouse.Windo2,
}))
wait()
--Call #37:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.6513691, -221.157837, 1, 9.02242263e-08, -3.75901053e-08, -8.74227766e-08, 0.653643608, -0.756802499, -4.37113883e-08, 0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #38:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.5115738, -221.07074, 1, -8.74227766e-08, -4.37113883e-08, -8.74227766e-08, -1, 0, -4.37113883e-08, 3.82137093e-15, -1),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #39:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.5340824, -221.118454, 1, -8.4016591e-08, 4.99463653e-08, -8.74227766e-08, -0.540302277, 0.841470957, -4.37113883e-08, -0.841470957, -0.540302277),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #40:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.0578346, -220.841141, 1, -8.74227766e-08, -4.37113883e-08, -8.74227766e-08, -1, 0, -4.37113883e-08, 3.82137093e-15, -1),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #41:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 21.8301716, -231.295288, 1, 9.27164407e-08, 3.0936846e-08, -8.74227766e-08, 0.989992499, -0.141120002, -4.37113883e-08, 0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Part,
}))
wait()
--Call #42:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 21.6689816, -231.186905, 1, 9.27164407e-08, 3.0936846e-08, -8.74227766e-08, 0.989992499, -0.141120002, -4.37113883e-08, 0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Part,
}))
wait()
--Call #43:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 20.2573318, -231.376266, 1, 7.6127364e-08, -6.13029485e-08, -8.74227766e-08, 0.416146845, -0.909297407, -4.37113883e-08, 0.909297407, 0.416146845),
    [2] = workspace.TheHouse.Part,
}))

--Call #44:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 19.4820385, -231.666138, 1, 1.71173742e-08, -9.62310907e-08, -8.74227766e-08, -0.2836622, -0.958924294, -4.37113883e-08, 0.958924294, -0.2836622),
    [2] = workspace.TheHouse.Part,
}))
wait()
--Call #45:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 19.1122742, -231.801392, 1, -6.67144491e-08, 7.14325523e-08, -8.74227766e-08, -0.2836622, 0.958924294, -4.37113883e-08, -0.958924294, -0.2836622),
    [2] = workspace.TheHouse.Part,
}))

--Call #46:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 19.0874443, -231.745239, 1, 2.40624516e-08, 9.47334442e-08, -8.74227766e-08, 0.653643608, 0.756802499, -4.37113883e-08, -0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Part,
}))

--Call #47:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 19.1868153, -231.779312, 1, -3.36594042e-09, 9.76836603e-08, -8.74227766e-08, 0.416146845, 0.909297407, -4.37113883e-08, -0.909297407, 0.416146845),
    [2] = workspace.TheHouse.Part,
}))
wait()
--Call #48:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 19.3452072, -232.060944, 1, -7.17271078e-08, -6.63976536e-08, -8.74227766e-08, -0.960170269, -0.279415488, -4.37113883e-08, 0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Part,
}))
wait()
--Call #49:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 18.9739914, -231.707047, 1, 9.02242263e-08, -3.75901053e-08, -8.74227766e-08, 0.653643608, -0.756802499, -4.37113883e-08, 0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Part,
}))

--Call #50:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 20.9021626, -231.808945, 1, 8.03793441e-08, 5.56110464e-08, -8.74227766e-08, 0.989992499, 0.141120002, -4.37113883e-08, -0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Part,
}))

--Call #51:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567307, 21.7591801, -230.346741, -1, -7.6127364e-08, 6.13029485e-08, -8.74227766e-08, 0.416146845, -0.909297407, 4.37113883e-08, -0.909297407, -0.416146845),
    [2] = workspace.TheHouse.Part,
}))

--Call #52:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567307, 21.7702236, -229.695694, -1, 8.74227766e-08, 4.37113883e-08, -8.74227766e-08, -1, 0, 4.37113883e-08, -3.82137093e-15, 1),
    [2] = workspace.TheHouse.Part,
}))
wait()
--Call #53:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567307, 21.702734, -229.739594, -1, 1.04528617e-08, 9.71810863e-08, -8.74227766e-08, -0.540302277, -0.841470957, 4.37113883e-08, -0.841470957, 0.540302277),
    [2] = workspace.TheHouse.Part,
}))

--Call #54:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567307, 21.7207661, -229.728546, -1, 8.74227766e-08, 4.37113883e-08, -8.74227766e-08, -1, 0, 4.37113883e-08, -3.82137093e-15, 1),
    [2] = workspace.TheHouse.Part,
}))

--Call #55:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567307, 21.7567101, -229.703201, -1, -8.03793441e-08, -5.56110464e-08, -8.74227766e-08, 0.989992499, 0.141120002, 4.37113883e-08, 0.141120002, -0.989992499),
    [2] = workspace.TheHouse.Part,
}))

--Call #56:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567307, 23.0792446, -228.904083, -1, -7.6127364e-08, 6.13029485e-08, -8.74227766e-08, 0.416146845, -0.909297407, 4.37113883e-08, -0.909297407, -0.416146845),
    [2] = workspace.TheHouse.Part,
}))

--Call #57:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567307, 21.7480469, -229.679886, -1, -8.03793441e-08, -5.56110464e-08, -8.74227766e-08, 0.989992499, 0.141120002, 4.37113883e-08, 0.141120002, -0.989992499),
    [2] = workspace.TheHouse.Part,
}))

--Call #58:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567307, 22.003643, -229.497772, -1, -8.03793441e-08, -5.56110464e-08, -8.74227766e-08, 0.989992499, 0.141120002, 4.37113883e-08, 0.141120002, -0.989992499),
    [2] = workspace.TheHouse.Part,
}))
wait()
--Call #59:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567307, 21.8185158, -229.576584, -1, 1.04528617e-08, 9.71810863e-08, -8.74227766e-08, -0.540302277, -0.841470957, 4.37113883e-08, -0.841470957, 0.540302277),
    [2] = workspace.TheHouse.Part,
}))

--Call #60:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567307, 22.3062611, -229.359772, -1, -2.40624516e-08, -9.47334442e-08, -8.74227766e-08, 0.653643608, 0.756802499, 4.37113883e-08, 0.756802499, -0.653643608),
    [2] = workspace.TheHouse.Part,
}))

--Call #61:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567535, 23.663763, -194.984604, -1, -8.03793441e-08, -5.56110464e-08, -8.74227766e-08, 0.989992499, 0.141120002, 4.37113883e-08, 0.141120002, -0.989992499),
    [2] = workspace.TheHouse.Windo1,
}))

--Call #62:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567535, 25.0903149, -193.405182, -1, 3.36594042e-09, -9.76836603e-08, -8.74227766e-08, 0.416146845, 0.909297407, 4.37113883e-08, 0.909297407, -0.416146845),
    [2] = workspace.TheHouse.Windo1,
}))

--Call #63:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567535, 23.8383179, -193.826447, -1, -9.27164407e-08, -3.0936846e-08, -8.74227766e-08, 0.989992499, -0.141120002, 4.37113883e-08, -0.141120002, -0.989992499),
    [2] = workspace.TheHouse.Windo1,
}))
wait()
--Call #64:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567535, 21.4843025, -194.201126, -1, 3.36594042e-09, -9.76836603e-08, -8.74227766e-08, 0.416146845, 0.909297407, 4.37113883e-08, 0.909297407, -0.416146845),
    [2] = workspace.TheHouse.Windo1,
}))

--Call #65:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567535, 18.5654716, -193.46431, -1, 3.36594042e-09, -9.76836603e-08, -8.74227766e-08, 0.416146845, 0.909297407, 4.37113883e-08, 0.909297407, -0.416146845),
    [2] = workspace.TheHouse.Windo1,
}))
wait()
--Call #66:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567535, 19.540905, -194.430527, -1, -7.6127364e-08, 6.13029485e-08, -8.74227766e-08, 0.416146845, -0.909297407, 4.37113883e-08, -0.909297407, -0.416146845),
    [2] = workspace.TheHouse.Windo1,
}))

--Call #67:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567535, 20.607132, -195.219086, -1, -9.27164407e-08, -3.0936846e-08, -8.74227766e-08, 0.989992499, -0.141120002, 4.37113883e-08, -0.141120002, -0.989992499),
    [2] = workspace.TheHouse.Windo1,
}))
wait()
--Call #68:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567535, 22.3229599, -195.380249, -1, 1.04528617e-08, 9.71810863e-08, -8.74227766e-08, -0.540302277, -0.841470957, 4.37113883e-08, -0.841470957, 0.540302277),
    [2] = workspace.TheHouse.Windo1,
}))

--Call #69:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567535, 23.4311104, -195.674316, -1, 1.04528617e-08, 9.71810863e-08, -8.74227766e-08, -0.540302277, -0.841470957, 4.37113883e-08, -0.841470957, 0.540302277),
    [2] = workspace.TheHouse.Windo1,
}))

--Call #70:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.1567535, 23.4495735, -196.328186, -1, 8.4016591e-08, -4.99463653e-08, -8.74227766e-08, -0.540302277, 0.841470957, 4.37113883e-08, 0.841470957, 0.540302277),
    [2] = workspace.TheHouse.Windo1,
}))

--Call #71:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 21.0241966, -195.696304, 1, 8.03793441e-08, 5.56110464e-08, -8.74227766e-08, 0.989992499, 0.141120002, -4.37113883e-08, -0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #72:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 21.1565838, -195.898743, 1, 1.71173742e-08, -9.62310907e-08, -8.74227766e-08, -0.2836622, -0.958924294, -4.37113883e-08, 0.958924294, -0.2836622),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #73:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 20.7006721, -196.098572, 1, 9.02242263e-08, -3.75901053e-08, -8.74227766e-08, 0.653643608, -0.756802499, -4.37113883e-08, 0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #74:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 20.7948799, -196.126938, 1, -3.36594042e-09, 9.76836603e-08, -8.74227766e-08, 0.416146845, 0.909297407, -4.37113883e-08, -0.909297407, 0.416146845),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #75:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 20.5688324, -196.686417, 1, -7.17271078e-08, -6.63976536e-08, -8.74227766e-08, -0.960170269, -0.279415488, -4.37113883e-08, 0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Windo4,
}))
wait()
--Call #76:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 20.5943375, -197.521561, 1, -9.61543876e-08, -1.75430959e-08, -8.74227766e-08, -0.960170269, 0.279415488, -4.37113883e-08, -0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #77:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 20.5986004, -197.524979, 1, 9.27164407e-08, 3.0936846e-08, -8.74227766e-08, 0.989992499, -0.141120002, -4.37113883e-08, 0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #78:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 20.594017, -197.558533, 1, 9.27164407e-08, 3.0936846e-08, -8.74227766e-08, 0.989992499, -0.141120002, -4.37113883e-08, 0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #79:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 19.6672344, -198.411743, 1, -8.74227766e-08, -4.37113883e-08, -8.74227766e-08, -1, 0, -4.37113883e-08, 3.82137093e-15, -1),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #80:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 21.0929947, -196.787888, 1, -7.17271078e-08, -6.63976536e-08, -8.74227766e-08, -0.960170269, -0.279415488, -4.37113883e-08, 0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Windo4,
}))
wait()
--Call #81:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(17.7129402, 21.8271503, -178.129227, 4.37113883e-08, -0.756802499, -0.653643608, -8.74227766e-08, 0.653643608, -0.756802499, 1, 9.02242263e-08, -3.75901053e-08),
    [2] = workspace.TheHouse.Windo3,
}))

--Call #82:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(17.7414818, 21.8607101, -178.129227, 4.37113883e-08, 0.909297407, -0.416146845, -8.74227766e-08, 0.416146845, 0.909297407, 1, -3.36594042e-09, 9.76836603e-08),
    [2] = workspace.TheHouse.Windo3,
}))

--Call #83:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(17.6513882, 21.8664856, -178.129227, 4.37113883e-08, -3.82137093e-15, 1, -8.74227766e-08, -1, 0, 1, -8.74227766e-08, -4.37113883e-08),
    [2] = workspace.TheHouse.Windo3,
}))
wait()
--Call #84:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(17.6746674, 21.9063416, -178.129227, 4.37113883e-08, -0.909297407, -0.416146845, -8.74227766e-08, 0.416146845, -0.909297407, 1, 7.6127364e-08, -6.13029485e-08),
    [2] = workspace.TheHouse.Windo3,
}))

--Call #85:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(18.0809212, 22.3910599, -178.129227, 4.37113883e-08, 0.841470957, 0.540302277, -8.74227766e-08, -0.540302277, 0.841470957, 1, -8.4016591e-08, 4.99463653e-08),
    [2] = workspace.TheHouse.Windo3,
}))
wait()
--Call #86:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(17.9895287, 22.2342796, -178.129227, 4.37113883e-08, 0.141120002, -0.989992499, -8.74227766e-08, 0.989992499, 0.141120002, 1, 8.03793441e-08, 5.56110464e-08),
    [2] = workspace.TheHouse.Windo3,
}))

--Call #87:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(17.7819824, 21.929121, -178.129227, 4.37113883e-08, -3.82137093e-15, 1, -8.74227766e-08, -1, 0, 1, -8.74227766e-08, -4.37113883e-08),
    [2] = workspace.TheHouse.Windo3,
}))

--Call #88:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(17.3379135, 21.0321064, -178.129227, 4.37113883e-08, -0.909297407, -0.416146845, -8.74227766e-08, 0.416146845, -0.909297407, 1, 7.6127364e-08, -6.13029485e-08),
    [2] = workspace.TheHouse.Windo3,
}))
wait()
--Call #89:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(18.3279552, 22.9655704, -178.129227, 4.37113883e-08, -3.82137093e-15, 1, -8.74227766e-08, -1, 0, 1, -8.74227766e-08, -4.37113883e-08),
    [2] = workspace.TheHouse.Windo3,
}))

--Call #90:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(17.3364182, 21.0275059, -178.129227, 4.37113883e-08, -3.82137093e-15, 1, -8.74227766e-08, -1, 0, 1, -8.74227766e-08, -4.37113883e-08),
    [2] = workspace.TheHouse.Windo3,
}))

--Call #91:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 19.5729637, -196.657578, 1, -8.74227766e-08, -4.37113883e-08, -8.74227766e-08, -1, 0, -4.37113883e-08, 3.82137093e-15, -1),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #92:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 20.9566669, -195.943436, 1, 8.03793441e-08, 5.56110464e-08, -8.74227766e-08, 0.989992499, 0.141120002, -4.37113883e-08, -0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #93:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 21.0222778, -195.692703, 1, 9.02242263e-08, -3.75901053e-08, -8.74227766e-08, 0.653643608, -0.756802499, -4.37113883e-08, 0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Windo4,
}))
wait()
--Call #94:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 21.2199783, -195.99939, 1, 2.40624516e-08, 9.47334442e-08, -8.74227766e-08, 0.653643608, 0.756802499, -4.37113883e-08, -0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #95:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 21.5150604, -196.238953, 1, -7.17271078e-08, -6.63976536e-08, -8.74227766e-08, -0.960170269, -0.279415488, -4.37113883e-08, 0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #96:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 21.1092911, -198.122681, 1, 9.27164407e-08, 3.0936846e-08, -8.74227766e-08, 0.989992499, -0.141120002, -4.37113883e-08, 0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #97:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 21.5575638, -198.366898, 1, -3.36594042e-09, 9.76836603e-08, -8.74227766e-08, 0.416146845, 0.909297407, -4.37113883e-08, -0.909297407, 0.416146845),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #98:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 21.2306614, -198.228836, 1, 9.27164407e-08, 3.0936846e-08, -8.74227766e-08, 0.989992499, -0.141120002, -4.37113883e-08, 0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Windo4,
}))
wait()
--Call #99:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 21.1254082, -198.419922, 1, 8.03793441e-08, 5.56110464e-08, -8.74227766e-08, 0.989992499, 0.141120002, -4.37113883e-08, -0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #100:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634769, 21.2387428, -198.534241, 1, -8.4016591e-08, 4.99463653e-08, -8.74227766e-08, -0.540302277, 0.841470957, -4.37113883e-08, -0.841470957, -0.540302277),
    [2] = workspace.TheHouse.Windo4,
}))

--Call #101:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.1519318, -217.673676, 1, -3.36594042e-09, 9.76836603e-08, -8.74227766e-08, 0.416146845, 0.909297407, -4.37113883e-08, -0.909297407, 0.416146845),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #102:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.1671619, -218.347153, 1, -9.61543876e-08, -1.75430959e-08, -8.74227766e-08, -0.960170269, 0.279415488, -4.37113883e-08, -0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #103:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.3613453, -220.106461, 1, 9.27164407e-08, 3.0936846e-08, -8.74227766e-08, 0.989992499, -0.141120002, -4.37113883e-08, 0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #104:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.5668011, -220.331482, 1, -8.4016591e-08, 4.99463653e-08, -8.74227766e-08, -0.540302277, 0.841470957, -4.37113883e-08, -0.841470957, -0.540302277),
    [2] = workspace.TheHouse.Windo2,
}))
wait()
--Call #105:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.251255, -220.096207, 1, 9.02242263e-08, -3.75901053e-08, -8.74227766e-08, 0.653643608, -0.756802499, -4.37113883e-08, 0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #106:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.2512283, -220.087936, 1, -8.74227766e-08, -4.37113883e-08, -8.74227766e-08, -1, 0, -4.37113883e-08, 3.82137093e-15, -1),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #107:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.1259689, -219.916611, 1, -6.67144491e-08, 7.14325523e-08, -8.74227766e-08, -0.2836622, 0.958924294, -4.37113883e-08, -0.958924294, -0.2836622),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #108:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.0171356, -219.859039, 1, 2.40624516e-08, 9.47334442e-08, -8.74227766e-08, 0.653643608, 0.756802499, -4.37113883e-08, -0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #109:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 22.0332947, -219.866394, 1, 8.03793441e-08, 5.56110464e-08, -8.74227766e-08, 0.989992499, 0.141120002, -4.37113883e-08, -0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #110:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 21.9903698, -219.890366, 1, -8.4016591e-08, 4.99463653e-08, -8.74227766e-08, -0.540302277, 0.841470957, -4.37113883e-08, -0.841470957, -0.540302277),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #111:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1639042, 21.4098568, -221.589203, 1, -7.17271078e-08, -6.63976536e-08, -8.74227766e-08, -0.960170269, -0.279415488, -4.37113883e-08, 0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Windo2,
}))

--Call #112:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 22.3898697, -231.109085, 1, -3.36594042e-09, 9.76836603e-08, -8.74227766e-08, 0.416146845, 0.909297407, -4.37113883e-08, -0.909297407, 0.416146845),
    [2] = workspace.TheHouse.Part,
}))
wait()
--Call #113:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 22.2918968, -230.530228, 1, 1.71173742e-08, -9.62310907e-08, -8.74227766e-08, -0.2836622, -0.958924294, -4.37113883e-08, 0.958924294, -0.2836622),
    [2] = workspace.TheHouse.Part,
}))

--Call #114:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 22.0605927, -230.765701, 1, 8.03793441e-08, 5.56110464e-08, -8.74227766e-08, 0.989992499, 0.141120002, -4.37113883e-08, -0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Part,
}))

--Call #115:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 22.0929718, -231.276443, 1, -6.67144491e-08, 7.14325523e-08, -8.74227766e-08, -0.2836622, 0.958924294, -4.37113883e-08, -0.958924294, -0.2836622),
    [2] = workspace.TheHouse.Part,
}))

--Call #116:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 21.5607929, -232.225189, 1, -8.74227766e-08, -4.37113883e-08, -8.74227766e-08, -1, 0, -4.37113883e-08, 3.82137093e-15, -1),
    [2] = workspace.TheHouse.Part,
}))

--Call #117:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 21.5982742, -232.265045, 1, 9.27164407e-08, 3.0936846e-08, -8.74227766e-08, 0.989992499, -0.141120002, -4.37113883e-08, 0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Part,
}))

--Call #118:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 21.4114418, -232.170364, 1, -7.17271078e-08, -6.63976536e-08, -8.74227766e-08, -0.960170269, -0.279415488, -4.37113883e-08, 0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Part,
}))

--Call #119:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 21.4183655, -232.156128, 1, -3.36594042e-09, 9.76836603e-08, -8.74227766e-08, 0.416146845, 0.909297407, -4.37113883e-08, -0.909297407, 0.416146845),
    [2] = workspace.TheHouse.Part,
}))

--Call #120:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.1634998, 20.7426529, -232.491119, 1, -7.17271078e-08, -6.63976536e-08, -8.74227766e-08, -0.960170269, -0.279415488, -4.37113883e-08, 0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Part,
}))
wait()
--Call #121:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-36.5295143, 4.76147652, -186.950302, 4.37113883e-08, 0.958924294, 0.2836622, -8.74227766e-08, -0.2836622, 0.958924294, 1, -6.67144491e-08, 7.14325523e-08),
    [2] = workspace.Doors.Front.Closed,
}))

--Call #122:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-38.1116562, 4.68528843, -186.950302, 4.37113883e-08, -0.958924294, 0.2836622, -8.74227766e-08, -0.2836622, -0.958924294, 1, 1.71173742e-08, -9.62310907e-08),
    [2] = workspace.Doors.Front.Closed,
}))

--Call #123:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-38.4591064, 4.17426205, -186.950302, 4.37113883e-08, 0.909297407, -0.416146845, -8.74227766e-08, 0.416146845, 0.909297407, 1, -3.36594042e-09, 9.76836603e-08),
    [2] = workspace.Doors.Front.Closed,
}))

--Call #124:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-38.2760735, 4.2171731, -186.950302, 4.37113883e-08, -0.756802499, -0.653643608, -8.74227766e-08, 0.653643608, -0.756802499, 1, 9.02242263e-08, -3.75901053e-08),
    [2] = workspace.Doors.Front.Closed,
}))

--Call #125:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-37.9496269, 4.10786629, -186.950302, 4.37113883e-08, 0.909297407, -0.416146845, -8.74227766e-08, 0.416146845, 0.909297407, 1, -3.36594042e-09, 9.76836603e-08),
    [2] = workspace.Doors.Front.Closed,
}))

--Call #126:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-37.6013794, 4.05089188, -186.950302, 4.37113883e-08, 0.756802499, -0.653643608, -8.74227766e-08, 0.653643608, 0.756802499, 1, 2.40624516e-08, 9.47334442e-08),
    [2] = workspace.Doors.Front.Closed,
}))
wait()
--Call #127:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-37.4051285, 4.13527489, -186.950302, 4.37113883e-08, 0.958924294, 0.2836622, -8.74227766e-08, -0.2836622, 0.958924294, 1, -6.67144491e-08, 7.14325523e-08),
    [2] = workspace.Doors.Front.Closed,
}))

--Call #128:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-37.5074806, 4.12699509, -186.950302, 4.37113883e-08, -0.841470957, 0.540302277, -8.74227766e-08, -0.540302277, -0.841470957, 1, -1.04528617e-08, -9.71810863e-08),
    [2] = workspace.Doors.Front.Closed,
}))

--Call #129:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-37.807106, 3.76822042, -186.950302, 4.37113883e-08, -0.279415488, 0.960170269, -8.74227766e-08, -0.960170269, -0.279415488, 1, -7.17271078e-08, -6.63976536e-08),
    [2] = workspace.Doors.Front.Closed,
}))

--Call #130:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-37.4388962, 4.07945824, -186.950302, 4.37113883e-08, 0.909297407, -0.416146845, -8.74227766e-08, 0.416146845, 0.909297407, 1, -3.36594042e-09, 9.76836603e-08),
    [2] = workspace.Doors.Front.Closed,
}))

--Call #131:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.5749359, 7.7259984, -214.794098, -1, 8.4016591e-08, -4.99463653e-08, -8.74227766e-08, -0.540302277, 0.841470957, 4.37113883e-08, 0.841470957, 0.540302277),
    [2] = workspace.TheHouse.Part,
}))

--Call #132:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.5749359, 6.09252834, -214.763824, -1, 8.4016591e-08, -4.99463653e-08, -8.74227766e-08, -0.540302277, 0.841470957, 4.37113883e-08, 0.841470957, 0.540302277),
    [2] = workspace.TheHouse.Part,
}))

--Call #133:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.5749359, 5.89041901, -213.519241, -1, 8.4016591e-08, -4.99463653e-08, -8.74227766e-08, -0.540302277, 0.841470957, 4.37113883e-08, 0.841470957, 0.540302277),
    [2] = workspace.TheHouse.Part,
}))

--Call #134:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.5749359, 6.16118717, -213.065247, -1, 1.04528617e-08, 9.71810863e-08, -8.74227766e-08, -0.540302277, -0.841470957, 4.37113883e-08, -0.841470957, 0.540302277),
    [2] = workspace.TheHouse.Part,
}))

--Call #135:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.5749359, 6.10187149, -213.069977, -1, -9.27164407e-08, -3.0936846e-08, -8.74227766e-08, 0.989992499, -0.141120002, 4.37113883e-08, -0.141120002, -0.989992499),
    [2] = workspace.TheHouse.Part,
}))

--Call #136:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.5749359, 5.94737577, -213.114807, -1, 7.17271078e-08, 6.63976536e-08, -8.74227766e-08, -0.960170269, -0.279415488, 4.37113883e-08, -0.279415488, 0.960170269),
    [2] = workspace.TheHouse.Part,
}))

--Call #137:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.5749359, 5.96814823, -213.101501, -1, -9.27164407e-08, -3.0936846e-08, -8.74227766e-08, 0.989992499, -0.141120002, 4.37113883e-08, -0.141120002, -0.989992499),
    [2] = workspace.TheHouse.Part,
}))
wait()
--Call #138:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.5749359, 6.20110035, -212.977066, -1, 7.17271078e-08, 6.63976536e-08, -8.74227766e-08, -0.960170269, -0.279415488, 4.37113883e-08, -0.279415488, 0.960170269),
    [2] = workspace.TheHouse.Part,
}))

--Call #139:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.5749359, 6.0548687, -213.061234, -1, 8.4016591e-08, -4.99463653e-08, -8.74227766e-08, -0.540302277, 0.841470957, 4.37113883e-08, 0.841470957, 0.540302277),
    [2] = workspace.TheHouse.Part,
}))

--Call #140:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(-69.5749359, 6.08993053, -212.963837, -1, -7.6127364e-08, 6.13029485e-08, -8.74227766e-08, 0.416146845, -0.909297407, 4.37113883e-08, -0.909297407, -0.416146845),
    [2] = workspace.TheHouse.Part,
}))

--Call #141:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.0995274, 7.52285337, -213.466354, 1, -8.4016591e-08, 4.99463653e-08, -8.74227766e-08, -0.540302277, 0.841470957, -4.37113883e-08, -0.841470957, -0.540302277),
    [2] = workspace.TheHouse.Part,
}))

--Call #142:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.0995274, 7.60250044, -213.633911, 1, 8.03793441e-08, 5.56110464e-08, -8.74227766e-08, 0.989992499, 0.141120002, -4.37113883e-08, -0.141120002, 0.989992499),
    [2] = workspace.TheHouse.Part,
}))
wait()
--Call #143:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.0995274, 7.02979088, -213.772903, 1, 9.02242263e-08, -3.75901053e-08, -8.74227766e-08, 0.653643608, -0.756802499, -4.37113883e-08, 0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Part,
}))

--Call #144:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.0995274, 6.37872934, -213.848221, 1, 7.6127364e-08, -6.13029485e-08, -8.74227766e-08, 0.416146845, -0.909297407, -4.37113883e-08, 0.909297407, 0.416146845),
    [2] = workspace.TheHouse.Part,
}))

--Call #145:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.0995274, 5.94694233, -213.797546, 1, -1.04528617e-08, -9.71810863e-08, -8.74227766e-08, -0.540302277, -0.841470957, -4.37113883e-08, 0.841470957, -0.540302277),
    [2] = workspace.TheHouse.Part,
}))

--Call #146:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.0995274, 5.97263813, -213.704422, 1, -8.4016591e-08, 4.99463653e-08, -8.74227766e-08, -0.540302277, 0.841470957, -4.37113883e-08, -0.841470957, -0.540302277),
    [2] = workspace.TheHouse.Part,
}))

--Call #147:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.0995274, 6.90552092, -213.767136, 1, -7.17271078e-08, -6.63976536e-08, -8.74227766e-08, -0.960170269, -0.279415488, -4.37113883e-08, 0.279415488, -0.960170269),
    [2] = workspace.TheHouse.Part,
}))

--Call #148:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.0995274, 6.49636555, -212.412262, 1, 9.02242263e-08, -3.75901053e-08, -8.74227766e-08, 0.653643608, -0.756802499, -4.37113883e-08, 0.756802499, 0.653643608),
    [2] = workspace.TheHouse.Part,
}))

--Call #149:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.0995274, 6.68609858, -212.541718, 1, -8.74227766e-08, -4.37113883e-08, -8.74227766e-08, -1, 0, -4.37113883e-08, 3.82137093e-15, -1),
    [2] = workspace.TheHouse.Part,
}))

--Call #150:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(30.0995274, 6.65216255, -212.483856, 1, -6.67144491e-08, 7.14325523e-08, -8.74227766e-08, -0.2836622, 0.958924294, -4.37113883e-08, -0.958924294, -0.2836622),
    [2] = workspace.TheHouse.Part,
}))

--Call #151:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(8.30265236, 5.68769169, -178.129166, 4.37113883e-08, -0.841470957, 0.540302277, -8.74227766e-08, -0.540302277, -0.841470957, 1, -1.04528617e-08, -9.71810863e-08),
    [2] = workspace.TheHouse.BreakWindow,
}))

--Call #152:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(8.17240906, 5.409657, -178.129166, 4.37113883e-08, 0.279415488, 0.960170269, -8.74227766e-08, -0.960170269, 0.279415488, 1, -9.61543876e-08, -1.75430959e-08),
    [2] = workspace.TheHouse.BreakWindow,
}))

--Call #153:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(7.75592327, 5.65693235, -178.129166, 4.37113883e-08, 0.958924294, 0.2836622, -8.74227766e-08, -0.2836622, 0.958924294, 1, -6.67144491e-08, 7.14325523e-08),
    [2] = workspace.TheHouse.BreakWindow,
}))

--Call #154:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(6.93612719, 5.77144241, -178.129166, 4.37113883e-08, 0.909297407, -0.416146845, -8.74227766e-08, 0.416146845, 0.909297407, 1, -3.36594042e-09, 9.76836603e-08),
    [2] = workspace.TheHouse.BreakWindow,
}))

--Call #155:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(5.06183672, 6.2933445, -178.129166, 4.37113883e-08, 0.756802499, -0.653643608, -8.74227766e-08, 0.653643608, 0.756802499, 1, 2.40624516e-08, 9.47334442e-08),
    [2] = workspace.TheHouse.BreakWindow,
}))
wait()
--Call #156:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(5.4278388, 6.9860487, -178.129166, 4.37113883e-08, -0.958924294, 0.2836622, -8.74227766e-08, -0.2836622, -0.958924294, 1, 1.71173742e-08, -9.62310907e-08),
    [2] = workspace.TheHouse.BreakWindow,
}))

--Call #157:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(5.5991087, 7.42796326, -178.129166, 4.37113883e-08, 0.841470957, 0.540302277, -8.74227766e-08, -0.540302277, 0.841470957, 1, -8.4016591e-08, 4.99463653e-08),
    [2] = workspace.TheHouse.BreakWindow,
}))

--Call #158:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(5.72412395, 8.34895325, -178.129166, 4.37113883e-08, 0.841470957, 0.540302277, -8.74227766e-08, -0.540302277, 0.841470957, 1, -8.4016591e-08, 4.99463653e-08),
    [2] = workspace.TheHouse.BreakWindow,
}))

--Call #159:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(6.97900391, 11.3603849, -178.129166, 4.37113883e-08, 0.841470957, 0.540302277, -8.74227766e-08, -0.540302277, 0.841470957, 1, -8.4016591e-08, 4.99463653e-08),
    [2] = workspace.TheHouse.BreakWindow,
}))

--Call #160:
game:GetService("ReplicatedStorage").RemoteEvents.makePlank:FireServer(table.unpack({
    [1] = CFrame.new(5.84943485, 8.47839069, -178.129166, 4.37113883e-08, -0.141120002, -0.989992499, -8.74227766e-08, 0.989992499, -0.141120002, 1, 9.27164407e-08, 3.0936846e-08),
    [2] = workspace.TheHouse.BreakWindow,
}))

							end
						)
 local otherUIs = serv:Channel("Other UIs")
 otherUIs:Button(
	 "UI 2",
	 function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/RealPacket/Break-In-Script-UI2/main/Script.lua", true))()
	 end)
