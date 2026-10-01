--[[
    ✨ BONNY HUB PREMIUM ✨
    PART 1a: Base GUI
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

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 540, 0, 400)
MainFrame.Position = UDim2.new(0.5, -270, 0.5, -200)
MainFrame.BackgroundColor3 = THEME.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0, 16) MainCorner.Parent = MainFrame

local BG = Instance.new("UIGradient")
BG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.Background3),
    ColorSequenceKeypoint.new(0.5, THEME.Background),
    ColorSequenceKeypoint.new(1, THEME.Background2)
})
BG.Rotation = 135
BG.Parent = MainFrame

local OuterGlow = Instance.new("UIStroke")
OuterGlow.Color = THEME.Accent
OuterGlow.Thickness = 2
OuterGlow.Transparency = 0.2
OuterGlow.Parent = MainFrame

local ShadowFrame = Instance.new("Frame")
ShadowFrame.Size = UDim2.new(1, 20, 1, 20)
ShadowFrame.Position = UDim2.new(0, -10, 0, -10)
ShadowFrame.BackgroundColor3 = THEME.Shadow
ShadowFrame.BackgroundTransparency = 0.7
ShadowFrame.BorderSizePixel = 0
ShadowFrame.ZIndex = -1
ShadowFrame.Parent = MainFrame
local ShadowCorner = Instance.new("UICorner") ShadowCorner.CornerRadius = UDim.new(0, 20) ShadowCorner.Parent = ShadowFrame

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 46)
TitleBar.BackgroundColor3 = THEME.Sidebar
TitleBar.BackgroundTransparency = 0.2
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
local TitleCorner = Instance.new("UICorner") TitleCorner.CornerRadius = UDim.new(0, 16) TitleCorner.Parent = TitleBar

local TBottom = Instance.new("Frame")
TBottom.Size = UDim2.new(1, 0, 0, 16)
TBottom.Position = UDim2.new(0, 0, 1, -16)
TBottom.BackgroundColor3 = THEME.Sidebar
TBottom.BackgroundTransparency = 0.2
TBottom.BorderSizePixel = 0
TBottom.Parent = TitleBar

local LogoFrame = Instance.new("Frame")
LogoFrame.Size = UDim2.new(0, 32, 0, 32)
LogoFrame.Position = UDim2.new(0, 14, 0.5, -16)
LogoFrame.BackgroundColor3 = THEME.Accent
LogoFrame.BorderSizePixel = 0
LogoFrame.Parent = TitleBar
local LogoCorner = Instance.new("UICorner") LogoCorner.CornerRadius = UDim.new(0, 9) LogoCorner.Parent = LogoFrame

local LogoGrad = Instance.new("UIGradient")
LogoGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.Accent),
    ColorSequenceKeypoint.new(0.5, THEME.Purple),
    ColorSequenceKeypoint.new(1, THEME.Gold)
})
LogoGrad.Rotation = 45
LogoGrad.Parent = LogoFrame

local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = THEME.Accent2
LogoStroke.Thickness = 1
LogoStroke.Transparency = 0.3
LogoStroke.Parent = LogoFrame

local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(1, 0, 1, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "★"
Logo.TextColor3 = THEME.Text
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 19
Logo.Parent = LogoFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -200, 0, 22)
Title.Position = UDim2.new(0, 56, 0, 6)
Title.BackgroundTransparency = 1
Title.Text = "BONNY HUB"
Title.TextColor3 = THEME.Text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local TitleGrad = Instance.new("UIGradient")
TitleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, THEME.Text),
    ColorSequenceKeypoint.new(1, THEME.Accent2)
})
TitleGrad.Parent = Title

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -200, 0, 14)
SubTitle.Position = UDim2.new(0, 56, 0, 26)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "PREMIUM EDITION"
SubTitle.TextColor3 = THEME.TextDim
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 9
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = TitleBar

-- Кнопки управления
local function CreateTitleBtn(symbol, xOffset, color, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 28, 0, 28)
    Btn.Position = UDim2.new(1, xOffset, 0.5, -14)
    Btn.BackgroundColor3 = THEME.Element
    Btn.BackgroundTransparency = 0.4
    Btn.Text = symbol
    Btn.TextColor3 = color
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 16
    Btn.BorderSizePixel = 0
    Btn.AutoButtonColor = false
    Btn.Parent = TitleBar
    local C = Instance.new("UICorner") C.CornerRadius = UDim.new(0, 8) C.Parent = Btn
    Btn.MouseEnter:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play() end)
    Btn.MouseLeave:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.4}):Play() end)
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local miniButton

CreateTitleBtn("−", -74, THEME.TextDim, function()
    MainFrame.Visible = false
    if miniButton then miniButton:Destroy() end

    local Mini = Instance.new("TextButton")
    Mini.Name = "MiniBtn"
    Mini.Size = UDim2.new(0, 60, 0, 60)
    Mini.Position = UDim2.new(0, 100, 0.5, -30)
    Mini.BackgroundColor3 = THEME.Background
    Mini.Text = "★"
    Mini.TextColor3 = THEME.Text
    Mini.TextScaled = true
    Mini.Font = Enum.Font.GothamBold
    Mini.BorderSizePixel = 0
    Mini.Active = true
    Mini.Parent = ScreenGui

    local MC = Instance.new("UICorner") MC.CornerRadius = UDim.new(0, 14) MC.Parent = Mini
    local MG = Instance.new("UIGradient")
    MG.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, THEME.Accent),
        ColorSequenceKeypoint.new(1, THEME.Purple)
    })
    MG.Rotation = 45
    MG.Parent = Mini
    local MS = Instance.new("UIStroke") MS.Color = THEME.Accent2 MS.Thickness = 2 MS.Parent = Mini

    task.spawn(function()
        while Mini.Parent do
            TweenService:Create(MS, TweenInfo.new(1), {Transparency = 0.5}):Play()
            task.wait(1)
            if not Mini.Parent then break end
            TweenService:Create(MS, TweenInfo.new(1), {Transparency = 0}):Play()
            task.wait(1)
        end
    end)

    local dragging, dragStart, startPos = false, nil, nil
    Mini.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = Mini.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            Mini.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    Mini.MouseButton1Click:Connect(function()
        if not dragging then
            MainFrame.Visible = true
            Mini:Destroy()
            miniButton = nil
        end
    end)
    miniButton = Mini
end)

CreateTitleBtn("×", -42, Color3.fromRGB(255, 80, 80), function()
    ScreenGui:Destroy()
    _G.BonnyHubLoaded = false
end)

-- Профиль внизу
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(1, -24, 0, 50)
ProfileFrame.Position = UDim2.new(0, 12, 1, -58)
ProfileFrame.BackgroundColor3 = THEME.Element
ProfileFrame.BackgroundTransparency = 0.3
ProfileFrame.BorderSizePixel = 0
ProfileFrame.Parent = MainFrame
local ProfileCorner = Instance.new("UICorner") ProfileCorner.CornerRadius = UDim.new(0, 10) ProfileCorner.Parent = ProfileFrame
local ProfileStroke = Instance.new("UIStroke") ProfileStroke.Color = THEME.Accent ProfileStroke.Thickness = 1 ProfileStroke.Transparency = 0.6 ProfileStroke.Parent = ProfileFrame

local AvatarFrame = Instance.new("Frame")
AvatarFrame.Size = UDim2.new(0, 38, 0, 38)
AvatarFrame.Position = UDim2.new(0, 6, 0.5, -19)
AvatarFrame.BackgroundColor3 = THEME.Accent
AvatarFrame.BorderSizePixel = 0
AvatarFrame.Parent = ProfileFrame
local AFC = Instance.new("UICorner") AFC.CornerRadius = UDim.new(1, 0) AFC.Parent = AvatarFrame

