--[[
    ✨ BONNY HUB PREMIUM ✨
    MM2 Script | All-in-One
    Aimbot + ESP + Timer + Teleports + Troll + Settings
--]]

if _G.BonnyHubLoaded then
    game:GetService("CoreGui"):FindFirstChild("BonnyHub"):Destroy()
end
_G.BonnyHubLoaded = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

local THEME = {
    Background    = Color3.fromRGB(15, 8, 12),
    Background2   = Color3.fromRGB(30, 10, 20),
    Background3   = Color3.fromRGB(45, 15, 28),
    Sidebar       = Color3.fromRGB(22, 10, 17),
    Element       = Color3.fromRGB(40, 18, 30),
    ElementHover  = Color3.fromRGB(65, 25, 45),
    Accent        = Color3.fromRGB(255, 30, 80),
    Accent2       = Color3.fromRGB(255, 100, 150),
    Gold          = Color3.fromRGB(255, 200, 60),
    Purple        = Color3.fromRGB(180, 80, 255),
    Text          = Color3.fromRGB(255, 255, 255),
    TextDim       = Color3.fromRGB(190, 150, 170),
    Success       = Color3.fromRGB(0, 220, 130),
    Shadow        = Color3.fromRGB(0, 0, 0)
}

-- ============================================
-- LANGUAGE
-- ============================================
local Lang = {
    current = "en",
    strings = {
        en = {
            mainFeatures="Main Features", noclip="Noclip", autoPickupGun="Auto Pickup Gun",
            chatInfo="Chat Info", chatRoles="Copy Roles to Clipboard", chatCopied="Copied! Paste in chat (Ctrl+V)",
            visualFeatures="Visual Features", esp="ESP Players", espGun="ESP Guns (Orange)",
            fullbright="Fullbright", removeFog="Remove Fog", roundTimer="Round Timer",
            aimbot="Aimbot Murderer", aimWall="Aim Through Walls", aimPart="Aim Part",
            aimSmooth="Smoothness", partTorso="Torso", partHead="Head", partHRP="HRP",
            teleports="Teleports", tpMurderer="Teleport to Murderer", tpSheriff="Teleport to Sheriff",
            tpMap="Teleport to Map", tpSpawn="Teleport to Spawn",
            trollFeatures="Troll Features", touchFling="Touch Fling",
            settings="Settings", language="Language", clickSound="Click Sound",
            noSound="No Sound", clientSound="Client", client2="Client 2", client3="Client 3",
            disableSound="Disable Sound",
            loaded="Loaded successfully!", noTarget="Target not found"
        },
        ru = {
            mainFeatures="Основные функции", noclip="Noclip", autoPickupGun="Авто-подбор пистолета",
            chatInfo="Информация в чат", chatRoles="Скопировать роли в буфер", chatCopied="Скопировано! Вставь в чат (Ctrl+V)",
            visualFeatures="Визуальные функции", esp="ESP игроков", espGun="ESP пистолета (оранжевый)",
            fullbright="Полная яркость", removeFog="Убрать туман", roundTimer="Таймер раунда",
            aimbot="Аим на мардера", aimWall="Наводиться через стены", aimPart="Часть тела",
            aimSmooth="Плавность", partTorso="Туловище", partHead="Голова", partHRP="HRP",
            teleports="Телепорты", tpMurderer="ТП к мардеру", tpSheriff="ТП к шерифу",
            tpMap="ТП на карту", tpSpawn="ТП на спавн",
            trollFeatures="Тролль функции", touchFling="Тач-флинг",
            settings="Настройки", language="Язык", clickSound="Звук клика",
            noSound="Без звука", clientSound="Client", client2="Client 2", client3="Client 3",
            disableSound="Звук выключения",
            loaded="Успешно загружено!", noTarget="Цель не найдена"
        }
    }
}
local function L(key) return Lang.strings[Lang.current][key] or key end
local LangRefs = {}
local function RegisterLang(ref, key, prefix)
    table.insert(LangRefs, {ref=ref, key=key, prefix=prefix or ""})
end
local function ApplyLang()
    for _, e in ipairs(LangRefs) do
        pcall(function()
            if e.ref and e.ref.Parent then
                if e.ref.Name == "SectionLabel" then
                    e.ref.Text = "  ⚡  " .. L(e.key)
                else
                    e.ref.Text = "  " .. e.prefix .. L(e.key)
                end
            end
        end)
    end
end

-- ============================================
-- SOUND SYSTEM
-- ============================================
local SoundConfig = { clickSound = 0, disableSound = 0 }
local SOUND_IDS = {
    [0]=nil, [1]="rbxassetid://87437544236708",
    [2]="rbxassetid://140207837688369", [3]="rbxassetid://139421450430380"
}
local DIS_SOUND = { [0]=nil, [1]="rbxassetid://73954763982661" }
local soundCache = {}
local function PreloadSound(id)
    if soundCache[id] then return soundCache[id] end
    local s = Instance.new("Sound")
    s.SoundId = id
    s.Volume = 1.5
    s.Parent = SoundService
    soundCache[id] = s
    return s
end
for _, id in pairs(SOUND_IDS) do if id then PreloadSound(id) end end
for _, id in pairs(DIS_SOUND) do if id then PreloadSound(id) end end

local function PlayClickSound()
    local id = SOUND_IDS[SoundConfig.clickSound]
    if not id then return end
    local s = soundCache[id]
    if s then s.TimePosition = 0; s:Play() else PreloadSound(id):Play() end
end
local function PlayDisableSound()
    local id = DIS_SOUND[SoundConfig.disableSound]
    if not id then return end
    local s = soundCache[id]
    if s then s.TimePosition = 0; s:Play() else PreloadSound(id):Play() end
end
local function OnToggleSound(state)
    if state then PlayClickSound()
    else
        if SoundConfig.disableSound > 0 then PlayDisableSound()
        else PlayClickSound() end
    end
end

-- ============================================
-- HELPERS
-- ============================================
local function IsGun(t)
    if not t or not t:IsA("Tool") then return false end
    local n = t.Name:lower()
    return n:find("gun") or n:find("revolver") or n:find("pistol") or n:find("firearm")
end
local function IsKnife(t)
    if not t or not t:IsA("Tool") then return false end
    local n = t.Name:lower()
    return n:find("knife") or n:find("sword") or n:find("m9") or n:find("dagger") or n:find("blade")
end
local function HasGunInChar(c)
    if not c then return false end
    for _, i in pairs(c:GetChildren()) do if IsGun(i) then return true end end
    return false
end
local function GetRole(plr)
    if plr == LocalPlayer then return "LocalPlayer" end
    local char = plr.Character
    if not char then return "Innocent" end
    local bp = plr:FindFirstChildOfClass("Backpack")
    local cbp = char:FindFirstChildOfClass("Backpack")
    local hg, hk = false, false
    local function scan(c)
        for _, i in pairs(c:GetChildren()) do
            if IsGun(i) then hg = true end
            if IsKnife(i) then hk = true end
        end
    end
    scan(char)
    if bp then scan(bp) end
    if cbp then scan(cbp) end
    if hg then return "Sheriff" end
    if hk then return "Murderer" end
    return "Innocent"
