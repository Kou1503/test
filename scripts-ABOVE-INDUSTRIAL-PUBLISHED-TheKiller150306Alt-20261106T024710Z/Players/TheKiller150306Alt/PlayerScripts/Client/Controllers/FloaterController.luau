-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.FloaterController
-- Decompile time: 2.83 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Palette = require(Shared.Palette)
local Remotes = require(Shared.Remotes)
local u34 = require(script.Parent.Parent.Ui)
local Aim = require(script.Parent.Aim)
local SettingsController = require(script.Parent.SettingsController)
local u45 = {}
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local u49 = nil
local u50 = {}

local function ease(a1) -- Line: 52; types: a1: number
    local v1 = 1 - a1
    return 1 - v1 * v1
end

function u45.show(a1, a2, a3, a4)
    -- Line: 59
    -- upvalues: Config (val), Aim (val), u50 (val), u34 (val), u49 (ref)
    -- types: a1: string, a2: vector, a3: userdata, a4: number?
    local Floaters = Config.Appearance.Floaters
    local MaxFloaters = if not Aim.isTouch() then
        Floaters.MaxOnScreen
    else
        Config.Touch.Reduced.MaxFloaters

    if MaxFloaters <= #u50 then
        local v1 = table.remove(u50, 1)

        if v1 then
            v1.label:Destroy()
        end
    end

    local TextLabel = Instance.new("TextLabel")
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.Size = UDim2.fromOffset(160, 24)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = a1
    TextLabel.TextColor3 = a3
    TextLabel.TextSize = a4 or Floaters.TextSize
    TextLabel.FontFace = u34.Font.Bold
    TextLabel.TextStrokeTransparency = 0.4
    TextLabel.Visible = false
    TextLabel.Parent = u49

    table.insert(
        u50,
        {
            label = TextLabel,
            origin = a2,
            born = os.clock(),
            drift = (math.random() - 0.5) * Floaters.DriftPixels,
            seconds = Floaters.Seconds,
        }
    )
end

local function step() -- Line: 97; upvalues: u50 (val), CurrentCamera (val), Config (val)
    local v1, v2, v3, v4, v5, v6

    if #u50 == 0 then
        return
    end

    local v7 = os.clock()

    for i = #u50, 1, -1 do
        v1 = u50[i]
        v2 = (v7 - v1.born) / v1.seconds

        if not (v2 >= 1) then
            v3, v4 = CurrentCamera:WorldToViewportPoint(v1.origin)
            v1.label.Visible = v4

            if v4 then
                v6 = 1 - v2
                v5 = 1 - v6 * v6
                v1.label.Position = UDim2.fromOffset(v3.X + v1.drift * v5, v3.Y - Config.Appearance.Floaters.RisePixels * v5)
                v1.label.TextTransparency = math.max(0, (v2 - 0.66) / 0.34)
                v1.label.TextStrokeTransparency = math.max(0, (v2 - 0.66) / 0.34) * 0.6 + 0.4
            end
        else
            v1.label:Destroy()
            table.remove(u50, i)
        end
    end
end

local function rgb(a1) -- Line: 131; types: a1: table
    return Color3.fromRGB(a1.r, a1.g, a1.b)
end

function u45.start()
    -- Line: 135
    -- upvalues: u49 (ref), LocalPlayer (val), RunService (val), step (val), Remotes (val), u45 (val), Palette (val)
    -- upvalues: rgb (val), Config (val), SettingsController (val)
    u49 = Instance.new("ScreenGui")
    u49.Name = "Floaters"
    u49.ResetOnSpawn = false
    u49.IgnoreGuiInset = true
    u49.DisplayOrder = 0
    u49.Parent = LocalPlayer:WaitForChild("PlayerGui")

    RunService.RenderStepped:Connect(step)

    ;(Remotes.get(Remotes.ItemGained)).OnClientEvent:Connect(function(a1, a2, a3)
        -- Line: 150
        -- upvalues: u45 (upval), Palette (upval), rgb (upval), Config (upval)
        if type(a1) == "string" and typeof(a2) == "Vector3" then
            local show = u45.show
            local v1 = Palette.displayName(a1)

            show(("+%* %*"):format(if type(a3) ~= "number" then 1 else math.max(1, a3), v1), a2 + Vector3.new(0, 1.5, 0), rgb(Config.Appearance.Floaters.GainColor))
        end
    end)

    ;(Remotes.get(Remotes.DamageDealt)).OnClientEvent:Connect(function(a1, a2, a3, a4)
        -- Line: 165
        -- upvalues: SettingsController (upval), Config (upval), u45 (upval)
        if typeof(a1) == "Vector3" and type(a2) == "number" then
            if not SettingsController.is("DamageNumbers", "On") then
                return
            end

            local Floaters = Config.Appearance.Floaters
            local TextSize = Floaters.TextSize

            if a3 then
                TextSize = TextSize + 8
            end

            if a4 == true then
                TextSize = TextSize + 6
            end

            local show = u45.show
            local v1 = tostring((math.floor(a2)))
            local CritColor = if a4 ~= true then Floaters.DamageColor else Floaters.CritColor

            show(v1, a1 + Vector3.new(0, 2, 0), Color3.fromRGB(CritColor.r, CritColor.g, CritColor.b), TextSize)
        end
    end)
end

return u45