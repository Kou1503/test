-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.BoostController
-- Decompile time: 3.03 ms

local Players = game:GetService("Players")
local DeviceMode = require(script.Parent.DeviceMode)
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Remotes = require(Shared.Remotes)
local u28 = require(script.Parent.Parent.Ui)
local ItemIcon = require(script.Parent.ItemIcon)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u40 = if not DeviceMode.touchOnly() then 24 else 230
local u41 = nil
local u42 = {}

local function clock(a1) -- Line: 42; types: a1: number
    local v1 = math.max(0, (math.ceil(a1)))

    if v1 < 60 then
        return (("%*s"):format(v1))
    end

    return string.format("%d:%02d", v1 // 60, v1 % 60)
end

local function describe(a1) -- Line: 51; types: a1: table
    local v1 = {}

    if 0 < a1.speedPercent then
        table.insert(v1, (("+%*%% speed"):format(a1.speedPercent)))
    end

    if 1 < a1.luck then
        table.insert(v1, (("x%* rare harvests"):format(a1.luck)))
    end

    if a1.effect then
        table.insert(v1, a1.effect)
    end

    return table.concat(v1, ", ")
end

local function layout() -- Line: 66; upvalues: u42 (ref)
    for i, j in u42 do
        j.frame.Position = UDim2.new(0, 0, 1, -i * 40)
    end
end

local function makeLine(a1)
    -- Line: 72
    -- upvalues: u41 (ref), u28 (val), ItemIcon (val), describe (val)
    -- types: a1: table
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromOffset(0, 36)
    Frame.AutomaticSize = Enum.AutomaticSize.X
    Frame.BackgroundColor3 = Color3.fromRGB(24, 27, 35)
    Frame.BackgroundTransparency = 0.15
    Frame.BorderSizePixel = 0
    Frame.Parent = u41

    u28.corner(Frame, 6)
    u28.stroke(Frame, Color3.fromRGB(70, 62, 30), 1)

    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingRight = UDim.new(0, 10)
    UIPadding.Parent = Frame
    local UISizeConstraint = Instance.new("UISizeConstraint")
    UISizeConstraint.MaxSize = Vector2.new(250, 36)
    UISizeConstraint.Parent = Frame
    local Frame_2 = Instance.new("Frame")
    Frame_2.Size = UDim2.fromOffset(22, 22)
    Frame_2.Position = UDim2.fromOffset(6, 7)
    Frame_2.BackgroundTransparency = 1
    Frame_2.Parent = Frame

    ItemIcon.render(Frame_2, a1.itemId, 22, 3)

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.fromOffset(0, 16)
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.Position = UDim2.fromOffset(34, 3)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = describe(a1)
    TextLabel.TextColor3 = Color3.fromRGB(235, 240, 250)
    TextLabel.FontFace = u28.Font.Bold
    TextLabel.TextSize = 12
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = Frame
    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.Size = UDim2.fromOffset(0, 14)
    TextLabel_2.AutomaticSize = Enum.AutomaticSize.X
    TextLabel_2.Position = UDim2.fromOffset(34, 19)
    TextLabel_2.BackgroundTransparency = 1
    TextLabel_2.TextColor3 = u28.Palette.Gold
    TextLabel_2.FontFace = u28.Font.Bold
    TextLabel_2.TextSize = 11
    TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel_2.Parent = Frame
    Frame.Name = a1.itemId

    return {boost = a1, frame = Frame, timer = TextLabel_2}
end

local function tick() -- Line: 125; upvalues: u42 (ref), layout (val)
    local timer, v1, v2
    local ServerTimeNow = workspace:GetServerTimeNow()
    local v3 = {}
    local v4 = nil
    local v5 = nil

    for i, j in u42, v4, v5 do
        v2 = j.boost.endsAt - ServerTimeNow

        if not (v2 <= 0) then
            timer = j.timer
            v1 = math.max(0, (math.ceil(v2)))
            timer.Text = if not (v1 < 60) then
                string.format("%d:%02d", v1 // 60, v1 % 60)
            else
                ("%*s"):format(v1)

            table.insert(v3, j)
        else
            j.frame:Destroy()
        end
    end

    if #v3 ~= #u42 then
        u42 = v3
        layout()
    end
end

local function show(a1)
    -- Line: 143
    -- upvalues: u42 (ref), makeLine (val), layout (val), tick (val)
    -- types: a1: table
    for i, j in u42 do
        j.frame:Destroy()
    end

    u42 = {}
    table.sort(
        a1,
        function(a1, a2) -- Line: 149
            return a1.endsAt < a2.endsAt
        end
    )

    for k, n in a1 do
        table.insert(u42, (makeLine(n)))
    end

    layout()
    tick()
end

function v1.start()
    -- Line: 159
    -- upvalues: LocalPlayer (val), u41 (ref), u40 (val), Remotes (val), show (val), u42 (ref), tick (val)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AboveBoosts"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u41 = Instance.new("Frame")
    u41.Size = UDim2.fromOffset(250, 200)
    u41.AnchorPoint = Vector2.new(0, 1)
    u41.Position = UDim2.new(0, 16, 1, -u40)
    u41.BackgroundTransparency = 1
    u41.Parent = ScreenGui

    ;(Remotes.get(Remotes.Boosts)).OnClientEvent:Connect(function(a1) -- Line: 172; upvalues: show (upval)
        if type(a1) ~= "table" then
            return
        end

        local v1 = {}
        local v2 = nil
        local v3 = nil

        for i, j in a1, v2, v3 do
            if type(j) == "table"
                and type(j.itemId) == "string"
                and type(j.speedPercent) == "number"
                and type(j.luck) == "number"
                and type(j.endsAt) == "number" then
                if j.effect == nil or type(j.effect) == "string" then
                    table.insert(v1, j)
                end
            end
        end

        show(v1)
    end)

    task.spawn(function() -- Line: 192; upvalues: u42 (upval), tick (upval)
        while true do
            task.wait(0.5)

            if #u42 > 0 then
                tick()
            end
        end
    end)
end

return v1