end
local function GetRoleColors(role)
    if role == "Murderer" then return Color3.fromRGB(255,0,0), Color3.fromRGB(255,130,130)
    elseif role == "Sheriff" then return Color3.fromRGB(0,100,255), Color3.fromRGB(120,180,255)
    elseif role == "Innocent" then return Color3.fromRGB(0,200,50), Color3.fromRGB(130,255,160) end
    return Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255)
end
local function CopyToClipboard(text)
    if setclipboard then return pcall(setclipboard, text) end
    if toclipboard then return pcall(toclipboard, text) end
    if syn and syn.setclipboard then return pcall(syn.setclipboard, text) end
    if writeclipboard then return pcall(writeclipboard, text) end
    return false
end

-- ============================================
-- SCREEN GUI
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BonnyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

if gethui then ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then syn.protect_gui(ScreenGui); ScreenGui.Parent = game:GetService("CoreGui")
else
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 540, 0, 400)
MainFrame.Position = UDim2.new(0.5, -270, 0.5, -200)
MainFrame.BackgroundColor3 = THEME.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

local BG = Instance.new("UIGradient", MainFrame)
BG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.Background3),
    ColorSequenceKeypoint.new(0.5, THEME.Background),
    ColorSequenceKeypoint.new(1, THEME.Background2)
})
BG.Rotation = 135

local OG = Instance.new("UIStroke", MainFrame)
OG.Color = THEME.Accent; OG.Thickness = 2; OG.Transparency = 0.2

local Shadow = Instance.new("Frame", MainFrame)
Shadow.Size = UDim2.new(1, 20, 1, 20); Shadow.Position = UDim2.new(0, -10, 0, -10)
Shadow.BackgroundColor3 = THEME.Shadow; Shadow.BackgroundTransparency = 0.7
Shadow.BorderSizePixel = 0; Shadow.ZIndex = -1
Instance.new("UICorner", Shadow).CornerRadius = UDim.new(0, 20)

-- Title
local TB = Instance.new("Frame", MainFrame)
TB.Size = UDim2.new(1, 0, 0, 46); TB.BackgroundColor3 = THEME.Sidebar
TB.BackgroundTransparency = 0.2; TB.BorderSizePixel = 0
Instance.new("UICorner", TB).CornerRadius = UDim.new(0, 16)
local TBo = Instance.new("Frame", TB)
TBo.Size = UDim2.new(1, 0, 0, 16); TBo.Position = UDim2.new(0, 0, 1, -16)
TBo.BackgroundColor3 = THEME.Sidebar; TBo.BackgroundTransparency = 0.2; TBo.BorderSizePixel = 0

local LF = Instance.new("Frame", TB)
LF.Size = UDim2.new(0, 32, 0, 32); LF.Position = UDim2.new(0, 14, 0.5, -16)
LF.BackgroundColor3 = THEME.Accent; LF.BorderSizePixel = 0
Instance.new("UICorner", LF).CornerRadius = UDim.new(0, 9)
local LG = Instance.new("UIGradient", LF)
LG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.Accent),
    ColorSequenceKeypoint.new(0.5, THEME.Purple),
    ColorSequenceKeypoint.new(1, THEME.Gold)
})
LG.Rotation = 45
local LS = Instance.new("UIStroke", LF); LS.Color = THEME.Accent2; LS.Thickness = 1; LS.Transparency = 0.3
local Logo = Instance.new("TextLabel", LF)
Logo.Size = UDim2.new(1, 0, 1, 0); Logo.BackgroundTransparency = 1; Logo.Text = "★"
Logo.TextColor3 = THEME.Text; Logo.Font = Enum.Font.GothamBold; Logo.TextSize = 19

local T = Instance.new("TextLabel", TB)
T.Size = UDim2.new(1, -200, 0, 22); T.Position = UDim2.new(0, 56, 0, 6)
T.BackgroundTransparency = 1; T.Text = "BONNY HUB"; T.TextColor3 = THEME.Text
T.Font = Enum.Font.GothamBold; T.TextSize = 16; T.TextXAlignment = Enum.TextXAlignment.Left
local TG = Instance.new("UIGradient", T)
TG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.Text),
    ColorSequenceKeypoint.new(1, THEME.Accent2)
})
local ST = Instance.new("TextLabel", TB)
ST.Size = UDim2.new(1, -200, 0, 14); ST.Position = UDim2.new(0, 56, 0, 26)
ST.BackgroundTransparency = 1; ST.Text = "PREMIUM EDITION"; ST.TextColor3 = THEME.TextDim
ST.Font = Enum.Font.Gotham; ST.TextSize = 9; ST.TextXAlignment = Enum.TextXAlignment.Left

local function CreateTitleBtn(sym, x, clr, cb)
    local B = Instance.new("TextButton", TB)
    B.Size = UDim2.new(0, 28, 0, 28); B.Position = UDim2.new(1, x, 0.5, -14)
    B.BackgroundColor3 = THEME.Element; B.BackgroundTransparency = 0.4
    B.Text = sym; B.TextColor3 = clr; B.Font = Enum.Font.GothamBold; B.TextSize = 16
    B.BorderSizePixel = 0; B.AutoButtonColor = false
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
    B.MouseEnter:Connect(function() TweenService:Create(B, TweenInfo.new(0.15), {BackgroundTransparency=0}):Play() end)
    B.MouseLeave:Connect(function() TweenService:Create(B, TweenInfo.new(0.15), {BackgroundTransparency=0.4}):Play() end)
    B.MouseButton1Click:Connect(cb)
    return B
end

local miniBtn
CreateTitleBtn("−", -74, THEME.TextDim, function()
    MainFrame.Visible = false
    if miniBtn then miniBtn:Destroy() end
    local M = Instance.new("TextButton", ScreenGui)
    M.Size = UDim2.new(0, 60, 0, 60); M.Position = UDim2.new(0, 100, 0.5, -30)
    M.BackgroundColor3 = THEME.Background; M.Text = "★"; M.TextColor3 = THEME.Text
    M.TextScaled = true; M.Font = Enum.Font.GothamBold; M.BorderSizePixel = 0; M.Active = true
    Instance.new("UICorner", M).CornerRadius = UDim.new(0, 14)
    local MG = Instance.new("UIGradient", M)
    MG.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, THEME.Accent),
        ColorSequenceKeypoint.new(1, THEME.Purple)
    })
    MG.Rotation = 45
    local MS = Instance.new("UIStroke", M); MS.Color = THEME.Accent2; MS.Thickness = 2
    task.spawn(function()
        while M.Parent do
            TweenService:Create(MS, TweenInfo.new(1), {Transparency=0.5}):Play()
            task.wait(1)
            if not M.Parent then break end
            TweenService:Create(MS, TweenInfo.new(1), {Transparency=0}):Play()
            task.wait(1)
        end
    end)
    local drag, ds, sp = false, nil, nil
    M.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            drag = true; ds = i.Position; sp = M.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - ds
            M.Position = UDim2.new(sp.X.Scale, sp.X.Offset+d.X, sp.Y.Scale, sp.Y.Offset+d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end
    end)
    M.MouseButton1Click:Connect(function()
        if not drag then
            MainFrame.Visible = true
            M:Destroy()
            miniBtn = nil
        end
    end)
    miniBtn = M
end)
CreateTitleBtn("×", -42, Color3.fromRGB(255,80,80), function()
    ScreenGui:Destroy()
    _G.BonnyHubLoaded = false
end)

