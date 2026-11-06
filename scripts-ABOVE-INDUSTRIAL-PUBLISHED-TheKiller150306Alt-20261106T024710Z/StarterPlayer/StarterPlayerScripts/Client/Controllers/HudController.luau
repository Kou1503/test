-- Script path: game:GetService("StarterPlayer").StarterPlayerScripts.Client.Controllers.HudController
-- Decompile time: 14.53 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local AudioController = require(script.Parent.AudioController)
local Format = require(Shared.Format)
local u44 = require(script.Parent.Parent.Ui)
local SettingsController = require(script.Parent.SettingsController)
local TimeController = require(script.Parent.TimeController)
local NewPlayerView = require(script.Parent.NewPlayerView)
local u60 = {}
local LocalPlayer = Players.LocalPlayer
local u65 = Remotes.get(Remotes.BlockCountChanged)
local u68 = Remotes.get(Remotes.CoinsChanged)
local u71 = Remotes.get(Remotes.Alert)
local u74 = Remotes.get(Remotes.FriendLuckChanged)
local TouchEnabled = UserInputService.TouchEnabled

if TouchEnabled then
    TouchEnabled = not UserInputService.KeyboardEnabled
end

local u78 = nil
local u84 = Color3.fromRGB(110, 215, 120)
local u89 = Color3.fromRGB(220, 70, 70)
local u90 = nil
local u91 = nil
local u92 = nil
local u93 = nil
local u94 = 0
local u95 = 0
local u96 = 0

local function coinText(a1) -- Line: 61; upvalues: Format (val), u96 (ref); types: a1: number
    return Format.comma((math.floor(a1 + u96)))
end

local u99 = nil
local u100 = nil
local u101 = nil
local u102 = {}
local u103 = 0
local u104 = 100
local u105 = nil

local function weatherState() -- Line: 81; upvalues: ReplicatedStorage (val), Config (val), NewPlayerView (val)
    local Attribute_2 = ReplicatedStorage:GetAttribute(Config.Weather.Attribute)

    if type(Attribute_2) == "string" and Config.Weather.States[Attribute_2] then
        return NewPlayerView.weather(Attribute_2)
    end

    return Config.Weather.Default
end

local function label(a1, a2, a3, a4)
    -- Line: 90
    -- upvalues: u44 (val)
    -- types: a1: userdata, a2: userdata, a3: userdata, a4: number
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = a2
    TextLabel.Position = a3
    TextLabel.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
    TextLabel.BackgroundTransparency = 0.3
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.FontFace = u44.Font.Regular
    TextLabel.TextSize = a4
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = ""
    TextLabel.Parent = a1
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = TextLabel
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.Parent = TextLabel

    return TextLabel
end

