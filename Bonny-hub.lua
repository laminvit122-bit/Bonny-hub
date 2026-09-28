--[[
    BONNY HUB | MM2 Premium Script
    PART 1: GUI + Tabs + Elements
--]]

if _G.BonnyHubLoaded then
    game:GetService("CoreGui"):FindFirstChild("BonnyHub"):Destroy()
end
_G.BonnyHubLoaded = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local THEME = {
    Background    = Color3.fromRGB(18, 10, 15),
    Background2   = Color3.fromRGB(35, 12, 22),
    Sidebar       = Color3.fromRGB(28, 12, 20),
    Element       = Color3.fromRGB(45, 20, 32),
    ElementHover  = Color3.fromRGB(65, 28, 45),
    Accent        = Color3.fromRGB(255, 30, 80),
    Gold          = Color3.fromRGB(255, 200, 60),
    Text          = Color3.fromRGB(255, 255, 255),
    TextDim       = Color3.fromRGB(200, 160, 180),
    Success       = Color3.fromRGB(0, 220, 130)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BonnyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

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

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = THEME.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local BG = Instance.new("UIGradient")
BG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.Background2),
    ColorSequenceKeypoint.new(0.5, THEME.Background),
    ColorSequenceKeypoint.new(1, THEME.Background2)
})
BG.Rotation = 45
BG.Parent = MainFrame

local GlowStroke = Instance.new("UIStroke")
GlowStroke.Color = THEME.Accent
GlowStroke.Thickness = 1.5
GlowStroke.Transparency = 0.3
GlowStroke.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundColor3 = THEME.Sidebar
TitleBar.BackgroundTransparency = 0.3
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 14)
TitleCorner.Parent = TitleBar

local TBottom = Instance.new("Frame")
TBottom.Size = UDim2.new(1, 0, 0, 14)
TBottom.Position = UDim2.new(0, 0, 1, -14)
TBottom.BackgroundColor3 = THEME.Sidebar
TBottom.BackgroundTransparency = 0.3
TBottom.BorderSizePixel = 0
TBottom.Parent = TitleBar

local LogoFrame = Instance.new("Frame")
LogoFrame.Size = UDim2.new(0, 30, 0, 30)
LogoFrame.Position = UDim2.new(0, 12, 0.5, -15)
LogoFrame.BackgroundColor3 = THEME.Accent
LogoFrame.BorderSizePixel = 0
LogoFrame.Parent = TitleBar

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 8)
LogoCorner.Parent = LogoFrame

local LogoGrad = Instance.new("UIGradient")
LogoGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.Accent),
    ColorSequenceKeypoint.new(1, THEME.Gold)
})
LogoGrad.Rotation = 45
LogoGrad.Parent = LogoFrame

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(1, 0, 1, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "★"
Logo.TextColor3 = THEME.Text
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 18
Logo.Parent = LogoFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -200, 0, 22)
Title.Position = UDim2.new(0, 52, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "BONNY HUB"
Title.TextColor3 = THEME.Text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -200, 0, 14)
SubTitle.Position = UDim2.new(0, 52, 0, 23)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "PREMIUM  •  MM2"
SubTitle.TextColor3 = THEME.TextDim
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 9
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = TitleBar

local function CreateTitleBtn(symbol, xOffset, color, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 26, 0, 26)
    Btn.Position = UDim2.new(1, xOffset, 0.5, -13)
    Btn.BackgroundColor3 = THEME.Element
    Btn.BackgroundTransparency = 0.3
    Btn.Text = symbol
    Btn.TextColor3 = color
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 15
    Btn.BorderSizePixel = 0
    Btn.AutoButtonColor = false
    Btn.Parent = TitleBar
    local C = Instance.new("UICorner") C.CornerRadius = UDim.new(0, 7) C.Parent = Btn
    Btn.MouseEnter:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play() end)
    Btn.MouseLeave:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.3}):Play() end)
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