local AvatarImg = Instance.new("ImageLabel")
AvatarImg.Size = UDim2.new(1, -4, 1, -4)
AvatarImg.Position = UDim2.new(0, 2, 0, 2)
AvatarImg.BackgroundTransparency = 1
AvatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
AvatarImg.Parent = AvatarFrame
local AvatarCorner = Instance.new("UICorner") AvatarCorner.CornerRadius = UDim.new(1, 0) AvatarCorner.Parent = AvatarImg

local NameLabel = Instance.new("TextLabel")
NameLabel.Size = UDim2.new(1, -80, 0, 16)
NameLabel.Position = UDim2.new(0, 52, 0, 8)
NameLabel.BackgroundTransparency = 1
NameLabel.Text = LocalPlayer.DisplayName
NameLabel.TextColor3 = THEME.Text
NameLabel.Font = Enum.Font.GothamBold
NameLabel.TextSize = 12
NameLabel.TextXAlignment = Enum.TextXAlignment.Left
NameLabel.Parent = ProfileFrame

local UserLabel = Instance.new("TextLabel")
UserLabel.Size = UDim2.new(1, -80, 0, 14)
UserLabel.Position = UDim2.new(0, 52, 0, 24)
UserLabel.BackgroundTransparency = 1
UserLabel.Text = "@" .. LocalPlayer.Name
UserLabel.TextColor3 = THEME.TextDim
UserLabel.Font = Enum.Font.Gotham
UserLabel.TextSize = 10
UserLabel.TextXAlignment = Enum.TextXAlignment.Left
UserLabel.Parent = ProfileFrame

local OnlineDot = Instance.new("Frame")
OnlineDot.Size = UDim2.new(0, 10, 0, 10)
OnlineDot.Position = UDim2.new(1, -18, 0.5, -5)
OnlineDot.BackgroundColor3 = THEME.Success
OnlineDot.BorderSizePixel = 0
OnlineDot.Parent = ProfileFrame
local ODC = Instance.new("UICorner") ODC.CornerRadius = UDim.new(1, 0) ODC.Parent = OnlineDot
local ODStroke = Instance.new("UIStroke") ODStroke.Color = THEME.Success ODStroke.Thickness = 2 ODStroke.Transparency = 0.4 ODStroke.Parent = OnlineDot

task.spawn(function()
    while OnlineDot.Parent do
        TweenService:Create(ODStroke, TweenInfo.new(1), {Transparency = 0.8, Thickness = 4}):Play()
        task.wait(1)
        if not OnlineDot.Parent then break end
        TweenService:Create(ODStroke, TweenInfo.new(1), {Transparency = 0.4, Thickness = 2}):Play()
        task.wait(1)
    end
end)

-- Экспорт
_G.BonnyHub = {
    ScreenGui = ScreenGui, MainFrame = MainFrame,
    THEME = THEME, LocalPlayer = LocalPlayer, Players = Players,
    RunService = RunService, StarterGui = StarterGui, TweenService = TweenService,
    UserInputService = UserInputService
}

print("[Bonny Hub] Part 1a loaded (Base GUI)")
--[[
    ✨ BONNY HUB PREMIUM ✨
    PART 1b: Sidebar + Tabs + Elements
--]]

local H = _G.BonnyHub
if not H then warn("[Bonny Hub] Run PART 1a first!") return end

local THEME        = H.THEME
local TweenService = H.TweenService
local MainFrame    = H.MainFrame

-- Сайдбар
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 155, 1, -110)
Sidebar.Position = UDim2.new(0, 12, 0, 54)
Sidebar.BackgroundColor3 = THEME.Sidebar
Sidebar.BackgroundTransparency = 0.15
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame
local SidebarCorner = Instance.new("UICorner") SidebarCorner.CornerRadius = UDim.new(0, 12) SidebarCorner.Parent = Sidebar
local SidebarStroke = Instance.new("UIStroke") SidebarStroke.Color = THEME.Accent SidebarStroke.Thickness = 1 SidebarStroke.Transparency = 0.6 SidebarStroke.Parent = Sidebar

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(1, -20, 0, 26)
VersionLabel.Position = UDim2.new(0, 10, 0, 10)
VersionLabel.BackgroundColor3 = THEME.Element
VersionLabel.BackgroundTransparency = 0.2
VersionLabel.Text = "⚡ BONNY"
VersionLabel.TextColor3 = THEME.Gold
VersionLabel.Font = Enum.Font.GothamBold
VersionLabel.TextSize = 11
VersionLabel.BorderSizePixel = 0
VersionLabel.Parent = Sidebar
local VLC = Instance.new("UICorner") VLC.CornerRadius = UDim.new(0, 7) VLC.Parent = VersionLabel
local VLS = Instance.new("UIStroke") VLS.Color = THEME.Gold VLS.Thickness = 1 VLS.Transparency = 0.7 VLS.Parent = VersionLabel

local TabListFrame = Instance.new("Frame")
TabListFrame.Size = UDim2.new(1, -20, 1, -50)
TabListFrame.Position = UDim2.new(0, 10, 0, 44)
TabListFrame.BackgroundTransparency = 1
TabListFrame.Parent = Sidebar
local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 6)
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Parent = TabListFrame

-- Контент
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -185, 1, -110)
Content.Position = UDim2.new(0, 175, 0, 54)
Content.BackgroundColor3 = THEME.Sidebar
Content.BackgroundTransparency = 0.15
Content.BorderSizePixel = 0
Content.Parent = MainFrame
local ContentCorner = Instance.new("UICorner") ContentCorner.CornerRadius = UDim.new(0, 12) ContentCorner.Parent = Content
local ContentStroke = Instance.new("UIStroke") ContentStroke.Color = THEME.Accent ContentStroke.Thickness = 1 ContentStroke.Transparency = 0.6 ContentStroke.Parent = Content

-- ============ ВКЛАДКИ ============
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
    local BtnCorner = Instance.new("UICorner") BtnCorner.CornerRadius = UDim.new(0, 8) BtnCorner.Parent = TabBtn

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

-- ============ ЭЛЕМЕНТЫ ============
local function CreateSection(parent, text)
    local Wrap = Instance.new("Frame")
    Wrap.Size = UDim2.new(1, 0, 0, 26)
    Wrap.BackgroundTransparency = 1
    Wrap.Parent = parent

    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, 0, 0, 1)
    Line.Position = UDim2.new(0, 0, 0.5, 0)
    Line.BackgroundColor3 = THEME.Accent
    Line.BackgroundTransparency = 0.5
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

-- Создаём вкладки
local MainTab      = CreateTab("Main", "🏠")
local VisualTab    = CreateTab("Visual", "👁")
local TeleportsTab = CreateTab("Teleports", "📍")
local TrollTab     = CreateTab("Troll", "☠")
local SettingsTab  = CreateTab("Settings", "⚙")

-- Экспорт в _G
H.MainTab       = MainTab
H.VisualTab     = VisualTab
H.TeleportsTab  = TeleportsTab
H.TrollTab      = TrollTab
H.SettingsTab   = SettingsTab
H.TabButtons    = TabButtons
H.CreateSection = CreateSection
H.CreateButton  = CreateButton
H.CreateToggle  = CreateToggle

print("[Bonny Hub] Part 1b loaded (Tabs + Elements)")
--[[
    ✨ BONNY HUB PREMIUM ✨
    PART 2a: System + Main
--]]

local H = _G.BonnyHub
if not H then warn("[Bonny Hub] Run PART 1a+1b first!") return end

local LocalPlayer   = H.LocalPlayer
local Players       = H.Players
local RunService    = H.RunService
local StarterGui    = H.StarterGui
local TweenService  = H.TweenService
local MainTab       = H.MainTab
local CreateSection = H.CreateSection
local CreateButton  = H.CreateButton
local CreateToggle  = H.CreateToggle
local THEME         = H.THEME

