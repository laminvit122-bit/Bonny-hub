if _G.BonnyHubLoaded then
    pcall(function()
        game:GetService("CoreGui"):FindFirstChild("BonnyHub"):Destroy()
    end)
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
    Background = Color3.fromRGB(15, 8, 12),
    Background2 = Color3.fromRGB(30, 10, 20),
    Background3 = Color3.fromRGB(45, 15, 28),
    Sidebar = Color3.fromRGB(22, 10, 17),
    Element = Color3.fromRGB(40, 18, 30),
    ElementHover = Color3.fromRGB(65, 25, 45),
    Accent = Color3.fromRGB(255, 30, 80),
    Accent2 = Color3.fromRGB(255, 100, 150),
    Gold = Color3.fromRGB(255, 200, 60),
    Purple = Color3.fromRGB(180, 80, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(190, 150, 170),
    Success = Color3.fromRGB(0, 220, 130)
}

local Lang = {
    current = "en",
    strings = {
        en = {
            main = "Main Features",
            noclip = "Noclip",
            autoPickup = "Auto Pickup Gun",
            chatInfo = "Chat Info",
            chatRoles = "Copy Roles to Clipboard",
            chatCopied = "Copied! Paste in chat",
            visual = "Visual Features",
            esp = "ESP Players",
            espGun = "ESP Guns",
            fullbright = "Fullbright",
            removeFog = "Remove Fog",
            roundTimer = "Round Timer",
            aimbot = "Aimbot Murderer",
            aimWall = "Aim Through Walls",
            aimPart = "Aim Part",
            aimSmooth = "Smoothness",
            partTorso = "Torso",
            partHead = "Head",
            partHRP = "HRP",
            teleports = "Teleports",
            tpMurderer = "Teleport to Murderer",
            tpSheriff = "Teleport to Sheriff",
            tpMap = "Teleport to Map",
            tpSpawn = "Teleport to Spawn",
            troll = "Troll Features",
            touchFling = "Touch Fling",
            skullTexture = "Skull Texture",
            settings = "Settings",
            language = "Language",
            clickSound = "Click Sound",
            noSound = "No Sound",
            c1 = "Client",
            c2 = "Client 2",
            c3 = "Client 3",
            disSound = "Disable Sound",
            loaded = "Loaded successfully!",
            noTarget = "Target not found"
        },
        ru = {
            main = "Основные функции",
            noclip = "Noclip",
            autoPickup = "Авто-подбор пистолета",
            chatInfo = "Информация в чат",
            chatRoles = "Скопировать роли в буфер",
            chatCopied = "Скопировано! Вставь в чат",
            visual = "Визуальные функции",
            esp = "ESP игроков",
            espGun = "ESP пистолета",
            fullbright = "Полная яркость",
            removeFog = "Убрать туман",
            roundTimer = "Таймер раунда",
            aimbot = "Аим на мардера",
            aimWall = "Наводиться через стены",
            aimPart = "Часть тела",
            aimSmooth = "Плавность",
            partTorso = "Туловище",
            partHead = "Голова",
            partHRP = "HRP",
            teleports = "Телепорты",
            tpMurderer = "ТП к мардеру",
            tpSheriff = "ТП к шерифу",
            tpMap = "ТП на карту",
            tpSpawn = "ТП на спавн",
            troll = "Тролль функции",
            touchFling = "Тач-флинг",
            skullTexture = "Текстура черепа",
            settings = "Настройки",
            language = "Язык",
            clickSound = "Звук клика",
            noSound = "Без звука",
            c1 = "Client",
            c2 = "Client 2",
            c3 = "Client 3",
            disSound = "Звук выключения",
            loaded = "Загружено!",
            noTarget = "Цель не найдена"
        }
    }
}

local function L(key)
    return Lang.strings[Lang.current][key] or key
end

local LangRefs = {}

local function RegLang(ref, key, pfx)
    table.insert(LangRefs, {ref = ref, key = key, pfx = pfx or ""})
end

local function ApplyLang()
    for _, entry in ipairs(LangRefs) do
        pcall(function()
            if entry.ref and entry.ref.Parent then
                if entry.ref.Name == "SectionLabel" then
                    entry.ref.Text = "  " .. L(entry.key)
                else
                    entry.ref.Text = "  " .. entry.pfx .. L(entry.key)
                end
            end
        end)
    end
end

local SoundConfig = {
    click = 0,
    disable = 0
}

local SOUND_IDS = {
    [0] = nil,
    [1] = "rbxassetid://87437544236708",
    [2] = "rbxassetid://140207837688369",
    [3] = "rbxassetid://139421450430380"
}

local DIS_SOUND = {
    [0] = nil,
    [1] = "rbxassetid://73954763982661"
}

local soundCache = {}

local function PreloadSound(id)
    if soundCache[id] then
        return soundCache[id]
    end
    local s = Instance.new("Sound")
    s.SoundId = id
    s.Volume = 1.5
    s.Parent = SoundService
    soundCache[id] = s
    return s
end

for _, id in pairs(SOUND_IDS) do
    if id then
        PreloadSound(id)
    end
end

for _, id in pairs(DIS_SOUND) do
    if id then
        PreloadSound(id)
    end
end

task.wait(0.3)

local function PlayClick()
    local id = SOUND_IDS[SoundConfig.click]
    if not id then return end
    local s = soundCache[id]
    if s then
        s.TimePosition = 0
        s:Play()
    else
        PreloadSound(id):Play()
    end
end

local function PlayDisable()
    local id = DIS_SOUND[SoundConfig.disable]
    if not id then return end

    local s = Instance.new("Sound")
    s.SoundId = id
    s.Volume = 1.5
    s.Parent = SoundService
    s:Play()
    game:GetService("Debris"):AddItem(s, 5)
end

local function OnSound(state)
    if state then
        PlayClick()
    else
        if SoundConfig.disable > 0 then
            PlayDisable()
        else
            PlayClick()
        end
    end
end

local function IsGun(t)
    if not t or not t:IsA("Tool") then return false end
    local n = t.Name:lower()
    return n:find("gun") or n:find("revolver") or n:find("pistol")
end

local function IsKnife(t)
    if not t or not t:IsA("Tool") then return false end
    local n = t.Name:lower()
    return n:find("knife") or n:find("sword") or n:find("m9")
        or n:find("dagger") or n:find("blade")
end

local function HasGun(c)
    if not c then return false end
    for _, i in pairs(c:GetChildren()) do
        if IsGun(i) then return true end
    end
    return false
end

local function GetRole(plr)
    if plr == LocalPlayer then
        return "LocalPlayer"
    end

    local char = plr.Character
    if not char then
        return "Innocent"
    end

    local bp = plr:FindFirstChildOfClass("Backpack")
    local cbp = char:FindFirstChildOfClass("Backpack")

    local hg = false
    local hk = false

    local function scan(c)
        if not c then return end
        for _, i in pairs(c:GetChildren()) do
            if i:IsA("Tool") then
                local n = i.Name:lower()
                if n:find("gun") or n:find("revolver") or n:find("pistol") then
                    hg = true
                end
                if n:find("knife") or n:find("sword") or n:find("m9")
                or n:find("dagger") or n:find("blade") then
                    hk = true
                end
            end
        end
    end

    scan(char)
    if bp then scan(bp) end
    if cbp then scan(cbp) end

    if hg then return "Sheriff" end
    if hk then return "Murderer" end
    return "Innocent"
end

local function GetColors(role)
    if role == "Murderer" then
        return Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 130, 130)
    elseif role == "Sheriff" then
        return Color3.fromRGB(0, 100, 255), Color3.fromRGB(120, 180, 255)
    elseif role == "Innocent" then
        return Color3.fromRGB(0, 200, 50), Color3.fromRGB(130, 255, 160)
    end
    return Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)
end

