-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ShowroomController
-- Decompile time: 18.55 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Format = require(Shared.Format)
local Remotes = require(Shared.Remotes)
local u29 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local PanelTabs = require(script.Parent.PanelTabs)
local u40 = {}
local Categories = Config.Place.Showroom.Categories
local u44 = {Shops = u29.Palette.Gold, Games = u29.Palette.Violet}
u44.Builds = Color3.fromRGB(110, 180, 255)
local LocalPlayer = Players.LocalPlayer
local u58 = Remotes.get(Remotes.ShowroomsState)
local u61 = Remotes.get(Remotes.RequestShowrooms)
local u65 = u29.tap(64)
local u66 = false
local u67 = nil
local u68 = nil
local u69 = nil
local u70 = nil
local u71 = nil
local u72 = nil
local u73 = nil
local u74 = nil
local u75 = false
local u76 = {}
local u77 = nil
local u78 = {}
local u79 = nil
local u80 = false
local u81 = nil
local u82 = false
local u83 = 0
local u84 = nil
local u85 = nil
local u86 = nil
local u87 = nil
local u88 = nil
local DefaultCategory = Config.Place.Showroom.DefaultCategory
local u92 = {}
local u93 = nil
local u94 = nil
local u95 = nil
local u96 = false
local u97 = nil
local u98 = nil
local u99 = false
local u100 = 0
local u101 = nil

local function label(a1, a2, a3, a4, a5)
    -- Line: 116
    -- types: a1: userdata, a2: string, a3: number, a4: userdata, a5: userdata
    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = a2
    TextLabel.TextSize = a3
    TextLabel.FontFace = a4
    TextLabel.TextColor3 = a5
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
    TextLabel.Parent = a1

    return TextLabel
end

local function chip(a1, a2, a3, a4)
    -- Line: 130
    -- upvalues: u29 (val)
    -- types: a1: userdata, a2: number, a3: string, a4: userdata
    local TextLabel = Instance.new("TextLabel")
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.Size = UDim2.fromOffset(0, 18)
    TextLabel.LayoutOrder = a2
    TextLabel.BackgroundColor3 = u29.Palette.Card
    TextLabel.BorderSizePixel = 0
    TextLabel.Text = (" %* "):format(a3)
    TextLabel.TextColor3 = a4
    TextLabel.FontFace = u29.Font.Bold
    TextLabel.TextSize = 11
    TextLabel.Parent = a1

    u29.corner(TextLabel, 4)
end

local Green = u29.Palette.Green
local u110 = Color3.fromRGB(110, 180, 255)
local Gold = u29.Palette.Gold
local u117 = Color3.fromRGB(56, 34, 80)

local function button(a1, a2, a3, a4)
    -- Line: 157
    -- upvalues: u29 (val)
    -- types: a1: userdata, a2: string, a3: userdata?, a4: number
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromOffset(a4, u29.tap(30))
    TextButton.BorderSizePixel = 0
    TextButton.BackgroundColor3 = a3 or u29.Palette.Track
    local OnGold = if not a3 then u29.Palette.Text else u29.Palette.OnGold
    TextButton.TextColor3 = OnGold
    TextButton.FontFace = u29.Font.Bold
    TextButton.TextSize = 13
    TextButton.Text = a2
    TextButton.Parent = a1

    u29.corner(TextButton, 6)

    return TextButton
end

local function leaveFirst(a1) -- Line: 174; upvalues: u75 (ref), Config (val), u29 (val); types: a1: function
    if not u75 then
        a1()
        return
    end

    local LeaveWarning = Config.Place.Showroom.LeaveWarning
    u29.confirm(
        {
            danger = true,
            title = LeaveWarning.title,
            body = LeaveWarning.body,
            cancel = LeaveWarning.cancel,
            confirm = LeaveWarning.confirm,
        },
        function(a1_2) -- Line: 186; upvalues: a1 (val)
            if a1_2 then
                a1()
            end
        end
    )
end

