--[[
    Bonny Hub | MM2 Script
    ЧАСТЬ 1: GUI, дизайн, вкладки, элементы
    Вставь ЧАСТЬ 2 после этого кода
--]]

if _G.BonnyHubLoaded then
    game:GetService("CoreGui"):FindFirstChild("BonnyHub"):Destroy()
end
_G.BonnyHubLoaded = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- ============ ЦВЕТА ============
local THEME = {
    Background   = Color3.fromRGB(139, 0, 30),
    Sidebar      = Color3.fromRGB(115, 0, 25),
    Element      = Color3.fromRGB(160, 20, 50),
    ElementHover = Color3.fromRGB(180, 30, 60),
    Text         = Color3.fromRGB(255, 255, 255),
    TextDim      = Color3.fromRGB(230, 180, 190)
}

-- ============ GUI ============
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BonnyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = game:GetService("CoreGui")
else
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ScreenGui.Parent then
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
end

-- ============ ОСНОВНОЙ ФРЕЙМ ============
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 480, 0, 280)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -140)
MainFrame.BackgroundColor3 = THEME.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- ============ ЗАГОЛОВОК ============
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 32)
TitleBar.BackgroundColor3 = THEME.Sidebar
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 25, 1, 0)
Logo.Position = UDim2.new(0, 10, 0, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "★"
Logo.TextColor3 = THEME.Text
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 16
Logo.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Position = UDim2.new(0, 32, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "BONNY HUB"
Title.TextColor3 = THEME.Text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- ============ КНОПКИ УПРАВЛЕНИЯ (только − и ×) ============
local function CreateTitleBtn(symbol, xOffset, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 22, 0, 22)
    Btn.Position = UDim2.new(1, xOffset, 0.5, -11)
    Btn.BackgroundTransparency = 1
    Btn.Text = symbol
    Btn.TextColor3 = THEME.Text
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 16
    Btn.Parent = TitleBar
    Btn.MouseButton1Click:Connect(callback)
    Btn.MouseEnter:Connect(function() Btn.TextColor3 = Color3.fromRGB(255, 200, 200) end)
    Btn.MouseLeave:Connect(function() Btn.TextColor3 = THEME.Text end)
    return Btn
end

-- Свернуть (−)
CreateTitleBtn("−", -55, function()
    MainFrame.Visible = false
    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Name = "OpenBtn"
    OpenBtn.Size = UDim2.new(0, 100, 0, 30)
    OpenBtn.Position = UDim2.new(0, 20, 0.5, -15)
    OpenBtn.BackgroundColor3 = THEME.Background
    OpenBtn.Text = "★ Bonny Hub"
    OpenBtn.TextColor3 = THEME.Text
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.TextSize = 13
    OpenBtn.BorderSizePixel = 0
    OpenBtn.Parent = ScreenGui
    local OC = Instance.new("UICorner") OC.CornerRadius = UDim.new(0, 8) OC.Parent = OpenBtn
    OpenBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        OpenBtn:Destroy()
    end)
end)

-- Закрыть (×)
CreateTitleBtn("×", -28, function()
    ScreenGui:Destroy()
    _G.BonnyHubLoaded = false
end)

-- ============ САЙДБАР ============
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 140, 1, -42)
Sidebar.Position = UDim2.new(0, 8, 0, 38)
Sidebar.BackgroundColor3 = THEME.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 3)
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

local SidebarPad = Instance.new("UIPadding")
SidebarPad.PaddingTop = UDim.new(0, 8)
SidebarPad.PaddingLeft = UDim.new(0, 6)
SidebarPad.PaddingRight = UDim.new(0, 6)
SidebarPad.Parent = Sidebar

-- ============ КОНТЕНТ ============
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -160, 1, -50)
Content.Position = UDim2.new(0, 152, 0, 44)
Content.BackgroundColor3 = THEME.Sidebar
Content.BorderSizePixel = 0
Content.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = Content

-- ============ ВКЛАДКИ ============
local Tabs = {}
local TabButtons = {}

