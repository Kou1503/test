-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.AchievementsController
-- Decompile time: 12.61 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)

require(Shared.Config.AchievementConfig)

local Format = require(Shared.Format)
local Palette = require(Shared.Palette)
local Remotes = require(Shared.Remotes)
local u36 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local AudioController = require(script.Parent.AudioController)
local u47 = {}
local LocalPlayer = Players.LocalPlayer
local u52 = Remotes.get(Remotes.RequestAchievements)
local u55 = Remotes.get(Remotes.AchievementData)
local u56 = nil
local u57 = nil
local u58 = nil
local u59 = nil
local u60 = {}
local u65 = Color3.fromRGB(150, 158, 178)
local u70 = Color3.fromRGB(238, 240, 248)
local u75 = Color3.fromRGB(255, 214, 110)
local u80 = Color3.fromRGB(140, 225, 175)
local u85 = Color3.fromRGB(132, 198, 255)

function u47.isOpen() -- Line: 64; upvalues: u57 (ref)
    local Visible = false

    if u57 ~= nil then
        Visible = u57.Visible
    end

    return Visible
end

local function label(a1, a2, a3, a4, a5, a6)
    -- Line: 70
    -- upvalues: u36 (val)
    -- types: a1: userdata, a2: string, a3: userdata, a4: userdata, a5: userdata, a6: number
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = a3
    TextLabel.Position = a4
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = a2
    TextLabel.TextColor3 = a5
    TextLabel.TextSize = a6
    TextLabel.FontFace = u36.Font.Regular
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = a1

    return TextLabel
end

local function rewardText(a1) -- Line: 87; upvalues: Palette (val), Format (val)
    local v1 = {}

    if a1.boundItem then
        table.insert(v1, (string.upper((Palette.displayName(a1.boundItem)))))
    end

    if a1.maxHealth then
        table.insert(v1, (("+%* MAX HEALTH"):format(a1.maxHealth)))
    end

    if a1.bonus then
        table.insert(v1, (("+%*%% %*"):format(a1.bonus.percent, (string.upper((Palette.displayName(a1.bonus.stat)))))))
    end

    table.insert(v1, (("%* COINS"):format((Format.comma(a1.coins)))))

    return table.concat(v1, "   ·   ")
end

local u89 = nil
local u90 = nil
local u91 = nil
local u92 = 0

local function buildBanner(a1)
    -- Line: 116
    -- upvalues: u36 (val), u90 (ref), u91 (ref), u89 (ref)
    -- types: a1: userdata
    local Frame = Instance.new("Frame")
    Frame.Name = "AchievementBanner"
    Frame.AnchorPoint = Vector2.new(0.5, 0)
    Frame.Position = UDim2.new(0.5, 0, 0, 136)
    Frame.Size = UDim2.fromOffset(380, 78)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    Frame.BackgroundTransparency = 0.08
    Frame.BorderSizePixel = 0
    Frame.Visible = false
    Frame.Parent = a1

    u36.corner(Frame, u36.Radius.Card)

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = u36.Palette.Gold
    UIStroke.Transparency = 0.35
    UIStroke.Thickness = 1.5
    UIStroke.Parent = Frame
    local v1 = UDim2.new(1, -20, 0, 16)
    local v2 = UDim2.fromOffset(10, 8)
    local Gold = u36.Palette.Gold
    local v3 = Instance.new("TextLabel")
    v3.Size = v1
    v3.Position = v2
    v3.BackgroundTransparency = 1
    v3.Text = "ACHIEVEMENT UNLOCKED"
    v3.TextColor3 = Gold
    v3.TextSize = 12
    v3.FontFace = u36.Font.Regular
    v3.TextXAlignment = Enum.TextXAlignment.Left
    v3.Parent = Frame
    v2 = UDim2.new(1, -20, 0, 22)
    local v4 = UDim2.fromOffset(10, 26)
    local Text = u36.Palette.Text
    v1 = Instance.new("TextLabel")
    v1.Size = v2
    v1.Position = v4
    v1.BackgroundTransparency = 1
    v1.Text = ""
    v1.TextColor3 = Text
    v1.TextSize = 17
    v1.FontFace = u36.Font.Regular
    v1.TextXAlignment = Enum.TextXAlignment.Left
    v1.Parent = Frame
    u90 = v1
    v2 = UDim2.new(1, -20, 0, 18)
    v4 = UDim2.fromOffset(10, 52)
    local v5 = Color3.fromRGB(150, 200, 255)
    v1 = Instance.new("TextLabel")
    v1.Size = v2
    v1.Position = v4
    v1.BackgroundTransparency = 1
    v1.Text = ""
    v1.TextColor3 = v5
    v1.TextSize = 13
    v1.FontFace = u36.Font.Regular
    v1.TextXAlignment = Enum.TextXAlignment.Left
    v1.Parent = Frame
    u91 = v1
    u89 = Frame