-- Sidebar
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 155, 1, -110); Sidebar.Position = UDim2.new(0, 12, 0, 54)
Sidebar.BackgroundColor3 = THEME.Sidebar; Sidebar.BackgroundTransparency = 0.15; Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)
local SS = Instance.new("UIStroke", Sidebar); SS.Color = THEME.Accent; SS.Thickness = 1; SS.Transparency = 0.6

local VL = Instance.new("TextLabel", Sidebar)
VL.Size = UDim2.new(1, -20, 0, 26); VL.Position = UDim2.new(0, 10, 0, 10)
VL.BackgroundColor3 = THEME.Element; VL.BackgroundTransparency = 0.2
VL.Text = "⚡ BONNY"; VL.TextColor3 = THEME.Gold; VL.Font = Enum.Font.GothamBold
VL.TextSize = 11; VL.BorderSizePixel = 0
Instance.new("UICorner", VL).CornerRadius = UDim.new(0, 7)
local VLS = Instance.new("UIStroke", VL); VLS.Color = THEME.Gold; VLS.Thickness = 1; VLS.Transparency = 0.7

local TabListFrame = Instance.new("Frame", Sidebar)
TabListFrame.Size = UDim2.new(1, -20, 1, -50); TabListFrame.Position = UDim2.new(0, 10, 0, 44)
TabListFrame.BackgroundTransparency = 1
local TL = Instance.new("UIListLayout", TabListFrame)
TL.Padding = UDim.new(0, 6); TL.SortOrder = Enum.SortOrder.LayoutOrder

-- Content
local Content = Instance.new("Frame", MainFrame)
Content.Size = UDim2.new(1, -185, 1, -110); Content.Position = UDim2.new(0, 175, 0, 54)
Content.BackgroundColor3 = THEME.Sidebar; Content.BackgroundTransparency = 0.15; Content.BorderSizePixel = 0
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 12)
local CS = Instance.new("UIStroke", Content); CS.Color = THEME.Accent; CS.Thickness = 1; CS.Transparency = 0.6

-- Profile
local PF = Instance.new("Frame", MainFrame)
PF.Size = UDim2.new(1, -24, 0, 50); PF.Position = UDim2.new(0, 12, 1, -58)
PF.BackgroundColor3 = THEME.Element; PF.BackgroundTransparency = 0.3; PF.BorderSizePixel = 0
Instance.new("UICorner", PF).CornerRadius = UDim.new(0, 10)
local PFS = Instance.new("UIStroke", PF); PFS.Color = THEME.Accent; PFS.Thickness = 1; PFS.Transparency = 0.6

local AF = Instance.new("Frame", PF)
AF.Size = UDim2.new(0, 38, 0, 38); AF.Position = UDim2.new(0, 6, 0.5, -19)
AF.BackgroundColor3 = THEME.Accent; AF.BorderSizePixel = 0
Instance.new("UICorner", AF).CornerRadius = UDim.new(1, 0)

local AI = Instance.new("ImageLabel", AF)
AI.Size = UDim2.new(1, -4, 1, -4); AI.Position = UDim2.new(0, 2, 0, 2)
AI.BackgroundTransparency = 1
AI.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
Instance.new("UICorner", AI).CornerRadius = UDim.new(1, 0)

local NL = Instance.new("TextLabel", PF)
NL.Size = UDim2.new(1, -80, 0, 16); NL.Position = UDim2.new(0, 52, 0, 8)
NL.BackgroundTransparency = 1; NL.Text = LocalPlayer.DisplayName; NL.TextColor3 = THEME.Text
NL.Font = Enum.Font.GothamBold; NL.TextSize = 12; NL.TextXAlignment = Enum.TextXAlignment.Left

local UL = Instance.new("TextLabel", PF)
UL.Size = UDim2.new(1, -80, 0, 14); UL.Position = UDim2.new(0, 52, 0, 24)
UL.BackgroundTransparency = 1; UL.Text = "@" .. LocalPlayer.Name; UL.TextColor3 = THEME.TextDim
UL.Font = Enum.Font.Gotham; UL.TextSize = 10; UL.TextXAlignment = Enum.TextXAlignment.Left

local OD = Instance.new("Frame", PF)
OD.Size = UDim2.new(0, 10, 0, 10); OD.Position = UDim2.new(1, -18, 0.5, -5)
OD.BackgroundColor3 = THEME.Success; OD.BorderSizePixel = 0
Instance.new("UICorner", OD).CornerRadius = UDim.new(1, 0)
local ODS = Instance.new("UIStroke", OD); ODS.Color = THEME.Success; ODS.Thickness = 2; ODS.Transparency = 0.4

task.spawn(function()
    while OD.Parent do
        TweenService:Create(ODS, TweenInfo.new(1), {Transparency=0.8, Thickness=4}):Play()
        task.wait(1)
        if not OD.Parent then break end
        TweenService:Create(ODS, TweenInfo.new(1), {Transparency=0.4, Thickness=2}):Play()
        task.wait(1)
    end
end)

-- ============================================
-- TABS
-- ============================================
local Tabs = {}
local TabButtons = {}

local function CreateTab(name, icon)
    local B = Instance.new("TextButton")
    B.Size = UDim2.new(1, 0, 0, 32); B.BackgroundColor3 = THEME.Element
    B.BackgroundTransparency = 0.4; B.Text = "  " .. icon .. "   " .. name
    B.TextColor3 = THEME.TextDim; B.Font = Enum.Font.GothamMedium; B.TextSize = 13
    B.TextXAlignment = Enum.TextXAlignment.Left; B.BorderSizePixel = 0; B.AutoButtonColor = false
    B.Parent = TabListFrame
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)

    local St = Instance.new("Frame", B)
    St.Name = "Stripe"; St.Size = UDim2.new(0, 3, 0.6, 0)
    St.Position = UDim2.new(0, 0, 0.2, 0); St.BackgroundColor3 = THEME.Accent
    St.BorderSizePixel = 0; St.Visible = false
    Instance.new("UICorner", St).CornerRadius = UDim.new(1, 0)

    local TC = Instance.new("ScrollingFrame")
    TC.Size = UDim2.new(1, -20, 1, -20); TC.Position = UDim2.new(0, 10, 0, 10)
    TC.BackgroundTransparency = 1; TC.BorderSizePixel = 0
    TC.CanvasSize = UDim2.new(0, 0, 0, 0); TC.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TC.ScrollBarThickness = 3; TC.ScrollBarImageColor3 = THEME.Accent; TC.Visible = false
    TC.Parent = Content

    local CL = Instance.new("UIListLayout", TC)
    CL.Padding = UDim.new(0, 6); CL.SortOrder = Enum.SortOrder.LayoutOrder

    Tabs[name] = TC
    TabButtons[name] = B

    B.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Visible = false end
        for _, btn in pairs(TabButtons) do
            btn.BackgroundColor3 = THEME.Element
            btn.BackgroundTransparency = 0.4
            btn.TextColor3 = THEME.TextDim
            local s = btn:FindFirstChild("Stripe")
            if s then s.Visible = false end
        end
        TC.Visible = true
        B.BackgroundColor3 = THEME.Accent
        B.BackgroundTransparency = 0.15
        B.TextColor3 = THEME.Text
        local s = B:FindFirstChild("Stripe")
        if s then s.Visible = true end
    end)
    B.MouseEnter:Connect(function()
        if TC.Visible == false then
            TweenService:Create(B, TweenInfo.new(0.15), {BackgroundTransparency=0.15}):Play()
        end
    end)
    B.MouseLeave:Connect(function()
        if TC.Visible == false then
            TweenService:Create(B, TweenInfo.new(0.15), {BackgroundTransparency=0.4}):Play()
        end
    end)
    return TC