CreateTitleBtn("−", -70, THEME.TextDim, function()
    MainFrame.Visible = false
    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Name = "OpenBtn"
    OpenBtn.Size = UDim2.new(0, 110, 0, 34)
    OpenBtn.Position = UDim2.new(0, 20, 0.5, -17)
    OpenBtn.BackgroundColor3 = THEME.Background2
    OpenBtn.Text = "★ Bonny Hub"
    OpenBtn.TextColor3 = THEME.Text
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.TextSize = 13
    OpenBtn.BorderSizePixel = 0
    OpenBtn.Parent = ScreenGui
    local OC = Instance.new("UICorner") OC.CornerRadius = UDim.new(0, 9) OC.Parent = OpenBtn
    local OS = Instance.new("UIStroke") OS.Color = THEME.Accent OS.Thickness = 1.5 OS.Parent = OpenBtn
    OpenBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        OpenBtn:Destroy()
    end)
end)

CreateTitleBtn("×", -40, Color3.fromRGB(255, 80, 80), function()
    ScreenGui:Destroy()
    _G.BonnyHubLoaded = false
end)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, -54)
Sidebar.Position = UDim2.new(0, 10, 0, 48)
Sidebar.BackgroundColor3 = THEME.Sidebar
Sidebar.BackgroundTransparency = 0.2
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

local SidebarStroke = Instance.new("UIStroke")
SidebarStroke.Color = THEME.Accent
SidebarStroke.Thickness = 1
SidebarStroke.Transparency = 0.7
SidebarStroke.Parent = Sidebar

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(1, -20, 0, 24)
VersionLabel.Position = UDim2.new(0, 10, 0, 8)
VersionLabel.BackgroundColor3 = THEME.Element
VersionLabel.BackgroundTransparency = 0.2
VersionLabel.Text = "⚡ BONNY v2.0"
VersionLabel.TextColor3 = THEME.Gold
VersionLabel.Font = Enum.Font.GothamBold
VersionLabel.TextSize = 11
VersionLabel.BorderSizePixel = 0
VersionLabel.Parent = Sidebar
local VLC = Instance.new("UICorner") VLC.CornerRadius = UDim.new(0, 6) VLC.Parent = VersionLabel

local TabListFrame = Instance.new("Frame")
TabListFrame.Size = UDim2.new(1, -20, 1, -44)
TabListFrame.Position = UDim2.new(0, 10, 0, 36)
TabListFrame.BackgroundTransparency = 1
TabListFrame.Parent = Sidebar

local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 5)
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Parent = TabListFrame

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -180, 1, -60)
Content.Position = UDim2.new(0, 170, 0, 48)
Content.BackgroundColor3 = THEME.Sidebar
Content.BackgroundTransparency = 0.2
Content.BorderSizePixel = 0
Content.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = Content

local ContentStroke = Instance.new("UIStroke")
ContentStroke.Color = THEME.Accent
ContentStroke.Thickness = 1
ContentStroke.Transparency = 0.7
ContentStroke.Parent = Content

local Tabs = {}
local TabButtons = {}

local function CreateTab(name, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 32)
    TabBtn.BackgroundColor3 = THEME.Element
    TabBtn.BackgroundTransparency = 0.4
    TabBtn.Text = "  " .. icon .. "   " .. name
    TabBtn.TextColor3 = THEME.TextDim
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.TextSize = 13
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.BorderSizePixel = 0
    TabBtn.AutoButtonColor = false
    TabBtn.Parent = TabListFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = TabBtn

    local Stripe = Instance.new("Frame")
    Stripe.Name = "Stripe"
    Stripe.Size = UDim2.new(0, 3, 0.6, 0)
    Stripe.Position = UDim2.new(0, 0, 0.2, 0)
    Stripe.BackgroundColor3 = THEME.Accent
    Stripe.BorderSizePixel = 0
    Stripe.Visible = false
    Stripe.Parent = TabBtn
    local SC = Instance.new("UICorner") SC.CornerRadius = UDim.new(1, 0) SC.Parent = Stripe

    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Size = UDim2.new(1, -20, 1, -20)
    TabContent.Position = UDim2.new(0, 10, 0, 10)
    TabContent.BackgroundTransparency = 1
    TabContent.BorderSizePixel = 0
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabContent.ScrollBarThickness = 3
    TabContent.ScrollBarImageColor3 = THEME.Accent
    TabContent.Visible = false
    TabContent.Parent = Content

    local CList = Instance.new("UIListLayout")
    CList.Padding = UDim.new(0, 6)
    CList.SortOrder = Enum.SortOrder.LayoutOrder
    CList.Parent = TabContent

    Tabs[name] = TabContent
    TabButtons[name] = TabBtn

    TabBtn.MouseButton1Click:Connect(function()
        for _, tab in pairs(Tabs) do tab.Visible = false end
        for _, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = THEME.Element
            btn.BackgroundTransparency = 0.4
            btn.TextColor3 = THEME.TextDim
            local s = btn:FindFirstChild("Stripe")
            if s then s.Visible = false end
        end
        TabContent.Visible = true
        TabBtn.BackgroundColor3 = THEME.Accent
        TabBtn.BackgroundTransparency = 0.15
        TabBtn.TextColor3 = THEME.Text
        local s = TabBtn:FindFirstChild("Stripe")
        if s then s.Visible = true end
    end)

    TabBtn.MouseEnter:Connect(function()
        if TabContent.Visible == false then
            TweenService:Create(TabBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play()
        end
    end)
    TabBtn.MouseLeave:Connect(function()
        if TabContent.Visible == false then
            TweenService:Create(TabBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.4}):Play()
        end
    end)

    return TabContent
