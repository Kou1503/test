-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.SettingsPanelController
-- Decompile time: 12.40 ms

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u33 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local DeviceMode = require(script.Parent.DeviceMode)
local PanelTabs = require(script.Parent.PanelTabs)
local SettingsController = require(script.Parent.SettingsController)
local u59 = {}
local LocalPlayer = Players.LocalPlayer
local u64 = u33.tapRow(34)
local u65 = nil
local u66 = nil
local u67 = nil

local function isOpen() -- Line: 44; upvalues: u66 (ref)
    local Visible = false

    if u66 ~= nil then
        Visible = u66.Visible
    end

    return Visible
end

u59.isOpen = isOpen

local function makeRow(a1, a2, a3, a4)
    -- Line: 49
    -- upvalues: u64 (val), u33 (val)
    -- types: a1: userdata, a2: number, a3: string, a4: string?
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -12, 0, u64 - 4)
    Frame.Position = UDim2.fromOffset(6, a2)
    Frame.BackgroundColor3 = Color3.fromRGB(32, 35, 44)
    Frame.BorderSizePixel = 0
    Frame.Parent = a1
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Frame
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -150, 1, 0)
    TextLabel.Position = UDim2.fromOffset(12, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = if not a4 then a3 else ("%*   ·   %*"):format(a3, a4)
    TextLabel.TextColor3 = Color3.fromRGB(232, 236, 245)
    TextLabel.TextSize = 13
    TextLabel.FontFace = u33.Font.Medium
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
    TextLabel.Parent = Frame

    return Frame
end

local function makeValueButton(a1, a2, a3)
    -- Line: 75
    -- upvalues: u33 (val)
    -- types: a1: userdata, a2: string, a3: userdata
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromOffset(126, u33.tap(24))
    TextButton.Position = UDim2.new(1, -136, 0.5, -u33.tap(24) / 2)
    TextButton.BackgroundColor3 = a3
    TextButton.Text = a2
    TextButton.TextColor3 = u33.Palette.OnGold
    TextButton.TextSize = u33.tapText(12)
    TextButton.FontFace = u33.Font.Bold
    TextButton.Parent = a1
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = TextButton

    return TextButton
end

local function nextOption(a1, a2) -- Line: 95; types: a1: table, a2: string
    local v1 = table.find(a1, a2) or #a1
    return a1[v1 % #a1 + 1]
end

local u72 = nil
local u73 = {}

local function stepped(a1, a2) -- Line: 113; types: a2: number
    return (math.clamp(a1.min + (math.round((a1.min + a2 * (a1.max - a1.min) - a1.min) / a1.step)) * a1.step, a1.min, a1.max))
end

local function isPress(a1) -- Line: 119; types: a1: userdata
    local v1 = true

    if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
        v1 = a1.UserInputType == Enum.UserInputType.Touch
    end

    return v1
end

local function makeSlider(a1, a2)
    -- Line: 123
    -- upvalues: u64 (val), u33 (val), SettingsController (val), u73 (val), UserInputService (val), u72 (ref)
    -- types: a1: userdata
    local slider = a2.slider
    local TextLabel_2 = a1:FindFirstChildOfClass("TextLabel")

    if TextLabel_2 then
        TextLabel_2.Size = UDim2.new(1, -254, 1, 0)
    end

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.fromOffset(46, u64 - 4)
    TextLabel.Position = UDim2.new(1, -56, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = u33.Palette.Gold
    TextLabel.FontFace = u33.Font.Bold
    TextLabel.TextSize = u33.tapText(13)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Right
    TextLabel.Parent = a1
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromOffset(168, 6)
    Frame.Position = UDim2.new(1, -236, 0.5, -3)
    Frame.BackgroundColor3 = Color3.fromRGB(54, 58, 70)
    Frame.BorderSizePixel = 0
    Frame.Parent = a1

    u33.corner(Frame, 3)

    local Frame_2 = Instance.new("Frame")
    Frame_2.BackgroundColor3 = u33.Palette.Gold
    Frame_2.BorderSizePixel = 0
    Frame_2.Parent = Frame

    u33.corner(Frame_2, 3)

    local Frame_3 = Instance.new("Frame")
    Frame_3.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame_3.Size = UDim2.fromOffset(16, 16)
    Frame_3.BackgroundColor3 = Color3.fromRGB(245, 240, 225)
    Frame_3.BorderSizePixel = 0
    Frame_3.ZIndex = 2
    Frame_3.Parent = Frame

    u33.corner(Frame_3, 8)

    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.new(1, 16, 0, u33.tap(26))
    TextButton.Position = UDim2.new(0, -8, 0.5, -u33.tap(26) / 2)
    TextButton.BackgroundTransparency = 1
    TextButton.Text = ""
    TextButton.ZIndex = 3
    TextButton.Parent = Frame

    local function show(a1)
        -- Line: 173
        -- upvalues: slider (val), Frame_2 (val), Frame_3 (val), TextLabel (val)
        -- types: a1: number
        local v1 = (a1 - slider.min) / (slider.max - slider.min)
        Frame_2.Size = UDim2.fromScale(v1, 1)
        Frame_3.Position = UDim2.fromScale(v1, 0.5)
        TextLabel.Text = ("%*%*"):format(a1, slider.suffix or "")
    end

    local min = tonumber((SettingsController.get(a2.id)))

    if not min then
        min = slider.min
    end

    local u136 = min
    show(min)

    local function at(a1) -- Line: 184; upvalues: Frame (val), u136 (ref), slider (val); types: a1: number
        local X = Frame.AbsoluteSize.X

        if X <= 0 then
            return u136
        end

        return (math.clamp(slider.min + (math.round((slider.min + (math.clamp((a1 - Frame.AbsolutePosition.X) / X, 0, 1)) * (slider.max - slider.min) - slider.min) / slider.step)) * slider.step, slider.min, slider.max))
    end

    local u144 = false

    TextButton.InputBegan:Connect(function(a1)
        -- Line: 193
        -- upvalues: u144 (ref), u136 (ref), Frame (val), slider (val), show (val)
        local v1 = true

        if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
            v1 = a1.UserInputType == Enum.UserInputType.Touch
        end

        if v1 then
            u144 = true
            local X = a1.Position.X
            local X_2 = Frame.AbsoluteSize.X

            show(if not (X_2 <= 0) then math.clamp(slider.min + (math.round((slider.min + (math.clamp((X - Frame.AbsolutePosition.X) / X_2, 0, 1)) * (slider.max - slider.min) - slider.min) / slider.step)) * slider.step, slider.min, slider.max) else u136)
        end
    end)

    table.insert(
        u73,
        (UserInputService.InputChanged:Connect(function(a1)
            -- Line: 202
            -- upvalues: u144 (ref), u136 (ref), Frame (val), slider (val), show (val)
            if u144 then
                if a1.UserInputType == Enum.UserInputType.MouseMovement
                    or a1.UserInputType == Enum.UserInputType.Touch then
                    local X = a1.Position.X
                    local X_2 = Frame.AbsoluteSize.X

                    show(if not (X_2 <= 0) then math.clamp(slider.min + (math.round((slider.min + (math.clamp((X - Frame.AbsolutePosition.X) / X_2, 0, 1)) * (slider.max - slider.min) - slider.min) / slider.step)) * slider.step, slider.min, slider.max) else u136)
                end
            end
        end))
    )

    table.insert(
        u73,
        (UserInputService.InputEnded:Connect(function(a1)
            -- Line: 217
            -- upvalues: u144 (ref), u136 (ref), min (ref), SettingsController (upval), a2 (val), u72 (upval)
            if u144 then
                local v1 = true

                if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    v1 = a1.UserInputType == Enum.UserInputType.Touch
                end

                if v1 then
                    u144 = false

                    if u136 ~= min then
                        min = u136
                        local v2 = u136

                        SettingsController.set(a2.id, (tostring(v2)))
                        task.defer(u72)
                    end
                end
            end
        end))
    )
end

local function settingsIn(a1) -- Line: 234; upvalues: Config (val), u33 (val), DeviceMode (val); types: a1: string
    local v1 = {}
    local v2 = nil
    local v3 = nil

    for i, j in Config.Settings.Settings, v2, v3 do
        if j.category == a1 and j.shownIn == nil then
            if not j.desktopOnly or not u33.TouchOnly then
                if not j.touchOnly or u33.TouchOnly then
                    if not j.consoleOnly or u33.TenFoot then
                        if not j.hybridOnly or DeviceMode.Hybrid then
                            if j.id ~= "GuiScale" or not u33.TenFoot then
                                table.insert(v1, j)
                            end
                        end
                    end
                end
            end
        end
    end

    table.sort(
        v1,
        function(a1, a2) -- Line: 251
            return a1.label < a2.label
        end
    )

    return v1
end

local function tabCategories() -- Line: 258; upvalues: Config (val), settingsIn (val)
    local v1 = {}

    for i, j in Config.Settings.Categories do
        if #settingsIn(j) > 0 then
            table.insert(v1, j)
        end
    end

    return v1
end

local u79 = nil
local u80 = nil

local function drawTabs(a1)
    -- Line: 272
    -- upvalues: u80 (ref), u79 (ref), u33 (val), u67 (ref), u72 (ref)
    -- types: a1: table
    local Gold, OnGold, TextButton, v1

    for i, j in u80:GetChildren() do
        if j:IsA("TextButton") then
            j:Destroy()
        end
    end

    local v2 = nil
    local v3 = nil

    for k, n in a1, v2, v3 do
        v1 = n == u79
        TextButton = Instance.new("TextButton")
        TextButton.LayoutOrder = k
        TextButton.Size = UDim2.fromOffset(0, u33.tap(26))
        TextButton.AutomaticSize = Enum.AutomaticSize.X
        Gold = if not v1 then Color3.fromRGB(36, 40, 50) else u33.Palette.Gold
        TextButton.BackgroundColor3 = Gold
        TextButton.Text = string.upper(n)
        OnGold = if not v1 then Color3.fromRGB(150, 158, 178) else u33.Palette.OnGold
        TextButton.TextColor3 = OnGold
        TextButton.TextSize = u33.tapText(12)
        TextButton.FontFace = u33.Font.Bold
        TextButton.AutoButtonColor = not v1
        TextButton.Parent = u80

        u33.corner(TextButton, 6)

        v1 = Instance.new("UIPadding")
        v1.PaddingLeft = UDim.new(0, 9)
        v1.PaddingRight = UDim.new(0, 9)
        v1.Parent = TextButton

        TextButton.Activated:Connect(function() -- Line: 297; upvalues: u79 (upval), n (val), u67 (upval), u72 (upval)
            if u79 ~= n then
                u79 = n
                u67.CanvasPosition = Vector2.zero

                u72()
            end
        end)
    end
end

local function drawSettings(a1)
    -- Line: 307
    -- upvalues: tabCategories (val), u79 (ref), drawTabs (val), settingsIn (val), ControlGlyphs (val), makeRow (val)
    -- upvalues: u67 (ref), makeSlider (val), u64 (val), SettingsController (val), makeValueButton (val), u33 (val)
    -- upvalues: u72 (ref), Config (val), VRService (val)
    -- types: a1: number
    local v1
    local v2 = tabCategories()

    if u79 == nil or not table.find(v2, u79) then
        u79 = v2[1]
    end

    drawTabs(v2)

    v2 = u79

    if not v2 then
        return a1
    end

    for i, j in settingsIn(v2) do
        if j.id == "PickupKey" then
            if not ControlGlyphs.usingGamepad() then
                v1 = makeRow(u67, a1, j.label)

                if not j.slider then
                    (makeValueButton(v1, string.upper((SettingsController.get(j.id))), u33.Palette.Gold)).MouseButton1Click:Connect(function()
                        -- Line: 332
                        -- upvalues: SettingsController (upval), j (val), u72 (upval)
                        local set = SettingsController.set
                        local id = j.id
                        local options = j.options

                        set(id, options[(table.find(options, (SettingsController.get(j.id))) or #options) % #options + 1])
                        u72()
                    end)
                else
                    makeSlider(v1, j)
                end

                a1 = a1 + u64
            end
        elseif j.id ~= "UseKey" or not ControlGlyphs.usingGamepad() then
            v1 = makeRow(u67, a1, j.label)

            if not j.slider then
                (makeValueButton(v1, string.upper((SettingsController.get(j.id))), u33.Palette.Gold)).MouseButton1Click:Connect(function()
                    -- Line: 332
                    -- upvalues: SettingsController (upval), j (val), u72 (upval)
                    local set = SettingsController.set
                    local id = j.id
                    local options = j.options

                    set(id, options[(table.find(options, (SettingsController.get(j.id))) or #options) % #options + 1])
                    u72()
                end)
            else
                makeSlider(v1, j)
            end

            a1 = a1 + u64
        end
    end

    if v2 == "Controls" and not u33.TouchOnly then
        local v3, v4, v5
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, -24, 0, 22)
        TextLabel.Position = UDim2.fromOffset(12, a1 + 6)
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        local v6 = ControlGlyphs.usingGamepad()
        TextLabel.Text = if not v6 then "OTHER KEYS" else "CONTROLLER"
        TextLabel.TextColor3 = u33.Palette.Dim
        TextLabel.TextSize = 11
        TextLabel.FontFace = u33.Font.Bold
        TextLabel.Parent = u67
        a1 = a1 + 30

        if v6 then
            local v7
            v3 = nil
            v4 = nil

            for m, i5 in Config.Settings.PadButtons, v3, v4 do
                if not i5.vrOnly or VRService.VREnabled then
                    v7 = makeRow(u67, a1, i5.action)
                    v5 = ControlGlyphs.icon(Enum.KeyCode[i5.key], u64 - 12)
                    v5.AnchorPoint = Vector2.new(1, 0.5)
                    v5.Position = UDim2.new(1, -12, 0.5, 0)
                    v5.Parent = v7
                    a1 = a1 + u64
                end
            end

            return a1
        end

        v3 = nil
        v4 = nil

        for k, n in Config.Settings.FixedKeys, v3, v4 do
            if n.action ~= "Shop" or Config.Monetization.ShopInMenuBar then
                v5 = makeValueButton(makeRow(u67, a1, n.action), n.key, u33.Palette.Track)
                v5.TextColor3 = u33.Palette.Text
                v5.AutoButtonColor = false
                v5.Active = false
                a1 = a1 + u64
            end
        end
    end

    return a1
end

function u72() -- Line: 388; upvalues: u73 (val), u67 (ref), drawSettings (val)
    for i, j in u73 do
        j:Disconnect()
    end

    table.clear(u73)

    for k, n in u67:GetChildren() do
        if n:IsA("Frame") or n:IsA("TextLabel") then
            n:Destroy()
        end
    end

    local v1 = drawSettings(0)
    u67.CanvasSize = UDim2.fromOffset(0, v1 + 8)
end

function u59.close() -- Line: 403; upvalues: u66 (ref), BuildController (val)
    local Visible = false

    if u66 ~= nil then
        Visible = u66.Visible
    end

    if not Visible then
        return
    end

    u66.Visible = false
    BuildController.setUiOpen("Settings", false)
end

function u59.open() -- Line: 411; upvalues: u66 (ref), u33 (val), BuildController (val), u72 (ref)
    u66.Visible = true
    u33.appear(u66)
    BuildController.setUiOpen("Settings", true)
    u72()
end

function u59.toggle() -- Line: 418; upvalues: u66 (ref), u59 (val)
    local Visible = false

    if u66 ~= nil then
        Visible = u66.Visible
    end

    if Visible then
        u59.close()
        return
    end

    u59.open()
end

function u59.start()
    -- Line: 426
    -- upvalues: BuildController (val), u59 (val), PanelTabs (val), isOpen (val), tabCategories (val), u79 (ref)
    -- upvalues: u67 (ref), u72 (ref), ControlGlyphs (val), u66 (ref), u65 (ref), LocalPlayer (val), u33 (val)
    -- upvalues: u80 (ref), SettingsController (val)
    BuildController.registerMenu("Settings", u59.close)

    PanelTabs.register(
        isOpen,
        function(a1)
            -- Line: 430
            -- upvalues: PanelTabs (upval), tabCategories (upval), u79 (upval), u67 (upval), u72 (upval)
            local v1 = PanelTabs.neighbour(tabCategories(), u79, a1)

            if v1 and v1 ~= u79 then
                u79 = v1
                u67.CanvasPosition = Vector2.zero

                u72()
            end
        end
    )

    ControlGlyphs.onChanged(function() -- Line: 439; upvalues: u66 (upval), u72 (upval)
        local Visible = false

        if u66 ~= nil then
            Visible = u66.Visible
        end

        if Visible then
            u72()
        end
    end)

    u65 = Instance.new("ScreenGui")
    u65.Name = "Settings"
    u65.ResetOnSpawn = false
    u65.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    u65.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u66 = Instance.new("CanvasGroup")
    u66.Size = UDim2.fromOffset(470, 460)
    u66.Position = UDim2.new(0.5, -235, 0.5, -230)

    u33.fitToScreen(u66)

    u66.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    u66.BackgroundTransparency = 0.05
    u66.BorderSizePixel = 0
    u66.Visible = false
    u66.Active = true
    u66.Parent = u65

    u33.closeButton(u66, 10, u59.close)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = u66
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(58, 62, 78)
    UIStroke.Thickness = 1
    UIStroke.Parent = u66
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -24, 0, 30)
    TextLabel.Position = UDim2.fromOffset(14, 10)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "SETTINGS"
    TextLabel.TextColor3 = Color3.fromRGB(238, 240, 248)
    TextLabel.TextSize = 17
    TextLabel.FontFace = u33.Font.Bold
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = u66
    u80 = Instance.new("Frame")
    u80.Size = UDim2.new(1, -28, 0, u33.tap(26) + 2)
    u80.Position = UDim2.fromOffset(14, 20 + u33.tap(26))
    u80.BackgroundTransparency = 1
    u80.Parent = u66
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.Parent = u80
    u67 = Instance.new("ScrollingFrame")
    u67.Size = UDim2.new(1, -20, 1, -(30 + 2 * u33.tap(26) + 10))
    u67.Position = UDim2.fromOffset(10, 30 + 2 * u33.tap(26) + 2)
    u67.BackgroundTransparency = 1
    u67.BorderSizePixel = 0
    u67.ScrollBarThickness = 5
    u67.CanvasSize = UDim2.fromOffset(0, 0)
    u67.Parent = u66

    SettingsController.onChanged(function() -- Line: 510; upvalues: u66 (upval), u72 (upval)
        local Visible = false

        if u66 ~= nil then
            Visible = u66.Visible
        end

        if Visible then
            u72()
        end
    end)
end

return u59