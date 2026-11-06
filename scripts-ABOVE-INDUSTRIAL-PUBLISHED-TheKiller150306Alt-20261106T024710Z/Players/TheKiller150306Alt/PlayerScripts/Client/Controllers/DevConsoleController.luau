-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.DevConsoleController
-- Decompile time: 27.10 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local ServerEvents = require(Shared.ServerEvents)
local DevCommands = require(Shared.DevCommands)
local GuestBookController = require(script.Parent.GuestBookController)
local Palette = require(Shared.Palette)
local Remotes = require(Shared.Remotes)
local u60 = require(script.Parent.Parent.Ui)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u67 = Color3.fromRGB(24, 26, 32)
local u72 = Color3.fromRGB(16, 18, 22)
local u77 = Color3.fromRGB(44, 48, 58)
local u82 = Color3.fromRGB(70, 120, 200)
local u87 = Color3.fromRGB(70, 150, 90)
local u92 = Color3.fromRGB(170, 60, 60)
local u97 = Color3.fromRGB(235, 238, 245)
local u102 = Color3.fromRGB(150, 158, 172)
local u105 = Remotes.get(Remotes.RequestDevCommand)
local u116 = DevCommands.itemIds(Config.Build, Config.Recipe, Config.Tool, Config.Crop, Config.Bush, Config.Shiny, Config.Enemy, Config.Flower, Config.Wearable)

table.sort(
    u116,
    function(a1, a2) -- Line: 65; upvalues: Palette (val)
        return (Palette.displayName(a1)) < Palette.displayName(a2)
    end
)

local function corner(a1, a2) -- Line: 69; types: a1: userdata, a2: number
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, a2)
    UICorner.Parent = a1
end

local function label(a1, a2, a3, a4)
    -- Line: 75
    -- upvalues: u60 (val)
    -- types: a1: string, a2: number, a3: userdata, a4: userdata
    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = a1
    TextLabel.TextColor3 = a3
    TextLabel.FontFace = u60.Font.Regular
    TextLabel.TextSize = a2
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = a4

    return TextLabel
end

local function button(a1, a2, a3)
    -- Line: 87
    -- upvalues: u97 (val), u60 (val)
    -- types: a1: string, a2: userdata, a3: userdata?
    local TextButton = Instance.new("TextButton")
    TextButton.BackgroundColor3 = a2
    TextButton.Text = a1
    TextButton.TextColor3 = u97
    TextButton.FontFace = u60.Font.Medium
    TextButton.TextSize = 13
    TextButton.AutoButtonColor = true
    TextButton.BorderSizePixel = 0

    if a3 then
        TextButton.Parent = a3
    end

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = TextButton

    return TextButton
end

