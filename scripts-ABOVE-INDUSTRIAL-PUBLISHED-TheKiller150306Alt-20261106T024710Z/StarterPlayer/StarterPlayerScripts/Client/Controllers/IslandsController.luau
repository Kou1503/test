-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.IslandsController
-- Decompile time: 26.50 ms

local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Remotes = require(Shared.Remotes)
local SignText = require(Shared.SignText)
local CoopLedger = require(Shared.CoopLedger)
local u34 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local IslandPermissionsController = require(script.Parent.IslandPermissionsController)
local u45 = {}
local LocalPlayer = Players.LocalPlayer
local u50 = Remotes.get(Remotes.RequestIslands)
local u53 = Remotes.get(Remotes.RequestIslandAction)
local u56 = Remotes.get(Remotes.RequestFriendList)
local u57 = nil
local u58 = nil
local u59 = nil
local u60 = nil
local u61 = nil
local u62 = {}
local u63 = nil
local u64 = "permissions"
local u65 = nil
local u66 = false
local u67 = {}
local u68 = false
local u69 = nil
local u70 = ""

function u45.isOpen() -- Line: 121; upvalues: u58 (ref)
    local Visible = false

    if u58 ~= nil then
        Visible = u58.Visible
    end

    return Visible
end

local function act(a1, a2, a3, a4) -- Line: 128; upvalues: u53 (val); types: a1: string
    u53:FireServer(a1, a2, a3, a4)
end

local function label(a1, a2, a3, a4, a5)
    -- Line: 132
    -- upvalues: u34 (val)
    -- types: a1: userdata, a2: string, a3: number, a4: userdata, a5: boolean
    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = a2
    TextLabel.TextColor3 = a4
    TextLabel.TextSize = a3
    local Bold = if not a5 then u34.Font.Regular else u34.Font.Bold
    TextLabel.FontFace = Bold
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
    TextLabel.Parent = a1

    return TextLabel
end

local function button(a1, a2, a3, a4, a5)
    -- Line: 145
    -- upvalues: u34 (val)
    -- types: a1: userdata, a2: string, a3: number, a4: userdata, a5: userdata
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromOffset(a3, u34.tap(26))
    TextButton.BackgroundColor3 = a4
    TextButton.BorderSizePixel = 0
    TextButton.Text = a2
    TextButton.TextColor3 = a5
    TextButton.TextSize = u34.tapText(12)
    TextButton.FontFace = u34.Font.Bold
    TextButton.AutoButtonColor = true
    TextButton.Parent = a1

    u34.corner(TextButton, 5)

    return TextButton
end

local function setStatus(a1, a2) -- Line: 160; upvalues: u60 (ref), u34 (val); types: a1: string, a2: userdata?
    u60.Text = a1
    u60.TextColor3 = a2 or u34.Palette.Dim
end

local function clearBody() -- Line: 165; upvalues: u59 (ref)
    for i, j in u59:GetChildren() do
        if not j:IsA("UIListLayout") then
            j:Destroy()
        end
    end
end

local function closeOverlay() -- Line: 178; upvalues: u69 (ref), u61 (ref)
    u69 = nil
    u61.Visible = false

    for i, j in u61:GetChildren() do
        if not j:IsA("UICorner") then
            j:Destroy()
        end
    end
end

local function dialog(a1, a2) -- Line: 193; upvalues: u58 (ref), u34 (val), u61 (ref); types: a1: number, a2: number
    local v1 = math.min(a2, u58.Size.Y.Offset - 16)
    return u34.modalCard(u61, UDim2.fromOffset(a1, v1), UDim2.new(0.5, -a1 / 2, 0.5, -v1 / 2))
end

local function openRename(a1, a2, a3)
    -- Line: 198
    -- upvalues: closeOverlay (val), u61 (ref), u58 (ref), u34 (val), SignText (val), button (val)
    -- types: a1: string, a2: string, a3: function
    closeOverlay()

    u61.Visible = true
    local v1 = math.min(168, u58.Size.Y.Offset - 16)
    local v2 = u34.modalCard(u61, UDim2.fromOffset(360, v1), UDim2.new(0.5, -180, 0.5, -v1 / 2))
    local Text = u34.Palette.Text
    v1 = Instance.new("TextLabel")
    v1.BackgroundTransparency = 1
    v1.Text = a1
    v1.TextColor3 = Text
    v1.TextSize = 15
    v1.FontFace = u34.Font.Bold
    v1.TextXAlignment = Enum.TextXAlignment.Left
    v1.TextTruncate = Enum.TextTruncate.AtEnd
    v1.Parent = v2
    v1.Size = UDim2.new(1, -28, 0, 20)
    v1.Position = UDim2.fromOffset(14, 14)
    local v3 = ("Letters, digits, spaces and punctuation. Up to %*."):format(SignText.MaxLength)
    local Faint = u34.Palette.Faint
    v1 = Instance.new("TextLabel")
    v1.BackgroundTransparency = 1
    v1.Text = v3
    v1.TextColor3 = Faint
    v1.TextSize = 12
    v1.FontFace = u34.Font.Regular
    v1.TextXAlignment = Enum.TextXAlignment.Left
    v1.TextTruncate = Enum.TextTruncate.AtEnd
    v1.Parent = v2
    v1.Size = UDim2.new(1, -28, 0, 16)
    v1.Position = UDim2.fromOffset(14, 36)
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1, -28, 0, u34.tap(34))
    TextBox.Position = UDim2.fromOffset(14, 62)
    TextBox.BackgroundColor3 = Color3.fromRGB(34, 37, 46)
    TextBox.BorderSizePixel = 0
    TextBox.Text = a2
    TextBox.PlaceholderText = "ISLAND NAME"
    TextBox.TextColor3 = u34.Palette.Text
    TextBox.PlaceholderColor3 = u34.Palette.Dim
    TextBox.TextSize = 14
    TextBox.FontFace = u34.Font.Bold
    TextBox.TextXAlignment = Enum.TextXAlignment.Left
    TextBox.ClearTextOnFocus = false
    TextBox.Parent = v2

    u34.corner(TextBox, 5)

    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.Parent = TextBox

    ;(TextBox:GetPropertyChangedSignal("Text")):Connect(function()
        -- Line: 236
        -- upvalues: SignText (upval), TextBox (val)
        local v1 = SignText.sanitize(TextBox.Text)

        if v1 ~= TextBox.Text then
            TextBox.Text = v1
        end
    end)

    v3 = button(v2, "SAVE", 100, u34.Palette.Gold, Color3.fromRGB(28, 24, 12))
    v3.Position = UDim2.new(1, -114, 1, -40)

    v3.Activated:Connect(function()
        -- Line: 245
        -- upvalues: a3 (val), SignText (upval), TextBox (val), closeOverlay (upval)
        a3(SignText.sanitize(TextBox.Text))
        closeOverlay()
    end)

    v3 = button(v2, "CANCEL", 90, Color3.fromRGB(44, 48, 60), u34.Palette.Text)
    v3.Position = UDim2.new(0, 14, 1, -40)

    v3.Activated:Connect(closeOverlay)
    TextBox:CaptureFocus()
