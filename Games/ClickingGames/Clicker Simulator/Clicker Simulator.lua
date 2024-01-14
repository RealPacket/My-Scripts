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
--[[
Game link: https://web.roblox.com/games/7560156054/X3-Clicker-Simulator
for checking if the script user wants the script automatically 'click' for them.
--]]
shared.AutoClick = true

while shared.AutoClick do
	game:GetService("ReplicatedStorage").Events.Client.emitClicks:FireServer()
	game:GetService("ReplicatedStorage").Events.Client.emitClicks:FireClient(table.unpack({
		game:GetService("Players").LocalPlayer,
	}))
	task.wait()
end