-- ============ LANGUAGE ============
local Lang = {
    current = "en",
    strings = {
        en = {
            mainFeatures="Main Features", noclip="Noclip", autoPickupGun="Auto Pickup Gun",
            chatInfo="Chat Info", chatRoles="Copy Roles to Clipboard",
            chatCopied="Copied! Paste in chat (Ctrl+V)",
            visualFeatures="Visual Features", esp="ESP Players", espGun="ESP Guns (Orange)",
            fullbright="Fullbright", removeFog="Remove Fog", roundTimer="Round Timer",
            aimbot="Aimbot Murderer",
            aimWall="Aim Through Walls", aimPart="Aim Part", aimSmooth="Smoothness",
            partTorso="Torso", partHead="Head", partHRP="HRP",
            teleports="Teleports", tpMurderer="Teleport to Murderer",
            tpSheriff="Teleport to Sheriff", tpMap="Teleport to Map", tpSpawn="Teleport to Spawn",
            trollFeatures="Troll Features", touchFling="Touch Fling",
            settings="Settings", language="Language", clickSound="Click Sound",
            noSound="No Sound", clientSound="Client", client2="Client 2", client3="Client 3",
            disableSound="Disable Sound",
            loaded="Loaded successfully!", roundEnded="Round ended", roundTime="Time left",
            noTarget="Target not found"
        },
        ru = {
            mainFeatures="Основные функции", noclip="Noclip", autoPickupGun="Авто-подбор пистолета",
            chatInfo="Информация в чат", chatRoles="Скопировать роли в буфер",
            chatCopied="Скопировано! Вставь в чат (Ctrl+V)",
            visualFeatures="Визуальные функции", esp="ESP игроков", espGun="ESP пистолета (оранжевый)",
            fullbright="Полная яркость", removeFog="Убрать туман", roundTimer="Таймер раунда",
            aimbot="Аим на мардера",
            aimWall="Наводиться через стены", aimPart="Часть тела", aimSmooth="Плавность",
            partTorso="Туловище", partHead="Голова", partHRP="HRP",
            teleports="Телепорты", tpMurderer="ТП к мардеру",
            tpSheriff="ТП к шерифу", tpMap="ТП на карту", tpSpawn="ТП на спавн",
            trollFeatures="Тролль функции", touchFling="Тач-флинг",
            settings="Настройки", language="Язык", clickSound="Звук клика",
            noSound="Без звука", clientSound="Client", client2="Client 2", client3="Client 3",
            disableSound="Звук выключения",
            loaded="Успешно загружено!", roundEnded="Раунд закончен", roundTime="Осталось",
            noTarget="Цель не найдена"
        }
    }
}
local function L(key) return Lang.strings[Lang.current][key] or key end
H.Lang = Lang
H.L = L
H.LangRefs = {}
H.RegisterLang = function(ref, key, prefix)
    table.insert(H.LangRefs, {ref=ref, key=key, prefix=prefix or ""})
end
local RegisterLang = H.RegisterLang

H.ApplyLang = function()
    for _, e in ipairs(H.LangRefs) do
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

-- ============ SOUND SYSTEM ============
H.SoundConfig = {
    clickSound = 0,
    disableSound = 0
}

local SOUND_IDS = {
    [0] = nil,
    [1] = "rbxassetid://87437544236708",
    [2] = "rbxassetid://140207837688369",
    [3] = "rbxassetid://139421450430380"
}
local DISABLE_SOUND_IDS = {
    [0] = nil,
    [1] = "rbxassetid://73954763982661"
}

local soundCache = {}
local SoundService = game:GetService("SoundService")

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
for _, id in pairs(DISABLE_SOUND_IDS) do if id then PreloadSound(id) end end

function H.PlayClickSound()
    local id = SOUND_IDS[H.SoundConfig.clickSound]
    if not id then return end
    local s = soundCache[id]
    if s then s.TimePosition = 0; s:Play() else PreloadSound(id):Play() end
end

function H.PlayDisableSound()
    local id = DISABLE_SOUND_IDS[H.SoundConfig.disableSound]
    if not id then return end
    local s = soundCache[id]
    if s then s.TimePosition = 0; s:Play() else PreloadSound(id):Play() end
end

function H.OnToggleSound(state)
    if state then
        H.PlayClickSound()
    else
        if H.SoundConfig.disableSound > 0 then H.PlayDisableSound()
        else H.PlayClickSound() end
    end
end

-- ============ HELPERS ============
local function IsGun(tool)
    if not tool or not tool:IsA("Tool") then return false end
    local n = tool.Name:lower()
    return n:find("gun") or n:find("revolver") or n:find("pistol") or n:find("firearm")
end
local function IsKnife(tool)
    if not tool or not tool:IsA("Tool") then return false end
    local n = tool.Name:lower()
    return n:find("knife") or n:find("sword") or n:find("m9") or n:find("dagger") or n:find("blade")
end
local function HasGunInChar(char)
    if not char then return false end
    for _, item in pairs(char:GetChildren()) do
        if IsGun(item) then return true end
    end
    return false
end
H.IsGun = IsGun
H.IsKnife = IsKnife
H.HasGunInChar = HasGunInChar

-- ============ ROLE DETECTION ============
local function GetRole(plr)
    if plr == LocalPlayer then return "LocalPlayer" end
    local char = plr.Character
    if not char then return "Innocent" end
    local backpack = plr:FindFirstChildOfClass("Backpack")
    local charBP = char:FindFirstChildOfClass("Backpack")
    local hasGun, hasKnife = false, false
    local function scan(c)
        for _, item in pairs(c:GetChildren()) do
            if IsGun(item) then hasGun = true end
            if IsKnife(item) then hasKnife = true end
        end
    end
    scan(char)
    if backpack then scan(backpack) end
    if charBP then scan(charBP) end
    if hasGun then return "Sheriff" end
    if hasKnife then return "Murderer" end
    return "Innocent"
end
local function GetRoleColors(role)
    if role == "Murderer" then return Color3.fromRGB(255,0,0), Color3.fromRGB(255,130,130)
    elseif role == "Sheriff" then return Color3.fromRGB(0,100,255), Color3.fromRGB(120,180,255)
    elseif role == "Innocent" then return Color3.fromRGB(0,200,50), Color3.fromRGB(130,255,160)
    end
    return Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255)
end
H.GetRole = GetRole
H.GetRoleColors = GetRoleColors

-- ============ CLIPBOARD ============
local function CopyToClipboard(text)
    if setclipboard then return pcall(setclipboard, text) end
    if toclipboard then return pcall(toclipboard, text) end
    if syn and syn.setclipboard then return pcall(syn.setclipboard, text) end
    if writeclipboard then return pcall(writeclipboard, text) end
    return false
end
H.CopyToClipboard = CopyToClipboard

-- ============ MAIN TAB ============
local mainSec = CreateSection(MainTab, L("mainFeatures"))
local mainSecL = mainSec:FindFirstChild("SectionLabel")
if mainSecL then RegisterLang(mainSecL, "mainFeatures") end

-- Noclip
local noclipEnabled = false
local noclipConn
local function startNoclip()
    if noclipConn then noclipConn:Disconnect() end
    noclipConn = RunService.Stepped:Connect(function()
        if not noclipEnabled then return end
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
            end
        end
    end)
end
local noclipToggle = CreateToggle(MainTab, "👻  " .. L("noclip"), false, function(state)
    noclipEnabled = state
    H.OnToggleSound(state)
    if state then startNoclip() end
end)
RegisterLang(noclipToggle, "noclip", "👻  ")
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if noclipEnabled then startNoclip() end
end)