end

-- ============================================
-- ELEMENTS
-- ============================================
local function CreateSection(parent, text)
    local W = Instance.new("Frame", parent)
    W.Size = UDim2.new(1, 0, 0, 26); W.BackgroundTransparency = 1
    local Ln = Instance.new("Frame", W)
    Ln.Size = UDim2.new(1, 0, 0, 1); Ln.Position = UDim2.new(0, 0, 0.5, 0)
    Ln.BackgroundColor3 = THEME.Accent; Ln.BackgroundTransparency = 0.5; Ln.BorderSizePixel = 0
    local S = Instance.new("TextLabel", W)
    S.Name = "SectionLabel"
    S.Size = UDim2.new(0, 220, 1, 0); S.Position = UDim2.new(0, 8, 0, 0)
    S.BackgroundColor3 = THEME.Sidebar; S.BackgroundTransparency = 0.1
    S.Text = "  ⚡  " .. text; S.TextColor3 = THEME.Gold
    S.Font = Enum.Font.GothamBold; S.TextSize = 12
    S.TextXAlignment = Enum.TextXAlignment.Left; S.BorderSizePixel = 0
    Instance.new("UICorner", S).CornerRadius = UDim.new(0, 6)
    return W
end

local function CreateButton(parent, text, cb)
    local B = Instance.new("TextButton", parent)
    B.Size = UDim2.new(1, 0, 0, 32); B.BackgroundColor3 = THEME.Element
    B.BackgroundTransparency = 0.15; B.Text = "  " .. text; B.TextColor3 = THEME.Text
    B.Font = Enum.Font.GothamMedium; B.TextSize = 12
    B.TextXAlignment = Enum.TextXAlignment.Left; B.BorderSizePixel = 0; B.AutoButtonColor = false
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 8)
    local S = Instance.new("UIStroke", B); S.Color = THEME.Accent; S.Thickness = 1; S.Transparency = 0.85
    B.MouseEnter:Connect(function()
        TweenService:Create(B, TweenInfo.new(0.15), {BackgroundColor3=THEME.ElementHover, BackgroundTransparency=0}):Play()
    end)
    B.MouseLeave:Connect(function()
        TweenService:Create(B, TweenInfo.new(0.15), {BackgroundColor3=THEME.Element, BackgroundTransparency=0.15}):Play()
    end)
    B.MouseButton1Click:Connect(cb)
    return B
end

local function CreateToggle(parent, text, def, cb)
    local state = def or false
    local F = Instance.new("TextButton", parent)
    F.Size = UDim2.new(1, 0, 0, 32); F.BackgroundColor3 = THEME.Element
    F.BackgroundTransparency = 0.15; F.Text = "  " .. text; F.TextColor3 = THEME.Text
    F.Font = Enum.Font.GothamMedium; F.TextSize = 12
    F.TextXAlignment = Enum.TextXAlignment.Left; F.BorderSizePixel = 0; F.AutoButtonColor = false
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 8)
    local S = Instance.new("UIStroke", F); S.Color = THEME.Accent; S.Thickness = 1; S.Transparency = 0.85

    local SB = Instance.new("Frame", F)
    SB.Size = UDim2.new(0, 36, 0, 18); SB.Position = UDim2.new(1, -46, 0.5, -9)
    SB.BackgroundColor3 = state and THEME.Success or Color3.fromRGB(60, 40, 50)
    SB.BorderSizePixel = 0
    Instance.new("UICorner", SB).CornerRadius = UDim.new(1, 0)

    local Ci = Instance.new("Frame", SB)
    Ci.Size = UDim2.new(0, 14, 0, 14)
    Ci.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    Ci.BackgroundColor3 = THEME.Text; Ci.BorderSizePixel = 0
    Instance.new("UICorner", Ci).CornerRadius = UDim.new(1, 0)

    F.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(SB, TweenInfo.new(0.2), {
            BackgroundColor3 = state and THEME.Success or Color3.fromRGB(60, 40, 50)
        }):Play()
        TweenService:Create(Ci, TweenInfo.new(0.2), {
            Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        }):Play()
        if cb then cb(state) end
    end)
    F.MouseEnter:Connect(function()
        TweenService:Create(F, TweenInfo.new(0.15), {BackgroundColor3=THEME.ElementHover, BackgroundTransparency=0}):Play()
    end)
    F.MouseLeave:Connect(function()
        TweenService:Create(F, TweenInfo.new(0.15), {BackgroundColor3=THEME.Element, BackgroundTransparency=0.15}):Play()
    end)
    return F
end

-- ============================================
-- CREATE TABS
-- ============================================
local MainTab      = CreateTab("Main", "🏠")
local VisualTab    = CreateTab("Visual", "👁")
local TeleportsTab = CreateTab("Teleports", "📍")
local TrollTab     = CreateTab("Troll", "☠")
local SettingsTab  = CreateTab("Settings", "⚙")

-- ============================================
-- MAIN TAB
-- ============================================
local mainSec = CreateSection(MainTab, L("mainFeatures"))
local ml = mainSec:FindFirstChild("SectionLabel")
if ml then RegisterLang(ml, "mainFeatures") end

local noclipEnabled, noclipConn = false, nil
local function startNoclip()
    if noclipConn then noclipConn:Disconnect() end
    noclipConn = RunService.Stepped:Connect(function()
        if not noclipEnabled then return end
        local char = LocalPlayer.Character
        if char then
            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
            end
        end
    end)
end
local noclipToggle = CreateToggle(MainTab, "👻  " .. L("noclip"), false, function(state)
    noclipEnabled = state
    OnToggleSound(state)
    if state then startNoclip() end
end)
RegisterLang(noclipToggle, "noclip", "👻  ")
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if noclipEnabled then startNoclip() end
end)

local autoPickupEnabled, autoPickupRunning = false, false
local function FindGroundGun()
    for _, o in pairs(workspace:GetChildren()) do
        if IsGun(o) and o:FindFirstChild("Handle") then return o end
    end
    return nil
end
local function AutoPickupLoop()
    if autoPickupRunning then return end
    autoPickupRunning = true
    task.spawn(function()
        while autoPickupEnabled do
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if char and hum and hrp and hum.Health > 0 and not HasGunInChar(char) then
                local gun = FindGroundGun()
                if gun then
                    local handle = gun:FindFirstChild("Handle")
                    if handle then
                        local oCF, oV = hrp.CFrame, hrp.AssemblyLinearVelocity
                        hrp.CFrame = handle.CFrame + Vector3.new(0, 2, 0)
                        hrp.AssemblyLinearVelocity = Vector3.zero
                        task.wait(0.1)
                        for i = 1, 15 do
                            if HasGunInChar(char) then break end
                            pcall(function() if gun.Parent == workspace then gun.Parent = char end end)
                            task.wait(0.05)
                        end
                        task.wait(0.2)
                        if char.Parent and char:FindFirstChild("HumanoidRootPart") and hum.Health > 0 then
                            char.HumanoidRootPart.CFrame = oCF
                            char.HumanoidRootPart.AssemblyLinearVelocity = oV
                        end
                    end
                end
            end
            task.wait(1)
        end
        autoPickupRunning = false
    end)
