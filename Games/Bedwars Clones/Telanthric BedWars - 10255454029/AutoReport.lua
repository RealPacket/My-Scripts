-- Improved version.
local plrs = {}
local reportedPlrs = {}
shared.AutoReport = {
	["Config"] = {
		["Enabled"] = true
	}
}
--[[
	Notifies the user about something, Maybe you lost some pringles 💀.
	Default title is "Notification"
	Default text is "No content. Called with nothing to give you."
	Default duration is 2.
--]]
local Services = {
	["sGUI"] = game:GetService("StarterGui")
}
function Notify(Title: string, Text: string, Duration: number?)
	Services["sGUI"]:SetCore("SendNotification", {
			Title = Title or "Notification",
			Text = Text or "No content. Called with nothing to give you.",
			Duration = Duration or 2
		})
end
function includes(Table: table, value)
  for _, v in pairs(Table) do
    if v == value then
      return true
    end
  end
  return false
end
function Chat(Msg: string, channel: string?)
	if not channel then channel = "All" end
	if game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents") then
		getgenv().ChatRemote = game:GetService("ReplicatedStorage")["DefaultChatSystemChatEvents"]["SayMessageRequest"]
	end
	if getgenv().ChatRemote then
		getgenv().ChatRemote:FireServer(Msg, channel)
	end
	for _, Remote in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
		if Remote:IsA("RemoteEvent") then
			if string.find(tostring(Remote) or Remote.Name, "Chat") then
				Remote:FireServer(Msg)
			else
				continue
			end
		end
	end
end
-- all of the functions below trying to access APIs are for the AntiReportHacker bullshit that I want to do soon.
function getUID(PlayerName: string)
	local headers = {
		["username"] = PlayerName
	}
	local options = {
		Url = URL,
		Method = "GET",
		Headers = headers 
	}
	-- if your request function isn't really the same then I don't care.
	-- I use Krnl, Atleast I don't waste money on a lego hack.
	local response = request(options)
	local UIDHolder = game:GetService("HttpService").JSONDecode(response.Body)
	return UIDHolder["Id"]
end
function getDescription(PlayerUID: number|Integer|string)
	local URL = "https://users.roblox.com/v1/users/"..tostring(PlayerUID)
	local options = {
		Url = URL,
		Method = "GET"
	}
	response = request(options)
	local descHolder = game:GetService("HttpService"):JSONDecode(response.Body)
	public_description = descHolder["description"]
	print(public_description)
end


function Report(Player, NotifyMethod)
  -- various checks that'll return without doing anything.
  -- TODO: Make the AntiReportHacker thing, so that we can have staff truly mald,
  -- as half of the players reported will be legits or hackers without the string in their description.
  -- Working on that soon.
  if Player == game.Players.LocalPlayer
  or includes(reportedPlrs, Player) then
    return
  end

  local URL = "https://docs.google.com/forms/d/e/1FAIpQLSfzOZz9FddF3TpbG1BEtuKlP_mVlH00D4JIYuHLEnBE2XwuaA/formResponse"
  local formData = {
    ["entry.286304015"] = "https://discord.com/invite/wjRYjVWkya",
    ["entry.352020552"] = Player.DisplayName,
    ["entry.652796102"] = tostring(Player) or Player.Name,
    ["entry.1386130187"] = "-",
    ["emailAddress"] = "bro_you_really_thought@you_would_get_a_valid_email.lol"
  }
  local options = {
    Url = URL,
    Method = "GET",
    Form = formData,
  }
  local response = request(options)
  if not response.Success then
    error("Couldn't send request.", 1)
    for hName, hValue in pairs(response) do
      if hName == "Body" then
      end
      if typeof(hValue) == "table" then
        for Name, Value in pairs(hValue) do
          print("["..tostring(hName).." - "..tostring(Name).."] "..tostring(Value))
          if typeof(hValue) == "table" then
            for _Name, _Val in pairs(hValue) do
              print("["..tostring(Name).." - "..tostring(_Name).."] "..tostring(_Val))
            end
          end
        end
      end
      print("["..tostring(hName).."] "..tostring(hValue))
    end
  end
  if not NotfiyMethod then
	   print("Reported @"..Player.Name.." (@"..Player.DisplayName..")")
	end
  if NotifyMethod == "Console" then
	   print("[AutoReport] Reported @"..Player.Name.." (@"..Player.DisplayName..")")
  elseif NotifyMethod == "Notify" then
	   Notify("AutoReport", "Reported @"..Player.Name.." (@"..Player.DisplayName..")")
  elseif NotifyMethod == "Chat" then
	  Chat("I just false reported @"..Player.Name.." (@"..Player.DisplayName..")")
  end
  table.insert(reportedPlrs, Player)
end

for _, P in pairs(game.Players:GetPlayers()) do
  table.insert(plrs, P)
end

local PlayerAdded = game.Players.PlayerAdded
local PlayerRemoved = game.Players.PlayerRemoving

local PA = PlayerAdded:Connect(function(Player)
  table.insert(plrs, Player)
end)

local PR = PlayerRemoved:Connect(function(Player)
  local index
  for i, P in pairs(plrs) do
    if P == Player then
      index = i
      break
    end
  end
  if index then
    table.remove(plrs, index)
  end
end)
function Disconnect()
  PA:Disconnect()
  PR:Disconnect()
  for i = #plrs, 1, -1 do
    table.remove(plrs, i)
  end
end
-- TODO: Make a GUI with this file.
while shared.AutoReport.Config["Enabled"] do
  local RandomPlr = math.random(1, #plrs)
  local numOfTeams = game:GetService("Teams"):GetChildren()
  if includes(plrs, plrs[RandomPlr]) then
  	RandomPlr = math.random(1, #plrs)
  end
  if #numOfTeams > 1 then
	  if plrs[RandomPlr].Team == game.Players.LocalPlayer.Team then
  		RandomPlr = math.random(1, #plrs)
	   end
  end
  Report(plrs[RandomPlr], "Notify")
  wait(math.random(1, 2.2))
end