local function buildCard(a1, a2)
    -- Line: 193
    -- upvalues: u65 (val), u29 (val), u117 (val), chip (val), u44 (val), Format (val), button (val), Green (val)
    -- upvalues: leaveFirst (val), u71 (ref), u61 (val)
    -- types: a1: table, a2: number
    local v1
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -12, 0, u65)
    Frame.LayoutOrder = a2
    Frame.BackgroundColor3 = u29.Palette.Track
    Frame.BorderSizePixel = 0

    u29.corner(Frame, u29.Radius.Row)

    if a1.vip then
        Frame.BackgroundColor3 = u117
    end

    if a1.here then
        v1 = u29.stroke(Frame, u29.Palette.Gold, 1)
        v1.Transparency = 0.4
    end

    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Size = UDim2.fromOffset(40, 40)
    ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
    ImageLabel.Position = UDim2.new(0, 10, 0.5, 0)
    ImageLabel.BackgroundColor3 = u29.Palette.Card
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=48&h=48"):format(a1.ownerUserId)
    ImageLabel.Parent = Frame

    u29.corner(ImageLabel, 20)

    local title = a1.title
    local Bold = u29.Font.Bold
    local Text = u29.Palette.Text
    v1 = Instance.new("TextLabel")
    v1.BackgroundTransparency = 1
    v1.Text = title
    v1.TextSize = 15
    v1.FontFace = Bold
    v1.TextColor3 = Text
    v1.TextXAlignment = Enum.TextXAlignment.Left
    v1.TextYAlignment = Enum.TextYAlignment.Center
    v1.TextTruncate = Enum.TextTruncate.AtEnd
    v1.Parent = Frame

    u29.asWritten(v1)

    v1.Position = UDim2.new(0, 60, 0.5, -20)
    v1.Size = UDim2.new(1, -326, 0, 20)
    local Frame_2 = Instance.new("Frame")
    Frame_2.BackgroundTransparency = 1
    Frame_2.Position = UDim2.new(0, 60, 0.5, 2)
    Frame_2.Size = UDim2.new(1, -326, 0, 18)
    Frame_2.ClipsDescendants = true
    Frame_2.Parent = Frame
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    UIListLayout.Parent = Frame_2
    local ownerName = a1.ownerName
    local Medium = u29.Font.Medium
    local Dim = u29.Palette.Dim
    local v2 = Instance.new("TextLabel")
    v2.BackgroundTransparency = 1
    v2.Text = ownerName
    v2.TextSize = 13
    v2.FontFace = Medium
    v2.TextColor3 = Dim
    v2.TextXAlignment = Enum.TextXAlignment.Left
    v2.TextYAlignment = Enum.TextYAlignment.Center
    v2.TextTruncate = Enum.TextTruncate.AtEnd
    v2.Parent = Frame_2

    u29.asWritten(v2)

    v2.AutomaticSize = Enum.AutomaticSize.X
    v2.Size = UDim2.fromOffset(0, 18)
    v2.LayoutOrder = 1

    chip(Frame_2, 2, string.upper(a1.category), u44[a1.category] or u29.Palette.Dim)

    if a1.coop then
        chip(Frame_2, 3, "CO-OP", u29.Palette.Green)
    end

    v2 = a1.cap <= a1.players

    local function stat(a1, a2, a3, a4, a5)
        -- Line: 257
        -- upvalues: Frame (val), u29 (upval)
        -- types: a1: string, a2: string?, a3: userdata, a4: userdata, a5: number
        local Frame_2 = Instance.new("Frame")
        Frame_2.BackgroundTransparency = 1
        Frame_2.AnchorPoint = Vector2.new(1, 0.5)
        Frame_2.Position = UDim2.new(1, -a5, 0.5, 0)
        Frame_2.Size = UDim2.fromOffset(70, 38)
        Frame_2.Parent = Frame
        local Bold = u29.Font.Bold
        local v1 = Instance.new("TextLabel")
        v1.BackgroundTransparency = 1
        v1.Text = a1
        v1.TextSize = 16
        v1.FontFace = Bold
        v1.TextColor3 = a4
        v1.TextXAlignment = Enum.TextXAlignment.Left
        v1.TextYAlignment = Enum.TextYAlignment.Center
        v1.TextTruncate = Enum.TextTruncate.AtEnd
        v1.Parent = Frame_2
        v1.Size = UDim2.new(1, 0, 0, 22)
        v1.TextXAlignment = Enum.TextXAlignment.Center

        if a2 then
            local Bold_2 = u29.Font.Bold
            v1 = Instance.new("TextLabel")
            v1.BackgroundTransparency = 1
            v1.Text = a2
            v1.TextSize = 16
            v1.FontFace = Bold_2
            v1.TextColor3 = a3
            v1.TextXAlignment = Enum.TextXAlignment.Left
            v1.TextYAlignment = Enum.TextYAlignment.Center
            v1.TextTruncate = Enum.TextTruncate.AtEnd
            v1.Parent = Frame_2
            v1.Position = UDim2.fromOffset(0, 21)
            v1.Size = UDim2.new(1, 0, 0, 16)
            v1.TextXAlignment = Enum.TextXAlignment.Center
        end
    end

    stat(("%* / %*"):format(a1.players, a1.cap), nil, u29.Palette.Faint, if not v2 then u29.Palette.Text else u29.Palette.Red, 188)
    stat(Format.comma(a1.likes), "♥", Color3.fromRGB(220, 70, 70), u29.Palette.Text, 112)

    if not a1.here then
        v1 = button(Frame, "VISIT", Green, 90)
        v1.AnchorPoint = Vector2.new(1, 0.5)
        v1.Position = UDim2.new(1, -12, 0.5, 0)
        local id = a1.id

        v1.Activated:Connect(function() -- Line: 298; upvalues: leaveFirst (upval), u71 (upval), u61 (upval), id (val)
            leaveFirst(function() -- Line: 299; upvalues: u71 (upval), u61 (upval), id (upval)
                u71.Text = "Taking you there..."
                u61:FireServer("visit", id)
            end)
        end)

        return Frame
    end

    local Bold_2 = u29.Font.Bold
    local Gold = u29.Palette.Gold
    v2 = Instance.new("TextLabel")
    v2.BackgroundTransparency = 1
    v2.Text = "YOU'RE HERE"
    v2.TextSize = 12
    v2.FontFace = Bold_2
    v2.TextColor3 = Gold
    v2.TextXAlignment = Enum.TextXAlignment.Left
    v2.TextYAlignment = Enum.TextYAlignment.Center
    v2.TextTruncate = Enum.TextTruncate.AtEnd
    v2.Parent = Frame
    v2.AnchorPoint = Vector2.new(1, 0.5)
    v2.Position = UDim2.new(1, -12, 0.5, 0)
    v2.Size = UDim2.fromOffset(90, 18)
    v2.TextXAlignment = Enum.TextXAlignment.Center

    return Frame
end

