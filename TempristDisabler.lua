--game:GetService("ReplicatedStorage").RemoteEvents.GiveTool:FireServer("Key")
local Whitelist = {
	"BubbleChat",
	"ChatScript",
	"PlayerScriptLoader",
	"oGy",
	"ControlAsset",
	"LocalTransparency",
	"PlayerModule"
}
for i, v in pairs(game:GetService("Players"):GetDescendants()) do
	if v.Name == "ChatScript" then
		return
	end
	if v.Name == "BubbleChat" then
		return
	end
	if v:IsA("Script") then v:Destroy() print("Deleted", v.Name) end
end