local function CreateTab(name, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 28)
    TabBtn.BackgroundColor3 = THEME.Sidebar
    TabBtn.Text = "  " .. (icon or "★") .. "  " .. name
    TabBtn.TextColor3 = THEME.TextDim
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.TextSize = 12
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = Sidebar

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = TabBtn

    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Size = UDim2.new(1, -16, 1, -16)
    TabContent.Position = UDim2.new(0, 8, 0, 8)
    TabContent.BackgroundTransparency = 1
    TabContent.BorderSizePixel = 0
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabContent.ScrollBarThickness = 3
    TabContent.ScrollBarImageColor3 = THEME.Text
    TabContent.Visible = false
    TabContent.Parent = Content

    local CList = Instance.new("UIListLayout")
    CList.Padding = UDim.new(0, 5)
    CList.SortOrder = Enum.SortOrder.LayoutOrder
    CList.Parent = TabContent

    Tabs[name] = TabContent
    TabButtons[name] = TabBtn

    TabBtn.MouseButton1Click:Connect(function()
        for _, tab in pairs(Tabs) do tab.Visible = false end
        for _, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = THEME.Sidebar
            btn.TextColor3 = THEME.TextDim
        end
        TabContent.Visible = true
        TabBtn.BackgroundColor3 = THEME.Element
        TabBtn.TextColor3 = THEME.Text
    end)

    TabBtn.MouseEnter:Connect(function()
        if TabContent.Visible == false then
            TabBtn.BackgroundColor3 = THEME.ElementHover
        end
    end)
    TabBtn.MouseLeave:Connect(function()
        if TabContent.Visible == false then
            TabBtn.BackgroundColor3 = THEME.Sidebar
        end
    end)

    return TabContent
end

-- ============ ЭЛЕМЕНТЫ ============
local function CreateSection(parent, text)
    local Sec = Instance.new("TextLabel")
    Sec.Size = UDim2.new(1, 0, 0, 22)
    Sec.BackgroundTransparency = 1
    Sec.Text = "  ⚡ " .. text
    Sec.TextColor3 = THEME.Text
    Sec.Font = Enum.Font.GothamBold
    Sec.TextSize = 12
    Sec.TextXAlignment = Enum.TextXAlignment.Left
    Sec.Parent = parent
    return Sec
end

local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 30)
    Btn.BackgroundColor3 = THEME.Element
    Btn.Text = "  " .. text
    Btn.TextColor3 = THEME.Text
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 12
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.BorderSizePixel = 0
    Btn.Parent = parent

    local C = Instance.new("UICorner") C.CornerRadius = UDim.new(0, 6) C.Parent = Btn

    Btn.MouseEnter:Connect(function() Btn.BackgroundColor3 = THEME.ElementHover end)
    Btn.MouseLeave:Connect(function() Btn.BackgroundColor3 = THEME.Element end)
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function CreateToggle(parent, text, default, callback)
    local state = default or false
    local Frame = Instance.new("TextButton")
    Frame.Size = UDim2.new(1, 0, 0, 30)
    Frame.BackgroundColor3 = THEME.Element
    Frame.Text = "  " .. text
    Frame.TextColor3 = THEME.Text
    Frame.Font = Enum.Font.Gotham
    Frame.TextSize = 12
    Frame.TextXAlignment = Enum.TextXAlignment.Left
    Frame.BorderSizePixel = 0
    Frame.Parent = parent

    local C = Instance.new("UICorner") C.CornerRadius = UDim.new(0, 6) C.Parent = Frame

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 8, 0, 8)
    Indicator.Position = UDim2.new(1, -18, 0.5, -4)
    Indicator.BackgroundColor3 = state and Color3.fromRGB(0, 220, 100) or Color3.fromRGB(80, 80, 80)
    Indicator.BorderSizePixel = 0
    Indicator.Parent = Frame
    local IC = Instance.new("UICorner") IC.CornerRadius = UDim.new(1, 0) IC.Parent = Indicator

    Frame.MouseButton1Click:Connect(function()
        state = not state
        Indicator.BackgroundColor3 = state and Color3.fromRGB(0, 220, 100) or Color3.fromRGB(80, 80, 80)
        if callback then callback(state) end
    end)
    Frame.MouseEnter:Connect(function() Frame.BackgroundColor3 = THEME.ElementHover end)
    Frame.MouseLeave:Connect(function() Frame.BackgroundColor3 = THEME.Element end)
    return Frame
end

-- ============ СОЗДАНИЕ ВКЛАДОК ============
local MainTab   = CreateTab("Main", "★")
local VisualTab = CreateTab("Visual", "👁")
local TrollTab  = CreateTab("Troll", "☠")

-- ============ ФУНКЦИИ ДЛЯ ЧАСТИ 2 ============
-- Экспортируем всё нужное, чтобы использовать во второй части
_G.BonnyHub = {
    ScreenGui  = ScreenGui,
    MainFrame  = MainFrame,
    MainTab    = MainTab,
    VisualTab  = VisualTab,
    TrollTab   = TrollTab,
    TabButtons = TabButtons,
    CreateSection = CreateSection,
    CreateButton  = CreateButton,
    CreateToggle  = CreateToggle,
    THEME = THEME,
    LocalPlayer = LocalPlayer,
    Players = Players,
    RunService = RunService,
    StarterGui = StarterGui
}