local function Clip(text)
    if setclipboard then
        return pcall(setclipboard, text)
    end
    if toclipboard then
        return pcall(toclipboard, text)
    end
    if syn and syn.setclipboard then
        return pcall(syn.setclipboard, text)
    end
    return false
end

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
    pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    if not ScreenGui.Parent then
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 540, 0, 420)
MainFrame.Position = UDim2.new(0.5, -270, 0.5, -210)
MainFrame.BackgroundColor3 = THEME.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 16)

local BG = Instance.new("UIGradient", MainFrame)
BG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.Background3),
    ColorSequenceKeypoint.new(0.5, THEME.Background),
    ColorSequenceKeypoint.new(1, THEME.Background2)
})
BG.Rotation = 135

local OG = Instance.new("UIStroke", MainFrame)
OG.Color = THEME.Accent
OG.Thickness = 2
OG.Transparency = 0.2

local TB = Instance.new("Frame", MainFrame)
TB.Size = UDim2.new(1, 0, 0, 46)
TB.BackgroundColor3 = THEME.Sidebar
TB.BackgroundTransparency = 0.2
TB.BorderSizePixel = 0

local TBC = Instance.new("UICorner", TB)
TBC.CornerRadius = UDim.new(0, 16)

local TBo = Instance.new("Frame", TB)
TBo.Size = UDim2.new(1, 0, 0, 16)
TBo.Position = UDim2.new(0, 0, 1, -16)
TBo.BackgroundColor3 = THEME.Sidebar
TBo.BackgroundTransparency = 0.2
TBo.BorderSizePixel = 0

local LF = Instance.new("Frame", TB)
LF.Size = UDim2.new(0, 32, 0, 32)
LF.Position = UDim2.new(0, 14, 0.5, -16)
LF.BackgroundColor3 = THEME.Accent
LF.BorderSizePixel = 0

local LFC = Instance.new("UICorner", LF)
LFC.CornerRadius = UDim.new(0, 9)

local LG = Instance.new("UIGradient", LF)
LG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.Accent),
    ColorSequenceKeypoint.new(0.5, THEME.Purple),
    ColorSequenceKeypoint.new(1, THEME.Gold)
})
LG.Rotation = 45

local LS = Instance.new("UIStroke", LF)
LS.Color = THEME.Accent2
LS.Thickness = 1
LS.Transparency = 0.3

local Logo = Instance.new("TextLabel", LF)
Logo.Size = UDim2.new(1, 0, 1, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "*"
Logo.TextColor3 = THEME.Text
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 19

local T = Instance.new("TextLabel", TB)
T.Size = UDim2.new(1, -200, 0, 22)
T.Position = UDim2.new(0, 56, 0, 6)
T.BackgroundTransparency = 1
T.Text = "BONNY HUB"
T.TextColor3 = THEME.Text
T.Font = Enum.Font.GothamBold
T.TextSize = 16
T.TextXAlignment = Enum.TextXAlignment.Left

local TG = Instance.new("UIGradient", T)
TG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.Text),
    ColorSequenceKeypoint.new(1, THEME.Accent2)
})

local ST = Instance.new("TextLabel", TB)
ST.Size = UDim2.new(1, -200, 0, 14)
ST.Position = UDim2.new(0, 56, 0, 26)
ST.BackgroundTransparency = 1
ST.Text = "PREMIUM EDITION"
ST.TextColor3 = THEME.TextDim
ST.Font = Enum.Font.Gotham
ST.TextSize = 9
ST.TextXAlignment = Enum.TextXAlignment.Left

local function TBtn(sym, x, clr, cb)
    local B = Instance.new("TextButton", TB)
    B.Size = UDim2.new(0, 28, 0, 28)
    B.Position = UDim2.new(1, x, 0.5, -14)
    B.BackgroundColor3 = THEME.Element
    B.BackgroundTransparency = 0.4
    B.Text = sym
    B.TextColor3 = clr
    B.Font = Enum.Font.GothamBold
    B.TextSize = 16
    B.BorderSizePixel = 0
    B.AutoButtonColor = false

    local C = Instance.new("UICorner", B)
    C.CornerRadius = UDim.new(0, 8)

    B.MouseEnter:Connect(function()
        TweenService:Create(B, TweenInfo.new(0.15), {
            BackgroundTransparency = 0
        }):Play()
    end)

    B.MouseLeave:Connect(function()
        TweenService:Create(B, TweenInfo.new(0.15), {
            BackgroundTransparency = 0.4
        }):Play()
    end)

    B.MouseButton1Click:Connect(cb)
    return B
end

local miniBtn

TBtn("-", -74, THEME.TextDim, function()
    local closeTween = TweenService:Create(
        MainFrame,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }
    )
    closeTween:Play()
    closeTween.Completed:Wait()

    MainFrame.Visible = false
    MainFrame.Size = UDim2.new(0, 540, 0, 420)
    MainFrame.Position = UDim2.new(0.5, -270, 0.5, -210)

    if miniBtn then
        miniBtn:Destroy()
    end

    local M = Instance.new("TextButton", ScreenGui)
    M.Size = UDim2.new(0, 0, 0, 0)
    M.Position = UDim2.new(0, 100, 0.5, -30)
    M.BackgroundColor3 = THEME.Background
    M.Text = "*"
    M.TextColor3 = THEME.Text
    M.TextScaled = true
    M.Font = Enum.Font.GothamBold
    M.BorderSizePixel = 0
    M.Active = true
    M.AutoButtonColor = false

    local MC = Instance.new("UICorner", M)
    MC.CornerRadius = UDim.new(0, 14)

    local MG = Instance.new("UIGradient", M)
    MG.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, THEME.Accent),
        ColorSequenceKeypoint.new(1, THEME.Purple)
    })
    MG.Rotation = 45

    local MS = Instance.new("UIStroke", M)
    MS.Color = THEME.Accent2
    MS.Thickness = 2

    TweenService:Create(
        M,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        { Size = UDim2.new(0, 60, 0, 60) }
    ):Play()

    task.spawn(function()
        while M.Parent do
            TweenService:Create(MS, TweenInfo.new(1), {
                Transparency = 0.5
            }):Play()
            task.wait(1)

            if not M.Parent then break end

            TweenService:Create(MS, TweenInfo.new(1), {
                Transparency = 0
            }):Play()
            task.wait(1)
        end
    end)

    local dragStart, startPos, moved = nil, nil, false

    M.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragStart = input.Position
            startPos = M.Position
            moved = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragStart and (
            input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
        ) then
            local delta = input.Position - dragStart

            if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
                moved = true
            end

            if moved then
                M.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            if not moved and dragStart then
                local t1 = TweenService:Create(
                    M,
                    TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                    { Size = UDim2.new(0, 0, 0, 0) }
                )
                t1:Play()

                MainFrame.Visible = true
                MainFrame.Size = UDim2.new(0, 0, 0, 0)
                MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

                TweenService:Create(
                    MainFrame,
                    TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                    {
                        Size = UDim2.new(0, 540, 0, 420),
                        Position = UDim2.new(0.5, -270, 0.5, -210)
                    }
                ):Play()

                t1.Completed:Wait()
                M:Destroy()
                miniBtn = nil
            end

            dragStart = nil
            startPos = nil
            moved = false
        end
    end)

    miniBtn = M
end)

TBtn("x", -42, Color3.fromRGB(255, 80, 80), function()
    local t = TweenService:Create(
        MainFrame,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }
    )
    t:Play()
    t.Completed:Wait()

    ScreenGui:Destroy()
    _G.BonnyHubLoaded = false
end)

local SB = Instance.new("Frame", MainFrame)
SB.Size = UDim2.new(0, 155, 1, -125)
SB.Position = UDim2.new(0, 12, 0, 54)
SB.BackgroundColor3 = THEME.Sidebar
SB.BackgroundTransparency = 0.15
SB.BorderSizePixel = 0

local SBC = Instance.new("UICorner", SB)
SBC.CornerRadius = UDim.new(0, 12)

