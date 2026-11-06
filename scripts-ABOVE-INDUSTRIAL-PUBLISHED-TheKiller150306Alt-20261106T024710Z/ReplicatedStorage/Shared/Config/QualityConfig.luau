-- Script path: game:GetService("ReplicatedStorage").Shared.Config.QualityConfig
-- Decompile time: 4.20 ms

local v1
local u0 = {
    BaseOutcomeOdds = {Standard = 0.94, Prime = 0.05, Masterwork = 0.01},
    Outcomes = {"Standard", "Prime", "Masterwork"},
    EligibilityByClass = {
        Weapon = {"Standard", "Prime", "Masterwork"},
        Tool = {"Standard", "Prime", "Masterwork"},
        Machine = {"Standard", "Prime", "Masterwork"},
        Drill = {"Standard", "Prime", "Masterwork"},
        Harvester = {"Standard", "Prime", "Masterwork"},
    },
    MaxNonStandardChance = 0.25,
    StatSteps = {
        Damage = 1,
        ExtraUses = 1,
        AttackCooldown = 0.05,
        RangeCells = 1,
        CraftSpeedPercent = 1,
        QualityLuckPercent = 0.1,
        HarvestIntervalSeconds = 0.1,
        GatherCooldown = 0.01,
        RecyclerProcessSeconds = 0.5,
    },
    LowerIsBetter = {
        AttackCooldown = true,
        HarvestIntervalSeconds = true,
        RecyclerProcessSeconds = true,
        GatherCooldown = true,
    },
    OutcomeTransforms = {
        Standard = {
            Damage = {min = 1, max = 1},
            AttackCooldown = {min = 1, max = 1},
            RangeCells = {min = 1, max = 1},
            HarvestIntervalSeconds = {min = 1, max = 1},
            Magnitude = {min = 1, max = 1},
        },
        Prime = {
            Damage = {min = 1.3, max = 1.24},
            AttackCooldown = {min = 0.85, max = 0.85},
            RangeCells = {min = 1.15, max = 1.15},
            HarvestIntervalSeconds = {min = 0.92, max = 0.92},
            Magnitude = {min = 1.25, max = 1.2},
        },
        Masterwork = {
            Damage = {min = 1.6, max = 1.5},
            AttackCooldown = {min = 0.72, max = 0.75},
            RangeCells = {min = 1.3, max = 1.28},
            HarvestIntervalSeconds = {min = 0.84, max = 0.84},
            Magnitude = {min = 1.5, max = 1.4},
        },
    },
    DefaultTransformKey = "Magnitude",
}

function u0.quantize(a1, a2) -- Line: 113; types: a1: number, a2: number
    if a2 <= 0 then
        return a1
    end

    return (tonumber((string.format("%.6f", (math.round(a1 / a2)) * a2))))
end

function u0.deriveBand(a1, a2, a3) -- Line: 126; upvalues: u0 (val); types: a1: table, a2: string, a3: string
    local v1
    local v2 = u0.OutcomeTransforms[a3]

    if not v2 then
        return a1
    end

    local v3 = v2[a2]

    if not v3 then
        v1 = v2[u0.DefaultTransformKey] or {min = 1, max = 1}
        v3 = if not u0.LowerIsBetter[a2] then
            v1
        else
            {min = 1 / v1.min, max = 1 / v1.max}
    end

    v2 = u0.StatSteps[a2] or 0
    v1 = {}
    local v4 = a1.min * v3.min
    v1.min = if not (v2 <= 0) then
        tonumber((string.format("%.6f", (math.round(v4 / v2)) * v2)))
    else
        v4
    v4 = a1.max * v3.max
    v1.max = if not (v2 <= 0) then
        tonumber((string.format("%.6f", (math.round(v4 / v2)) * v2)))
    else
        v4

    return v1
end

function u0.deriveOutcome(a1, a2) -- Line: 153; upvalues: u0 (val); types: a1: table, a2: string
    local v1 = {}

    for i, j in a1 do
        v1[i] = (u0.deriveBand(j, i, a2))
    end

    return v1
end

function u0.bestValue(a1, a2) -- Line: 162; upvalues: u0 (val); types: a1: table, a2: string
    if u0.LowerIsBetter[a2] then
        return a1.min
    end

    return a1.max
end