local function render()
    -- Line: 309
    -- upvalues: u69 (ref), u76 (ref), u77 (ref), buildCard (val), u70 (ref), u78 (val), u29 (val)
    local Gold, OnGold, v1

    for i, j in u69:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end

    local v2 = 0
    local v3 = nil
    local v4 = nil

    for k, n in u76, v3, v4 do
        if u77 == nil or n.category == u77 then
            v2 = v2 + 1
            v1 = buildCard(n, v2)
            v1.Parent = u69
        end
    end

    u70.Text = if not u77 then
        "No islands are published right now."
    else
        ("No %* are published right now."):format((string.lower(u77)))
    u70.Visible = v2 == 0
    v3 = nil
    v4 = nil

    for m, i5 in u78, v3, v4 do
        if m ~= "All" then
            v2 = m == u77
        else
            v2 = true

            if u77 ~= nil then
                v2 = m == u77
            end
        end

        Gold = if not v2 then u29.Palette.Track else u29.Palette.Gold
        i5.BackgroundColor3 = Gold
        OnGold = if not v2 then u29.Palette.Dim else u29.Palette.OnGold
        i5.TextColor3 = OnGold
    end
end

function u40.close() -- Line: 333; upvalues: u66 (ref), u68 (ref), BuildController (val), u84 (ref), u101 (ref)
    if not u66 then
        return
    end

    u66 = false
    u68.Visible = false

    BuildController.setUiOpen("Showrooms", false)
    u84()
    u101()
end

function u40.show() -- Line: 345; upvalues: u66 (ref), u68 (ref), BuildController (val), u29 (val)
    u66 = true
    u68.Visible = true

    BuildController.setUiOpen("Showrooms", true)
    u29.appear(u68)
end

function u40.toggle() -- Line: 353; upvalues: u66 (ref), u40 (val), u61 (val)
    if u66 then
        u40.close()
        return
    end

    u40.show()
    u61:FireServer("refresh")
end

