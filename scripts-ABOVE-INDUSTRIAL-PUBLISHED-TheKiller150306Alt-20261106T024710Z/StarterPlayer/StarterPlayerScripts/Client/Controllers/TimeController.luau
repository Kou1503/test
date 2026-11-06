-- Script path: game:GetService("StarterPlayer").StarterPlayerScripts.Client.Controllers.TimeController
-- Decompile time: 1.95 ms

local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Config = require(Shared.Config)
local u27 = require(script.Parent.SettingsController)
local NewPlayerView = require(script.Parent.NewPlayerView)
local u33 = {}
local u34 = 0
local u35 = false

function u33.isNight() -- Line: 27; upvalues: NewPlayerView (val), u34 (ref), Config (val)
    if NewPlayerView.active() then
        return false
    end

    return Config.Time.DayLengthSeconds <= u34
end

function u33.clockText() -- Line: 40; upvalues: Config (val), u34 (ref)
    local v1 = (Config.Time.DayStartHour + u34 / 60) % 24
    local v2 = math.floor(v1)

    return string.format("%02d:%02d", v2, (math.floor((v1 - v2) * 60)))
end

local function applyLighting()
    -- Line: 47
    -- upvalues: Lighting (val), NewPlayerView (val), Config (val), u34 (ref), u27 (val), u33 (val)
    local v1 = NewPlayerView.clockHour() or (Config.Time.DayStartHour + u34 / 60) % 24
    Lighting.ClockTime = v1
    Lighting.GlobalShadows = u27.is("Shadows", "On")
    local v2 = Config.Time.ambientGrey(Lighting.ClockTime)
    Lighting.Ambient = Color3.fromRGB(v2, v2, v2)

    if u33.isNight() then
        Lighting.OutdoorAmbient = Color3.fromRGB(38, 44, 70)
        Lighting.Brightness = 4

        return
    end

    Lighting.OutdoorAmbient = Color3.fromRGB(140, 140, 150)
    Lighting.Brightness = 2
end

function u33.start()
    -- Line: 74
    -- upvalues: ReplicatedStorage (val), Config (val), u34 (ref), u35 (ref), applyLighting (val), NewPlayerView (val)
    -- upvalues: RunService (val)
    local function isHeld() -- Line: 79; upvalues: ReplicatedStorage (upval)
        return ReplicatedStorage:GetAttribute("ClockHeld") == true
    end

    local u1 = 0

    local function sync()
        -- Line: 86
        -- upvalues: ReplicatedStorage (upval), Config (upval), u34 (upval), u35 (upval), applyLighting (upval)
        -- upvalues: u1 (ref)
        local Attribute = ReplicatedStorage:GetAttribute("CycleSeconds")

        if type(Attribute) == "number" then
            local FullCycleSeconds = Config.Time.FullCycleSeconds
            local v1 = math.abs((Attribute - u34 + FullCycleSeconds / 2) % FullCycleSeconds - FullCycleSeconds / 2)
            local v2 = not u35 or Config.Time.LightingJumpSeconds < v1
            u34 = Attribute
            u35 = true

            if ReplicatedStorage:GetAttribute("ClockHeld") == true then
                applyLighting()
                return
            end

            if v2 then
                u1 = 0
                applyLighting()
            end
        end
    end

    sync()

    NewPlayerView.onChanged(function() -- Line: 109; upvalues: u1 (ref), applyLighting (upval)
        u1 = 0
        applyLighting()
    end)

    ;(ReplicatedStorage:GetAttributeChangedSignal("CycleSeconds")):Connect(sync)
    ;(ReplicatedStorage:GetAttributeChangedSignal("ClockHeld")):Connect(sync)

    RunService.Heartbeat:Connect(function(a1)
        -- Line: 116
        -- upvalues: u35 (upval), ReplicatedStorage (upval), u34 (upval), Config (upval), u1 (ref)
        -- upvalues: applyLighting (upval)
        if u35 then
            local v1 = ReplicatedStorage:GetAttribute("ClockHeld") == true

            if not v1 then
                u34 = (u34 + a1) % Config.Time.FullCycleSeconds
                u1 = u1 + a1
                v1 = u1

                if Config.Time.LightingApplySeconds <= v1 then
                    u1 = 0
                    applyLighting()
                end
            end
        end
    end)
end

return u33