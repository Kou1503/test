-- Script path: game:GetService("ReplicatedStorage").Shared.Config.ShinyConfig
-- Decompile time: 3.26 ms

local v1
local u143 = {
    Regions = {Hub = "Hub", Home = "Home"},
    Families = {
        {
            id = "Blue",
            title = "The Blue Collection",
            weight = 70,
            wearable = "Glowlight",
            pieces = {
                "FrozenBlueShiny",
                "FieryBlueShiny",
                "ElectricBlueShiny",
                "OceanBlueShiny",
                "StormBlueShiny",
                "MidnightBlueShiny",
            },
            regions = {"Hub", "Home"},
            reward = {coins = 0, itemId = "SlimeGel", itemCount = 100},
        },
        {
            id = "Red",
            title = "The Ember Collection",
            weight = 22,
            wearable = "CrimsonGlowlight",
            pieces = {
                "EmberRedShiny",
                "CinderRedShiny",
                "BlazeRedShiny",
                "MagmaRedShiny",
                "InfernoRedShiny",
                "PhoenixRedShiny",
            },
            regions = {"Hub", "Home"},
            reward = {coins = 0, itemId = "PinkSlimeGel", itemCount = 6},
        },
        {
            id = "Yellow",
            title = "The Sun Collection",
            weight = 8,
            wearable = "SunGlowlight",
            pieces = {
                "DawnYellowShiny",
                "SolarYellowShiny",
                "RadiantYellowShiny",
                "SunburstYellowShiny",
                "ZenithYellowShiny",
                "CoronaYellowShiny",
            },
            regions = {"Hub", "Home"},
            reward = {coins = 0, itemId = "GoldenBread", itemCount = 10},
        },
    },
    RewardScale = {BaseCoins = 50000, RoundTo = 10000},
}
local v2 = 0

for i, j in u143.Families do
    v2 = math.max(v2, j.weight)
end

local RewardScale = u143.RewardScale

for k, n in u143.Families do
    v1 = RewardScale.BaseCoins * v2 / n.weight
    n.reward.coins = (math.floor(v1 / RewardScale.RoundTo + 0.5)) * RewardScale.RoundTo
end

u143.Spawning = {
    IslandGround = "GrassBlock",
    MaxUncollectedPerRegion = 2,
    BaseChance = 0.35,
    LifetimeSeconds = 1200,
    HubRadiusStuds = 170,
    HubGrassTries = 12,
    HomeRadiusCells = 20,
    MinDistanceFromPlayerStuds = 25,
    RollIntervalSeconds = {min = 300, max = 540},
}
u143.Modifiers = {Night = 2, Windy = 1.15, Maximum = 2.5}
u143.OwnerProtectedRegions = {Home = true, Hub = false}
local u144 = {}
local v3 = nil
local v4 = nil

for m, i5 in u143.Families, v3, v4 do
    for i6, i7 in i5.pieces do
        u144[i7] = i5.id
    end
end

u143.PieceFamily = u144

function u143.familyOf(a1) -- Line: 223; upvalues: u144 (val); types: a1: string
    return u144[a1]
end

function u143.isShiny(a1) -- Line: 227; upvalues: u144 (val); types: a1: string?
    local v1 = false

    if a1 ~= nil then
        v1 = u144[a1] ~= nil
    end

    return v1
end

function u143.flavourOf(a1) -- Line: 242; upvalues: u143 (val); types: a1: string
    local v1 = u143.familyOf(a1)

    if not v1 then
        return nil
    end

    local v2 = string.match(a1, (("^(%%a+)%*Shiny$"):format(v1)))

    if v2 ~= nil and v2 ~= "" then
        return v2
    end

    return nil
end

function u143.flavours() -- Line: 256; upvalues: u143 (val)
    local v1
    local v2 = {}
    local v3 = {}
    local v4 = nil
    local v5 = nil

    for i, j in u143.Families, v4, v5 do
        for k, n in j.pieces do
            v1 = u143.flavourOf(n)

            if v1 and not v2[v1] then
                v2[v1] = true
                table.insert(v3, v1)
            end
        end
    end

    table.sort(v3)

    return v3
