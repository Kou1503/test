-- Script path: game:GetService("ReplicatedStorage").Shared.ChatLines
-- Decompile time: 1.30 ms

local v1 = {}
local u1 = {
    Enemy = "{name} died to {by}",
    Player = "{name} was slain by {by}",
    Explode = "{name} got exploded",
    Burn = "{name} burned to death",
    Lava = "{name} tried to swim in lava",
    Smite = "{name} was struck down",
}

function v1.withArticle(a1) -- Line: 24; types: a1: string
    local v1 = string.lower((string.sub(a1, 1, 1)))
    return (("%* %*"):format(if not string.find("aeiou", v1, 1, true) then "a" else if v1 == "" then "a" else "an", a1))
end

function v1.text(a1, a2, a3) -- Line: 31; upvalues: u1 (val); types: a1: string, a2: string?, a3: string?
    local v1, v2

    if not (if not a2 then nil else u1[a2]) then
        return (("%* died"):format(a1))
    end

    if string.find(v1, "{by}", 1, true) and not a3 then
        return (("%* died"):format(a1))
    end

    local function put(a1, a2, a3) -- Line: 37; types: a1: string, a2: string, a3: string
        local v1 = string.find(a1, a2, 1, true)

        if v1 then
            return (string.sub(a1, 1, v1 - 1)) .. a3 .. string.sub(a1, v1 + #a2)
        end

        return a1
    end

    local v3 = string.find(v1, "{name}", 1, true)
    local v4 = string.find(if not v3 then v1 else (string.sub(v1, 1, v3 - 1)) .. a1 .. string.sub(v1, v3 + 6), "{by}", 1, true)

    if v4 then
        return (string.sub(v2, 1, v4 - 1)) .. (a3 or "") .. string.sub(v2, v4 + 4)
    end

    return v2
end

function v1.found(a1, a2) -- Line: 46; types: a1: string, a2: string
    return (("%* found %*!"):format(a1, a2))
end

return v1