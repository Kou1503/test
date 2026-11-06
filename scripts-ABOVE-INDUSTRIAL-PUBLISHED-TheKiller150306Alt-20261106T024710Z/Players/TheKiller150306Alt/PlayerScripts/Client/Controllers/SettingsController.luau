-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.SettingsController
-- Decompile time: 1.19 ms

local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u15 = {}
local u18 = Remotes.get(Remotes.RequestSetting)
local u21 = Remotes.get(Remotes.SettingsChanged)
local u25 = Config.Settings.defaults()
local u26 = {}

function u15.get(a1) -- Line: 30; upvalues: u25 (val), Config (val); types: a1: string
    return u25[a1] or Config.Settings.get(a1).default
end

function u15.is(a1, a2) -- Line: 34; upvalues: u15 (val); types: a1: string, a2: string
    return u15.get(a1) == a2
end

function u15.onChanged(a1) -- Line: 38; upvalues: u26 (val); types: a1: function
    table.insert(u26, a1)
end

function u15.set(a1, a2)
    -- Line: 44
    -- upvalues: Config (val), u25 (val), u26 (val), u18 (val)
    -- types: a1: string, a2: string
    if not Config.Settings.isValid(a1, a2) then
        return
    end

    u25[a1] = a2

    for i, j in u26 do
        j(a1, a2)
    end

    u18:FireServer(a1, a2)
end

local u31 = false

function u15.waitLoaded(a1) -- Line: 60; upvalues: u31 (ref); types: a1: number
    local v1 = os.clock() + a1

    while not u31 do
        if not (os.clock() < v1) then
            break
        end

        task.wait(0.05)
    end
end

function u15.start() -- Line: 67; upvalues: u21 (val), u31 (ref), u25 (val), u26 (val)
    u21.OnClientEvent:Connect(function(a1, a2) -- Line: 68; upvalues: u31 (upval), u25 (upval), u26 (upval)
        if type(a1) ~= "table" then
            return
        end

        if a2 == true then
            u31 = true
        end

        local v1 = nil
        local v2 = nil

        for i, j in a1, v1, v2 do
            if type(i) == "string" and type(j) == "string" and u25[i] ~= j then
                u25[i] = j

                for k, n in u26 do
                    n(i, j)
                end
            end
        end
    end)
end

return u15