local function buildPanel()
    -- Line: 362
    -- upvalues: u67 (ref), LocalPlayer (val), u68 (ref), u29 (val), u40 (val), Categories (val), button (val)
    -- upvalues: u78 (val), u77 (ref), render (val), Green (val), u69 (ref), u70 (ref), u71 (ref), u72 (ref), Gold (val)
    -- upvalues: u61 (val), u73 (ref), u74 (ref), Config (val), u93 (ref), u94 (ref), u110 (val), leaveFirst (val)
    u67 = Instance.new("ScreenGui")
    u67.Name = "AboveShowrooms"
    u67.ResetOnSpawn = false
    u67.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u68 = Instance.new("CanvasGroup")
    u68.Size = UDim2.fromOffset(560, 470)
    u68.Position = UDim2.new(0.5, -280, 0.5, -235)

    u29.fitToScreen(u68)

    u68.BackgroundColor3 = u29.Palette.Card
    u68.BackgroundTransparency = 0
    u68.Visible = false
    u68.Active = true
    u68.Parent = u67

    u29.corner(u68, 8)
    u29.stroke(u68, u29.Palette.Stroke, 1)

    local v1 = u68
    local Bold = u29.Font.Bold
    local Gold_2 = u29.Palette.Gold
    local v2 = Instance.new("TextLabel")
    v2.BackgroundTransparency = 1
    v2.Text = "PUBLISHED"
    v2.TextSize = 18
    v2.FontFace = Bold
    v2.TextColor3 = Gold_2
    v2.TextXAlignment = Enum.TextXAlignment.Left
    v2.TextYAlignment = Enum.TextYAlignment.Center
    v2.TextTruncate = Enum.TextTruncate.AtEnd
    v2.Parent = v1
    v2.Size = UDim2.new(1, -60, 0, 24)
    v2.Position = UDim2.fromOffset(16, 12)

    u29.closeButton(u68, 12, u40.close)

    local Frame = Instance.new("Frame")
    Frame.BackgroundTransparency = 1
    Frame.Position = UDim2.fromOffset(16, 46)
    Frame.Size = UDim2.new(1, -32, 0, u29.tap(28))
    Frame.Parent = u68
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.Parent = Frame

    for i, j in {"All", table.unpack(Categories)} do
        v1 = button(Frame, string.upper(j), nil, 86)
        v1.Size = UDim2.fromOffset(86, u29.tap(28))
        v1.LayoutOrder = i
        u78[j] = v1

        v1.Activated:Connect(function() -- Line: 402; upvalues: u77 (upval), j (val), render (upval)
            u77 = if j ~= "All" then j else nil
            render()
        end)
    end

    v2 = button(u68, "JOIN", Green, 90)
    v2.Size = UDim2.fromOffset(90, u29.tap(28))
    v2.AnchorPoint = Vector2.new(1, 0)
    v2.Position = UDim2.new(1, -16, 0, 46)

    v2.Activated:Connect(function() -- Line: 413; upvalues: u40 (upval)
        u40.showJoin(nil, nil)
    end)

    v2 = 46 + u29.tap(28) + 8
    u69 = Instance.new("ScrollingFrame")
    u69.Size = UDim2.new(1, -16, 1, -(v2 + 82))
    u69.Position = UDim2.fromOffset(10, v2)
    u69.BackgroundTransparency = 1
    u69.BorderSizePixel = 0
    u69.ScrollBarThickness = 4
    u69.ScrollBarImageColor3 = u29.Palette.Stroke
    u69.AutomaticCanvasSize = Enum.AutomaticSize.Y
    u69.CanvasSize = UDim2.new()
    u69.Parent = u68
    local UIListLayout_2 = Instance.new("UIListLayout")
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.Padding = UDim.new(0, 6)
    UIListLayout_2.Parent = u69
    local v3 = u68
    local Medium = u29.Font.Medium
    local Faint = u29.Palette.Faint
    local v4 = Instance.new("TextLabel")
    v4.BackgroundTransparency = 1
    v4.Text = "No islands are published right now."
    v4.TextSize = 14
    v4.FontFace = Medium
    v4.TextColor3 = Faint
    v4.TextXAlignment = Enum.TextXAlignment.Left
    v4.TextYAlignment = Enum.TextYAlignment.Center
    v4.TextTruncate = Enum.TextTruncate.AtEnd
    v4.Parent = v3
    u70 = v4
    u70.Size = UDim2.new(1, -32, 0, 20)
    u70.Position = UDim2.fromOffset(16, v2 + 18)
    u70.TextXAlignment = Enum.TextXAlignment.Center
    u70.Visible = false
    v3 = u68
    local Regular = u29.Font.Regular
    local Dim = u29.Palette.Dim
    v4 = Instance.new("TextLabel")
    v4.BackgroundTransparency = 1
    v4.Text = ""
    v4.TextSize = 13
    v4.FontFace = Regular
    v4.TextColor3 = Dim
    v4.TextXAlignment = Enum.TextXAlignment.Left
    v4.TextYAlignment = Enum.TextYAlignment.Center
    v4.TextTruncate = Enum.TextTruncate.AtEnd
    v4.Parent = v3
    u71 = v4
    u71.AnchorPoint = Vector2.new(0, 1)
    u71.Position = UDim2.new(0, 16, 1, -(14 + u29.tap(30) + 6))
    u71.Size = UDim2.new(1, -32, 0, 18)
    u72 = button(u68, "PUBLISH ISLAND", Gold, 150)
    u72.AnchorPoint = Vector2.new(0, 1)
    u72.Position = UDim2.new(0, 16, 1, -14)
    u72.Visible = false

    u72.Activated:Connect(function() -- Line: 453; upvalues: u72 (upval), u61 (upval)
        if u72.Active then
            u61:FireServer("openPublish")
        end
    end)

    v3 = u68
    local Bold_2 = u29.Font.Bold
    local Dim_2 = u29.Palette.Dim
    v4 = Instance.new("TextLabel")
    v4.BackgroundTransparency = 1
    v4.Text = ""
    v4.TextSize = 13
    v4.FontFace = Bold_2
    v4.TextColor3 = Dim_2
    v4.TextXAlignment = Enum.TextXAlignment.Left
    v4.TextYAlignment = Enum.TextYAlignment.Center
    v4.TextTruncate = Enum.TextTruncate.AtEnd
    v4.Parent = v3
    u73 = v4
    u73.RichText = true
    u73.AnchorPoint = Vector2.new(0, 1)
    u73.Position = UDim2.new(0, 176, 1, -14)
    u73.Size = UDim2.fromOffset(130, u29.tap(30))
    u73.Visible = false
    u74 = button(u68, "UNPUBLISH", u29.Palette.Red, 92)
    u74.AnchorPoint = Vector2.new(0, 1)
    u74.Visible = false

    u74.Activated:Connect(function() -- Line: 469; upvalues: Config (upval), u29 (upval), u61 (upval)
        local UnpublishWarning = Config.Place.Showroom.UnpublishWarning
        u29.confirm(
            {
                danger = true,
                title = UnpublishWarning.title,
                body = UnpublishWarning.body,
                cancel = UnpublishWarning.cancel,
                confirm = UnpublishWarning.confirm,
            },
            function(a1) -- Line: 477; upvalues: u61 (upval)
                if a1 then
                    u61:FireServer("unpublish")
                end
            end
        )
    end)

    v3 = u68
    local Bold_3 = u29.Font.Bold
    local Dim_3 = u29.Palette.Dim
    v4 = Instance.new("TextLabel")
    v4.BackgroundTransparency = 1
    v4.Text = "CODE"
    v4.TextSize = 12
    v4.FontFace = Bold_3
    v4.TextColor3 = Dim_3
    v4.TextXAlignment = Enum.TextXAlignment.Left
    v4.TextYAlignment = Enum.TextYAlignment.Center
    v4.TextTruncate = Enum.TextTruncate.AtEnd
    v4.Parent = v3
    u93 = v4
    u93.AnchorPoint = Vector2.new(0, 1)
    u93.Position = UDim2.new(0, 16, 1, -14)
    u93.Size = UDim2.fromOffset(40, u29.tap(30))
    u93.Visible = false
    u94 = Instance.new("TextBox")
    u94.AnchorPoint = Vector2.new(0, 1)
    u94.Position = UDim2.new(0, 56, 1, -14)
    u94.Size = UDim2.fromOffset(80, u29.tap(30))
    u94.BackgroundColor3 = Color3.fromRGB(34, 37, 46)
    u94.BorderSizePixel = 0
    u94.TextColor3 = u29.Palette.Gold
    u94.FontFace = u29.Font.Bold
    u94.TextSize = 16
    u94.TextEditable = false
    u94.ClearTextOnFocus = false
    u94.Visible = false
    u94.Parent = u68

    u29.corner(u94, 5)

    local v5 = button(u68, "RANDOM", u110, 120)
    v5.AnchorPoint = Vector2.new(1, 1)
    v5.Position = UDim2.new(1, -16, 1, -14)

    v5.Activated:Connect(function() -- Line: 510; upvalues: leaveFirst (upval), u71 (upval), u61 (upval), u77 (upval)
        leaveFirst(function() -- Line: 511; upvalues: u71 (upval), u61 (upval), u77 (upval)
            u71.Text = "Finding one..."
            u61:FireServer("random", u77)
        end)
    end)

    v5 = button(u68, "REFRESH", nil, 110)
    v5.AnchorPoint = Vector2.new(1, 1)
    v5.Position = UDim2.new(1, -144, 1, -14)

    v5.Activated:Connect(function() -- Line: 519; upvalues: u61 (upval)
        u61:FireServer("refresh")
    end)