-- Auto Pickup Gun
local autoPickupEnabled = false
local autoPickupRunning = false
local function FindGroundGun()
    for _, obj in pairs(workspace:GetChildren()) do
        if IsGun(obj) and obj:FindFirstChild("Handle") then return obj end
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
                        local origCFrame = hrp.CFrame
                        local origVel = hrp.AssemblyLinearVelocity
                        hrp.CFrame = handle.CFrame + Vector3.new(0, 2, 0)
                        hrp.AssemblyLinearVelocity = Vector3.zero
                        task.wait(0.1)
                        for i = 1, 15 do
                            if HasGunInChar(char) then break end
                            pcall(function()
                                if gun.Parent == workspace then gun.Parent = char end
                            end)
                            task.wait(0.05)
                        end
                        task.wait(0.2)
                        if char.Parent and char:FindFirstChild("HumanoidRootPart") and hum.Health > 0 then
                            char.HumanoidRootPart.CFrame = origCFrame
                            char.HumanoidRootPart.AssemblyLinearVelocity = origVel
                        end
                    end
                end
            end
            task.wait(1)
        end
        autoPickupRunning = false
    end)
end
local autoPickupToggle = CreateToggle(MainTab, "🔫  " .. L("autoPickupGun"), false, function(state)
    autoPickupEnabled = state
    H.OnToggleSound(state)
    if state then AutoPickupLoop() end
end)
RegisterLang(autoPickupToggle, "autoPickupGun", "🔫  ")

-- Chat Info
local chatSec = CreateSection(MainTab, L("chatInfo"))
local chatSecL = chatSec:FindFirstChild("SectionLabel")
if chatSecL then RegisterLang(chatSecL, "chatInfo") end

local chatBtn = CreateButton(MainTab, "💬  " .. L("chatRoles"), function()
    H.PlayClickSound()
    local msg = ""
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local role = GetRole(plr)
            if role == "Murderer" then msg = msg .. plr.Name .. "(murder) "
            elseif role == "Sheriff" then msg = msg .. plr.Name .. "(sheriff) " end
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

print("[Bonny Hub] Part 2a loaded (System + Main)")
local H = _G.BonnyHub
if not H or not H.GetRole then warn("[Bonny Hub] Run 1a+1b+2a first!") return end

local LocalPlayer      = H.LocalPlayer
local Players          = H.Players
local RunService       = H.RunService
local TweenService     = H.TweenService
local UserInputService = H.UserInputService
local VisualTab        = H.VisualTab
local CreateSection    = H.CreateSection
local CreateToggle     = H.CreateToggle
local GetRole          = H.GetRole
local GetRoleColors    = H.GetRoleColors
local IsGun            = H.IsGun
local Lang             = H.Lang
local L                = H.L
local RegisterLang     = H.RegisterLang
local THEME            = H.THEME

-- VISUAL
local visSec = CreateSection(VisualTab, L("visualFeatures"))
local vl = visSec:FindFirstChild("SectionLabel")
if vl then RegisterLang(vl, "visualFeatures") end

local espEnabled, espObjects = false, {}
local espToggle = CreateToggle(VisualTab, "👁️  " .. L("esp"), false, function(state)
    espEnabled = state; H.OnToggleSound(state)
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
    if role == "Innocent" and H.HasGunInChar(plr.Character) then
        isHero = true
        oc = Color3.fromRGB(255,215,0); fc = Color3.fromRGB(255,240,150)
    end
    local hl = Instance.new("Highlight")
    hl.Name = "BonnyESP"; hl.Adornee = plr.Character
    hl.FillColor = fc; hl.FillTransparency = 0.7
    hl.OutlineColor = oc; hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = plr.Character
    local tag = Instance.new("BillboardGui")
    tag.Name = "BonnyTag"; tag.Adornee = head
    tag.Size = UDim2.new(0,220,0,30); tag.StudsOffset = Vector3.new(0,2.8,0)
    tag.AlwaysOnTop = true; tag.Parent = head
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,0,1,0); lbl.BackgroundTransparency = 1
    lbl.Text = isHero and (plr.Name .. " [HERO]") or (plr.Name .. " [" .. role .. "]")
    lbl.TextColor3 = fc; lbl.TextStrokeTransparency = 0
    lbl.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 13
    lbl.Parent = tag
    espObjects[plr] = {highlight = hl, tag = tag}
end
local function removeESP(plr)
    local d = espObjects[plr]; if not d then return end
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
    espGunEnabled = state; H.OnToggleSound(state)
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
                    hl.FillColor = Color3.fromRGB(255,140,0); hl.FillTransparency = 0.4
                    hl.OutlineColor = Color3.fromRGB(255,80,0); hl.OutlineTransparency = 0
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
    H.OnToggleSound(state)
    local l = game:GetService("Lighting")
    if state then
        l.Ambient = Color3.fromRGB(255,255,255); l.Brightness = 2
        l.FogEnd = 100000; l.GlobalShadows = false
    else
        l.Ambient = Color3.fromRGB(70,70,70); l.Brightness = 1
        l.FogEnd = 1000; l.GlobalShadows = true
    end
end)
RegisterLang(fbToggle, "fullbright", "💡  ")

local fogToggle = CreateToggle(VisualTab, "🌫️  " .. L("removeFog"), false, function(state)
    H.OnToggleSound(state)
    game:GetService("Lighting").FogEnd = state and 100000 or 1000
end)
RegisterLang(fogToggle, "removeFog", "🌫️  ")

-- AIMBOT
local aimSec = CreateSection(VisualTab, L("aimbot"))
local al = aimSec:FindFirstChild("SectionLabel")
if al then RegisterLang(al, "aimbot") end

H.AimbotConfig = { enabled = false, throughWalls = false, aimPart = "Torso", smoothness = 0.35 }

local AimbotWrap = Instance.new("Frame")
AimbotWrap.Size = UDim2.new(1,0,0,32)
AimbotWrap.BackgroundColor3 = THEME.Element
AimbotWrap.BackgroundTransparency = 0.15
AimbotWrap.BorderSizePixel = 0
AimbotWrap.Parent = VisualTab
local AWCC = Instance.new("UICorner") AWCC.CornerRadius = UDim.new(0,8) AWCC.Parent = AimbotWrap
local AWCS = Instance.new("UIStroke") AWCS.Color = THEME.Accent AWCS.Thickness = 1 AWCS.Transparency = 0.85 AWCS.Parent = AimbotWrap

local AimbotLabel = Instance.new("TextLabel")
AimbotLabel.Size = UDim2.new(1,-110,1,0); AimbotLabel.Position = UDim2.new(0,10,0,0)
AimbotLabel.BackgroundTransparency = 1; AimbotLabel.Text = L("aimbot")
AimbotLabel.TextColor3 = THEME.Text; AimbotLabel.Font = Enum.Font.GothamMedium
AimbotLabel.TextSize = 12; AimbotLabel.TextXAlignment = Enum.TextXAlignment.Left
AimbotLabel.Parent = AimbotWrap
RegisterLang(AimbotLabel, "aimbot")

local aimState = false
local SwitchBG = Instance.new("Frame")
SwitchBG.Size = UDim2.new(0,36,0,18); SwitchBG.Position = UDim2.new(1,-80,0.5,-9)
SwitchBG.BackgroundColor3 = Color3.fromRGB(60,40,50); SwitchBG.BorderSizePixel = 0
SwitchBG.Parent = AimbotWrap
local SBGC = Instance.new("UICorner") SBGC.CornerRadius = UDim.new(1,0) SBGC.Parent = SwitchBG
local Circle = Instance.new("Frame")
Circle.Size = UDim2.new(0,14,0,14); Circle.Position = UDim2.new(0,2,0.5,-7)
Circle.BackgroundColor3 = THEME.Text; Circle.BorderSizePixel = 0
Circle.Parent = SwitchBG
local CC = Instance.new("UICorner") CC.CornerRadius = UDim.new(1,0) CC.Parent = Circle