local SBS = Instance.new("UIStroke", SB)
SBS.Color = THEME.Accent
SBS.Thickness = 1
SBS.Transparency = 0.6

local VL = Instance.new("TextLabel", SB)
VL.Size = UDim2.new(1, -20, 0, 26)
VL.Position = UDim2.new(0, 10, 0, 10)
VL.BackgroundColor3 = THEME.Element
VL.BackgroundTransparency = 0.2
VL.Text = "BONNY"
VL.TextColor3 = THEME.Gold
VL.Font = Enum.Font.GothamBold
VL.TextSize = 11
VL.BorderSizePixel = 0

local VLC = Instance.new("UICorner", VL)
VLC.CornerRadius = UDim.new(0, 7)

local VLS = Instance.new("UIStroke", VL)
VLS.Color = THEME.Gold
VLS.Thickness = 1
VLS.Transparency = 0.7

local TLF = Instance.new("Frame", SB)
TLF.Size = UDim2.new(1, -20, 1, -50)
TLF.Position = UDim2.new(0, 10, 0, 44)
TLF.BackgroundTransparency = 1

local TL = Instance.new("UIListLayout", TLF)
TL.Padding = UDim.new(0, 6)
TL.SortOrder = Enum.SortOrder.LayoutOrder

local C = Instance.new("Frame", MainFrame)
C.Size = UDim2.new(1, -185, 1, -125)
C.Position = UDim2.new(0, 175, 0, 54)
C.BackgroundColor3 = THEME.Sidebar
C.BackgroundTransparency = 0.15
C.BorderSizePixel = 0

local CC = Instance.new("UICorner", C)
CC.CornerRadius = UDim.new(0, 12)

local CS = Instance.new("UIStroke", C)
CS.Color = THEME.Accent
CS.Thickness = 1
CS.Transparency = 0.6

local PF = Instance.new("Frame", MainFrame)
PF.Size = UDim2.new(1, -24, 0, 52)
PF.Position = UDim2.new(0, 12, 1, -64)
PF.BackgroundColor3 = THEME.Element
PF.BackgroundTransparency = 0.3
PF.BorderSizePixel = 0

local PFC = Instance.new("UICorner", PF)
PFC.CornerRadius = UDim.new(0, 10)

local PFS = Instance.new("UIStroke", PF)
PFS.Color = THEME.Accent
PFS.Thickness = 1
PFS.Transparency = 0.6

local AF = Instance.new("Frame", PF)
AF.Size = UDim2.new(0, 40, 0, 40)
AF.Position = UDim2.new(0, 6, 0.5, -20)
AF.BackgroundColor3 = THEME.Accent
AF.BorderSizePixel = 0

local AFC = Instance.new("UICorner", AF)
AFC.CornerRadius = UDim.new(1, 0)

local AI = Instance.new("ImageLabel", AF)
AI.Size = UDim2.new(1, -4, 1, -4)
AI.Position = UDim2.new(0, 2, 0, 2)
AI.BackgroundTransparency = 1
AI.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"

local AIC = Instance.new("UICorner", AI)
AIC.CornerRadius = UDim.new(1, 0)

local NL = Instance.new("TextLabel", PF)
NL.Size = UDim2.new(1, -90, 0, 16)
NL.Position = UDim2.new(0, 54, 0, 10)
NL.BackgroundTransparency = 1
NL.Text = LocalPlayer.DisplayName
NL.TextColor3 = THEME.Text
NL.Font = Enum.Font.GothamBold
NL.TextSize = 12
NL.TextXAlignment = Enum.TextXAlignment.Left

local UL = Instance.new("TextLabel", PF)
UL.Size = UDim2.new(1, -90, 0, 14)
UL.Position = UDim2.new(0, 54, 0, 26)
UL.BackgroundTransparency = 1
UL.Text = "@" .. LocalPlayer.Name
UL.TextColor3 = THEME.TextDim
UL.Font = Enum.Font.Gotham
UL.TextSize = 10
UL.TextXAlignment = Enum.TextXAlignment.Left

local OD = Instance.new("Frame", PF)
OD.Size = UDim2.new(0, 10, 0, 10)
OD.Position = UDim2.new(1, -18, 0.5, -5)
OD.BackgroundColor3 = THEME.Success
OD.BorderSizePixel = 0

local ODC = Instance.new("UICorner", OD)
ODC.CornerRadius = UDim.new(1, 0)

local ODS = Instance.new("UIStroke", OD)
ODS.Color = THEME.Success
ODS.Thickness = 2
ODS.Transparency = 0.4

task.spawn(function()
    while OD.Parent do
        TweenService:Create(ODS, TweenInfo.new(1), {
            Transparency = 0.8,
            Thickness = 4
        }):Play()
        task.wait(1)

        if not OD.Parent then break end

        TweenService:Create(ODS, TweenInfo.new(1), {
            Transparency = 0.4,
            Thickness = 2
        }):Play()
        task.wait(1)
    end
end)

local Tabs = {}
local TabsBtns = {}

local TAB_ICONS = {
    Main = "rbxassetid://7539983780",
    Visual = "rbxassetid://10709791942",
    Teleports = "rbxassetid://10709791706",
    Troll = "rbxassetid://10653372160",
    Settings = "rbxassetid://10734950023"
}

local function NewTab(name, iconId)
    local B = Instance.new("TextButton", TLF)
    B.Size = UDim2.new(1, 0, 0, 32)
    B.BackgroundColor3 = THEME.Element
    B.BackgroundTransparency = 0.4
    B.Text = ""
    B.TextColor3 = THEME.TextDim
    B.Font = Enum.Font.GothamMedium
    B.TextSize = 13
    B.TextXAlignment = Enum.TextXAlignment.Left
    B.BorderSizePixel = 0
    B.AutoButtonColor = false

    local BC = Instance.new("UICorner", B)
    BC.CornerRadius = UDim.new(0, 8)

    if iconId then
        local ico = Instance.new("ImageLabel", B)
        ico.Size = UDim2.new(0, 18, 0, 18)
        ico.Position = UDim2.new(0, 8, 0.5, -9)
        ico.BackgroundTransparency = 1
        ico.Image = iconId
        ico.ImageColor3 = THEME.TextDim
        ico.Name = "Icon"
    end

    local txt = Instance.new("TextLabel", B)
    txt.Size = UDim2.new(1, -36, 1, 0)
    txt.Position = UDim2.new(0, 32, 0, 0)
    txt.BackgroundTransparency = 1
    txt.Text = name
    txt.TextColor3 = THEME.TextDim
    txt.Font = Enum.Font.GothamMedium
    txt.TextSize = 13
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Name = "Label"

    local St = Instance.new("Frame", B)
    St.Name = "Stripe"
    St.Size = UDim2.new(0, 3, 0.6, 0)
    St.Position = UDim2.new(0, 0, 0.2, 0)
    St.BackgroundColor3 = THEME.Accent
    St.BorderSizePixel = 0
    St.Visible = false

    local SC = Instance.new("UICorner", St)
    SC.CornerRadius = UDim.new(1, 0)

    local TC = Instance.new("ScrollingFrame", C)
    TC.Size = UDim2.new(1, -20, 1, -20)
    TC.Position = UDim2.new(0, 10, 0, 10)
    TC.BackgroundTransparency = 1
    TC.BorderSizePixel = 0
    TC.CanvasSize = UDim2.new(0, 0, 0, 0)
    TC.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TC.ScrollBarThickness = 3
    TC.ScrollBarImageColor3 = THEME.Accent
    TC.Visible = false

    local CL = Instance.new("UIListLayout", TC)
    CL.Padding = UDim.new(0, 6)
    CL.SortOrder = Enum.SortOrder.LayoutOrder

    Tabs[name] = TC
    TabsBtns[name] = B

    B.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Visible = false
        end

        for _, btn in pairs(TabsBtns) do
            btn.BackgroundColor3 = THEME.Element
            btn.BackgroundTransparency = 0.4
            local lbl = btn:FindFirstChild("Label")
            if lbl then lbl.TextColor3 = THEME.TextDim end
            local ico = btn:FindFirstChild("Icon")
            if ico then ico.ImageColor3 = THEME.TextDim end
            local s = btn:FindFirstChild("Stripe")
            if s then s.Visible = false end
        end

        TC.Visible = true
        B.BackgroundColor3 = THEME.Accent
        B.BackgroundTransparency = 0.15

        local lbl = B:FindFirstChild("Label")
        if lbl then lbl.TextColor3 = THEME.Text end
        local ico = B:FindFirstChild("Icon")
        if ico then ico.ImageColor3 = THEME.Text end
        local s = B:FindFirstChild("Stripe")
        if s then s.Visible = true end
    end)

    B.MouseEnter:Connect(function()
        if TC.Visible == false then
            TweenService:Create(B, TweenInfo.new(0.15), {
                BackgroundTransparency = 0.15
            }):Play()
        end
    end)

    B.MouseLeave:Connect(function()
        if TC.Visible == false then
            TweenService:Create(B, TweenInfo.new(0.15), {
                BackgroundTransparency = 0.4
            }):Play()
        end
    end)

    return TC
