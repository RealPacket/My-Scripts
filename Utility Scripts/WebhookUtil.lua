local WebhookUtils = {}

function WebhookUtils.sendWebhook(self, url, options)
    if self and not url then
        url, options = self, url
    end
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
    end
    local dataString = game:GetService("HttpService"):JSONEncode(data)
    local headers = {
        ["Content-Type"] = "application/json",
        ["Content-Length"] = #dataString
    }
    local success, response = pcall(function()
        return request({
            Url = url,
            Method = "POST",
            Headers = headers,
            Body = dataString
        })
    end)


function WebhookUtils:sendWebhook(url, options)
    return WebhookUtils.sendWebhook(self, url, options)
end


return WebhookUtils
