-- Script path: game:GetService("ReplicatedStorage").Shared.Config.BushConfig
-- Decompile time: 0.65 ms

local u0 = {
    Bushes = {
        BerryBush = {
            id = "BerryBush",
            seed = "BerryBushSeed",
            produce = "Berries",
            yieldMin = 2,
            yieldMax = 4,
            growSeconds = 270,
            regrowMinSeconds = 250,
            regrowMaxSeconds = 280,
            seedChance = 0.02,
            rareItemId = "JumboBerry",
            rareChance = 0.001,
        },
    },
    GroundBlocks = {GrassBlock = true, FarmSoil = true},
}

function u0.bushForSeed(a1) -- Line: 85; upvalues: u0 (val); types: a1: string?
    if not a1 then
        return nil
    end

    for i, j in u0.Bushes do
        if j.seed == a1 then
            return j
        end
    end

    return nil
end

function u0.isSeed(a1) -- Line: 97; upvalues: u0 (val); types: a1: string
    return u0.bushForSeed(a1) ~= nil
end

function u0.itemIds() -- Line: 102; upvalues: u0 (val)
    local v1 = {}

    for i, j in u0.Bushes do
        table.insert(v1, j.seed)
        table.insert(v1, j.produce)
        table.insert(v1, j.rareItemId)
    end

    table.sort(v1)

    return v1
end

u0.RipeArtName = "Berries"
u0.GrowthVisualStages = 6

return u0