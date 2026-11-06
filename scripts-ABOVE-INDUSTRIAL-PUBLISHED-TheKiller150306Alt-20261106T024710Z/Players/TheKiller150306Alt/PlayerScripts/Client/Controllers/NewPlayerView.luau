-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.NewPlayerView
-- Decompile time: 0.68 ms

local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u12 = {}
local u13 = false
local u14 = {}
local u15 = {}

function u12.active() -- Line: 27; upvalues: u13 (ref)
    return u13
end

function u12.hold(a1, a2) -- Line: 32; upvalues: u15 (val), u13 (ref), u14 (val); types: a1: string, a2: boolean
    local v1
    u15[a1] = if not a2 then nil else true

    if next(u15) ~= nil == u13 then
        return
    end

    u13 = v1

    for i, j in u14 do
        task.spawn(j, v1)
    end
end

function u12.set(a1) -- Line: 45; upvalues: u12 (val); types: a1: boolean
    u12.hold("Tutorial", a1)
end

function u12.onChanged(a1) -- Line: 49; upvalues: u14 (val); types: a1: function
    table.insert(u14, a1)
end

function u12.weather(a1) -- Line: 54; upvalues: u13 (ref), Config (val); types: a1: string
    if u13 then
        return Config.Weather.Default
    end

    return a1
end

function u12.clockHour() -- Line: 59; upvalues: u13 (ref), Config (val)
    if u13 then
        return Config.Tutorial.NewPlayerView.ClockHour
    end

    return nil
end

return u12