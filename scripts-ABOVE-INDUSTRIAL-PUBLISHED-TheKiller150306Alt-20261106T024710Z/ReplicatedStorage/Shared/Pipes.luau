-- Script path: game:GetService("ReplicatedStorage").Shared.Pipes
-- Decompile time: 2.77 ms

local u0 = {Straight = "WaterPipe", Corner = "WaterPipeCorner", Spout = "WaterSpout", Pump = "WaterPump"}
local u5 = {0, 90, 180, 270}
local u10 = {[u0.Straight] = {{x = 0, z = 1}, {x = 0, z = -1}}}
u10[u0.Corner] = {{x = 0, z = 1}, {x = 1, z = 0}}
u10[u0.Spout] = {{x = 0, z = 1}}

function u0.isPipe(a1) -- Line: 35; upvalues: u10 (val); types: a1: string?
    local v1 = false

    if a1 ~= nil then
        v1 = u10[a1] ~= nil
    end

    return v1
end

function u0.isSpout(a1) -- Line: 39; upvalues: u0 (val); types: a1: string?
    return a1 == u0.Spout
end

function u0.turn(a1, a2) -- Line: 44; types: a1: table, a2: number
    local v1 = math.rad(a2)
    local v2 = math.cos(v1)
    local v3 = math.sin(v1)

    return {
        x = math.round(a1.x * v2 + a1.z * v3),
        z = math.round(-a1.x * v3 + a1.z * v2),
    }
end

local function same(a1, a2) -- Line: 50; types: a1: table, a2: table
    local v1 = false

    if a1.x == a2.x then
        v1 = a1.z == a2.z
    end

    return v1
end

function u0.openings(a1, a2) -- Line: 55; upvalues: u10 (val), u0 (val); types: a1: string, a2: number
    local v1 = {}

    for i, j in u10[a1] or {} do
        table.insert(v1, (u0.turn(j, a2)))
    end

    return v1
end

function u0.accepts(a1, a2, a3) -- Line: 65; upvalues: u0 (val); types: a1: string, a2: number, a3: table
    local v1
    local v2 = {x = -a3.x, z = -a3.z}

    for i, j in u0.openings(a1, a2) do
        v1 = false

        if j.x == v2.x then
            v1 = j.z == v2.z
        end

        if v1 then
            return true
        end
    end

    return false
end

function u0.outlet(a1, a2, a3) -- Line: 78; upvalues: u0 (val); types: a1: string, a2: number, a3: table
    local v1
    local v2 = {x = -a3.x, z = -a3.z}
    local v3 = false
    local v4 = nil
    local v5 = (u0.openings(a1, a2))
    local v6 = nil
    local v7 = nil

    for i, j in v5, v6, v7 do
        v1 = false

        if j.x == v2.x then
            v1 = j.z == v2.z
        end

        if not v1 or v3 then
            v4 = j
        else
            v3 = true
        end
    end

    if v3 then
        return v4
    end

    return nil
end

function u0.rightOf(a1) -- Line: 94; types: a1: table
    return {x = -a1.z, z = a1.x}
end

function u0.yawFor(a1, a2, a3) -- Line: 100; upvalues: u0 (val), u5 (val); types: a1: string, a2: table, a3: boolean
    local v1, v2, v3

    if u0.isSpout(a1) then
        for k, n in u5 do
            if u0.accepts(a1, n, a2) then
                return n
            end
        end

        return nil
    end

    if a1 ~= u0.Corner then
        v2 = a2
    else
        local v4 = u0.rightOf(a2)
        v2 = if not a3 then {x = -v4.x, z = -v4.z} else v4
    end

    local v5 = nil
    local v6 = nil
    local v7, v8 = a1, a2

    for i, j in u5, v5, v6 do
        v3 = u0.outlet(v7, j, v8)

        if v3 then
            v1 = false

            if v3.x == v2.x then
                v1 = v3.z == v2.z
            end

            if v1 then
                return j
            end
        end
    end

    return nil
end

function u0.dirKey(a1) -- Line: 126; types: a1: table
    return (("%*,%*"):format(a1.x, a1.z))
end

function u0.dirFromKey(a1) -- Line: 130
    if type(a1) ~= "string" then
        return nil
    end

    local v1, v2 = string.match(a1, "^(%-?%d+),(%-?%d+)$")

    if v1 and v2 then
        return {x = tonumber(v1), z = tonumber(v2)}
    end

    return nil
end

return u0