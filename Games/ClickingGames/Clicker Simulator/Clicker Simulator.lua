--[[
Game link: https://web.roblox.com/games/7560156054/X3-Clicker-Simulator
for checking if the script user wants the script automatically 'click' for them.
--]] _G.AutoClick = true

while _G.AutoClick == true do
    print("AutoClick is 'true'! that means, LETS GET CLICKING")
    game:GetService("ReplicatedStorage").Events.Client.emitClicks:FireServer()
    game:GetService("ReplicatedStorage").Events.Client.emitClicks:FireClient(table.unpack({
        [1] = game:GetService("Players").LocalPlayer
    }))
    wait()
end

