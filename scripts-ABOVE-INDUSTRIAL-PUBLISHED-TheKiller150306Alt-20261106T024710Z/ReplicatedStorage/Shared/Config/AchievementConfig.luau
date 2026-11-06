-- Script path: game:GetService("ReplicatedStorage").Shared.Config.AchievementConfig
-- Decompile time: 1.73 ms

local u0 = {
    MaxCoinReward = 100000,
    TierNumerals = {"I", "II", "III", "IV", "V", "VI"},
    Families = {
        {
            id = "Mining",
            title = "Mining",
            unit = "resources mined",
            stats = {"StoneMined", "IronMined", "CoalMined", "SandMined", "ClayMined"},
            tiers = {
                {amount = 250, coins = 5000},
                {amount = 2500, coins = 20000, maxHealth = 5},
                {amount = 10000, coins = 40000},
                {amount = 25000, coins = 60000, maxHealth = 5},
                {amount = 50000, coins = 80000},
                {
                    amount = 100000,
                    coins = 100000,
                    maxHealth = 10,
                    bonus = {stat = "GatherPower", percent = 2},
                },
            },
        },
        {
            id = "Farming",
            title = "Farming",
            unit = "crops harvested",
            stats = {"CropsHarvested"},
            tiers = {
                {amount = 100, coins = 5000},
                {amount = 1000, coins = 20000, maxHealth = 5},
                {amount = 5000, coins = 40000},
                {amount = 12500, coins = 60000, maxHealth = 5},
                {amount = 25000, coins = 80000},
                {
                    amount = 50000,
                    coins = 100000,
                    maxHealth = 10,
                    bonus = {stat = "CropGrowth", percent = 2},
                },
            },
        },
        {
            id = "Lumber",
            title = "Lumber",
            unit = "trees felled",
            stats = {"TreesChopped"},
            tiers = {
                {amount = 50, coins = 5000},
                {amount = 500, coins = 20000, maxHealth = 5},
                {amount = 2500, coins = 40000},
                {amount = 6000, coins = 60000, maxHealth = 5},
                {amount = 12500, coins = 80000},
                {
                    amount = 25000,
                    coins = 100000,
                    maxHealth = 10,
                    bonus = {stat = "GatherPower", percent = 2},
                },
            },
        },
        {
            id = "Combat",
            title = "Combat",
            unit = "creatures defeated",
            stats = {"SlimesDefeated"},
            tiers = {
                {amount = 25, coins = 5000, maxHealth = 5},
                {amount = 250, coins = 20000, maxHealth = 5},
                {amount = 1000, coins = 40000, maxHealth = 8},
                {amount = 2500, coins = 60000, maxHealth = 8},
                {amount = 6000, coins = 80000, maxHealth = 8},
                {amount = 12500, coins = 100000, maxHealth = 21, bonus = {stat = "Damage", percent = 2}},
            },
        },
        {
            id = "Builder",
            title = "Builder",
            unit = "blocks placed",
            stats = {"BlocksPlaced"},
            tiers = {
                {amount = 250, coins = 5000},
                {amount = 2500, coins = 20000, maxHealth = 3},
                {amount = 10000, coins = 40000},
                {amount = 25000, coins = 60000, maxHealth = 3},
                {amount = 50000, coins = 80000},
                {amount = 100000, coins = 100000, maxHealth = 4},
            },
        },
    },
    HealthCeiling = {min = 180, max = 225},
}

function u0.tierOf(a1, a2) -- Line: 176; types: a1: table, a2: number
    return a1.tiers[a2]
end

function u0.numeral(a1) -- Line: 181; upvalues: u0 (val); types: a1: number
    return u0.TierNumerals[a1] or tostring(a1)
end

function u0.tiersEarned(a1, a2) -- Line: 187; types: a1: table, a2: number
    local v1 = 0

    for i, j in a1.tiers do
        if not (j.amount <= a2) then
            break
        end

        v1 = v1 + 1
    end

    return v1
end

function u0.totalMaxHealthBonus() -- Line: 200; upvalues: u0 (val)
    local v1 = 0
    local v2 = nil
    local v3 = nil

    for i, j in u0.Families, v2, v3 do
        for k, n in j.tiers do
            v1 = v1 + (n.maxHealth or 0)
        end
    end

    return v1
end

return u0