--[[
    references for VSC to not be mad at me, remove
--]] 
--[[
local loadstring = nil
local Color3 = nil
local game = nil
local C = nil
local Enum = nil
local shared = nil
local wait = nil
local getgenv = nil
local spawn = nil
]]
local AutoClick = getgenv().AutoClick
getgenv().AutoClick = true
local library = loadstring(game:HttpGet(
    ('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()

local w = library:CreateWindow("Clicking Sim") -- Creates the window
local b = w:CreateFolder("Farming") -- Creates the folder(U will put here your buttons,etc)
local c = w:CreateFolder("Tests")
local d = w:CreateFolder("TPs")
b:Label("Farming", {
    TextSize = 25, -- Self Explaining
    TextColor = Color3.fromRGB(255, 255, 255), -- Self Explaining
    BgColor = Color3.fromRGB(69, 69, 69) -- Self Explaining
})

C:label(2, {
    TextSize = 25,
    TextColor = Color3.fromRGB(255, 255, 255),
    BgColor = Color3.fromRGB(69, 69, 69)
})
b:Button("Toggle", function(bool)
    getgenv().AutoClick = bool
    print("Auto Clicker is'", bool)
end)

b:Toggle("Toggle", function(bool)
    shared.toggle = bool
    print(shared.toggle)
end)

b:Slider("Slider", {
    min = 10, -- min value of the slider
    max = 50, -- max value of the slider
    precise = true -- max 2 decimals
}, function(value)
    print(value)
end)

b:Dropdown("Dropdown", {"A", "B", "C"}, true,
    function(mob) -- true/false, replaces the current title "Dropdown" with the option that t
        print(mob)
    end)

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
            game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.ClickService.Click:FireServer(1);
            wait();
        end
    end)
end

function TPTo(placeCFrame)
    local plr = game.Players.LocalPlayer;
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
