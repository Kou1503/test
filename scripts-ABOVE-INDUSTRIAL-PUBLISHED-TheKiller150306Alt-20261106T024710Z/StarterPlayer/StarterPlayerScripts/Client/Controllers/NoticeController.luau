-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.NoticeController
-- Decompile time: 2.12 ms

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u31 = require(script.Parent.Parent.Ui)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u34 = nil
local u35 = {}

local function rgb(a1) -- Line: 34; types: a1: table
    return Color3.fromRGB(a1.r, a1.g, a1.b)
end

local function reflow() -- Line: 40; upvalues: u35 (val), TweenService (val)
    local v1, v2, v3

    for i, j in u35 do
        v2 = (#u35 - i) * 40
        v3 = TweenInfo.new(0.16, Enum.EasingStyle.Quad)
        v1 = {Position = UDim2.new(0, 12, 1, -150 - v2)}

        TweenService:Create(j, v3, v1):Play()
    end
end

local function dismiss(a1)
    -- Line: 49
    -- upvalues: u35 (val), reflow (val), Config (val), TweenService (val)
    -- types: a1: userdata
    local v1 = table.find(u35, a1)

    if not v1 then
        return
    end

    table.remove(u35, v1)
    reflow()

    TweenService:Create(
        a1,
        TweenInfo.new(Config.Notice.FadeSeconds, Enum.EasingStyle.Quad),
        {GroupTransparency = 1}
    ):Play()

    task.delay(
        Config.Notice.FadeSeconds,
        function() -- Line: 59; upvalues: a1 (val)
            a1:Destroy()
        end
    )
end

local function show(a1, a2)
    -- Line: 64
    -- upvalues: Config (val), u31 (val), u34 (ref), u35 (val), dismiss (val), reflow (val), TweenService (val)
    -- types: a1: string, a2: string
    local v1 = Config.Notice.Tones[a2]
        or Config.Notice.Tones[Config.Notice.DefaultTone]
    local CanvasGroup = Instance.new("CanvasGroup")
    CanvasGroup.Size = UDim2.fromOffset(260, 34)
    CanvasGroup.Position = UDim2.new(0, 12, 1, -150)
    CanvasGroup.BackgroundColor3 = u31.Palette.Card
    CanvasGroup.BackgroundTransparency = u31.Palette.CardTransparency
    CanvasGroup.BorderSizePixel = 0
    CanvasGroup.GroupTransparency = 1
    CanvasGroup.Parent = u34

    u31.corner(CanvasGroup, 6)

    local stroke = u31.stroke
    local color = v1.color

    stroke(CanvasGroup, Color3.fromRGB(color.r, color.g, color.b), 1)

    v1 = Instance.new("TextLabel")
    v1.Size = UDim2.new(1, -20, 1, 0)
    v1.Position = UDim2.fromOffset(10, 0)
    v1.BackgroundTransparency = 1
    v1.Text = a1
    v1.TextColor3 = u31.Palette.Text
    v1.FontFace = u31.Font.Medium
    v1.TextSize = 13
    v1.TextXAlignment = Enum.TextXAlignment.Left
    v1.TextTruncate = Enum.TextTruncate.AtEnd
    v1.Parent = CanvasGroup

    table.insert(u35, CanvasGroup)

    while true do
        if not (Config.Notice.MaxOnScreen < #u35) then
            break
        end

        dismiss(u35[1])
    end

    reflow()

    TweenService:Create(
        CanvasGroup,
        TweenInfo.new(0.18, Enum.EasingStyle.Quad),
        {GroupTransparency = 0}
    ):Play()

    task.delay(
        Config.Notice.SecondsOnScreen,
        function() -- Line: 99; upvalues: CanvasGroup (val), dismiss (upval)
            if CanvasGroup.Parent then
                dismiss(CanvasGroup)
            end
        end
    )
end

function v1.start() -- Line: 106; upvalues: u34 (ref), LocalPlayer (val), Remotes (val), show (val), Config (val)
    u34 = Instance.new("ScreenGui")
    u34.Name = "AboveNotices"
    u34.ResetOnSpawn = false
    u34.DisplayOrder = 3
    u34.Parent = LocalPlayer:WaitForChild("PlayerGui")

    ;(Remotes.get(Remotes.Notice)).OnClientEvent:Connect(function(a1, a2)
        -- Line: 113
        -- upvalues: show (upval), Config (upval)
        if type(a1) == "string" and a1 ~= "" then
            show(a1, if type(a2) ~= "string" then Config.Notice.DefaultTone else a2)
        end
    end)
end

return v1