end

local function renderPicker()
    -- Line: 258
    -- upvalues: u69 (ref), u61 (ref), u58 (ref), u34 (val), u63 (ref), u70 (ref), button (val), closeOverlay (val)
    -- upvalues: u68 (ref), u67 (ref), u53 (val)
    if not u69 then
        return
    end

    local u1 = u69

    for i, j in u61:GetChildren() do
        if not j:IsA("UICorner") then
            j:Destroy()
        end
    end

    local v1 = math.min(380, u58.Size.Y.Offset - 16)
    local v2 = u34.modalCard(u61, UDim2.fromOffset(420, v1), UDim2.new(0.5, -210, 0.5, -v1 / 2))
    local asWritten = u34.asWritten
    local v3 = ("INVITE TO %*"):format(u1.name)
    local Text = u34.Palette.Text
    local v4 = Instance.new("TextLabel")
    v4.BackgroundTransparency = 1
    v4.Text = v3
    v4.TextColor3 = Text
    v4.TextSize = 15
    v4.FontFace = u34.Font.Bold
    v4.TextXAlignment = Enum.TextXAlignment.Left
    v4.TextTruncate = Enum.TextTruncate.AtEnd
    v4.Parent = v2
    v1 = asWritten(v4)
    v1.Size = UDim2.new(1, -28, 0, 20)
    v1.Position = UDim2.fromOffset(14, 14)
    v1 = #u1.members + #u1.invites
    local v5 = ("%* of %* seats taken"):format(v1, if not u63 then v1 else u63.maxMembers)
    local Faint = u34.Palette.Faint
    v3 = Instance.new("TextLabel")
    v3.BackgroundTransparency = 1
    v3.Text = v5
    v3.TextColor3 = Faint
    v3.TextSize = 12
    v3.FontFace = u34.Font.Regular
    v3.TextXAlignment = Enum.TextXAlignment.Left
    v3.TextTruncate = Enum.TextTruncate.AtEnd
    v3.Parent = v2
    v3.Size = UDim2.new(1, -28, 0, 16)
    v3.Position = UDim2.fromOffset(14, 36)
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1, -28, 0, u34.tap(28))
    TextBox.Position = UDim2.fromOffset(14, 58)
    TextBox.BackgroundColor3 = Color3.fromRGB(34, 37, 46)
    TextBox.BorderSizePixel = 0
    TextBox.Text = u70
    TextBox.PlaceholderText = "Search friends"
    TextBox.TextColor3 = u34.Palette.Text
    TextBox.PlaceholderColor3 = u34.Palette.Dim
    TextBox.TextSize = 13
    TextBox.FontFace = u34.Font.Regular
    TextBox.TextXAlignment = Enum.TextXAlignment.Left
    TextBox.ClearTextOnFocus = false
    TextBox.Parent = v2

    u34.corner(TextBox, 5)

    v4 = Instance.new("UIPadding")
    v4.PaddingLeft = UDim.new(0, 8)
    v4.Parent = TextBox
    local u166 = Instance.new("ScrollingFrame")
    u166.Size = UDim2.new(1, -28, 1, -(140 + u34.tap(28) - 28))
    u166.Position = UDim2.fromOffset(14, 92 + u34.tap(28) - 28)
    u166.BackgroundTransparency = 1
    u166.BorderSizePixel = 0
    u166.ScrollBarThickness = 4
    u166.ScrollBarImageColor3 = u34.Palette.Stroke
    u166.CanvasSize = UDim2.new()
    u166.AutomaticCanvasSize = Enum.AutomaticSize.Y
    u166.Parent = v2
    v1 = Instance.new("UIListLayout")
    v1.Padding = UDim.new(0, 6)
    v1.SortOrder = Enum.SortOrder.LayoutOrder
    v1.Parent = u166
    v1 = button(v2, "DONE", 90, Color3.fromRGB(44, 48, 60), u34.Palette.Text)
    v1.Position = UDim2.new(1, -104, 1, -38)

    v1.Activated:Connect(closeOverlay)

    local function fill()
        -- Line: 323
        -- upvalues: u166 (val), u68 (upval), u34 (upval), u70 (upval), u67 (upval), u1 (val), button (upval)
        -- upvalues: u53 (upval)
        local Frame, Text, asWritten, displayName, v1, v2, v3, v4

        for i, j in u166:GetChildren() do
            if not j:IsA("UIListLayout") then
                j:Destroy()
            end
        end

        if u68 then
            local Faint = u34.Palette.Faint
            v1 = Instance.new("TextLabel")
            v1.BackgroundTransparency = 1
            v1.Text = "Looking up your friends..."
            v1.TextColor3 = Faint
            v1.TextSize = 13
            v1.FontFace = u34.Font.Regular
            v1.TextXAlignment = Enum.TextXAlignment.Left
            v1.TextTruncate = Enum.TextTruncate.AtEnd
            v1.Parent = u166
            v1.Size = UDim2.new(1, 0, 0, 30)

            return
        end

        v1 = 0
        local v5 = string.lower(u70)
        local v6 = nil
        local v7 = nil

        for k, n in u67, v6, v7 do
            v3 = false
            v4 = nil
            v2 = nil

            for m, i5 in u1.members, v4, v2 do
                v3 = v3 or i5.userId == n.userId
            end

            v4 = nil
            v2 = nil

            for i6, i7 in u1.invites, v4, v2 do
                v3 = v3 or i7.userId == n.userId
            end

            if not v3 then
                if v5 == "" then
                    v1 = v1 + 1
                    Frame = Instance.new("Frame")
                    Frame.Size = UDim2.new(1, -6, 0, 34)
                    Frame.BackgroundColor3 = Color3.fromRGB(68, 74, 90)
                    Frame.BorderSizePixel = 0
                    Frame.LayoutOrder = v1
                    Frame.Parent = u166

                    u34.corner(Frame, 5)

                    asWritten = u34.asWritten
                    displayName = n.displayName
                    Text = u34.Palette.Text
                    v2 = Instance.new("TextLabel")
                    v2.BackgroundTransparency = 1
                    v2.Text = displayName
                    v2.TextColor3 = Text
                    v2.TextSize = 13
                    v2.FontFace = u34.Font.Bold
                    v2.TextXAlignment = Enum.TextXAlignment.Left
                    v2.TextTruncate = Enum.TextTruncate.AtEnd
                    v2.Parent = Frame
                    v4 = asWritten(v2)
                    v4.Size = UDim2.new(1, -110, 1, 0)
                    v4.Position = UDim2.fromOffset(10, 0)
                    v4 = button(Frame, "INVITE", 78, u34.Palette.Green, Color3.fromRGB(14, 30, 18))
                    v4.Position = UDim2.new(1, -86, 0.5, -13)

                    v4.Activated:Connect(function() -- Line: 376; upvalues: u1 (upval), n (val), u53 (upval)
                        local slot = u1.slot
                        local userId = n.userId

                        u53:FireServer("invite", slot, userId, nil)
                    end)
                else
                    v3 = true

                    if string.find(string.lower(n.displayName), v5, 1, true) == nil then
                        v3 = string.find(string.lower(n.name), v5, 1, true) ~= nil
                    end

                    if v3 then
                        v1 = v1 + 1
                        Frame = Instance.new("Frame")
                        Frame.Size = UDim2.new(1, -6, 0, 34)
                        Frame.BackgroundColor3 = Color3.fromRGB(68, 74, 90)
                        Frame.BorderSizePixel = 0
                        Frame.LayoutOrder = v1
                        Frame.Parent = u166

                        u34.corner(Frame, 5)

                        asWritten = u34.asWritten
                        displayName = n.displayName
                        Text = u34.Palette.Text
                        v2 = Instance.new("TextLabel")
                        v2.BackgroundTransparency = 1
                        v2.Text = displayName
                        v2.TextColor3 = Text
                        v2.TextSize = 13
                        v2.FontFace = u34.Font.Bold
                        v2.TextXAlignment = Enum.TextXAlignment.Left
                        v2.TextTruncate = Enum.TextTruncate.AtEnd
                        v2.Parent = Frame
                        v4 = asWritten(v2)
                        v4.Size = UDim2.new(1, -110, 1, 0)
                        v4.Position = UDim2.fromOffset(10, 0)
                        v4 = button(Frame, "INVITE", 78, u34.Palette.Green, Color3.fromRGB(14, 30, 18))
                        v4.Position = UDim2.new(1, -86, 0.5, -13)

                        v4.Activated:Connect(function() -- Line: 376; upvalues: u1 (upval), n (val), u53 (upval)
                            local slot = u1.slot
                            local userId = n.userId

                            u53:FireServer("invite", slot, userId, nil)
                        end)
                    end
                end
            end
        end

        if v1 == 0 then
            local Faint_2 = u34.Palette.Faint
            v5 = Instance.new("TextLabel")
            v5.BackgroundTransparency = 1
            v5.Text = "Nobody left to invite here."
            v5.TextColor3 = Faint_2
            v5.TextSize = 13
            v5.FontFace = u34.Font.Regular
            v5.TextXAlignment = Enum.TextXAlignment.Left
            v5.TextTruncate = Enum.TextTruncate.AtEnd
            v5.Parent = u166
            v5.Size = UDim2.new(1, 0, 0, 30)
        end
    end

    ;(TextBox:GetPropertyChangedSignal("Text")):Connect(function()
        -- Line: 387
        -- upvalues: u70 (upval), TextBox (val), fill (val)
        u70 = TextBox.Text
        fill()
    end)

    fill()
