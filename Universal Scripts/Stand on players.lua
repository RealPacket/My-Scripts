-- NOTE: this does have some bugs, I just wanna publish it early.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local lPlayer = Players.LocalPlayer
-- our target; the player that our player has touched, and we'll stand on him.
local target: Player? = nil
local sittingOnTarget = false

local function onJumpRequest()
    -- if they're not standing on anyone, don't do anything.
    if target == nil then return end
    target = nil
    sittingOnTarget = false
    lPlayer.Character.PrimaryPart.Anchored = false
    lPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
end


UserInputService.JumpRequest:Connect(onJumpRequest)

local function targetLoop()
  -- lPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.None)
  while target and target ~= nil and sittingOnTarget do
  	-- lPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.None)
    local targetHead: Part? = target.Character:FindFirstChild("Head")
    lPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
    lPlayer.Character.PrimaryPart.Anchored = false
    local Position = targetHead.CFrame + (Vector3.new(0, targetHead.Size.Y + 2, 0))
    lPlayer.Character:PivotTo(Position)
    lPlayer.Character.PrimaryPart.Anchored = true
    task.wait()
  end
end


local function onPlayerRemoving(Player: Player)
	if Player == target then
		lPlayer.Character.PrimaryPart.Anchored = false
        target = nil
        lPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
		else
		return
	end
    -- do other things
end

local function onPlayerAdded(Player: Player)
    if Player == lPlayer then return end
    task.spawn(function()
        if not Player.Character then Player.CharacterAdded:Wait() end

        -- the player's head
        local PlayerHead: Part? = Player.Character:WaitForChild("Head", 0.4)

        if not PlayerHead then return end
        if not PlayerHead.CanCollide then PlayerHead.CanCollide = true end

        PlayerHead.Touched:Connect(function(part)
            -- if the player isn't us, we're not interested in it.
            if part.Parent == lPlayer.Character then return end


            sittingOnTarget = true
            target = Players:GetPlayerFromCharacter(Player.Character)
            targetLoop()
        end)
    end)
end
Players.PlayerRemoving:Connect(onPlayerRemoving)
Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in Players:GetPlayers() do
    if player == lPlayer then continue end
    onPlayerAdded(player)
end