end

local function NewSection(parent, text)
    local W = Instance.new("Frame", parent)
    W.Size = UDim2.new(1, 0, 0, 26)
    W.BackgroundTransparency = 1

    local Ln = Instance.new("Frame", W)
    Ln.Size = UDim2.new(1, 0, 0, 1)
    Ln.Position = UDim2.new(0, 0, 0.5, 0)
    Ln.BackgroundColor3 = THEME.Accent
    Ln.BackgroundTransparency = 0.5
    Ln.BorderSizePixel = 0

    local S = Instance.new("TextLabel", W)
    S.Name = "SectionLabel"
    S.Size = UDim2.new(0, 220, 1, 0)
    S.Position = UDim2.new(0, 8, 0, 0)
    S.BackgroundColor3 = THEME.Sidebar
    S.BackgroundTransparency = 0.1
    S.Text = "  " .. text
    S.TextColor3 = THEME.Gold
    S.Font = Enum.Font.GothamBold
    S.TextSize = 12
    S.TextXAlignment = Enum.TextXAlignment.Left
    S.BorderSizePixel = 0

    local SC = Instance.new("UICorner", S)
    SC.CornerRadius = UDim.new(0, 6)

    return W
end

local function NewButton(parent, text, cb)
    local B = Instance.new("TextButton", parent)
    B.Size = UDim2.new(1, 0, 0, 32)
    B.BackgroundColor3 = THEME.Element
    B.BackgroundTransparency = 0.15
    B.Text = "  " .. text
    B.TextColor3 = THEME.Text
    B.Font = Enum.Font.GothamMedium
    B.TextSize = 12
    B.TextXAlignment = Enum.TextXAlignment.Left
    B.BorderSizePixel = 0
    B.AutoButtonColor = false

    local C2 = Instance.new("UICorner", B)
    C2.CornerRadius = UDim.new(0, 8)

    local S = Instance.new("UIStroke", B)
    S.Color = THEME.Accent
    S.Thickness = 1
    S.Transparency = 0.85

    B.MouseEnter:Connect(function()
        TweenService:Create(B, TweenInfo.new(0.15), {
            BackgroundColor3 = THEME.ElementHover,
            BackgroundTransparency = 0
        }):Play()
    end)

    B.MouseLeave:Connect(function()
        TweenService:Create(B, TweenInfo.new(0.15), {
            BackgroundColor3 = THEME.Element,
            BackgroundTransparency = 0.15
        }):Play()
    end)

    B.MouseButton1Click:Connect(cb)
    return B
end

local function NewToggle(parent, text, def, cb)
    local state = def or false

    local F = Instance.new("TextButton", parent)
    F.Size = UDim2.new(1, 0, 0, 32)
    F.BackgroundColor3 = state and THEME.Accent or THEME.Element
    F.BackgroundTransparency = state and 0.6 or 0.15
    F.Text = "  " .. text
    F.TextColor3 = THEME.Text
    F.Font = Enum.Font.GothamMedium
    F.TextSize = 12
    F.TextXAlignment = Enum.TextXAlignment.Left
    F.BorderSizePixel = 0
    F.AutoButtonColor = false

    local C2 = Instance.new("UICorner", F)
    C2.CornerRadius = UDim.new(0, 8)

    local S = Instance.new("UIStroke", F)
    S.Color = THEME.Accent
    S.Thickness = state and 2 or 1
    S.Transparency = state and 0 or 0.85

    local SB2 = Instance.new("Frame", F)
    SB2.Size = UDim2.new(0, 36, 0, 18)
    SB2.Position = UDim2.new(1, -46, 0.5, -9)
    SB2.BackgroundColor3 = state and THEME.Success or Color3.fromRGB(60, 40, 50)
    SB2.BorderSizePixel = 0

    local SB2C = Instance.new("UICorner", SB2)
    SB2C.CornerRadius = UDim.new(1, 0)

    local Ci = Instance.new("Frame", SB2)
    Ci.Size = UDim2.new(0, 14, 0, 14)
    Ci.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    Ci.BackgroundColor3 = THEME.Text
    Ci.BorderSizePixel = 0

    local CiC = Instance.new("UICorner", Ci)
    CiC.CornerRadius = UDim.new(1, 0)

    F.MouseButton1Click:Connect(function()
        state = not state

        TweenService:Create(SB2, TweenInfo.new(0.2), {
            BackgroundColor3 = state and THEME.Success or Color3.fromRGB(60, 40, 50)
        }):Play()

        TweenService:Create(Ci, TweenInfo.new(0.2), {
            Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        }):Play()

        TweenService:Create(F, TweenInfo.new(0.2), {
            BackgroundColor3 = state and THEME.Accent or THEME.Element,
            BackgroundTransparency = state and 0.6 or 0.15
        }):Play()

        TweenService:Create(S, TweenInfo.new(0.2), {
            Thickness = state and 2 or 1,
            Transparency = state and 0 or 0.85
        }):Play()

        if cb then cb(state) end
    end)

    F.MouseEnter:Connect(function()
        if not state then
            TweenService:Create(F, TweenInfo.new(0.15), {
                BackgroundColor3 = THEME.ElementHover,
                BackgroundTransparency = 0
            }):Play()
        end
    end)

    F.MouseLeave:Connect(function()
        if not state then
            TweenService:Create(F, TweenInfo.new(0.15), {
                BackgroundColor3 = THEME.Element,
                BackgroundTransparency = 0.15
            }):Play()
        end
    end)

    return F
end

local MainTab = NewTab("Main", TAB_ICONS.Main)
local VisualTab = NewTab("Visual", TAB_ICONS.Visual)
local TeleportsTab = NewTab("Teleports", TAB_ICONS.Teleports)
local TrollTab = NewTab("Troll", TAB_ICONS.Troll)
local SettingsTab = NewTab("Settings", TAB_ICONS.Settings)

-- MAIN
local mSec = NewSection(MainTab, L("main"))
local ml = mSec:FindFirstChild("SectionLabel")
if ml then RegLang(ml, "main") end

local noclipOn = false
local noclipConn = nil

local function StartNoclip()
    if noclipConn then
        noclipConn:Disconnect()
    end
    noclipConn = RunService.Stepped:Connect(function()
        if not noclipOn then return end
        local ch = LocalPlayer.Character
        if ch then
            for _, p in pairs(ch:GetDescendants()) do
                if p:IsA("BasePart") and p.CanCollide then
                    p.CanCollide = false
                end
            end
        end
    end)
end

local ncT = NewToggle(MainTab, L("noclip"), false, function(s)
    noclipOn = s
    OnSound(s)
    if s then StartNoclip() end
end)
RegLang(ncT, "noclip")

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if noclipOn then StartNoclip() end
end)

