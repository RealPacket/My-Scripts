-- This script helps you by making it so every single Proximity Prompt won't have delay.
-- You can find the documentation of the ProximityPrompt class at https://create.roblox.com/docs/reference/engine/classes/ProximityPrompt
shared.NoProxPromptWait = 
{
  ["Config"] = {
    ["Delay"] = 0, -- anything above 0 isn't instant.
    ["Enabled"] = true -- if the mod should be enabled.
  }
}
local SettingsHolder = shared.NoProxPromptWait
local moddedProximityPrompts = {
  
}
  -- if you were trying to get only the ones parented to the workspace, and not some folder in the workspace, you'd change this to workspace:GetChildren()
for _, ProxPrompt in pairs(workspace:GetDescendants()) do
  -- Make sure that there's only Proximity Prompts,
  -- if we allowed every type of class, we'd get a error if there would be even just 1 thing that isn't a proximity prompt.
  if ProxPrompt:IsA("ProximityPrompt") then
    -- Modify the wait delay
    ProxPrompt["HoldDuration"] = SettingsHolder["Config"]["Delay"] or 0 -- Current Config's delay or Instant
    table.insert(moddedProximityPrompts, ProxPrompt)
  end
 end
function noDelay(ProxPrompt)
    if ProxPrompt:IsA("ProximityPrompt") then
      ProxPrompt["HoldDuration"] = SettingsHolder["Config"]["Delay"] or 0 -- Current Config's delay or Instant
      moddedProximityPrompts:insert(ProxPrompt)
    end
end
workspace.DescendantAdded:Connect(noDelay)