end

local function CreateSection(parent, text)
    local Wrap = Instance.new("Frame")
    Wrap.Size = UDim2.new(1, 0, 0, 26)
    Wrap.BackgroundTransparency = 1
    Wrap.Parent = parent

    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, 0, 0, 1)
    Line.Position = UDim2.new(0, 0, 0.5, 0)
    Line.BackgroundColor3 = THEME.Accent
    Line.BackgroundTransparency = 0.6
    Line.BorderSizePixel = 0
    Line.Parent = Wrap

    local Sec = Instance.new("TextLabel")
    Sec.Name = "SectionLabel"
    Sec.Size = UDim2.new(0, 220, 1, 0)
    Sec.Position = UDim2.new(0, 8, 0, 0)
    Sec.BackgroundColor3 = THEME.Sidebar
    Sec.BackgroundTransparency = 0.1
    Sec.Text = "  ⚡  " .. text
    Sec.TextColor3 = THEME.Gold
    Sec.Font = Enum.Font.GothamBold
    Sec.TextSize = 12
    Sec.TextXAlignment = Enum.TextXAlignment.Left
    Sec.BorderSizePixel = 0
    Sec.Parent = Wrap
    local SC = Instance.new("UICorner") SC.CornerRadius = UDim.new(0, 6) SC.Parent = Sec
    return Wrap
end

local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Btn.BackgroundColor3 = THEME.Element
    Btn.BackgroundTransparency = 0.15
    Btn.Text = "  " .. text
    Btn.TextColor3 = THEME.Text
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 12
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.BorderSizePixel = 0
    Btn.AutoButtonColor = false
    Btn.Parent = parent

    local C = Instance.new("UICorner") C.CornerRadius = UDim.new(0, 8) C.Parent = Btn
    local S = Instance.new("UIStroke") S.Color = THEME.Accent S.Thickness = 1 S.Transparency = 0.85 S.Parent = Btn

    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = THEME.ElementHover, BackgroundTransparency = 0}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = THEME.Element, BackgroundTransparency = 0.15}):Play()
    end)
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function CreateToggle(parent, text, default, callback)
    local state = default or false
    local Frame = Instance.new("TextButton")
    Frame.Size = UDim2.new(1, 0, 0, 32)
    Frame.BackgroundColor3 = THEME.Element
    Frame.BackgroundTransparency = 0.15
    Frame.Text = "  " .. text
    Frame.TextColor3 = THEME.Text
    Frame.Font = Enum.Font.GothamMedium
    Frame.TextSize = 12
    Frame.TextXAlignment = Enum.TextXAlignment.Left
    Frame.BorderSizePixel = 0
    Frame.AutoButtonColor = false
    Frame.Parent = parent

    local C = Instance.new("UICorner") C.CornerRadius = UDim.new(0, 8) C.Parent = Frame
    local S = Instance.new("UIStroke") S.Color = THEME.Accent S.Thickness = 1 S.Transparency = 0.85 S.Parent = Frame

    local SwitchBG = Instance.new("Frame")
    SwitchBG.Size = UDim2.new(0, 36, 0, 18)
    SwitchBG.Position = UDim2.new(1, -46, 0.5, -9)
    SwitchBG.BackgroundColor3 = state and THEME.Success or Color3.fromRGB(60, 40, 50)
    SwitchBG.BorderSizePixel = 0
    SwitchBG.Parent = Frame

    local SBGC = Instance.new("UICorner") SBGC.CornerRadius = UDim.new(1, 0) SBGC.Parent = SwitchBG

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 14, 0, 14)
    Circle.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    Circle.BackgroundColor3 = THEME.Text
    Circle.BorderSizePixel = 0
    Circle.Parent = SwitchBG
    local CC = Instance.new("UICorner") CC.CornerRadius = UDim.new(1, 0) CC.Parent = Circle

    Frame.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(SwitchBG, TweenInfo.new(0.2), {
            BackgroundColor3 = state and THEME.Success or Color3.fromRGB(60, 40, 50)
        }):Play()
        TweenService:Create(Circle, TweenInfo.new(0.2), {
            Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        }):Play()
        if callback then callback(state) end
    end)
    Frame.MouseEnter:Connect(function()
        TweenService:Create(Frame, TweenInfo.new(0.15), {BackgroundColor3 = THEME.ElementHover, BackgroundTransparency = 0}):Play()
    end)
    Frame.MouseLeave:Connect(function()
        TweenService:Create(Frame, TweenInfo.new(0.15), {BackgroundColor3 = THEME.Element, BackgroundTransparency = 0.15}):Play()
    end)
    return Frame
