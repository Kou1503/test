-- Script path: game:GetService("ReplicatedStorage").Shared.ItemStats
-- Decompile time: 4.29 ms

local u0 = {
    BetterColor = "#78DC8C",
    WorseColor = "#F08C78",
    QualityColors = {Standard = "#969EB2", Prime = "#78DC8C", Masterwork = "#BEAAFF"},
}

function u0.paint(a1) -- Line: 50; upvalues: u0 (val); types: a1: table
    if a1.better == true then
        return (("<font color=\"%*\">%*</font>"):format(u0.BetterColor, a1.value))
    end

    if a1.better == false then
        return (("<font color=\"%*\">%*</font>"):format(u0.WorseColor, a1.value))
    end

    return a1.value
end

local function round(a1, a2) -- Line: 74; types: a1: number, a2: number
    local v1 = 10 ^ a2
    local v2 = math.floor(a1 * v1 + 0.5) / v1

    if a2 <= 0 then
        return (string.format("%d", v2))
    end

    return (string.format(("%%.%*f"):format(a2), v2))
end

local function midpoint(a1) -- Line: 81; types: a1: table?
    if a1 and type(a1.min) == "number" and type(a1.max) == "number" then
        return (a1.min + a1.max) / 2
    end

    return nil
end

local function spread(a1) -- Line: 89
    if type(a1) == "number" then
        return a1, a1
    end

    if type(a1) == "table" and type(a1.min) == "number" and type(a1.max) == "number" then
        return a1.min, a1.max
    end

    return nil, nil
end