local function statRow(a1, a2, a3, a4)
    -- Line: 121
    -- upvalues: u78 (ref), u44 (val)
    -- types: a1: number, a2: string, a3: userdata, a4: string?
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromOffset(0, 24)
    Frame.AutomaticSize = Enum.AutomaticSize.X
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = a1
    Frame.Parent = u78

    u44.chip(Frame, a2, a3, 20, UDim2.fromOffset(0, 2), a4)

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.fromOffset(0, 24)
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.Position = UDim2.fromOffset(26, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = u44.Palette.Text
    TextLabel.FontFace = u44.Font.Bold
    TextLabel.TextSize = 14
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = ""
    TextLabel.Parent = Frame

    ;(TextLabel:GetPropertyChangedSignal("Visible")):Connect(function()
        -- Line: 145
        -- upvalues: Frame (val), TextLabel (val)
        Frame.Visible = TextLabel.Visible
    end)

    return TextLabel
end

local u113 = {}
u113.Gain = Color3.fromRGB(130, 225, 150)
u113.Announce = Color3.fromRGB(255, 214, 110)
u113.Partner = Color3.fromRGB(170, 200, 235)
local u133 = Color3.fromRGB(255, 150, 150)
local u134 = {Announce = 8, Partner = 4}

function u60.showAlert(a1, a2)
    -- Line: 171
    -- upvalues: u105 (ref), u113 (val), u133 (val), u134 (val)
    -- types: a1: string, a2: string?
    u105.Text = a1
    u105.TextColor3 = a2 and u113[a2] or u133
    u105.TextTransparency = 0

    task.delay(
        a2 and u134[a2] or 2.5,
        function() -- Line: 175; upvalues: u105 (upval), a1 (val)
            if u105.Text == a1 then
                u105.TextTransparency = 1
            end
        end
    )
end

local u137 = 1
local u138 = u84
local u139 = 0
local u140 = 0

local function setHealth(a1, a2)
    -- Line: 191
    -- upvalues: u104 (ref), u140 (ref), Config (val), u137 (ref), u103 (ref), u138 (ref), u89 (val), u84 (val)
    -- upvalues: u101 (ref), u100 (ref)
    -- types: a1: number, a2: number
    local v1 = if not (a2 > 0) then 0 else math.clamp(a1 / a2, 0, 1)

    if a1 < u104 and a1 > 0 then
        u140 = Config.Appearance.HitFlash.Alpha
    end

    u137 = v1
    u104 = a1
    local LowHealthVignette = Config.Appearance.LowHealthVignette
    u103 = if not (a1 < LowHealthVignette.BelowHp) or not (a1 > 0) then
        0
    else
        LowHealthVignette.MinAlpha
            + (1 - a1 / LowHealthVignette.BelowHp)
                * (LowHealthVignette.MaxAlpha - LowHealthVignette.MinAlpha)
    u138 = u89:Lerp(u84, v1)
    u101.Size = UDim2.fromScale(v1, 1)
    u101.BackgroundColor3 = u138
    u100.Text = ("%* / %*"):format(math.ceil(a1), (math.floor(a2)))
end

local function paintVignette(a1) -- Line: 217; upvalues: u102 (val); types: a1: number
    local v1
    local v2 = nil
    local v3 = nil
    local v4 = a1

    for i, j in u102, v2, v3 do
        v1 = v4 > 0.005
        j.Visible = v1
        j.BackgroundTransparency = 1 - v4
    end
end

local function pulseHealth(a1)
    -- Line: 224
    -- upvalues: Config (val), u140 (ref), u103 (ref), u137 (ref), u139 (ref), u101 (ref), u138 (ref), u104 (ref)
    -- upvalues: u102 (val)
    -- types: a1: number
    local v1, v2, v3, v4, v5
    local HealthPulse = Config.Appearance.HealthPulse

    if u140 > 0 then
        local HitFlash = Config.Appearance.HitFlash
        u140 = math.max(0, u140 - a1 * HitFlash.Alpha / HitFlash.Seconds)
    end

    local v6 = u103 > 0

    if HealthPulse.BelowFraction < u137 and not v6 then
        if u139 ~= 0 then
            u139 = 0
            u101.BackgroundColor3 = u138
        end

        v3 = u140
        v2 = math.max(if not (u104 <= 0) then 0 else Config.Appearance.LowHealthVignette.MaxAlpha, v3)
        v3 = nil
        v4 = nil

        for i, j in u102, v3, v4 do
            v1 = v2 > 0.005
            j.Visible = v1
            j.BackgroundTransparency = 1 - v2
        end

        return
    end

    if u137 <= 0 then
        if u139 ~= 0 then
            u139 = 0
            u101.BackgroundColor3 = u138
        end

        v3 = u140
        v2 = math.max(if not (u104 <= 0) then 0 else Config.Appearance.LowHealthVignette.MaxAlpha, v3)
        v3 = nil
        v4 = nil

        for m, i5 in u102, v3, v4 do
            v1 = v2 > 0.005
            i5.Visible = v1
            i5.BackgroundTransparency = 1 - v2
        end

        return
    end

    u139 = u139 + a1
    v6 = (1 - math.cos(u139 / HealthPulse.PeriodSeconds * 3.141592653589793 * 2)) / 2

    if u137 <= HealthPulse.BelowFraction then
        u101.BackgroundColor3 = u138:Lerp(Color3.new(1, 1, 1), v6 * HealthPulse.Strength)
    end

    local v7 = math.max(u103 * (v6 * 0.34 + 0.66), u140)
    local v8 = nil
    v3 = nil

    for k, n in u102, v8, v3 do
        v5 = v7 > 0.005
        n.Visible = v5
        n.BackgroundTransparency = 1 - v7
    end
end

local function buildVignette(a1) -- Line: 252; upvalues: Config (val), u102 (val); types: a1: userdata
    local UIGradient, v1
    local LowHealthVignette = Config.Appearance.LowHealthVignette
    local v2 = Color3.fromRGB(LowHealthVignette.Color.r, LowHealthVignette.Color.g, LowHealthVignette.Color.b)
    local EdgeFraction = LowHealthVignette.EdgeFraction

    for i, j in {
        {
            rotation = 90,
            size = UDim2.fromScale(1, EdgeFraction),
            position = UDim2.fromScale(0, 0),
        },
        {
            rotation = -90,
            size = UDim2.fromScale(1, EdgeFraction),
            position = UDim2.fromScale(0, 1 - EdgeFraction),
        },
        {
            rotation = 0,
            size = UDim2.fromScale(EdgeFraction, 1),
            position = UDim2.fromScale(0, 0),
        },
        {
            rotation = 180,
            size = UDim2.fromScale(EdgeFraction, 1),
            position = UDim2.fromScale(1 - EdgeFraction, 0),
        },
    } do
        v1 = Instance.new("Frame")
        v1.Name = "Vignette"
        v1.Size = j.size
        v1.Position = j.position
        v1.BackgroundColor3 = v2
        v1.BackgroundTransparency = 1
        v1.BorderSizePixel = 0
        v1.ZIndex = 0
        v1.Visible = false
        v1.Parent = a1
        UIGradient = Instance.new("UIGradient")
        UIGradient.Rotation = j.rotation
        UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), (NumberSequenceKeypoint.new(1, 1))})
        UIGradient.Parent = v1

        table.insert(u102, v1)
    end
