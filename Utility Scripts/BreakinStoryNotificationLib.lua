local this = {}
-- Instances:
local HiddenUI
-- MultiExecutor support at some point
-- if identifyexecutor():find("Syn") then
-- 	HiddenUI = syn.protect_gui
-- 	else
-- 	HiddenUI = gethui
-- end
HiddenUI = gethui
local SmallNotifications = Instance.new("Frame")
local NotificationDefault = Instance.new("ImageLabel")
local Button = Instance.new("ImageButton")
local TextLabel = Instance.new("Frame")
local XboxButton = Instance.new("ImageLabel")


SmallNotifications.Name = "SmallNotifications"
SmallNotifications.Parent = HiddenUI()
SmallNotifications.AnchorPoint = Vector2.new(1, 0.5)
SmallNotifications.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SmallNotifications.BackgroundTransparency = 1.000
SmallNotifications.BorderSizePixel = 0
SmallNotifications.Position = UDim2.new(1, 0, 1.39999998, 0)
SmallNotifications.Size = UDim2.new(0.75, 0, 3, 0)

NotificationDefault.Name = "NotificationDefault"
NotificationDefault.Parent = SmallNotifications
NotificationDefault.BackgroundColor3 = Color3.fromRGB(96, 16, 255)
NotificationDefault.BackgroundTransparency = 1.000
NotificationDefault.BorderSizePixel = 0
NotificationDefault.Size = UDim2.new(1, 0, 0.25, 0)
NotificationDefault.Visible = false
NotificationDefault.Image = "http://www.roblox.com/asset/?id=4584362528"
NotificationDefault.ImageTransparency = 0.400

Button.Name = "Button"
Button.Parent = NotificationDefault
Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Button.BackgroundTransparency = 1.000
Button.BorderSizePixel = 0
Button.Size = UDim2.new(1, 0, 1, 0)

TextLabel.Name = "TextLabel"
TextLabel.Parent = NotificationDefault
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.150000006, 0, 0.150000006, 0)
TextLabel.Size = UDim2.new(0.800000012, 0, 0.699999988, 0)

XboxButton.Name = "XboxButton"
XboxButton.Parent = NotificationDefault
XboxButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
XboxButton.BackgroundTransparency = 1.000
XboxButton.BorderSizePixel = 0
XboxButton.Position = UDim2.new(0.852668166, 0, 0, 0)
XboxButton.Size = UDim2.new(0.146776497, 0, 0.250648499, 0)
XboxButton.Visible = false
XboxButton.ZIndex = 5
XboxButton.Image = "http://www.roblox.com/asset/?id=4684834708"

function this:displayNotification(text, duration)
	local SmallNotifications = game.StarterGui.SmallNotifications.SmallNotifications:FindFirstChild("SmallNotifications")
	local NotificationDefault = SmallNotifications:FindFirstChild("NotificationDefault")
	local TextLabel = NotificationDefault:FindFirstChild("TextLabel")

	NotificationDefault.Visible = true
	TextLabel.Text = text

	wait(duration)
	NotificationDefault.Visible = false
end
return this