u0.RollValues = {
    Machine = {Standard = 3, Prime = 4, Masterwork = 5},
    Fabricator = {Standard = 2, Prime = 3, Masterwork = 3},
    Tool = {Standard = 3, Prime = 4, Masterwork = 5},
    Weapon = {
        Standard = {Damage = 2, AttackCooldown = 2},
        Prime = {Damage = 4, AttackCooldown = 3},
        Masterwork = {Damage = 4, AttackCooldown = 4},
    },
}

function u0.rollValuesFor(a1, a2) -- Line: 195; upvalues: u0 (val); types: a1: string, a2: string
    local v1 = u0.RollValues[a1]

    if v1 then
        return v1[a2]
    end

    return nil
end

function u0.machineRollValues(a1, a2) -- Line: 201; upvalues: u0 (val); types: a1: string, a2: string
    return u0.rollValuesFor(if not u0.RollValues[a1] then "Machine" else a1, a2)
end

u0.Bands = {WateringCan = {ExtraUses = {min = 0, max = 2}}}

function u0.rollOutcome(a1, a2) -- Line: 230; upvalues: u0 (val); types: a1: number?, a2: number
    local v1
    local BaseOutcomeOdds = u0.BaseOutcomeOdds
    local v2 = 0

    for i, j in u0.Outcomes do
        if j ~= "Standard" then
            v2 = v2 + (BaseOutcomeOdds[j] or 0)
        end
    end

    if v2 <= 0 then
        return "Standard"
    end

    local v3 = math.min(v2 * ((math.max(0, a1 or 0)) / 100 + 1), u0.MaxNonStandardChance)
        / v2
    local v4 = math.clamp(a2, 0, 0.999999)
    v2 = 0

    for k = #u0.Outcomes, 1, -1 do
        v1 = u0.Outcomes[k]

        if v1 ~= "Standard" then
            v2 = v2 + (BaseOutcomeOdds[v1] or 0) * v3

            if v4 < v2 then
                return v1
            end
        end
    end

    return "Standard"
end

function u0.rollStats(a1, a2, a3, a4) -- Line: 274; upvalues: u0 (val); types: a1: table, a2: string, a3: function
    local v1, v2, v3, v4, v5
    local v6 = {}
    local v7 = true
    local v8 = false
    local v9 = nil
    local v10 = nil
    local v11, v12 = a2, a4

    for i, j in a1, v9, v10 do
        v1 = u0.deriveBand(j, i, v11)
        v2 = if type(v12) ~= "table" then v12 else v12[i]

        if not v2 or not (v2 >= 2) then
            v3 = v1.min + (v1.max - v1.min) * v13()
        else
            v4 = math.clamp(math.floor((v13()) * v2), 0, v2 - 1)
            v3 = v1.min + (v1.max - v1.min) * v4 / (v2 - 1)
        end

        v5 = u0.StatSteps[i] or 0
        v2 = math.clamp(if not (v5 <= 0) then tonumber((string.format("%.6f", (math.round(v3 / v5)) * v5))) else v3, math.min(v1.min, v1.max), (math.max(v1.min, v1.max)))
        v6[i] = v2
        v8 = true

        if 1e-09 < (math.abs(v2 - (u0.bestValue(v1, i)))) then
            v7 = false
        end
    end

    return v6, v8 and v7
end

function u0.fillMissing(a1, a2, a3, a4, a5)
    -- Line: 326
    -- upvalues: u0 (val)
    -- types: a1: table, a2: string, a3: table?, a4: function
    local v1
    local v2 = {}
    local v3 = false
    local v4 = nil
    local v5 = nil
    local v6, v7, v8, v9, v10 = a3, a2, a4, a5, a1

    for i, j in a1, v4, v5 do
        if not v6 or type(v6[i]) ~= "number" then
            v2[i] = j
            v3 = true
        end
    end

    if not v3 then
        return nil, false
    end

    v3 = if not v6 then {} else table.clone(v6)

    for k, n in (u0.rollStats(v2, v7, v8, v9)) do
        v3[k] = n
    end

    local v11 = true

    for m, i5 in v10 do
        v1 = u0.deriveBand(i5, m, v7)
        v1 = math.abs(v3[m] - (u0.bestValue(v1, m)))

        if v1 > 1e-09 then
            v11 = false
        end
    end

    return v3, v11
end

return u0