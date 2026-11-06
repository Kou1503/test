-- Script path: game:GetService("ReplicatedStorage").Shared.Config.FlowerConfig
-- Decompile time: 3.33 ms

local v1, v2, v3, v4
local u164 = {
    Species = {"Daisy", "Lily", "Poppy", "Snapdragon", "Tulip"},
    BaseColors = {"Red", "Yellow", "Blue", "White"},
    Patterns = {"Plain", "Striped", "Dotted", "Glowing"},
    PlainPattern = "Plain",
    MutationColors = {"Orange", "Pink", "Purple", "Green", "Sky", "Lime", "Black"},
}
local u202 = {}

local function pairKey(a1, a2) -- Line: 69; types: a1: string, a2: string
    return (("%*|%*"):format(a1, a2))
end

local function authorMutation(a1, a2, a3)
    -- Line: 72
    -- upvalues: u202 (val)
    -- types: a1: string, a2: string, a3: string
    u202[("%*|%*"):format(a1, a2)] = a3
    u202[("%*|%*"):format(a2, a1)] = a3
end

u202["Red|Yellow"] = "Orange"
u202["Yellow|Red"] = "Orange"
u202["Red|White"] = "Pink"
u202["White|Red"] = "Pink"
u202["Blue|Red"] = "Purple"
u202["Red|Blue"] = "Purple"
u202["Yellow|Blue"] = "Green"
u202["Blue|Yellow"] = "Green"
u202["Blue|White"] = "Sky"
u202["White|Blue"] = "Sky"
u202["Yellow|White"] = "Lime"
u202["White|Yellow"] = "Lime"
u202["Purple|Green"] = "Black"
u202["Green|Purple"] = "Black"
u164.Mutations = u202
u164.GrowthSeconds = 180
u164.BudScale = 0.45
u164.PollinatorItem = "Pollinator"
u164.Breeding = {
    PartnerRadiusCells = 2,
    ChildRadiusCells = 1,
    PollenSeconds = 90,
    SecondsMin = 720,
    SecondsMax = 900,
    RainMultiplier = 0.8695652173913044,
}
u164.WildSpawn = {
    IslandGround = "GrassBlock",
    BaseChance = 0.12,
    RadiusCells = 24,
    MaxWildPerIsland = 6,
    RainMultiplier = 1.5,
    HubChance = 0.35,
    MaxWildOnHub = 8,
    HubRadiusStuds = 170,
    HubGrassTries = 12,
    HubSpacingStuds = 6,
    RollIntervalSeconds = {min = 150, max = 330},
    HubRollIntervalSeconds = {min = 90, max = 240},
}
u164.WildGrass = {
    ItemId = "WildGrass",
    Ground = "GrassBlock",
    Chance = 0.1,
    RadiusCells = 24,
    MaxPerIsland = 3,
    RollIntervalSeconds = {min = 300, max = 600},
}