local GearBtn = Instance.new("TextButton")
GearBtn.Size = UDim2.new(0,24,0,24); GearBtn.Position = UDim2.new(1,-38,0.5,-12)
GearBtn.BackgroundColor3 = THEME.ElementHover; GearBtn.Text = "⚙"
GearBtn.TextColor3 = THEME.Text; GearBtn.TextSize = 14
GearBtn.Font = Enum.Font.GothamBold; GearBtn.BorderSizePixel = 0
GearBtn.AutoButtonColor = false; GearBtn.Parent = AimbotWrap
local GBC = Instance.new("UICorner") GBC.CornerRadius = UDim.new(0,6) GBC.Parent = GearBtn

local SettingsPanel = Instance.new("Frame")
SettingsPanel.Size = UDim2.new(1,0,0,0)
SettingsPanel.BackgroundColor3 = THEME.Sidebar
SettingsPanel.BackgroundTransparency = 0.3
SettingsPanel.BorderSizePixel = 0
SettingsPanel.ClipsDescendants = true
SettingsPanel.Parent = VisualTab
local SPC = Instance.new("UICorner") SPC.CornerRadius = UDim.new(0,8) SPC.Parent = SettingsPanel
local SPS = Instance.new("UIStroke") SPS.Color = THEME.Accent SPS.Thickness = 1 SPS.Transparency = 0.6 SPS.Parent = SettingsPanel
local PanelList = Instance.new("UIListLayout") PanelList.Padding = UDim.new(0,5) PanelList.SortOrder = Enum.SortOrder.LayoutOrder PanelList.Parent = SettingsPanel
local PanelPad = Instance.new("UIPadding")
PanelPad.PaddingTop = UDim.new(0,8); PanelPad.PaddingLeft = UDim.new(0,8)
PanelPad.PaddingRight = UDim.new(0,8); PanelPad.PaddingBottom = UDim.new(0,8)
PanelPad.Parent = SettingsPanel

local wallToggle = CreateToggle(SettingsPanel, "🚪  " .. L("aimWall"), false, function(state)
    H.AimbotConfig.throughWalls = state; H.OnToggleSound(state)
end)
RegisterLang(wallToggle, "aimWall", "🚪  ")

local partLabel = Instance.new("TextLabel")
partLabel.Size = UDim2.new(1,0,0,20); partLabel.BackgroundTransparency = 1
partLabel.Text = "  🎯  " .. L("aimPart"); partLabel.TextColor3 = THEME.Gold
partLabel.Font = Enum.Font.GothamBold; partLabel.TextSize = 11
partLabel.TextXAlignment = Enum.TextXAlignment.Left
partLabel.Parent = SettingsPanel
RegisterLang(partLabel, "aimPart", "🎯  ")

local partButtonsFrame = Instance.new("Frame")
partButtonsFrame.Size = UDim2.new(1,0,0,30); partButtonsFrame.BackgroundTransparency = 1
partButtonsFrame.Parent = SettingsPanel
local PBL = Instance.new("UIListLayout") PBL.FillDirection = Enum.FillDirection.Horizontal PBL.Padding = UDim.new(0,4) PBL.Parent = partButtonsFrame

local function CreatePartBtn(name, key)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.33,-3,1,0)
    Btn.BackgroundColor3 = H.AimbotConfig.aimPart == name and THEME.Accent or THEME.Element
    Btn.Text = L(key); Btn.TextColor3 = THEME.Text
    Btn.Font = Enum.Font.GothamMedium; Btn.TextSize = 11
    Btn.BorderSizePixel = 0; Btn.AutoButtonColor = false
    Btn.Parent = partButtonsFrame
    local C = Instance.new("UICorner") C.CornerRadius = UDim.new(0,6) C.Parent = Btn
    Btn.MouseButton1Click:Connect(function()
        H.AimbotConfig.aimPart = name; H.PlayClickSound()
        for _, child in pairs(partButtonsFrame:GetChildren()) do
            if child:IsA("TextButton") then
                TweenService:Create(child, TweenInfo.new(0.15), {BackgroundColor3 = THEME.Element}):Play()
            end
        end
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = THEME.Accent}):Play()
    end)
end
CreatePartBtn("Torso", "partTorso")
CreatePartBtn("Head", "partHead")
CreatePartBtn("HumanoidRootPart", "partHRP")

local smoothLabel = Instance.new("TextLabel")
smoothLabel.Size = UDim2.new(1,0,0,20); smoothLabel.BackgroundTransparency = 1
smoothLabel.Text = "  🎚️  " .. L("aimSmooth") .. ": 0.35"
smoothLabel.TextColor3 = THEME.Gold; smoothLabel.Font = Enum.Font.GothamBold
smoothLabel.TextSize = 11; smoothLabel.TextXAlignment = Enum.TextXAlignment.Left
smoothLabel.Parent = SettingsPanel
RegisterLang(smoothLabel, "aimSmooth", "🎚️  ")

local sliderBG = Instance.new("TextButton")
sliderBG.Size = UDim2.new(1,0,0,14); sliderBG.BackgroundColor3 = THEME.Element
sliderBG.Text = ""; sliderBG.BorderSizePixel = 0; sliderBG.AutoButtonColor = false
sliderBG.Parent = SettingsPanel
local SLBC = Instance.new("UICorner") SLBC.CornerRadius = UDim.new(1,0) SLBC.Parent = sliderBG
local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(H.AimbotConfig.smoothness,0,1,0)
sliderFill.BackgroundColor3 = THEME.Accent; sliderFill.BorderSizePixel = 0
sliderFill.Parent = sliderBG
local SLFC = Instance.new("UICorner") SLFC.CornerRadius = UDim.new(1,0) SLFC.Parent = sliderFill
local sliderDot = Instance.new("Frame")
sliderDot.Size = UDim2.new(0,16,0,16); sliderDot.AnchorPoint = Vector2.new(0.5,0.5)
sliderDot.Position = UDim2.new(H.AimbotConfig.smoothness,0,0.5,0)
sliderDot.BackgroundColor3 = THEME.Text; sliderDot.BorderSizePixel = 0
sliderDot.Parent = sliderBG
local SLDC = Instance.new("UICorner") SLDC.CornerRadius = UDim.new(1,0) SLDC.Parent = sliderDot

local sliderDragging = false
local function UpdateSlider(input)
    local pos = math.clamp((input.Position.X - sliderBG.AbsolutePosition.X) / sliderBG.AbsoluteSize.X, 0, 1)
    H.AimbotConfig.smoothness = pos
    sliderFill.Size = UDim2.new(pos,0,1,0)
    sliderDot.Position = UDim2.new(pos,0,0.5,0)
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
    panelOpen = not panelOpen; H.PlayClickSound()
    if panelOpen then
        SettingsPanel.Visible = true
        TweenService:Create(SettingsPanel, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(1,0,0,180)
        }):Play()
        TweenService:Create(GearBtn, TweenInfo.new(0.3), {Rotation = 180}):Play()
    else
        TweenService:Create(SettingsPanel, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Size = UDim2.new(1,0,0,0)
        }):Play()
        TweenService:Create(GearBtn, TweenInfo.new(0.3), {Rotation = 0}):Play()
    end
end)