end

-- Tabs order: Main, Visual, Teleports, Troll, Settings (bottom)
local MainTab      = CreateTab("Main", "🏠")
local VisualTab    = CreateTab("Visual", "👁")
local TeleportsTab = CreateTab("Teleports", "📍")
local TrollTab     = CreateTab("Troll", "☠")
local SettingsTab  = CreateTab("Settings", "⚙")

_G.BonnyHub = {
    ScreenGui = ScreenGui, MainFrame = MainFrame,
    MainTab = MainTab, VisualTab = VisualTab, TeleportsTab = TeleportsTab,
    TrollTab = TrollTab, SettingsTab = SettingsTab,
    TabButtons = TabButtons,
    CreateSection = CreateSection, CreateButton = CreateButton, CreateToggle = CreateToggle,
    THEME = THEME, LocalPlayer = LocalPlayer, Players = Players,
    RunService = RunService, StarterGui = StarterGui, TweenService = TweenService
}

print("[Bonny Hub] Part 1 loaded (GUI ready)")
--[[
    BONNY HUB | MM2 Premium Script
    PART 2: Language system + Roles + Main + Visual
--]]

local H = _G.BonnyHub
if not H then warn("[Bonny Hub] Run PART 1 first!") return end

local LocalPlayer   = H.LocalPlayer
local Players       = H.Players
local RunService    = H.RunService
local StarterGui    = H.StarterGui
local MainTab       = H.MainTab
local VisualTab     = H.VisualTab
local CreateSection = H.CreateSection
local CreateButton  = H.CreateButton
local CreateToggle  = H.CreateToggle

-- ============ LANGUAGE SYSTEM ============
local Lang = {
    current = "en",
    strings = {
        en = {
            chatInfo       = "Chat Info",
            chatRoles      = "Show Murderer & Sheriff in Chat",
            visualFeatures = "Visual Features",
            esp            = "ESP Players",
            fullbright     = "Fullbright",
            removeFog      = "Remove Fog",
            roundTimer     = "Round Timer",
            teleports      = "Teleports",
            tpMurderer     = "Teleport to Murderer",
            tpSheriff      = "Teleport to Sheriff",
            tpMap          = "Teleport to Map",
            tpSpawn        = "Teleport to Spawn",
            trollFeatures  = "Troll Features",
            explosionSelf  = "Explosion Self",
            touchFling     = "Touch Fling",
            settings       = "Settings",
            language       = "Language",
            languageEn     = "English",
            languageRu     = "Russian",
            loaded         = "Loaded successfully!",
            roundEnded     = "Round ended",
            roundTime      = "Round time left",
            noTarget       = "Target not found"
        },
        ru = {
            chatInfo       = "Информация в чат",
            chatRoles      = "Показать мардера и шерифа в чат",
            visualFeatures = "Визуальные функции",
            esp            = "ESP игроков",
            fullbright     = "Полная яркость",
            removeFog      = "Убрать туман",
            roundTimer     = "Таймер раунда",
            teleports      = "Телепорты",
            tpMurderer     = "ТП к мардеру",
            tpSheriff      = "ТП к шерифу",
            tpMap          = "ТП на карту",
            tpSpawn        = "ТП на спавн",
            trollFeatures  = "Тролль функции",
            explosionSelf  = "Взрыв себя",
            touchFling     = "Тач-флинг",
            settings       = "Настройки",
            language       = "Язык",
            languageEn     = "Английский",
            languageRu     = "Русский",
            loaded         = "Успешно загружено!",
            roundEnded     = "Раунд закончен",
            roundTime      = "Осталось времени",
            noTarget       = "Цель не найдена"
        }
    }
}

