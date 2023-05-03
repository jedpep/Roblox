local CoreGuiPath = "Jedpep/CoreGui"
local AssetPath = "Jedpep/CoreGui/assets"

repeat task.wait() until game:IsLoaded()
local getasset = getsynasset or getcustomasset
if syn then
    getasset = getsynasset
end
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
local function getcustomassetfunc(file)
    print(1)
    makefolder(CoreGuiPath)
    makefolder(AssetPath)
	if not isfile(AssetPath..'/'..file) then
        print(2)
        local req = game:HttpGet(("https://raw.githubusercontent.com/jedpep/Roblox/main/CoreGui/assets/%s"):format(file))
		writefile(AssetPath.."/"..file, req)
    end
    print(3)
	return getasset(AssetPath..'/'..file)
end

local ResetGameButtonButton = Instance.new("ImageButton")
local ResetGameButtonTextLabel = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local ResetGameButtonHint = Instance.new("ImageLabel")

ResetGameButtonButton.Name = "ResetGameButtonButton"
ResetGameButtonButton.Parent = game:GetService("CoreGui"):WaitForChild("RobloxGui"):WaitForChild("SettingsShield"):WaitForChild("SettingsShield"):WaitForChild("MenuContainer"):WaitForChild("BottomButtonFrame")
ResetGameButtonButton.BackgroundTransparency = 1.000
ResetGameButtonButton.Position = UDim2.new(0.5, -130, 0.5, 50)
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
ResetGameButtonTextLabel.Text = "Rejoin"
ResetGameButtonTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetGameButtonTextLabel.TextScaled = true
ResetGameButtonTextLabel.TextSize = 24.000
ResetGameButtonTextLabel.TextWrapped = true

UITextSizeConstraint.Parent = ResetGameButtonTextLabel
UITextSizeConstraint.MaxTextSize = 24

ResetGameButtonHint.Name = "ResetGameButtonHint"
ResetGameButtonHint.Parent = ResetGameButtonButton
ResetGameButtonHint.Image = getcustomassetfunc("RejoinIcon.png")
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
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
end)