end

local function chooseCategory(a1)
    -- Line: 526
    -- upvalues: DefaultCategory (ref), u92 (val), u44 (val), u29 (val)
    -- types: a1: string
    local Gold, OnGold, v1
    DefaultCategory = a1
    local v2 = nil
    local v3 = nil

    for i, j in u92, v2, v3 do
        Gold = if not (i == a1) then
            u29.Palette.Track
        else
            u44[i] or u29.Palette.Gold
        j.BackgroundColor3 = Gold
        OnGold = if not v1 then u29.Palette.Dim else u29.Palette.OnGold
        j.TextColor3 = OnGold
    end
end

function u84() -- Line: 535; upvalues: u80 (ref), u79 (ref), u81 (ref), BuildController (val)
    if not u80 then
        return
    end

    u80 = false
    u79.Visible = false
    u81.Visible = false

    BuildController.setUiOpen("ShowroomPublish", false)
end

local function showPublish(a1)
    -- Line: 545
    -- upvalues: u101 (ref), u80 (ref), u85 (ref), u88 (ref), u86 (ref), Config (val), u29 (val), u87 (ref)
    -- upvalues: chooseCategory (val), DefaultCategory (ref), u79 (ref), u81 (ref), BuildController (val)
    -- types: a1: table
    u101()

    u80 = true
    u85.Text = if not a1.update then "PUBLISH YOUR ISLAND" else "YOUR PUBLISHED ISLAND"
    u88.Text = if not a1.update then "PUBLISH" else "UPDATE"
    u86.Text = ("Letters, numbers and spaces. Up to %*."):format(Config.Place.Showroom.TitleMaxLength)
    u86.TextColor3 = u29.Palette.Faint
    u87.Text = Config.Place.sanitizeTitle(a1.title)

    chooseCategory(if not Config.Place.isCategory(a1.category) then DefaultCategory else a1.category)

    u79.Visible = true
    u81.Visible = true

    BuildController.setUiOpen("ShowroomPublish", true)
    u29.appear(u79)
end