print("[Bonny Hub] Часть 1 загружена (GUI готов)")
--[[
    Bonny Hub | MM2 Script
    ЧАСТЬ 2: Функции (Main, Visual, Troll)
    Вставь ПОСЛЕ части 1
--]]

local H = _G.BonnyHub
if not H then
    warn("[Bonny Hub] Сначала запусти ЧАСТЬ 1!")
    return
end

local LocalPlayer = H.LocalPlayer
local Players = H.Players
local RunService = H.RunService
local StarterGui = H.StarterGui
local MainTab = H.MainTab
local VisualTab = H.VisualTab
local TrollTab = H.TrollTab
local CreateSection = H.CreateSection
local CreateButton = H.CreateButton
local CreateToggle = H.CreateToggle
local TabButtons = H.TabButtons

-- ============ ВКЛАДКА MAIN ============
CreateSection(MainTab, "Main Features")

CreateButton(MainTab, "🗡️ Auto Pickup Knife", function()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Tool") then
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                obj.Parent = char
                break
            end
        end
    end
end)

CreateButton(MainTab, "🔫 Auto Pickup Gun", function()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Tool") and (obj.Name:lower():find("gun") or obj.Name:lower():find("revolver")) then
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                obj.Parent = char
                break
            end
        end
    end
end)

CreateButton(MainTab, "📍 Teleport to Nearest Weapon", function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local closest, dist = nil, math.huge
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
            local d = (char.HumanoidRootPart.Position - obj.Handle.Position).Magnitude
            if d < dist then closest = obj; dist = d end
        end
    end
    if closest and closest:FindFirstChild("Handle") then
        char.HumanoidRootPart.CFrame = closest.Handle.CFrame + Vector3.new(0, 3, 0)
        wait(0.1)
        closest.Parent = char
    end
end)

CreateButton(MainTab, "🏃 Teleport to Safe Place", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(0, 500, 0)
    end
end)

CreateToggle(MainTab, "💀 Auto Kill", false, function(state) _G.BonnyAutoKill = state end)

-- ============ ОПРЕДЕЛЕНИЕ РОЛИ ============
local function GetRole(plr)
    if plr == LocalPlayer then return "LocalPlayer" end

    local char = plr.Character
    if not char then return "Innocent" end

    local function hasKnife(container)
        for _, item in pairs(container:GetChildren()) do
            if item:IsA("Tool") then
                local n = item.Name:lower()
                if n:find("knife") or n:find("sword") or n:find("m9") or n:find("dagger") then
                    return true
                end
            end
        end
        return false
    end

    local function hasGun(container)
        for _, item in pairs(container:GetChildren()) do
            if item:IsA("Tool") then
                local n = item.Name:lower()
                if n:find("gun") or n:find("revolver") or n:find("pistol") then
                    return true
                end
            end
        end
        return false
    end

    local backpack = plr:FindFirstChildOfClass("Backpack")
    if hasGun(char) or (backpack and hasGun(backpack)) then
        return "Sheriff"
    end
    if hasKnife(char) or (backpack and hasKnife(backpack)) then
        return "Murderer"
    end

    return "Innocent"
end

local function GetRoleColor(role)
    if role == "Murderer" then
        return Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 120, 120)
    elseif role == "Sheriff" then
        return Color3.fromRGB(0, 120, 255), Color3.fromRGB(130, 200, 255)
    elseif role == "Innocent" then
        return Color3.fromRGB(0, 220, 80), Color3.fromRGB(150, 255, 180)
    end
    return Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)
end

-- ============ ВКЛАДКА VISUAL ============
CreateSection(VisualTab, "Visual Features")

local espEnabled = false
local espObjects = {}

CreateToggle(VisualTab, "👁️ ESP Players (Aura)", false, function(state)
    espEnabled = state
    if not state then
        for _, data in pairs(espObjects) do
            if data.outer and data.outer.Parent then data.outer:Destroy() end
            if data.inner and data.inner.Parent then data.inner:Destroy() end
            if data.tag and data.tag.Parent then data.tag:Destroy() end
        end
        espObjects = {}
    end
end)

