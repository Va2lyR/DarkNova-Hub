-- 🟩 DarkNova Hub Manual Spam Button with Customization
local UserInputService = game:GetService("UserInputService")
local spamming = false
local spamDelay = 0.07  -- Delay between keypresses (customizable)
local maxSpams = 0     -- Number of times to spam before auto-stop (0 for infinite)
local spamCount = 0    -- Counter for how many times the button has been pressed

-- 🖼️ DarkNova Hub GUI
local manualGui = Instance.new("ScreenGui", game.CoreGui)
manualGui.Name = "DarkNovaHubGui"
manualGui.ResetOnSpawn = false

-- 📜 Button to toggle Manual Spam
local button = Instance.new("TextButton", manualGui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.87, 0)
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.BackgroundTransparency = 0.3
button.BorderSizePixel = 0
button.Text = "Manual Spam: OFF"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.Active = true
button.Draggable = true
button.ClipsDescendants = true
button.AnchorPoint = Vector2.new(0.5, 0.5)

local corner = Instance.new("UICorner", button)
corner.CornerRadius = UDim.new(0, 12)

-- 📊 Indicator Label to show spam status
local indicator = Instance.new("TextLabel", manualGui)
indicator.Size = UDim2.new(0, 200, 0, 30)
indicator.Position = UDim2.new(0.5, -100, 0.75, 0)
indicator.BackgroundTransparency = 1
indicator.Text = "Manual Spam: OFF"
indicator.TextColor3 = Color3.fromRGB(255, 255, 255)
indicator.TextScaled = true
indicator.Font = Enum.Font.GothamBold
indicator.AnchorPoint = Vector2.new(0.5, 0.5)

-- 🧰 Customizable settings: Spam Delay, Max Spams
local settingsTab = Instance.new("Frame", manualGui)
settingsTab.Size = UDim2.new(0, 250, 0, 150)
settingsTab.Position = UDim2.new(0.5, -125, 0.5, -75)
settingsTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
settingsTab.BackgroundTransparency = 0.6
settingsTab.Visible = false

local delayLabel = Instance.new("TextLabel", settingsTab)
delayLabel.Size = UDim2.new(0, 250, 0, 30)
delayLabel.Position = UDim2.new(0, 0, 0, 0)
delayLabel.Text = "Spam Delay: " .. spamDelay .. "s"
delayLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
delayLabel.TextScaled = true
delayLabel.Font = Enum.Font.GothamBold

local delaySlider = Instance.new("Slider", settingsTab)
delaySlider.Size = UDim2.new(0, 200, 0, 20)
delaySlider.Position = UDim2.new(0.5, -100, 0.25, 0)
delaySlider.MinValue = 0.02
delaySlider.MaxValue = 0.2
delaySlider.Value = spamDelay
delaySlider.OnValueChanged = function(value)
    spamDelay = value
    delayLabel.Text = "Spam Delay: " .. string.format("%.2f", value) .. "s"
end

local maxSpamsInput = Instance.new("TextBox", settingsTab)
maxSpamsInput.Size = UDim2.new(0, 200, 0, 30)
maxSpamsInput.Position = UDim2.new(0.5, -100, 0.5, 0)
maxSpamsInput.PlaceholderText = "Max Spams (0 for infinite)"
maxSpamsInput.Text = tostring(maxSpams)
maxSpamsInput.TextChanged:Connect(function()
    maxSpams = tonumber(maxSpamsInput.Text) or 0
end)

-- 🛠️ Toggle the spam feature
button.MouseButton1Click:Connect(function()
    spamming = not spamming
    button.Text = spamming and "Manual Spam: ON" or "Manual Spam: OFF"
    button.BackgroundColor3 = spamming and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(40, 40, 40)
    indicator.Text = spamming and "Manual Spam: ON" or "Manual Spam: OFF"
    indicator.TextColor3 = spamming and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 255, 255)

    spamCount = 0
    while spamming and (maxSpams == 0 or spamCount < maxSpams) do
        task.wait(spamDelay)
        keypress(0x46)
        task.wait(0.02)
        keyrelease(0x46)
        spamCount = spamCount + 1
    end
end)

-- 🔧 Shortcut to toggle Manual Spam
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.M then
        spamming = not spamming
        button.Text = spamming and "Manual Spam: ON" or "Manual Spam: OFF"
        button.BackgroundColor3 = spamming and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(40, 40, 40)
        indicator.Text = spamming and "Manual Spam: ON" or "Manual Spam: OFF"
        indicator.TextColor3 = spamming and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 255, 255)

        spamCount = 0
        while spamming and (maxSpams == 0 or spamCount < maxSpams) do
            task.wait(spamDelay)
            keypress(0x46)
            task.wait(0.02)
            keyrelease(0x46)
            spamCount = spamCount + 1
        end
    end
end)

-- 🛠️ Settings toggle button
local settingsButton = Instance.new("TextButton", manualGui)
settingsButton.Size = UDim2.new(0, 100, 0, 30)
settingsButton.Position = UDim2.new(0.5, -50, 0.7, 0)
settingsButton.Text = "Settings"
settingsButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
settingsButton.BackgroundTransparency = 0.3
settingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsButton.TextScaled = true
settingsButton.Font = Enum.Font.GothamBold
settingsButton.AnchorPoint = Vector2.new(0.5, 0.5)

settingsButton.MouseButton1Click:Connect(function()
    settingsTab.Visible = not settingsTab.Visible
end)

-- 🖼️ DarkNova Hub Logo
local logoGui = Instance.new("ScreenGui", game.CoreGui)
logoGui.Name = "DarkNovaLogo"
logoGui.ResetOnSpawn = false

local image = Instance.new("ImageLabel", logoGui)
image.Size = UDim2.new(0, 140, 0, 140)
image.Position = UDim2.new(0, 30, 0, 30)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://15725622983"  -- ✅ Place your logo image ID here
image.ImageTransparency = 0.1
image.ZIndex = 10