SwitchBG.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        aimState = not aimState
        H.AimbotConfig.enabled = aimState
        H.OnToggleSound(aimState)
        TweenService:Create(SwitchBG, TweenInfo.new(0.2), {
            BackgroundColor3 = aimState and THEME.Success or Color3.fromRGB(60,40,50)
        }):Play()
        TweenService:Create(Circle, TweenInfo.new(0.2), {
            Position = aimState and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7)
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
    local part = H.AimbotConfig.aimPart
    if part == "Head" then return char:FindFirstChild("Head") end
    if part == "Torso" then
        return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
    end
    return char:FindFirstChild("HumanoidRootPart")
end

RunService.RenderStepped:Connect(function()
    if not H.AimbotConfig.enabled then return end
    local myChar = LocalPlayer.Character
    if not myChar then return end
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end
    local target = getMurdererChar()
    if not target then return end
    local tp = getAimPart(target)
    if not tp then return end
    if not H.AimbotConfig.throughWalls then
        local rp = RaycastParams.new()
        rp.FilterType = Enum.RaycastFilterType.Exclude
        rp.FilterDescendantsInstances = {myChar, target}
        local result = workspace:Raycast(myHRP.Position, (tp.Position - myHRP.Position), rp)
        if result then return end
    end
    local desired = CFrame.new(myHRP.Position, tp.Position)
    local alpha = 1 - H.AimbotConfig.smoothness
    if alpha < 0.05 then alpha = 0.05 end
    myHRP.CFrame = myHRP.CFrame:Lerp(desired, alpha)
end)

-- ROUND TIMER
local timerSec = CreateSection(VisualTab, L("roundTimer"))
local tl = timerSec:FindFirstChild("SectionLabel")
if tl then RegisterLang(tl, "roundTimer") end

local TimerGui = Instance.new("ScreenGui")
TimerGui.Name = "BonnyTimer"; TimerGui.ResetOnSpawn = false
TimerGui.IgnoreGuiInset = true; TimerGui.DisplayOrder = 999
if gethui then TimerGui.Parent = gethui()
elseif syn and syn.protect_gui then syn.protect_gui(TimerGui); TimerGui.Parent = game:GetService("CoreGui")
else pcall(function() TimerGui.Parent = game:GetService("CoreGui") end)
    if not TimerGui.Parent then TimerGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end end

local TimerFrame = Instance.new("Frame")
TimerFrame.Size = UDim2.new(0,180,0,56); TimerFrame.Position = UDim2.new(0.5,-90,0,20)
TimerFrame.BackgroundColor3 = THEME.Background; TimerFrame.BackgroundTransparency = 0.1
TimerFrame.BorderSizePixel = 0; TimerFrame.Visible = false
TimerFrame.Parent = TimerGui
local TFC = Instance.new("UICorner") TFC.CornerRadius = UDim.new(0,14) TFC.Parent = TimerFrame
local TFS = Instance.new("UIStroke") TFS.Color = THEME.Accent TFS.Thickness = 2 TFS.Transparency = 0.2 TFS.Parent = TimerFrame
local TimerIcon = Instance.new("TextLabel")
TimerIcon.Size = UDim2.new(0,40,1,0); TimerIcon.Position = UDim2.new(0,6,0,0)
TimerIcon.BackgroundTransparency = 1; TimerIcon.Text = "⏱️"
TimerIcon.TextColor3 = THEME.Text; TimerIcon.Font = Enum.Font.GothamBold
TimerIcon.TextSize = 24; TimerIcon.Parent = TimerFrame
local TimerText = Instance.new("TextLabel")
TimerText.Size = UDim2.new(1,-50,1,0); TimerText.Position = UDim2.new(0,48,0,0)
TimerText.BackgroundTransparency = 1; TimerText.Text = "03:00"
TimerText.TextColor3 = THEME.Text; TimerText.Font = Enum.Font.GothamBold
TimerText.TextSize = 26; TimerText.TextXAlignment = Enum.TextXAlignment.Left
TimerText.Parent = TimerFrame
local TimerGrad = Instance.new("UIGradient")
TimerGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,THEME.Accent2),ColorSequenceKeypoint.new(1,THEME.Gold)})
TimerGrad.Parent = TimerText

local roundTimerEnabled, roundTimeLeft, timerThread = false, 180, nil
local function FormatTime(sec)
    sec = math.max(0, math.floor(sec))
    return string.format("%02d:%02d", math.floor(sec/60), sec%60)
end
local function UpdateTimer() TimerText.Text = FormatTime(roundTimeLeft) end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(2)
    if roundTimerEnabled then roundTimeLeft = 180; UpdateTimer() end
end)

local timerToggle = CreateToggle(VisualTab, "⏱️  " .. L("roundTimer"), false, function(state)
    roundTimerEnabled = state; H.OnToggleSound(state)
    TimerFrame.Visible = state
    if state then
        roundTimeLeft = 180; UpdateTimer()
        if timerThread then task.cancel(timerThread) end
        timerThread = task.spawn(function()
            while roundTimerEnabled do
                task.wait(1)
                if roundTimeLeft > 0 then roundTimeLeft = roundTimeLeft - 1; UpdateTimer() end
            end
        end)
    else
        if timerThread then task.cancel(timerThread); timerThread = nil end
    end
end)
RegisterLang(timerToggle, "roundTimer", "⏱️  ")

print("[Bonny Hub] Part 2b loaded")
local H = _G.BonnyHub
if not H or not H.GetRole then warn("[Bonny Hub] Run previous parts!") return end

local LocalPlayer    = H.LocalPlayer
local Players        = H.Players
local StarterGui     = H.StarterGui
local TweenService   = H.TweenService
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
local THEME          = H.THEME

-- TELEPORTS
local tpSec = CreateSection(TeleportsTab, L("teleports"))
local tl = tpSec:FindFirstChild("SectionLabel")
if tl then RegisterLang(tl, "teleports") end

local SPAWN_POS = Vector3.new(-16.2, 504.8, -27.3)

local function TPToPlayer(roleFilter)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if GetRole(plr) == roleFilter then
                char.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                return
            end
        end
    end
    StarterGui:SetCore("SendNotification", {Title = "Bonny Hub", Text = L("noTarget"), Duration = 2})
end
local function TpToSpawn()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    char.HumanoidRootPart.CFrame = CFrame.new(SPAWN_POS + Vector3.new(0,3,0))
end

local tpM = CreateButton(TeleportsTab, "🔴  " .. L("tpMurderer"), function()
    H.PlayClickSound(); TPToPlayer("Murderer")
end)
RegisterLang(tpM, "tpMurderer", "🔴  ")
local tpS = CreateButton(TeleportsTab, "🔵  " .. L("tpSheriff"), function()
    H.PlayClickSound(); TPToPlayer("Sheriff")
end)
RegisterLang(tpS, "tpSheriff", "🔵  ")
local tpMp = CreateButton(TeleportsTab, "🗺️  " .. L("tpMap"), function()
    H.PlayClickSound(); TpToSpawn()
end)
RegisterLang(tpMp, "tpMap", "🗺️  ")
local tpSp = CreateButton(TeleportsTab, "🏠  " .. L("tpSpawn"), function()
    H.PlayClickSound(); TpToSpawn()
end)
RegisterLang(tpSp, "tpSpawn", "🏠  ")

-- TROLL
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
    bv.Velocity = Vector3.new(math.random(-300,300), 500, math.random(-300,300))
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.P = 5000; bv.Parent = hrp
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
    touchFlingEnabled = state; H.OnToggleSound(state)
    if state then setupTouchFling()
    else
        for _, c in pairs(touchFlingConnections) do c:Disconnect() end
        touchFlingConnections = {}
    end
end)
RegisterLang(tfToggle, "touchFling", "✋  ")
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1); if touchFlingEnabled then setupTouchFling() end
end)

-- SETTINGS
local setSec = CreateSection(SettingsTab, L("settings"))
local sl = setSec:FindFirstChild("SectionLabel")
if sl then RegisterLang(sl, "settings") end

local langLabel = Instance.new("TextLabel")
langLabel.Size = UDim2.new(1,0,0,26); langLabel.BackgroundTransparency = 1
langLabel.Text = "  🌐  " .. L("language"); langLabel.TextColor3 = THEME.Gold
langLabel.Font = Enum.Font.GothamBold; langLabel.TextSize = 12
langLabel.TextXAlignment = Enum.TextXAlignment.Left
langLabel.Parent = SettingsTab
RegisterLang(langLabel, "language", "🌐  ")