local apOn = false
local apRunning = false

local function FindGun()
    for _, o in pairs(workspace:GetChildren()) do
        if IsGun(o) and o:FindFirstChild("Handle") then
            return o
        end
    end
    return nil
end

local function APLoop()
    if apRunning then return end
    apRunning = true

    task.spawn(function()
        while apOn do
            local ch = LocalPlayer.Character
            local hum = ch and ch:FindFirstChildOfClass("Humanoid")
            local hrp = ch and ch:FindFirstChild("HumanoidRootPart")

            if ch and hum and hrp and hum.Health > 0 and not HasGun(ch) then
                local g = FindGun()
                if g then
                    local h = g:FindFirstChild("Handle")
                    if h then
                        local oC = hrp.CFrame
                        local oV = hrp.AssemblyLinearVelocity

                        hrp.CFrame = h.CFrame + Vector3.new(0, 2, 0)
                        hrp.AssemblyLinearVelocity = Vector3.zero

                        task.wait(0.1)

                        for i = 1, 15 do
                            if HasGun(ch) then break end
                            pcall(function()
                                if g.Parent == workspace then
                                    g.Parent = ch
                                end
                            end)
                            task.wait(0.05)
                        end

                        task.wait(0.2)

                        if ch.Parent and ch:FindFirstChild("HumanoidRootPart") and hum.Health > 0 then
                            ch.HumanoidRootPart.CFrame = oC
                            ch.HumanoidRootPart.AssemblyLinearVelocity = oV
                        end
                    end
                end
            end
            task.wait(1)
        end
        apRunning = false
    end)
end

local apT = NewToggle(MainTab, L("autoPickup"), false, function(s)
    apOn = s
    OnSound(s)
    if s then APLoop() end
end)
RegLang(apT, "autoPickup")

local chSec = NewSection(MainTab, L("chatInfo"))
local chl = chSec:FindFirstChild("SectionLabel")
if chl then RegLang(chl, "chatInfo") end

local chBtn = NewButton(MainTab, L("chatRoles"), function()
    local msg = ""
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local r = GetRole(plr)
            if r == "Murderer" then
                msg = msg .. plr.Name .. "(murder) "
            elseif r == "Sheriff" then
                msg = msg .. plr.Name .. "(sheriff) "
            end
        end
    end

    if msg == "" then msg = "none " end
    msg = msg .. "| Bonny hub"

    local ok = Clip(msg)

    StarterGui:SetCore("SendNotification", {
        Title = "Bonny Hub",
        Text = ok and L("chatCopied") or ("Failed: " .. msg),
        Duration = 4
    })
end)
RegLang(chBtn, "chatRoles")

-- VISUAL
local vSec = NewSection(VisualTab, L("visual"))
local vl = vSec:FindFirstChild("SectionLabel")
if vl then RegLang(vl, "visual") end

local espOn = false
local espObj = {}

local espT = NewToggle(VisualTab, L("esp"), false, function(s)
    espOn = s
    OnSound(s)

    if not s then
        for _, d in pairs(espObj) do
            if d.hl and d.hl.Parent then d.hl:Destroy() end
            if d.tag and d.tag.Parent then d.tag:Destroy() end
        end
        espObj = {}
    end
end)
RegLang(espT, "esp")

local function CreateESP(plr)
    if plr == LocalPlayer or not plr.Character then return end

    local head = plr.Character:FindFirstChild("Head")
    if not head then return end

    local role = GetRole(plr)
    local oc, fc = GetColors(role)

    local isHero = false
    if role == "Innocent" and HasGun(plr.Character) then
        isHero = true
        oc = Color3.fromRGB(255, 215, 0)
        fc = Color3.fromRGB(255, 240, 150)
    end

    local hl = Instance.new("Highlight")
    hl.Name = "BonnyESP"
    hl.Adornee = plr.Character
    hl.FillColor = fc
    hl.FillTransparency = 0.7
    hl.OutlineColor = oc
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

    local lbl = Instance.new("TextLabel", tag)
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    if isHero then
        lbl.Text = plr.Name .. " [HERO]"
    else
        lbl.Text = plr.Name .. " [" .. role .. "]"
    end
    lbl.TextColor3 = fc
    lbl.TextStrokeTransparency = 0
    lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13

    espObj[plr] = {hl = hl, tag = tag, char = plr.Character}
end

local function RemoveESP(plr)
    local d = espObj[plr]
    if not d then return end

    if d.hl and d.hl.Parent then d.hl:Destroy() end
    if d.tag and d.tag.Parent then d.tag:Destroy() end

    espObj[plr] = nil
end

local function HookRespawn(plr)
    if plr == LocalPlayer then return end
    plr.CharacterAdded:Connect(function(newChar)
        RemoveESP(plr)
        if espOn then
            task.wait(0.5)
            if plr.Character and plr.Character.Parent and plr.Character:FindFirstChild("Head") then
                CreateESP(plr)
            end
        end
    end)
end

for _, plr in pairs(Players:GetPlayers()) do
    HookRespawn(plr)
end

Players.PlayerAdded:Connect(function(plr)
    HookRespawn(plr)
end)

RunService.RenderStepped:Connect(function()
    if not espOn then return end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local d = espObj[plr]

            if plr.Character and plr.Character:FindFirstChild("Head") then
                if not d
                or not d.hl
                or not d.hl.Parent
                or d.char ~= plr.Character
                or d.hl.Adornee ~= plr.Character then
                    RemoveESP(plr)
                    CreateESP(plr)
                end
            else
                RemoveESP(plr)
            end
        end
    end

    for plr, _ in pairs(espObj) do
        if not plr.Parent then
            RemoveESP(plr)
        end
    end
end)

Players.PlayerRemoving:Connect(RemoveESP)

local gEspOn = false
local gEspObj = {}

local gEspT = NewToggle(VisualTab, L("espGun"), false, function(s)
    gEspOn = s
    OnSound(s)

    if not s then
        for _, o in pairs(gEspObj) do
            if o and o.Parent then o:Destroy() end
        end
        gEspObj = {}
    end
end)
RegLang(gEspT, "espGun")

task.spawn(function()
    while true do
        if gEspOn then
            for i = #gEspObj, 1, -1 do
                local o = gEspObj[i]
                if not o or not o.Parent then
                    table.remove(gEspObj, i)
                end
            end

            for _, obj in pairs(workspace:GetChildren()) do
                if IsGun(obj) and not obj:FindFirstChild("BonnyGunESP") and obj:FindFirstChild("Handle") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "BonnyGunESP"
                    hl.Adornee = obj
                    hl.FillColor = Color3.fromRGB(255, 140, 0)
                    hl.FillTransparency = 0.4
                    hl.OutlineColor = Color3.fromRGB(255, 80, 0)
                    hl.OutlineTransparency = 0
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Parent = obj

                    table.insert(gEspObj, hl)
                end
            end
        end
        task.wait(0.5)
    end
end)

