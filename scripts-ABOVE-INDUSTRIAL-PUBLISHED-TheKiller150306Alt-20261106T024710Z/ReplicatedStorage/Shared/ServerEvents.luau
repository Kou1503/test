-- Script path: game:GetService("ReplicatedStorage").Shared.ServerEvents
-- Decompile time: 2.38 ms

local v1 = {}

local function sortedKeys(a1) -- Line: 24; types: a1: table
    local v1 = {}

    for i in a1 do
        table.insert(v1, i)
    end

    table.sort(v1)

    return v1
end

function v1.targets(a1, a2, a3, a4) -- Line: 34
    local u249 = {}
    local u243 = {}

    local function add(a1) -- Line: 37; upvalues: u243 (val), u249 (val); types: a1: table
        if not u243[string.lower(a1.id)] then
            u243[(string.lower(a1.id))] = true
            table.insert(u249, a1)
        end
    end

    local v1 = {}
    local v2 = nil
    local v3 = nil

    for i in a1.Nodes, v2, v3 do
        table.insert(v1, i)
    end

    table.sort(v1)

    local v4 = nil
    local v5 = nil
    local v6, v7, v8, v9 = a2, a3, a4, a1

    for j, k in v1, v4, v5 do
        v2 = v9.Nodes[k]

        if type(v2.resource) == "string" then
            v3 = {
                kind = "gather",
                id = v2.resource,
                verb = if v2.requires ~= "Axe" then "mined" else "chopped",
            }

            if not u243[string.lower(v3.id)] then
                u243[(string.lower(v3.id))] = true
                table.insert(u249, v3)
            end
        end
    end

    v1 = {}
    v2 = nil

    for n in v6.Crops, v2 do
        table.insert(v1, n)
    end

    table.sort(v1)

    for m, i5 in v1 do
        v2 = {kind = "gather", verb = "harvested", id = i5}

        if not u243[string.lower(v2.id)] then
            u243[(string.lower(v2.id))] = true
            table.insert(u249, v2)
        end
    end

    v1 = {}
    v2 = nil
    v3 = nil

    for i6 in v7.Bushes, v2, v3 do
        table.insert(v1, i6)
    end

    table.sort(v1)

    v4 = nil

    for i7, i8 in v1, v4 do
        v2 = v7.Bushes[i8]

        if type(v2.produce) == "string" then
            v3 = {kind = "gather", verb = "picked", id = v2.produce}

            if not u243[string.lower(v3.id)] then
                u243[(string.lower(v3.id))] = true
                table.insert(u249, v3)
            end
        end
    end

    v1 = {}

    for i9 in v8.Enemies do
        if string.find(i9, "Slime", 1, true) then
            v1[i9] = true
        end
    end

    if next(v1) then
        v4 = {id = "Slime", kind = "kill", verb = "slain", enemies = v1}

        if not u243[string.lower(v4.id)] then
            u243[(string.lower(v4.id))] = true
            table.insert(u249, v4)
        end
    end

    v4 = {}
    v3 = nil

    for i10 in v8.Enemies, v3 do
        table.insert(v4, i10)
    end

    table.sort(v4)

    for i11, i12 in v4 do
        v3 = {kind = "kill", verb = "slain", id = i12, enemies = {[i12] = true}}

        if not u243[string.lower(v3.id)] then
            u243[(string.lower(v3.id))] = true
            table.insert(u249, v3)
        end
    end

    return u249
end

function v1.find(a1, a2) -- Line: 82; types: a1: table, a2: string
    local v1 = string.lower(a2)

    for i, j in a1 do
        if string.lower(j.id) == v1 then
            return j
        end
    end

    return nil
end

function v1.counts(a1, a2, a3) -- Line: 93; types: a1: table, a2: string, a3: string
    if a2 ~= a1.kind then
        return false
    end

    if a2 ~= "kill" then
        return a3 == a1.id
    end

    local enemies = a1.enemies
    local v1 = false

    if enemies ~= nil then
        v1 = enemies[a3] == true
    end

    return v1
end

function v1.ids(a1) -- Line: 105; types: a1: table
    local v1 = {}

    for i, j in a1 do
        table.insert(v1, j.id)
    end

    return v1
end

return v1