-- Script path: game:GetService("ReplicatedStorage").Shared.Rails
-- Decompile time: 9.13 ms

local u0 = {
    Straight = "Rail",
    Corner = "RailCorner",
    Ramp = "RailRamp",
    Booster = "RailBooster",
    RampBooster = "RailRampBooster",
    Cart = "Minecart",
    IronCart = "IronRailcart",
}
u0.Carts = {[u0.Cart] = true, [u0.IronCart] = true}

function u0.isCart(a1) -- Line: 48; upvalues: u0 (val)
    local v1 = false

    if type(a1) == "string" then
        v1 = u0.Carts[a1] == true
    end

    return v1
end

u0.CellSize = 3
u0.RailTopStuds = 0.3
local u17 = u0.CellSize / 2
local u20 = -u17 + u0.RailTopStuds
local u21 = {}
u21[u0.Straight] = u0.CellSize
u21[u0.Booster] = u0.CellSize
u21[u0.Ramp] = u0.CellSize * 1.4142135623730951
u21[u0.RampBooster] = u0.CellSize * 1.4142135623730951
u21[u0.Corner] = u17 * 3.141592653589793 / 2

function u0.isRamp(a1) -- Line: 95; upvalues: u0 (val); types: a1: string
    local v1 = true

    if a1 ~= u0.Ramp then
        v1 = a1 == u0.RampBooster
    end

    return v1
end

function u0.boosts(a1) -- Line: 100; upvalues: u0 (val); types: a1: string
    local v1 = true

    if a1 ~= u0.Booster then
        v1 = a1 == u0.RampBooster
    end

    return v1
end

function u0.isRail(a1) -- Line: 104; upvalues: u21 (val)
    local v1 = false

    if type(a1) == "string" then
        v1 = u21[a1] ~= nil
    end

    return v1
end

function u0.length(a1) -- Line: 109; upvalues: u21 (val), u0 (val); types: a1: string
    return u21[a1] or u0.CellSize
end

function u0.turn(a1, a2) -- Line: 114; types: a1: table, a2: number
    local v1 = math.rad(a2)
    local v2 = math.cos(v1)
    local v3 = math.sin(v1)

    return {
        x = a1.x * v2 + a1.z * v3,
        y = a1.y,
        z = -a1.x * v3 + a1.z * v2,
    }
end

local function localPoint(a1, a2)
    -- Line: 122
    -- upvalues: u0 (val), u17 (val), u20 (val)
    -- types: a1: string, a2: number
    local v1 = math.clamp(a2 / (u0.length(a1)), 0, 1)

    if a1 == u0.Corner then
        local v2 = 3.141592653589793 + v1 * 3.141592653589793 / 2
        return {
            x = u17 + u17 * math.cos(v2),
            y = u20,
            z = u17 + u17 * math.sin(v2),
        }, {y = 0, x = -math.sin(v2), z = math.cos(v2)}
    end

    if u0.isRamp(a1) then
        return {x = 0, y = u20 + v1 * u0.CellSize, z = -u17 + v1 * u0.CellSize},
            {x = 0, y = 0.7071067811865476, z = 0.7071067811865476}
    end

    return {x = 0, y = u20, z = -u17 + v1 * u0.CellSize}, {x = 0, y = 0, z = 1}
end

function u0.point(a1, a2, a3, a4)
    -- Line: 143
    -- upvalues: localPoint (val), u0 (val)
    -- types: a1: table, a2: string, a3: number, a4: number
    local v1, v2 = localPoint(a2, a4)
    local v3 = u0.turn(v1, a3)

    return {
        x = a1.x * u0.CellSize + v3.x,
        y = a1.y * u0.CellSize + v3.y,
        z = a1.z * u0.CellSize + v3.z,
    }, u0.turn(v2, a3)
end

function u0.endOf(a1, a2, a3, a4)
    -- Line: 156
    -- upvalues: localPoint (val), u0 (val), u17 (val)
    -- types: a1: table, a2: string, a3: number, a4: boolean
    local v1 = localPoint(a2, if not a4 then 0 else u0.length(a2))
    local v2 = u0.turn(
        {x = v1.x, y = v1.y - u0.RailTopStuds, z = v1.z},
        a3
    )

    return {
        x = a1.x * 2 + math.round(v2.x / u17),
        y = a1.y * 2 + math.round(v2.y / u17),
        z = a1.z * 2 + math.round(v2.z / u17),
    }
end

local function same(a1, a2) -- Line: 166; types: a1: table, a2: table
    local v1 = false

    if a1.x == a2.x then
        v1 = false

        if a1.y == a2.y then
            v1 = a1.z == a2.z
        end
    end

    return v1
end