end
local apToggle = CreateToggle(MainTab, "🔫  " .. L("autoPickupGun"), false, function(state)
    autoPickupEnabled = state
    OnToggleSound(state)
    if state then AutoPickupLoop() end
end)
RegisterLang(apToggle, "autoPickupGun", "🔫  ")

local chatSec = CreateSection(MainTab, L("chatInfo"))
local cl = chatSec:FindFirstChild("SectionLabel")
if cl then RegisterLang(cl, "chatInfo") end

local chatBtn = CreateButton(MainTab, "💬  " .. L("chatRoles"), function()
    PlayClickSound()
    local msg = ""
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local r = GetRole(plr)
            if r == "Murderer" then msg = msg .. plr.Name .. "(murder) "
            elseif r == "Sheriff" then msg = msg .. plr.Name .. "(sheriff) " end
        end
    end
    if msg == "" then msg = "none " end
    msg = msg .. "| Bonny hub"
    local ok = CopyToClipboard(msg)
    StarterGui:SetCore("SendNotification", {
        Title = "Bonny Hub",
        Text = ok and L("chatCopied") or ("Failed: " .. msg),
        Duration = 4
    })
end)
RegisterLang(chatBtn, "chatRoles", "💬  ")

-- ============================================
-- VISUAL TAB
-- ============================================
local visSec = CreateSection(VisualTab, L("visualFeatures"))
local vl = visSec:FindFirstChild("SectionLabel")
if vl then RegisterLang(vl, "visualFeatures") end

local espEnabled, espObjects = false, {}
local espToggle = CreateToggle(VisualTab, "👁️  " .. L("esp"), false, function(state)
    espEnabled = state
    OnToggleSound(state)
    if not state then
        for _, d in pairs(espObjects) do
            if d.highlight and d.highlight.Parent then d.highlight:Destroy() end
            if d.tag and d.tag.Parent then d.tag:Destroy() end
        end
        espObjects = {}
    end
end)
RegisterLang(espToggle, "esp", "👁️  ")

local function createESP(plr)
    if plr == LocalPlayer or not plr.Character then return end
    local head = plr.Character:FindFirstChild("Head")
    if not head then return end
    local role = GetRole(plr)
    local oc, fc = GetRoleColors(role)
    local isHero = false
    if role == "Innocent" and HasGunInChar(plr.Character) then
        isHero = true
        oc = Color3.fromRGB(255, 215, 0); fc = Color3.fromRGB(255, 240, 150)
    end
    local hl = Instance.new("Highlight")
    hl.Name = "BonnyESP"; hl.Adornee = plr.Character
    hl.FillColor = fc; hl.FillTransparency = 0.7
    hl.OutlineColor = oc; hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = plr.Character
    local tag = Instance.new("BillboardGui")
    tag.Name = "BonnyTag"; tag.Adornee = head
    tag.Size = UDim2.new(0, 220, 0, 30); tag.StudsOffset = Vector3.new(0, 2.8, 0)
    tag.AlwaysOnTop = true; tag.Parent = head
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1
    lbl.Text = isHero and (plr.Name .. " [HERO]") or (plr.Name .. " [" .. role .. "]")
    lbl.TextColor3 = fc; lbl.TextStrokeTransparency = 0
    lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 13
    lbl.Parent = tag
    espObjects[plr] = {highlight=hl, tag=tag}
end
local function removeESP(plr)
    local d = espObjects[plr]
    if not d then return end
    if d.highlight and d.highlight.Parent then d.highlight:Destroy() end
    if d.tag and d.tag.Parent then d.tag:Destroy() end
    espObjects[plr] = nil
end
RunService.RenderStepped:Connect(function()
    if not espEnabled then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if plr.Character and plr.Character:FindFirstChild("Head") then
                local data = espObjects[plr]
                if not data or not data.highlight or not data.highlight.Parent or data.highlight.Adornee ~= plr.Character then
                    removeESP(plr); createESP(plr)
                end
            else removeESP(plr) end
        end
    end
    for plr, _ in pairs(espObjects) do if not plr.Parent then removeESP(plr) end end
end)
Players.PlayerRemoving:Connect(removeESP)

local espGunEnabled, gunESPObjects = false, {}
local egToggle = CreateToggle(VisualTab, "🔶  " .. L("espGun"), false, function(state)
    espGunEnabled = state
    OnToggleSound(state)
    if not state then
        for _, o in pairs(gunESPObjects) do if o and o.Parent then o:Destroy() end end
        gunESPObjects = {}
    end
end)
RegisterLang(egToggle, "espGun", "🔶  ")

task.spawn(function()
    while true do
        if espGunEnabled then
            for i = #gunESPObjects, 1, -1 do
                local o = gunESPObjects[i]
                if not o or not o.Parent then table.remove(gunESPObjects, i) end
            end
            for _, obj in pairs(workspace:GetChildren()) do
                if IsGun(obj) and not obj:FindFirstChild("BonnyGunESP") and obj:FindFirstChild("Handle") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "BonnyGunESP"; hl.Adornee = obj
                    hl.FillColor = Color3.fromRGB(255, 140, 0); hl.FillTransparency = 0.4
                    hl.OutlineColor = Color3.fromRGB(255, 80, 0); hl.OutlineTransparency = 0
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Parent = obj
                    table.insert(gunESPObjects, hl)
                end
            end
        end
        task.wait(0.5)
    end
end)

local fbToggle = CreateToggle(VisualTab, "💡  " .. L("fullbright"), false, function(state)
    OnToggleSound(state)
    local l = game:GetService("Lighting")
    if state then
        l.Ambient = Color3.fromRGB(255, 255, 255); l.Brightness = 2
        l.FogEnd = 100000; l.GlobalShadows = false
    else
        l.Ambient = Color3.fromRGB(70, 70, 70); l.Brightness = 1
        l.FogEnd = 1000; l.GlobalShadows = true
    end
end)
RegisterLang(fbToggle, "fullbright", "💡  ")

local fogToggle = CreateToggle(VisualTab, "🌫️  " .. L("removeFog"), false, function(state)
    OnToggleSound(state)
    game:GetService("Lighting").FogEnd = state and 100000 or 1000
end)
RegisterLang(fogToggle, "removeFog", "🌫️  ")

-- ============================================
-- AIMBOT
-- ============================================
local aimSec = CreateSection(VisualTab, L("aimbot"))
local al = aimSec:FindFirstChild("SectionLabel")
if al then RegisterLang(al, "aimbot") end

local AimbotConfig = { enabled=false, throughWalls=false, aimPart="Torso", smoothness=0.35 }

