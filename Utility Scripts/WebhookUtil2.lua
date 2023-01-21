local WebhookUtils = {}

function WebhookUtils.sendWebhook(url, options: table)
    --[[
        The data that this function uses to trigger/send a webhook message.
    ]]
    local data = {
        content = "Unspecified.",
        avatar_url = "https://example.com/avatar.png",
        tts = false,
        embeds = {
            {
                title = "Test Embed",
                description = "This is a test embed"
            }
        }
    }
    if options then
        if options["content"] then data["content"] = tostring(options["content"]) end
        if options["avatar_url"] then data["avatar_url"] = tostring(options["avatar_url"]) end
        if options["TTS"] and typeof(options["TTS"]) == "boolean" then data["tts"] = options["TTS"] end
        if options["embeds"] and typeof(options["embeds"] == typeof(data["embeds"])) then data["embeds"] = options["embeds"] end
        if options["username"] and typeof(options["username"]) == "string" then data["username"] = options["username"] end
    end
    local dataString = game:GetService("HttpService"):JSONEncode(data)
    local headers = {
        ["Content-Type"] = "application/json",
        ["Content-Length"] = #dataString
    }
    local success, response = pcall(function()
        return game:HttpPostAsync(url, dataString, headers)
    end)
    if success and response.Success then
        print("Webhook triggered successfully")
    else
        print("Failed to trigger webhook. Response: "..tostring(response))
    end
end

return WebhookUtils