local function buildPublish()
    -- Line: 560
    -- upvalues: u67 (ref), LocalPlayer (val), u81 (ref), u84 (ref), u101 (ref), u79 (ref), u29 (val), u85 (ref)
    -- upvalues: u87 (ref), Config (val), u86 (ref), Categories (val), button (val), u92 (val), chooseCategory (val)
    -- upvalues: u88 (ref), Green (val), u82 (ref), u61 (val), DefaultCategory (ref), u83 (ref)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AboveShowroomPublish"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = u67.DisplayOrder + 2
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local ScreenGui_2 = Instance.new("ScreenGui")
    ScreenGui_2.Name = "AboveShowroomBackdrop"
    ScreenGui_2.ResetOnSpawn = false
    ScreenGui_2.IgnoreGuiInset = true
    ScreenGui_2.ScreenInsets = Enum.ScreenInsets.None
    ScreenGui_2.DisplayOrder = u67.DisplayOrder + 1
    ScreenGui_2.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u81 = Instance.new("TextButton")
    u81.Name = "Backdrop"
    u81.Size = UDim2.fromScale(1, 1)
    u81.BackgroundColor3 = Color3.new(0, 0, 0)
    u81.BackgroundTransparency = 0.45
    u81.BorderSizePixel = 0
    u81.Text = ""
    u81.AutoButtonColor = false
    u81.Visible = false
    u81.Parent = ScreenGui_2

    u81.Activated:Connect(function() -- Line: 590; upvalues: u84 (upval), u101 (upval)
        u84()
        u101()
    end)

    u79 = Instance.new("CanvasGroup")
    u79.Size = UDim2.fromOffset(400, 300)
    u79.Position = UDim2.new(0.5, -200, 0.5, -150)

    u29.fitToScreen(u79)

    u79.BackgroundColor3 = u29.Palette.Card
    u79.Visible = false
    u79.Active = true
    u79.Parent = ScreenGui

    u29.corner(u79, 8)
    u29.stroke(u79, u29.Palette.Stroke, 1)

    local v1 = u79
    local Bold = u29.Font.Bold
    local Gold = u29.Palette.Gold
    local v2 = Instance.new("TextLabel")
    v2.BackgroundTransparency = 1
    v2.Text = ""
    v2.TextSize = 18
    v2.FontFace = Bold
    v2.TextColor3 = Gold
    v2.TextXAlignment = Enum.TextXAlignment.Left
    v2.TextYAlignment = Enum.TextYAlignment.Center
    v2.TextTruncate = Enum.TextTruncate.AtEnd
    v2.Parent = v1
    u85 = v2
    u85.Size = UDim2.new(1, -60, 0, 24)
    u85.Position = UDim2.fromOffset(16, 12)

    u29.closeButton(u79, 12, u84)

    v2 = u79
    local Bold_2 = u29.Font.Bold
    local Dim = u29.Palette.Dim
    local v3 = Instance.new("TextLabel")
    v3.BackgroundTransparency = 1
    v3.Text = "TITLE"
    v3.TextSize = 12
    v3.FontFace = Bold_2
    v3.TextColor3 = Dim
    v3.TextXAlignment = Enum.TextXAlignment.Left
    v3.TextYAlignment = Enum.TextYAlignment.Center
    v3.TextTruncate = Enum.TextTruncate.AtEnd
    v3.Parent = v2
    v3.Size = UDim2.new(1, -32, 0, 16)
    v3.Position = UDim2.fromOffset(16, 50)
    u87 = Instance.new("TextBox")
    u87.Size = UDim2.new(1, -32, 0, u29.tap(34))
    u87.Position = UDim2.fromOffset(16, 70)
    u87.BackgroundColor3 = Color3.fromRGB(34, 37, 46)
    u87.BorderSizePixel = 0
    u87.PlaceholderText = "Leave blank for your name's island"
    u87.TextColor3 = u29.Palette.Text
    u87.PlaceholderColor3 = u29.Palette.Dim
    u87.TextSize = 15
    u87.FontFace = u29.Font.Bold
    u87.TextXAlignment = Enum.TextXAlignment.Left
    u87.ClearTextOnFocus = false
    u87.Parent = u79

    u29.corner(u87, 5)

    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.Parent = u87

    ;(u87:GetPropertyChangedSignal("Text")):Connect(function() -- Line: 634; upvalues: Config (upval), u87 (upval)
        local v1 = Config.Place.sanitizeTitle(u87.Text)

        if v1 ~= u87.Text then
            u87.Text = v1
        end
    end)

    v1 = u79
    local Regular = u29.Font.Regular
    local Faint = u29.Palette.Faint
    v2 = Instance.new("TextLabel")
    v2.BackgroundTransparency = 1
    v2.Text = ""
    v2.TextSize = 12
    v2.FontFace = Regular
    v2.TextColor3 = Faint
    v2.TextXAlignment = Enum.TextXAlignment.Left
    v2.TextYAlignment = Enum.TextYAlignment.Center
    v2.TextTruncate = Enum.TextTruncate.AtEnd
    v2.Parent = v1
    u86 = v2
    u86.Size = UDim2.new(1, -32, 0, 16)
    u86.Position = UDim2.fromOffset(16, 70 + u29.tap(34) + 4)
    v3 = 70 + u29.tap(34) + 30
    v2 = u79
    local Bold_3 = u29.Font.Bold
    local Dim_2 = u29.Palette.Dim
    local v4 = Instance.new("TextLabel")
    v4.BackgroundTransparency = 1
    v4.Text = "CATEGORY"
    v4.TextSize = 12
    v4.FontFace = Bold_3
    v4.TextColor3 = Dim_2
    v4.TextXAlignment = Enum.TextXAlignment.Left
    v4.TextYAlignment = Enum.TextYAlignment.Center
    v4.TextTruncate = Enum.TextTruncate.AtEnd
    v4.Parent = v2
    v4.Size = UDim2.new(1, -32, 0, 16)
    v4.Position = UDim2.fromOffset(16, v3)
    v4 = Instance.new("Frame")
    v4.BackgroundTransparency = 1
    v4.Position = UDim2.fromOffset(16, v3 + 20)
    v4.Size = UDim2.new(1, -32, 0, u29.tap(32))
    v4.Parent = u79
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.Parent = v4

    for i, j in Categories do
        v3 = button(v4, string.upper(j), nil, 110)
        v3.Size = UDim2.fromOffset(110, u29.tap(32))
        v3.LayoutOrder = i
        u92[j] = v3

        v3.Activated:Connect(function() -- Line: 663; upvalues: chooseCategory (upval), j (val)
            chooseCategory(j)
        end)
    end

    v4 = button(u79, "CANCEL", nil, 110)
    v4.AnchorPoint = Vector2.new(0, 1)
    v4.Position = UDim2.new(0, 16, 1, -14)

    v4.Activated:Connect(u84)

    u88 = button(u79, "PUBLISH", Green, 140)
    u88.AnchorPoint = Vector2.new(1, 1)
    u88.Position = UDim2.new(1, -16, 1, -14)

    u88.Activated:Connect(function()
        -- Line: 677
        -- upvalues: u82 (upval), u86 (upval), u29 (upval), u61 (upval), Config (upval), u87 (upval)
        -- upvalues: DefaultCategory (upval), u83 (upval)
        if u82 then
            return
        end

        u82 = true
        u86.Text = "Checking..."
        u86.TextColor3 = u29.Palette.Dim

        u61:FireServer("publish", Config.Place.sanitizeTitle(u87.Text), DefaultCategory)

        local u21 = os.clock()
        u83 = u21

        task.delay(
            20,
            function() -- Line: 690; upvalues: u82 (upval), u83 (upval), u21 (val), u86 (upval), u29 (upval)
                if u82 and u83 == u21 then
                    u82 = false
                    u86.Text = "No answer from the server. Try again."
                    u86.TextColor3 = u29.Palette.Red
                end
            end
        )
    end)
end

function u101() -- Line: 702; upvalues: u96 (ref), u95 (ref), u81 (ref), BuildController (val)
    if not u96 then
        return
    end

    u96 = false
    u95.Visible = false
    u81.Visible = false

    BuildController.setUiOpen("ShowroomJoin", false)
end

