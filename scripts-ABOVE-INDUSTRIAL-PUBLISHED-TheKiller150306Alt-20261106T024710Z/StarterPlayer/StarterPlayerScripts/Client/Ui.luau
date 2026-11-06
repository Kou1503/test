-- Script path: game:GetService("StarterPlayer").StarterPlayerScripts.Client.Ui
-- Decompile time: 10.40 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Config = require((game:GetService("ReplicatedStorage")):WaitForChild("Shared").Config)
local u32 = {}
u32.Palette = {
    CardTransparency = 0.25,
    Unique = Color3.fromRGB(196, 160, 255),
    New = Color3.fromRGB(30, 72, 52),
    NewDot = Color3.fromRGB(226, 62, 62),
    Card = Color3.fromRGB(20, 22, 28),
    Stroke = Color3.fromRGB(58, 62, 78),
    Text = Color3.fromRGB(238, 240, 248),
    Dim = Color3.fromRGB(150, 158, 178),
    Faint = Color3.fromRGB(126, 133, 152),
    Gold = Color3.fromRGB(255, 214, 110),
    OnGold = Color3.fromRGB(28, 24, 12),
    Green = Color3.fromRGB(120, 220, 140),
    Red = Color3.fromRGB(220, 70, 70),
    Violet = Color3.fromRGB(190, 170, 255),
    Track = Color3.fromRGB(28, 30, 38),
    Raised = Color3.fromRGB(54, 59, 73),
    RaisedEdge = Color3.fromRGB(112, 122, 146),
}
local FontFamily = Config.Appearance.FontFamily
u32.Font = {
    Regular = Font.new(FontFamily, Enum.FontWeight.Regular),
    Medium = Font.new(FontFamily, Enum.FontWeight.Medium),
    Bold = Font.new(FontFamily, Enum.FontWeight.Bold),
    Family = FontFamily,
}
u32.Radius = {Card = 10, Row = 6, Chip = 6, Bar = 4}

function u32.corner(a1, a2) -- Line: 97; types: a1: userdata, a2: number
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, a2)
    UICorner.Parent = a1

    return UICorner
end

function u32.stroke(a1, a2, a3) -- Line: 104; upvalues: u32 (val); types: a1: userdata, a2: userdata?, a3: number?
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = a2 or u32.Palette.Stroke
    UIStroke.Thickness = a3 or 1
    UIStroke.Parent = a1

    return UIStroke
end

function u32.card(a1, a2, a3) -- Line: 113; upvalues: u32 (val); types: a1: userdata, a2: userdata, a3: userdata
    local Frame = Instance.new("Frame")
    Frame.Size = a2
    Frame.Position = a3
    Frame.BackgroundColor3 = u32.Palette.Card
    Frame.BackgroundTransparency = u32.Palette.CardTransparency
    Frame.BorderSizePixel = 0
    Frame.Parent = a1

    u32.corner(Frame, u32.Radius.Card)
    u32.stroke(Frame)

    return Frame
end

function u32.modalCard(a1, a2, a3)
    -- Line: 139
    -- upvalues: u32 (val)
    -- types: a1: userdata, a2: userdata, a3: userdata
    local v1 = u32.card(a1, a2, a3)
    v1.BackgroundTransparency = 0
    v1.BackgroundColor3 = u32.Palette.Raised

    u32.stroke(v1, u32.Palette.RaisedEdge, 2)

    return v1
end

function u32.newDot(a1) -- Line: 154; upvalues: u32 (val); types: a1: userdata
    local Frame = Instance.new("Frame")
    Frame.Name = "NewDot"
    Frame.Size = UDim2.fromOffset(10, 10)
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.new(1, -4, 0, 4)
    Frame.BackgroundColor3 = u32.Palette.NewDot
    Frame.BorderSizePixel = 0
    Frame.ZIndex = a1.ZIndex + 3
    Frame.Parent = a1

    u32.corner(Frame, 999)

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(18, 20, 26)
    UIStroke.Thickness = 1.5
    UIStroke.Parent = Frame

    return Frame
