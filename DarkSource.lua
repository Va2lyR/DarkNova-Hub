-- تحميل Redz UI
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Redz-UI/Redz-UI-V2/main/RedzUI.lua"))()

-- إنشاء نافذة واجهة المستخدم
local window = UI:CreateWindow("Murder Mystery 2 Helper")

-- الكشف عن الميردر، الشريف، والبرئ
local function revealRole(role)
    if role == "Murderer" then
        print("تم كشف الميردر!")
        -- هنا يمكنك إضافة الكود للكشف عن الميردر
    elseif role == "Sheriff" then
        print("تم كشف الشريف!")
        -- هنا يمكنك إضافة الكود للكشف عن الشريف
    elseif role == "Innocent" then
        print("تم كشف البرئ!")
        -- هنا يمكنك إضافة الكود للكشف عن البرئ
    end
end

-- إنشاء الأزرار للكشف عن الأدوار
local murdererButton = window:CreateButton("كشف الميردر", function()
    revealRole("Murderer")
end)

local sheriffButton = window:CreateButton("كشف الشريف", function()
    revealRole("Sheriff")
end)

local innocentButton = window:CreateButton("كشف البرئ", function()
    revealRole("Innocent")
end)

-- خطوط لتحديد الأدوار
local function createRoleLine(role)
    if role == "Murderer" then
        print("تم تحديد خط للميردر!")
        -- هنا يمكنك إضافة الكود لتحديد مكان الميردر
    elseif role == "Sheriff" then
        print("تم تحديد خط للشريف!")
        -- هنا يمكنك إضافة الكود لتحديد مكان الشريف
    elseif role == "Innocent" then
        print("تم تحديد خط للبرئ!")
        -- هنا يمكنك إضافة الكود لتحديد مكان البرئ
    end
end

-- إضافة الأزرار لخطوط الأدوار
local murdererLine = window:CreateLine("خط للميردر", function()
    createRoleLine("Murderer")
end)

local sheriffLine = window:CreateLine("خط للشريف", function()
    createRoleLine("Sheriff")
end)

local innocentLine = window:CreateLine("خط للبرئ", function()
    createRoleLine("Innocent")
end)

-- التنقل إلى السلاح (إذا كنت شريف أو ميردر)
local function teleportToWeapon()
    local player = game.Players.LocalPlayer
    local weapon = nil

    -- تحقق من دور اللاعب
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        local role = player:FindFirstChild("Role") and player.Role.Value or "Innocent"

        -- العثور على السلاح بناءً على الدور
        if role == "Murderer" then
            weapon = game.ServerStorage.MurderWeapon -- تأكد من أن السلاح موجود في ServerStorage
        elseif role == "Sheriff" then
            weapon = game.ServerStorage.SheriffWeapon -- تأكد من أن السلاح موجود في ServerStorage
        end

        if weapon then
            -- التنقل إلى السلاح
            player.Character.HumanoidRootPart.CFrame = weapon.CFrame
            print("تم التنقل إلى السلاح!")
        else
            print("لا يوجد سلاح لهذا الدور!")
        end
    end
end

-- زر التنقل إلى السلاح
local weaponButton = window:CreateButton("التنقل إلى السلاح", function()
    teleportToWeapon()
end)

-- إظهار واجهة المستخدم
UI:Show()
