-- Script path: game:GetService("ReplicatedStorage").Shared.Config.CropConfig
-- Decompile time: 1.15 ms

local u0 = {
    Crops = {
        Wheat = {
            id = "Wheat",
            seed = "WheatSeeds",
            growthSeconds = 90,
            yieldMin = 2,
            yieldMax = 3,
            seedChance = 0.45,
            rareItemId = "GoldenWheatSheaf",
            rareChance = 0.0015,
        },
        Carrot = {
            id = "Carrot",
            seed = "CarrotSeeds",
            growthSeconds = 180,
            yieldMin = 1,
            yieldMax = 3,
            seedChance = 0.35,
            rareItemId = "HeirloomCarrot",
            rareChance = 0.0015,
        },
        Tomato = {
            id = "Tomato",
            seed = "TomatoSeeds",
            growthSeconds = 215,
            yieldMin = 1,
            yieldMax = 3,
            seedChance = 0.2,
            rareItemId = "SunRipenedTomato",
            rareChance = 0.0015,
        },
        Onion = {
            id = "Onion",
            seed = "OnionSeeds",
            growthSeconds = 260,
            yieldMin = 1,
            yieldMax = 3,
            seedChance = 0.05,
            rareItemId = "PearlOnion",
            rareChance = 0.0015,
        },
    },
    RequiredGround = "FarmSoil",
}
local u7 = {}

for i, j in u0.Crops do
    u7[j.seed] = i
end

function u0.cropForSeed(a1) -- Line: 88; upvalues: u7 (val), u0 (val); types: a1: string?
    local v1 = if not a1 then nil else u7[a1]

    if v1 then
        return u0.Crops[v1]
    end

    return nil
end

function u0.isSeed(a1) -- Line: 93; upvalues: u7 (val); types: a1: string
    return u7[a1] ~= nil
end

function u0.itemIds() -- Line: 99; upvalues: u0 (val)
    local v1 = {}

    for i, j in u0.Crops do
        table.insert(v1, i)
        table.insert(v1, j.seed)
        table.insert(v1, j.rareItemId)
    end

    table.sort(v1)

    return v1
end

u0.Harvester = {
    RadiusCells = 4,
    ActionSeconds = 20,
    SeedsPerReap = 1,
    CropBuffer = 24,
    StopHarvestingAt = 20,
    ReplantReserveSeconds = 60,
}

function u0.harvesterFor(a1) -- Line: 157; types: a1: string
    return (("%*Harvester"):format(a1))
end

u0.DebugWaterLog = false
u0.TickSeconds = 3
u0.SpareStageModels = 64
local u28 = {}

function u0.cropForHarvester(a1) -- Line: 182; upvalues: u28 (val), u0 (val); types: a1: string
    local v1
    local v2 = u28[a1]

    if v2 ~= nil then
        return v2 or nil
    end

    v2 = string.match(a1, "^(%a+)Harvester$")
    u28[a1] = (if not v2 then nil else if not u0.Crops[v2] then nil else v2) or false

    return v1
end

return u0