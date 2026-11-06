-- Script path: game:GetService("ReplicatedStorage").Shared.Grid
-- Decompile time: 4.99 ms

local u0 = {CellSize = 3}

local function whole(a1) -- Line: 28; types: a1: number
    if a1 == 0 then
        return 0
    end

    return a1
end

function u0.cell(a1, a2, a3) -- Line: 35; types: a1: number, a2: number, a3: number
    return {
        x = if a1 ~= 0 then a1 else 0,
        y = if a2 ~= 0 then a2 else 0,
        z = if a3 ~= 0 then a3 else 0,
    }
end

function u0.key(a1) -- Line: 40; types: a1: table
    local x = a1.x
    local v1 = if x ~= 0 then x else 0
    local y = a1.y
    local v2 = if y ~= 0 then y else 0
    local z = a1.z

    return (("%*,%*,%*"):format(v1, v2, if z ~= 0 then z else 0))
end

function u0.fromKey(a1) -- Line: 44; types: a1: string
    local v1, v2, v3 = string.match(a1, "^(-?%d+),(-?%d+),(-?%d+)$")

    if not v1 then
        return nil
    end

    local v4 = {}
    local v5 = tonumber(v1)
    v4.x = if v5 ~= 0 then v5 else 0
    v5 = tonumber(v2)
    v4.y = if v5 ~= 0 then v5 else 0
    v5 = tonumber(v3)
    v4.z = if v5 ~= 0 then v5 else 0

    return v4
end

function u0.cellToWorld(a1, a2) -- Line: 58; upvalues: u0 (val); types: a1: vector, a2: table
    return a1
        + Vector3.new(a2.x * u0.CellSize, a2.y * u0.CellSize, a2.z * u0.CellSize)
end

function u0.worldToCell(a1, a2) -- Line: 62; upvalues: u0 (val); types: a1: vector, a2: vector
    local v1 = a2 - a1
    local v2 = {}
    local v3 = math.round(v1.X / u0.CellSize)
    v2.x = if v3 ~= 0 then v3 else 0
    v3 = math.round(v1.Y / u0.CellSize)
    v2.y = if v3 ~= 0 then v3 else 0
    v3 = math.round(v1.Z / u0.CellSize)
    v2.z = if v3 ~= 0 then v3 else 0

    return v2
end

function u0.baseOfCell(a1, a2) -- Line: 78; upvalues: u0 (val); types: a1: vector, a2: table
    return (u0.cellToWorld(a1, a2)) - Vector3.new(0, u0.CellSize / 2, 0)
end

function u0.cellFromBase(a1, a2) -- Line: 87; upvalues: u0 (val); types: a1: vector, a2: vector
    return u0.worldToCell(a1, a2 + Vector3.new(0, u0.CellSize / 2, 0))
end

function u0.isInBounds(a1, a2) -- Line: 92; types: a1: table, a2: table
    if not (a2.horizontal < (math.abs(a1.x)))
        and not (a2.horizontal < (math.abs(a1.z))) then
        if not (a1.y < -a2.below) and not (a2.above < a1.y) then
            return true
        end

        return false
    end

    return false
end

function u0.boundaryEdgeStuds(a1) -- Line: 107; upvalues: u0 (val); types: a1: number
    return a1 * u0.CellSize + u0.CellSize / 2
end

function u0.boundarySpanStuds(a1) -- Line: 112; upvalues: u0 (val); types: a1: number
    return (a1 * 2 + 1) * u0.CellSize
end

function u0.surfaceCell(a1, a2, a3) -- Line: 123; upvalues: u0 (val); types: a1: vector, a2: vector, a3: vector
    return u0.worldToCell(a1, a2 - a3 * (u0.CellSize / 2))
end

function u0.offsetByNormal(a1, a2) -- Line: 128; upvalues: u0 (val); types: a1: table, a2: vector
    return u0.cell(a1.x + math.round(a2.X), a1.y + math.round(a2.Y), a1.z + math.round(a2.Z))
