-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ToastController
-- Decompile time: 5.15 ms

local Players = game:GetService("Players")
local DeviceMode = require(script.Parent.DeviceMode)
local TweenService = game:GetService("TweenService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Format = require(Shared.Format)
local Palette = require(Shared.Palette)
local ItemIcon = require(script.Parent.ItemIcon)
local Remotes = require(Shared.Remotes)
local u47 = require(script.Parent.Parent.Ui)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u53 = Remotes.get(Remotes.InventoryChanged)
local v2 = DeviceMode.touchOnly()
local u57 = if not v2 then 6 else 3
local u60 = if not v2 then 120 else 200
local u61 = nil
local u62 = {}
local u63 = {}
local u64 = false

local function layout() -- Line: 86; upvalues: u62 (val), TweenService (val)
    local v1

    for i, j in u62 do
        v1 = UDim2.new(0, 0, 1, -(i - 1) * 37 - 33)
        TweenService:Create(
            j.frame,
            TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Position = v1}
        ):Play()
    end
end

local function remove(a1) -- Line: 98; upvalues: u62 (val), TweenService (val), layout (val); types: a1: table
    local v1
    local v2 = table.find(u62, a1)

    if not v2 then
        return
    end

    table.remove(u62, v2)

    v2 = TweenService:Create(
        a1.frame,
        TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {
            BackgroundTransparency = 1,
            Position = a1.frame.Position + UDim2.fromOffset(271, 0),
        }
    )
    TweenService:Create(
        a1.label,
        TweenInfo.new(0.18),
        {TextTransparency = 1}
    ):Play()

    for i, j in a1.frame:GetChildren() do
        if j:IsA("Frame") then
            v1 = TweenInfo.new(0.18)
            TweenService:Create(
                j,
                v1,
                {BackgroundTransparency = 1}
            ):Play()
        end
    end

    v2:Play()

    v2.Completed:Connect(function() -- Line: 120; upvalues: a1 (val)
        a1.frame:Destroy()
    end)

    layout()
end

local function setText(a1) -- Line: 126; upvalues: Palette (val); types: a1: table
    local v1 = if not a1.lost then "+" else "-"
    a1.label.Text = ("%*%*  %*"):format(v1, a1.amount, (Palette.displayName(a1.itemId)))
end

local function colorFor(a1) -- Line: 132; types: a1: boolean?
    if a1 then
        return (Color3.fromRGB(240, 120, 120))
    end

    return (Color3.fromRGB(235, 240, 250))
end

