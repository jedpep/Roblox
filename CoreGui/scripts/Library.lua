local Lib = {} do
    Lib.Storage = {
        Buttons = 0,
        Left_Menus = 0,
        Right_Menus = 0,
        CoreGuiPath = "Jedpep/CoreGui",
        AssetPath = "Jedpep/CoreGui/assets"
    }

    local ROM = {
        Button_Positions = {
            [1] = UDim2.new(0.15, -120, 0.5, 50),
            [2] = UDim2.new(0.5, -130, 0.5, 50),
            [3] = UDim2.new(0.85, -140, 0.5, 50),
        }
    }

    Lib.Utils = {} do
        Lib.Utils.getcustomassetfunc = function(file)
            local getasset = getsynasset or getcustomasset
            makefolder(Lib.Storage.CoreGuiPath)
            makefolder(Lib.Storage.AssetPath)
            if not isfile(Lib.Storage.AssetPath..'/'..file) then
                local req = game:HttpGet(("https://raw.githubusercontent.com/jedpep/Roblox/main/CoreGui/assets/%s"):format(file))
                writefile(Lib.Storage.AssetPath.."/"..file, req)
            end
            return getasset(Lib.Storage.AssetPath..'/'..file)
        end

        Lib.Utils.Serverhop = function(Mode)
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
            Jump(Mode)
        end

        Lib.Utils.Rejoin = function()
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
        end
    end

    Lib.IconList = function()
        setclipboard("https://github.com/jedpep/Roblox/tree/main/CoreGui/assets")
    end

    Lib.CreateButton = function(params)
        local ButtonText = params.ButtonText
        local Icon = params.Icon
        local callback = params.callback
        Lib.Storage.Buttons += 1

        local CoreGUIButton = Instance.new("ImageButton")
        local CoreGUITextLabel = Instance.new("TextLabel")
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
        local CoreGUIButtonHint = Instance.new("ImageLabel")

        CoreGUIButton.Name = "CoreGUIButton"..math.random(10000,99999)
        CoreGUIButton.Parent = game:GetService("CoreGui"):WaitForChild("RobloxGui"):WaitForChild("SettingsShield"):WaitForChild("SettingsShield"):WaitForChild("MenuContainer"):WaitForChild("BottomButtonFrame")
        CoreGUIButton.BackgroundTransparency = 1.000
        CoreGUIButton.Position = UDim2.new(ROM.Button_Positions[Lib.Storage.Buttons])
        CoreGUIButton.Size = UDim2.new(0, 260, 0, 70)
        CoreGUIButton.ZIndex = 2
        CoreGUIButton.AutoButtonColor = false
        CoreGUIButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
        CoreGUIButton.ScaleType = Enum.ScaleType.Slice
        CoreGUIButton.SliceCenter = Rect.new(8, 6, 46, 44)

        CoreGUITextLabel.Name = "CoreGUITextLabel"..math.random(10000,99999)
        CoreGUITextLabel.Parent = CoreGUIButton
        CoreGUITextLabel.BackgroundTransparency = 1.000
        CoreGUITextLabel.BorderSizePixel = 0
        CoreGUITextLabel.Position = UDim2.new(0.25, 0, 0, 0)
        CoreGUITextLabel.Size = UDim2.new(0.75, 0, 0.899999976, 0)
        CoreGUITextLabel.ZIndex = 2
        CoreGUITextLabel.Font = Enum.Font.SourceSansBold
        CoreGUITextLabel.Text = tostring(ButtonText)
        CoreGUITextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        CoreGUITextLabel.TextScaled = true
        CoreGUITextLabel.TextSize = 24.000
        CoreGUITextLabel.TextWrapped = true

        UITextSizeConstraint.Parent = CoreGUITextLabel
        UITextSizeConstraint.MaxTextSize = 24

        CoreGUIButtonHint.Name = "CoreGUIButtonHint"..math.random(10000,99999)
        CoreGUIButtonHint.Parent = CoreGUIButton
        CoreGUIButtonHint.Image = getcustomassetfunc(Icon)
        CoreGUIButtonHint.AnchorPoint = Vector2.new(0.5, 0.5)
        CoreGUIButtonHint.BackgroundTransparency = 1.000
        CoreGUIButtonHint.Position = UDim2.new(0.150000006, 0, 0.474999994, 0)
        CoreGUIButtonHint.Size = UDim2.new(0, 55, 0, 60)
        CoreGUIButtonHint.ZIndex = 4

        CoreGUIButton.MouseEnter:Connect(function() 
            CoreGUIButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
        end)

        CoreGUIButton.MouseLeave:Connect(function()
            CoreGUIButton.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
        end)

        CoreGUIButton.MouseButton1Click:Connect(callback)
    end
end

return Lib
