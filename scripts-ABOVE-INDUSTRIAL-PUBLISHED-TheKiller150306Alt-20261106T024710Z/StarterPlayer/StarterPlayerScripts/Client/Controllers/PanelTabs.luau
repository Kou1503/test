-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.PanelTabs
-- Decompile time: 0.52 ms

local v1 = {}
local u1 = {}

function v1.register(a1, a2) -- Line: 15; upvalues: u1 (val); types: a1: function, a2: function
    table.insert(
        u1,
        {isOpen = a1, step = a2}
    )
end

function v1.step(a1) -- Line: 20; upvalues: u1 (val); types: a1: number
    for i, j in u1 do
        if j.isOpen() then
            j.step(a1)
            return true
        end
    end

    return false
end

function v1.neighbour(a1, a2, a3) -- Line: 31; types: a1: table, a3: number
    if #a1 == 0 then
        return nil
    end

    local v1 = table.find(a1, a2)

    if not v1 then
        return a1[1]
    end

    return a1[(v1 - 1 + a3) % #a1 + 1]
end

return v1