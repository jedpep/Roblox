local httprequest = (syn and syn.request) or http and http.request or http_request or (fluxus and fluxus.request) or request

local CreateWebhook = {}
CreateWebhook.__index = CreateWebhook

function CreateWebhook.new(webhook)
    local self = setmetatable({}, CreateWebhook)
    self.webhook = webhook
    self.data = {}
    return self
end

function CreateWebhook:setContent(content)
    self.data["content"] = content
end

function CreateWebhook:addEmbed(embed)
    if not self.data["embeds"] then
        self.data["embeds"] = {}
    end
    table.insert(self.data["embeds"], embed:toJSON())
end

function CreateWebhook:send()
    local success, response = pcall(function()
        return httprequest({
            Url = self.webhook,
            Body = game.HttpService:JSONEncode(self.data),
            Method = "POST",
            Headers = {["content-type"] = "application/json"}
        })
    end)
    
    if success then
        print("Webhook sent successfully")
    else
        warn("Failed to send webhook: " .. response)
    end
end

local CreateEmbed = {}
CreateEmbed.__index = CreateEmbed

function CreateEmbed.new()
    local self = setmetatable({}, CreateEmbed)
    self.data = {}
    return self
end

function CreateEmbed:setTitle(title)
    self.data["title"] = title
end

function CreateEmbed:setURL(url)
    self.data["url"] = url
end

function CreateEmbed:setDescription(description)
    self.data["description"] = description
end

function CreateEmbed:setColor(color)
    self.data["color"] = color
end

function CreateEmbed:addFields(name, value, inline)
    if not self.data["fields"] then
        self.data["fields"] = {}
    end
    table.insert(self.data["fields"], {
        ["name"] = name,
        ["value"] = value,
        ["inline"] = inline
    })
end

function CreateEmbed:setAuthor(name, url)
    local author = {["name"] = name}
    if url then
        author["url"] = url
    end
    self.data["author"] = author
end

function CreateEmbed:setFooter(text, icon_url)
    local footer = {["text"] = text}
    if icon_url then
        footer["icon_url"] = icon_url
    end
    self.data["footer"] = footer
end

function CreateEmbed:setTimestamp(timestamp)
    self.data["timestamp"] = timestamp
end

function CreateEmbed:setThumbnail(url)
    self.data["thumbnail"] = {["url"] = url}
end

function CreateEmbed:setImage(url)
    self.data["image"] = {["url"] = url}
end

function CreateEmbed:toJSON()
    return self.data
end

return CreateWebhook, CreateEmbed