local AimbotWrap = Instance.new("Frame", VisualTab)
AimbotWrap.Size = UDim2.new(1, 0, 0, 32)
AimbotWrap.BackgroundColor3 = THEME.Element
AimbotWrap.BackgroundTransparency = 0.15
AimbotWrap.BorderSizePixel = 0
Instance.new("UICorner", AimbotWrap).CornerRadius = UDim.new(0, 8)
local AWCS = Instance.new("UIStroke", AimbotWrap)
AWCS.Color = THEME.Accent; AWCS.Thickness = 1; AWCS.Transparency = 0.85

local AimbotLabel = Instance.new("TextLabel", AimbotWrap)
AimbotLabel.Size = UDim2.new(1, -110, 1, 0); AimbotLabel.Position = UDim2.new(0, 10, 0, 0)
AimbotLabel.BackgroundTransparency = 1; AimbotLabel.Text = L("aimbot")
AimbotLabel.TextColor3 = THEME.Text; AimbotLabel.Font = Enum.Font.GothamMedium
AimbotLabel.TextSize = 12; AimbotLabel.TextXAlignment = Enum.TextXAlignment.Left
RegisterLang(AimbotLabel, "aimbot")

local SwitchBG = Instance.new("Frame", AimbotWrap)
SwitchBG.Size = UDim2.new(0, 36, 0, 18); SwitchBG.Position = UDim2.new(1, -80, 0.5, -9)
SwitchBG.BackgroundColor3 = Color3.fromRGB(60, 40, 50); SwitchBG.BorderSizePixel = 0
Instance.new("UICorner", SwitchBG).CornerRadius = UDim.new(1, 0)

local Circle = Instance.new("Frame", SwitchBG)
Circle.Size = UDim2.new(0, 14, 0, 14); Circle.Position = UDim2.new(0, 2, 0.5, -7)
Circle.BackgroundColor3 = THEME.Text; Circle.BorderSizePixel = 0
Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

local GearBtn = Instance.new("TextButton", AimbotWrap)
GearBtn.Size = UDim2.new(0, 24, 0, 24); GearBtn.Position = UDim2.new(1, -38, 0.5, -12)
GearBtn.BackgroundColor3 = THEME.ElementHover; GearBtn.Text = "⚙"
GearBtn.TextColor3 = THEME.Text; GearBtn.TextSize = 14
GearBtn.Font = Enum.Font.GothamBold; GearBtn.BorderSizePixel = 0; GearBtn.AutoButtonColor = false
Instance.new("UICorner", GearBtn).CornerRadius = UDim.new(0, 6)

local SettingsPanel = Instance.new("Frame", VisualTab)
SettingsPanel.Size = UDim2.new(1, 0, 0, 0)
SettingsPanel.BackgroundColor3 = THEME.Sidebar
SettingsPanel.BackgroundTransparency = 0.3
SettingsPanel.BorderSizePixel = 0
SettingsPanel.ClipsDescendants = true
Instance.new("UICorner", SettingsPanel).CornerRadius = UDim.new(0, 8)
local SPS = Instance.new("UIStroke", SettingsPanel)
SPS.Color = THEME.Accent; SPS.Thickness = 1; SPS.Transparency = 0.6

local PanelList = Instance.new("UIListLayout", SettingsPanel)
PanelList.Padding = UDim.new(0, 5); PanelList.SortOrder = Enum.SortOrder.LayoutOrder
local PanelPad = Instance.new("UIPadding", SettingsPanel)
PanelPad.PaddingTop = UDim.new(0, 8); PanelPad.PaddingLeft = UDim.new(0, 8)
PanelPad.PaddingRight = UDim.new(0, 8); PanelPad.PaddingBottom = UDim.new(0, 8)

local wallToggle = CreateToggle(SettingsPanel, "🚪  " .. L("aimWall"), false, function(state)
    AimbotConfig.throughWalls = state
    OnToggleSound(state)
end)
RegisterLang(wallToggle, "aimWall", "🚪  ")

local partLabel = Instance.new("TextLabel", SettingsPanel)
partLabel.Size = UDim2.new(1, 0, 0, 20); partLabel.BackgroundTransparency = 1
partLabel.Text = "  🎯  " .. L("aimPart"); partLabel.TextColor3 = THEME.Gold
partLabel.Font = Enum.Font.GothamBold; partLabel.TextSize = 11
partLabel.TextXAlignment = Enum.TextXAlignment.Left
RegisterLang(partLabel, "aimPart", "🎯  ")

local partButtonsFrame = Instance.new("Frame", SettingsPanel)
partButtonsFrame.Size = UDim2.new(1, 0, 0, 30); partButtonsFrame.BackgroundTransparency = 1
local PBL = Instance.new("UIListLayout", partButtonsFrame)
PBL.FillDirection = Enum.FillDirection.Horizontal; PBL.Padding = UDim.new(0, 4)

local function CreatePartBtn(name, key)
    local Btn = Instance.new("TextButton", partButtonsFrame)
    Btn.Size = UDim2.new(0.33, -3, 1, 0)
    Btn.BackgroundColor3 = AimbotConfig.aimPart == name and THEME.Accent or THEME.Element
    Btn.Text = L(key); Btn.TextColor3 = THEME.Text
    Btn.Font = Enum.Font.GothamMedium; Btn.TextSize = 11
    Btn.BorderSizePixel = 0; Btn.AutoButtonColor = false
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn.MouseButton1Click:Connect(function()
        AimbotConfig.aimPart = name
        PlayClickSound()
        for _, c in pairs(partButtonsFrame:GetChildren()) do
            if c:IsA("TextButton") then
                TweenService:Create(c, TweenInfo.new(0.15), {BackgroundColor3=THEME.Element}):Play()
            end
        end
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3=THEME.Accent}):Play()
    end)
end
CreatePartBtn("Torso", "partTorso")
CreatePartBtn("Head", "partHead")
CreatePartBtn("HumanoidRootPart", "partHRP")

local smoothLabel = Instance.new("TextLabel", SettingsPanel)
smoothLabel.Size = UDim2.new(1, 0, 0, 20); smoothLabel.BackgroundTransparency = 1
smoothLabel.Text = "  🎚️  " .. L("aimSmooth") .. ": 0.35"
smoothLabel.TextColor3 = THEME.Gold; smoothLabel.Font = Enum.Font.GothamBold
smoothLabel.TextSize = 11; smoothLabel.TextXAlignment = Enum.TextXAlignment.Left
RegisterLang(smoothLabel, "aimSmooth", "🎚️  ")

local sliderBG = Instance.new("TextButton", SettingsPanel)
sliderBG.Size = UDim2.new(1, 0, 0, 14); sliderBG.BackgroundColor3 = THEME.Element
sliderBG.Text = ""; sliderBG.BorderSizePixel = 0; sliderBG.AutoButtonColor = false
Instance.new("UICorner", sliderBG).CornerRadius = UDim.new(1, 0)

local sliderFill = Instance.new("Frame", sliderBG)
sliderFill.Size = UDim2.new(AimbotConfig.smoothness, 0, 1, 0)
sliderFill.BackgroundColor3 = THEME.Accent; sliderFill.BorderSizePixel = 0
Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

local sliderDot = Instance.new("Frame", sliderBG)
sliderDot.Size = UDim2.new(0, 16, 0, 16); sliderDot.AnchorPoint = Vector2.new(0.5, 0.5)
sliderDot.Position = UDim2.new(AimbotConfig.smoothness, 0, 0.5, 0)
sliderDot.BackgroundColor3 = THEME.Text; sliderDot.BorderSizePixel = 0
Instance.new("UICorner", sliderDot).CornerRadius = UDim.new(1, 0)