local function createAura(plr)
    if plr == LocalPlayer then return end
    if not plr.Character then return end
    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
    local head = plr.Character:FindFirstChild("Head")
    if not hrp then return end

    local role = GetRole(plr)
    local mainColor, lightColor = GetRoleColor(role)

    local outer = Instance.new("SphereHandleAdornment")
    outer.Name = "BonnyAuraOuter"
    outer.Adornee = hrp
    outer.AlwaysOnTop = false
    outer.Radius = 4
    outer.Color3 = mainColor
    outer.Transparency = 0.75
    outer.ZIndex = 1
    outer.Parent = hrp

    local inner = Instance.new("SphereHandleAdornment")
    inner.Name = "BonnyAuraInner"
    inner.Adornee = hrp
    inner.AlwaysOnTop = false
    inner.Radius = 3
    inner.Color3 = lightColor
    inner.Transparency = 0.85
    inner.ZIndex = 2
    inner.Parent = hrp

    local tag
    if head then
        tag = Instance.new("BillboardGui")
        tag.Name = "BonnyTag"
        tag.Adornee = head
        tag.Size = UDim2.new(0, 200, 0, 30)
        tag.StudsOffset = Vector3.new(0, 2.5, 0)
        tag.AlwaysOnTop = true
        tag.Parent = head

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = plr.Name .. " [" .. role .. "]"
        lbl.TextColor3 = mainColor
        lbl.TextStrokeTransparency = 0
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 13
        lbl.Parent = tag
    end

    espObjects[plr] = {outer = outer, inner = inner, tag = tag, hrp = hrp}
end

local function removeAura(plr)
    local data = espObjects[plr]
    if not data then return end
    if data.outer and data.outer.Parent then data.outer:Destroy() end
    if data.inner and data.inner.Parent then data.inner:Destroy() end
    if data.tag and data.tag.Parent then data.tag:Destroy() end
    espObjects[plr] = nil
end

RunService.RenderStepped:Connect(function()
    if not espEnabled then return end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local data = espObjects[plr]
                if not data or not data.outer or not data.outer.Parent
                   or data.hrp ~= plr.Character.HumanoidRootPart then
                    removeAura(plr)
                    createAura(plr)
                else
                    local role = GetRole(plr)
                    local mainColor, lightColor = GetRoleColor(role)
                    if data.outer.Color3 ~= mainColor then
                        data.outer.Color3 = mainColor
                        data.inner.Color3 = lightColor
                        if data.tag then
                            local lbl = data.tag:FindFirstChildOfClass("TextLabel")
                            if lbl then
                                lbl.Text = plr.Name .. " [" .. role .. "]"
                                lbl.TextColor3 = mainColor
                            end
                        end
                    end
                end
            else
                removeAura(plr)
            end
        end
    end

    for plr, _ in pairs(espObjects) do
        if not plr.Parent then removeAura(plr) end
    end
end)

Players.PlayerRemoving:Connect(removeAura)

CreateToggle(VisualTab, "💡 Fullbright", false, function(state)
    local l = game:GetService("Lighting")
    if state then
        l.Ambient = Color3.fromRGB(255, 255, 255)
        l.Brightness = 2
        l.FogEnd = 100000
        l.GlobalShadows = false
    else
        l.Ambient = Color3.fromRGB(70, 70, 70)
        l.Brightness = 1
        l.FogEnd = 1000
        l.GlobalShadows = true
    end
end)

CreateToggle(VisualTab, "🌫️ Remove Fog", false, function(state)
    game:GetService("Lighting").FogEnd = state and 100000 or 1000
end)

-- ============ ВКЛАДКА TROLL ============
CreateSection(TrollTab, "Troll Features")

CreateButton(TrollTab, "🤸 Flip Character", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(180), 0, 0)
    end
end)

local spamDance = false
CreateToggle(TrollTab, "💃 Dance Spam", false, function(state) spamDance = state end)
RunService.Heartbeat:Connect(function()
    if spamDance then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://182435998"
                local load = hum:LoadAnimation(anim)
                load:Play()
            end
        end
    end
end)

local speedEnabled = false
CreateToggle(TrollTab, "⚡ Speed 100", false, function(state)
    speedEnabled = state
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char.Humanoid.WalkSpeed = state and 100 or 16
    end
end)
LocalPlayer.CharacterAdded:Connect(function(char)
    wait(1)
    if speedEnabled then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 100 end
    end
end)

CreateButton(TrollTab, "💬 Chat Spam", function()
    for i = 1, 10 do
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Bonny Hub ON TOP 🔥", "All")
        wait(0.5)
    end
end)

CreateButton(TrollTab, "💥 Visual Explosion", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local e = Instance.new("Explosion")
        e.Position = char.HumanoidRootPart.Position
        e.BlastRadius = 5
        e.BlastPressure = 0
        e.Parent = workspace
    end
end)

-- ============ АКТИВАЦИЯ ПЕРВОЙ ВКЛАДКИ ============
for _, btn in pairs(TabButtons) do
    btn.MouseButton1Click:Fire()
    break
end

StarterGui:SetCore("SendNotification", {
    Title = "Bonny Hub",
    Text = "Loaded successfully!",
    Duration = 3
})

print("[Bonny Hub] Часть 2 загружена (функции готовы)")