end

function u143.familiesIn(a1) -- Line: 273; upvalues: u143 (val); types: a1: string
    local v1 = {}

    for i, j in u143.Families do
        if table.find(j.regions, a1) then
            table.insert(v1, j)
        end
    end

    return v1
end

function u143.spawnMultiplier(a1, a2) -- Line: 284; upvalues: u143 (val); types: a1: boolean, a2: string?
    local v1 = 1

    if a1 then
        v1 = v1 * u143.Modifiers.Night
    end

    if a2 == "Windy" then
        v1 = v1 * u143.Modifiers.Windy
    end

    return (math.min(v1, u143.Modifiers.Maximum))
end

function u143.choosePiece(a1, a2, a3) -- Line: 300; upvalues: u143 (val); types: a1: string, a2: number, a3: number
    local v1 = u143.familiesIn(a1)

    if #v1 == 0 then
        return nil
    end

    local v2 = 0

    for i, j in v1 do
        v2 = v2 + j.weight
    end

    local v3 = math.clamp(a2, 0, 0.999999) * v2
    v2 = v1[#v1]

    for k, n in v1 do
        if v3 < n.weight then
            v2 = n
            break
        end

        v3 = v3 - n.weight
    end

    local pieces = v2.pieces

    if #pieces == 0 then
        return nil
    end

    return pieces[math.min(#pieces, (math.floor((math.clamp(a3, 0, 0.999999)) * #pieces)) + 1)]
end

u143.Look = {
    Body = {
        sizeStuds = 0.35,
        materialName = "Neon",
        transparency = 0,
        castShadow = false,
        heightStuds = 1.741,
    },
    Light = {rangeStuds = 10, brightness = 2},
    Emitters = {
        {
            id = "InnerGlint",
            texture = "rbxassetid://139788553818301",
            size = 1.3,
            transparency = 0.6,
            rate = 1,
            speed = 0.01,
            brightness = 1,
            lightEmission = 1,
            lightInfluence = 0,
            orientation = "FacingCamera",
            emissionDirection = "Top",
            lifetimeSeconds = {1, 1},
            spreadAngle = {0, 0},
        },
        {
            id = "OuterGlint",
            texture = "rbxassetid://110989060619599",
            size = 1.3,
            transparency = 0.6,
            rate = 1,
            speed = 0.01,
            brightness = 1,
            lightEmission = 1,
            lightInfluence = 0,
            orientation = "FacingCamera",
            emissionDirection = "Top",
            lifetimeSeconds = {1, 1},
            spreadAngle = {0, 0},
        },
        {
            id = "Drift",
            texture = "rbxassetid://70668652183701",
            size = 2,
            rate = 8,
            speed = 1,
            brightness = 1,
            lightEmission = 1,
            lightInfluence = 0,
            orientation = "FacingCamera",
            emissionDirection = "Top",
            transparency = {{0, 1}, {0.367, 0.156, 0.0875}, {0.495, 0.131, 0.0313}, {0.85, 1}, {1, 1}},
            lifetimeSeconds = {0.5, 1.5},
            spreadAngle = {0, 0},
        },
    },
}
u143.EmitterOverrides = {}

function u143.emittersFor(a1) -- Line: 433; upvalues: u143 (val); types: a1: string
    local v1, v2
    local v3 = u143.EmitterOverrides[a1]
    local v4 = {}
    local v5 = nil
    local v6 = nil

    for i, j in u143.Look.Emitters, v5, v6 do
        v1 = table.clone(j)
        v2 = if not v3 then nil else v3[j.id]

        if v2 then
            for k, n in v2 do
                v1[k] = n
            end
        end

        table.insert(v4, v1)
    end

    return v4
end

return u143