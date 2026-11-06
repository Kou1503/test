-- Script path: game:GetService("ReplicatedStorage").Shared.Config.HintConfig
-- Decompile time: 0.37 ms

local u0 = {
    Hints = {
        {
            id = "Backpack",
            text = "Press  E  for your Backpack",
            retiredBy = "opening the backpack, however it was opened",
        },
    },
}

function u0.get(a1) -- Line: 36; upvalues: u0 (val); types: a1: string
    for i, j in u0.Hints do
        if j.id == a1 then
            return j
        end
    end

    return nil
end

function u0.isHint(a1) -- Line: 45; upvalues: u0 (val); types: a1: string
    return u0.get(a1) ~= nil
end

return u0