end

function u32.chip(a1, a2, a3, a4, a5, a6)
    -- Line: 172
    -- upvalues: u32 (val)
    -- types: a1: userdata, a2: string, a3: userdata, a4: number, a5: userdata, a6: string?
    local v1

    if not a6 or a6 == "" then
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Text = a2
        TextLabel.TextColor3 = a3
        TextLabel.TextSize = math.floor(a4 * 0.62)
        TextLabel.FontFace = u32.Font.Bold
        v1 = TextLabel
    else
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Image = a6
        ImageLabel.ImageColor3 = Color3.new(1, 1, 1)
        ImageLabel.ScaleType = Enum.ScaleType.Fit
        v1 = ImageLabel
    end

    v1.Name = "Chip"
    v1.Size = UDim2.fromOffset(a4, a4)
    v1.Position = a5
    v1.BackgroundColor3 = a3
    v1.BackgroundTransparency = if not a6 then 0.78 else if a6 == "" then 0.78 else 1
    v1.BorderSizePixel = 0
    v1.Parent = a1

    u32.corner(v1, u32.Radius.Chip)

    return v1
end

function u32.bar(a1, a2, a3, a4)
    -- Line: 210
    -- upvalues: u32 (val)
    -- types: a1: userdata, a2: userdata, a3: userdata, a4: userdata
    local Frame = Instance.new("Frame")
    Frame.Size = a2
    Frame.Position = a3
    Frame.BackgroundColor3 = u32.Palette.Track
    Frame.BorderSizePixel = 0
    Frame.Parent = a1

    u32.corner(Frame, u32.Radius.Bar)

    local Frame_2 = Instance.new("Frame")
    Frame_2.Size = UDim2.fromScale(1, 1)
    Frame_2.BackgroundColor3 = a4
    Frame_2.BorderSizePixel = 0
    Frame_2.Parent = Frame

    u32.corner(Frame_2, u32.Radius.Bar)

    return Frame_2
end

function u32.machineRoll(a1) -- Line: 233; types: a1: userdata
    local Attribute = a1:GetAttribute("Quality")
    local v1 = {}
    local v2 = false

    for i, j in a1:GetAttributes() do
        if string.sub(i, 1, 5) == "Stat_" and type(j) == "number" then
            v1[string.sub(i, 6)] = j
            v2 = true
        end
    end

    local v3 = if type(Attribute) ~= "string" then nil else Attribute

    if v2 then
        return v3, v1
    end

    return v3, nil
end

function u32.asWritten(a1) -- Line: 265
    a1.AutoLocalize = false
    return a1
end

u32.LAYER_SCALE = "GuiScale"

function u32.layerScale(a1) -- Line: 276; upvalues: u32 (val); types: a1: userdata
    local v1
    local v2 = (if not a1:IsA("LayerCollector") then a1:FindFirstAncestorWhichIsA("LayerCollector") else a1)
        and v1:FindFirstChild(u32.LAYER_SCALE)

    if v2 and v2:IsA("UIScale") and 0 < v2.Scale then
        return v2.Scale
    end

    return 1
end

local u141 = {}

function u32.onLayerScaleChanged(a1) -- Line: 285; upvalues: u141 (val); types: a1: function
    table.insert(u141, a1)
end

local DeviceMode = require(script.Parent.Controllers.DeviceMode)