end

local function openPicker(a1)
    -- Line: 394
    -- upvalues: closeOverlay (val), u69 (ref), u70 (ref), u61 (ref), u67 (ref), u68 (ref), u56 (val)
    -- upvalues: renderPicker (val)
    -- types: a1: table
    closeOverlay()

    u69 = a1
    u70 = ""
    u61.Visible = true

    if #u67 == 0 then
        u68 = true
        u56:FireServer()
    end

    renderPicker()
end

local function drawSlotCard(a1, a2)
    -- Line: 407
    -- upvalues: u59 (ref), u34 (val), button (val), u53 (val), openRename (val)
    -- types: a1: table, a2: number
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.5, -6, 0, 116)
    local v1 = if not a1.current then
        Color3.fromRGB(40, 44, 55)
    else
        Color3.fromRGB(38, 56, 45)
    Frame.BackgroundColor3 = v1
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = a2
    Frame.Parent = u59

    u34.corner(Frame, 8)
    u34.stroke(Frame, if not a1.current then u34.Palette.Stroke else u34.Palette.Green, if not a1.current then 1 else 2)

    local name = if a1.name == "" then ("ISLAND %*"):format(a1.slot) else a1.name
    local Text = u34.Palette.Text
    v1 = Instance.new("TextLabel")
    v1.BackgroundTransparency = 1
    v1.Text = name
    v1.TextColor3 = Text
    v1.TextSize = 15
    v1.FontFace = u34.Font.Bold
    v1.TextXAlignment = Enum.TextXAlignment.Left
    v1.TextTruncate = Enum.TextTruncate.AtEnd
    v1.Parent = Frame

    if a1.name ~= "" then
        u34.asWritten(v1)
    end

    v1.Size = UDim2.new(1, -100, 0, 20)
    v1.Position = UDim2.fromOffset(14, 14)
    local Faint = u34.Palette.Faint
    local v2 = Instance.new("TextLabel")
    v2.BackgroundTransparency = 1
    v2.Text = ""
    v2.TextColor3 = Faint
    v2.TextSize = 11
    v2.FontFace = u34.Font.Bold
    v2.TextXAlignment = Enum.TextXAlignment.Left
    v2.TextTruncate = Enum.TextTruncate.AtEnd
    v2.Parent = Frame
    v2.Size = UDim2.fromOffset(88, 18)
    v2.Position = UDim2.new(1, -100, 0, 14)
    v2.TextXAlignment = Enum.TextXAlignment.Right
    local Dim = u34.Palette.Dim
    local v3 = Instance.new("TextLabel")
    v3.BackgroundTransparency = 1
    v3.Text = ""
    v3.TextColor3 = Dim
    v3.TextSize = 12
    v3.FontFace = u34.Font.Regular
    v3.TextXAlignment = Enum.TextXAlignment.Left
    v3.TextTruncate = Enum.TextTruncate.AtEnd
    v3.Parent = Frame
    v3.Size = UDim2.new(1, -28, 0, 32)
    v3.Position = UDim2.fromOffset(14, 38)
    v3.TextYAlignment = Enum.TextYAlignment.Top
    v3.TextWrapped = true

    if not a1.unlocked then
        local v4
        Frame.BackgroundColor3 = Color3.fromRGB(32, 34, 43)
        v1.TextColor3 = u34.Palette.Faint
        v2.Text = "LOCKED"
        v2.TextColor3 = u34.Palette.Violet

        if a1.price then
            v3.Text = ("%*. Its own world, inventory and achievements."):format(a1.productName or "Another island")
            v4 = button(Frame, ("BUY  R$ %*"):format(a1.price), 130, u34.Palette.Violet, Color3.fromRGB(24, 18, 40))
            v4.Position = UDim2.new(0, 14, 1, -38)

            v4.Activated:Connect(function() -- Line: 453; upvalues: a1 (val), u53 (upval)
                local productId = a1.productId
                u53:FireServer("buy", productId, nil, nil)
            end)

            return
        end

        v3.Text = ("%*. Not on sale yet."):format(a1.productName or "Another island")
        v4 = button(Frame, "COMING SOON", 130, Color3.fromRGB(52, 55, 68), u34.Palette.Dim)
        v4.Position = UDim2.new(0, 14, 1, -38)
        v4.AutoButtonColor = false

        return
    end

    if a1.current then
        v2.Text = "PLAYING"
        v2.TextColor3 = u34.Palette.Green
        v3.Text = "You're on this island now."
    elseif not a1.used then
        v2.Text = "NEW"
        v2.TextColor3 = u34.Palette.Gold
        v3.Text = "Empty. Starts from a fresh island with nothing carried over."
    else
        v3.Text = "Saved and waiting. Switching saves this island first."
    end

    if not a1.current then
        v3 = button(Frame, "PLAY", 96, u34.Palette.Gold, Color3.fromRGB(28, 24, 12))
        v3.Position = UDim2.new(0, 14, 1, -38)

        v3.Activated:Connect(function() -- Line: 482; upvalues: a1 (val), u53 (upval)
            local slot = a1.slot
            u53:FireServer("play", slot, nil, nil)
        end)
    end

    v2 = button(Frame, "RENAME", 90, Color3.fromRGB(40, 43, 54), u34.Palette.Dim)
    v2.Position = UDim2.new(1, -104, 1, -38)

    v2.Activated:Connect(function() -- Line: 489; upvalues: openRename (upval), a1 (val), u53 (upval)
        openRename(
            ("NAME ISLAND %*"):format(a1.slot),
            a1.name,
            function(a1_2) -- Line: 490; upvalues: a1 (upval), u53 (upval)
                local slot = a1.slot
                u53:FireServer("rename", slot, a1_2, nil)
            end
        )
    end)
