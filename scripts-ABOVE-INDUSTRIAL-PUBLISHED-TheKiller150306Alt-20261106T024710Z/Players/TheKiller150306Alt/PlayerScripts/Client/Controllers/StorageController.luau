-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.StorageController
-- Decompile time: 11.05 ms

local Players = game:GetService("Players")
local u11 = (require(script.Parent.DeviceMode)).touchOnly()
local v1 = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(v1.Config)
local DisplayAccepts = require(v1.DisplayAccepts)
local Palette = require(v1.Palette)
local Remotes = require(v1.Remotes)
local u40 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local ItemIcon = require(script.Parent.ItemIcon)
local CopyPicker = require(script.Parent.Parent.CopyPicker)
local u62 = {}
local LocalPlayer = Players.LocalPlayer
local u67 = Remotes.get(Remotes.StorageUpdate)
local u70 = Remotes.get(Remotes.RequestStorageWithdraw)
local u73 = Remotes.get(Remotes.RequestStorageWithdrawAll)
local u76 = Remotes.get(Remotes.RequestStorageStore)
local u77 = nil
local u78 = nil
local u79 = nil
local u80 = nil
local u81 = nil
local u82 = nil
local u83 = nil
local u84 = nil
local u85 = nil
local u86 = {}
local u87 = nil
local u88 = {}
local u89 = 0
local u90 = 99

local function slotsFrom(a1) -- Line: 68; upvalues: u90 (ref); types: a1: table
    local v1, v2
    local v3 = {}

    for i, j in a1 do
        if j > 0 then
            table.insert(v3, i)
        end
    end

    table.sort(v3)

    local v4 = {}
    local v5 = nil
    local v6 = nil

    for k, n in v3, v5, v6 do
        v1 = a1[n]

        while v1 > 0 do
            v2 = math.min(v1, u90)
            table.insert(
                v4,
                {itemId = n, count = v2}
            )

            v1 = v1 - v2
        end
    end

    return v4
end

local u95 = setmetatable(
    {},
    {__mode = "k"}
)

local function slotAt(a1, a2) -- Line: 106; types: a1: userdata, a2: number
    local v1 = a1:FindFirstChild((("Slot%*"):format(a2)))

    if v1 and v1:IsA("Frame") then
        return v1
    end

    return nil
end

local function trimSlots(a1, a2) -- Line: 112; types: a1: userdata, a2: number
    local v1

    for i, j in a1:GetChildren() do
        v1 = tonumber((string.match(j.Name, "^Slot(%d+)$")))

        if v1 and a2 < v1 then
            j:Destroy()
        end
    end
end

local u98 = nil
local u102 = u40.tap(22) - 22
local u103 = ""
local u104 = nil

local function buildBackpackSearch(a1, a2, a3, a4)
    -- Line: 147
    -- upvalues: u40 (val), u103 (ref)
    -- types: a1: userdata, a2: number, a3: number, a4: function
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.fromOffset(a3, u40.tap(22))
    TextBox.Position = UDim2.fromOffset(a2, 44)
    TextBox.BackgroundColor3 = Color3.fromRGB(26, 30, 38)
    TextBox.BorderSizePixel = 0
    TextBox.PlaceholderText = "Search your backpack"
    TextBox.PlaceholderColor3 = Color3.fromRGB(96, 106, 124)
    TextBox.Text = ""
    TextBox.TextColor3 = Color3.fromRGB(226, 232, 244)
    TextBox.FontFace = u40.Font.Regular
    TextBox.TextSize = 12
    TextBox.TextXAlignment = Enum.TextXAlignment.Left
    TextBox.ClearTextOnFocus = false
    TextBox.Parent = a1
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.Parent = TextBox
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = TextBox

    ;(TextBox:GetPropertyChangedSignal("Text")):Connect(function()
        -- Line: 171
        -- upvalues: u103 (upval), TextBox (val), a4 (val)
        u103 = string.lower(TextBox.Text)
        a4()
    end)

    return TextBox
end

local function matchesBackpackQuery(a1) -- Line: 180; upvalues: u103 (ref), Palette (val); types: a1: string
    if u103 == "" then
        return true
    end

    return string.find(string.lower(Palette.displayName(a1)), u103, 1, true) ~= nil
end