local sliderDragging = false
local function UpdateSlider(input)
    local pos = math.clamp((input.Position.X - sliderBG.AbsolutePosition.X) / sliderBG.AbsoluteSize.X, 0, 1)
    AimbotConfig.smoothness = pos
    sliderFill.Size = UDim2.new(pos, 0, 1, 0)
    sliderDot.Position = UDim2.new(pos, 0, 0.5, 0)
    smoothLabel.Text = "  🎚️  " .. L("aimSmooth") .. ": " .. string.format("%.2f", pos)
end
sliderBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliderDragging = true; UpdateSlider(input)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if sliderDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        UpdateSlider(input)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliderDragging = false
    end
end)

local panelOpen = false
GearBtn.MouseButton1Click:Connect(function()
    panelOpen = not panelOpen
    PlayClickSound()
    if panelOpen then
        SettingsPanel.Visible = true
        TweenService:Create(SettingsPanel, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 0, 180)
        }):Play()
        TweenService:Create(GearBtn, TweenInfo.new(0.3), {Rotation=180}):Play()
    else
        TweenService:Create(SettingsPanel, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(1, 0, 0, 0)
        }):Play()
        TweenService:Create(GearBtn, TweenInfo.new(0.3), {Rotation=0}):Play()
    end
end)

SwitchBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        AimbotConfig.enabled = not AimbotConfig.enabled
        OnToggleSound(AimbotConfig.enabled)
        TweenService:Create(SwitchBG, TweenInfo.new(0.2), {
            BackgroundColor3 = AimbotConfig.enabled and THEME.Success or Color3.fromRGB(60, 40, 50)
        }):Play()
        TweenService:Create(Circle, TweenInfo.new(0.2), {
            Position = AimbotConfig.enabled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        }):Play()
    end
end)

local function getMurdererChar()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and GetRole(plr) == "Murderer" then
            return plr.Character
        end
    end
    return nil
end
local function getAimPart(char)
    if not char then return nil end
    local part = AimbotConfig.aimPart
    if part == "Head" then return char:FindFirstChild("Head") end
    if part == "Torso" then
        return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
    end
    return char:FindFirstChild("HumanoidRootPart")
end

RunService.RenderStepped:Connect(function()
    if not AimbotConfig.enabled then return end
    local myChar = LocalPlayer.Character
    if not myChar then return end
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end
    local target = getMurdererChar()
    if not target then return end
    local tp = getAimPart(target)
    if not tp then return end
    if not AimbotConfig.throughWalls then
        local rp = RaycastParams.new()
        rp.FilterType = Enum.RaycastFilterType.Exclude
        rp.FilterDescendantsInstances = {myChar, target}
        local result = workspace:Raycast(myHRP.Position, (tp.Position - myHRP.Position), rp)
        if result then return end
    end
    local desired = CFrame.new(myHRP.Position, tp.Position)
    local alpha = 1 - AimbotConfig.smoothness
    if alpha < 0.05 then alpha = 0.05 end
    myHRP.CFrame = myHRP.CFrame:Lerp(desired, alpha)
end)

-- ============================================
-- ROUND TIMER
-- ============================================
local timerSec = CreateSection(VisualTab, L("roundTimer"))
local tl = timerSec:FindFirstChild("SectionLabel")
if tl then RegisterLang(tl, "roundTimer") end

local TimerGui = Instance.new("ScreenGui")
TimerGui.Name = "BonnyTimer"
TimerGui.ResetOnSpawn = false
TimerGui.IgnoreGuiInset = true
TimerGui.DisplayOrder = 999

if gethui then TimerGui.Parent = gethui()
elseif syn and syn.protect_gui then syn.protect_gui(TimerGui); TimerGui.Parent = game:GetService("CoreGui")
else
    pcall(function() TimerGui.Parent = game:GetService("CoreGui") end)
    if not TimerGui.Parent then TimerGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
end

local TimerFrame = Instance.new("Frame", TimerGui)
TimerFrame.Size = UDim2.new(0, 180, 0, 56)
TimerFrame.Position = UDim2.new(0.5, -90, 0, 20)
TimerFrame.BackgroundColor3 = THEME.Background
TimerFrame.BackgroundTransparency = 0.1
TimerFrame.BorderSizePixel = 0
TimerFrame.Visible = false
Instance.new("UICorner", TimerFrame).CornerRadius = UDim.new(0, 14)
local TFS = Instance.new("UIStroke", TimerFrame)
TFS.Color = THEME.Accent; TFS.Thickness = 2; TFS.Transparency = 0.2

local TimerIcon = Instance.new("TextLabel", TimerFrame)
TimerIcon.Size = UDim2.new(0, 40, 1, 0); TimerIcon.Position = UDim2.new(0, 6, 0, 0)
TimerIcon.BackgroundTransparency = 1; TimerIcon.Text = "⏱️"
TimerIcon.TextColor3 = THEME.Text; TimerIcon.Font = Enum.Font.GothamBold
TimerIcon.TextSize = 24

local TimerText = Instance.new("TextLabel", TimerFrame)
TimerText.Size = UDim2.new(1, -50, 1, 0); TimerText.Position = UDim2.new(0, 48, 0, 0)
TimerText.BackgroundTransparency = 1; TimerText.Text = "03:00"
TimerText.TextColor3 = THEME.Text; TimerText.Font = Enum.Font.GothamBold
TimerText.TextSize = 26; TimerText.TextXAlignment = Enum.TextXAlignment.Left

local TimerGrad = Instance.new("UIGradient", TimerText)
TimerGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.Accent2),
    ColorSequenceKeypoint.new(1, THEME.Gold)
})

local roundTimerEnabled, roundTimeLeft, timerThread = false, 180, nil
local function FormatTime(sec)
    sec = math.max(0, math.floor(sec))
    return string.format("%02d:%02d", math.floor(sec / 60), sec % 60)
end
local function UpdateTimer() TimerText.Text = FormatTime(roundTimeLeft) end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(2)
    if roundTimerEnabled then roundTimeLeft = 180; UpdateTimer() end
end)

local timerToggle = CreateToggle(VisualTab, "⏱️  " .. L("roundTimer"), false, function(state)
    roundTimerEnabled = state
    OnToggleSound(state)
    TimerFrame.Visible = state
    if state then
        roundTimeLeft = 180; UpdateTimer()
        if timerThread then task.cancel(timerThread) end
        timerThread = task.spawn(function()
            while roundTimerEnabled do
                task.wait(1)
                if roundTimeLeft > 0 then
                    roundTimeLeft = roundTimeLeft - 1
                    UpdateTimer()
                end
            end
        end)
    else
        if timerThread then task.cancel(timerThread); timerThread = nil end
    end
end)
RegisterLang(timerToggle, "roundTimer", "⏱️  ")

-- ============================================
-- TELEPORTS
-- ============================================
local tpSec = CreateSection(TeleportsTab, L("teleports"))
local tpl = tpSec:FindFirstChild("SectionLabel")
if tpl then RegisterLang(tpl, "teleports") end

local SPAWN_POS = Vector3.new(-16.2, 504.8, -27.3)

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
    StarterGui:SetCore("SendNotification", {Title="Bonny Hub", Text=L("noTarget"), Duration=2})