local fbT = NewToggle(VisualTab, L("fullbright"), false, function(s)
    OnSound(s)
    local l = game:GetService("Lighting")

    if s then
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
RegLang(fbT, "fullbright")

local fogT = NewToggle(VisualTab, L("removeFog"), false, function(s)
    OnSound(s)
    game:GetService("Lighting").FogEnd = s and 100000 or 1000
end)
RegLang(fogT, "removeFog")

-- AIMBOT
local aSec = NewSection(VisualTab, L("aimbot"))
local al = aSec:FindFirstChild("SectionLabel")
if al then RegLang(al, "aimbot") end

local AC = {
    enabled = false,
    throughWalls = false,
    aimPart = "Torso",
    smoothness = 0.35
}

local AW = Instance.new("Frame", VisualTab)
AW.Size = UDim2.new(1, 0, 0, 32)
AW.BackgroundColor3 = THEME.Element
AW.BackgroundTransparency = 0.15
AW.BorderSizePixel = 0

local AWC = Instance.new("UICorner", AW)
AWC.CornerRadius = UDim.new(0, 8)

local AWS = Instance.new("UIStroke", AW)
AWS.Color = THEME.Accent
AWS.Thickness = 1
AWS.Transparency = 0.85

local AL = Instance.new("TextLabel", AW)
AL.Size = UDim2.new(1, -110, 1, 0)
AL.Position = UDim2.new(0, 10, 0, 0)
AL.BackgroundTransparency = 1
AL.Text = L("aimbot")
AL.TextColor3 = THEME.Text
AL.Font = Enum.Font.GothamMedium
AL.TextSize = 12
AL.TextXAlignment = Enum.TextXAlignment.Left
RegLang(AL, "aimbot")

local SWB = Instance.new("Frame", AW)
SWB.Size = UDim2.new(0, 36, 0, 18)
SWB.Position = UDim2.new(1, -80, 0.5, -9)
SWB.BackgroundColor3 = Color3.fromRGB(60, 40, 50)
SWB.BorderSizePixel = 0

local SWBC = Instance.new("UICorner", SWB)
SWBC.CornerRadius = UDim.new(1, 0)

local Ci2 = Instance.new("Frame", SWB)
Ci2.Size = UDim2.new(0, 14, 0, 14)
Ci2.Position = UDim2.new(0, 2, 0.5, -7)
Ci2.BackgroundColor3 = THEME.Text
Ci2.BorderSizePixel = 0

local Ci2C = Instance.new("UICorner", Ci2)
Ci2C.CornerRadius = UDim.new(1, 0)

local Gear = Instance.new("TextButton", AW)
Gear.Size = UDim2.new(0, 24, 0, 24)
Gear.Position = UDim2.new(1, -38, 0.5, -12)
Gear.BackgroundColor3 = THEME.ElementHover
Gear.Text = "G"
Gear.TextColor3 = THEME.Text
Gear.TextSize = 14
Gear.Font = Enum.Font.GothamBold
Gear.BorderSizePixel = 0
Gear.AutoButtonColor = false

local GearC = Instance.new("UICorner", Gear)
GearC.CornerRadius = UDim.new(0, 6)

local SP = Instance.new("Frame", VisualTab)
SP.Size = UDim2.new(1, 0, 0, 0)
SP.BackgroundColor3 = THEME.Sidebar
SP.BackgroundTransparency = 0.3
SP.BorderSizePixel = 0
SP.ClipsDescendants = true

local SPC = Instance.new("UICorner", SP)
SPC.CornerRadius = UDim.new(0, 8)

local SPS = Instance.new("UIStroke", SP)
SPS.Color = THEME.Accent
SPS.Thickness = 1
SPS.Transparency = 0.6

local PL = Instance.new("UIListLayout", SP)
PL.Padding = UDim.new(0, 5)
PL.SortOrder = Enum.SortOrder.LayoutOrder

local PP = Instance.new("UIPadding", SP)
PP.PaddingTop = UDim.new(0, 8)
PP.PaddingLeft = UDim.new(0, 8)
PP.PaddingRight = UDim.new(0, 8)
PP.PaddingBottom = UDim.new(0, 8)

local wT = NewToggle(SP, L("aimWall"), false, function(s)
    AC.throughWalls = s
    OnSound(s)
end)
RegLang(wT, "aimWall")

local pL = Instance.new("TextLabel", SP)
pL.Size = UDim2.new(1, 0, 0, 20)
pL.BackgroundTransparency = 1
pL.Text = "  " .. L("aimPart")
pL.TextColor3 = THEME.Gold
pL.Font = Enum.Font.GothamBold
pL.TextSize = 11
pL.TextXAlignment = Enum.TextXAlignment.Left
RegLang(pL, "aimPart")

local pFrame = Instance.new("Frame", SP)
pFrame.Size = UDim2.new(1, 0, 0, 30)
pFrame.BackgroundTransparency = 1

local PBL = Instance.new("UIListLayout", pFrame)
PBL.FillDirection = Enum.FillDirection.Horizontal
PBL.Padding = UDim.new(0, 4)

local function PartBtn(name, key)
    local B = Instance.new("TextButton", pFrame)
    B.Size = UDim2.new(0.33, -3, 1, 0)
    B.BackgroundColor3 = AC.aimPart == name and THEME.Accent or THEME.Element
    B.Text = L(key)
    B.TextColor3 = THEME.Text
    B.Font = Enum.Font.GothamMedium
    B.TextSize = 11
    B.BorderSizePixel = 0
    B.AutoButtonColor = false

    local C2 = Instance.new("UICorner", B)
    C2.CornerRadius = UDim.new(0, 6)

    B.MouseButton1Click:Connect(function()
        AC.aimPart = name

        for _, c in pairs(pFrame:GetChildren()) do
            if c:IsA("TextButton") then
                TweenService:Create(c, TweenInfo.new(0.15), {
                    BackgroundColor3 = THEME.Element
                }):Play()
            end
        end

        TweenService:Create(B, TweenInfo.new(0.15), {
            BackgroundColor3 = THEME.Accent
        }):Play()
    end)
end

PartBtn("Torso", "partTorso")
PartBtn("Head", "partHead")
PartBtn("HumanoidRootPart", "partHRP")

local sL = Instance.new("TextLabel", SP)
sL.Size = UDim2.new(1, 0, 0, 20)
sL.BackgroundTransparency = 1
sL.Text = "  " .. L("aimSmooth") .. ": 0.35"
sL.TextColor3 = THEME.Gold
sL.Font = Enum.Font.GothamBold
sL.TextSize = 11
sL.TextXAlignment = Enum.TextXAlignment.Left
RegLang(sL, "aimSmooth")

local slBG = Instance.new("TextButton", SP)
slBG.Size = UDim2.new(1, 0, 0, 14)
slBG.BackgroundColor3 = THEME.Element
slBG.Text = ""
slBG.BorderSizePixel = 0
slBG.AutoButtonColor = false

local slBGC = Instance.new("UICorner", slBG)
slBGC.CornerRadius = UDim.new(1, 0)

local slF = Instance.new("Frame", slBG)
slF.Size = UDim2.new(AC.smoothness, 0, 1, 0)
slF.BackgroundColor3 = THEME.Accent
slF.BorderSizePixel = 0

local slFC = Instance.new("UICorner", slF)
slFC.CornerRadius = UDim.new(1, 0)

local slD = Instance.new("Frame", slBG)
slD.Size = UDim2.new(0, 16, 0, 16)
slD.AnchorPoint = Vector2.new(0.5, 0.5)
slD.Position = UDim2.new(AC.smoothness, 0, 0.5, 0)
slD.BackgroundColor3 = THEME.Text
slD.BorderSizePixel = 0

local slDC = Instance.new("UICorner", slD)
slDC.CornerRadius = UDim.new(1, 0)

local slDrag = false

local function UpdSl(input)
    local pos = math.clamp((input.Position.X - slBG.AbsolutePosition.X) / slBG.AbsoluteSize.X, 0, 1)
    AC.smoothness = pos
    slF.Size = UDim2.new(pos, 0, 1, 0)
    slD.Position = UDim2.new(pos, 0, 0.5, 0)
    sL.Text = "  " .. L("aimSmooth") .. ": " .. string.format("%.2f", pos)
end

slBG.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        slDrag = true
        UpdSl(i)
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if slDrag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        UpdSl(i)
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        slDrag = false
    end
end)

local sOpen = false

Gear.MouseButton1Click:Connect(function()
    sOpen = not sOpen

    if sOpen then
        SP.Visible = true
        TweenService:Create(SP, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 0, 180)
        }):Play()
        TweenService:Create(Gear, TweenInfo.new(0.3), {
            Rotation = 180
        }):Play()
    else
        TweenService:Create(SP, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(1, 0, 0, 0)
        }):Play()
        TweenService:Create(Gear, TweenInfo.new(0.3), {
            Rotation = 0
        }):Play()
    end
