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

-- Skidded from https://github.com/RegularVynixu/Vynixius/blob/main/Loader.lua lmao
local games = {
	[{ 8884433153 }] = "https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/Collect%20All%20Pets/Script.lua",
	[{ 7560156054 }] = "https://raw.githubusercontent.com/https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/ClickingGames/Clicker%20Simulator/Clicker%20Simulator.lua/My-Scripts/main/Clicker%20Simulator.lua",
	[{ 9912491609 }] = "https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/How%20Far%20can%20You%20Fly/Orion%20Library/Script.lua",
	[{ 9498006165 }] = "https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/ClickingGames/Tapping%20Simulator/TappingScript.lua",
	[{ 3851622790 }] = "https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/BreakIn/BreakInHubLoader.lua",
	[{ 4620170611 }] = "https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/BreakIn/KavoUI/Script.lua",
}

for ids, url in next, games do
	if table.find(ids, game.PlaceId) then
		loadstring(game:HttpGet(url))()
		break
	end
end
