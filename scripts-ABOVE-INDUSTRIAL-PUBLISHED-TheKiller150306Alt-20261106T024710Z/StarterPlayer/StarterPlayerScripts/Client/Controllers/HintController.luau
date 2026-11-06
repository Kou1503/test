-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.HintController
-- Decompile time: 0.95 ms

local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Remotes = require(Shared.Remotes)
local v1 = {}
local u13 = {}
local u14 = false
local u17 = Remotes.get(Remotes.RequestHintSeen)
local u18 = {}

function v1.onChanged(a1) -- Line: 28; upvalues: u18 (val), u14 (ref); types: a1: function
    table.insert(u18, a1)

    if u14 then
        task.spawn(a1)
    end
end

function v1.hasSeen(a1) -- Line: 35; upvalues: u13 (val); types: a1: string
    return u13[a1] == true
end

function v1.markSeen(a1) -- Line: 42; upvalues: u13 (val), u17 (val); types: a1: string
    if u13[a1] then
        return
    end

    u13[a1] = true
    u17:FireServer(a1)
end

function v1.start() -- Line: 50; upvalues: Remotes (val), u13 (val), u14 (ref), u18 (val)
    (Remotes.get(Remotes.HintsChanged)).OnClientEvent:Connect(function(a1)
        -- Line: 51
        -- upvalues: u13 (upval), u14 (upval), u18 (upval)
        if type(a1) ~= "table" then
            return
        end

        for i, j in a1 do
            if type(i) == "string" and j == true then
                u13[i] = true
            end
        end

        u14 = true

        for k, n in u18 do
            task.spawn(n)
        end
    end)

    task.delay(
        12,
        function() -- Line: 69; upvalues: u14 (upval), u18 (upval)
            if not u14 then
                u14 = true

                for i, j in u18 do
                    task.spawn(j)
                end
            end
        end
    )
end

return v1