end)

SWB.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        AC.enabled = not AC.enabled
        OnSound(AC.enabled)

        TweenService:Create(SWB, TweenInfo.new(0.2), {
            BackgroundColor3 = AC.enabled and THEME.Success or Color3.fromRGB(60, 40, 50)
        }):Play()

        TweenService:Create(Ci2, TweenInfo.new(0.2), {
            Position = AC.enabled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        }):Play()

        TweenService:Create(AW, TweenInfo.new(0.2), {
            BackgroundColor3 = AC.enabled and THEME.Accent or THEME.Element,
            BackgroundTransparency = AC.enabled and 0.6 or 0.15
        }):Play()

        TweenService:Create(AWS, TweenInfo.new(0.2), {
            Thickness = AC.enabled and 2 or 1,
            Transparency = AC.enabled and 0 or 0.85
        }):Play()
    end
end)

local function GetMurdererChar()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if GetRole(plr) == "Murderer" then
                return plr.Character
            end
        end
    end
    return nil
end

local function GetAP(char)
    if not char then return nil end
    if AC.aimPart == "Head" then
        return char:FindFirstChild("Head")
    end
    if AC.aimPart == "Torso" then
        return char:FindFirstChild("UpperTorso")
            or char:FindFirstChild("Torso")
            or char:FindFirstChild("HumanoidRootPart")
    end
    return char:FindFirstChild("HumanoidRootPart")
end

RunService.RenderStepped:Connect(function()
    if not AC.enabled then return end

    local mc = LocalPlayer.Character
    if not mc then return end

    local mh = mc:FindFirstChild("HumanoidRootPart")
    if not mh then return end

    local t = GetMurdererChar()
    if not t then return end

    local tp = GetAP(t)
    if not tp then return end

    if not AC.throughWalls then
        local rp = RaycastParams.new()
        rp.FilterType = Enum.RaycastFilterType.Exclude
        rp.FilterDescendantsInstances = {mc, t}
        rp.IgnoreWater = true

        local r = workspace:Raycast(mh.Position, (tp.Position - mh.Position), rp)
        if r then return end
    end

    local desired = CFrame.new(mh.Position, tp.Position)
    local a = 1 - AC.smoothness
    if a < 0.05 then a = 0.05 end
    mh.CFrame = mh.CFrame:Lerp(desired, a)
end)

-- ROUND TIMER
local tSec = NewSection(VisualTab, L("roundTimer"))
local tl = tSec:FindFirstChild("SectionLabel")
if tl then RegLang(tl, "roundTimer") end

local TGui = Instance.new("ScreenGui")
TGui.Name = "BonnyTimer"
TGui.ResetOnSpawn = false
TGui.IgnoreGuiInset = true
TGui.DisplayOrder = 999

if gethui then
    TGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(TGui)
    TGui.Parent = game:GetService("CoreGui")
else
    pcall(function()
        TGui.Parent = game:GetService("CoreGui")
    end)
    if not TGui.Parent then
        TGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
end

local TFrame = Instance.new("Frame", TGui)
TFrame.Size = UDim2.new(0, 180, 0, 56)
TFrame.Position = UDim2.new(0.5, -90, 0, 20)
TFrame.BackgroundColor3 = THEME.Background
TFrame.BackgroundTransparency = 0.1
TFrame.BorderSizePixel = 0
TFrame.Visible = false
TFrame.Active = true

local TFC = Instance.new("UICorner", TFrame)
TFC.CornerRadius = UDim.new(0, 14)

local TFS2 = Instance.new("UIStroke", TFrame)
TFS2.Color = THEME.Accent
TFS2.Thickness = 2
TFS2.Transparency = 0.2

local TIcon = Instance.new("TextLabel", TFrame)
TIcon.Size = UDim2.new(0, 40, 1, 0)
TIcon.Position = UDim2.new(0, 6, 0, 0)
TIcon.BackgroundTransparency = 1
TIcon.Text = "T"
TIcon.TextColor3 = THEME.Text
TIcon.Font = Enum.Font.GothamBold
TIcon.TextSize = 24

local TText = Instance.new("TextLabel", TFrame)
TText.Size = UDim2.new(1, -50, 1, 0)
TText.Position = UDim2.new(0, 48, 0, 0)
TText.BackgroundTransparency = 1
TText.Text = "03:00"
TText.TextColor3 = THEME.Text
TText.Font = Enum.Font.GothamBold
TText.TextSize = 26
TText.TextXAlignment = Enum.TextXAlignment.Left

local TGr = Instance.new("UIGradient", TText)
TGr.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.Accent2),
    ColorSequenceKeypoint.new(1, THEME.Gold)
})

local tDragStart, tStartPos, tMoved = nil, nil, false

TFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        tDragStart = input.Position
        tStartPos = TFrame.Position
        tMoved = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if tDragStart and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - tDragStart
        if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then
            tMoved = true
        end
        if tMoved then
            TFrame.Position = UDim2.new(
                tStartPos.X.Scale, tStartPos.X.Offset + delta.X,
                tStartPos.Y.Scale, tStartPos.Y.Offset + delta.Y
            )
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        tDragStart = nil
        tStartPos = nil
        tMoved = false
    end
end)

local rtOn = false
local rtThread = nil

local function FormatT(s)
    s = math.max(0, math.floor(s))
    return string.format("%02d:%02d", math.floor(s / 60), s % 60)
end

local function FindRealRoundTime()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if not pg then return nil end

    for _, gui in pairs(pg:GetDescendants()) do
        if gui:IsA("TextLabel") and gui.Visible and gui.Text then
            local txt = gui.Text
            local m, s = txt:match("^(%d+):(%d+)$")
            if m and s then
                local total = tonumber(m) * 60 + tonumber(s)
                if total <= 300 and total >= 0 then
                    return total
                end
            end
        end
    end
    return nil
end

local function StartRoundTimer()
    if rtThread then
        task.cancel(rtThread)
    end

    local rtLeft = 180
    TText.Text = FormatT(rtLeft)

    rtThread = task.spawn(function()
        while rtOn do
            local realTime = FindRealRoundTime()
            if realTime then
                rtLeft = realTime
                TText.Text = FormatT(rtLeft)
            elseif rtLeft > 0 then
                rtLeft = rtLeft - 1
                TText.Text = FormatT(rtLeft)
            end
            task.wait(1)
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function()
    if rtOn then
        task.wait(2)
        StartRoundTimer()
    end
end)

local rtT = NewToggle(VisualTab, L("roundTimer"), false, function(s)
    rtOn = s
    OnSound(s)
    TFrame.Visible = s

    if s then
        StartRoundTimer()
    else
        if rtThread then
            task.cancel(rtThread)
            rtThread = nil
        end
    end
end)
RegLang(rtT, "roundTimer")

-- TELEPORTS
local tpSec = NewSection(TeleportsTab, L("teleports"))
local tpl = tpSec:FindFirstChild("SectionLabel")
if tpl then RegLang(tpl, "teleports") end

local SPAWN = Vector3.new(-16.2, 504.8, -27.3)

local function TPPlr(rf)
    local ch = LocalPlayer.Character
    if not ch or not ch:FindFirstChild("HumanoidRootPart") then return end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and GetRole(plr) == rf then
            ch.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            return
        end
    end

    StarterGui:SetCore("SendNotification", {
        Title = "Bonny Hub",
        Text = L("noTarget"),
        Duration = 2
    })
end

local function TPSpawn()
    local ch = LocalPlayer.Character
    if not ch or not ch:FindFirstChild("HumanoidRootPart") then return end
    ch.HumanoidRootPart.CFrame = CFrame.new(SPAWN + Vector3.new(0, 3, 0))
end