end

local function showUnlocked(a1, a2)
    -- Line: 141
    -- upvalues: Config (val), u89 (ref), u90 (ref), u91 (ref), Format (val), rewardText (val), u36 (val)
    -- upvalues: AudioController (val), u92 (ref)
    -- types: a1: string, a2: number
    local v1 = nil

    for i, j in Config.Achievement.Families do
        if j.id == a1 then
            v1 = j
        end
    end

    local v2 = v1 and v1.tiers[a2]
    local u20 = u89
    local v3 = u90
    local v4 = u91

    if v1 and v2 and u20 and v3 and v4 then
        v3.Text = ("%* %*  ·  %* %*"):format(v1.title, Config.Achievement.numeral(a2), Format.comma(v2.amount), v1.unit)
        v4.Text = rewardText(v2)
        u20.Visible = true

        u36.appear(u20)
        AudioController.play("Crafted")

        u92 = u92 + 1
        local u55 = u92

        task.delay(
            5,
            function() -- Line: 160; upvalues: u55 (val), u92 (upval), u20 (val)
                if u55 == u92 then
                    u20.Visible = false
                end
            end
        )
    end
end

local function renderFamily(a1, a2)
    -- Line: 190
    -- upvalues: u60 (ref), Config (val), u58 (ref), u36 (val), u80 (val), u70 (val), u65 (val), u75 (val), Format (val)
    -- upvalues: rewardText (val), u85 (val)
    -- types: a2: number
    local Frame_2, Frame_3, v1, v2, v3
    local v4 = u60[a1.id] or {earned = 0, total = 0}
    local v5 = #a1.tiers
    local v6 = v5 <= v4.earned
    local v7 = Config.Achievement.tierOf(a1, v4.earned + 1)
    local amount = if not (0 < v4.earned) then
        0
    else
        Config.Achievement.tierOf(a1, v4.earned).amount
    local amount_2 = if not v7 then amount else v7.amount
    local v8 = if not v6 then
        math.clamp((v4.total - amount) / math.max(1, amount_2 - amount), 0, 1)
    else
        1
    local v9 = Instance.new("Frame")
    v9.Size = UDim2.new(1, -12, 0, 96)
    v9.Position = UDim2.fromOffset(0, a2)
    v9.BackgroundColor3 = Color3.fromRGB(30, 33, 42)
    v9.BorderSizePixel = 0
    v9.Parent = u58

    u36.corner(v9, 8)

    local v10 = if not v6 then 1 else 2
    u36.stroke(v9, if not v6 then Color3.fromRGB(52, 57, 72) else u80, v10)

    local v11 = string.upper(a1.title)
    local v12 = UDim2.new(1, -120, 0, 18)
    v10 = UDim2.fromOffset(12, 10)
    local v13 = Instance.new("TextLabel")
    v13.Size = v12
    v13.Position = v10
    v13.BackgroundTransparency = 1
    v13.Text = v11
    v13.TextColor3 = u70
    v13.TextSize = 14
    v13.FontFace = u36.Font.Regular
    v13.TextXAlignment = Enum.TextXAlignment.Left
    v13.Parent = v9
    v13.FontFace = u36.Font.Bold

    if 0 < v4.earned or v6 then
        v11 = if not v6 then
            ("TIER %*"):format((Config.Achievement.numeral(v4.earned)))
        else
            "MAX"
        v12 = UDim2.fromOffset(100, 18)
        v10 = UDim2.new(1, -112, 0, 10)
        v13 = Instance.new("TextLabel")
        v13.Size = v12
        v13.Position = v10
        v13.BackgroundTransparency = 1
        v13.Text = v11
        v13.TextColor3 = if not v6 then u65 else u80
        v13.TextSize = 12
        v13.FontFace = u36.Font.Regular
        v13.TextXAlignment = Enum.TextXAlignment.Left
        v13.Parent = v9
        v13.FontFace = u36.Font.Bold
        v13.TextXAlignment = Enum.TextXAlignment.Right
    end

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -24, 0, 10)
    Frame.Position = UDim2.fromOffset(12, 34)
    Frame.BackgroundTransparency = 1
    Frame.Parent = v9

    for i = 1, v5 do
        Frame_2 = Instance.new("Frame")
        Frame_2.Size = UDim2.new(1 / v5, (v5 - 1) * -3 / v5, 1, 0)
        Frame_2.Position = UDim2.new((i - 1) / v5, (i - 1) * 3 / v5, 0, 0)
        Frame_2.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
        Frame_2.BorderSizePixel = 0
        Frame_2.Parent = Frame

        u36.corner(Frame_2, 3)

        v3 = if not (i <= v4.earned) then if i ~= v4.earned + 1 then 0 else v8 else 1

        if not (v3 <= 0) then
            Frame_3 = Instance.new("Frame")
            Frame_3.Size = UDim2.fromScale(v3, 1)
            Frame_3.BackgroundColor3 = if not v6 then u75 else u80
            Frame_3.BorderSizePixel = 0
            Frame_3.Parent = Frame_2

            u36.corner(Frame_3, 3)
        end
    end

    v11 = if not v6 then
        ("<b>%* / %*</b> <font color=\"rgb(150,158,178)\">%*</font>"):format(Format.comma(v4.total), Format.comma(amount_2), v1.unit)
    else
        ("<b>%*</b> <font color=\"rgb(150,158,178)\">%*</font>"):format(Format.comma(v4.total), v1.unit)
    v12 = UDim2.new(1, -24, 0, 18)
    v10 = UDim2.fromOffset(12, 50)
    v8 = Instance.new("TextLabel")
    v8.Size = v12
    v8.Position = v10
    v8.BackgroundTransparency = 1
    v8.Text = v11
    v8.TextColor3 = u70
    v8.TextSize = 14
    v8.FontFace = u36.Font.Regular
    v8.TextXAlignment = Enum.TextXAlignment.Left
    v8.Parent = v9
    v8.RichText = true

    if v7 then
        v12 = ("<font color=\"rgb(126,133,152)\">NEXT</font>  %*"):format((rewardText(v7)))
        v10 = UDim2.new(1, -24, 0, 16)
        local v14 = UDim2.fromOffset(12, 68)
        v11 = Instance.new("TextLabel")
        v11.Size = v10
        v11.Position = v14
        v11.BackgroundTransparency = 1
        v11.Text = v12
        v11.TextColor3 = u85
        v11.TextSize = 11
        v11.FontFace = u36.Font.Regular
        v11.TextXAlignment = Enum.TextXAlignment.Left
        v11.Parent = v9
        v11.RichText = true
        v11.FontFace = u36.Font.Bold
    end

    return v2 + 96 + 10