local function buildEmptySlot(a1, a2) -- Line: 186; types: a1: userdata, a2: number
    local v1 = a1:FindFirstChild((("Slot%*"):format(a2)))
    local v2 = if not v1 then nil else if not v1:IsA("Frame") then nil else v1

    if v2 then
        if v2:GetAttribute("Kind") == "Empty" then
            return
        end

        v2:Destroy()
    end

    local Frame = Instance.new("Frame")
    Frame.Name = ("Slot%*"):format(a2)

    Frame:SetAttribute("Kind", "Empty")

    Frame.Size = UDim2.fromOffset(58, 58)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 25, 31)
    Frame.BackgroundTransparency = 0.45
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = a2
    Frame.Parent = a1
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Frame
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 1
    UIStroke.Transparency = 0.5
    UIStroke.Color = Color3.fromRGB(90, 100, 120)
    UIStroke.Parent = Frame
end

local function buildSlot(a1, a2, a3, a4, a5)
    -- Line: 216
    -- upvalues: ItemIcon (val), Palette (val), u95 (val), u40 (val), ControlGlyphs (val)
    -- types: a1: userdata, a2: string, a3: number, a4: number, a5: function
    local v1 = a1:FindFirstChild((("Slot%*"):format(a4)))
    local v2 = if not v1 then nil else if not v1:IsA("Frame") then nil else v1

    if v2 and v2:GetAttribute("Kind") ~= "Item" then
        v2:Destroy()

        v2 = nil
    end

    if v2 then
        local Holder = v2:FindFirstChild("Holder")
        local Amount = v2:FindFirstChild("Amount")
        local Label = v2:FindFirstChild("Label")

        if Holder and Holder:IsA("GuiObject") then
            ItemIcon.render(Holder, a2, 30, 4)
        end

        if Amount and Amount:IsA("TextLabel") then
            Amount.Text = ("x%*"):format(a3)
        end

        if Label and Label:IsA("TextLabel") then
            Label.Text = Palette.displayName(a2)
        end

        u95[v2] = a5

        return
    end

    local Frame = Instance.new("Frame")
    Frame.Name = ("Slot%*"):format(a4)

    Frame:SetAttribute("Kind", "Item")

    Frame.Size = UDim2.fromOffset(58, 58)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 34, 42)
    Frame.BackgroundTransparency = 0.15
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = a4
    Frame.Parent = a1
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Frame
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 2
    UIStroke.Color = Color3.fromRGB(16, 18, 24)
    UIStroke.Parent = Frame
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "Holder"
    Frame_2.Size = UDim2.fromOffset(30, 30)
    Frame_2.Position = UDim2.new(0.5, -15, 0, 12)
    Frame_2.BackgroundTransparency = 1
    Frame_2.Parent = Frame

    ItemIcon.render(Frame_2, a2, 30, 4)

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "Amount"
    TextLabel.Size = UDim2.fromOffset(50, 14)
    TextLabel.Position = UDim2.fromOffset(4, 3)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = ("x%*"):format(a3)
    TextLabel.TextColor3 = Color3.fromRGB(255, 226, 130)
    TextLabel.FontFace = u40.Font.Bold
    TextLabel.TextSize = 13
    TextLabel.TextXAlignment = Enum.TextXAlignment.Right
    TextLabel.Parent = Frame
    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.Name = "Label"
    TextLabel_2.Size = UDim2.new(1, -6, 0, 12)
    TextLabel_2.Position = UDim2.new(0, 3, 1, -14)
    TextLabel_2.BackgroundTransparency = 1
    TextLabel_2.Text = Palette.displayName(a2)
    TextLabel_2.TextColor3 = Color3.fromRGB(210, 215, 228)
    TextLabel_2.TextSize = 10
    TextLabel_2.FontFace = u40.Font.Regular
    TextLabel_2.TextTruncate = Enum.TextTruncate.AtEnd
    TextLabel_2.Parent = Frame
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromScale(1, 1)
    TextButton.BackgroundTransparency = 1
    TextButton.Text = ""
    TextButton.Parent = Frame
    u95[Frame] = a5
    local u232 = u40.holdForStack(
        TextButton,
        function() -- Line: 299; upvalues: u95 (upval), Frame (val)
            local v1 = u95[Frame]

            if v1 then
                v1(true)
            end
        end
    )

    TextButton.Activated:Connect(function()
        -- Line: 305
        -- upvalues: u232 (val), ControlGlyphs (upval), u95 (upval), Frame (val)
        if u232() then
            return
        end

        local v1 = ControlGlyphs.bulkHeld()
        local v2 = u95[Frame]

        if v2 then
            v2(v1)
        end
    end)
end

