local UI = {} do
    UI.Name = ""
    UI.Transparency = 0

    UI.MakeUI = function(Name)
        UI.Name = Name
        local screenGui = Instance.new("ScreenGui")
        screenGui.Parent = game:GetService("CoreGui")
        screenGui.Name = UI.Name

        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(1, 0, 1, 0)
        mainFrame.Position = UDim2.new(0, 0, 0, 0)
        mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        mainFrame.Parent = screenGui
        mainFrame.Transparency = UI.Transparency
        mainFrame.Name = "MainFrame"

        local mainFrame = Instance.new("Frame")
        mainFrame.Size = UDim2.new(1, 0, 1, 0)
        mainFrame.AnchorPoint = Vector2.new(0,1)
        mainFrame.Position = UDim2.new(0, 0, 0, 0)
        mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        mainFrame.Parent = screenGui
        mainFrame.Transparency = UI.Transparency
        mainFrame.Name = "MainFrame"
        mainFrame.BorderSizePixel = 0
    end

    function UI:Destroy()
        local ui = game:GetService("CoreGui"):FindFirstChild(UI.Name)
        if ui then
            ui:Destroy()
        end
    end

    UI.MakeTextLabel = function(Name, yPos)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.5, 0, 0.1, 0)
        label.AnchorPoint = Vector2.new(0.2, 0.5)
        label.Position = UDim2.new(0.5, 0, yPos, 0)
        label.Text = Name
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.BackgroundTransparency = 1
        label.TextScaled = true
        label.Font = Enum.Font.SourceSansBold
        label.Parent = game:GetService("CoreGui"):FindFirstChild(UI.Name)["MainFrame"]
        label.Name = Name
    end

    UI.EditTextLabel = function(Name, NewText)
        local Label = game:GetService("CoreGui"):FindFirstChild(UI.Name)["MainFrame"]:FindFirstChild(Name)
        if Label then
            Label.Text = NewText
        end
    end

    UI.MakeImage = function(Asset)
        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Size = UDim2.new(0, 100, 0, 100)
        imageLabel.AnchorPoint = Vector2.new(0.5, 0)
        imageLabel.Position = UDim2.new(0.5, 0, 0, 0)
        imageLabel.BackgroundTransparency = 1
        imageLabel.Image = Asset
        imageLabel.Parent = game:GetService("CoreGui"):FindFirstChild(UI.Name)["MainFrame"]
    end

    UI.Setup = function(Name, Labels, Image)
        UI.MakeUI(Name)
        for i, v in pairs(Labels) do
            local yPos = 0.1 + (i * 0.1)
            UI.MakeTextLabel(v, yPos)
        end
        if Image then
            UI.MakeImage(Image)
        end
    end
end

return UI