end

local function render() -- Line: 289; upvalues: u58 (ref), Config (val), renderFamily (val), u60 (ref), u59 (ref)
    local v1

    for i, j in u58:GetChildren() do
        if j:IsA("Frame") or j:IsA("TextLabel") then
            j:Destroy()
        end
    end

    local v2 = 0
    local v3 = 0
    local v4 = nil
    local v5 = nil

    for k, n in Config.Achievement.Families, v4, v5 do
        v2 = renderFamily(n, v2)
        v1 = u60[n.id] or {earned = 0}
        v3 = v3 + v1.earned
    end

    u58.CanvasSize = UDim2.fromOffset(0, v2)
    v2 = #Config.Achievement.Families * #Config.Achievement.TierNumerals
    u59.Text = ("%* of %* tiers earned"):format(v3, v2)
end

function u47.close() -- Line: 308; upvalues: u57 (ref), BuildController (val)
    local Visible = false

    if u57 ~= nil then
        Visible = u57.Visible
    end

    if not Visible then
        return
    end

    u57.Visible = false
    BuildController.setUiOpen("Achievements", false)
end

function u47.open() -- Line: 316; upvalues: u57 (ref), u36 (val), BuildController (val), u52 (val), render (val)
    u57.Visible = true
    u36.appear(u57)
    BuildController.setUiOpen("Achievements", true)
    u52:FireServer()
    render()
