-- Script path: game:GetService("ReplicatedStorage").Shared.WaterFlow
-- Decompile time: 12.62 ms

local v1 = {}

local function cellAt(a1, a2, a3) -- Line: 27; types: a1: number, a2: number, a3: number
    return {x = a1, y = a2, z = a3}
end

local function keyOf(a1) -- Line: 31; types: a1: table
    return (("%*,%*,%*"):format(a1.x, a1.y, a1.z))
end

local u3 = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}}

function v1.nextPour(a1, a2, a3) -- Line: 54; upvalues: u3 (val); types: a1: table, a2: table, a3: table
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, y, y_11, y_4, y_6, y_8

    local function inside(a1_2) -- Line: 55; upvalues: a1 (val), a3 (val); types: a1_2: table
        local v1 = false

        if (math.abs(a1_2.x - a1.x)) <= a3.spread then
            v1 = false

            if (math.abs(a1_2.z - a1.z)) <= a3.spread then
                v1 = false

                if a1_2.y < a1.y then
                    local y = a1_2.y
                    v1 = a1.y - a3.depth <= y
                end
            end
        end

        return v1
    end

    local function isWater(a1) -- Line: 61; upvalues: a2 (val); types: a1: table
        return a2.waterAt(a1) ~= nil
    end

    local function passable(a1) -- Line: 64; upvalues: a2 (val); types: a1: table
        return a2.waterAt(a1) ~= nil or a2.empty(a1)
    end

    local function below(a1) -- Line: 67; types: a1: table
        return {x = a1.x, y = a1.y - 1, z = a1.z}
    end

    local v15 = {x = a1.x, y = a1.y - 1, z = a1.z}

    if not (a2.waterAt(v15) ~= nil or a2.empty(v15)) then
        return nil, 0
    end

    while a2.empty(v15) do
        if not a2.empty({x = v15.x, y = v15.y - 1, z = v15.z}) then
            break
        end

        v14 = {x = v15.x, y = v15.y - 1, z = v15.z}
        v13 = false

        if (math.abs(v14.x - a1.x)) <= a3.spread then
            v13 = false

            if (math.abs(v14.z - a1.z)) <= a3.spread then
                v13 = false

                if v14.y < a1.y then
                    y = v14.y
                    v13 = a1.y - a3.depth <= y
                end
            end
        end

        if not v13 then
            break
        end

        v13 = v15
        v15 = {x = v13.x, y = v13.y - 1, z = v13.z}
    end

    local u508 = {}
    local x_7 = v15.x
    local y_2 = v15.y
    local z_7 = v15.z
    u508[("%*,%*,%*"):format(x_7, y_2, z_7)] = 0
    local u509 = {v15}
    local v16 = 1
    local v17 = nil
    local v18 = 0
    local v19 = (1 / 0)

    local function visit(a1_2, a2_2)
        -- Line: 93
        -- upvalues: u508 (val), a1 (val), a3 (val), a2 (val), u509 (val)
        -- types: a1_2: table, a2_2: number
        local v1 = ("%*,%*,%*"):format(a1_2.x, a1_2.y, a1_2.z)

        if u508[v1] == nil then
            local v2 = false

            if (math.abs(a1_2.x - a1.x)) <= a3.spread then
                v2 = false

                if (math.abs(a1_2.z - a1.z)) <= a3.spread then
                    v2 = false

                    if a1_2.y < a1.y then
                        local y_2 = a1_2.y
                        v2 = a1.y - a3.depth <= y_2
                    end
                end
            end

            if v2 and (a2.waterAt(a1_2) ~= nil or a2.empty(a1_2)) then
                u508[v1] = a2_2 + 1
                table.insert(u509, a1_2)
            end
        end
    end

    while u509[v16] do
        v1 = u509[v16]
        v16 = v16 + 1
        v2 = u508[("%*,%*,%*"):format(v1.x, v1.y, v1.z)]
        v3 = a2.waterAt(v1) or 0
        v4 = {x = v1.x, y = v1.y - 1, z = v1.z}
        v5 = a2.waterAt(v4)
        v6 = false

        if (math.abs(v4.x - a1.x)) <= a3.spread then
            v6 = false

            if (math.abs(v4.z - a1.z)) <= a3.spread then
                v6 = false

                if v4.y < a1.y then
                    y_4 = v4.y
                    v6 = a1.y - a3.depth <= y_4
                end
            end
        end

        if not v6 then
            if v3 < a3.full then
                v5 = v3
                    + math.max(math.abs(v1.x - v15.x), (math.abs(v1.z - v15.z)))
                    + v1.y * 0.001
                    + v2 * 0.0001

                if v5 < v19 then
                    v17 = v1
                    v18 = v3
                    v19 = v5
                end
            end

            if not a2.empty(v4) then
                v8 = u3
                v9 = nil
                v10 = nil

                for i, j in v8, v9, v10 do
                    v11 = {x = v1.x + j[1], y = v1.y, z = v1.z + j[2]}
                    v4 = ("%*,%*,%*"):format(v11.x, v11.y, v11.z)

                    if u508[v4] == nil then
                        v12 = false

                        if (math.abs(v11.x - a1.x)) <= a3.spread then
                            v12 = false

                            if (math.abs(v11.z - a1.z)) <= a3.spread then
                                v12 = false

                                if v11.y < a1.y then
                                    y_11 = v11.y
                                    v12 = a1.y - a3.depth <= y_11
                                end
                            end
                        end

                        if v12 and (a2.waterAt(v11) ~= nil or a2.empty(v11)) then
                            u508[v4] = v2 + 1
                            table.insert(u509, v11)
                        end
                    end
                end

                if a3.full <= v3 then
                    v8 = {x = v1.x, y = v1.y + 1, z = v1.z}
                    v9 = ("%*,%*,%*"):format(v8.x, v8.y, v8.z)

                    if u508[v9] == nil then
                        v10 = false

                        if (math.abs(v8.x - a1.x)) <= a3.spread then
                            v10 = false

                            if (math.abs(v8.z - a1.z)) <= a3.spread then
                                v10 = false

                                if v8.y < a1.y then
                                    y_8 = v8.y
                                    v10 = a1.y - a3.depth <= y_8
                                end
                            end
                        end

                        if v10 and (a2.waterAt(v8) ~= nil or a2.empty(v8)) then
                            u508[v9] = v2 + 1
                            table.insert(u509, v8)
                        end
                    end
                end
            end
        elseif a2.empty(v4) then
            v7 = ("%*,%*,%*"):format(v4.x, v4.y, v4.z)

            if u508[v7] == nil then
                v8 = false

                if (math.abs(v4.x - a1.x)) <= a3.spread then
                    v8 = false

                    if (math.abs(v4.z - a1.z)) <= a3.spread then
                        v8 = false

                        if v4.y < a1.y then
                            y_6 = v4.y
                            v8 = a1.y - a3.depth <= y_6
                        end
                    end
                end

                if v8 and (a2.waterAt(v4) ~= nil or a2.empty(v4)) then
                    u508[v7] = v2 + 1
                    table.insert(u509, v4)
                end
            end
        elseif v5 == nil then
            if v3 < a3.full then
                v5 = v3
                    + math.max(math.abs(v1.x - v15.x), (math.abs(v1.z - v15.z)))
                    + v1.y * 0.001
                    + v2 * 0.0001

                if v5 < v19 then
                    v17 = v1
                    v18 = v3
                    v19 = v5
                end
            end

            if not a2.empty(v4) then
                v8 = u3
                v9 = nil
                v10 = nil

                for k, n in v8, v9, v10 do
                    v11 = {x = v1.x + n[1], y = v1.y, z = v1.z + n[2]}
                    v4 = ("%*,%*,%*"):format(v11.x, v11.y, v11.z)

                    if u508[v4] == nil then
                        v12 = false

                        if (math.abs(v11.x - a1.x)) <= a3.spread then
                            v12 = false

                            if (math.abs(v11.z - a1.z)) <= a3.spread then
                                v12 = false

                                if v11.y < a1.y then
                                    y_11 = v11.y
                                    v12 = a1.y - a3.depth <= y_11
                                end
                            end
                        end

                        if v12 and (a2.waterAt(v11) ~= nil or a2.empty(v11)) then
                            u508[v4] = v2 + 1
                            table.insert(u509, v11)
                        end
                    end
                end

                if a3.full <= v3 then
                    v8 = {x = v1.x, y = v1.y + 1, z = v1.z}
                    v9 = ("%*,%*,%*"):format(v8.x, v8.y, v8.z)

                    if u508[v9] == nil then
                        v10 = false

                        if (math.abs(v8.x - a1.x)) <= a3.spread then
                            v10 = false

                            if (math.abs(v8.z - a1.z)) <= a3.spread then
                                v10 = false

                                if v8.y < a1.y then
                                    y_8 = v8.y
                                    v10 = a1.y - a3.depth <= y_8
                                end
                            end
                        end

                        if v10 and (a2.waterAt(v8) ~= nil or a2.empty(v8)) then
                            u508[v9] = v2 + 1
                            table.insert(u509, v8)
                        end
                    end
                end
            end
        elseif not (v5 < a3.full) then
            if v3 < a3.full then
                v5 = v3
                    + math.max(math.abs(v1.x - v15.x), (math.abs(v1.z - v15.z)))
                    + v1.y * 0.001
                    + v2 * 0.0001

                if v5 < v19 then
                    v17 = v1
                    v18 = v3
                    v19 = v5
                end
            end

            if not a2.empty(v4) then
                v8 = u3
                v9 = nil
                v10 = nil

                for m, i5 in v8, v9, v10 do
                    v11 = {x = v1.x + i5[1], y = v1.y, z = v1.z + i5[2]}
                    v4 = ("%*,%*,%*"):format(v11.x, v11.y, v11.z)

                    if u508[v4] == nil then
                        v12 = false

                        if (math.abs(v11.x - a1.x)) <= a3.spread then
                            v12 = false

                            if (math.abs(v11.z - a1.z)) <= a3.spread then
                                v12 = false

                                if v11.y < a1.y then
                                    y_11 = v11.y
                                    v12 = a1.y - a3.depth <= y_11
                                end
                            end
                        end

                        if v12 and (a2.waterAt(v11) ~= nil or a2.empty(v11)) then
                            u508[v4] = v2 + 1
                            table.insert(u509, v11)
                        end
                    end
                end

                if a3.full <= v3 then
                    v8 = {x = v1.x, y = v1.y + 1, z = v1.z}
                    v9 = ("%*,%*,%*"):format(v8.x, v8.y, v8.z)

                    if u508[v9] == nil then
                        v10 = false

                        if (math.abs(v8.x - a1.x)) <= a3.spread then
                            v10 = false

                            if (math.abs(v8.z - a1.z)) <= a3.spread then
                                v10 = false

                                if v8.y < a1.y then
                                    y_8 = v8.y
                                    v10 = a1.y - a3.depth <= y_8
                                end
                            end
                        end

                        if v10 and (a2.waterAt(v8) ~= nil or a2.empty(v8)) then
                            u508[v9] = v2 + 1
                            table.insert(u509, v8)
                        end
                    end
                end
            end
        else
            v7 = ("%*,%*,%*"):format(v4.x, v4.y, v4.z)

            if u508[v7] == nil then
                v8 = false

                if (math.abs(v4.x - a1.x)) <= a3.spread then
                    v8 = false

                    if (math.abs(v4.z - a1.z)) <= a3.spread then
                        v8 = false

                        if v4.y < a1.y then
                            y_6 = v4.y
                            v8 = a1.y - a3.depth <= y_6
                        end
                    end
                end

                if v8 and (a2.waterAt(v4) ~= nil or a2.empty(v4)) then
                    u508[v7] = v2 + 1
                    table.insert(u509, v4)
                end
            end
        end
    end

    return v17, v18
end

return v1