--[[
     This file is part of RealPacket/My-Scripts, a collection of scripts licensed under AGPL.
    My-Scripts is 100% free scripts:
        you can redistribute it and/or modify it under
        the terms of the GNU Affero General Public License as published by the Free Software Foundation,
        either version 3 of the License, or (at your option) any later version.

    My-Scripts is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY;
        without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
        See the GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License along with My-Scripts.
    If not, see <https://www.gnu.org/licenses/>.
]]
-- this is literally the stand on players script but with humanoid state set to sitting.
-- bugs should be fixed, will test soon...

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local lPlayer = Players.LocalPlayer
-- our target; the player that our character has touched.
local target: Player? = nil
local sittingOnTarget = false

local function onJumpRequest()
	-- if they're not standing on anyone, don't do anything.
	if not target then
		return
	end
	target = nil
	sittingOnTarget = false
	lPlayer.Character.PrimaryPart.Anchored = false
  lPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.None)
	lPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
end

UserInputService.JumpRequest:Connect(onJumpRequest)

local function targetLoop()
	lPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Seated)
	while target and target ~= nil and sittingOnTarget do
		local targetHead: Part? = target.Character:FindFirstChild("Head")
		lPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
		lPlayer.Character.PrimaryPart.Anchored = false
		local position = targetHead.CFrame + (Vector3.new(0, targetHead.Size.Y + 2, 0))
		lPlayer.Character:PivotTo(position)
		lPlayer.Character.PrimaryPart.Anchored = true
		task.wait()
	end
end

---@param player Player
local function onPlayerRemoving(player)
	if player == target then
    target = nil
    onJumpRequest()
	else
		return
	end
	-- do other things
end

---@param player Player
local function onPlayerAdded(player)
	if player == lPlayer then
		return
	end
	task.spawn(function()
		if not player.Character then
			player.CharacterAdded:Wait()
		end

		-- the player's head
		local PlayerHead: Part? = player.Character:FindFirstChild("Head")

		if not PlayerHead then
			return
		end
		if not PlayerHead.CanCollide then
			PlayerHead.CanCollide = true
		end

		PlayerHead.Touched:Connect(function(part)
			-- if the player isn't us, we're not interested in it.
			if part.Parent == lPlayer.Character then
				return
			end

			sittingOnTarget = true
			target = Players:GetPlayerFromCharacter(player.Character)
			targetLoop()
		end)
	end)
end
Players.PlayerRemoving:Connect(onPlayerRemoving)
Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in Players:GetPlayers() do
	if player == lPlayer then
		continue
	end
	onPlayerAdded(player)
end
