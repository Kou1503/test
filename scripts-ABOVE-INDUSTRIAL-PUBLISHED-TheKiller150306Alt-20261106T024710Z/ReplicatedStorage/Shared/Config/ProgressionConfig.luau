-- Script path: game:GetService("ReplicatedStorage").Shared.Config.ProgressionConfig
-- Decompile time: 0.75 ms

local u0 = {
    Stats = {
        TreesChopped = "TreesChopped",
        StoneMined = "StoneMined",
        IronMined = "IronMined",
        CoalMined = "CoalMined",
        SandMined = "SandMined",
        ClayMined = "ClayMined",
        IronSmelted = "IronSmelted",
        CropsHarvested = "CropsHarvested",
        CropsPlanted = "CropsPlanted",
        ItemsSold = "ItemsSold",
        ItemsBought = "ItemsBought",
        ItemsCrafted = "ItemsCrafted",
        BlocksPlaced = "BlocksPlaced",
        SoilTilled = "SoilTilled",
        HubVisits = "HubVisits",
        CoinsEarned = "CoinsEarned",
        FoodCooked = "FoodCooked",
        IronToolsCrafted = "IronToolsCrafted",
        SlimesDefeated = "SlimesDefeated",
        BucketsFilled = "BucketsFilled",
        FlowersBred = "FlowersBred",
        CartRides = "CartRides",
        WoodByBelt = "WoodByBelt",
        BreadByBelt = "BreadByBelt",
    },
    StatsAwaitingSystem = {},
    Upgrades = {
        {
            toTier = 2,
            coins = 7500,
            requirements = {
                {stat = "TreesChopped", amount = 10, label = "Chop 10 trees"},
                {stat = "StoneMined", amount = 25, label = "Mine 25 stone"},
                {stat = "IronMined", amount = 10, label = "Mine 10 iron ore"},
                {stat = "CropsHarvested", amount = 20, label = "Harvest 20 crops"},
                {stat = "SlimesDefeated", amount = 5, label = "Defeat 5 slimes"},
            },
            items = {Wood = 40, Stone = 60},
        },
    },
}

function u0.upgradeFrom(a1) -- Line: 154; upvalues: u0 (val); types: a1: number
    for i, j in u0.Upgrades do
        if j.toTier == a1 + 1 then
            return j
        end
    end

    return nil
end

function u0.isStat(a1) -- Line: 164; upvalues: u0 (val); types: a1: string
    return u0.Stats[a1] ~= nil
end

function u0.workbenchVisualId(a1) -- Line: 181; upvalues: u0 (val); types: a1: number
    local v1 = #u0.Upgrades + 1
    local v2 = math.clamp(math.floor(a1), 1, v1)

    if v2 <= 1 then
        return "Workbench"
    end

    return (("Workbench%*"):format((string.rep("I", v2))))
end

return u0