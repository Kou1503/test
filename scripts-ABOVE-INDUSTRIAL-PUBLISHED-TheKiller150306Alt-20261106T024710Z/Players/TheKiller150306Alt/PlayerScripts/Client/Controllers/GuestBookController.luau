-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.GuestBookController
-- Decompile time: 6.09 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u23 = Remotes.get(Remotes.RequestGuestBookLike)
local u26 = Remotes.get(Remotes.GuestBookOpened)
local u33 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local u39 = {}
local LocalPlayer = Players.LocalPlayer
local u41 = nil
local u42 = nil
local u43 = nil
local u44 = nil
local u45 = nil
local u46 = nil
local u47 = nil
local u48 = false

local function ago(a1) -- Line: 96; types: a1: number
    local v1 = math.max(0, (os.time()) - a1)

    if v1 < 60 then
        return "just now"
    end

    local v2 = math.floor(v1 / 60)

    if v2 < 60 then
        return (("%*m ago"):format(v2))
    end

    v1 = math.floor(v2 / 60)

    if v1 < 24 then
        return (("%*h ago"):format(v1))
    end

    v2 = math.floor(v1 / 24)

    if v2 < 7 then
        return (("%*d ago"):format(v2))
    end

    return (("%*w ago"):format((math.floor(v2 / 7))))
end

local u50 = {}
u50.VideoStar = {label = "VIDEO STAR", tint = u33.Palette.Violet}
u50.Dev = {label = "DEV", tint = u33.Palette.Violet}
u50.Verified = {label = "VERIFIED", tint = u33.Palette.Gold}
local u64 = Color3.fromRGB(255, 176, 64)

local function tagsFor(a1) -- Line: 136; upvalues: u64 (val), u50 (val), u33 (val); types: a1: table
    local v1 = {}

    if a1.vip then
        table.insert(
            v1,
            {label = "VIP", tint = u64}
        )
    end

    local v2 = if not a1.tier then nil else u50[a1.tier]

    if v2 then
        table.insert(
            v1,
            {label = v2.label, tint = v2.tint}
        )
        return v1
    end

    if a1.friend then
        table.insert(
            v1,
            {label = "FRIEND", tint = u33.Palette.Green}
        )
    end

    return v1
end

local function inReadingOrder(a1) -- Line: 156; upvalues: Config (val); types: a1: table
    local v1 = table.clone(a1)
    table.sort(
        v1,
        function(a1, a2) -- Line: 158; upvalues: Config (upval)
            local v1 = Config.GuestBook.rankOf(Config.GuestBook.sortTier(a1.tier, a1.vip))
            local v2 = Config.GuestBook.rankOf(Config.GuestBook.sortTier(a2.tier, a2.vip))

            if v1 ~= v2 then
                return v1 < v2
            end

            if a1.at ~= a2.at then
                return a2.at < a1.at
            end

            return a1.userId < a2.userId
        end
    )

    return v1
end

local function fillAvatar(a1, a2) -- Line: 177; types: a1: userdata, a2: number
    a1.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=48&h=48"):format(a2)
end

local function buildRow(a1, a2)
    -- Line: 181
    -- upvalues: u33 (val), tagsFor (val), ago (val)
    -- types: a1: table, a2: number
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -12, 0, 44)
    Frame.Position = UDim2.fromOffset(6, (a2 - 1) * 48 + 4)
    Frame.BackgroundColor3 = u33.Palette.Track
    Frame.BorderSizePixel = 0

    u33.corner(Frame, 6)

    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Size = UDim2.fromOffset(32, 32)
    ImageLabel.Position = UDim2.fromOffset(6, 6)
    ImageLabel.BackgroundColor3 = u33.Palette.Card
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Parent = Frame

    u33.corner(ImageLabel, 16)

    ImageLabel.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=48&h=48"):format(a1.userId)
    local v1 = tagsFor(a1)
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, if not (#v1 > 1) then -140 else -196, 0, 18)
    TextLabel.Position = UDim2.fromOffset(46, 5)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = a1.name

    u33.asWritten(TextLabel)

    TextLabel.TextColor3 = u33.Palette.Text
    TextLabel.FontFace = u33.Font.Medium
    TextLabel.TextSize = 14
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
    TextLabel.Parent = Frame
    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.Size = UDim2.new(1, -140, 0, 14)
    TextLabel_2.Position = UDim2.fromOffset(46, 22)
    TextLabel_2.BackgroundTransparency = 1
    TextLabel_2.Text = ago(a1.at)
    TextLabel_2.TextColor3 = u33.Palette.Faint
    TextLabel_2.FontFace = u33.Font.Regular
    TextLabel_2.TextSize = 12
    TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel_2.Parent = Frame

    if #v1 > 0 then
        local v2
        local Frame_2 = Instance.new("Frame")
        Frame_2.AutomaticSize = Enum.AutomaticSize.X
        Frame_2.Size = UDim2.fromOffset(0, 18)
        Frame_2.AnchorPoint = Vector2.new(1, 0.5)
        Frame_2.Position = UDim2.new(1, -10, 0.5, 0)
        Frame_2.BackgroundTransparency = 1
        Frame_2.Parent = Frame
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.FillDirection = Enum.FillDirection.Horizontal
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 4)
        UIListLayout.Parent = Frame_2

        for i, j in v1 do
            v2 = Instance.new("TextLabel")
            v2.AutomaticSize = Enum.AutomaticSize.X
            v2.Size = UDim2.fromOffset(0, 18)
            v2.LayoutOrder = i
            v2.BackgroundColor3 = u33.Palette.Card
            v2.BorderSizePixel = 0
            v2.Text = (" %* "):format(j.label)
            v2.TextColor3 = j.tint
            v2.FontFace = u33.Font.Bold
            v2.TextSize = 11
            v2.Parent = Frame_2

            u33.corner(v2, 4)
        end
    end

    return Frame