function v1.start()
    -- Line: 103
    -- upvalues: LocalPlayer (val), u60 (val), u67 (val), u97 (val), u102 (val), u77 (val), TweenService (val)
    -- upvalues: u72 (val), u82 (val), u116 (val), Config (val), ServerEvents (val), Players (val)
    -- upvalues: GuestBookController (val), u105 (val), DevCommands (val), u92 (val), u87 (val), Palette (val)
    -- upvalues: TextChatService (val), Remotes (val), RunService (val), UserInputService (val)
    local UICorner_4, UIPadding_2, name, renderDetail, v1, v2, v3, v4, v5
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AboveDevConsole"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 100
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromScale(1, 1)
    TextButton.BackgroundColor3 = Color3.new(0, 0, 0)
    TextButton.BackgroundTransparency = 0.5
    TextButton.Text = ""
    TextButton.AutoButtonColor = false
    TextButton.Visible = false
    TextButton.Parent = ScreenGui
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromOffset(700, 480)
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.fromScale(0.5, 0.5)

    u60.fitToScreen(Frame)

    Frame.BackgroundColor3 = u67
    Frame.BorderSizePixel = 0
    Frame.Parent = TextButton
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Frame
    local v6 = u97
    local v7 = Instance.new("TextLabel")
    v7.BackgroundTransparency = 1
    v7.Text = "DEV CONSOLE"
    v7.TextColor3 = v6
    v7.FontFace = u60.Font.Regular
    v7.TextSize = 18
    v7.TextXAlignment = Enum.TextXAlignment.Left
    v7.Parent = Frame
    v7.FontFace = u60.Font.Bold
    v7.Position = UDim2.fromOffset(16, 12)
    v7.Size = UDim2.new(1, -60, 0, 24)
    v6 = u102
    v7 = Instance.new("TextLabel")
    v7.BackgroundTransparency = 1
    v7.Text = "Scaffolding. Anything here bypasses progression."
    v7.TextColor3 = v6
    v7.FontFace = u60.Font.Regular
    v7.TextSize = 12
    v7.TextXAlignment = Enum.TextXAlignment.Left
    v7.Parent = Frame
    v7.Position = UDim2.fromOffset(16, 36)
    v7.Size = UDim2.new(1, -60, 0, 16)
    v6 = u77
    v7 = Instance.new("TextButton")
    v7.BackgroundColor3 = v6
    v7.Text = "x"
    v7.TextColor3 = u97
    v7.FontFace = u60.Font.Medium
    v7.TextSize = 13
    v7.AutoButtonColor = true
    v7.BorderSizePixel = 0

    if Frame then
        v7.Parent = Frame
    end

    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.CornerRadius = UDim.new(0, 6)
    UICorner_2.Parent = v7
    v7.AnchorPoint = Vector2.new(1, 0)
    v7.Position = UDim2.new(1, -12, 0, 12)
    v7.Size = UDim2.fromOffset(30, 30)
    local v8 = u97
    local u142 = Instance.new("TextLabel")
    u142.BackgroundTransparency = 1
    u142.Text = ""
    u142.TextColor3 = v8
    u142.FontFace = u60.Font.Regular
    u142.TextSize = 15
    u142.TextXAlignment = Enum.TextXAlignment.Left
    u142.Parent = ScreenGui
    u142.AnchorPoint = Vector2.new(0.5, 1)
    u142.Position = UDim2.new(0.5, 0, 1, -150)
    u142.Size = UDim2.fromOffset(600, 22)
    u142.TextXAlignment = Enum.TextXAlignment.Center
    u142.FontFace = u60.Font.Medium
    u142.TextStrokeTransparency = 0.5
    u142.TextTransparency = 1

    local function showToast(a1, a2)
        -- Line: 159
        -- upvalues: u142 (val), TweenService (upval)
        -- types: a1: string, a2: boolean
        u142.Text = a1
        local v1 = if not a2 then
            Color3.fromRGB(235, 120, 120)
        else
            Color3.fromRGB(140, 220, 150)
        u142.TextColor3 = v1
        u142.TextTransparency = 0

        TweenService:Create(
            u142,
            TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 4),
            {TextTransparency = 1}
        ):Play()
    end

    local function scroller(a1) -- Line: 170; types: a1: userdata
        local ScrollingFrame = Instance.new("ScrollingFrame")
        ScrollingFrame.BackgroundTransparency = 1
        ScrollingFrame.BorderSizePixel = 0
        ScrollingFrame.ScrollBarThickness = 6
        ScrollingFrame.CanvasSize = UDim2.new()
        ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        ScrollingFrame.Parent = a1
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Padding = UDim.new(0, 4)
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Parent = ScrollingFrame

        return ScrollingFrame
    end

    local v9 = scroller(Frame)
    v9.Position = UDim2.fromOffset(16, 64)
    v9.Size = UDim2.new(0, 240, 1, -80)
    v9.BackgroundColor3 = u72
    v9.BackgroundTransparency = 0.3
    local UICorner_3 = Instance.new("UICorner")
    UICorner_3.CornerRadius = UDim.new(0, 8)
    UICorner_3.Parent = v9
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 8)
    UIPadding.PaddingBottom = UDim.new(0, 8)
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.PaddingRight = UDim.new(0, 8)
    UIPadding.Parent = v9
    local u217 = scroller(Frame)
    u217.AnchorPoint = Vector2.new(1, 0)
    u217.Position = UDim2.new(1, -16, 0, 64)
    u217.Size = UDim2.new(1, -280, 1, -80)
    local u234 = {}
    local u235 = {}
    local u236 = false

    local function chip(a1, a2, a3, a4)
        -- Line: 214
        -- upvalues: u82 (upval), u77 (upval), u97 (upval), u60 (upval)
        -- types: a1: string, a2: number, a3: boolean, a4: function
        local v1 = Instance.new("TextButton")
        v1.BackgroundColor3 = if not a3 then u77 else u82
        v1.Text = a1
        v1.TextColor3 = u97
        v1.FontFace = u60.Font.Medium
        v1.TextSize = 13
        v1.AutoButtonColor = true
        v1.BorderSizePixel = 0
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = v1
        v1.Size = UDim2.fromOffset(0, u60.tap(26))
        v1.AutomaticSize = Enum.AutomaticSize.X
        v1.LayoutOrder = a2
        v1.TextSize = u60.tapText(12)
        local UIPadding = Instance.new("UIPadding")
        UIPadding.PaddingLeft = UDim.new(0, 10)
        UIPadding.PaddingRight = UDim.new(0, 10)
        UIPadding.Parent = v1

        v1.Activated:Connect(a4)

        return v1
    end

    local function choicesFor(a1)
        -- Line: 228
        -- upvalues: u116 (upval), Config (upval), ServerEvents (upval), Players (upval)
        -- types: a1: string
        local v1

        if a1 == "item" then
            return u116
        end

        if a1 == "block" then
            v1 = {}

            for i7 in Config.Build.Blocks do
                table.insert(v1, i7)
            end

            table.sort(v1)

            return v1
        end

        if a1 == "onoff" then
            return {"on", "off"}
        end

        if a1 == "weather" then
            return table.clone(Config.Weather.Order)
        end

        if a1 == "mob" then
            v1 = {}

            for i6 in Config.Enemy.Enemies do
                table.insert(v1, i6)
            end

            table.sort(v1)

            return v1
        end

        if a1 == "event" then
            v1 = ServerEvents.ids(ServerEvents.targets(Config.Tool, Config.Crop, Config.Bush, Config.Enemy))
            table.insert(v1, 1, "stop")

            return v1
        end

        if a1 == "achievement" then
            v1 = {}

            for m, i5 in Config.Achievement.Families do
                table.insert(v1, i5.id)
            end

            return v1
        end

        if a1 == "ore" then
            return table.clone(Config.AdminFun.Meteor.Types)
        end

        if a1 == "pass" then
            v1 = {}

            for k, n in Config.Monetization.Products do
                if n.kind == "Pass" then
                    table.insert(v1, k)
                end
            end

            table.sort(v1)

            return v1
        end

        if a1 ~= "player" then
            return nil
        end

        v1 = {}

        for i, j in Players:GetPlayers() do
            table.insert(v1, j.Name)
        end

        table.sort(v1)

        return v1
    end

    local u240 = {guestbook = GuestBookController.preview}

    local function send(a1) -- Line: 290; upvalues: u240 (val), u234 (ref), u105 (upval)
        local v1
        local v2 = u240[a1.name]

        if v2 then
            v2()
            return
        end

        v2 = {}

        for i in a1.args do
            v1 = u234[i]

            if not v1 then
                break
            end

            table.insert(v2, v1)
        end

        u105:FireServer(a1.name, (table.concat(v2, " ")))
    end

    function renderDetail(a1)
        -- Line: 308
        -- upvalues: u217 (val), u102 (upval), u60 (upval), DevCommands (upval), u97 (upval), u234 (ref), u77 (upval)
        -- upvalues: u236 (ref), u92 (upval), u87 (upval), choicesFor (val), u235 (ref), u72 (upval), Palette (upval)
        -- upvalues: chip (val), renderDetail (ref), send (val)
        local Frame, Frame_2, UICorner_2, UICorner_3, UICorner_4, UIListLayout, UIListLayout_2, UIPadding,
            UIPadding_2, UIPadding_3, presets, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14

        for i, j in u217:GetChildren() do
            if j:IsA("GuiObject") then
                j:Destroy()
            end
        end

        if not a1 then
            v10 = u102
            v1 = Instance.new("TextLabel")
            v1.BackgroundTransparency = 1
            v1.Text = "Pick a command on the left."
            v1.TextColor3 = v10
            v1.FontFace = u60.Font.Regular
            v1.TextSize = 13
            v1.TextXAlignment = Enum.TextXAlignment.Left
            v1.Parent = u217
            v1.Size = UDim2.new(1, 0, 0, 20)

            return
        end

        v10 = DevCommands.signature(a1)
        local v15 = u97
        v1 = Instance.new("TextLabel")
        v1.BackgroundTransparency = 1
        v1.Text = v10
        v1.TextColor3 = v15
        v1.FontFace = u60.Font.Regular
        v1.TextSize = 16
        v1.TextXAlignment = Enum.TextXAlignment.Left
        v1.Parent = u217
        v1.FontFace = u60.Font.Bold
        v1.Size = UDim2.new(1, 0, 0, 22)
        v1.LayoutOrder = 0
        local desc = a1.desc
        v15 = u102
        v1 = Instance.new("TextLabel")
        v1.BackgroundTransparency = 1
        v1.Text = desc
        v1.TextColor3 = v15
        v1.FontFace = u60.Font.Regular
        v1.TextSize = 12
        v1.TextXAlignment = Enum.TextXAlignment.Left
        v1.Parent = u217
        v1.Size = UDim2.new(1, 0, 0, 32)
        v1.TextWrapped = true
        v1.TextYAlignment = Enum.TextYAlignment.Top
        v1.LayoutOrder = 1
        local u82 = nil

        local function refreshRun()
            -- Line: 332
            -- upvalues: a1 (val), u234 (upval), u82 (ref), u77 (upval), u236 (upval), u92 (upval), u87 (upval)
            local v1 = false

            for i, j in a1.args do
                if not j.optional and not u234[i] then
                    v1 = true
                end
            end

            if v1 then
                u82.Text = "Set required values"
                u82.BackgroundColor3 = u77
                u82.Active = false
                u82.AutoButtonColor = false

                return
            end

            if a1.destructive then
                u82.Text = if not u236 then "RUN" else "CLICK AGAIN TO CONFIRM"
                u82.BackgroundColor3 = u92
                u82.Active = true
                u82.AutoButtonColor = true

                return
            end

            u82.Text = "RUN"
            u82.BackgroundColor3 = u87
            u82.Active = true
            u82.AutoButtonColor = true
        end

        local v16 = nil
        local v17 = nil

        for k, n in a1.args, v16, v17 do
            Frame = Instance.new("Frame")
            Frame.Size = UDim2.fromScale(1, 0)
            Frame.AutomaticSize = Enum.AutomaticSize.Y
            Frame.BackgroundTransparency = 1
            Frame.LayoutOrder = 1 + k
            Frame.Parent = u217
            UIListLayout = Instance.new("UIListLayout")
            UIListLayout.Padding = UDim.new(0, 4)
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Parent = Frame
            v2 = ("%*%*"):format(n.name, if not n.optional then "" else "   (optional)")
            v3 = u102
            v14 = Instance.new("TextLabel")
            v14.BackgroundTransparency = 1
            v14.Text = v2
            v14.TextColor3 = v3
            v14.FontFace = u60.Font.Regular
            v14.TextSize = 12
            v14.TextXAlignment = Enum.TextXAlignment.Left
            v14.Parent = Frame
            v14.Size = UDim2.new(1, 0, 0, 16)
            v14.LayoutOrder = 0
            Frame_2 = Instance.new("Frame")
            Frame_2.Size = UDim2.fromScale(1, 0)
            Frame_2.AutomaticSize = Enum.AutomaticSize.Y
            Frame_2.BackgroundTransparency = 1
            Frame_2.LayoutOrder = 1
            Frame_2.Parent = Frame
            UIListLayout_2 = Instance.new("UIListLayout")
            UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
            UIListLayout_2.Wraps = true
            UIListLayout_2.Padding = UDim.new(0, 4)
            UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_2.Parent = Frame_2
            v3 = choicesFor(n.kind)

            if v3 then
                local u209 = {}
                local u210 = nil

                local function applyFilter() -- Line: 403; upvalues: u235 (upval), k (val), u209 (val), u210 (ref)
                    local v1
                    local v2 = string.lower(u235[k] or "")
                    local v3 = 0
                    local v4 = nil
                    local v5 = nil

                    for i, j in u209, v4, v5 do
                        v1 = true

                        if v2 ~= "" then
                            v1 = string.find(j.text, v2, 1, true) ~= nil
                        end

                        j.chip.Visible = v1

                        if v1 then
                            v3 = v3 + 1
                        end
                    end

                    if u210 then
                        u210.Text = ("Nothing matches \"%*\""):format(u235[k] or "")
                        u210.Visible = v3 == 0
                    end
                end

                if #v3 > 12 then
                    local TextBox = Instance.new("TextBox")
                    TextBox.Size = UDim2.new(1, 0, 0, u60.tap(26))
                    TextBox.BackgroundColor3 = u72
                    TextBox.TextColor3 = u97
                    TextBox.PlaceholderText = ("Filter %* %*s…"):format(#v3, n.name)
                    TextBox.PlaceholderColor3 = u102
                    TextBox.Text = u235[k] or ""
                    TextBox.FontFace = u60.Font.Regular
                    TextBox.TextSize = 13
                    TextBox.TextXAlignment = Enum.TextXAlignment.Left
                    TextBox.ClearTextOnFocus = false
                    TextBox.BorderSizePixel = 0
                    TextBox.LayoutOrder = 0
                    TextBox.Parent = Frame
                    UIPadding = Instance.new("UIPadding")
                    UIPadding.PaddingLeft = UDim.new(0, 8)
                    UIPadding.PaddingRight = UDim.new(0, 8)
                    UIPadding.Parent = TextBox
                    UICorner_2 = Instance.new("UICorner")
                    UICorner_2.CornerRadius = UDim.new(0, 4)
                    UICorner_2.Parent = TextBox
                    v14.LayoutOrder = -1

                    ;(TextBox:GetPropertyChangedSignal("Text")):Connect(function()
                        -- Line: 443
                        -- upvalues: u235 (upval), k (val), TextBox (val), applyFilter (val)
                        u235[k] = TextBox.Text
                        applyFilter()
                    end)
                end

                v7 = nil
                v8 = nil

                for i6, i7 in v3, v7, v8 do
                    v11 = if n.kind ~= "item" then i7 else Palette.displayName(i7)
                    v13 = u234[k] == i7
                    v12 = chip(
                        v11,
                        i6,
                        v13,
                        function()
                            -- Line: 454
                            -- upvalues: u234 (upval), k (val), i7 (val), u236 (upval), renderDetail (upval), a1 (val)
                            u234[k] = i7
                            u236 = false

                            renderDetail(a1)
                        end
                    )
                    v12.Parent = Frame_2

                    table.insert(
                        u209,
                        {chip = v12, text = string.lower(v11)}
                    )
                end

                v7 = u102
                v6 = Instance.new("TextLabel")
                v6.BackgroundTransparency = 1
                v6.Text = ""
                v6.TextColor3 = v7
                v6.FontFace = u60.Font.Regular
                v6.TextSize = 12
                v6.TextXAlignment = Enum.TextXAlignment.Left
                v6.Parent = Frame_2
                v6.Size = UDim2.new(1, 0, 0, 20)
                v6.LayoutOrder = #v3 + 1
                u210 = v6

                applyFilter()

                if n.kind == "player" and n.anyone then
                    local TextBox_2 = Instance.new("TextBox")
                    TextBox_2.Size = UDim2.new(1, 0, 0, u60.tap(28))
                    TextBox_2.BackgroundColor3 = u72
                    TextBox_2.TextColor3 = u97
                    TextBox_2.FontFace = u60.Font.Regular
                    TextBox_2.TextSize = 13
                    TextBox_2.TextXAlignment = Enum.TextXAlignment.Left
                    TextBox_2.PlaceholderText = "...or type any username or user id (they need not be online)"
                    TextBox_2.PlaceholderColor3 = u102
                    TextBox_2.ClearTextOnFocus = false
                    TextBox_2.Text = if not u234[k] then
                        ""
                    else
                        if table.find(v3, u234[k]) then "" else u234[k]
                    TextBox_2.LayoutOrder = 2
                    TextBox_2.Parent = Frame
                    UICorner_3 = Instance.new("UICorner")
                    UICorner_3.CornerRadius = UDim.new(0, 6)
                    UICorner_3.Parent = TextBox_2
                    UIPadding_2 = Instance.new("UIPadding")
                    UIPadding_2.PaddingLeft = UDim.new(0, 8)
                    UIPadding_2.Parent = TextBox_2

                    ;(TextBox_2:GetPropertyChangedSignal("Text")):Connect(function()
                        -- Line: 489
                        -- upvalues: TextBox_2 (val), u234 (upval), k (val), u236 (upval), refreshRun (val)
                        local v1 = string.match(TextBox_2.Text, "^%s*(%S+)%s*$")
                        u234[k] = v1
                        u236 = false

                        refreshRun()
                    end)
                end
            elseif n.kind ~= "number" then
                local TextBox_3 = Instance.new("TextBox")
                TextBox_3.Size = UDim2.new(1, 0, 0, u60.tap(28))
                TextBox_3.BackgroundColor3 = u72
                TextBox_3.TextColor3 = u97
                TextBox_3.FontFace = u60.Font.Regular
                TextBox_3.TextSize = 13
                TextBox_3.TextXAlignment = Enum.TextXAlignment.Left
                TextBox_3.PlaceholderText = ("type the %*..."):format(n.name)
                TextBox_3.ClearTextOnFocus = false
                TextBox_3.Text = u234[k] or ""
                TextBox_3.Parent = Frame_2
                UICorner_4 = Instance.new("UICorner")
                UICorner_4.CornerRadius = UDim.new(0, 6)
                UICorner_4.Parent = TextBox_3
                UIPadding_3 = Instance.new("UIPadding")
                UIPadding_3.PaddingLeft = UDim.new(0, 8)
                UIPadding_3.Parent = TextBox_3

                ;(TextBox_3:GetPropertyChangedSignal("Text")):Connect(function()
                    -- Line: 522
                    -- upvalues: u234 (upval), k (val), TextBox_3 (val), refreshRun (val)
                    u234[k] = if TextBox_3.Text == "" then nil else TextBox_3.Text
                    refreshRun()
                end)
            else
                presets = n.presets or {1, 10, 100}
                v4 = nil
                v5 = nil

                for m, i5 in presets, v4, v5 do
                    v9 = tostring(i5)
                    v11 = u234[k] == tostring(i5)
                    chip(
                        v9,
                        m,
                        v11,
                        function()
                            -- Line: 499
                            -- upvalues: u234 (upval), k (val), i5 (val), u236 (upval), renderDetail (upval), a1 (val)
                            u234[k] = (tostring(i5))
                            u236 = false

                            renderDetail(a1)
                        end
                    ).Parent = Frame_2
                end
            end
        end

        v15 = u87
        local TextButton = Instance.new("TextButton")
        TextButton.BackgroundColor3 = v15
        TextButton.Text = "RUN"
        TextButton.TextColor3 = u97
        TextButton.FontFace = u60.Font.Medium
        TextButton.TextSize = 13
        TextButton.AutoButtonColor = true
        TextButton.BorderSizePixel = 0

        if u217 then
            TextButton.Parent = u217
        end

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = TextButton
        u82 = TextButton
        u82.Size = UDim2.new(1, 0, 0, 38)
        u82.TextSize = 14
        u82.LayoutOrder = 100

        u82.Activated:Connect(function()
            -- Line: 533
            -- upvalues: u82 (ref), a1 (val), u236 (upval), refreshRun (val), send (upval)
            if not u82.Active then
                return
            end

            if a1.destructive and not u236 then
                u236 = true
                refreshRun()

                return
            end

            u236 = false
            send(a1)
            refreshRun()
        end)

        refreshRun()
    end

    local u245 = {}
    local v10 = 0

    local function selectCommand(a1)
        -- Line: 558
        -- upvalues: u234 (ref), u235 (ref), u236 (ref), u245 (val), u82 (upval), u77 (upval), renderDetail (ref)
        local v1
        u234 = {}
        u235 = {}
        u236 = false
        local v2 = nil
        local v3 = nil
        local v4 = a1

        for i, j in u245, v2, v3 do
            v1 = if i ~= v4.name then u77 else u82
            j.BackgroundColor3 = v1
        end

        renderDetail(v4)
    end

    for i, j in DevCommands.groups() do
        v10 = v10 + 1
        v2 = u102
        v1 = Instance.new("TextLabel")
        v1.BackgroundTransparency = 1
        v1.Text = j
        v1.TextColor3 = v2
        v1.FontFace = u60.Font.Regular
        v1.TextSize = 11
        v1.TextXAlignment = Enum.TextXAlignment.Left
        v1.Parent = v9
        v1.FontFace = u60.Font.Bold
        v1.Size = UDim2.new(1, 0, 0, 18)
        v1.LayoutOrder = v10
        v3 = nil
        v4 = nil

        for k, n in DevCommands.list, v3, v4 do
            if n.group == j then
                if not n.owner or LocalPlayer.UserId == Config.Player.OwnerUserId then
                    v10 = v10 + 1
                    name = n.name
                    v5 = u77
                    v1 = Instance.new("TextButton")
                    v1.BackgroundColor3 = v5
                    v1.Text = name
                    v1.TextColor3 = u97
                    v1.FontFace = u60.Font.Medium
                    v1.TextSize = 13
                    v1.AutoButtonColor = true
                    v1.BorderSizePixel = 0

                    if v9 then
                        v1.Parent = v9
                    end

                    UICorner_4 = Instance.new("UICorner")
                    UICorner_4.CornerRadius = UDim.new(0, 6)
                    UICorner_4.Parent = v1
                    v1.Size = UDim2.new(1, 0, 0, u60.tap(28))
                    v1.TextXAlignment = Enum.TextXAlignment.Left
                    UIPadding_2 = Instance.new("UIPadding")
                    UIPadding_2.PaddingLeft = UDim.new(0, 10)
                    UIPadding_2.Parent = v1
                    v1.LayoutOrder = v10
                    u245[n.name] = v1

                    v1.Activated:Connect(function() -- Line: 589; upvalues: selectCommand (val), n (val)
                        selectCommand(n)
                    end)
                end
            end
        end
    end

    renderDetail(nil)

    local function setChatVisible(a1) -- Line: 601; upvalues: TextChatService (upval); types: a1: boolean
        pcall(function() -- Line: 602; upvalues: TextChatService (upval), a1 (val)
            local ChatWindowConfiguration = TextChatService:FindFirstChild("ChatWindowConfiguration")

            if ChatWindowConfiguration then
                ChatWindowConfiguration.Enabled = a1
            end
        end)
    end

    local function close() -- Line: 610; upvalues: TextButton (val), TextChatService (upval)
        TextButton.Visible = false
        local u2 = true

        pcall(function() -- Line: 602; upvalues: TextChatService (upval), u2 (val)
            local ChatWindowConfiguration = TextChatService:FindFirstChild("ChatWindowConfiguration")

            if ChatWindowConfiguration then
                ChatWindowConfiguration.Enabled = u2
            end
        end)
    end

    v7.Activated:Connect(close)
    TextButton.Activated:Connect(close)

    ;(Remotes.get(Remotes.DevConsoleOpen)).OnClientEvent:Connect(function()
        -- Line: 618
        -- upvalues: TextButton (val), TextChatService (upval)
        TextButton.Visible = true
        local u2 = false

        pcall(function() -- Line: 602; upvalues: TextChatService (upval), u2 (val)
            local ChatWindowConfiguration = TextChatService:FindFirstChild("ChatWindowConfiguration")

            if ChatWindowConfiguration then
                ChatWindowConfiguration.Enabled = u2
            end
        end)
    end)

    local u291 = Instance.new("TextButton")
    u291.Name = "DevButton"
    u291.AnchorPoint = Vector2.new(0, 1)
    u291.Position = UDim2.new(0, 4, 1, -2)
    u291.Size = UDim2.fromOffset(u60.tap(24), u60.tap(16))
    u291.BackgroundTransparency = 1
    u291.AutoButtonColor = false
    u291.Text = "DC"
    u291.TextColor3 = Color3.new(1, 1, 1)
    u291.TextTransparency = 0.6
    u291.TextXAlignment = Enum.TextXAlignment.Left
    u291.TextYAlignment = Enum.TextYAlignment.Bottom
    u291.FontFace = u60.Font.Regular
    u291.TextSize = 10
    u291.Visible = false
    local ScreenGui_2 = Instance.new("ScreenGui")
    ScreenGui_2.Name = "DevShortcut"
    ScreenGui_2.ResetOnSpawn = false
    ScreenGui_2.DisplayOrder = 5
    ScreenGui_2.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    ScreenGui_2.Parent = ScreenGui.Parent
    u291.Parent = ScreenGui_2

    local function showDevButton()
        -- Line: 654
        -- upvalues: u291 (val), LocalPlayer (upval), Config (upval), TextButton (val)
        local v1 = false

        if LocalPlayer:GetAttribute(Config.Release.AdminAttribute) == true then
            v1 = not TextButton.Visible
        end

        u291.Visible = v1
    end

    local v11 = false

    if LocalPlayer:GetAttribute(Config.Release.AdminAttribute) == true then
        v11 = not TextButton.Visible
    end

    u291.Visible = v11
    ;(LocalPlayer:GetAttributeChangedSignal(Config.Release.AdminAttribute)):Connect(showDevButton)
    ;(TextButton:GetPropertyChangedSignal("Visible")):Connect(showDevButton)

    u291.Activated:Connect(function() -- Line: 660; upvalues: TextButton (val), TextChatService (upval)
        TextButton.Visible = true
        local u2 = false

        pcall(function() -- Line: 602; upvalues: TextChatService (upval), u2 (val)
            local ChatWindowConfiguration = TextChatService:FindFirstChild("ChatWindowConfiguration")

            if ChatWindowConfiguration then
                ChatWindowConfiguration.Enabled = u2
            end
        end)
    end)

    ;(Remotes.get(Remotes.DevCommandResult)).OnClientEvent:Connect(function(a1, a2)
        -- Line: 665
        -- upvalues: showToast (val)
        -- types: a1: boolean, a2: string
        showToast(tostring(a2), a1 == true)
    end)

    local u389 = false

    local function makeChatCommands()
        -- Line: 677
        -- upvalues: LocalPlayer (upval), Config (upval), u389 (ref), TextChatService (upval), u105 (upval)
        -- upvalues: DevCommands (upval)
        local v1 = LocalPlayer:GetAttribute(Config.Release.AdminAttribute) == true
        local v2 = LocalPlayer:GetAttribute(Config.Player.ModAttribute) == true

        if u389 then
            return
        end

        if not v1 and not v2 then
            return
        end

        u389 = true

        local function make(a1) -- Line: 684; upvalues: TextChatService (upval), u105 (upval); types: a1: string
            local TextChatCommand = Instance.new("TextChatCommand")
            TextChatCommand.Name = ("Dev_%*"):format(a1)
            TextChatCommand.PrimaryAlias = ("/%*"):format(a1)
            TextChatCommand.Parent = TextChatService

            TextChatCommand.Triggered:Connect(function(a1_2, a2)
                -- Line: 689
                -- upvalues: u105 (upval), a1 (val)
                -- types: a1_2: userdata, a2: string
                local v1 = string.match(a2, "^%S+%s+(.*)$")
                u105:FireServer(a1, if not v1 then nil else if v1 == "" then nil else v1)
            end)
        end

        local v3 = nil
        local v4 = nil

        for i, j in DevCommands.list, v3, v4 do
            if v1 or j.mod then
                if not j.owner or LocalPlayer.UserId == Config.Player.OwnerUserId then
                    make(j.name)
                end
            end
        end

        if v1 then
            local TextChatCommand = Instance.new("TextChatCommand")
            TextChatCommand.Name = "Dev_devconsole"
            TextChatCommand.PrimaryAlias = "/devconsole"
            TextChatCommand.Parent = TextChatService
            local Triggered = TextChatCommand.Triggered
            local u43 = "devconsole"

            Triggered:Connect(function(a1, a2)
                -- Line: 689
                -- upvalues: u105 (upval), u43 (val)
                -- types: a1: userdata, a2: string
                local v1 = string.match(a2, "^%S+%s+(.*)$")
                u105:FireServer(u43, if not v1 then nil else if v1 == "" then nil else v1)
            end)
        end
    end

    makeChatCommands()
    ;(LocalPlayer:GetAttributeChangedSignal(Config.Release.AdminAttribute)):Connect(makeChatCommands)
    ;(LocalPlayer:GetAttributeChangedSignal(Config.Player.ModAttribute)):Connect(makeChatCommands)

    RunService.RenderStepped:Connect(function() -- Line: 712; upvalues: TextButton (val), UserInputService (upval)
        if TextButton.Visible then
            UserInputService.MouseIconEnabled = true

            if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            end
        end
    end)

    UserInputService.InputBegan:Connect(function(a1, a2)
        -- Line: 721
        -- upvalues: TextButton (val), TextChatService (upval)
        if not a2 and a1.KeyCode == Enum.KeyCode.Escape and TextButton.Visible then
            TextButton.Visible = false
            local u8 = true

            pcall(function() -- Line: 602; upvalues: TextChatService (upval), u8 (val)
                local ChatWindowConfiguration = TextChatService:FindFirstChild("ChatWindowConfiguration")

                if ChatWindowConfiguration then
                    ChatWindowConfiguration.Enabled = u8
                end
            end)
        end
    end)
end

return v1