end

function u0.rimOffset(a1, a2, a3, a4, a5)
    -- Line: 134
    -- upvalues: u0 (val)
    -- types: a1: vector, a2: table, a3: vector, a4: number, a5: boolean
    local v1 = u0.cellToWorld(a1, a2)
    local v2 = u0.CellSize * (0.5 - a4)
    local v3 = a3.X - v1.X
    local v4 = a3.Z - v1.Z
    v1 = if not (v2 < v3) then if not (v3 < -v2) then 0 else -1 else 1
    local v5 = if not (v2 < v4) then if not (v4 < -v2) then 0 else -1 else 1

    if not a5 and v1 ~= 0 and v5 ~= 0 then
        local v6 = math.abs(v3)

        if not (math.abs(v4) <= v6) then
            v1 = 0
        else
            v5 = 0
        end
    end

    return v1, v5
end

function u0.cellFromPlane(a1, a2, a3, a4)
    -- Line: 163
    -- upvalues: u0 (val)
    -- types: a1: vector, a2: vector, a3: vector, a4: number
    local Unit = a3.Unit

    if -0.001 <= Unit.Y then
        return nil
    end

    local v1 = (a1.Y + a4 * u0.CellSize + u0.CellSize / 2 - a2.Y)
        / Unit.Y

    if v1 <= 0 then
        return nil
    end

    v1 = u0.worldToCell(a1, a2 + Unit * v1)

    return u0.cell(v1.x, a4, v1.z)
end

u0.NoTerrain = -1

function u0.isSolidIsland(a1, a2, a3) -- Line: 193; types: a1: table, a2: number, a3: number
    if a2 < 0 then
        return false
    end

    local v1 = false

    if a1.y <= a3 then
        v1 = false

        if math.abs(a1.x) <= a2 then
            v1 = math.abs(a1.z) <= a2
        end
    end

    return v1
end

function u0.isSupported(a1, a2) -- Line: 205; upvalues: u0 (val); types: a1: table, a2: function
    return a2(u0.cell(a1.x, a1.y - 1, a1.z))
end

function u0.forEachNeighbor(a1, a2) -- Line: 211; upvalues: u0 (val); types: a1: table, a2: function
    local v1, v2 = a1, a2

    for i = -1, 1 do
        for j = -1, 1 do
            for k = -1, 1 do
                if i == 0 and j == 0 and k == 0 then
                    continue
                end

                if v2(u0.cell(v1.x + i, v1.y + j, v1.z + k)) then
                    return true
                end
            end
        end
    end

    return false
end

function u0.footprintCells(a1, a2, a3) -- Line: 235; upvalues: u0 (val); types: a1: table, a2: table, a3: number
    local v1, v2, v3, v4
    local v5 = (math.round(a3 / 90) % 4 + 4) % 4
    local v6 = {}
    local v7 = math.max(1, a2.x) - 1
    local v8, v9 = a2, a1

    for i = 0, v7 do
        v4 = math.max(1, v8.y) - 1

        for j = 0, v4 do
            v1 = math.max(1, v8.z) - 1

            for k = 0, v1 do
                if v5 == 0 then
                    v2 = i
                    v3 = k
                elseif v5 == 1 then
                    v2 = k
                    v3 = -i
                elseif v5 ~= 2 then
                    v2 = -k
                    v3 = i
                else
                    v2 = -i
                    v3 = -k
                end

                table.insert(v6, (u0.cell(v9.x + v2, v9.y + j, v9.z + v3)))
            end
        end
    end

    return v6
end

function u0.footprintCenter(a1, a2) -- Line: 261; upvalues: u0 (val); types: a1: vector, a2: table
    local v1 = Vector3.new(0, 0, 0)

    for i, j in a2 do
        v1 = v1 + u0.cellToWorld(a1, j)
    end

    return v1 / math.max(1, #a2)
end

return u0