local tpM = NewButton(TeleportsTab, L("tpMurderer"), function()
    TPPlr("Murderer")
end)
RegLang(tpM, "tpMurderer")

local tpS = NewButton(TeleportsTab, L("tpSheriff"), function()
    TPPlr("Sheriff")
end)
RegLang(tpS, "tpSheriff")

local tpMp = NewButton(TeleportsTab, L("tpMap"), function()
    TPSpawn()
end)
RegLang(tpMp, "tpMap")

local tpSp = NewButton(TeleportsTab, L("tpSpawn"), function()
    TPSpawn()
end)
RegLang(tpSp, "tpSpawn")

-- TROLL
local trSec = NewSection(TrollTab, L("troll"))
local trl = trSec:FindFirstChild("SectionLabel")
if trl then RegLang(trl, "troll") end

-- Touch Fling
local tfOn = false
local tfConns = {}
local tfDeb = {}

local function FlingChar(tc)
    if not tc or not tc.Parent then return end

    local hrp = tc:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local now = tick()
    if tfDeb[tc] and now - tfDeb[tc] < 0.5 then return end
    tfDeb[tc] = now

    for _, c in pairs(hrp:GetChildren()) do
        if c.Name == "BonnyFling" then
            c:Destroy()
        end
    end

    local bv = Instance.new("BodyVelocity")
    bv.Name = "BonnyFling"
    bv.Velocity = Vector3.new(math.random(-300, 300), 500, math.random(-300, 300))
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.P = 5000
    bv.Parent = hrp

    game:GetService("Debris"):AddItem(bv, 0.4)
end

local function SetupTF()
    for _, c in pairs(tfConns) do
        c:Disconnect()
    end
    tfConns = {}

    local ch = LocalPlayer.Character
    if not ch then return end

    for _, part in pairs(ch:GetDescendants()) do
        if part:IsA("BasePart") then
            local conn = part.Touched:Connect(function(hit)
                if not tfOn then return end

                local oc = hit:FindFirstAncestorOfClass("Model")
                if not oc or oc == ch then return end

                local op = Players:GetPlayerFromCharacter(oc)
                if not op or op == LocalPlayer then return end

                FlingChar(oc)
            end)

            table.insert(tfConns, conn)
        end
    end
end

local tfT = NewToggle(TrollTab, L("touchFling"), false, function(s)
    tfOn = s
    OnSound(s)

    if s then
        SetupTF()
    else
        for _, c in pairs(tfConns) do
            c:Disconnect()
        end
        tfConns = {}
    end
end)
RegLang(tfT, "touchFling")

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if tfOn then
        SetupTF()
    end
end)

-- SKULL TEXTURE
local skullOn = false
local skullTextures = {}

local SKULL_IMAGE = "rbxassetid://10653372160"
local SKULL_TEXTURE = "rbxassetid://10653372143"

local function ApplySkull()
    local ch = LocalPlayer.Character
    if not ch then return end

    for _, part in pairs(ch:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            skullTextures[part] = {
                texture = part.TextureID or "",
                color = part.Color or Color3.new(1,1,1)
            }

            pcall(function()
                part.TextureID = SKULL_TEXTURE
            end)

            part.Color = Color3.fromRGB(255, 255, 255)
        end
    end

    local head = ch:FindFirstChild("Head")
    if head and not head:FindFirstChild("BonnySkullDecal") then
        local dec = Instance.new("Decal")
        dec.Name = "BonnySkullDecal"
        dec.Face = Enum.NormalId.Front
        dec.Texture = SKULL_IMAGE
        dec.Parent = head
    end
end

local function RemoveSkull()
    local ch = LocalPlayer.Character
    if not ch then return end

    for part, data in pairs(skullTextures) do
        if part and part.Parent then
            pcall(function()
                part.TextureID = data.texture
            end)
            pcall(function()
                part.Color = data.color
            end)
        end
    end

    skullTextures = {}

    local head = ch:FindFirstChild("Head")
    if head then
        local dec = head:FindFirstChild("BonnySkullDecal")
        if dec then dec:Destroy() end
    end
end

local skT = NewToggle(TrollTab, L("skullTexture"), false, function(s)
    skullOn = s
    OnSound(s)

    if s then
        ApplySkull()
    else
        RemoveSkull()
    end
end)
RegLang(skT, "skullTexture")

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if skullOn then
        ApplySkull()
    end
end)

-- SETTINGS
local setSec = NewSection(SettingsTab, L("settings"))
local sl2 = setSec:FindFirstChild("SectionLabel")
if sl2 then RegLang(sl2, "settings") end

local lgL = Instance.new("TextLabel", SettingsTab)
lgL.Size = UDim2.new(1, 0, 0, 26)
lgL.BackgroundTransparency = 1
lgL.Text = "  " .. L("language")
lgL.TextColor3 = THEME.Gold
lgL.Font = Enum.Font.GothamBold
lgL.TextSize = 12
lgL.TextXAlignment = Enum.TextXAlignment.Left
RegLang(lgL, "language")

NewButton(SettingsTab, "English", function()
    Lang.current = "en"
    ApplyLang()
end)

NewButton(SettingsTab, "Russian", function()
    Lang.current = "ru"
    ApplyLang()
end)

local clL = Instance.new("TextLabel", SettingsTab)
clL.Size = UDim2.new(1, 0, 0, 26)
clL.BackgroundTransparency = 1
clL.Text = "  " .. L("clickSound")
clL.TextColor3 = THEME.Gold
clL.Font = Enum.Font.GothamBold
clL.TextSize = 12
clL.TextXAlignment = Enum.TextXAlignment.Left
RegLang(clL, "clickSound")

local clBtns = {}

local function UpdClBtns()
    for i, b in pairs(clBtns) do
        TweenService:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = (i == SoundConfig.click) and THEME.Accent or THEME.Element
        }):Play()
    end
end

local function ClBtn(text, index)
    local B = NewButton(SettingsTab, text, function()
        SoundConfig.click = index
        if index ~= 0 then
            PlayClick()
        end
        UpdClBtns()
    end)
    clBtns[index] = B
    if SoundConfig.click == index then
        B.BackgroundColor3 = THEME.Accent
    end
end

ClBtn("1. " .. L("noSound"), 0)
ClBtn("2. " .. L("c1"), 1)
ClBtn("3. " .. L("c2"), 2)
ClBtn("4. " .. L("c3"), 3)

local dsL = Instance.new("TextLabel", SettingsTab)
dsL.Size = UDim2.new(1, 0, 0, 26)
dsL.BackgroundTransparency = 1
dsL.Text = "  " .. L("disSound")
dsL.TextColor3 = THEME.Gold
dsL.Font = Enum.Font.GothamBold
dsL.TextSize = 12
dsL.TextXAlignment = Enum.TextXAlignment.Left
RegLang(dsL, "disSound")

local dsBtns = {}

local function UpdDsBtns()
    for i, b in pairs(dsBtns) do
        TweenService:Create(b, TweenInfo.new(0.15), {
            BackgroundColor3 = (i == SoundConfig.disable) and THEME.Accent or THEME.Element
        }):Play()
    end
end

local function DsBtn(text, index)
    local B = NewButton(SettingsTab, text, function()
        SoundConfig.disable = index
        if index == 1 then
            PlayDisable()
        end
        UpdDsBtns()
    end)
    dsBtns[index] = B
    if SoundConfig.disable == index then
        B.BackgroundColor3 = THEME.Accent
    end
end

DsBtn("1. " .. L("noSound") .. " (default)", 0)
DsBtn("2. " .. L("disSound"), 1)

-- LAUNCH
for _, b in pairs(TabsBtns) do
    b.MouseButton1Click:Fire()
    break
end

StarterGui:SetCore("SendNotification", {
    Title = "Bonny Hub",
    Text = L("loaded"),
    Duration = 3
})

print("[Bonny Hub] Loaded successfully!")
