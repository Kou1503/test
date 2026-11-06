-- Script path: game:GetService("ReplicatedStorage").Shared.CoinAmount
-- Decompile time: 0.45 ms

local u0 = {Suffixes = {k = 1000, m = 1000000, b = 1000000000}}

function u0.parse(a1) -- Line: 30; upvalues: u0 (val); types: a1: string
    local v1 = string.gsub(string.lower((string.gsub(a1, "%s", ""))), ",", "")

    if v1 == "" then
        return nil
    end

    local v2, v3 = string.match(v1, "^(.-)([kmb])$")
    local v4 = 1

    if v2 and v3 then
        v4 = u0.Suffixes[v3] or 1

        if v2 == "" then
            return nil
        end
    end

    v3 = tonumber(v1)

    if v3 and v3 == v3 and v3 ~= (1 / 0) and v3 ~= (-1 / 0) then
        if v3 < 0 then
            return nil
        end

        return (math.floor(v3 * v4))
    end

    return nil
end

return u0