local function L(key) return Lang.strings[Lang.current][key] or key end

_G.BonnyHub.Lang = Lang
_G.BonnyHub.L = L
_G.BonnyHub.LangRefs = {}
_G.BonnyHub.RegisterLang = function(ref, key, prefix)
    table.insert(_G.BonnyHub.LangRefs, {ref = ref, key = key, prefix = prefix})
end

local RegisterLang = _G.BonnyHub.RegisterLang
local LangRefs = _G.BonnyHub.LangRefs

local function ApplyLang()
    for _, entry in ipairs(LangRefs) do
        pcall(function()
            if entry.ref and entry.ref.Parent then
                local pfx = entry.prefix or ""
                if entry.ref.Name == "SectionLabel" then
                    entry.ref.Text = "  ⚡  " .. L(entry.key)
                else
                    entry.ref.Text = "  " .. pfx .. L(entry.key)
                end
            end
        end)
    end
end
_G.BonnyHub.ApplyLang = ApplyLang

-- ============ ROLE DETECTION ============
local function GetRole(plr)
    if plr == LocalPlayer then return "LocalPlayer" end
    local char = plr.Character
    if not char then return "Innocent" end

    local function scan(container, patterns)
        for _, item in pairs(container:GetChildren()) do
            if item:IsA("Tool") then
                local n = item.Name:lower()
                for _, p in ipairs(patterns) do
                    if n:find(p) then return true end
                end
            end
        end
        return false
    end

    local knifePatterns = {"knife", "sword", "m9", "dagger", "blade"}
    local gunPatterns   = {"gun", "revolver", "pistol", "firearm"}

    local backpack = plr:FindFirstChildOfClass("Backpack")
    local charBP   = char:FindFirstChildOfClass("Backpack")

    if scan(char, gunPatterns) or (backpack and scan(backpack, gunPatterns)) or (charBP and scan(charBP, gunPatterns)) then
        return "Sheriff"
    end
    if scan(char, knifePatterns) or (backpack and scan(backpack, knifePatterns)) or (charBP and scan(charBP, knifePatterns)) then
        return "Murderer"
    end
    return "Innocent"
end

local function GetRoleColors(role)
    if role == "Murderer" then
        return Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 130, 130)
    elseif role == "Sheriff" then
        return Color3.fromRGB(0, 100, 255), Color3.fromRGB(120, 180, 255)
    elseif role == "Innocent" then
        return Color3.fromRGB(0, 200, 50), Color3.fromRGB(130, 255, 160)
    end
    return Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)
end

_G.BonnyHub.GetRole = GetRole
_G.BonnyHub.GetRoleColors = GetRoleColors

-- ============ CHAT ============
local function SendChat(msg)
    local RS = game:GetService("ReplicatedStorage")
    local ok = pcall(function()
        RS.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    end)
    if not ok then
        pcall(function()
            game:GetService("TextChatService").TextChannels.RBGeneral:SendAsync(msg)
        end)
    end
end
_G.BonnyHub.SendChat = SendChat

-- ============ MAIN TAB ============
local mainSec = CreateSection(MainTab, L("chatInfo"))
local mainSecLabel = mainSec:FindFirstChild("SectionLabel")
if mainSecLabel then RegisterLang(mainSecLabel, "chatInfo") end

