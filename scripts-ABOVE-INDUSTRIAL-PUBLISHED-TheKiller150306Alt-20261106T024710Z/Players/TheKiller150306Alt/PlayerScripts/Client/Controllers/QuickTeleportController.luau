-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.QuickTeleportController
-- Decompile time: 29.39 ms

local fill
local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u31 = require(script.Parent.Parent.Ui)
local u32 = {}
local LocalPlayer = Players.LocalPlayer
local u36 = Remotes.get(Remotes.RequestFriendAction)
local u39 = Remotes.get(Remotes.RequestDevCommand)
local u43 = u31.tap(22) + 6
local u44 = nil
local u45 = nil
local u46 = 0
local u47 = false
local zero = Vector2.zero
local u49 = 0
local u50 = nil
local u51 = {}

local function setShown(a1) -- Line: 55; upvalues: u44 (ref), u51 (val); types: a1: boolean
    local v1 = u44

    if v1 and v1.Visible ~= a1 then
        v1.Visible = a1

        for i, j in u51 do
            task.spawn(j)
        end
    end
end

local function close() -- Line: 65; upvalues: u44 (ref), u51 (val)
    local v1 = u44

    if v1 and v1.Visible ~= false then
        v1.Visible = false

        for i, j in u51 do
            task.spawn(j)
        end
    end
end

local function isStaff() -- Line: 69; upvalues: LocalPlayer (val), Config (val)
    local v1 = true

    if LocalPlayer:GetAttribute(Config.Release.AdminAttribute) ~= true then
        v1 = LocalPlayer:GetAttribute(Config.Player.ModAttribute) == true
    end

    return v1
end

local function staffButton(a1, a2, a3) -- Line: 74; upvalues: u31 (val); types: a1: userdata, a2: string, a3: number
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromOffset(40, u31.tap(22))
    TextButton.AnchorPoint = Vector2.new(1, 0.5)
    TextButton.Position = UDim2.new(1, -a3, 0.5, 0)
    TextButton.BackgroundColor3 = Color3.fromRGB(70, 74, 92)
    TextButton.Text = a2
    TextButton.TextColor3 = u31.Palette.Text
    TextButton.TextSize = u31.tapText(11)
    TextButton.FontFace = u31.Font.Bold
    TextButton.Parent = a1

    u31.corner(TextButton, 5)

    return TextButton
end

