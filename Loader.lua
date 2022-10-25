-- Skidded lololololol
local games = {
    -- commas added cause loader prob will work if I do.
    [{8884433153}] = "https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/Collect%20All%20Pets/Script.lua",
    [{7560156054}] = "https://raw.githubusercontent.com/https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/ClickingGames/Clicker%20Simulator/Clicker%20Simulator.lua/My-Scripts/main/Clicker%20Simulator.lua",
    [{9912491609}] = "https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/How%20Far%20can%20You%20Fly/Script.lua",
    [{9498006165}] = "https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/ClickingGames/Tapping%20Simulator/TappingScript.lua",
                      --[[
                          TODO: 
                            Change this to the loader when I release the loader...
                            Loader coming soon (will use discord UI Lib as I think it is the best for loaders and some people use it)
                        ]]
    [{3851622790}] = "https://raw.githubusercontent.com/RealPacket/My-Scripts/main/Games/BreakIn/KavoUI/BreakInStoryKavo.lua"
}

for ids, url in next, games do
    if table.find(ids, game.PlaceId) then
        loadstring(game:HttpGet(url))(); break
    end
end
