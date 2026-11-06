-- Script path: game:GetService("ReplicatedStorage").Shared.Config.PatternConfig
-- Decompile time: 1.15 ms

local u0 = {
    Patterns = {
        {id = "Plain", displayName = "", weight = 86},
        {
            id = "Striped",
            displayName = "Striped",
            weight = 8,
            colorMap = "rbxassetid://110819480934998",
            overlay = "Striped",
        },
        {
            id = "Dotted",
            displayName = "Dotted",
            weight = 4,
            colorMap = "rbxassetid://107203721679618",
            overlay = "Dotted",
        },
        {id = "Glowing", displayName = "Glowing", weight = 2, material = "Neon"},
    },
    Plain = "Plain",
}

function u0.prefixOf(a1) -- Line: 93; upvalues: u0 (val); types: a1: string
    if a1 == u0.Plain then
        return ""
    end

    return a1
end

local u8 = {}
local u30 = 0

for i, j in u0.Patterns do
    u8[j.id] = j
    u30 = u30 + j.weight
end

function u0.get(a1) -- Line: 104; upvalues: u8 (val), u0 (val); types: a1: string?
    return (if not a1 then nil else u8[a1]) or u8[u0.Plain]
end

function u0.choose(a1) -- Line: 113; upvalues: u30 (ref), u0 (val); types: a1: number
    local v1 = (math.clamp(a1, 0, 0.999999)) * u30
    local v2 = 0

    for i, j in u0.Patterns do
        v2 = v2 + j.weight

        if v1 < v2 then
            return j.id
        end
    end

    return u0.Plain
end

function u0.split(a1) -- Line: 129; upvalues: u0 (val); types: a1: string
    local v1
    local Plain = u0.Plain
    local v2 = 0

    for i, j in u0.Patterns do
        v1 = u0.prefixOf(j.id)

        if v1 ~= "" and v2 < #v1 and string.sub(a1, 1, #v1) == v1 then
            Plain = j.id
            v2 = #v1
        end
    end

    return Plain, (string.sub(a1, v2 + 1))
end

function u0.compose(a1, a2) -- Line: 140; upvalues: u0 (val); types: a1: string, a2: string
    return (u0.prefixOf(u0.get(a1).id)) .. a2
end

function u0.rarityMultiplier(a1) -- Line: 146; upvalues: u0 (val), u8 (val); types: a1: string
    local v1 = u0.get(a1)
    local v2 = u8[u0.Plain]

    if v1.id ~= u0.Plain and not (v1.weight <= 0) then
        return (math.sqrt(v2.weight / v1.weight))
    end

    return 1
end

return u0