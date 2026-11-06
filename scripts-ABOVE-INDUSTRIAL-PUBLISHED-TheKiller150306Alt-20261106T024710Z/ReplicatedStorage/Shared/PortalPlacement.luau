-- Script path: game:GetService("ReplicatedStorage").Shared.PortalPlacement
-- Decompile time: 2.17 ms

local u0 = {
    Refusals = {
        OutsideIsland = "The portal must stay on your island",
        InTheWay = "Something is in the way",
        NoGround = "The portal needs solid ground under all of it",
        NearSpawn = "Too close to a spawn block",
    },
}

function u0.sizeAt(a1, a2, a3) -- Line: 25; types: a1: table, a2: number, a3: number
    if math.round((a3 - a2) / 90) % 2 == 1 then
        return {x = a1.z, y = a1.y, z = a1.x}
    end

    return {x = a1.x, y = a1.y, z = a1.z}
end

function u0.cells(a1, a2, a3) -- Line: 35; types: a1: table, a2: table, a3: number
    local function span(a1, a2) -- Line: 37; upvalues: a3 (val); types: a1: number, a2: number
        return (math.round((a1 - a2 / 2 + 0.01) / a3)), (math.round((a1 + a2 / 2 - 0.01) / a3))
    end

    local v1 = a1.x * a3
    local x = a2.x
    local v2 = math.round((v1 - x / 2 + 0.01) / a3)
    local v3 = math.round((v1 + x / 2 - 0.01) / a3)
    local v4 = a1.z * a3
    local z = a2.z
    v1 = math.round((v4 - z / 2 + 0.01) / a3)
    local v5 = math.round((v4 + z / 2 - 0.01) / a3)
    local v6 = a1.y * a3 - a3 / 2
    v4 = math.round((v6 + 0.01) / a3)
    local v7 = math.round((v6 + a2.y - 0.01) / a3)
    v6 = {}

    for i = v2, v3 do
        for j = v4, v7 do
            for k = v1, v5 do
                table.insert(
                    v6,
                    {x = i, y = j, z = k}
                )
            end
        end
    end

    return v6
end

function u0.near(a1, a2, a3) -- Line: 71; types: a1: table, a2: table, a3: number
    local v1 = nil
    local v2 = nil

    for i, j in a1, v1, v2 do
        for k, n in a2 do
            if math.max(math.abs(j.x - n.x), (math.abs(j.z - n.z)))
                < v3 then
                return true
            end
        end
    end

    return false
end

function u0.refusal(a1, a2, a3) -- Line: 87; upvalues: u0 (val); types: a1: table, a2: table, a3: number
    if #a1 == 0 then
        return u0.Refusals.InTheWay
    end

    local v1 = (1 / 0)

    for i, j in a1 do
        if not a2.inBounds(j) then
            return u0.Refusals.OutsideIsland
        end

        v1 = math.min(v1, j.y)
    end

    if u0.near(a1, a2.spawns, a3) then
        return u0.Refusals.NearSpawn
    end

    for k, n in a1 do
        if not a2.isEmpty(n) then
            return u0.Refusals.InTheWay
        end
    end

    for m, i5 in a1 do
        if i5.y == v1
            and not a2.isSolidGround({x = i5.x, y = i5.y - 1, z = i5.z}) then
            return u0.Refusals.NoGround
        end
    end

    return nil
end

return u0