end
local function TpToSpawn()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    char.HumanoidRootPart.CFrame = CFrame.new(SPAWN_POS + Vector3.new(0, 3, 0))
end

local tpM = CreateButton(TeleportsTab, "🔴  " .. L("tpMurderer"), function()
    PlayClickSound(); TPToPlayer("Murderer")
end)
RegisterLang(tpM, "tpMurderer", "🔴  ")

local tpS = CreateButton(TeleportsTab, "🔵  " .. L("tpSheriff"), function()
    PlayClickSound(); TPToPlayer("Sheriff")
end)
RegisterLang(tpS, "tpSheriff", "🔵  ")

local tpMp = CreateButton(TeleportsTab, "🗺️  " .. L("tpMap"), function()
    PlayClickSound(); TpToSpawn()
end)
RegisterLang(tpMp, "tpMap", "🗺️  ")

local tpSp = CreateButton(TeleportsTab, "🏠  " .. L("tpSpawn"), function()
    PlayClickSound(); TpToSpawn()
end)
RegisterLang(tpSp, "tpSpawn", "🏠  ")

-- ============================================
-- TROLL
-- ============================================
local trSec = CreateSection(TrollTab, L("trollFeatures"))
local trl = trSec:FindFirstChild("SectionLabel")
if trl then RegisterLang(trl, "trollFeatures") end

local touchFlingEnabled, touchFlingConnections, flingDebounce = false, {}, {}
local function FlingCharacter(targetChar)
    if not targetChar or not targetChar.Parent then return end
    local hrp = targetChar:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local now = tick()
    if flingDebounce[targetChar] and now - flingDebounce[targetChar] < 0.5 then return end
    flingDebounce[targetChar] = now
    for _, c in pairs(hrp:GetChildren()) do
        if c.Name == "BonnyFling" then c:Destroy() end
    end
    local bv = Instance.new("BodyVelocity")
    bv.Name = "BonnyFling"
    bv.Velocity = Vector3.new(math.random(-300, 300), 500, math.random(-300, 300))
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.P = 5000
    bv.Parent = hrp
    game:GetService("Debris"):AddItem(bv, 0.4)
end
local function setupTouchFling()
    for _, c in pairs(touchFlingConnections) do c:Disconnect() end
    touchFlingConnections = {}
    local char = LocalPlayer.Character
    if not char then return end
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            local conn = part.Touched:Connect(function(hit)
                if not touchFlingEnabled then return end
                local otherChar = hit:FindFirstAncestorOfClass("Model")
                if not otherChar or otherChar == char then return end
                local otherPlayer = Players:GetPlayerFromCharacter(otherChar)
                if not otherPlayer or otherPlayer == LocalPlayer then return end
                FlingCharacter(otherChar)
            end)
            table.insert(touchFlingConnections, conn)
        end
    end
end
local tfToggle = CreateToggle(TrollTab, "✋  " .. L("touchFling"), false, function(state)
    touchFlingEnabled = state
    OnToggleSound(state)
    if state then setupTouchFling()
    else
        for _, c in pairs(touchFlingConnections) do c:Disconnect() end
        touchFlingConnections = {}
    end
end)
RegisterLang(tfToggle, "touchFling", "✋  ")
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if touchFlingEnabled then setupTouchFling() end
end)

-- ============================================
-- SETTINGS
-- ============================================
local setSec = CreateSection(SettingsTab, L("settings"))
local sl = setSec:FindFirstChild("SectionLabel")
if sl then RegisterLang(sl, "settings") end

local langLabel = Instance.new("TextLabel", SettingsTab)
langLabel.Size = UDim2.new(1, 0, 0, 26); langLabel.BackgroundTransparency = 1
langLabel.Text = "  🌐  " .. L("language"); langLabel.TextColor3 = THEME.Gold
langLabel.Font = Enum.Font.GothamBold; langLabel.TextSize = 12
langLabel.TextXAlignment = Enum.TextXAlignment.Left
RegisterLang(langLabel, "language", "🌐  ")

CreateButton(SettingsTab, "🇬🇧  English", function()
    PlayClickSound()
    Lang.current = "en"
    ApplyLang()
end)
CreateButton(SettingsTab, "🇷🇺  Русский", function()
    PlayClickSound()
    Lang.current = "ru"
    ApplyLang()
end)

local clickLabel = Instance.new("TextLabel", SettingsTab)
clickLabel.Size = UDim2.new(1, 0, 0, 26); clickLabel.BackgroundTransparency = 1
clickLabel.Text = "  🔊  " .. L("clickSound"); clickLabel.TextColor3 = THEME.Gold
clickLabel.Font = Enum.Font.GothamBold; clickLabel.TextSize = 12
clickLabel.TextXAlignment = Enum.TextXAlignment.Left
RegisterLang(clickLabel, "clickSound", "🔊  ")

local clickBtns = {}
local function UpdateClickBtns()
    for i, btn in pairs(clickBtns) do
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = (i == SoundConfig.clickSound) and THEME.Accent or THEME.Element
        }):Play()
    end
end
local function CreateSoundBtn(text, index)
    local Btn = CreateButton(SettingsTab, text, function()
        SoundConfig.clickSound = index
        if index ~= 0 then PlayClickSound() end
        UpdateClickBtns()
    end)
    clickBtns[index] = Btn
    if SoundConfig.clickSound == index then Btn.BackgroundColor3 = THEME.Accent end
end
CreateSoundBtn("1. " .. L("noSound"), 0)
CreateSoundBtn("2. " .. L("clientSound"), 1)
CreateSoundBtn("3. " .. L("client2"), 2)
CreateSoundBtn("4. " .. L("client3"), 3)

local disLabel = Instance.new("TextLabel", SettingsTab)
disLabel.Size = UDim2.new(1, 0, 0, 26); disLabel.BackgroundTransparency = 1
disLabel.Text = "  🔕  " .. L("disableSound"); disLabel.TextColor3 = THEME.Gold
disLabel.Font = Enum.Font.GothamBold; disLabel.TextSize = 12
disLabel.TextXAlignment = Enum.TextXAlignment.Left
RegisterLang(disLabel, "disableSound", "🔕  ")

local disBtns = {}
local function UpdateDisBtns()
    for i, btn in pairs(disBtns) do
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = (i == SoundConfig.disableSound) and THEME.Accent or THEME.Element
        }):Play()
    end
end
local function CreateDisBtn(text, index)
    local Btn = CreateButton(SettingsTab, text, function()
        SoundConfig.disableSound = index
        if index == 1 then PlayDisableSound() end
        UpdateDisBtns()
    end)
    disBtns[index] = Btn
    if SoundConfig.disableSound == index then Btn.BackgroundColor3 = THEME.Accent end
end
CreateDisBtn("1. " .. L("noSound") .. " (default)", 0)
CreateDisBtn("2. " .. L("disableSound"), 1)

-- ============================================
-- LAUNCH
-- ============================================
for _, btn in pairs(TabButtons) do
    btn.MouseButton1Click:Fire()
    break
end

StarterGui:SetCore("SendNotification", {
    Title = "★ Bonny Hub",
    Text = L("loaded"),
    Duration = 3
})

print("[Bonny Hub] ✨ Loaded successfully!")
