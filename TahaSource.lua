-- Orion UI Load
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/OrionLibrary/Orion/main/source.lua"))()
local Window = OrionLib:MakeWindow({
    Name = "Taha Scripter",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "TahaScripterConfig"
})

-- Info Tab
local InfoTab = Window:MakeTab({ Name = "Info", Icon = "rbxassetid://4483345998", PremiumOnly = false })
InfoTab:AddParagraph("Discord", "https://discord.gg/yourserver")
InfoTab:AddParagraph("Developers", "Taha Scripter")
InfoTab:AddParagraph("Features", "- Aimbot\n- Melee Aura\n- Gun Aura\n- Full Bright\n- No Fog\n- Infinite Jump\n- FOV Adjustments")

-- Main Tab
local MainTab = Window:MakeTab({ Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false })

-- Weapons Section
local WeaponsSection = MainTab:AddSection({ Name = "Weapons" })

WeaponsSection:AddToggle({
    Name = "Melee Aura",
    Default = false,
    Callback = function(val)
        print("Melee Aura:", val)
        -- ضع كود الميلي هنا
    end
})

WeaponsSection:AddToggle({
    Name = "Gun Aura",
    Default = false,
    Callback = function(val)
        print("Gun Aura:", val)
        -- ضع كود إطلاق السلاح التلقائي هنا
    end
})

-- Combat Section
local CombatSection = MainTab:AddSection({ Name = "Combat" })

local AimPart = "Head"
local AimbotPower = 50

CombatSection:AddToggle({
    Name = "Aimbot",
    Default = false,
    Callback = function(val)
        print("Aimbot Enabled:", val)
        -- أضف كود الايم بوت هنا
    end
})

CombatSection:AddDropdown({
    Name = "Aim Part",
    Default = "Head",
    Options = {"Head", "Chest"},
    Callback = function(val)
        AimPart = val
        print("Aimbot Target:", val)
    end
})

CombatSection:AddSlider({
    Name = "Aimbot Strength",
    Min = 1,
    Max = 100,
    Default = 50,
    Increment = 1,
    ValueName = "%",
    Callback = function(val)
        AimbotPower = val
        print("Aimbot Strength:", val)
    end
})

-- Local Tab
local LocalTab = Window:MakeTab({ Name = "Local", Icon = "rbxassetid://4483345998", PremiumOnly = false })

LocalTab:AddToggle({
    Name = "Full Bright",
    Default = false,
    Callback = function(val)
        if val then
            game:GetService("Lighting").Brightness = 5
            game:GetService("Lighting").ClockTime = 14
            game:GetService("Lighting").FogEnd = 100000
        end
    end
})

LocalTab:AddToggle({
    Name = "No Fog",
    Default = false,
    Callback = function(val)
        game:GetService("Lighting").FogEnd = val and 100000 or 100
    end
})

LocalTab:AddToggle({
    Name = "No Clip",
    Default = false,
    Callback = function(val)
        noclip = val
        game:GetService("RunService").Stepped:Connect(function()
            if noclip and game.Players.LocalPlayer.Character then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
})

LocalTab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(val)
        InfiniteJumpEnabled = val
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if InfiniteJumpEnabled and game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end
        end)
    end
})

LocalTab:AddSlider({
    Name = "FOV",
    Min = 70,
    Max = 120,
    Default = 90,
    Increment = 1,
    ValueName = "°",
    Callback = function(val)
        game:GetService("Workspace").CurrentCamera.FieldOfView = val
    end
})

-- Start UI
OrionLib:Init()
