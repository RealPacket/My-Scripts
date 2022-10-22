-- Skidded lololololol
local games = {
    [{3851622790}] = "LOADSTRING"
    [{7560156054}] = "https://raw.githubusercontent.com/https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/ClickingGames/Clicker%20Simulator/Clicker%20Simulator.lua/My-Scripts/main/Clicker%20Simulator.lua"
    [{9912491609}] = "https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/How%20Far%20can%20You%20Fly/Script.lua"
    [{9498006165}] = "https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/ClickingGames/Tapping%20Simulator/TappingScript.lua"
}

for ids, url in next, games do
    if table.find(ids, game.PlaceId) then
        loadstring(game:HttpGet(url))(); break
    end
end