local chatBtn = CreateButton(MainTab, "💬  " .. L("chatRoles"), function()
    local murderers, sheriffs = {}, {}
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local role = GetRole(plr)
            if role == "Murderer" then table.insert(murderers, plr.Name .. "(murder)")
            elseif role == "Sheriff" then table.insert(sheriffs, plr.Name .. "(sheriff)") end
        end
    end
    local parts = {}
    for _, m in ipairs(murderers) do table.insert(parts, m) end
    for _, s in ipairs(sheriffs)  do table.insert(parts, s) end
    local msg = table.concat(parts, " ")
    if msg == "" then msg = "none" end
    msg = msg .. " | Bonny hub"
    SendChat(msg)
end)
RegisterLang(chatBtn, "chatRoles", "💬  ")

-- ============ VISUAL TAB ============
local visSec = CreateSection(VisualTab, L("visualFeatures"))
local visSecLabel = visSec:FindFirstChild("SectionLabel")
if visSecLabel then RegisterLang(visSecLabel, "visualFeatures") end

local espEnabled = false
local espObjects = {}

local espToggle = CreateToggle(VisualTab, "👁️  " .. L("esp"), false, function(state)
    espEnabled = state
    if not state then
        for _, data in pairs(espObjects) do
            if data.highlight and data.highlight.Parent then data.highlight:Destroy() end
            if data.tag and data.tag.Parent then data.tag:Destroy() end
        end
        espObjects = {}
    end
end)
RegisterLang(espToggle, "esp", "👁️  ")

local function createESP(plr)
    if plr == LocalPlayer then return end
    if not plr.Character then return end
    local head = plr.Character:FindFirstChild("Head")
    if not head then return end

    local role = GetRole(plr)
    local outlineColor, fillColor = GetRoleColors(role)

    local hl = Instance.new("Highlight")
    hl.Name = "BonnyESP"
    hl.Adornee = plr.Character
    hl.FillColor = fillColor
    hl.FillTransparency = 0.7
    hl.OutlineColor = outlineColor
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = plr.Character

    local tag = Instance.new("BillboardGui")
    tag.Name = "BonnyTag"
    tag.Adornee = head
    tag.Size = UDim2.new(0, 220, 0, 30)
    tag.StudsOffset = Vector3.new(0, 2.8, 0)
    tag.AlwaysOnTop = true
    tag.Parent = head

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = plr.Name .. " [" .. role .. "]"
    lbl.TextColor3 = fillColor
    lbl.TextStrokeTransparency = 0
    lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.Parent = tag

    espObjects[plr] = {highlight = hl, tag = tag}
end

local function removeESP(plr)
    local data = espObjects[plr]
    if not data then return end
    if data.highlight and data.highlight.Parent then data.highlight:Destroy() end
    if data.tag and data.tag.Parent then data.tag:Destroy() end
    espObjects[plr] = nil
end

RunService.RenderStepped:Connect(function()
    if not espEnabled then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if plr.Character and plr.Character:FindFirstChild("Head") then
                local data = espObjects[plr]
                if not data or not data.highlight or not data.highlight.Parent
                   or data.highlight.Adornee ~= plr.Character then
                    removeESP(plr)
                    createESP(plr)
                else
                    local role = GetRole(plr)
                    local outlineColor, fillColor = GetRoleColors(role)
                    if data.highlight.OutlineColor ~= outlineColor then
                        data.highlight.OutlineColor = outlineColor
                        data.highlight.FillColor = fillColor
                        local lbl = data.tag and data.tag:FindFirstChildOfClass("TextLabel")
                        if lbl then
                            lbl.Text = plr.Name .. " [" .. role .. "]"
                            lbl.TextColor3 = fillColor
                        end
                    end
                end
            else
                removeESP(plr)
            end
        end
    end
    for plr, _ in pairs(espObjects) do
        if not plr.Parent then removeESP(plr) end
    end
end)

Players.PlayerRemoving:Connect(removeESP)