end

local function clearLowHealth()
    -- Line: 288
    -- upvalues: u104 (ref), u137 (ref), u103 (ref), u140 (ref), u139 (ref), u138 (ref), u84 (val), u101 (ref)
    -- upvalues: u102 (val)
    u104 = 100
    u137 = 1
    u103 = 0
    u140 = 0
    u139 = 0
    u138 = u84
    u101.BackgroundColor3 = u84
    u101.Size = UDim2.fromScale(1, 1)

    for i, j in u102 do
        j.Visible = false
        j.BackgroundTransparency = 1
    end
end

local function watchCharacter(a1)
    -- Line: 300
    -- upvalues: u104 (ref), u137 (ref), u103 (ref), u140 (ref), u139 (ref), u138 (ref), u84 (val), u101 (ref)
    -- upvalues: u102 (val), setHealth (val), clearLowHealth (val)
    -- types: a1: userdata
    u104 = 100
    u137 = 1
    u103 = 0
    u140 = 0
    u139 = 0
    u138 = u84
    u101.BackgroundColor3 = u84
    u101.Size = UDim2.fromScale(1, 1)

    for i, j in u102 do
        j.Visible = false
        j.BackgroundTransparency = 1
    end

    local Humanoid = a1:WaitForChild("Humanoid", 10)

    if not Humanoid then
        return
    end

    setHealth(Humanoid.Health, Humanoid.MaxHealth)

    Humanoid.Died:Connect(function() -- Line: 309; upvalues: clearLowHealth (upval)
        task.delay(1.2, clearLowHealth)
    end)

    Humanoid.HealthChanged:Connect(function(a1) -- Line: 312; upvalues: setHealth (upval), Humanoid (val)
        setHealth(a1, Humanoid.MaxHealth)
    end)

    ;(Humanoid:GetPropertyChangedSignal("MaxHealth")):Connect(function()
        -- Line: 315
        -- upvalues: setHealth (upval), Humanoid (val)
        setHealth(Humanoid.Health, Humanoid.MaxHealth)
    end)
end

