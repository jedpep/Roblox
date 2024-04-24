local CoreGuiPath = "Jedpep/CoreGui"
local AssetPath = "Jedpep/CoreGui/assets"

repeat task.wait() until game:IsLoaded()
local getasset = getsynasset or getcustomasset
if syn then
    getasset = getsynasset
end
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
local function getcustomassetfunc(file)
    makefolder(CoreGuiPath)
    makefolder(AssetPath)
	if not isfile(AssetPath..'/'..file) then
        local req = game:HttpGet(("https://raw.githubusercontent.com/jedpep/Roblox/main/CoreGui/assets/%s"):format(file))
		writefile(AssetPath.."/"..file, req)
    end
	return getasset(AssetPath..'/'..file)
end

local function shop()
    --Made by Rafa#0069 ❤
    local MINIMUM_PLAYERS = 1
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local LocalPlayer = Players.LocalPlayer
    local PlaceId = game.PlaceId
    local fileName = string.format("%s_servers.json", tostring(PlaceId))
    local ServerHopData = { 
        CheckedServers = {},
        LastTimeHop = nil,
        CreatedAt = os.time()
    }
    if isfile(fileName) then
        local fileContent = readfile(fileName)
        ServerHopData = HttpService:JSONDecode(fileContent)
    end
    if ServerHopData.LastTimeHop then
        print("Took", os.time() - ServerHopData.LastTimeHop, "seconds to server hop")
    end
    local ServerTypes = { ["Normal"] = "desc", ["Low"] = "asc" }
    function Jump(serverType)
        serverType = serverType or "Normal"
        if not ServerTypes[serverType] then serverType = "Normal" end
        local function GetServerList(cursor)
            cursor = cursor and "&cursor=" .. cursor or ""
            local API_URL = string.format('https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=%s&limit=100', tostring(PlaceId), ServerTypes[serverType])
            return HttpService:JSONDecode(game:HttpGet(API_URL .. cursor))
        end
        local currentPageCursor = nil
        while true do 
            local serverList = GetServerList(currentPageCursor)
            currentPageCursor = serverList.nextPageCursor
            for _, server in ipairs(serverList.data) do
                if server.playing and tonumber(server.playing) >= MINIMUM_PLAYERS and tonumber(server.playing) < Players.MaxPlayers and not table.find(ServerHopData.CheckedServers, tostring(server.id)) then     
                    ServerHopData.LastTimeHop = os.time()
                    table.insert(ServerHopData.CheckedServers, server.id)
                    writefile(fileName, HttpService:JSONEncode(ServerHopData))
                    TeleportService:TeleportToPlaceInstance(PlaceId, server.id, LocalPlayer) 
                    wait(0.25)
                end
            end
            if not currentPageCursor then break else wait(0.25) end
        end  
    end
    Jump("Low")
end

local ResetGameButtonButton = Instance.new("ImageButton")
local ResetGameButtonTextLabel = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local ResetGameButtonHint = Instance.new("ImageLabel")

ResetGameButtonButton.Name = "ResetGameButtonButton"
ResetGameButtonButton.Parent = game:GetService("CoreGui"):WaitForChild("RobloxGui"):WaitForChild("SettingsClippingShield"):WaitForChild("SettingsShield"):WaitForChild("MenuContainer"):WaitForChild("BottomButtonFrame")
ResetGameButtonButton.BackgroundTransparency = 1.000
ResetGameButtonButton.Position = UDim2.new(0.15, -120, 0.5, 50)
ResetGameButtonButton.Size = UDim2.new(0, 260, 0, 70)
ResetGameButtonButton.ZIndex = 2
ResetGameButtonButton.AutoButtonColor = false
ResetGameButtonButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
ResetGameButtonButton.ScaleType = Enum.ScaleType.Slice
ResetGameButtonButton.SliceCenter = Rect.new(8, 6, 46, 44)

ResetGameButtonTextLabel.Name = "ResetGameButtonTextLabel"
ResetGameButtonTextLabel.Parent = ResetGameButtonButton
ResetGameButtonTextLabel.BackgroundTransparency = 1.000
ResetGameButtonTextLabel.BorderSizePixel = 0
ResetGameButtonTextLabel.Position = UDim2.new(0.25, 0, 0, 0)
ResetGameButtonTextLabel.Size = UDim2.new(0.75, 0, 0.899999976, 0)
ResetGameButtonTextLabel.ZIndex = 2
ResetGameButtonTextLabel.Font = Enum.Font.SourceSansBold
ResetGameButtonTextLabel.Text = "Low Server"
ResetGameButtonTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetGameButtonTextLabel.TextScaled = true
ResetGameButtonTextLabel.TextSize = 24.000
ResetGameButtonTextLabel.TextWrapped = true

UITextSizeConstraint.Parent = ResetGameButtonTextLabel
UITextSizeConstraint.MaxTextSize = 24

ResetGameButtonHint.Name = "ResetGameButtonHint"
ResetGameButtonHint.Parent = ResetGameButtonButton
ResetGameButtonHint.Image = getcustomassetfunc("LowServerIcon.png")
ResetGameButtonHint.AnchorPoint = Vector2.new(0.5, 0.5)
ResetGameButtonHint.BackgroundTransparency = 1.000
ResetGameButtonHint.Position = UDim2.new(0.150000006, 0, 0.474999994, 0)
ResetGameButtonHint.Size = UDim2.new(0, 55, 0, 60)
ResetGameButtonHint.ZIndex = 4

ResetGameButtonButton.MouseEnter:Connect(function() 
	ResetGameButtonButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
end)

ResetGameButtonButton.MouseLeave:Connect(function()
	ResetGameButtonButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
end)

ResetGameButtonButton.MouseButton1Click:Connect(function()
	shop()
end)