CreateButton(SettingsTab, "🇬🇧  English", function()
    H.PlayClickSound(); Lang.current = "en"; ApplyLang()
end)
CreateButton(SettingsTab, "🇷🇺  Русский", function()
    H.PlayClickSound(); Lang.current = "ru"; ApplyLang()
end)

local clickLabel = Instance.new("TextLabel")
clickLabel.Size = UDim2.new(1,0,0,26); clickLabel.BackgroundTransparency = 1
clickLabel.Text = "  🔊  " .. L("clickSound"); clickLabel.TextColor3 = THEME.Gold
clickLabel.Font = Enum.Font.GothamBold; clickLabel.TextSize = 12
clickLabel.TextXAlignment = Enum.TextXAlignment.Left
clickLabel.Parent = SettingsTab
RegisterLang(clickLabel, "clickSound", "🔊  ")

local clickBtns = {}
local function UpdateClickBtns()
    for i, btn in pairs(clickBtns) do
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = i == H.SoundConfig.clickSound and THEME.Accent or THEME.Element
        }):Play()
    end
end
local function CreateSoundBtn(text, index)
    local Btn = CreateButton(SettingsTab, text, function()
        H.SoundConfig.clickSound = index
        if index ~= 0 then H.PlayClickSound() end
        UpdateClickBtns()
    end)
    clickBtns[index] = Btn
    if H.SoundConfig.clickSound == index then Btn.BackgroundColor3 = THEME.Accent end
end
CreateSoundBtn("1. " .. L("noSound"), 0)
CreateSoundBtn("2. " .. L("clientSound"), 1)
CreateSoundBtn("3. " .. L("client2"), 2)
CreateSoundBtn("4. " .. L("client3"), 3)

local disLabel = Instance.new("TextLabel")
disLabel.Size = UDim2.new(1,0,0,26); disLabel.BackgroundTransparency = 1
disLabel.Text = "  🔕  " .. L("disableSound"); disLabel.TextColor3 = THEME.Gold
disLabel.Font = Enum.Font.GothamBold; disLabel.TextSize = 12
disLabel.TextXAlignment = Enum.TextXAlignment.Left
disLabel.Parent = SettingsTab
RegisterLang(disLabel, "disableSound", "🔕  ")

local disBtns = {}
local function UpdateDisBtns()
    for i, btn in pairs(disBtns) do
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = i == H.SoundConfig.disableSound and THEME.Accent or THEME.Element
        }):Play()
    end
end
local function CreateDisBtn(text, index)
    local Btn = CreateButton(SettingsTab, text, function()
        H.SoundConfig.disableSound = index
        if index == 1 then H.PlayDisableSound() end
        UpdateDisBtns()
    end)
    disBtns[index] = Btn
    if H.SoundConfig.disableSound == index then Btn.BackgroundColor3 = THEME.Accent end
end
CreateDisBtn("1. " .. L("noSound") .. " (default)", 0)
CreateDisBtn("2. " .. L("disableSound"), 1)

for _, btn in pairs(TabButtons) do
    btn.MouseButton1Click:Fire()
    break
end

StarterGui:SetCore("SendNotification", {
    Title = "★ Bonny Hub",
    Text = L("loaded"),
    Duration = 3
})

print("[Bonny Hub] Part 2c loaded ✨")
print("[Bonny Hub] All parts loaded!")
local H = _G.BonnyHub
if not H or not H.GetRole then warn("[Bonny Hub] Run previous parts!") return end

local LocalPlayer    = H.LocalPlayer
local Players        = H.Players
local StarterGui     = H.StarterGui
local TeleportsTab   = H.TeleportsTab
local TrollTab       = H.TrollTab
local CreateSection  = H.CreateSection
local CreateButton   = H.CreateButton
local CreateToggle   = H.CreateToggle
local GetRole        = H.GetRole
local L              = H.L
local RegisterLang   = H.RegisterLang
local THEME          = H.THEME

-- ============ TELEPORTS ============
local tpSec = CreateSection(TeleportsTab, L("teleports"))
local tl = tpSec:FindFirstChild("SectionLabel")
if tl then RegisterLang(tl, "teleports") end

local SPAWN_POS = Vector3.new(-16.2, 504.8, -27.3)

local function TPToPlayer(roleFilter)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            if GetRole(plr) == roleFilter then
                char.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
                return
            end
        end
    end
    StarterGui:SetCore("SendNotification", {Title = "Bonny Hub", Text = L("noTarget"), Duration = 2})
end
local function TpToSpawn()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    char.HumanoidRootPart.CFrame = CFrame.new(SPAWN_POS + Vector3.new(0,3,0))
end

local tpM = CreateButton(TeleportsTab, "🔴  " .. L("tpMurderer"), function()
    H.PlayClickSound(); TPToPlayer("Murderer")
end)
RegisterLang(tpM, "tpMurderer", "🔴  ")

local tpS = CreateButton(TeleportsTab, "🔵  " .. L("tpSheriff"), function()
    H.PlayClickSound(); TPToPlayer("Sheriff")
end)
RegisterLang(tpS, "tpSheriff", "🔵  ")

local tpMp = CreateButton(TeleportsTab, "🗺️  " .. L("tpMap"), function()
    H.PlayClickSound(); TpToSpawn()
end)
RegisterLang(tpMp, "tpMap", "🗺️  ")

local tpSp = CreateButton(TeleportsTab, "🏠  " .. L("tpSpawn"), function()
    H.PlayClickSound(); TpToSpawn()
end)
RegisterLang(tpSp, "tpSpawn", "🏠  ")

-- ============ TROLL ============
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
    bv.Velocity = Vector3.new(math.random(-300,300), 500, math.random(-300,300))
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
    H.OnToggleSound(state)
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

print("[Bonny Hub] Part 3a loaded (Teleports + Troll)")
local H = _G.BonnyHub
if not H or not H.GetRole then warn("[Bonny Hub] Run previous parts!") return end

local StarterGui   = H.StarterGui
local TweenService = H.TweenService
local SettingsTab  = H.SettingsTab
local TabButtons   = H.TabButtons
local CreateSection = H.CreateSection
local CreateButton  = H.CreateButton
local Lang          = H.Lang
local L             = H.L
local RegisterLang  = H.RegisterLang
local ApplyLang     = H.ApplyLang
local THEME         = H.THEME

-- ============ SETTINGS ============
local setSec = CreateSection(SettingsTab, L("settings"))
local sl = setSec:FindFirstChild("SectionLabel")
if sl then RegisterLang(sl, "settings") end

-- Language
local langLabel = Instance.new("TextLabel")
langLabel.Size = UDim2.new(1,0,0,26)
langLabel.BackgroundTransparency = 1
langLabel.Text = "  🌐  " .. L("language")
langLabel.TextColor3 = THEME.Gold
langLabel.Font = Enum.Font.GothamBold
langLabel.TextSize = 12
langLabel.TextXAlignment = Enum.TextXAlignment.Left
langLabel.Parent = SettingsTab
RegisterLang(langLabel, "language", "🌐  ")

CreateButton(SettingsTab, "🇬🇧  English", function()
    H.PlayClickSound()
    Lang.current = "en"
    ApplyLang()
end)

CreateButton(SettingsTab, "🇷🇺  Русский", function()
    H.PlayClickSound()
    Lang.current = "ru"
    ApplyLang()
end)

-- Click Sound
local clickLabel = Instance.new("TextLabel")
clickLabel.Size = UDim2.new(1,0,0,26)
clickLabel.BackgroundTransparency = 1
clickLabel.Text = "  🔊  " .. L("clickSound")
clickLabel.TextColor3 = THEME.Gold
clickLabel.Font = Enum.Font.GothamBold
clickLabel.TextSize = 12
clickLabel.TextXAlignment = Enum.TextXAlignment.Left
clickLabel.Parent = SettingsTab
RegisterLang(clickLabel, "clickSound", "🔊  ")

