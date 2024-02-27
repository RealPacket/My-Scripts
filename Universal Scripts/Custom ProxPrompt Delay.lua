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
-- This script helps you by making it so every single Proximity Prompt won't have delay (or will have a custom delay).
-- I cleaned it up.
-- You can find the documentation of the ProximityPrompt class at https://create.roblox.com/docs/reference/engine/classes/ProximityPrompt

shared.ProxPromptSettings = {
	Config = {
		Delay = 0, -- anything above 0 isn't instant.
	},
}
local settings = shared.ProxPromptSettings
---@param ProxPrompt ProximityPrompt
local function handle(ProxPrompt)
	ProxPrompt.HoldDuration = settings.Config.Delay or 0 -- Current config delay or instant.
end

-- if you were trying to get only the ones parented to the workspace, and not some folder in the workspace, you'd change this to workspace:GetChildren()
for _, ProxPrompt in workspace:GetDescendants() do
	-- Make sure that there's only Proximity Prompts,
	-- if we allowed every type of class, we'd get a error if there would be even just 1 thing that isn't a proximity prompt.
	if not ProxPrompt:IsA("ProximityPrompt") then
		return
	end
	handle(ProxPrompt)
end
---wraps around handle function to check the instance.
---@param inst Instance
local function connectionHandler(inst)
	if not inst:IsA("ProximityPrompt") then
		return
	end
	return handle(inst)
end
workspace.DescendantAdded:Connect(connectionHandler)