function fill()
    -- Line: 89
    -- upvalues: u45 (ref), Config (val), Players (val), LocalPlayer (val), u50 (ref), u43 (val), u31 (val), u36 (val)
    -- upvalues: u44 (ref), u51 (val), staffButton (val), u39 (val), fill (val)
    local DisplayName_2, Frame, ImageLabel, TextButton, TextLabel, v1, v2
    local v3 = u45

    for i, j in v3:GetChildren() do
        if j:IsA("GuiObject") then
            j:Destroy()
        end
    end

    local v4 = {}

    for k, n in Players:GetPlayers() do
        if n ~= LocalPlayer
            and n:GetAttribute(Config.Place.Showroom.VisitorAttribute) ~= true then
            table.insert(v4, n)
        end
    end

    table.sort(
        v4,
        function(a1, a2) -- Line: 109
            return (string.lower(a1.DisplayName)) < string.lower(a2.DisplayName)
        end
    )

    table.insert(v4, 1, LocalPlayer)

    local v5 = true

    if LocalPlayer:GetAttribute(Config.Release.AdminAttribute) ~= true then
        v5 = LocalPlayer:GetAttribute(Config.Player.ModAttribute) == true
    end

    if u50 and not Players:GetPlayerByUserId(u50) then
        u50 = nil
    end

    local v6 = if not v5 then 0 else 88
    local v7 = nil
    local v8 = nil

    for m, i5 in v4, v7, v8 do
        Frame = Instance.new("Frame")
        Frame.LayoutOrder = m
        Frame.Size = UDim2.new(1, -6, 0, u43 - 4)
        Frame.BackgroundColor3 = Color3.fromRGB(32, 35, 44)
        Frame.BorderSizePixel = 0
        Frame.Parent = v3

        u31.corner(Frame, 6)

        ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Size = UDim2.fromOffset(20, 20)
        ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
        ImageLabel.Position = UDim2.new(0, 4, 0.5, 0)
        ImageLabel.BackgroundColor3 = Color3.fromRGB(44, 48, 60)
        ImageLabel.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=48&h=48"):format(i5.UserId)
        ImageLabel.Parent = Frame

        u31.corner(ImageLabel, 10)

        TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, -(v6 + 84), 1, 0)
        TextLabel.Position = UDim2.fromOffset(30, 0)
        TextLabel.BackgroundTransparency = 1
        DisplayName_2 = if i5 ~= LocalPlayer then
            i5.DisplayName
        else
            ("%* (you)"):format(i5.DisplayName)
        TextLabel.Text = DisplayName_2

        u31.asWritten(TextLabel)

        TextLabel.TextColor3 = u31.Palette.Text
        TextLabel.TextSize = 12
        TextLabel.FontFace = u31.Font.Medium
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
        TextLabel.Parent = Frame
        TextButton = Instance.new("TextButton")
        TextButton.Size = UDim2.fromOffset(48, u31.tap(22))
        TextButton.AnchorPoint = Vector2.new(1, 0.5)
        TextButton.Position = UDim2.new(1, -4 - v6, 0.5, 0)
        TextButton.BackgroundColor3 = u31.Palette.Gold

        if i5 == LocalPlayer then
            u270 = true
        else
            local u270 = false
        end

        TextButton.Text = if not u270 then "Visit" else "Home"
        TextButton.TextColor3 = u31.Palette.OnGold
        TextButton.TextSize = u31.tapText(11)
        TextButton.FontFace = u31.Font.Bold
        TextButton.Parent = Frame

        u31.corner(TextButton, 5)

        local UserId = i5.UserId
        TextButton.Activated:Connect(function()
            -- Line: 162
            -- upvalues: u270 (val), u36 (upval), UserId (val), u44 (upval), u51 (upval)
            if not u270 then
                u36:FireServer("Visit", UserId)
            else
                u36:FireServer("Home")
            end

            local v1 = u44

            if v1 and v1.Visible ~= false then
                v1.Visible = false

                for i, j in u51 do
                    task.spawn(j)
                end
            end
        end)

        if v5 and not u270 then
            local Name = i5.Name
            ;(staffButton(Frame, "TP", 48)).Activated:Connect(function()
                -- Line: 175
                -- upvalues: u39 (upval), Name (val), u44 (upval), u51 (upval)
                u39:FireServer("tp", Name)

                local v1 = u44

                if v1 and v1.Visible ~= false then
                    v1.Visible = false

                    for i, j in u51 do
                        task.spawn(j)
                    end
                end
            end)

            v2 = staffButton(Frame, if not (u50 == UserId) then "SPEC" else "STOP", 4)

            if v1 then
                v2.BackgroundColor3 = u31.Palette.Gold
                v2.TextColor3 = u31.Palette.OnGold
            end

            v2.Activated:Connect(function()
                -- Line: 185
                -- upvalues: u50 (upval), UserId (val), u39 (upval), Name (val), fill (upval)
                if u50 ~= UserId then
                    u50 = UserId
                    u39:FireServer("spectate", Name)
                else
                    u50 = nil
                    u39:FireServer("spectate", nil)
                end

                fill()
            end)
        end
    end

    v5 = u44
    local v9 = math.max(1, #v4)
    v7 = v5:FindFirstAncestorWhichIsA("LayerCollector")
    v8 = if not (0 < v5.Size.X.Offset) then
        1
    else
        v5.AbsoluteSize.X / v5.Size.X.Offset

    if v7 and v8 > 0 then
        v9 = math.min(v9, (math.max(1, (math.floor(((v7.AbsoluteSize.Y - v5.AbsolutePosition.Y - 8) / v8 - 8) / u43)))))
    end

    v3.CanvasSize = UDim2.fromOffset(0, (math.max(1, #v4)) * u43)
    v5.Size = UDim2.fromOffset(v6 + 190, v9 * u43 + 8)
end

local function open() -- Line: 214; upvalues: u44 (ref), fill (val), u51 (val)
    if not u44 then
        return
    end

    fill()

    local v1 = u44

    if v1 and v1.Visible ~= true then
        v1.Visible = true

        for i, j in u51 do
            task.spawn(j)
        end
    end
end

local function closeSoon() -- Line: 223; upvalues: u49 (ref), u46 (ref), u44 (ref), u51 (val)
    u49 = u49 + 1
    local u2 = u49

    task.delay(
        0.3,
        function() -- Line: 226; upvalues: u2 (val), u49 (upval), u46 (upval), u44 (upval), u51 (upval)
            if u2 == u49 and u46 <= 0 then
                local v1 = u44

                if v1 and v1.Visible ~= false then
                    v1.Visible = false

                    for i, j in u51 do
                        task.spawn(j)
                    end
                end
            end
        end
    )
end

local function hoverInto(a1) -- Line: 233; upvalues: u46 (ref), u49 (ref), u44 (ref), u51 (val); types: a1: userdata
    a1.MouseEnter:Connect(function() -- Line: 234; upvalues: u46 (upval), u49 (upval)
        u46 = u46 + 1
        u49 = u49 + 1
    end)

    a1.MouseLeave:Connect(function() -- Line: 238; upvalues: u46 (upval), u49 (upval), u44 (upval), u51 (upval)
        u46 = math.max(0, u46 - 1)
        u49 = u49 + 1
        local u7 = u49

        task.delay(
            0.3,
            function() -- Line: 226; upvalues: u7 (val), u49 (upval), u46 (upval), u44 (upval), u51 (upval)
                if u7 == u49 and u46 <= 0 then
                    local v1 = u44

                    if v1 and v1.Visible ~= false then
                        v1.Visible = false

                        for i, j in u51 do
                            task.spawn(j)
                        end
                    end
                end
            end
        )
    end)
end

function u32.orient(a1) -- Line: 253; upvalues: u44 (ref), zero (ref); types: a1: boolean
    local v1 = u44

    if not v1 then
        return
    end

    if a1 then
        v1.AnchorPoint = Vector2.new(1, 0)
        v1.Position = UDim2.new(0.5, zero.X, 0.5, zero.Y + 8)

        return
    end

    v1.AnchorPoint = Vector2.new(0, 0)
    v1.Position = UDim2.new(0.5, zero.X + 10, 0.5, -zero.Y)
end

function u32.attach(a1, a2, a3)
    -- Line: 268
    -- upvalues: u31 (val), u44 (ref), zero (ref), u32 (val), u47 (ref), u45 (ref), hoverInto (val), open (val)
    -- upvalues: ContextActionService (val), u51 (val), fill (val), Config (val), Players (val)
    -- types: a1: userdata, a2: boolean, a3: boolean
    local VisitorAttribute
    local u12 = u31.card(a1, UDim2.fromOffset(190, 80), UDim2.new())
    u12.Name = "QuickTeleport"
    u12.Visible = false
    u12.Active = true
    u12.ZIndex = 20
    u44 = u12
    zero = Vector2.new(a1.Size.X.Offset, a1.Size.Y.Offset) / 2

    u32.orient(a2)

    u47 = a3
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, -8, 1, -8)
    ScrollingFrame.Position = UDim2.fromOffset(4, 4)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.ScrollBarThickness = 4
    ScrollingFrame.ZIndex = 21
    ScrollingFrame.Parent = u12
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 4)
    UIListLayout.Parent = ScrollingFrame
    u45 = ScrollingFrame

    u12.DescendantAdded:Connect(function(a1) -- Line: 297
        if a1:IsA("GuiObject") then
            a1.ZIndex = 22
        end
    end)

    if not a3 then
        hoverInto(a1)
        hoverInto(u12)
        a1.MouseEnter:Connect(open)
    end

    local C = Enum.KeyCode.C
    ContextActionService:BindAction(
        "AboveQuickTeleport",
        function(a1, a2) -- Line: 310; upvalues: u12 (val), u44 (upval), u51 (upval), fill (upval)
            if a2 == Enum.UserInputState.Begin then
                local v1

                if u12.Visible then
                    v1 = u44

                    if v1 and v1.Visible ~= false then
                        v1.Visible = false

                        for k, n in u51 do
                            task.spawn(n)
                        end
                    end
                elseif u44 then
                    fill()

                    v1 = u44

                    if v1 and v1.Visible ~= true then
                        v1.Visible = true

                        for i, j in u51 do
                            task.spawn(j)
                        end
                    end
                end
            end

            return Enum.ContextActionResult.Sink
        end,
        false,
        C
    )

    local function refill() -- Line: 322; upvalues: u12 (val), fill (upval)
        if u12.Visible then
            fill()
        end
    end

    local function watch(a1) -- Line: 327; upvalues: Config (upval), refill (val); types: a1: userdata
        (a1:GetAttributeChangedSignal(Config.Place.Showroom.VisitorAttribute)):Connect(refill)
    end

    for i, j in Players:GetPlayers() do
        VisitorAttribute = Config.Place.Showroom.VisitorAttribute
        ;(j:GetAttributeChangedSignal(VisitorAttribute)):Connect(refill)
    end

    Players.PlayerAdded:Connect(function(a1)
        -- Line: 333
        -- upvalues: Config (upval), refill (val), u12 (val), fill (upval)
        (a1:GetAttributeChangedSignal(Config.Place.Showroom.VisitorAttribute)):Connect(refill)

        if u12.Visible then
            fill()
        end
    end)

    Players.PlayerRemoving:Connect(function() -- Line: 337; upvalues: u12 (val), fill (upval)
        task.defer(function() -- Line: 338; upvalues: u12 (upval), fill (upval)
            if u12.Visible then
                fill()
            end
        end)
    end)
end

function u32.close() -- Line: 347; upvalues: u44 (ref), u51 (val)
    local v1 = u44

    if v1 and v1.Visible ~= false then
        v1.Visible = false

        for i, j in u51 do
            task.spawn(j)
        end
    end
end

function u32.isOpen() -- Line: 351; upvalues: u44 (ref)
    local v1 = u44
    local Visible = false

    if v1 ~= nil then
        Visible = v1.Visible
    end

    return Visible
end

function u32.onToggled(a1) -- Line: 356; upvalues: u51 (val); types: a1: function
    table.insert(u51, a1)
end

function u32.press() -- Line: 362; upvalues: u44 (ref), u47 (ref), u51 (val), fill (val)
    local v1
    local v2 = u44

    if v2 and v2.Visible and u47 then
        v1 = u44

        if v1 and v1.Visible ~= false then
            v1.Visible = false

            for i, j in u51 do
                task.spawn(j)
            end

            return
        end

        return
    end

    if not u44 then
        return
    end

    fill()

    v1 = u44

    if v1 and v1.Visible ~= true then
        v1.Visible = true

        for k, n in u51 do
            task.spawn(n)
        end
    end
end

return u32