local clickBtns = {}
local function UpdateClickBtns()
    for i, btn in pairs(clickBtns) do
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = i == H.SoundConfig.clickSound and THEME.Accent or THEME.Element
        }):Play()
    end
end

local function CreateSoundBtn(text, index)
    local Btn = CreateButton(SettingsTab, text, function()
        H.SoundConfig.clickSound = index
        if index ~= 0 then H.PlayClickSound() end
        UpdateClickBtns()
    end)
    clickBtns[index] = Btn
    if H.SoundConfig.clickSound == index then Btn.BackgroundColor3 = THEME.Accent end
end

CreateSoundBtn("1. " .. L("noSound"), 0)
CreateSoundBtn("2. " .. L("clientSound"), 1)
CreateSoundBtn("3. " .. L("client2"), 2)
CreateSoundBtn("4. " .. L("client3"), 3)

-- Disable Sound
local disLabel = Instance.new("TextLabel")
disLabel.Size = UDim2.new(1,0,0,26)
disLabel.BackgroundTransparency = 1
disLabel.Text = "  🔕  " .. L("disableSound")
disLabel.TextColor3 = THEME.Gold
disLabel.Font = Enum.Font.GothamBold
disLabel.TextSize = 12
disLabel.TextXAlignment = Enum.TextXAlignment.Left
disLabel.Parent = SettingsTab
RegisterLang(disLabel, "disableSound", "🔕  ")

local disBtns = {}
local function UpdateDisBtns()
    for i, btn in pairs(disBtns) do
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = i == H.SoundConfig.disableSound and THEME.Accent or THEME.Element
        }):Play()
    end
end

local function CreateDisBtn(text, index)
    local Btn = CreateButton(SettingsTab, text, function()
        H.SoundConfig.disableSound = index
        if index == 1 then H.PlayDisableSound() end
        UpdateDisBtns()
    end)
    disBtns[index] = Btn
    if H.SoundConfig.disableSound == index then Btn.BackgroundColor3 = THEME.Accent end
end

CreateDisBtn("1. " .. L("noSound") .. " (default)", 0)
CreateDisBtn("2. " .. L("disableSound"), 1)

-- ============ АКТИВАЦИЯ ПЕРВОЙ ВКЛАДКИ ============
for _, btn in pairs(TabButtons) do
    btn.MouseButton1Click:Fire()
    break
end

StarterGui:SetCore("SendNotification", {
    Title = "★ Bonny Hub",
    Text = L("loaded"),
    Duration = 3
})

print("[Bonny Hub] Part 3b loaded ✨")
print("[Bonny Hub] ===== ALL PARTS LOADED =====")
--[[
    ✨ BONNY HUB PREMIUM ✨
    PART 4: Settings + Launch
--]]

local H = _G.BonnyHub
if not H then warn("[Bonny Hub] Run PART 1 first!") return end
if not H.GetRole then warn("[Bonny Hub] Run PART 2 first!") return end

local StarterGui    = H.StarterGui
local TweenService  = H.TweenService
local SettingsTab   = H.SettingsTab
local TabButtons    = H.TabButtons
local CreateSection = H.CreateSection
local CreateButton  = H.CreateButton
local Lang          = H.Lang
local L             = H.L
local RegisterLang  = H.RegisterLang
local ApplyLang     = H.ApplyLang
local THEME         = H.THEME

-- ============ SETTINGS SECTION ============
local setSec = CreateSection(SettingsTab, L("settings"))
local sl = setSec:FindFirstChild("SectionLabel")
if sl then RegisterLang(sl, "settings") end

-- Language
local langLabel = Instance.new("TextLabel")
langLabel.Size = UDim2.new(1, 0, 0, 26)
langLabel.BackgroundTransparency = 1
langLabel.Text = "  🌐  " .. L("language")
langLabel.TextColor3 = THEME.Gold
langLabel.Font = Enum.Font.GothamBold
langLabel.TextSize = 12
langLabel.TextXAlignment = Enum.TextXAlignment.Left
langLabel.Parent = SettingsTab
RegisterLang(langLabel, "language", "🌐  ")

CreateButton(SettingsTab, "🇬🇧  English", function()
    H.PlayClickSound()
    Lang.current = "en"
    ApplyLang()
end)

CreateButton(SettingsTab, "🇷🇺  Русский", function()
    H.PlayClickSound()
    Lang.current = "ru"
    ApplyLang()
end)

-- Click Sound
local clickLabel = Instance.new("TextLabel")
clickLabel.Size = UDim2.new(1, 0, 0, 26)
clickLabel.BackgroundTransparency = 1
clickLabel.Text = "  🔊  " .. L("clickSound")
clickLabel.TextColor3 = THEME.Gold
clickLabel.Font = Enum.Font.GothamBold
clickLabel.TextSize = 12
clickLabel.TextXAlignment = Enum.TextXAlignment.Left
clickLabel.Parent = SettingsTab
RegisterLang(clickLabel, "clickSound", "🔊  ")

local clickBtns = {}
local function UpdateClickBtns()
    for i, btn in pairs(clickBtns) do
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = (i == H.SoundConfig.clickSound) and THEME.Accent or THEME.Element
        }):Play()
    end
end

local function CreateSoundBtn(text, index)
    local Btn = CreateButton(SettingsTab, text, function()
        H.SoundConfig.clickSound = index
        if index ~= 0 then H.PlayClickSound() end
        UpdateClickBtns()
    end)
    clickBtns[index] = Btn
    if H.SoundConfig.clickSound == index then
        Btn.BackgroundColor3 = THEME.Accent
    end
end

CreateSoundBtn("1. " .. L("noSound"), 0)
CreateSoundBtn("2. " .. L("clientSound"), 1)
CreateSoundBtn("3. " .. L("client2"), 2)
CreateSoundBtn("4. " .. L("client3"), 3)

-- Disable Sound
local disLabel = Instance.new("TextLabel")
disLabel.Size = UDim2.new(1, 0, 0, 26)
disLabel.BackgroundTransparency = 1
disLabel.Text = "  🔕  " .. L("disableSound")
disLabel.TextColor3 = THEME.Gold
disLabel.Font = Enum.Font.GothamBold
disLabel.TextSize = 12
disLabel.TextXAlignment = Enum.TextXAlignment.Left
disLabel.Parent = SettingsTab
RegisterLang(disLabel, "disableSound", "🔕  ")

local disBtns = {}
local function UpdateDisBtns()
    for i, btn in pairs(disBtns) do
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = (i == H.SoundConfig.disableSound) and THEME.Accent or THEME.Element
        }):Play()
    end
end

local function CreateDisBtn(text, index)
    local Btn = CreateButton(SettingsTab, text, function()
        H.SoundConfig.disableSound = index
        if index == 1 then H.PlayDisableSound() end
        UpdateDisBtns()
    end)
    disBtns[index] = Btn
    if H.SoundConfig.disableSound == index then
        Btn.BackgroundColor3 = THEME.Accent
    end
end

CreateDisBtn("1. " .. L("noSound") .. " (default)", 0)
CreateDisBtn("2. " .. L("disableSound"), 1)

-- ============ АКТИВАЦИЯ ПЕРВОЙ ВКЛАДКИ ============
for _, btn in pairs(TabButtons) do
    btn.MouseButton1Click:Fire()
    break
end

-- ============ УВЕДОМЛЕНИЕ О ЗАГРУЗКЕ ============
StarterGui:SetCore("SendNotification", {
    Title = "★ Bonny Hub",
    Text = L("loaded"),
    Duration = 3
})

print("[Bonny Hub] Part 4/4 loaded ✨")
print("[Bonny Hub] ===== ALL PARTS LOADED SUCCESSFULLY =====")