local function push(a1, a2, a3)
    -- Line: 136
    -- upvalues: u62 (val), Palette (val), u61 (ref), ItemIcon (val), u47 (val), u57 (val), remove (val), layout (val)
    -- types: a1: string, a2: number, a3: boolean?
    local v1
    local v2 = os.clock()

    for i, j in u62 do
        if j.itemId == a1 and j.lost == a3 then
            v1 = v2 - j.lastGainAt

            if v1 < 2.5 then
                j.amount = j.amount + a2
                j.lastGainAt = v2
                j.expiresAt = v2 + 3
                v1 = if not j.lost then "+" else "-"
                j.label.Text = ("%*%*  %*"):format(v1, j.amount, (Palette.displayName(j.itemId)))

                return
            end
        end
    end

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromOffset(231, 33)
    Frame.Position = UDim2.new(0, 271, 1, -33)
    Frame.BackgroundColor3 = Color3.fromRGB(24, 27, 34)
    Frame.BackgroundTransparency = 0.15
    Frame.BorderSizePixel = 0
    Frame.Parent = u61
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Frame
    local Frame_2 = Instance.new("Frame")
    Frame_2.Size = UDim2.fromOffset(22, 22)
    Frame_2.Position = UDim2.fromOffset(8, 6)
    Frame_2.BackgroundTransparency = 1
    Frame_2.Parent = Frame

    ItemIcon.render(Frame_2, a1, 22, 3)

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -37, 1, 0)
    TextLabel.Position = UDim2.fromOffset(33, 0)
    TextLabel.BackgroundTransparency = 1
    local v3 = if not a3 then Color3.fromRGB(235, 240, 250) else Color3.fromRGB(240, 120, 120)
    TextLabel.TextColor3 = v3
    TextLabel.FontFace = u47.Font.Bold
    TextLabel.TextSize = 14
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = Frame
    v3 = {
        itemId = a1,
        amount = a2,
        frame = Frame,
        label = TextLabel,
        lastGainAt = v2,
        expiresAt = v2 + 3,
        lost = a3,
    }
    local v4 = if not v3.lost then "+" else "-"
    v3.label.Text = ("%*%*  %*"):format(v4, v3.amount, (Palette.displayName(v3.itemId)))

    table.insert(u62, 1, v3)

    while true do
        if not (u57 < #u62) then
            break
        end

        remove(u62[#u62])
    end

    layout()
end

local function pushCoins(a1)
    -- Line: 213
    -- upvalues: u62 (val), Format (val), u61 (ref), Config (val), u47 (val), u57 (val), remove (val), layout (val)
    -- types: a1: number
    local v1 = os.clock()

    for i, j in u62 do
        if j.coins and v1 - j.lastGainAt < 2.5 then
            j.amount = j.amount + a1
            j.lastGainAt = v1
            j.expiresAt = v1 + 3
            j.label.Text = ("+%*  Coins"):format((Format.comma(j.amount)))

            return
        end
    end

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromOffset(231, 33)
    Frame.Position = UDim2.new(0, 271, 1, -33)
    Frame.BackgroundColor3 = Color3.fromRGB(24, 27, 34)
    Frame.BackgroundTransparency = 0.15
    Frame.BorderSizePixel = 0
    Frame.Parent = u61
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Frame
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Size = UDim2.fromOffset(22, 22)
    ImageLabel.Position = UDim2.fromOffset(8, 6)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = Config.Appearance.Icons.Coins or ""
    ImageLabel.ScaleType = Enum.ScaleType.Fit
    ImageLabel.Parent = Frame
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -37, 1, 0)
    TextLabel.Position = UDim2.fromOffset(33, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = u47.Palette.Gold
    TextLabel.FontFace = u47.Font.Bold
    TextLabel.TextSize = 14
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = ("+%*  Coins"):format((Format.comma(a1)))
    TextLabel.Parent = Frame

    table.insert(
        u62,
        1,
        {
            itemId = "Coins",
            coins = true,
            amount = a1,
            frame = Frame,
            label = TextLabel,
            lastGainAt = v1,
            expiresAt = v1 + 3,
        }
    )

    while true do
        if not (u57 < #u62) then
            break
        end

        remove(u62[#u62])
    end

    layout()
end

function v1.start()
    -- Line: 272
    -- upvalues: LocalPlayer (val), u61 (ref), u57 (val), u60 (val), u53 (val), u64 (ref), u63 (ref), push (val)
    -- upvalues: Remotes (val), pushCoins (val), u62 (val), remove (val)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AboveToasts"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u61 = Instance.new("Frame")
    u61.Size = UDim2.fromOffset(231, u57 * 37)
    u61.Position = UDim2.new(1, -247, 1, -(u57 * 37) - u60)
    u61.BackgroundTransparency = 1
    u61.Parent = ScreenGui

    u53.OnClientEvent:Connect(function(a1, a2, a3, a4, a5, a6)
        -- Line: 287
        -- upvalues: u64 (upval), u63 (upval), push (upval)
        -- types: a1: table
        local v1

        if not u64 then
            if a6 == true then
                u64 = true
            end

            u63 = table.clone(a1)

            return
        end

        for i, j in a1 do
            v1 = j - (u63[i] or 0)

            if v1 > 0 then
                push(i, v1)
            end
        end

        u63 = table.clone(a1)
    end)

    ;(Remotes.get(Remotes.ItemDropped)).OnClientEvent:Connect(function(a1, a2) -- Line: 312; upvalues: push (upval)
        if type(a1) == "string" and type(a2) == "number" and a2 > 0 then
            push(a1, a2, true)
        end
    end)

    local u49 = nil
    ;(Remotes.get(Remotes.CoinsChanged)).OnClientEvent:Connect(function(a1, a2, a3)
        -- Line: 324
        -- upvalues: u49 (ref), pushCoins (upval)
        -- types: a1: number, a2: number?, a3: boolean?
        if type(a1) ~= "number" then
            return
        end

        if a3 and u49 and u49 < a1 then
            pushCoins(a1 - u49)
        end

        u49 = a1
    end)

    task.spawn(function() -- Line: 334; upvalues: u62 (upval), remove (upval)
        local v1

        while true do
            task.wait(0.2)

            v1 = os.clock()

            for i = #u62, 1, -1 do
                if u62[i].expiresAt <= v1 then
                    remove(u62[i])
                end
            end
        end
    end)
end

return v1