local function fit(a1) -- Line: 299; upvalues: u32 (val), DeviceMode (val), Config (val); types: a1: userdata
    local v1 = a1:FindFirstAncestorWhichIsA("LayerCollector")

    if a1.Visible and v1 and v1:IsA("ScreenGui") then
        local v2 = v1.AbsoluteSize / u32.layerScale(v1)

        if not (v2.X <= 0) and not (v2.Y <= 0) then
            v1 = a1:FindFirstChild("FitScale")

            if not v1 then
                local UIScale = Instance.new("UIScale")
                UIScale.Name = "FitScale"
                UIScale.Parent = a1
                v1 = UIScale
            end

            local v3 = v1
            local Position = a1.Position
            local Attribute = a1:GetAttribute("FittedTo")
            local Attribute_2 = a1:GetAttribute("FittedFrom")

            if typeof(Attribute) == "UDim2"
                and typeof(Attribute_2) == "UDim2"
                and Attribute == a1.Position then
                Position = Attribute_2
            end

            local Size = a1.Size
            local Attribute_3 = a1:GetAttribute("FittedSizeTo")
            local Attribute_4 = a1:GetAttribute("FittedSizeFrom")

            if typeof(Attribute_3) == "UDim2"
                and typeof(Attribute_4) == "UDim2"
                and Attribute_3 == a1.Size then
                Size = Attribute_4
            end

            local v4 = Vector2.new(Size.X.Offset, Size.Y.Offset)

            if not (v4.X <= 0) and not (v4.Y <= 0) then
                local v5 = v2.X - 16
                local v6 = v2.Y - 16
                local v7 = math.min(1, v5 / v4.X, v6 / v4.Y)
                local Y_3 = v4.Y

                if DeviceMode.touchOnly() then
                    local v8 = math.min(Config.Touch.Panel.MinScale, v5 / v4.X)

                    if v7 < v8 then
                        Y_3 = math.min(v4.Y, v6 / v8)
                    end
                end

                v3.Scale = v7

                if not (Y_3 < v4.Y) then
                    if typeof(Attribute_3) == "UDim2" and Attribute_3 == a1.Size then
                        a1.Size = Size
                    end

                    a1:SetAttribute("FittedSizeFrom", nil)
                    a1:SetAttribute("FittedSizeTo", nil)
                else
                    v6 = UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale, Y_3)
                    a1:SetAttribute("FittedSizeFrom", Size)
                    a1:SetAttribute("FittedSizeTo", v6)

                    a1.Size = v6
                end

                local AnchorPoint = a1.AnchorPoint
                local v9 = (Vector2.new(Position.X.Scale * v2.X + Position.X.Offset - AnchorPoint.X * v4.X, Position.Y.Scale * v2.Y + Position.Y.Offset - AnchorPoint.Y * v4.Y))
                    + v4 / 2
                local v10 = Vector2.new(v4.X, Y_3) * v7
                local v11 = math.clamp(v9.X - v10.X / 2, 8, (math.max(8, v2.X - v10.X - 8)))
                v4 = math.clamp(v9.Y - v10.Y / 2, 8, (math.max(8, v2.Y - v10.Y - 8)))
                v3 = false

                if (math.abs(v11 - (v9.X - v10.X / 2))) < 0.5 then
                    v3 = (math.abs(v4 - (v9.Y - v10.Y / 2))) < 0.5
                end

                if v7 >= 1 and v3 then
                    if typeof(Attribute) == "UDim2" and Attribute == a1.Position then
                        a1.Position = Position
                    end

                    a1:SetAttribute("FittedTo", nil)
                    a1:SetAttribute("FittedFrom", nil)

                    return
                end

                v7 = UDim2.fromOffset(v11 + AnchorPoint.X * v10.X, v4 + AnchorPoint.Y * v10.Y)
                a1:SetAttribute("FittedFrom", Position)
                a1:SetAttribute("FittedTo", v7)

                a1.Position = v7
            end
        end
    end
end

