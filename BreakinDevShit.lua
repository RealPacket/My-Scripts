local False = false
getgenv().GodMode = false
while GodMode == true do
game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer("BloxyCola")
game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer("BloxyCola")
game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer("BloxyCola")
wait() -- to not lag your device, if this wasn't included. Your roblox game would prob insta-crash
    game:GetService("ReplicatedStorage").RemoteEvents.Energy:FireServer(table.unpack({
    [1] = 15, --You can't change the values of the healing amount :(
    [2] = "BloxyCola",
}))
    game:GetService("ReplicatedStorage").RemoteEvents.Energy:FireServer(table.unpack({
    [1] = 15,
    [2] = "BloxyCola",
}))
game:GetService("ReplicatedStorage").RemoteEvents.Energy:FireServer(table.unpack({
    [1] = 15, 
    [2] = "BloxyCola"
}))
end