function u40.showJoin(a1, a2)
    -- Line: 713
    -- upvalues: u84 (ref), u96 (ref), u99 (ref), u97 (ref), u98 (ref), Config (val), u29 (val), u95 (ref), u81 (ref)
    -- upvalues: BuildController (val)
    -- types: a1: string?, a2: string?
    u84()

    u96 = true
    u99 = false
    u97.Text = a1 or ""
    u98.Text = a2
        or ("The %*-character code of a published island."):format(Config.Place.Showroom.JoinCodeLength)
    u98.TextColor3 = u29.Palette.Faint
    u95.Visible = true
    u81.Visible = true

    BuildController.setUiOpen("ShowroomJoin", true)
    u29.appear(u95)
end

local function buildJoin()
    -- Line: 728
    -- upvalues: u67 (ref), LocalPlayer (val), u95 (ref), u29 (val), u101 (ref), u97 (ref), Config (val), u98 (ref)
    -- upvalues: button (val), Green (val), u99 (ref), leaveFirst (val), u61 (val), u100 (ref)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AboveShowroomJoin"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = u67.DisplayOrder + 2
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u95 = Instance.new("CanvasGroup")
    u95.Size = UDim2.fromOffset(340, 196)
    u95.Position = UDim2.new(0.5, -170, 0.5, -98)

    u29.fitToScreen(u95)

    u95.BackgroundColor3 = u29.Palette.Card
    u95.Visible = false
    u95.Active = true
    u95.Parent = ScreenGui

    u29.corner(u95, 8)
    u29.stroke(u95, u29.Palette.Stroke, 1)

    local v1 = u95
    local Bold = u29.Font.Bold
    local Gold = u29.Palette.Gold
    local v2 = Instance.new("TextLabel")
    v2.BackgroundTransparency = 1
    v2.Text = "JOIN AN ISLAND"
    v2.TextSize = 18
    v2.FontFace = Bold
    v2.TextColor3 = Gold
    v2.TextXAlignment = Enum.TextXAlignment.Left
    v2.TextYAlignment = Enum.TextYAlignment.Center
    v2.TextTruncate = Enum.TextTruncate.AtEnd
    v2.Parent = v1
    v2.Size = UDim2.new(1, -60, 0, 24)
    v2.Position = UDim2.fromOffset(16, 12)

    u29.closeButton(u95, 12, u101)

    u97 = Instance.new("TextBox")
    u97.Size = UDim2.new(1, -32, 0, u29.tap(40))
    u97.Position = UDim2.fromOffset(16, 50)
    u97.BackgroundColor3 = Color3.fromRGB(34, 37, 46)
    u97.BorderSizePixel = 0
    u97.PlaceholderText = "CODE"
    u97.TextColor3 = u29.Palette.Gold
    u97.PlaceholderColor3 = u29.Palette.Dim
    u97.TextSize = 22
    u97.FontFace = u29.Font.Bold
    u97.ClearTextOnFocus = false
    u97.Parent = u95

    u29.corner(u97, 5)

    ;(u97:GetPropertyChangedSignal("Text")):Connect(function() -- Line: 767; upvalues: Config (upval), u97 (upval)
        local v1 = Config.Place.typedJoinCode(u97.Text)

        if v1 ~= u97.Text then
            u97.Text = v1
        end
    end)

    local v3 = u95
    local Regular = u29.Font.Regular
    local Faint = u29.Palette.Faint
    v1 = Instance.new("TextLabel")
    v1.BackgroundTransparency = 1
    v1.Text = ""
    v1.TextSize = 12
    v1.FontFace = Regular
    v1.TextColor3 = Faint
    v1.TextXAlignment = Enum.TextXAlignment.Left
    v1.TextYAlignment = Enum.TextYAlignment.Center
    v1.TextTruncate = Enum.TextTruncate.AtEnd
    v1.Parent = v3
    u98 = v1
    u98.Size = UDim2.new(1, -32, 0, 16)
    u98.Position = UDim2.fromOffset(16, 50 + u29.tap(40) + 6)
    v2 = button(u95, "CANCEL", nil, 110)
    v2.AnchorPoint = Vector2.new(0, 1)
    v2.Position = UDim2.new(0, 16, 1, -14)

    v2.Activated:Connect(u101)

    v2 = button(u95, "JOIN", Green, 140)
    v2.AnchorPoint = Vector2.new(1, 1)
    v2.Position = UDim2.new(1, -16, 1, -14)

    local function submit()
        -- Line: 784
        -- upvalues: u99 (upval), Config (upval), u97 (upval), u98 (upval), u29 (upval), leaveFirst (upval), u61 (upval)
        -- upvalues: u100 (upval)
        if u99 then
            return
        end

        local u6 = Config.Place.cleanJoinCode(u97.Text)

        if u6 then
            leaveFirst(function()
                -- Line: 794
                -- upvalues: u99 (upval), u98 (upval), u29 (upval), u61 (upval), u6 (val), u100 (upval)
                u99 = true
                u98.Text = "Looking it up..."
                u98.TextColor3 = u29.Palette.Dim

                u61:FireServer("join", u6)

                local u14 = os.clock()
                u100 = u14

                task.delay(
                    15,
                    function() -- Line: 801; upvalues: u99 (upval), u100 (upval), u14 (val), u98 (upval), u29 (upval)
                        if u99 and u100 == u14 then
                            u99 = false
                            u98.Text = "No answer from the server. Try again."
                            u98.TextColor3 = u29.Palette.Red
                        end
                    end
                )
            end)
            return
        end

        u98.Text = ("A code is %* letters and numbers."):format(Config.Place.Showroom.JoinCodeLength)
        u98.TextColor3 = u29.Palette.Red
    end

    v2.Activated:Connect(submit)

    u97.FocusLost:Connect(function(a1) -- Line: 811; upvalues: submit (val)
        if a1 then
            submit()
        end
    end)
