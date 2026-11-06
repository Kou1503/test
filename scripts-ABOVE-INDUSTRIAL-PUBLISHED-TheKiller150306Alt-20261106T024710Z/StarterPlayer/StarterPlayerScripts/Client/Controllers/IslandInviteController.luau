-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.IslandInviteController
-- Decompile time: 3.12 ms

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u31 = require(script.Parent.Parent.Ui)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u37 = u31.tap(26) + 12
local u40 = Remotes.get(Remotes.RequestIslandInviteVisit)
local u41 = nil
local u42 = nil
local u43 = {}
local u44 = 0

local function dismiss(a1) -- Line: 34; upvalues: u43 (val); types: a1: string
    local v1 = u43[a1]

    if not v1 then
        return
    end

    u43[a1] = nil
    v1:Destroy()
end

local function show(a1)
    -- Line: 43
    -- upvalues: u43 (val), Config (val), u44 (ref), u31 (val), u42 (ref), u37 (val), u40 (val), TweenService (val)
    -- types: a1: table
    local id = a1.id
    local v1 = u43[id]

    if v1 then
        u43[id] = nil
        v1:Destroy()
    end

    local v2 = 0
    v1 = nil
    local LayoutOrder = (1 / 0)

    for i, j in u43 do
        v2 = v2 + 1

        if j.LayoutOrder < LayoutOrder then
            v1 = i
            LayoutOrder = j.LayoutOrder
        end
    end

    if Config.Friend.IslandInvite.MaxShown <= v2 and v1 then
        local v3 = u43[v1]

        if v3 then
            u43[v1] = nil
            v3:Destroy()
        end
    end

    u44 = u44 - 1
    local u47 = u31.card(u42, UDim2.fromOffset(300, u37), UDim2.new())
    u47.LayoutOrder = u44
    u47.Name = "Invite"
    u43[a1.id] = u47
    v2 = Instance.new("ImageLabel")
    v2.Size = UDim2.fromOffset(24, 24)
    v2.AnchorPoint = Vector2.new(0, 0.5)
    v2.Position = UDim2.new(0, 8, 0.5, 0)
    v2.BackgroundColor3 = Color3.fromRGB(40, 44, 56)
    v2.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=48&h=48"):format(a1.fromUserId)
    v2.Parent = u47

    u31.corner(v2, 12)

    v2 = UDim2.new(1, -(96 + u31.tap(26) + 20), 0, 0)
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = v2 + UDim2.fromScale(0, 0.5)
    TextLabel.Position = UDim2.fromOffset(38, 2)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
    TextLabel.TextColor3 = u31.Palette.Text
    TextLabel.TextSize = 13
    TextLabel.FontFace = u31.Font.Bold
    TextLabel.Text = a1.fromName

    u31.asWritten(TextLabel)

    TextLabel.Parent = u47
    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.Size = v2 + UDim2.fromScale(0, 0.5)
    TextLabel_2.Position = UDim2.new(0, 38, 0.5, 0)
    TextLabel_2.BackgroundTransparency = 1
    TextLabel_2.TextTruncate = Enum.TextTruncate.AtEnd
    TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel_2.TextYAlignment = Enum.TextYAlignment.Top
    TextLabel_2.TextColor3 = u31.Palette.Dim
    TextLabel_2.TextSize = 11
    TextLabel_2.FontFace = u31.Font.Regular
    TextLabel_2.Text = "invited you to their island"
    TextLabel_2.Parent = u47
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromOffset(52, u31.tap(24))
    TextButton.AnchorPoint = Vector2.new(1, 0.5)
    TextButton.Position = UDim2.new(1, -(u31.tap(26) + 16), 0.5, 0)
    TextButton.BackgroundColor3 = Color3.fromRGB(52, 140, 80)
    TextButton.Text = "Visit"
    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextButton.TextSize = u31.tapText(12)
    TextButton.FontFace = u31.Font.Bold
    TextButton.AutoButtonColor = true
    TextButton.Parent = u47

    u31.corner(TextButton, 6)

    TextButton.Activated:Connect(function() -- Line: 116; upvalues: u40 (upval), a1 (val), u43 (upval)
        u40:FireServer(a1.id)

        local id_2 = a1.id
        local v1 = u43[id_2]

        if not v1 then
            return
        end

        u43[id_2] = nil
        v1:Destroy()
    end)

    u31.closeButton(
        u47,
        (u37 - u31.tap(26)) / 2,
        function() -- Line: 122; upvalues: a1 (val), u43 (upval)
            local id = a1.id
            local v1 = u43[id]

            if not v1 then
                return
            end

            u43[id] = nil
            v1:Destroy()
        end
    )

    local v4 = math.max(1, a1.seconds)
    v2 = Instance.new("Frame")
    v2.Size = UDim2.new(1, -16, 0, 2)
    v2.Position = UDim2.new(0, 8, 1, -3)
    v2.BackgroundColor3 = u31.Palette.Gold
    v2.BorderSizePixel = 0
    v2.Parent = u47

    TweenService:Create(
        v2,
        TweenInfo.new(v4, Enum.EasingStyle.Linear),
        {Size = UDim2.fromOffset(0, 2)}
    ):Play()

    task.delay(
        v4,
        function() -- Line: 135; upvalues: u43 (upval), a1 (val), u47 (val)
            if u43[a1.id] == u47 then
                local id = a1.id
                local v1 = u43[id]

                if not v1 then
                    return
                end

                u43[id] = nil
                v1:Destroy()
            end
        end
    )
end

function v1.start()
    -- Line: 142
    -- upvalues: u41 (ref), LocalPlayer (val), u42 (ref), u37 (val), Remotes (val), show (val), Config (val)
    u41 = Instance.new("ScreenGui")
    u41.Name = "IslandInvites"
    u41.ResetOnSpawn = false
    u41.DisplayOrder = 6
    u41.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u42 = Instance.new("Frame")
    u42.Size = UDim2.fromOffset(300, 3 * (u37 + 6))
    u42.AnchorPoint = Vector2.new(1, 0.5)
    u42.Position = UDim2.new(1, -16, 0.5, 0)
    u42.BackgroundTransparency = 1
    u42.Parent = u41
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.Parent = u42

    ;(Remotes.get(Remotes.IslandInviteReceived)).OnClientEvent:Connect(function(a1)
        -- Line: 165
        -- upvalues: show (upval), Config (upval)
        if type(a1) == "table"
            and type(a1.id) == "string"
            and type(a1.fromUserId) == "number"
            and type(a1.fromName) == "string" then
            local v1 = show
            local v2 = {id = a1.id, fromUserId = a1.fromUserId, fromName = a1.fromName}
            local seconds_2 = if type(a1.seconds) ~= "number" then
                Config.Friend.IslandInvite.LifetimeSeconds
            else
                a1.seconds
            v2.seconds = seconds_2

            v1(v2)
        end
    end)
end

return v1