local function cellsAround(a1) -- Line: 172; types: a1: table
    local function options(a1) -- Line: 173; types: a1: number
        if a1 % 2 == 0 then
            return {a1 // 2}
        end

        return {(a1 - 1) // 2, (a1 + 1) // 2}
    end

    local v1 = {}
    local v2 = a1

    for i, j in options(a1.x) do
        for k, n in options(v2.y) do
            for m, i5 in options(v2.z) do
                table.insert(
                    v1,
                    {x = j, y = n, z = i5}
                )
            end
        end
    end

    return v1
end

function u0.follow(a1, a2, a3, a4, a5)
    -- Line: 192
    -- upvalues: u0 (val), cellsAround (val)
    -- types: a1: table, a2: string, a3: number, a4: boolean, a5: function
    local v1, v2, v3, v4, v5
    local v6 = u0.endOf(a1, a2, a3, a4)
    local v7, v8 = a1, a5

    for i, j in cellsAround(v6) do
        if j.x == v7.x and j.y == v7.y and j.z == v7.z then
            continue
        end

        v1, v2 = v8(j)

        if v1 and u0.isRail(v1) then
            v3 = v2 or 0
            v5 = u0.endOf(j, v1, v3, false)
            v4 = false

            if v5.x == v6.x then
                v4 = false

                if v5.y == v6.y then
                    v4 = v5.z == v6.z
                end
            end

            if v4 then
                return j, v1, v3, false
            end

            v5 = u0.endOf(j, v1, v3, true)
            v4 = false

            if v5.x == v6.x then
                v4 = false

                if v5.y == v6.y then
                    v4 = v5.z == v6.z
                end
            end

            if v4 then
                return j, v1, v3, true
            end
        end
    end

    return nil, nil, nil, nil
end

local function sign(a1) -- Line: 221; types: a1: number
    if a1 > 0 then
        return 1
    end

    if a1 < 0 then
        return -1
    end

    return 0
end

function u0.step(a1, a2, a3, a4, a5)
    -- Line: 237
    -- upvalues: u0 (val)
    -- types: a1: table, a2: number, a3: function, a4: table?, a5: table
    local v1, v2, v3, v4, v5, v6, v7, v8
    a1.launched = nil
    _, v8 = u0.point(a1.cell, a1.itemId, a1.yaw, a1.s)
    local BoostKickSpeed = a1.v - a5.Gravity * v8.y * a2

    if a4 then
        local v9 = math.sqrt(v8.x * v8.x + v8.z * v8.z)
        local v10 = if not (v9 > 0) then
            0
        else
            (a4.x * v8.x + a4.z * v8.z) / v9
        v9 = if not (v10 > 0) then if not (v10 < 0) then 0 else -1 else 1

        if v9 ~= 0 and BoostKickSpeed * v9 < a5.PushMaxSpeed then
            BoostKickSpeed = BoostKickSpeed + v10 * a5.PushAccel * a2

            if a5.PushMaxSpeed < BoostKickSpeed * v9 then
                BoostKickSpeed = v9 * a5.PushMaxSpeed
            end
        end
    end

    if u0.boosts(a1.itemId) then
        BoostKickSpeed = if not ((math.abs(BoostKickSpeed)) < 0.5) then
            BoostKickSpeed
                + (if not (BoostKickSpeed > 0) then if not (BoostKickSpeed < 0) then 0 else -1 else 1)
                    * a5.BoostAccel
                    * a2
        else
            a5.BoostKickSpeed
    end

    v8 = a5.Friction * a2
    local v11 = math.clamp(if not (math.abs(BoostKickSpeed) <= v8) then BoostKickSpeed - (if not (BoostKickSpeed > 0) then if not (BoostKickSpeed < 0) then 0 else -1 else 1) * v8 else 0, -a5.MaxSpeed, a5.MaxSpeed)
    v8 = a1.s + v11 * a2

    for i = 1, 4 do
        v1 = u0.length(a1.itemId)

        if (if not (v1 < v8) then if not (v8 < 0) then nil else false else true) == nil then
            break
        end

        v3 = if not v2 then -v8 else v8 - v1
        v4, v5, v6, v7 = u0.follow(a1.cell, a1.itemId, a1.yaw, v2, a3)

        if v4 and v5 and v6 ~= nil then
            a1.cell = v4
            a1.itemId = v5
            a1.yaw = v6
            v6 = math.abs(v11)

            if not v7 then
                v8 = v3
                v11 = v6
            else
                v8 = u0.length(v5) - v3
                v11 = -v6
            end

            continue
        end

        v8 = if not v2 then 0 else v1

        if a5.LaunchSpeed and a5.LaunchSpeed < (math.abs(v11)) then
            a1.launched = true
            break
        end

        v11 = 0
        break
    end

    a1.s = math.clamp(v8, 0, (u0.length(a1.itemId)))
    a1.v = v11

    return a1
end

function u0.nearest(a1, a2) -- Line: 310; upvalues: u0 (val); types: a1: table, a2: function
    local v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = math.round(a1.x / u0.CellSize)
    local v10 = math.round(a1.y / u0.CellSize)
    local v11 = math.round(a1.z / u0.CellSize)
    local v12 = nil
    local v13 = (1 / 0)
    local v14, v15 = a1, a2

    for i = -1, 1 do
        for j = -1, 1 do
            for k = -1, 1 do
                v1 = {x = v9 + i, y = v10 + j, z = v11 + k}
                v2, v3 = v15(v1)

                if v2 and u0.isRail(v2) then
                    v4 = v3 or 0
                    v5 = u0.length(v2)

                    for n = 0, 24 do
                        v6 = v5 * n / 24
                        v7 = u0.point(v1, v2, v4, v6)
                        v8 = math.sqrt((v7.x - v14.x) ^ 2 + (v7.y - v14.y) ^ 2 + (v7.z - v14.z) ^ 2)

                        if v8 < v13 then
                            v13 = v8
                            v12 = {
                                v = 0,
                                cell = v1,
                                itemId = v2,
                                yaw = v4,
                                s = v6,
                            }
                        end
                    end
                end
            end
        end
    end

    return v12, v13
end

return u0