local function render()
    -- Line: 322
    -- upvalues: slotsFrom (val), u88 (ref), u80 (ref), u89 (ref), u82 (ref), buildSlot (val), u83 (ref), u87 (ref)
    -- upvalues: u70 (val), u98 (ref), Config (val), u86 (ref), DisplayAccepts (val), u103 (ref), Palette (val)
    -- upvalues: u84 (ref), CopyPicker (val), u78 (ref), u40 (val), u76 (val), trimSlots (val), buildEmptySlot (val)
    local accepts, takes, v1, v2
    local v3 = slotsFrom(u88)
    local v4 = 0

    for i, j in u88 do
        v4 = v4 + j
    end

    u80.Text = ("%* / %* slots  ·  %* items"):format(#v3, u89, v4)
    local v5 = u80
    local v6 = #v3
    local v7 = if not (u89 <= v6) then
        Color3.fromRGB(150, 162, 180)
    else
        Color3.fromRGB(240, 140, 130)
    v5.TextColor3 = v7
    u82.Active = v4 > 0
    u82.AutoButtonColor = v4 > 0
    u82.BackgroundTransparency = if not (v4 > 0) then 0.6 else 0
    u82.TextTransparency = if not (v4 > 0) then 0.5 else 0

    for k, n in v3 do
        buildSlot(
            u83,
            n.itemId,
            n.count,
            k,
            function(a1) -- Line: 340; upvalues: u87 (upval), u70 (upval), n (val)
                if u87 then
                    local v1 = u70
                    local itemId = n.itemId
                    local count = if not a1 then 1 else n.count

                    v1:FireServer(u87, itemId, count)
                end
            end
        )
    end

    v4 = {}
    local u228 = if not u98 then nil else Config.Storage.Containers[u98]
    local u231 = false

    if u228 ~= nil then
        u231 = u228.takesOnlyRecyclable == true
    end

    local v8 = nil
    local v9 = nil

    for m, i5 in u86, v8, v9 do
        if i5 > 0 then
            if not u231 or Config.Recipe.isRecyclable(m) then
                takes = DisplayAccepts.takes
                accepts = u228 and u228.accepts

                if takes(accepts, m) then
                    if if u103 ~= "" then
                        string.find(string.lower(Palette.displayName(m)), u103, 1, true)
                            ~= nil
                    else
                        true then
                        table.insert(v4, m)
                    end
                end
            end
        end
    end

    table.sort(v4)

    for i6, i7 in v4 do
        v1 = u84
        v2 = u86[i7]

        buildSlot(
            v1,
            i7,
            v2,
            i6,
            function(a1)
                -- Line: 375
                -- upvalues: u87 (upval), u231 (val), Config (upval), i7 (val), CopyPicker (upval), u78 (upval)
                -- upvalues: u40 (upval), u76 (upval), u228 (val), u86 (upval)
                if not u87 then
                    return
                end

                if u231 and Config.Recipe.isUnique(i7) then
                    CopyPicker.ask(
                        i7,
                        u78,
                        "Recycle",
                        u40.Palette.Red,
                        function(a1) -- Line: 382; upvalues: u87 (upval), u76 (upval), i7 (upval)
                            if u87 then
                                u76:FireServer(u87, i7, 1, a1)
                            end
                        end
                    )
                    return
                end

                if u228 and u228.accepts and Config.Recipe.isUnique(i7) then
                    CopyPicker.ask(
                        i7,
                        u78,
                        "Display",
                        u40.Palette.Green,
                        function(a1) -- Line: 392; upvalues: u87 (upval), u76 (upval), i7 (upval)
                            if u87 then
                                u76:FireServer(u87, i7, 1, a1)
                            end
                        end
                    )
                    return
                end

                local v1 = u76
                local v2 = if not a1 then 1 else u86[i7]

                v1:FireServer(u87, i7, v2)
            end
        )
    end

    trimSlots(u84, #v4)

    u84.CanvasSize = UDim2.fromOffset(0, math.ceil(#v4 / 5) * 64 + 6)
    v9 = #v3 + 1
    v6 = u89

    for i8 = v9, v6 do
        buildEmptySlot(u83, i8)
    end

    trimSlots(u83, u89)

    u83.CanvasSize = UDim2.fromOffset(0, math.ceil(u89 / 5) * 64 + 6)
end

function u62.isOpen() -- Line: 415; upvalues: u78 (ref)
    local Visible = false

    if u78 ~= nil then
        Visible = u78.Visible
    end

    return Visible
end

function u62.close() -- Line: 421; upvalues: CopyPicker (val), u104 (ref), u87 (ref), u78 (ref), BuildController (val)
    CopyPicker.close()

    if u104 then
        u104:ReleaseFocus()
    end

    u87 = nil
    u78.Visible = false

    BuildController.setUiOpen("Storage", false)
end

local function refresh(a1, a2, a3, a4, a5)
    -- Line: 432
    -- upvalues: u87 (ref), u98 (ref), u88 (ref), u89 (ref), u90 (ref), u79 (ref), Palette (val), Config (val)
    -- upvalues: u85 (ref), render (val)
    -- types: a1: string, a2: string, a3: table, a4: number, a5: number
    u87 = a1
    u98 = a2
    u88 = a3
    u89 = a4
    u90 = a5
    u79.Text = Palette.displayName(a2)
    local v1 = Config.Storage.Containers[a2]

    if u85 then
        u85.Text = if not v1 then
            "IN THE CHEST"
        else
            if not v1.accepts then "IN THE CHEST" else "ON DISPLAY"
    end

    render()
end

local function open(a1, a2, a3, a4, a5)
    -- Line: 448
    -- upvalues: u87 (ref), u98 (ref), u88 (ref), u89 (ref), u90 (ref), u79 (ref), Palette (val), Config (val)
    -- upvalues: u85 (ref), render (val), u81 (ref), u11 (val), ControlGlyphs (val), u78 (ref), u40 (val)
    -- upvalues: BuildController (val)
    -- types: a1: string, a2: string, a3: table, a4: number, a5: number
    u87 = a1
    u98 = a2
    u88 = a3
    u89 = a4
    u90 = a5
    u79.Text = Palette.displayName(a2)
    local v1 = Config.Storage.Containers[a2]

    if u85 then
        u85.Text = if not v1 then
            "IN THE CHEST"
        else
            if not v1.accepts then "IN THE CHEST" else "ON DISPLAY"
    end

    render()

    u81.Text = if not u11 then
        if not ControlGlyphs.usingGamepad() then
            "Click to move one. Shift-click moves the stack."
        else
            ControlGlyphs.say("{A} moves one. Hold {Y} and press {A} to move the stack.")
    else
        "Tap to move one. Hold to move the stack."
    u78.Visible = true

    u40.appear(u78)
    BuildController.setUiOpen("Storage", true)
end

function u62.start()
    -- Line: 462
    -- upvalues: BuildController (val), u62 (val), u77 (ref), LocalPlayer (val), u78 (ref), u40 (val), u79 (ref)
    -- upvalues: u80 (ref), u102 (val), u83 (ref), u85 (ref), u84 (ref), u104 (ref), buildBackpackSearch (val)
    -- upvalues: render (val), u82 (ref), u87 (ref), u73 (val), u81 (ref), Remotes (val), u86 (ref), u67 (val)
    -- upvalues: u98 (ref), u88 (ref), u89 (ref), u90 (ref), Palette (val), Config (val), open (val)
    BuildController.registerMenu("Storage", u62.close)

    u77 = Instance.new("ScreenGui")
    u77.Name = "AboveStorage"
    u77.ResetOnSpawn = false
    u77.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u78 = Instance.new("Frame")
    u78.ClipsDescendants = true
    u78.Size = UDim2.fromOffset(676, 380)
    u78.Position = UDim2.new(0.5, -338, 0.5, -250)

    u40.fitToScreen(u78)

    u78.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    u78.BackgroundTransparency = 0.05
    u78.Visible = false
    u78.Active = false
    u78.Parent = u77
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = u78
    u79 = Instance.new("TextLabel")
    u79.Size = UDim2.new(1, -24, 0, 24)
    u79.Position = UDim2.fromOffset(12, 8)
    u79.BackgroundTransparency = 1
    u79.Text = "Chest"
    u79.TextColor3 = Color3.fromRGB(255, 226, 130)
    u79.FontFace = u40.Font.Bold
    u79.TextSize = 17
    u79.TextXAlignment = Enum.TextXAlignment.Left
    u79.Parent = u78
    u80 = Instance.new("TextLabel")
    u80.Size = UDim2.new(1, -24, 0, 16)
    u80.Position = UDim2.fromOffset(12, 32)
    u80.BackgroundTransparency = 1
    u80.Text = ""
    u80.TextColor3 = Color3.fromRGB(150, 162, 180)
    u80.FontFace = u40.Font.Regular
    u80.TextSize = 12
    u80.TextXAlignment = Enum.TextXAlignment.Left
    u80.Parent = u78

    u40.closeButton(u78, 8, u62.close)

    local function buildColumn(a1, a2)
        -- Line: 524
        -- upvalues: u102 (upval), u40 (upval), u78 (upval)
        -- types: a1: string, a2: number
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.fromOffset(326, 14)
        TextLabel.Position = UDim2.fromOffset(a2 + 6, 52 + u102)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Name = if a2 ~= 6 then "BackpackHeading" else "ChestHeading"
        TextLabel.Text = a1
        TextLabel.TextColor3 = Color3.fromRGB(120, 135, 160)
        TextLabel.FontFace = u40.Font.Bold
        TextLabel.TextSize = 11
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.Parent = u78
        local ScrollingFrame = Instance.new("ScrollingFrame")
        ScrollingFrame.Size = UDim2.new(0, 326, 1, -(108 + u102))
        ScrollingFrame.Position = UDim2.fromOffset(a2, 70 + u102)
        ScrollingFrame.BackgroundTransparency = 1
        ScrollingFrame.BorderSizePixel = 0
        ScrollingFrame.ScrollBarThickness = 5
        ScrollingFrame.Parent = u78
        local UIGridLayout = Instance.new("UIGridLayout")
        UIGridLayout.CellSize = UDim2.fromOffset(58, 58)
        UIGridLayout.CellPadding = UDim2.fromOffset(6, 6)
        UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIGridLayout.Parent = ScrollingFrame
        local UIPadding = Instance.new("UIPadding")
        UIPadding.PaddingLeft = UDim.new(0, 6)
        UIPadding.PaddingTop = UDim.new(0, 6)
        UIPadding.Parent = ScrollingFrame

        return ScrollingFrame
    end

    u83 = buildColumn("IN THE CHEST", 6)
    u85 = u78:FindFirstChild("ChestHeading")
    u84 = buildColumn("YOUR BACKPACK", 344)
    u104 = buildBackpackSearch(u78, 344, 326, render)
    local v1 = u83
    v1.Size = v1.Size - UDim2.fromOffset(0, 32)
    u82 = Instance.new("TextButton")
    u82.Size = UDim2.fromOffset(120, u40.tap(26))
    u82.AnchorPoint = Vector2.new(0, 1)
    u82.Position = UDim2.new(0, 12, 1, -28)
    u82.BackgroundColor3 = Color3.fromRGB(40, 80, 58)
    u82.TextColor3 = Color3.fromRGB(215, 245, 225)
    u82.Text = "COLLECT ALL"
    u82.FontFace = u40.Font.Bold
    u82.TextSize = u40.tapText(12)
    u82.Parent = u78

    u40.corner(u82, 5)

    u82.Activated:Connect(function() -- Line: 579; upvalues: u87 (upval), u82 (upval), u73 (upval)
        if u87 and u82.Active then
            u73:FireServer(u87)
        end
    end)

    u81 = Instance.new("TextLabel")
    u81.Size = UDim2.new(1, -24, 0, 14)
    u81.Position = UDim2.new(0, 12, 1, -22)
    u81.BackgroundTransparency = 1
    u81.TextColor3 = Color3.fromRGB(130, 145, 170)
    u81.FontFace = u40.Font.Regular
    u81.TextSize = 11
    u81.TextXAlignment = Enum.TextXAlignment.Left
    u81.Parent = u78

    ;(Remotes.get(Remotes.InventoryChanged)).OnClientEvent:Connect(function(a1, a2, a3, a4, a5)
        -- Line: 595
        -- upvalues: u86 (upval), u78 (upval), render (upval)
        if type(a1) ~= "table" then
            return
        end

        u86 = table.clone(a1)

        if type(a5) == "table" then
            local v1, v2

            for i, j in a5 do
                v1 = u86
                v2 = (u86[i] or 0) - j
                v1[i] = (math.max(0, v2))
            end
        end

        if u78.Visible then
            render()
        end
    end)

    u67.OnClientEvent:Connect(function(a1, a2, a3, a4, a5, a6)
        -- Line: 613
        -- upvalues: u78 (upval), u87 (upval), u98 (upval), u88 (upval), u89 (upval), u90 (upval), u79 (upval)
        -- upvalues: Palette (upval), Config (upval), u85 (upval), render (upval), open (upval)
        if not u78.Visible then
            if a6 ~= true then
                return
            end

            open(a1, a2, a3, a4, a5)

            return
        end

        if u87 ~= a1 then
            return
        end

        u87 = a1
        u98 = a2
        u88 = a3
        u89 = a4
        u90 = a5
        u79.Text = Palette.displayName(a2)
        local v1 = Config.Storage.Containers[a2]

        if u85 then
            u85.Text = if not v1 then
                "IN THE CHEST"
            else
                if not v1.accepts then "IN THE CHEST" else "ON DISPLAY"
        end

        render()
    end)
end

return u62