end

local function drawPersonChip(a1, a2, a3, a4, a5)
    -- Line: 497
    -- upvalues: u34 (val)
    -- types: a1: userdata, a2: table, a3: number, a4: boolean, a5: function?
    local Frame = Instance.new("Frame")
    local fromOffset = UDim2.fromOffset
    local v1 = if not a5 then 0 else 20
    Frame.Size = fromOffset((math.min(150, #a2.name * 7 + 34)) + v1, 24)
    local v2 = if not a4 then Color3.fromRGB(32, 38, 34) else Color3.fromRGB(38, 36, 30)
    Frame.BackgroundColor3 = v2
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = a3
    Frame.Parent = a1

    u34.corner(Frame, 12)

    local asWritten = u34.asWritten
    local name_2 = a2.name
    local Gold = if not a4 then u34.Palette.Text else u34.Palette.Gold
    local v3 = Instance.new("TextLabel")
    v3.BackgroundTransparency = 1
    v3.Text = name_2
    v3.TextColor3 = Gold
    v3.TextSize = 12
    v3.FontFace = u34.Font.Regular
    v3.TextXAlignment = Enum.TextXAlignment.Left
    v3.TextTruncate = Enum.TextTruncate.AtEnd
    v3.Parent = Frame
    v2 = asWritten(v3)
    v2.Size = UDim2.new(1, if not a5 then -18 else -30, 1, 0)
    v2.Position = UDim2.fromOffset(10, 0)

    if a5 then
        local TextButton = Instance.new("TextButton")
        TextButton.Size = UDim2.fromOffset(u34.tap(18), u34.tap(18))
        TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
        TextButton.Position = UDim2.new(1, -13, 0.5, 0)
        TextButton.BackgroundTransparency = 1
        TextButton.Text = "X"
        TextButton.TextColor3 = u34.Palette.Red
        TextButton.TextSize = 12
        TextButton.FontFace = u34.Font.Bold
        TextButton.Parent = Frame

        TextButton.Activated:Connect(a5)
    end
end

local function drawCoopCard(a1, a2, a3)
    -- Line: 529
    -- upvalues: CoopLedger (val), u59 (ref), u34 (val), drawPersonChip (val), u53 (val), button (val)
    -- upvalues: closeOverlay (val), u69 (ref), u70 (ref), u61 (ref), u67 (ref), u68 (ref), u56 (val)
    -- upvalues: renderPicker (val), openRename (val), LocalPlayer (val)
    -- types: a1: table, a2: table, a3: number
    local isOwner, v1, v2, v3
    local v4 = {}

    for i, j in a1.recent or {} do
        v3 = CoopLedger.sanitize(j)

        if v3 then
            table.insert(v4, v3)
        end
    end

    local v5 = if not (#v4 > 0) then 0 else #v4 * 16 + 18 + 6
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, v5 + 132)
    local v6 = if not a1.current then
        Color3.fromRGB(40, 44, 55)
    else
        Color3.fromRGB(38, 56, 45)
    Frame.BackgroundColor3 = v6
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = a3
    Frame.Parent = u59

    u34.corner(Frame, 8)
    u34.stroke(Frame, if not a1.current then u34.Palette.Stroke else u34.Palette.Green, if not a1.current then 1 else 2)

    local asWritten = u34.asWritten
    local name = a1.name
    local Text = u34.Palette.Text
    local v7 = Instance.new("TextLabel")
    v7.BackgroundTransparency = 1
    v7.Text = name
    v7.TextColor3 = Text
    v7.TextSize = 15
    v7.FontFace = u34.Font.Bold
    v7.TextXAlignment = Enum.TextXAlignment.Left
    v7.TextTruncate = Enum.TextTruncate.AtEnd
    v7.Parent = Frame
    v5 = asWritten(v7)
    v5.Size = UDim2.new(1, -240, 0, 20)
    v5.Position = UDim2.fromOffset(14, 14)
    local v8 = ("%*  ·  %* on board"):format(if not a1.isOwner then ("%*'s island"):format(a1.ownerName) else "Yours", (("%* of %*"):format(#a1.members, a2.maxMembers)))
    local Faint = u34.Palette.Faint
    v7 = Instance.new("TextLabel")
    v7.BackgroundTransparency = 1
    v7.Text = v8
    v7.TextColor3 = Faint
    v7.TextSize = 12
    v7.FontFace = u34.Font.Regular
    v7.TextXAlignment = Enum.TextXAlignment.Left
    v7.TextTruncate = Enum.TextTruncate.AtEnd
    v7.Parent = Frame
    v7.Size = UDim2.new(1, -240, 0, 16)
    v7.Position = UDim2.fromOffset(14, 34)
    local Frame_2 = Instance.new("Frame")
    Frame_2.Size = UDim2.new(1, -28, 0, 56)
    Frame_2.Position = UDim2.fromOffset(14, 56)
    Frame_2.BackgroundTransparency = 1
    Frame_2.Parent = Frame
    v6 = Instance.new("UIListLayout")
    v6.FillDirection = Enum.FillDirection.Horizontal
    v6.Padding = UDim.new(0, 6)
    v6.Wraps = true
    v6.SortOrder = Enum.SortOrder.LayoutOrder
    v6.Parent = Frame_2
    v6 = 0
    v3 = nil
    local v9 = nil

    for k, n in a1.members, v3, v9 do
        v6 = v6 + 1
        isOwner = a1.isOwner and n.userId ~= a1.owner
        v2 = if not isOwner then
            nil
        else
            function() -- Line: 583; upvalues: a1 (val), n (val), u53 (upval)
                local owner = a1.owner
                local slot = a1.slot
                local userId = n.userId

                u53:FireServer("remove", owner, slot, userId)
            end

        drawPersonChip(Frame_2, n, v6, false, v2)
    end

    v3 = nil
    v9 = nil

    for m, i5 in a1.invites, v3, v9 do
        v6 = v6 + 1

        if a1.isOwner then
            drawPersonChip(
                Frame_2,
                {userId = i5.userId, name = ("%* (asked)"):format(i5.name)},
                v6,
                true,
                function() -- Line: 596; upvalues: a1 (val), i5 (val), u53 (upval)
                    local slot = a1.slot
                    local userId = i5.userId

                    u53:FireServer("cancel", slot, userId, nil)
                end
            )
        end
    end

    if #v4 > 0 then
        local Green_2, v10
        local Faint_2 = u34.Palette.Faint
        v7 = Instance.new("TextLabel")
        v7.BackgroundTransparency = 1
        v7.Text = "RECENT SPENDING AND SALES"
        v7.TextColor3 = Faint_2
        v7.TextSize = 11
        v7.FontFace = u34.Font.Bold
        v7.TextXAlignment = Enum.TextXAlignment.Left
        v7.TextTruncate = Enum.TextTruncate.AtEnd
        v7.Parent = Frame
        v7.Size = UDim2.new(1, -28, 0, 14)
        v7.Position = UDim2.fromOffset(14, 112)
        v7 = os.time()
        v3 = nil
        v9 = nil

        for i6, i7 in v4, v3, v9 do
            v10 = ("%*  ·  %*"):format(CoopLedger.describe(i7), (CoopLedger.ago(v7 - i7.t)))
            Green_2 = if i7.k ~= "Sold" then u34.Palette.Dim else u34.Palette.Green
            v6 = Instance.new("TextLabel")
            v6.BackgroundTransparency = 1
            v6.Text = v10
            v6.TextColor3 = Green_2
            v6.TextSize = 12
            v6.FontFace = u34.Font.Regular
            v6.TextXAlignment = Enum.TextXAlignment.Left
            v6.TextTruncate = Enum.TextTruncate.AtEnd
            v6.Parent = Frame
            v6.Size = UDim2.new(1, -28, 0, 16)
            v6.Position = UDim2.fromOffset(14, (i6 - 1) * 16 + 130)
        end
    end

    v4 = {}

    if not a1.current then
        v8 = button(Frame, "PLAY", 88, u34.Palette.Gold, Color3.fromRGB(28, 24, 12))
        v8.Activated:Connect(function() -- Line: 625; upvalues: a1 (val), u53 (upval)
            local slot = a1.slot
            local owner = a1.owner

            u53:FireServer("play", slot, owner, nil)
        end)

        table.insert(v4, v8)
    end

    if not a1.isOwner then
        v8 = button(Frame, "LEAVE", 92, Color3.fromRGB(58, 30, 34), Color3.fromRGB(255, 200, 200))
        v8.Activated:Connect(function() -- Line: 657; upvalues: a1 (val), LocalPlayer (upval), u53 (upval)
            local owner = a1.owner
            local slot = a1.slot
            local UserId = LocalPlayer.UserId

            u53:FireServer("remove", owner, slot, UserId)
        end)

        table.insert(v4, v8)
    else
        local v11
        v3 = button(Frame, if not (v11.maxMembers <= #a1.members + #a1.invites) then "INVITE" else "FULL", 92, if not v8 then u34.Palette.Green else Color3.fromRGB(38, 40, 50), if not v8 then Color3.fromRGB(14, 30, 18) else u34.Palette.Faint)
        v3.AutoButtonColor = not v8

        if not v8 then
            v3.Activated:Connect(function()
                -- Line: 642
                -- upvalues: a1 (val), closeOverlay (upval), u69 (upval), u70 (upval), u61 (upval), u67 (upval)
                -- upvalues: u68 (upval), u56 (upval), renderPicker (upval)
                closeOverlay()

                u69 = a1
                u70 = ""
                u61.Visible = true

                if #u67 == 0 then
                    u68 = true
                    u56:FireServer()
                end

                renderPicker()
            end)
        end

        table.insert(v4, v3)

        v3 = button(Frame, "RENAME", 88, Color3.fromRGB(40, 43, 54), u34.Palette.Dim)
        v3.Activated:Connect(function() -- Line: 649; upvalues: openRename (upval), a1 (val), u53 (upval)
            openRename(
                "NAME CO-OP ISLAND",
                a1.name,
                function(a1_2) -- Line: 650; upvalues: a1 (upval), u53 (upval)
                    local slot = a1.slot
                    u53:FireServer("renamecoop", slot, a1_2, nil)
                end
            )
        end)

        table.insert(v4, v3)
    end

    local v12 = 14

    for i8 = #v4, 1, -1 do
        v1 = v4[i8]
        v1.AnchorPoint = Vector2.new(1, 0)
        v1.Position = UDim2.new(1, -v12, 1, -36)
        v12 = v12 + (v1.Size.X.Offset + 6)
    end
end

local function drawInvitation(a1, a2)
    -- Line: 672
    -- upvalues: u59 (ref), u34 (val), button (val), u53 (val)
    -- types: a1: table, a2: number
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 62)
    Frame.BackgroundColor3 = Color3.fromRGB(34, 32, 24)
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = a2
    Frame.Parent = u59

    u34.corner(Frame, 8)
    u34.stroke(Frame, u34.Palette.Gold, 1)

    local asWritten = u34.asWritten
    local v1 = ("%* invited you to %*"):format(a1.by, a1.name)
    local Text = u34.Palette.Text
    local v2 = Instance.new("TextLabel")
    v2.BackgroundTransparency = 1
    v2.Text = v1
    v2.TextColor3 = Text
    v2.TextSize = 14
    v2.FontFace = u34.Font.Bold
    v2.TextXAlignment = Enum.TextXAlignment.Left
    v2.TextTruncate = Enum.TextTruncate.AtEnd
    v2.Parent = Frame
    local v3 = asWritten(v2)
    v3.Size = UDim2.new(1, -220, 0, 20)
    v3.Position = UDim2.fromOffset(14, 12)
    local Faint = u34.Palette.Faint
    v3 = Instance.new("TextLabel")
    v3.BackgroundTransparency = 1
    v3.Text = "You would start fresh on that island."
    v3.TextColor3 = Faint
    v3.TextSize = 12
    v3.FontFace = u34.Font.Regular
    v3.TextXAlignment = Enum.TextXAlignment.Left
    v3.TextTruncate = Enum.TextTruncate.AtEnd
    v3.Parent = Frame
    v3.Size = UDim2.new(1, -220, 0, 16)
    v3.Position = UDim2.fromOffset(14, 32)
    v3 = button(Frame, "JOIN", 92, u34.Palette.Green, Color3.fromRGB(14, 30, 18))
    v3.Position = UDim2.new(1, -206, 0.5, -13)

    v3.Activated:Connect(function() -- Line: 693; upvalues: a1 (val), u53 (upval)
        local owner = a1.owner
        local slot = a1.slot

        u53:FireServer("accept", owner, slot, nil)
    end)

    v3 = button(Frame, "DECLINE", 92, Color3.fromRGB(44, 48, 60), u34.Palette.Dim)
    v3.Position = UDim2.new(1, -106, 0.5, -13)

    v3.Activated:Connect(function() -- Line: 699; upvalues: a1 (val), u53 (upval)
        local owner = a1.owner
        local slot = a1.slot

        u53:FireServer("decline", owner, slot, nil)
    end)
end

local function render()
    -- Line: 705
    -- upvalues: clearBody (val), u62 (val), u64 (ref), u34 (val), u59 (ref), u65 (ref)
    -- upvalues: IslandPermissionsController (val), u58 (ref), u63 (ref), u66 (ref), u60 (ref), drawSlotCard (val)
    -- upvalues: drawInvitation (val), drawCoopCard (val), button (val), u53 (val)
    local Text_2, v1, v2
    clearBody()

    local v3 = nil
    local v4 = nil

    for i, j in u62, v3, v4 do
        v2 = if not (i == u64) then Color3.fromRGB(26, 28, 35) else Color3.fromRGB(44, 48, 60)
        j.BackgroundColor3 = v2
        Text_2 = if not v1 then u34.Palette.Faint else u34.Palette.Text
        j.TextColor3 = Text_2
    end

    local v5 = u64 == "permissions"
    u59.Visible = not v5
    u65.Visible = v5
    local showEmbedded = IslandPermissionsController.showEmbedded
    local Visible = v5

    if Visible then
        Visible = false

        if u58 ~= nil then
            Visible = u58.Visible
        end
    end

    showEmbedded(Visible)

    if v5 then
        return
    end

    v5 = u63

    if not v5 then
        v4 = u59
        local Faint = u34.Palette.Faint
        v3 = Instance.new("TextLabel")
        v3.BackgroundTransparency = 1
        v3.Text = if not u66 then "" else "Loading your islands..."
        v3.TextColor3 = Faint
        v3.TextSize = 14
        v3.FontFace = u34.Font.Regular
        v3.TextXAlignment = Enum.TextXAlignment.Left
        v3.TextTruncate = Enum.TextTruncate.AtEnd
        v3.Parent = v4
        v3.Size = UDim2.new(1, 0, 0, 40)

        return
    end

    v3 = 0

    if u64 == "solo" then
        if not v5.slotsKnown then
            local Gold = u34.Palette.Gold
            u60.Text = "Couldn't check what you own just now. Locked islands may be wrong."
            u60.TextColor3 = Gold or u34.Palette.Dim
        end

        for i6, i7 in v5.slots do
            v3 = v3 + 1
            drawSlotCard(i7, v3)
        end

        return
    end

    for k, n in v5.invitations do
        v3 = v3 + 1
        drawInvitation(n, v3)
    end

    local v6 = nil

    for m, i5 in v5.coops, nil, v6 do
        v3 = v3 + 1
        drawCoopCard(i5, v5, v3)
    end

    v4 = v5.coopsOwned < v5.coopLimit
    v3 = v3 + 1
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 82)
    Frame.BackgroundColor3 = Color3.fromRGB(24, 26, 33)
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = v3
    Frame.Parent = u59

    u34.corner(Frame, 8)
    u34.stroke(Frame)

    if v4 then
        local Text = u34.Palette.Text
        v3 = Instance.new("TextLabel")
        v3.BackgroundTransparency = 1
        v3.Text = "START A CO-OP ISLAND"
        v3.TextColor3 = Text
        v3.TextSize = 14
        v3.FontFace = u34.Font.Bold
        v3.TextXAlignment = Enum.TextXAlignment.Left
        v3.TextTruncate = Enum.TextTruncate.AtEnd
        v3.Parent = Frame
        v3.Size = UDim2.new(1, -28, 0, 18)
        v3.Position = UDim2.fromOffset(14, 14)
        v6 = ("A fresh island you own, with up to %* friends on it. Nothing carries over from your other islands."):format(v5.maxMembers - 1)
        local Faint_2 = u34.Palette.Faint
        v3 = Instance.new("TextLabel")
        v3.BackgroundTransparency = 1
        v3.Text = v6
        v3.TextColor3 = Faint_2
        v3.TextSize = 12
        v3.FontFace = u34.Font.Regular
        v3.TextXAlignment = Enum.TextXAlignment.Left
        v3.TextTruncate = Enum.TextTruncate.AtEnd
        v3.Parent = Frame
        v3.Size = UDim2.new(1, -180, 0, 30)
        v3.Position = UDim2.fromOffset(14, 34)
        v3.TextWrapped = true
        v3.TextYAlignment = Enum.TextYAlignment.Top
        v3 = button(Frame, "CREATE", 120, u34.Palette.Green, Color3.fromRGB(14, 30, 18))
        v3.Position = UDim2.new(1, -134, 0.5, -13)

        v3.Activated:Connect(function() -- Line: 787; upvalues: u53 (upval)
            u53:FireServer("createcoop", nil, nil, nil)
        end)
    elseif not v5.nextCoop then
        local Dim_2 = u34.Palette.Dim
        v6 = Instance.new("TextLabel")
        v6.BackgroundTransparency = 1
        v6.Text = "YOU HAVE EVERY CO-OP ISLAND"
        v6.TextColor3 = Dim_2
        v6.TextSize = 14
        v6.FontFace = u34.Font.Bold
        v6.TextXAlignment = Enum.TextXAlignment.Left
        v6.TextTruncate = Enum.TextTruncate.AtEnd
        v6.Parent = Frame
        v6.Size = UDim2.new(1, -28, 0, 18)
        v6.Position = UDim2.fromOffset(14, 30)
    else
        local nextCoop = v5.nextCoop
        local productName = nextCoop.productName
        local Violet = u34.Palette.Violet
        v1 = Instance.new("TextLabel")
        v1.BackgroundTransparency = 1
        v1.Text = productName
        v1.TextColor3 = Violet
        v1.TextSize = 14
        v1.FontFace = u34.Font.Bold
        v1.TextXAlignment = Enum.TextXAlignment.Left
        v1.TextTruncate = Enum.TextTruncate.AtEnd
        v1.Parent = Frame
        v1.Size = UDim2.new(1, -28, 0, 18)
        v1.Position = UDim2.fromOffset(14, 14)
        local Faint_3 = u34.Palette.Faint
        v1 = Instance.new("TextLabel")
        v1.BackgroundTransparency = 1
        v1.Text = "Another co-op island of your own, with its own friends on it."
        v1.TextColor3 = Faint_3
        v1.TextSize = 12
        v1.FontFace = u34.Font.Regular
        v1.TextXAlignment = Enum.TextXAlignment.Left
        v1.TextTruncate = Enum.TextTruncate.AtEnd
        v1.Parent = Frame
        v1.Size = UDim2.new(1, -180, 0, 30)
        v1.Position = UDim2.fromOffset(14, 34)
        v1.TextWrapped = true
        v1.TextYAlignment = Enum.TextYAlignment.Top

        if not nextCoop.price then
            v2 = button(Frame, "COMING SOON", 130, Color3.fromRGB(52, 55, 68), u34.Palette.Dim)
            v2.Position = UDim2.new(1, -144, 0.5, -13)
            v2.AutoButtonColor = false
        else
            v1 = button(Frame, ("BUY  R$ %*"):format(nextCoop.price), 130, u34.Palette.Violet, Color3.fromRGB(24, 18, 40))
            v1.Position = UDim2.new(1, -144, 0.5, -13)

            v1.Activated:Connect(function() -- Line: 806; upvalues: nextCoop (val), u53 (upval)
                local productId = nextCoop.productId
                u53:FireServer("buy", productId, nil, nil)
            end)
        end
    end

    if #v5.coops == 0 and #v5.invitations == 0 then
        local Dim_3 = u34.Palette.Dim
        u60.Text = "A co-op island is shared. Everyone on it builds the same world."
        u60.TextColor3 = Dim_3 or u34.Palette.Dim
    end
end

local function refresh() -- Line: 825; upvalues: u66 (ref), u50 (val), render (ref)
    u66 = true
    u50:FireServer()
    render()
end

function u45.close()
    -- Line: 831
    -- upvalues: u58 (ref), closeOverlay (val), IslandPermissionsController (val), BuildController (val)
    local Visible = false

    if u58 ~= nil then
        Visible = u58.Visible
    end

    if not Visible then
        return
    end

    closeOverlay()

    u58.Visible = false
    IslandPermissionsController.showEmbedded(false)
    BuildController.setUiOpen("Islands", false)
end

function u45.open(a1)
    -- Line: 843
    -- upvalues: u64 (ref), u58 (ref), render (ref), u60 (ref), u34 (val), BuildController (val), u66 (ref), u50 (val)
    -- types: a1: string?
    if a1 == "permissions" or a1 == "solo" or a1 == "coop" then
        u64 = a1
    end

    local Visible = false

    if u58 ~= nil then
        Visible = u58.Visible
    end

    if Visible then
        render()
        return
    end

    u60.Text = ""
    u60.TextColor3 = u34.Palette.Dim
    u58.Visible = true

    BuildController.setUiOpen("Islands", true)
    u34.appear(u58)

    u66 = true
    u50:FireServer()
    render()
end

function u45.toggle() -- Line: 858; upvalues: u58 (ref), u45 (val)
    local Visible = false

    if u58 ~= nil then
        Visible = u58.Visible
    end

    if Visible then
        u45.close()
        return
    end

    u45.open()
end

function u45.start()
    -- Line: 866
    -- upvalues: BuildController (val), u45 (val), u57 (ref), LocalPlayer (val), u58 (ref), u34 (val), button (val)
    -- upvalues: u64 (ref), closeOverlay (val), render (ref), u62 (val), u59 (ref), u65 (ref)
    -- upvalues: IslandPermissionsController (val), u60 (ref), u61 (ref), Remotes (val), u66 (ref), u63 (ref), u69 (ref)
    -- upvalues: renderPicker (val), u68 (ref), u67 (ref), ContextActionService (val)
    local v1
    BuildController.registerMenu("Islands", u45.close)

    u57 = Instance.new("ScreenGui")
    u57.Name = "AboveIslands"
    u57.ResetOnSpawn = false
    u57.DisplayOrder = 60
    u57.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    u57.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u58 = Instance.new("CanvasGroup")
    u58.Size = UDim2.fromOffset(760, 540)
    u58.Position = UDim2.new(0.5, -380, 0.5, -270)

    u34.fitToScreen(u58)

    u58.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
    u58.BackgroundTransparency = 0
    u58.BorderSizePixel = 0
    u58.Visible = false
    u58.Active = true
    u58.Parent = u57

    u34.closeButton(u58, 10, u45.close)
    u34.corner(u58, u34.Radius.Card)
    u34.stroke(u58)

    local v2 = u58
    local Text = u34.Palette.Text
    local v3 = Instance.new("TextLabel")
    v3.BackgroundTransparency = 1
    v3.Text = "ISLAND MANAGEMENT"
    v3.TextColor3 = Text
    v3.TextSize = 18
    v3.FontFace = u34.Font.Bold
    v3.TextXAlignment = Enum.TextXAlignment.Left
    v3.TextTruncate = Enum.TextTruncate.AtEnd
    v3.Parent = v2
    v3.Size = UDim2.new(1, -120, 0, 24)
    v3.Position = UDim2.fromOffset(18, 16)

    for i, j in {
        {id = "permissions", text = "PERMISSIONS"},
        {id = "solo", text = "ISLAND SLOTS"},
        {id = "coop", text = "CO-OP SLOTS"},
    } do
        v1 = button(u58, j.text, 140, Color3.fromRGB(26, 28, 35), u34.Palette.Faint)
        v1.Size = UDim2.fromOffset(140, u34.tap(28))
        v1.Position = UDim2.fromOffset(18 + (i - 1) * 146, 52)

        v1.Activated:Connect(function()
            -- Line: 920
            -- upvalues: u64 (upval), j (val), closeOverlay (upval), render (upval)
            u64 = j.id
            closeOverlay()
            render()
        end)

        u62[j.id] = v1
    end

    u59 = Instance.new("ScrollingFrame")
    u59.Size = UDim2.new(1, -36, 1, -126)
    u59.Position = UDim2.fromOffset(18, 92)
    u59.BackgroundTransparency = 1
    u59.BorderSizePixel = 0
    u59.ScrollBarThickness = 5
    u59.ScrollBarImageColor3 = u34.Palette.Stroke
    u59.CanvasSize = UDim2.new()
    u59.AutomaticCanvasSize = Enum.AutomaticSize.Y
    u59.Parent = u58
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 12)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.Wraps = true
    UIListLayout.Parent = u59
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingRight = UDim.new(0, 8)
    UIPadding.Parent = u59
    u65 = Instance.new("Frame")
    u65.Size = UDim2.new(1, -36, 1, -126)
    u65.Position = UDim2.fromOffset(18, 92)
    u65.BackgroundTransparency = 1
    u65.Visible = false
    u65.Parent = u58

    IslandPermissionsController.embed(u65)

    local v4 = u58
    local Dim = u34.Palette.Dim
    v2 = Instance.new("TextLabel")
    v2.BackgroundTransparency = 1
    v2.Text = ""
    v2.TextColor3 = Dim
    v2.TextSize = 12
    v2.FontFace = u34.Font.Regular
    v2.TextXAlignment = Enum.TextXAlignment.Left
    v2.TextTruncate = Enum.TextTruncate.AtEnd
    v2.Parent = v4
    u60 = v2
    u60.Size = UDim2.new(1, -36, 0, 18)
    u60.Position = UDim2.new(0, 18, 1, -26)
    u60.TextWrapped = true
    u61 = Instance.new("Frame")
    u61.Size = UDim2.fromScale(1, 1)
    u61.BackgroundTransparency = 1
    u61.BorderSizePixel = 0
    u61.Visible = false
    u61.Active = true
    u61.ZIndex = 5
    u61.Parent = u58

    u34.corner(u61, u34.Radius.Card)

    ;(Remotes.get(Remotes.IslandsData)).OnClientEvent:Connect(function(a1)
        -- Line: 987
        -- upvalues: u66 (upval), u63 (upval), u69 (upval), renderPicker (upval), closeOverlay (upval), render (upval)
        if type(a1) ~= "table" then
            return
        end

        u66 = false

        if u69 then
            local v1 = nil

            for i, j in a1.coops do
                if j.owner == u69.owner and j.slot == u69.slot then
                    v1 = j
                end
            end

            u69 = v1

            if not v1 then
                closeOverlay()
            else
                renderPicker()
            end
        end

        render()
    end)

    ;(Remotes.get(Remotes.IslandActionResult)).OnClientEvent:Connect(function(a1, a2)
        -- Line: 1013
        -- upvalues: u34 (upval), u60 (upval)
        if type(a2) ~= "string" then
            return
        end

        local Green = if not a1 then u34.Palette.Red else u34.Palette.Green
        u60.Text = a2
        u60.TextColor3 = Green or u34.Palette.Dim
    end)

    ;(Remotes.get(Remotes.FriendList)).OnClientEvent:Connect(function(a1)
        -- Line: 1020
        -- upvalues: u68 (upval), u67 (upval), u69 (upval), renderPicker (upval)
        if type(a1) ~= "table" then
            return
        end

        u68 = false
        u67 = a1

        if u69 then
            renderPicker()
        end
    end)

    local Escape = Enum.KeyCode.Escape
    ContextActionService:BindAction(
        "AboveCloseIslands",
        function(a1, a2) -- Line: 1031; upvalues: u58 (upval), u61 (upval), closeOverlay (upval), u45 (upval)
            if a2 == Enum.UserInputState.Begin then
                local Visible = false

                if u58 ~= nil then
                    Visible = u58.Visible
                end

                if Visible then
                    if not u61.Visible then
                        u45.close()
                    else
                        closeOverlay()
                    end

                    return Enum.ContextActionResult.Sink
                end
            end

            return Enum.ContextActionResult.Pass
        end,
        false,
        Escape
    )
end

return u45