function u60.start()
    -- Line: 320
    -- upvalues: LocalPlayer (val), buildVignette (val), TouchEnabled (val), Config (val), u44 (val), u101 (ref)
    -- upvalues: u84 (val), u100 (ref), u78 (ref), u90 (ref), statRow (val), SettingsController (val), u91 (ref)
    -- upvalues: u92 (ref), u93 (ref), u99 (ref), u105 (ref), label (val), u65 (val), u68 (val), u96 (ref)
    -- upvalues: AudioController (val), u94 (ref), u95 (ref), Format (val), RunService (val), pulseHealth (val)
    -- upvalues: TimeController (val), ReplicatedStorage (val), NewPlayerView (val), u74 (val), u60 (val), u71 (val)
    -- upvalues: watchCharacter (val), clearLowHealth (val)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AboveHud"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local ScreenGui_2 = Instance.new("ScreenGui")
    ScreenGui_2.Name = "AboveVignette"
    ScreenGui_2.ResetOnSpawn = false
    ScreenGui_2.IgnoreGuiInset = true
    ScreenGui_2.ScreenInsets = Enum.ScreenInsets.None
    ScreenGui_2.DisplayOrder = -1
    ScreenGui_2.Parent = LocalPlayer:WaitForChild("PlayerGui")

    buildVignette(ScreenGui_2)

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromOffset(300, 26)
    Frame.Position = UDim2.new(0.5, -150, 1, -114)
    Frame.BackgroundTransparency = 1
    Frame.Name = "Health"
    Frame.Parent = ScreenGui

    if TouchEnabled then
        local HotbarScale = Config.Touch.Hud.HotbarScale
        Frame.AnchorPoint = Vector2.new(0.5, 1)
        Frame.Position = UDim2.new(0.5, 0, 1, -(18 + 62 * HotbarScale + 8))
        local UIScale = Instance.new("UIScale")
        UIScale.Scale = HotbarScale
        UIScale.Parent = Frame
    end

    u44.chip(Frame, "❤", u44.Palette.Red, 26, UDim2.fromOffset(0, 0))

    u101 = u44.bar(Frame, UDim2.new(1, -32, 1, -4), UDim2.fromOffset(32, 2), u84)
    u100 = Instance.new("TextLabel")
    u100.Size = UDim2.fromScale(1, 1)
    u100.BackgroundTransparency = 1
    u100.Text = ("%* / %*"):format(Config.Player.MaxHealth, Config.Player.MaxHealth)
    u100.TextColor3 = Color3.new(1, 1, 1)
    u100.TextStrokeTransparency = 0.4
    u100.FontFace = u44.Font.Bold
    u100.TextSize = 13
    u100.ZIndex = 2
    u100.Parent = u101.Parent
    local ScreenGui_3 = Instance.new("ScreenGui")
    ScreenGui_3.Name = "AboveTopStrip"
    ScreenGui_3.ResetOnSpawn = false
    ScreenGui_3.IgnoreGuiInset = true
    ScreenGui_3.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u78 = u44.card(ScreenGui_3, UDim2.fromOffset(0, 0), UDim2.new(1, -Config.Touch.Hud.StatStripRight, 0, 0))
    u78.Name = "Stats"
    local UIStroke = u78:FindFirstChildOfClass("UIStroke")

    if UIStroke then
        UIStroke:Destroy()
    end

    u78.AutomaticSize = Enum.AutomaticSize.XY
    u78.AnchorPoint = Vector2.new(1, 0)
    u78.Position = UDim2.new(1, -Config.Touch.Hud.StatStripRight, 0, Config.Touch.Hud.StatStripTop)

    if TouchEnabled then
        local UIScale_2 = Instance.new("UIScale")
        UIScale_2.Scale = Config.Touch.Hud.StatCardScale
        UIScale_2.Parent = u78
    end

    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 4)
    UIPadding.PaddingBottom = UDim.new(0, 4)
    UIPadding.PaddingLeft = UDim.new(0, 10)
    UIPadding.PaddingRight = UDim.new(0, 10)
    UIPadding.Parent = u78
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.Padding = UDim.new(0, 14)
    UIListLayout.Parent = u78
    u90 = statRow(1, "🧊", Color3.fromRGB(190, 200, 220), Config.Appearance.Icons.Blocks)
    u90.Text = "0 / 0"

    local function drawBlockCount() -- Line: 433; upvalues: u90 (upval), SettingsController (upval)
        u90.Visible = SettingsController.is("BlockCountHud", "On")
    end

    u90.Visible = SettingsController.is("BlockCountHud", "On")

    SettingsController.onChanged(function(a1)
        -- Line: 437
        -- upvalues: u90 (upval), SettingsController (upval)
        -- types: a1: string
        if a1 == "BlockCountHud" then
            u90.Visible = SettingsController.is("BlockCountHud", "On")
        end
    end)

    local LooseFillColors = Config.Build.LooseFillColors

    local function colorFor(a1) -- Line: 450; upvalues: LooseFillColors (val), u44 (upval); types: a1: number
        if LooseFillColors.Red <= a1 then
            return u44.Palette.Red
        end

        if LooseFillColors.Orange <= a1 then
            return Color3.fromRGB(240, 150, 60)
        end

        if LooseFillColors.Yellow <= a1 then
            return Color3.fromRGB(240, 210, 90)
        end

        return u44.Palette.Green
    end

    local function fillRow(a1, a2, a3, a4)
        -- Line: 462
        -- upvalues: u78 (upval), u44 (upval), SettingsController (upval), LocalPlayer (upval), colorFor (val)
        -- types: a1: number, a2: string, a3: string, a4: string
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.fromOffset(0, 24)
        Frame.AutomaticSize = Enum.AutomaticSize.X
        Frame.BackgroundTransparency = 1
        Frame.LayoutOrder = a1
        Frame.Parent = u78
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal
        UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 6)
        UIListLayout.Parent = Frame
        local TextLabel = Instance.new("TextLabel")
        TextLabel.LayoutOrder = 1
        TextLabel.Size = UDim2.fromOffset(0, 24)
        TextLabel.AutomaticSize = Enum.AutomaticSize.X
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = ("%*:"):format(a2)
        TextLabel.TextColor3 = u44.Palette.Gold
        TextLabel.FontFace = u44.Font.Bold
        TextLabel.TextSize = 14
        TextLabel.Parent = Frame
        local u58 = u44.bar(Frame, UDim2.fromOffset(52, 8), UDim2.new(), u44.Palette.Green)
        u58.Parent.LayoutOrder = 2

        local function draw()
            -- Line: 488
            -- upvalues: Frame (val), SettingsController (upval), a4 (val), LocalPlayer (upval), a3 (val), u58 (val)
            -- upvalues: colorFor (upval)
            local v1
            Frame.Visible = SettingsController.is(a4, "On")
            local Attribute = LocalPlayer:GetAttribute(a3)
            u58.Size = UDim2.fromScale(if type(Attribute) ~= "number" then 0 else math.clamp(Attribute, 0, 1), 1)
            u58.BackgroundColor3 = colorFor(v1)
        end

        draw()
        ;(LocalPlayer:GetAttributeChangedSignal(a3)):Connect(draw)

        SettingsController.onChanged(function(a1) -- Line: 497; upvalues: a4 (val), draw (val); types: a1: string
            if a1 == a4 then
                draw()
            end
        end)
    end

    fillRow(2, "Auto", Config.Build.LooseFillAttributes.World, "LooseItemsHud")
    fillRow(3, "Drop", Config.Build.LooseFillAttributes.PlayerDrops, "DroppedItemsHud")

    u91 = statRow(4, Config.Time.DayGlyph, Color3.fromRGB(255, 214, 130), Config.Appearance.Icons.Weather)
    u91.TextColor3 = Color3.fromRGB(200, 210, 230)
    u92 = statRow(5, "💰", u44.Palette.Gold, Config.Appearance.Icons.Coins)
    u92.TextColor3 = Color3.fromRGB(255, 226, 130)
    u92.Text = "0"
    u93 = statRow(6, "💎", u44.Palette.Violet)
    u93.TextColor3 = Color3.fromRGB(190, 170, 255)
    u93.Visible = false
    u99 = statRow(7, "👥", Color3.fromRGB(140, 225, 175), Config.Appearance.Icons.People)
    u99.TextColor3 = Color3.fromRGB(140, 225, 175)
    u99.Visible = false
    local ScreenGui_4 = Instance.new("ScreenGui")
    ScreenGui_4.Name = "AboveAlert"
    ScreenGui_4.ResetOnSpawn = false
    ScreenGui_4.DisplayOrder = 80
    ScreenGui_4.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u105 = label(ScreenGui_4, UDim2.fromOffset(440, 34), UDim2.new(0.5, -220, 0, 96), 20)
    u105.BackgroundTransparency = 1
    u105.TextXAlignment = Enum.TextXAlignment.Center
    u105.TextColor3 = Color3.fromRGB(255, 150, 150)
    u105.TextStrokeTransparency = 0.5
    u105.TextTransparency = 1

    u65.OnClientEvent:Connect(function(a1, a2) -- Line: 560; upvalues: u90 (upval); types: a1: number, a2: number
        u90.Text = ("%* / %*"):format(a1, a2)
    end)

    u68.OnClientEvent:Connect(function(a1, a2, a3, a4)
        -- Line: 564
        -- upvalues: u96 (upval), AudioController (upval), u94 (upval), u95 (upval), u92 (upval), Format (upval)
        -- upvalues: u93 (upval)
        -- types: a1: number, a2: number?, a3: boolean?, a4: number?
        u96 = if type(a4) ~= "number" then 0 else if not (a4 > 0) then 0 else a4

        if a3 then
            AudioController.play("Coins")
        end

        if not (u94 < a1) then
            u95 = a1
            u94 = a1
            u92.Text = Format.comma((math.floor(a1 + u96)))
        else
            u95 = a1
        end

        local v1 = a2 or 0
        u93.Visible = v1 > 0
        u93.Text = ("%* Sky Mark%*"):format(Format.comma(v1), if v1 ~= 1 then "s" else "")
    end)

    RunService.Heartbeat:Connect(function(a1)
        -- Line: 609
        -- upvalues: pulseHealth (upval), u94 (upval), u95 (upval), u92 (upval), Format (upval), u96 (upval)
        -- upvalues: TimeController (upval), Config (upval), u91 (upval), ReplicatedStorage (upval)
        -- upvalues: NewPlayerView (upval)
        local v1, v2, v3
        pulseHealth(a1)

        if u94 ~= u95 then
            v1 = u95 - u94
            v2 = math.max(1, (math.abs(v1)) * (math.min(1, a1 * 6)))
            u94 = if not (math.abs(v1) <= v2) then u94 + v2 else u95
            v3 = u94
            u92.Text = Format.comma((math.floor(v3 + u96)))
        end

        v1 = TimeController.isNight()
        local NightGlyph = if not v1 then Config.Time.DayGlyph else Config.Time.NightGlyph
        local Parent = u91.Parent
        local Chip = if not Parent then nil else Parent:FindFirstChild("Chip")

        if Chip and Chip:IsA("TextLabel") then
            Chip.Text = NightGlyph
        end

        local v4 = TimeController.clockText()
        local States = Config.Weather.States
        v2 = ReplicatedStorage:GetAttribute(Config.Weather.Attribute)
        local Default = if type(v2) ~= "string" then
            Config.Weather.Default
        else
            if not Config.Weather.States[v2] then
                Config.Weather.Default
            else
                NewPlayerView.weather(v2)
        local v5 = States[Default]

        if v5 and v5.glyph ~= "" then
            v4 = v4 .. ("   %*  %*"):format(v5.glyph, v5.displayName)
        end

        u91.Text = v4
        v3 = u91
        local v6 = if not v1 then
            Color3.fromRGB(210, 210, 200)
        else
            Color3.fromRGB(150, 170, 230)
        v3.TextColor3 = v6
    end)

    local u415 = 0
    local u416 = 0

    local function drawFriendLuck()
        -- Line: 643
        -- upvalues: u416 (ref), SettingsController (upval), u99 (upval), u415 (ref)
        local v1 = false

        if u416 > 0 then
            v1 = SettingsController.is("FriendLuckHud", "On")
        end

        u99.Visible = v1

        if v1 then
            local v2 = u99
            local v3 = if u415 ~= 1 then "s" else ""
            v2.Text = ("+%*%% luck (%* friend%*)"):format(u416, u415, v3)
        end
    end

    u74.OnClientEvent:Connect(function(a1, a2)
        -- Line: 654
        -- upvalues: u415 (ref), SettingsController (upval), u60 (upval), u416 (ref), u99 (upval)
        -- types: a1: number, a2: number
        if u415 < a1 and SettingsController.is("FriendJoinNotifications", "On") then
            u60.showAlert("A friend joined: Friend Luck up")
        end

        u415 = a1
        u416 = a2
        local v1 = false

        if u416 > 0 then
            v1 = SettingsController.is("FriendLuckHud", "On")
        end

        u99.Visible = v1

        if v1 then
            local v2 = u99
            local v3 = if u415 ~= 1 then "s" else ""
            v2.Text = ("+%*%% luck (%* friend%*)"):format(u416, u415, v3)
        end
    end)

    SettingsController.onChanged(function(a1)
        -- Line: 665
        -- upvalues: u416 (ref), SettingsController (upval), u99 (upval), u415 (ref)
        -- types: a1: string
        if a1 == "FriendLuckHud" then
            local v1 = false

            if u416 > 0 then
                v1 = SettingsController.is("FriendLuckHud", "On")
            end

            u99.Visible = v1

            if v1 then
                local v2 = u99
                local v3 = if u415 ~= 1 then "s" else ""
                v2.Text = ("+%*%% luck (%* friend%*)"):format(u416, u415, v3)
            end
        end
    end)

    u71.OnClientEvent:Connect(function(a1, a2) -- Line: 671; upvalues: u60 (upval); types: a1: string, a2: string?
        u60.showAlert(a1, if type(a2) ~= "string" then nil else a2)
    end)

    if LocalPlayer.Character then
        watchCharacter(LocalPlayer.Character)
    end

    LocalPlayer.CharacterAdded:Connect(watchCharacter)
    LocalPlayer.CharacterRemoving:Connect(clearLowHealth)
end

return u60