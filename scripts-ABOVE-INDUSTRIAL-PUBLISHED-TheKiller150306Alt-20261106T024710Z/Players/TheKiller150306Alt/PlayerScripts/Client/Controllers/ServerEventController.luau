-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ServerEventController
-- Decompile time: 8.42 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Format = require(Shared.Format)
local Remotes = require(Shared.Remotes)
local u36 = require(script.Parent.Parent.Ui)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u39 = {gather = "⛏️", kill = "⚔️"}
local u40 = {harvested = "🌾", picked = "🍇", chopped = "🪓"}
local u41 = {}
local Gold = u36.Palette.Gold
local v2 = Color3.fromRGB(205, 210, 222)
u41[1] = Gold
u41[2] = v2
u41[3] = Color3.fromRGB(214, 146, 92)

local function ordinal(a1) -- Line: 41; types: a1: number
    local v1 = a1 % 100

    if v1 >= 11 and v1 <= 13 then
        return (("%*th"):format(a1))
    end

    v1 = a1 % 10

    return (("%*%*"):format(a1, if v1 ~= 1 then if v1 ~= 2 then if v1 ~= 3 then "th" else "rd" else "nd" else "st"))
end

local function clock(a1) -- Line: 50; types: a1: number
    local v1 = math.max(0, (math.floor(a1)))
    return string.format("%d:%02d", v1 // 60, v1 % 60)
end

local function label(a1, a2, a3, a4) -- Line: 55; upvalues: u36 (val); types: a1: userdata, a2: number, a3: userdata
    local TextLabel = Instance.new("TextLabel")
    TextLabel.BackgroundTransparency = 1
    TextLabel.FontFace = a3
    TextLabel.TextSize = a2
    TextLabel.TextColor3 = u36.Palette.Text
    TextLabel.TextXAlignment = a4
    TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
    TextLabel.Parent = a1

    return TextLabel
end

function v1.start()
    -- Line: 67
    -- upvalues: LocalPlayer (val), u36 (val), Remotes (val), u40 (val), u39 (val), Format (val), u41 (val)
    -- upvalues: RunService (val), Workspace (val)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ServerEvent"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 2
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local u24 = u36.card(ScreenGui, UDim2.fromOffset(300, 0), UDim2.new(0.5, 0, 0, 8))
    u24.AnchorPoint = Vector2.new(0.5, 0)
    u24.AutomaticSize = Enum.AutomaticSize.Y
    u24.Visible = false
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 6)
    UIPadding.PaddingBottom = UDim.new(0, 8)
    UIPadding.PaddingLeft = UDim.new(0, 10)
    UIPadding.PaddingRight = UDim.new(0, 10)
    UIPadding.Parent = u24
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 2)
    UIListLayout.Parent = u24
    local Frame = Instance.new("Frame")
    Frame.LayoutOrder = 1
    Frame.Size = UDim2.new(1, 0, 0, 22)
    Frame.BackgroundTransparency = 1
    Frame.Parent = u24
    local Bold = u36.Font.Bold
    local Left = Enum.TextXAlignment.Left
    local u76 = Instance.new("TextLabel")
    u76.BackgroundTransparency = 1
    u76.FontFace = Bold
    u76.TextSize = 16
    u76.TextColor3 = u36.Palette.Text
    u76.TextXAlignment = Left
    u76.TextTruncate = Enum.TextTruncate.AtEnd
    u76.Parent = Frame
    u76.Size = UDim2.new(1, -86, 1, 0)
    u76.TextColor3 = u36.Palette.Gold
    local Bold_2 = u36.Font.Bold
    local Right = Enum.TextXAlignment.Right
    local u99 = Instance.new("TextLabel")
    u99.BackgroundTransparency = 1
    u99.FontFace = Bold_2
    u99.TextSize = 16
    u99.TextColor3 = u36.Palette.Text
    u99.TextXAlignment = Right
    u99.TextTruncate = Enum.TextTruncate.AtEnd
    u99.Parent = Frame
    u99.Size = UDim2.fromOffset(60, 22)
    u99.Position = UDim2.new(1, -82, 0, 0)
    local Bold_3 = u36.Font.Bold
    local Right_2 = Enum.TextXAlignment.Right
    local u123 = Instance.new("TextLabel")
    u123.BackgroundTransparency = 1
    u123.FontFace = Bold_3
    u123.TextSize = 18
    u123.TextColor3 = u36.Palette.Text
    u123.TextXAlignment = Right_2
    u123.TextTruncate = Enum.TextTruncate.AtEnd
    u123.Parent = Frame
    u123.Size = UDim2.fromOffset(16, 22)
    u123.Position = UDim2.new(1, -16, 0, 0)
    u123.TextColor3 = u36.Palette.Dim
    local TextButton = Instance.new("TextButton")
    TextButton.Name = "Fold"
    TextButton.BackgroundTransparency = 1
    TextButton.Text = ""
    TextButton.Size = UDim2.new(1, 20, 1, 12)
    TextButton.Position = UDim2.fromOffset(-10, -6)
    TextButton.ZIndex = 2
    TextButton.Parent = Frame
    local Bold_4 = u36.Font.Bold
    local Left_2 = Enum.TextXAlignment.Left
    local u167 = Instance.new("TextLabel")
    u167.BackgroundTransparency = 1
    u167.FontFace = Bold_4
    u167.TextSize = 13
    u167.TextColor3 = u36.Palette.Text
    u167.TextXAlignment = Left_2
    u167.TextTruncate = Enum.TextTruncate.AtEnd
    u167.Parent = u24
    u167.LayoutOrder = 2
    u167.Size = UDim2.new(1, 0, 0, 18)
    u167.TextColor3 = u36.Palette.Gold
    local Regular = u36.Font.Regular
    local Left_3 = Enum.TextXAlignment.Left
    local u191 = Instance.new("TextLabel")
    u191.BackgroundTransparency = 1
    u191.FontFace = Regular
    u191.TextSize = 12
    u191.TextColor3 = u36.Palette.Text
    u191.TextXAlignment = Left_3
    u191.TextTruncate = Enum.TextTruncate.AtEnd
    u191.Parent = u24
    u191.LayoutOrder = 3
    u191.Size = UDim2.new(1, 0, 0, 16)
    u191.TextColor3 = u36.Palette.Dim
    local Regular_2 = u36.Font.Regular
    local Left_4 = Enum.TextXAlignment.Left
    local u215 = Instance.new("TextLabel")
    u215.BackgroundTransparency = 1
    u215.FontFace = Regular_2
    u215.TextSize = 12
    u215.TextColor3 = u36.Palette.Text
    u215.TextXAlignment = Left_4
    u215.TextTruncate = Enum.TextTruncate.AtEnd
    u215.Parent = u24
    u215.LayoutOrder = 4
    u215.Size = UDim2.new(1, 0, 0, 16)
    u215.TextColor3 = u36.Palette.Faint
    u215.Text = "You joined after it started, so you're watching this one."
    local u233 = {}

    local function rowAt(a1) -- Line: 135; upvalues: u233 (val), u24 (val), u36 (upval); types: a1: number
        local v1 = u233[a1]

        if v1 then
            return v1
        end

        local Frame = Instance.new("Frame")
        Frame.LayoutOrder = a1 + 10
        Frame.Size = UDim2.new(1, 0, 0, 18)
        Frame.BackgroundTransparency = 1
        Frame.Parent = u24
        local Bold = u36.Font.Bold
        local Left = Enum.TextXAlignment.Left
        local v2 = Instance.new("TextLabel")
        v2.BackgroundTransparency = 1
        v2.FontFace = Bold
        v2.TextSize = 13
        v2.TextColor3 = u36.Palette.Text
        v2.TextXAlignment = Left
        v2.TextTruncate = Enum.TextTruncate.AtEnd
        v2.Parent = Frame
        v2.Size = UDim2.fromOffset(22, 18)
        local Regular = u36.Font.Regular
        local Left_2 = Enum.TextXAlignment.Left
        local v3 = Instance.new("TextLabel")
        v3.BackgroundTransparency = 1
        v3.FontFace = Regular
        v3.TextSize = 13
        v3.TextColor3 = u36.Palette.Text
        v3.TextXAlignment = Left_2
        v3.TextTruncate = Enum.TextTruncate.AtEnd
        v3.Parent = Frame
        v3.Size = UDim2.new(1, -132, 0, 18)
        v3.Position = UDim2.fromOffset(22, 0)
        local Bold_2 = u36.Font.Bold
        local Right = Enum.TextXAlignment.Right
        local v4 = Instance.new("TextLabel")
        v4.BackgroundTransparency = 1
        v4.FontFace = Bold_2
        v4.TextSize = 13
        v4.TextColor3 = u36.Palette.Text
        v4.TextXAlignment = Right
        v4.TextTruncate = Enum.TextTruncate.AtEnd
        v4.Parent = Frame
        v4.Size = UDim2.fromOffset(110, 18)
        v4.Position = UDim2.new(1, -110, 0, 0)
        v1 = {frame = Frame, place = v2, name = v3, count = v4}
        u233[a1] = v1

        return v1
    end

    local TouchOnly = u36.TouchOnly
    local u237 = false
    local u238 = 0

    local function applyFold()
        -- Line: 162
        -- upvalues: u123 (val), TouchOnly (ref), u167 (val), u191 (val), u215 (val), u237 (ref), u233 (val), u238 (ref)
        u123.Text = if not TouchOnly then "-" else "+"
        u167.Visible = TouchOnly
        u191.Visible = not TouchOnly
        u215.Visible = not TouchOnly and not u237
        local v1 = nil
        local v2 = nil

        for i, j in u233, v1, v2 do
            j.frame.Visible = not TouchOnly and i <= u238
        end
    end

    TextButton.Activated:Connect(function() -- Line: 171; upvalues: TouchOnly (ref), applyFold (val)
        TouchOnly = not TouchOnly
        applyFold()
    end)

    local u245 = 0
    ;(Remotes.get(Remotes.ServerEventUpdate)).OnClientEvent:Connect(function(a1)
        -- Line: 177
        -- upvalues: u24 (val), u245 (ref), u40 (upval), u39 (upval), u76 (val), u191 (val), u237 (ref), u167 (val)
        -- upvalues: Format (upval), rowAt (val), u41 (upval), u36 (upval), u238 (ref), applyFold (val)
        if type(a1) == "table" and a1.active == true then
            local Bold, Gold, name_4, name_5, v1, v2, v3, v4, v5, v6
            u245 = if type(a1.endsAt) ~= "number" then 0 else a1.endsAt
            u76.Text = ("%* %* EVENT"):format(u40[a1.verb] or u39[a1.kind] or "🎉", (string.upper((tostring(a1.label)))))
            u191.Text = ("Top 3 win %*"):format((tostring(a1.prizes or "")))
            u237 = a1.participating == true
            local board_2 = if type(a1.board) ~= "table" then {} else a1.board
            u167.Text = ""
            local v7 = board_2
            local v8 = nil
            local v9 = nil

            for i, j in v7, v8, v9 do
                if j.you then
                    v4 = if type(j.prize) ~= "number" or not (0 < j.prize) then
                        ""
                    else
                        ("  +%*"):format((Format.coins(j.prize)))
                    v2 = i % 100

                    if not (v2 >= 11) or not (v2 <= 13) then
                        v2 = i % 10
                        v3 = if v2 ~= 1 then
                            if v2 ~= 2 then if v2 ~= 3 then "th" else "rd" else "nd"
                        else
                            "st"
                        v1 = ("%*%*"):format(i, v3)
                    else
                        v1 = ("%*th"):format(i)
                    end

                    u167.Text = ("You: %* · %*%*"):format(v1, j.count or 0, v4)
                end
            end

            if u167.Text == "" then
                v7 = board_2[1]
                u167.Text = if not v7 then
                    "No one yet"
                else
                    ("Leader: %* · %*"):format(tostring(v7.name), v7.count or 0)
            end

            v8 = nil
            v9 = nil

            for k, n in board_2, v8, v9 do
                v4 = rowAt(k)
                v5 = false

                if type(n.count) == "number" then
                    v5 = 0 < n.count
                end

                v6 = if not v5 then nil else u41[k]
                v4.place.Text = ("%*."):format(k)
                v4.place.TextColor3 = v6 or u36.Palette.Faint
                v4.name.Text = tostring(n.name)

                u36.asWritten(v4.name)

                name_4 = v4.name
                Bold = if not n.you then u36.Font.Regular else u36.Font.Bold
                name_4.FontFace = Bold
                name_5 = v4.name
                Gold = if not n.you then u36.Palette.Text else u36.Palette.Gold
                name_5.TextColor3 = Gold
                v5 = if type(n.prize) ~= "number" or not (0 < n.prize) then
                    ""
                else
                    ("  +%*"):format((Format.coins(n.prize)))
                v4.count.Text = ("%*%*"):format(n.count or 0, v5)
                v4.count.TextColor3 = v6 or u36.Palette.Text
            end

            u238 = #board_2
            applyFold()

            u24.Visible = true

            return
        end

        u24.Visible = false
    end)

    local u261 = LocalPlayer:WaitForChild("PlayerGui")
    local u262 = {
        {gui = "AboveTopStrip", child = "Stats"},
        {gui = "MenuBar", child = "Frame"},
        {gui = "Tutorial", child = "Frame"},
        {gui = "Objective", child = "TextLabel"},
    }

    local function clearTop() -- Line: 240; upvalues: u24 (val), ScreenGui (val), u262 (val), u261 (val)
        local Y_2, v1, v2
        local X = u24.AbsolutePosition.X
        local v3 = X + u24.AbsoluteSize.X
        local Y = u24.AbsoluteSize.Y
        local UIScale = ScreenGui:FindFirstChildOfClass("UIScale")
        local Scale = if not UIScale then
            1
        else
            if not (0 < UIScale.Scale) then 1 else UIScale.Scale
        local v4 = {}
        local v5 = nil
        local v6 = nil

        for i, j in u262, v5, v6 do
            v2 = u261:FindFirstChild(j.gui)

            if v2 and v2:IsA("ScreenGui") and v2.Enabled then
                for k, n in v2:GetChildren() do
                    if n:IsA("GuiObject") and n.Visible then
                        if n.Name == j.child then
                            if n.AbsolutePosition.X < v3
                                and X < n.AbsolutePosition.X + n.AbsoluteSize.X then
                                Y_2 = n.AbsolutePosition.Y
                                table.insert(
                                    v4,
                                    {top = Y_2, bottom = Y_2 + n.AbsoluteSize.Y}
                                )
                            end
                        elseif n.ClassName == j.child
                            and n.AbsolutePosition.X < v3
                            and X < n.AbsolutePosition.X + n.AbsoluteSize.X then
                            Y_2 = n.AbsolutePosition.Y
                            table.insert(
                                v4,
                                {top = Y_2, bottom = Y_2 + n.AbsoluteSize.Y}
                            )
                        end
                    end
                end
            end
        end

        v3 = 8 * Scale
        local v7 = #v4 + 1

        for m = 1, v7 do
            v1 = false

            for i5, i6 in v4 do
                if i6.top < v3 + Y and v3 < i6.bottom then
                    v3 = i6.bottom + 6 * Scale
                    v1 = true
                end
            end

            if not v1 then
                break
            end
        end

        return v3 / Scale
    end

    RunService.Heartbeat:Connect(function()
        -- Line: 286
        -- upvalues: u24 (val), u99 (val), u245 (ref), Workspace (upval), clearTop (val)
        if u24.Visible then
            local v1 = math.max(0, (math.floor(u245 - Workspace:GetServerTimeNow())))
            u99.Text = string.format("%d:%02d", v1 // 60, v1 % 60)
            local v2 = clearTop()

            if u24.Position.Y.Offset ~= v2 then
                u24.Position = UDim2.new(0.5, 0, 0, v2)
            end
        end
    end)
end

return v1