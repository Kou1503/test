-- Script path: game:GetService("ReplicatedStorage").Shared.StackKey
-- Decompile time: 5.99 ms

local u0 = {}

function u0.roll(a1, a2, a3) -- Line: 25; types: a1: string, a2: boolean, a3: table?
    local v1
    local v2 = {}

    for i in a3 or {} do
        table.insert(v2, i)
    end

    table.sort(v2)

    local v3 = {if not a2 then a1 else ("Perfect %*"):format(a1)}

    for j, k in v2 do
        v1 = string.format("%.4f", a3[k])
        table.insert(v3, (("%*=%*"):format(k, v1)))
    end

    return table.concat(v3, ";")
end

function u0.of(a1, a2) -- Line: 38; types: a1: string, a2: string?
    if a2 then
        return a1 .. "@" .. a2
    end

    return a1
end

function u0.item(a1) -- Line: 43; types: a1: string
    local v1 = string.find(a1, "@", 1, true)

    if v1 then
        return (string.sub(a1, 1, v1 - 1))
    end

    return a1
end

function u0.rollOf(a1) -- Line: 49; types: a1: string
    local v1 = string.find(a1, "@", 1, true)

    if v1 then
        return (string.sub(a1, v1 + 1))
    end

    return nil
end

function u0.split(a1, a2) -- Line: 57; upvalues: u0 (val); types: a1: table, a2: table?
    local v1, v2
    local v3 = {}
    local v4 = {}
    local v5 = nil
    local v6 = nil
    local v7 = a2

    for i, j in a1, v5, v6 do
        v2 = if not v7 then nil else v7[i]

        if type(v2) ~= "table" or not (#v2 > 0) then
            v3[i] = j
        else
            for k, n in v2 do
                if type(n) == "table"
                    and type(n.roll) == "string"
                    and type(n.count) == "number" then
                    v1 = u0.of(i, n.roll)
                    v3[v1] = (v3[v1] or 0) + n.count
                    v4[v1] = n
                end
            end
        end
    end

    return v3, v4
end

return u0