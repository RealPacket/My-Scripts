local testing = identifyexecutor() == "Codex"
local file = testing and "Bot-testing.lua" or "Bot.lua"
loadstring(
	game:HttpGet(
		"https://raw.githubusercontent.com/RealPacket/My-Scripts/main/" .. "Universal%20Scripts" .. "/Bot/" .. file
	),
	"Betabot"
)()