end

function u39.render(a1)
    -- Line: 260
    -- upvalues: u43 (ref), u44 (ref), u45 (ref), u33 (val), u46 (ref), Config (val), buildRow (val), u47 (ref)
    -- types: a1: table
    local v1
    u43.Text = ("%*'s island"):format(a1.owner)
    u44.Text = ("<font color=\"#DC4646\">♥</font>  %*"):format(a1.likes)

    if a1.mine then
        u45.Text = "YOUR ISLAND"
        u45.BackgroundColor3 = u33.Palette.Track
        u45.TextColor3 = u33.Palette.Faint
        u45.AutoButtonColor = false
    elseif not a1.liked then
        u45.Text = "LIKE ISLAND"
        u45.BackgroundColor3 = u33.Palette.Gold
        u45.TextColor3 = Color3.fromRGB(28, 24, 12)
        u45.AutoButtonColor = true
    else
        u45.Text = "LIKED"
        u45.BackgroundColor3 = u33.Palette.Track
        u45.TextColor3 = u33.Palette.Green
        u45.AutoButtonColor = false
    end

    for i, j in u46:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end

    local v2 = table.clone(a1.entries)
    table.sort(
        v2,
        function(a1, a2) -- Line: 158; upvalues: Config (upval)
            local v1 = Config.GuestBook.rankOf(Config.GuestBook.sortTier(a1.tier, a1.vip))
            local v2 = Config.GuestBook.rankOf(Config.GuestBook.sortTier(a2.tier, a2.vip))

            if v1 ~= v2 then
                return v1 < v2
            end

            if a1.at ~= a2.at then
                return a2.at < a1.at
            end

            return a1.userId < a2.userId
        end
    )

    for k, n in v2 do
        v1 = buildRow(n, k)
        v1.Parent = u46
    end

    u46.CanvasSize = UDim2.fromOffset(0, #a1.entries * 48 + 8)
    u47.Visible = #a1.entries == 0
    u47.Text = if not a1.mine then
        "Nobody has signed this one yet. You could be first."
    else
        "Nobody has signed yet. Invite a friend over and see what they think."
end

function u39.isOpen() -- Line: 302; upvalues: u48 (ref)
    return u48
end

function u39.close() -- Line: 306; upvalues: u48 (ref), u42 (ref), BuildController (val)
    if not u48 then
        return
    end

    u48 = false
    u42.Visible = false

    BuildController.setUiOpen("GuestBook", false)
end

function u39.show(a1)
    -- Line: 315
    -- upvalues: u39 (val), u48 (ref), u42 (ref), BuildController (val), u33 (val)
    -- types: a1: table
    u39.render(a1)

    u48 = true
    u42.Visible = true

    BuildController.setUiOpen("GuestBook", true)
    u33.appear(u42)
end

function u39.preview() -- Line: 329; upvalues: u39 (val)
    local v1 = os.time()
    u39.show({
        owner = "DVwastaken",
        likes = 6,
        liked = false,
        mine = false,
        entries = {
            {userId = 3, name = "Jane Doe", at = v1 - 30},
            {userId = 156, name = "A Very Long Display Name Indeed", friend = true, at = v1 - 1800},
            {userId = 261, name = "Shedletsky", tier = "Verified", at = v1 - 7200},
            {
                userId = 2,
                name = "John Doe",
                friend = true,
                tier = "Verified",
                at = v1 - 200000,
            },
            {userId = 1, name = "Builderman", at = v1 - 900000},
            {userId = 7, name = "Stickmasterluke", tier = "VideoStar", at = v1 - 4000000},
            {userId = 156, name = "A VIP Visitor", vip = true, at = v1 - 600},
            {
                userId = 4,
                name = "A VIP Friend",
                vip = true,
                friend = true,
                at = v1 - 300000,
            },
            {
                userId = 5,
                name = "A VIP Developer",
                vip = true,
                tier = "Dev",
                at = v1 - 500000,
            },
        },
    })
end

function u39.start()
    -- Line: 355
    -- upvalues: u41 (ref), LocalPlayer (val), u42 (ref), u33 (val), u43 (ref), u39 (val), u44 (ref), u45 (ref)
    -- upvalues: u46 (ref), u47 (ref), u23 (val), u26 (val)
    u41 = Instance.new("ScreenGui")
    u41.Name = "AboveGuestBook"
    u41.ResetOnSpawn = false
    u41.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u42 = Instance.new("CanvasGroup")
    u42.Size = UDim2.fromOffset(420, 480)
    u42.Position = UDim2.new(0.5, -210, 0.5, -240)

    u33.fitToScreen(u42)

    u42.BackgroundColor3 = u33.Palette.Card
    u42.BackgroundTransparency = 0
    u42.Visible = false
    u42.Active = true
    u42.Parent = u41

    u33.corner(u42, 8)
    u33.stroke(u42, u33.Palette.Stroke, 1)

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -60, 0, 24)
    TextLabel.Position = UDim2.fromOffset(16, 12)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "GUEST BOOK"
    TextLabel.TextColor3 = u33.Palette.Gold
    TextLabel.FontFace = u33.Font.Bold
    TextLabel.TextSize = 18
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = u42
    u43 = Instance.new("TextLabel")
    u43.Size = UDim2.new(1, -60, 0, 16)
    u43.Position = UDim2.fromOffset(16, 34)
    u43.BackgroundTransparency = 1
    u43.Text = ""
    u43.TextColor3 = u33.Palette.Dim
    u43.FontFace = u33.Font.Regular
    u43.TextSize = 13
    u43.TextXAlignment = Enum.TextXAlignment.Left
    u43.Parent = u42

    u33.closeButton(u42, 12, u39.close)

    u44 = Instance.new("TextLabel")
    u44.Size = UDim2.new(0.5, -20, 0, 38)
    u44.Position = UDim2.fromOffset(16, 66)
    u44.BackgroundTransparency = 1
    u44.Text = ""
    u44.TextColor3 = u33.Palette.Text
    u44.FontFace = u33.Font.Bold
    u44.TextSize = 20
    u44.RichText = true
    u44.TextXAlignment = Enum.TextXAlignment.Left
    u44.Parent = u42
    u45 = Instance.new("TextButton")
    u45.AnchorPoint = Vector2.new(1, 0)
    u45.Size = UDim2.new(0.5, -20, 0, 38)
    u45.Position = UDim2.new(1, -16, 0, 66)
    u45.BorderSizePixel = 0
    u45.Text = "LIKE ISLAND"
    u45.FontFace = u33.Font.Bold
    u45.TextSize = 15
    u45.Parent = u42

    u33.corner(u45, 6)

    u46 = Instance.new("ScrollingFrame")
    u46.Size = UDim2.new(1, -24, 1, -128)
    u46.Position = UDim2.fromOffset(12, 116)
    u46.BackgroundTransparency = 1
    u46.BorderSizePixel = 0
    u46.ScrollBarThickness = 4
    u46.ScrollBarImageColor3 = u33.Palette.Stroke
    u46.CanvasSize = UDim2.fromOffset(0, 0)
    u46.Parent = u42
    u47 = Instance.new("TextLabel")
    u47.Size = UDim2.new(1, -32, 0, 40)
    u47.Position = UDim2.fromOffset(16, 140)
    u47.BackgroundTransparency = 1
    u47.Text = ""
    u47.TextWrapped = true
    u47.TextColor3 = u33.Palette.Faint
    u47.FontFace = u33.Font.Regular
    u47.TextSize = 13
    u47.TextXAlignment = Enum.TextXAlignment.Left
    u47.TextYAlignment = Enum.TextYAlignment.Top
    u47.Visible = false
    u47.Parent = u42

    u45.Activated:Connect(function() -- Line: 456; upvalues: u45 (upval), u23 (upval)
        if u45.AutoButtonColor then
            u23:FireServer()
        end
    end)

    u26.OnClientEvent:Connect(function(a1) -- Line: 462; upvalues: u39 (upval)
        if type(a1) == "table" then
            u39.show(a1)
        end
    end)
end

return u39