function u164.chooseWild(a1, a2, a3) -- Line: 223; upvalues: u164 (val); types: a1: number, a2: number, a3: string?
    local v1 = u164.Species[math.clamp(math.floor(a1 * #u164.Species) + 1, 1, #u164.Species)]
    local BaseColors = u164.BaseColors

    return u164.idFor(v1, BaseColors[math.clamp(math.floor(a2 * #BaseColors) + 1, 1, #BaseColors)], a3)
end

local u200 = {}

local function prefixFor(a1) -- Line: 242; upvalues: u164 (val); types: a1: string
    if a1 == u164.PlainPattern then
        return ""
    end

    return a1
end

local function register(a1, a2, a3)
    -- Line: 246
    -- upvalues: u164 (val), u200 (val)
    -- types: a1: string, a2: string, a3: string
    u200[(("%*%*%*"):format(if a3 ~= u164.PlainPattern then a3 else "", a2, a1))] = {species = a1, color = a2, pattern = a3}
end

local v5 = nil
local v6 = nil

for i, j in u164.Species, v5, v6 do
    v1 = nil
    v2 = nil

    for k, n in u164.Patterns, v1, v2 do
        v3 = nil
        v4 = nil

        for m, i5 in u164.BaseColors, v3, v4 do
            u200[(("%*%*%*"):format(if n ~= u164.PlainPattern then n else "", i5, j))] = {species = j, color = i5, pattern = n}
        end

        v3 = nil
        v4 = nil

        for i6, i7 in u164.MutationColors, v3, v4 do
            u200[(("%*%*%*"):format(if n ~= u164.PlainPattern then n else "", i7, j))] = {species = j, color = i7, pattern = n}
        end
    end
end

u164.Flowers = u200

function u164.isFlower(a1) -- Line: 270; upvalues: u200 (val); types: a1: string?
    local v1 = false

    if a1 ~= nil then
        v1 = u200[a1] ~= nil
    end

    return v1
end

function u164.idFor(a1, a2, a3) -- Line: 290; upvalues: u164 (val); types: a1: string, a2: string, a3: string?
    local PlainPattern = a3 or u164.PlainPattern
    return (("%*%*%*"):format(if PlainPattern ~= u164.PlainPattern then PlainPattern else "", a2, a1))
end

function u164.speciesOf(a1) -- Line: 297; upvalues: u200 (val); types: a1: string
    local v1 = u200[a1]

    if v1 then
        return v1.species
    end

    return nil
end

function u164.patternOf(a1) -- Line: 302; upvalues: u200 (val), u164 (val); types: a1: string
    local v1 = u200[a1]

    if v1 then
        return v1.pattern
    end

    return u164.PlainPattern
end

function u164.inheritPattern(a1, a2, a3, a4)
    -- Line: 317
    -- upvalues: u164 (val)
    -- types: a1: string, a2: string, a3: number, a4: string?
    if a1 == a2 then
        if a1 == u164.PlainPattern then
            return a4 or u164.PlainPattern
        end

        return a1
    end

    if a3 < 0.5 then
        return a1
    end

    return a2
end

function u164.canBreed(a1, a2) -- Line: 328; upvalues: u200 (val); types: a1: string, a2: string
    local v1 = u200[a1]
    local v2 = u200[a2]

    if v1 and v2 then
        return v1.species == v2.species
    end

    return false
end

function u164.inheritColor(a1, a2, a3) -- Line: 348; upvalues: u202 (val); types: a1: string, a2: string, a3: number
    local v1 = math.clamp(a3, 0, 0.999999)
    local v2 = u202[("%*|%*"):format(a1, a2)]

    if a1 == a2 then
        if v2 and v1 >= 0.9 then
            return v2, true
        end

        return a1, false
    end

    if not v2 then
        return if not (v1 < 0.5) then a2 else a1, false
    end

    if v1 < 0.4 then
        return a1, false
    end

    if v1 < 0.8 then
        return a2, false
    end

    return v2, true
end

u164.Bees = {
    FlowersPerBee = 3,
    MaxBees = 12,
    MaxBeesTouch = 6,
    RangeStuds = 60,
    OwnIslandStuds = 1500,
    HopStuds = 18,
    SpeedStuds = 3.5,
    CurveStuds = 2.5,
    WobbleStuds = 0.3,
    WanderRadiusStuds = 5,
    HoverChance = 0.6,
    PerchStuds = 0.08,
    RescanSeconds = 2,
    WingTransparency = 0.45,
    WingBeatsPerSecond = 30,
    LandSeconds = {min = 3, max = 7},
    LegPace = {min = 0.6, max = 1.15},
    WanderLegs = {min = 3, max = 6},
    WanderHeightStuds = {min = 0.4, max = 2.4},
    HoverSeconds = {min = 0.6, max = 2},
    BodySize = {x = 0.12, y = 0.12, z = 0.2},
    BodyColor = {r = 245, g = 196, b = 40},
    StripeColor = {r = 30, g = 26, b = 20},
    WingSize = {x = 0.14, y = 0.02, z = 0.1},
}

return u164