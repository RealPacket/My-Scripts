-- NOTE: this has been patched.
-- normalize any messages trying to lag our game.
if not game:IsLoaded() then
	game.Loaded:Wait()
end
-- lag
local sendMsg = "💫"
local Unicode = " "
sendMsg = sendMsg .. Unicode:rep(math.random(200, 204) - #sendMsg)
local delay = 1.2

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SayMessageRequest = ReplicatedStorage:FindFirstChild("SayMessageRequest", true)

if SayMessageRequest then
	for _ = 1, 10 do
		SayMessageRequest:FireServer(sendMsg, "All")
		delay = math.random(1.2, 1.5)
		task.wait(delay)
	end
end

local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local Chat = PlayerGui:FindFirstChild("Chat")
local MessageDisplay = Chat and Chat:FindFirstChild("Frame_MessageLogDisplay", true)
local Scroller = MessageDisplay and MessageDisplay:FindFirstChild("Scroller")

if not Scroller then
	return
end

for _, x in next, Scroller:GetChildren() do
	local MessageTextLabel = x:FindFirstChildWhichIsA("TextLabel")

	if MessageTextLabel then
		local Message = MessageTextLabel.Text

		if Message:match(utf8.charpattern) or Message:match(" ") then
			MessageTextLabel.Text = utf8.nfcnormalize(Message)
		end
	end
end

Scroller.ChildAdded:Connect(function(x)
	local MessageTextLabel = x:FindFirstChildWhichIsA("TextLabel")
	local SenderTextButton = MessageTextLabel and MessageTextLabel:FindFirstChildWhichIsA("TextButton")
	if MessageTextLabel and SenderTextButton then
		repeat
			task.wait()
		until not MessageTextLabel.Text:match("__+")
		local message = MessageTextLabel.Text:gsub("^%s+", "")

		if message:match(utf8.charpattern) or message:match(" ") then
			MessageTextLabel.Text = utf8.nfcnormalize(message)
		end

		if message:match("You must wait %d+ seconds") and tonumber(message:split(" ")[4]) then
			x:Destroy()
			delay = tonumber(message:split(" ")[4])
			print("New delay: " .. tostring(delay))
		end
	end
end)