function u0.of(a1, a2, a3) -- Line: 106; types: a1: table, a2: string, a3: table?
    local v1
    local u3 = {}

    local function add(a1_2, a2, a3_2, a4, a5)
        -- Line: 116
        -- upvalues: a3 (val), u3 (val), a1 (val)
        -- types: a1_2: string, a2: string, a3_2: table?, a4: function, a5: number?
        local max_3, min_3
        local v1 = if not a3_2 or type(a3_2.min) ~= "number" then
            nil
        else
            if type(a3_2.max) == "number" then (a3_2.min + a3_2.max) / 2 else nil
        local v2 = if not a3 then nil else a3[a2]

        if type(v2) == "number" then
            min_3 = v2
            max_3 = v2
        elseif type(v2) ~= "table"
            or type(v2.min) ~= "number"
            or type(v2.max) ~= "number" then
            min_3 = nil
            max_3 = nil
        else
            min_3 = v2.min
            max_3 = v2.max
        end

        if min_3 ~= nil and max_3 ~= nil then
            local v3 = true

            if v1 ~= nil then
                v3 = true

                if min_3 == v1 then
                    v3 = max_3 ~= v1
                end
            end

            local u80 = a5 or v1
            v1 = nil

            if u80 then
                local Quality = a1.Quality

                if Quality then
                    Quality = a1.Quality.LowerIsBetter[a2] == true
                end

                local function beats(a1) -- Line: 138; upvalues: Quality (val), u80 (val); types: a1: number
                    if Quality then
                        return a1 < u80 - 1e-09
                    end

                    return u80 + 1e-09 < a1
                end

                local function trails(a1) -- Line: 141; upvalues: Quality (val), u80 (val); types: a1: number
                    if Quality then
                        return u80 + 1e-09 < a1
                    end

                    return a1 < u80 - 1e-09
                end

                if not (if not Quality then u80 + 1e-09 < min_3 else min_3 < u80 - 1e-09) then
                    if (if not Quality then min_3 < u80 - 1e-09 else u80 + 1e-09 < min_3)
                        and (if not Quality then max_3 < u80 - 1e-09 else u80 + 1e-09 < max_3) then
                        v1 = false
                    end
                elseif if not Quality then u80 + 1e-09 < max_3 else max_3 < u80 - 1e-09 then
                    v1 = true
                elseif (if not Quality then min_3 < u80 - 1e-09 else u80 + 1e-09 < min_3)
                    and (if not Quality then max_3 < u80 - 1e-09 else u80 + 1e-09 < max_3) then
                    v1 = false
                end
            end

            table.insert(
                u3,
                {
                    label = a1_2,
                    value = if min_3 ~= max_3 then
                        ("%*–%*"):format(a4(min_3), (a4(max_3)))
                    else
                        a4(min_3),
                    rolled = v3,
                    better = v1,
                }
            )

            return
        end

        if v1 then
            table.insert(
                u3,
                {label = a1_2, value = a4(v1)}
            )
        end
    end

    local v2 = a1.Weapon.Weapons[a2]

    if v2 and v2.standard then
        add(
            "Damage",
            "Damage",
            v2.standard.Damage,
            function(a1) -- Line: 155
                return (string.format("%d", math.floor(a1 * 1 + 0.5) / 1))
            end
        )

        add(
            "Speed",
            "AttackCooldown",
            v2.standard.AttackCooldown,
            function(a1) -- Line: 161
                local v1 = math.floor(1 / a1 * 10 + 0.5) / 10
                return (("%*/s"):format((string.format(("%%.%*f"):format(1), v1))))
            end
        )

        return u3
    end

    local WateringCan = a1.Build.Farm.WateringCan

    if a2 == WateringCan.ItemId then
        v1 = a1.Quality.Bands[a2]
        add(
            "Holds",
            "ExtraUses",
            if not v1 then nil else v1.ExtraUses,
            function(a1) -- Line: 173; upvalues: WateringCan (val)
                return (("%* uses"):format(WateringCan.Uses + (math.floor(a1))))
            end
        )

        return u3
    end

    v1 = a1.Tool.Tools[a2]

    if v1 then
        table.insert(
            u3,
            {
                label = "Power",
                value = string.format("%d", math.floor((a1.Tool.powerOf(a2)) * 1 + 0.5) / 1),
            }
        )

        local v3 = a1.Tool.StandardBands[v1.tier]
        add(
            "Speed",
            "GatherCooldown",
            if not v3 then nil else v3.GatherCooldown,
            function(a1) -- Line: 186
                local v1 = math.floor(1 / a1 * 10 + 0.5) / 10
                return (("%*/s"):format((string.format(("%%.%*f"):format(1), v1))))
            end
        )

        return u3
    end

    v1 = a1.Factory.MachineStandardBands[a2]

    if v1 then
        local Harvester = a1.Factory.Harvester
        local u90 = Harvester.SaplingSecondsByMachine[a2]

        if not u90 then
            add(
                "Processes every",
                "HarvestIntervalSeconds",
                v1.HarvestIntervalSeconds,
                function(a1) -- Line: 207
                    return (("%*s"):format((string.format("%d", math.floor(a1 * 1 + 0.5) / 1))))
                end
            )
        else
            local Default = Harvester.PerMachine[a2] or Harvester.Default
            local HarvestSeconds = Default.HarvestSeconds

            add(
                "Grows a tree in",
                "HarvestIntervalSeconds",
                v1.HarvestIntervalSeconds,
                function(a1) -- Line: 203; upvalues: u90 (val), HarvestSeconds (val)
                    return (("%*s"):format((string.format("%d", math.floor(a1 * u90 / HarvestSeconds * 1 + 0.5) / 1))))
                end
            )
        end

        add(
            "Craft speed",
            "CraftSpeedPercent",
            v1.CraftSpeedPercent,
            function(a1) -- Line: 215
                local v1 = tonumber((string.format("%d", math.floor((a1 - 100) * 1 + 0.5) / 1)))

                if v1 == 0 then
                    return "Normal"
                end

                if v1 > 0 then
                    return (("%*%% faster"):format(v1))
                end

                return (("%*%% slower"):format(-v1))
            end,
            100
        )

        add(
            "Quality luck",
            "QualityLuckPercent",
            v1.QualityLuckPercent,
            function(a1) -- Line: 222
                local v1 = math.floor(a1 * 10 + 0.5) / 10
                return (("+%*%%"):format((string.format(("%%.%*f"):format(1), v1))))
            end
        )
    end

    return u3
end

function u0.summary(a1, a2, a3, a4)
    -- Line: 236
    -- upvalues: u0 (val)
    -- types: a1: table, a2: string, a3: string?, a4: table?
    local v1 = {}
    local v2 = if not a3 then nil else if a3 == "Standard" then nil else u0.QualityColors[a3]

    if a3 and v2 then
        table.insert(v1, (("<font color=\"%*\">%*</font>"):format(v2, a3)))
    end

    if a4 and next(a4) ~= nil then
        for i, j in u0.of(a1, a2, a4) do
            table.insert(v1, (("%* %*"):format(j.label, (u0.paint(j)))))
        end
    end

    return table.concat(v1, "  ·  ")
end

return u0