end

function u47.toggle() -- Line: 324; upvalues: u57 (ref), u47 (val)
    local Visible = false

    if u57 ~= nil then
        Visible = u57.Visible
    end

    if Visible then
        u47.close()
        return
    end

    u47.open()
end

function u47.start()
    -- Line: 332
    -- upvalues: BuildController (val), u47 (val), u56 (ref), LocalPlayer (val), u57 (ref), u36 (val), u70 (val)
    -- upvalues: u59 (ref), u58 (ref), buildBanner (val), Remotes (val), showUnlocked (val), u55 (val), u60 (ref)
    -- upvalues: render (val)
    BuildController.registerMenu("Achievements", u47.close)

    u56 = Instance.new("ScreenGui")
    u56.Name = "Achievements"
    u56.ResetOnSpawn = false
    u56.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u57 = Instance.new("CanvasGroup")
    u57.Size = UDim2.fromOffset(460, 520)
    u57.Position = UDim2.new(0.5, -230, 0.5, -260)

    u36.fitToScreen(u57)

    u57.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    u57.BackgroundTransparency = 0.05
    u57.BorderSizePixel = 0
    u57.Visible = false
    u57.Active = true
    u57.Parent = u56

    u36.closeButton(u57, 10, u47.close)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = u57
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(58, 62, 78)
    UIStroke.Parent = u57
    local v1 = u57
    local v2 = UDim2.new(1, -28, 0, 20)
    local v3 = UDim2.fromOffset(14, 10)
    local v4 = Instance.new("TextLabel")
    v4.Size = v2
    v4.Position = v3
    v4.BackgroundTransparency = 1
    v4.Text = "ACHIEVEMENTS"
    v4.TextColor3 = u70
    v4.TextSize = 17
    v4.FontFace = u36.Font.Regular
    v4.TextXAlignment = Enum.TextXAlignment.Left
    v4.Parent = v1
    v4.FontFace = u36.Font.Bold
    v2 = u57
    v3 = UDim2.new(1, -28, 0, 14)
    local v5 = UDim2.fromOffset(14, 36)
    local v6 = Color3.fromRGB(126, 133, 152)
    v1 = Instance.new("TextLabel")
    v1.Size = v3
    v1.Position = v5
    v1.BackgroundTransparency = 1
    v1.Text = ""
    v1.TextColor3 = v6
    v1.TextSize = 11
    v1.FontFace = u36.Font.Regular
    v1.TextXAlignment = Enum.TextXAlignment.Left
    v1.Parent = v2
    u59 = v1
    u58 = Instance.new("ScrollingFrame")
    u58.Size = UDim2.new(1, -20, 1, -84)
    u58.Position = UDim2.fromOffset(10, 74)
    u58.BackgroundTransparency = 1
    u58.BorderSizePixel = 0
    u58.ScrollBarThickness = 5
    u58.Parent = u57

    buildBanner(u56)

    ;(Remotes.get(Remotes.AchievementUnlocked)).OnClientEvent:Connect(function(a1, a2)
        -- Line: 379
        -- upvalues: showUnlocked (upval)
        if type(a1) == "string" and type(a2) == "number" then
            showUnlocked(a1, a2)
        end
    end)

    u55.OnClientEvent:Connect(function(a1) -- Line: 385; upvalues: u60 (upval), u57 (upval), render (upval)
        if type(a1) ~= "table" then
            return
        end

        u60 = a1
        local Visible = false

        if u57 ~= nil then
            Visible = u57.Visible
        end

        if Visible then
            render()
        end
    end)
end

return u47