end

local function renderCode(a1) -- Line: 821; upvalues: u93 (ref), u94 (ref), u75 (ref), u72 (ref), u29 (val), u74 (ref)
    local v1, v2
    local v3 = false

    if type(a1) == "string" then
        v3 = a1 ~= ""
    end

    u93.Visible = v3
    u94.Visible = v3
    u94.Text = if not v3 then "" else a1
    u72.Position = UDim2.new(0, if not v3 then 16 else 144, 1, -14)
    u72.Size = UDim2.fromOffset(if not u75 then if not v3 then 150 else 120 else 56, u29.tap(30))
    u74.Visible = u75
    u74.Position = UDim2.new(0, v1 + v2 + 6, 1, -14)
end

local function renderPublishing(a1) -- Line: 836; upvalues: u75 (ref), u72 (ref), u73 (ref), u29 (val), Format (val)
    local state
    u75 = (if type(a1) ~= "table" then nil else a1.state) == "edit"
    u72.Visible = state ~= nil
    u73.Visible = state == "locked"

    if state == nil then
        return
    end

    local v1 = state == "locked"
    u72.Text = if state ~= "edit" then
        if state ~= "home" then "PUBLISH ISLAND" else "PUBLISH MINE"
    else
        "EDIT"
    u72.Active = not v1
    u72.AutoButtonColor = not v1
    local v2 = u72
    local Track = if not v1 then u29.Palette.Gold else u29.Palette.Track
    v2.BackgroundColor3 = Track
    v2 = u72
    local Faint = if not v1 then u29.Palette.OnGold else u29.Palette.Faint
    v2.TextColor3 = Faint

    if v1 then
        local v3 = if type(a1.need) ~= "number" then
            0
        else
            math.max(0, (math.floor(a1.need)))
        u73.Text = ("%* more <font color=\"#DC4646\">♥</font> required"):format((Format.comma(v3)))
    end
end

function u40.start()
    -- Line: 859
    -- upvalues: buildPanel (val), buildPublish (val), buildJoin (val), BuildController (val), u40 (val), u84 (ref)
    -- upvalues: u101 (ref), PanelTabs (val), u66 (ref), Categories (val), u77 (ref), render (val), u58 (val)
    -- upvalues: showPublish (val), u99 (ref), u98 (ref), u29 (val), u82 (ref), u86 (ref), u76 (ref), u71 (ref)
    -- upvalues: renderPublishing (val), renderCode (val), u61 (val)
    buildPanel()
    buildPublish()
    buildJoin()
    BuildController.registerClose("Showrooms", u40.close)
    BuildController.registerClose("ShowroomPublish", u84)
    BuildController.registerClose("ShowroomJoin", u101)

    PanelTabs.register(
        function() -- Line: 869; upvalues: u66 (upval)
            return u66
        end,
        function(a1) -- Line: 871; upvalues: Categories (upval), PanelTabs (upval), u77 (upval), render (upval)
            local v1 = {"All", (table.unpack(Categories))}
            local v2 = u77 or "All"
            local v3 = PanelTabs.neighbour(v1, v2, a1)

            if v3 then
                u77 = if v3 ~= "All" then v3 else nil
                render()
            end
        end
    )

    u58.OnClientEvent:Connect(function(a1)
        -- Line: 880
        -- upvalues: showPublish (upval), u99 (upval), u101 (upval), u40 (upval), u98 (upval), u29 (upval), u82 (upval)
        -- upvalues: u84 (upval), u86 (upval), u76 (upval), render (upval), u71 (upval), renderPublishing (upval)
        -- upvalues: renderCode (upval), u66 (upval)
        if type(a1) ~= "table" then
            return
        end

        local publish = a1.publish

        if type(publish) == "table"
            and type(publish.title) == "string"
            and type(publish.category) == "string" then
            showPublish({
                title = publish.title,
                category = publish.category,
                update = publish.update == true,
            })
            return
        end

        local joinResult = a1.joinResult

        if type(joinResult) == "table" then
            u99 = false

            if joinResult.ok then
                u101()
                u40.close()

                return
            end

            u98.Text = if type(joinResult.message) ~= "string" then
                "That didn't work"
            else
                joinResult.message
            u98.TextColor3 = u29.Palette.Red

            return
        end

        local publishResult = a1.publishResult

        if type(publishResult) == "table" then
            u82 = false

            if publishResult.ok then
                u84()
                return
            end

            u86.Text = if type(publishResult.message) ~= "string" then
                "That didn't work"
            else
                publishResult.message
            u86.TextColor3 = u29.Palette.Red

            return
        end

        if type(a1.cards) ~= "table" then
            return
        end

        u76 = a1.cards
        render()

        u71.Text = if type(a1.notice) ~= "string" then "" else a1.notice
        renderPublishing(a1.publishing)
        renderCode(a1.code)

        if a1.open and not u66 then
            u40.show()
        end
    end)

    task.spawn(function() -- Line: 928; upvalues: u66 (upval), u61 (upval)
        while true do
            task.wait(15)

            if u66 then
                u61:FireServer("refresh")
            end
        end
    end)
end

return u40