local fbToggle = CreateToggle(VisualTab, "💡  " .. L("fullbright"), false, function(state)
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
RegisterLang(fbToggle, "fullbright", "💡  ")

local fogToggle = CreateToggle(VisualTab, "🌫️  " .. L("removeFog"), false, function(state)
    game:GetService("Lighting").FogEnd = state and 100000 or 1000
end)
RegisterLang(fogToggle, "removeFog", "🌫️  ")

-- ============ ROUND TIMER ============
local timerSec = CreateSection(VisualTab, L("roundTimer"))
local timerSecLabel = timerSec:FindFirstChild("SectionLabel")
if timerSecLabel then RegisterLang(timerSecLabel, "roundTimer") end

local TimerLabel = Instance.new("TextLabel")
TimerLabel.Size = UDim2.new(1, 0, 0, 32)
TimerLabel.BackgroundColor3 = H.THEME.Element
TimerLabel.BackgroundTransparency = 0.15
TimerLabel.Text = "⏱️  " .. L("roundTimer") .. ": --"
TimerLabel.TextColor3 = H.THEME.Text
TimerLabel.Font = Enum.Font.GothamBold
TimerLabel.TextSize = 13
TimerLabel.BorderSizePixel = 0
TimerLabel.Parent = VisualTab
local TLC = Instance.new("UICorner") TLC.CornerRadius = UDim.new(0, 8) TLC.Parent = TimerLabel
local TLS = Instance.new("UIStroke") TLS.Color = H.THEME.Gold TLS.Thickness = 1 TLS.Transparency = 0.5 TLS.Parent = TimerLabel

RegisterLang(TimerLabel, "roundTimer", "⏱️  ")

local function GetRoundTime()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if pg then
        for _, gui in pairs(pg:GetDescendants()) do
            if gui:IsA("TextLabel") then
                local t = gui.Text
                if t and t:match("^%d+:%d+$") then
                    return t
                end
            end
        end
    end
    return nil
end

task.spawn(function()
    while TimerLabel.Parent do
        local t = GetRoundTime()
        if t then
            TimerLabel.Text = "⏱️  " .. L("roundTimer") .. ": " .. t
        else
            TimerLabel.Text = "⏱️  " .. L("roundTimer") .. ": " .. L("roundEnded")
        end
        task.wait(0.5)
    end
end)

print("[Bonny Hub] Part 2 loaded (Lang + Roles + Main + Visual)")
--[[
    BONNY HUB | MM2 Premium Script
    PART 3: Teleports + Troll + Settings
--]]

local H = _G.BonnyHub
if not H then warn("[Bonny Hub] Run PART 1 first!") return end
if not H.GetRole then warn("[Bonny Hub] Run PART 2 first!") return end

local LocalPlayer    = H.LocalPlayer
local Players        = H.Players
local RunService     = H.RunService
local StarterGui     = H.StarterGui
local TeleportsTab   = H.TeleportsTab
local TrollTab       = H.TrollTab
local SettingsTab    = H.SettingsTab
local TabButtons     = H.TabButtons
local CreateSection  = H.CreateSection
local CreateButton   = H.CreateButton
local CreateToggle   = H.CreateToggle
local GetRole        = H.GetRole
local Lang           = H.Lang
local L              = H.L
local RegisterLang   = H.RegisterLang
local ApplyLang      = H.ApplyLang

-- ============ TELEPORTS TAB ============
local tpSec = CreateSection(TeleportsTab, L("teleports"))
local tpSecLabel = tpSec:FindFirstChild("SectionLabel")
if tpSecLabel then RegisterLang(tpSecLabel, "teleports") end

local function TPToPlayer(roleFilter)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if GetRole(plr) == roleFilter then
                char.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                return
            end
        end
    end
    StarterGui:SetCore("SendNotification", {
        Title = "Bonny Hub",
        Text = L("noTarget"),
        Duration = 2
    })
end

local tpMurder = CreateButton(TeleportsTab, "🔴  " .. L("tpMurderer"), function()
    TPToPlayer("Murderer")
end)
RegisterLang(tpMurder, "tpMurderer", "🔴  ")

local tpSheriff = CreateButton(TeleportsTab, "🔵  " .. L("tpSheriff"), function()
    TPToPlayer("Sheriff")
end)
RegisterLang(tpSheriff, "tpSheriff", "🔵  ")

local tpMap = CreateButton(TeleportsTab, "🗺️  " .. L("tpMap"), function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
    if not spawn then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("SpawnLocation") then spawn = obj break end
        end
    end
    if spawn then
        char.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
    else
        char.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
    end
end)
RegisterLang(tpMap, "tpMap", "🗺️  ")

local tpSpawn = CreateButton(TeleportsTab, "🏠  " .. L("tpSpawn"), function()
    local char = LocalPlayer.Character
    if not char then return end
    char:BreakJoints()
end)
RegisterLang(tpSpawn, "tpSpawn", "🏠  ")

-- ============ TROLL TAB ============
local trSec = CreateSection(TrollTab, L("trollFeatures"))
local trSecLabel = trSec:FindFirstChild("SectionLabel")
if trSecLabel then RegisterLang(trSecLabel, "trollFeatures") end

-- Touch Fling
local touchFlingEnabled = false
local touchFlingConnections = {}

local function setupTouchFling()
    for _, c in pairs(touchFlingConnections) do c:Disconnect() end
    touchFlingConnections = {}

    local char = LocalPlayer.Character
    if not char then return end

    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            local conn = part.Touched:Connect(function(hit)
                if not touchFlingEnabled then return end
                local otherChar = hit:FindFirstAncestorOfClass("Model")
                if not otherChar then return end
                local otherPlayer = Players:GetPlayerFromCharacter(otherChar)
                if otherPlayer and otherPlayer ~= LocalPlayer then
                    local otherHRP = otherChar:FindFirstChild("HumanoidRootPart")
                    if otherHRP then
                        local bv = Instance.new("BodyVelocity")
                        bv.Velocity = Vector3.new(999999, 999999, 999999)
                        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                        bv.Parent = otherHRP
                        game:GetService("Debris"):AddItem(bv, 0.15)
                    end
                end
            end)
            table.insert(touchFlingConnections, conn)
        end
    end
end

local touchFlingToggle = CreateToggle(TrollTab, "✋  " .. L("touchFling"), false, function(state)
    touchFlingEnabled = state
    if state then
        setupTouchFling()
    else
        for _, c in pairs(touchFlingConnections) do c:Disconnect() end
        touchFlingConnections = {}
    end
end)
RegisterLang(touchFlingToggle, "touchFling", "✋  ")

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if touchFlingEnabled then setupTouchFling() end
end)