local function guardOpening(a1) -- Line: 402; upvalues: DeviceMode (val), Config (val); types: a1: userdata
    if not DeviceMode.touchOnly() then
        return
    end

    local TapShield = a1:FindFirstChild("TapShield")

    if TapShield then
        TapShield:Destroy()
    end

    local TextButton = Instance.new("TextButton")
    TextButton.Name = "TapShield"
    TextButton.Text = ""
    TextButton.BackgroundTransparency = 1
    TextButton.AutoButtonColor = false
    TextButton.Size = UDim2.fromScale(1, 1)
    TextButton.ZIndex = 10000
    TextButton.Parent = a1

    task.delay(
        Config.Touch.Panel.OpenGuardSeconds,
        function() -- Line: 418; upvalues: TextButton (val)
            TextButton:Destroy()
        end
    )
end

local u151 = {}

function u32.fitToScreen(a1) -- Line: 428; upvalues: u151 (val), guardOpening (val), fit (val); types: a1: userdata
    table.insert(u151, a1)

    ;(a1:GetPropertyChangedSignal("Visible")):Connect(function()
        -- Line: 430
        -- upvalues: a1 (val), guardOpening (upval), fit (upval)
        if a1.Visible then
            guardOpening(a1)
            task.defer(fit, a1)
        end
    end)

    local function refit() -- Line: 441; upvalues: fit (upval), a1 (val)
        task.defer(fit, a1)
        task.delay(0.2, fit, a1)
    end

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        (CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(refit)
    end

    local v1 = a1:FindFirstAncestorWhichIsA("LayerCollector")

    if v1 then
        (v1:GetPropertyChangedSignal("AbsoluteSize")):Connect(refit)
    end

    task.defer(fit, a1)
end

function u32.layerScaleChanged() -- Line: 458; upvalues: u151 (val), fit (val), u141 (val)
    for i, j in u151 do
        task.defer(fit, j)
    end

    for k, n in u141 do
        task.spawn(n)
    end
end

function u32.appear(a1) -- Line: 477; upvalues: Config (val), TweenService (val); types: a1: userdata
    local Panel = Config.Appearance.Panel

    if not Panel.Enabled then
        return
    end

    local AppearScale = a1:FindFirstChild("AppearScale")

    if not AppearScale then
        local UIScale = Instance.new("UIScale")
        UIScale.Name = "AppearScale"
        UIScale.Parent = a1
        AppearScale = UIScale
    end

    assert(AppearScale, "a UIScale was just parented")

    local Attribute = a1:GetAttribute("RestPosition")

    if typeof(Attribute) ~= "UDim2" then
        a1:SetAttribute("RestPosition", a1.Position)
    end

    local v1 = Attribute
    AppearScale.Scale = Panel.FromScale
    a1.Position = v1 + UDim2.fromOffset(0, Panel.RisePixels)
    local v2 = TweenInfo.new(Panel.OpenSeconds, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    TweenService:Create(
        AppearScale,
        v2,
        {Scale = 1}
    ):Play()

    TweenService:Create(
        a1,
        v2,
        {Position = v1}
    ):Play()

    if a1:IsA("CanvasGroup") then
        a1.GroupTransparency = 1
        TweenService:Create(
            a1,
            v2,
            {GroupTransparency = 0}
        ):Play()
    end
end

function u32.holdForStack(a1, a2) -- Line: 526; upvalues: Config (val); types: a1: userdata, a2: function
    local Panel = Config.Touch.Panel
    local u5 = false
    local u6 = 0

    a1.InputBegan:Connect(function(a1) -- Line: 530; upvalues: u6 (ref), u5 (ref), Panel (val), a2 (val)
        if a1.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        u6 = u6 + 1
        local u5_2 = u6
        u5 = false
        local Position = a1.Position

        task.delay(
            Panel.HoldForStackSeconds,
            function()
                -- Line: 538
                -- upvalues: u6 (upval), u5_2 (val), a1 (val), Position (val), Panel (upval), u5 (upval), a2 (upval)
                if u6 == u5_2 and a1.UserInputState ~= Enum.UserInputState.End then
                    if a1.UserInputState == Enum.UserInputState.Cancel then
                        return
                    end

                    local Magnitude = (a1.Position - Position).Magnitude

                    if Panel.HoldForStackSlop < Magnitude then
                        return
                    end

                    u5 = true
                    a2()
                end
            end
        )
    end)

    a1.InputEnded:Connect(function(a1) -- Line: 552; upvalues: u6 (ref)
        if a1.UserInputType == Enum.UserInputType.Touch then
            u6 = u6 + 1
        end
    end)

    return function() -- Line: 557; upvalues: u5 (ref)
        local v1 = u5
        u5 = false

        return v1
    end
end

function u32.pointerOverGui() -- Line: 591; upvalues: Players (val), UserInputService (val), GuiService (val)
    local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")

    if not PlayerGui then
        return false
    end

    local MouseLocation = UserInputService:GetMouseLocation()
    local GuiInset = GuiService:GetGuiInset()

    for i, j in (PlayerGui:GetGuiObjectsAtPosition(MouseLocation.X - GuiInset.X, MouseLocation.Y - GuiInset.Y)) do
        if j.Visible and j.BackgroundTransparency < 1 then
            return true
        end
    end

    return false
end

u32.TouchOnly = DeviceMode.touchOnly()
u32.TenFoot = GuiService:IsTenFootInterface()

function u32.tap(a1) -- Line: 624; upvalues: DeviceMode (val), Config (val); types: a1: number
    if DeviceMode.touchOnly() then
        return (math.max(a1, Config.Touch.Panel.MinTapHeight))
    end

    return a1
end

function u32.tapRow(a1) -- Line: 629; upvalues: DeviceMode (val), Config (val); types: a1: number
    if DeviceMode.touchOnly() then
        return (math.max(a1, Config.Touch.Panel.MinTapHeight + 8))
    end

    return a1
end

function u32.tapText(a1) -- Line: 634; upvalues: DeviceMode (val), Config (val); types: a1: number
    if DeviceMode.touchOnly() then
        return a1 + Config.Touch.Panel.TapTextBump
    end

    return a1
end

function u32.confirm(a1, a2) -- Line: 655; upvalues: u32 (val); types: a1: table, a2: function
    local PlayerGui = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")

    if not PlayerGui then
        a2(false)
        return
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ConfirmDialog"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 90
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromScale(1, 1)
    TextButton.BackgroundColor3 = Color3.new(0, 0, 0)
    TextButton.BackgroundTransparency = 0.45
    TextButton.BorderSizePixel = 0
    TextButton.AutoButtonColor = false
    TextButton.Text = ""
    TextButton.Parent = ScreenGui
    local v1 = a1.height or 196
    local u54 = u32.modalCard(ScreenGui, UDim2.fromOffset(380, v1), UDim2.fromScale(0.5, 0.5))
    u54.AnchorPoint = Vector2.new(0.5, 0.5)

    u32.corner(u54, u32.Radius.Card)

    local v2 = Instance.new("TextLabel")
    v2.Size = UDim2.new(1, -32, 0, 30)
    v2.Position = UDim2.fromOffset(16, 14)
    v2.BackgroundTransparency = 1
    v2.FontFace = u32.Font.Bold
    v2.TextSize = u32.tapText(22)
    local Red = if not a1.danger then u32.Palette.Text else u32.Palette.Red
    v2.TextColor3 = Red
    v2.Text = a1.title
    v2.Parent = u54
    v2 = Instance.new("TextLabel")
    v2.Size = UDim2.new(1, -32, 0, v1 - 126)
    v2.Position = UDim2.fromOffset(16, 48)
    v2.BackgroundTransparency = 1
    v2.FontFace = u32.Font.Medium
    v2.TextSize = u32.tapText(15)
    v2.TextWrapped = true
    v2.TextYAlignment = Enum.TextYAlignment.Top
    v2.TextColor3 = u32.Palette.Text
    v2.Text = a1.body
    v2.Parent = u54
    local u129 = false

    local function answer(a1) -- Line: 705; upvalues: u129 (ref), ScreenGui (val), a2 (val); types: a1: boolean
        if u129 then
            return
        end

        u129 = true
        ScreenGui:Destroy()
        a2(a1)
    end

    local u137 = u32.tap(36)

    local function button(a1, a2_2, a3, a4, a5)
        -- Line: 715
        -- upvalues: u137 (val), u32 (upval), u54 (val), u129 (ref), ScreenGui (val), a2 (val)
        -- types: a1: string, a2_2: userdata, a3: userdata, a4: number, a5: boolean
        local TextButton = Instance.new("TextButton")
        TextButton.Size = UDim2.new(0.5, -22, 0, u137)
        TextButton.Position = UDim2.new(a4, if a4 ~= 0 then 6 else 16, 1, -(u137 + 14))
        TextButton.BackgroundColor3 = a2_2
        TextButton.BorderSizePixel = 0
        TextButton.AutoButtonColor = true
        TextButton.FontFace = u32.Font.Bold
        TextButton.TextSize = u32.tapText(16)
        TextButton.TextColor3 = a3
        TextButton.Text = a1
        TextButton.Parent = u54

        u32.corner(TextButton, u32.Radius.Chip)

        TextButton.Activated:Connect(function()
            -- Line: 728
            -- upvalues: a5 (val), u129 (upval), ScreenGui (upval), a2 (upval)
            if u129 then
                return
            end

            u129 = true
            ScreenGui:Destroy()
            a2(a5)
        end)
    end

    local cancel = a1.cancel

    if not cancel then
        button(a1.confirm, u32.Palette.Gold, u32.Palette.OnGold, 0, true)

        local TextButton_2 = u54:FindFirstChildWhichIsA("TextButton")

        if TextButton_2 then
            TextButton_2.Size = UDim2.new(1, -32, 0, u137)
        end
    else
        button(cancel, u32.Palette.Track, u32.Palette.Text, 0, false)
        button(a1.confirm, if not a1.danger then u32.Palette.Gold else u32.Palette.Red, if not a1.danger then u32.Palette.OnGold else u32.Palette.Text, 0.5, true)
    end

    ScreenGui.Parent = PlayerGui
    u32.fitToScreen(u54)
end

function u32.closeButton(a1, a2, a3)
    -- Line: 755
    -- upvalues: u32 (val), DeviceMode (val), Config (val)
    -- types: a1: userdata, a2: number, a3: function
    local TextButton = Instance.new("TextButton")
    TextButton.Name = "Close"
    TextButton.Size = UDim2.fromOffset(u32.tap(26), u32.tap(26))
    TextButton.AnchorPoint = Vector2.new(1, 0)
    TextButton.Position = UDim2.new(1, -10, 0, a2)
    TextButton.BackgroundColor3 = u32.Palette.Track
    TextButton.BorderSizePixel = 0
    TextButton.Text = "×"
    TextButton.TextColor3 = u32.Palette.Dim
    TextButton.FontFace = u32.Font.Bold
    TextButton.TextSize = u32.tapText(20)
    TextButton.AutoButtonColor = true
    TextButton.Parent = a1

    u32.corner(TextButton, 6)

    if DeviceMode.touchOnly() then
        local TextButton_2 = Instance.new("TextButton")
        TextButton_2.Name = "CloseHitArea"
        TextButton_2.Text = ""
        TextButton_2.BackgroundTransparency = 1
        TextButton_2.AutoButtonColor = false
        TextButton_2.AnchorPoint = Vector2.new(0.5, 0.5)
        TextButton_2.Position = UDim2.fromScale(0.5, 0.5)
        TextButton_2.Size = UDim2.fromOffset(Config.Touch.Panel.CloseHitSize, Config.Touch.Panel.CloseHitSize)
        TextButton_2.ZIndex = TextButton.ZIndex
        TextButton_2.Parent = TextButton

        TextButton_2.Activated:Connect(a3)
    end

    TextButton.Activated:Connect(a3)

    return TextButton
end

return u32