-- Explosion Self
local explosionBtn = CreateButton(TrollTab, "💥  " .. L("explosionSelf"), function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local e = Instance.new("Explosion")
    e.Position = hrp.Position
    e.BlastRadius = 10
    e.BlastPressure = 50000
    e.DestroyJointRadiusPercent = 1
    e.Parent = workspace
end)
RegisterLang(explosionBtn, "explosionSelf", "💥  ")

-- ============ SETTINGS TAB ============
local setSec = CreateSection(SettingsTab, L("settings"))
local setSecLabel = setSec:FindFirstChild("SectionLabel")
if setSecLabel then RegisterLang(setSecLabel, "settings") end

local langLabel = Instance.new("TextLabel")
langLabel.Size = UDim2.new(1, 0, 0, 30)
langLabel.BackgroundColor3 = H.THEME.Element
langLabel.BackgroundTransparency = 0.15
langLabel.Text = "  🌐  " .. L("language")
langLabel.TextColor3 = H.THEME.Text
langLabel.Font = Enum.Font.GothamMedium
langLabel.TextSize = 12
langLabel.TextXAlignment = Enum.TextXAlignment.Left
langLabel.BorderSizePixel = 0
langLabel.Parent = SettingsTab
local LLC = Instance.new("UICorner") LLC.CornerRadius = UDim.new(0, 8) LLC.Parent = langLabel
RegisterLang(langLabel, "language", "🌐  ")

CreateButton(SettingsTab, "🇬🇧  English", function()
    Lang.current = "en"
    ApplyLang()
end)

CreateButton(SettingsTab, "🇷🇺  Русский", function()
    Lang.current = "ru"
    ApplyLang()
end)

-- ============ ACTIVATE FIRST TAB ============
for _, btn in pairs(TabButtons) do
    btn.MouseButton1Click:Fire()
    break
end

StarterGui:SetCore("SendNotification", {
    Title = "★ Bonny Hub",
    Text = L("loaded"),
    Duration = 3
})

print("[Bonny Hub] Part 3 loaded (Teleports + Troll + Settings)")
print("[Bonny Hub] ✨ All 3 parts loaded successfully!")
