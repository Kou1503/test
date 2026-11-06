-- Script path: game:GetService("ReplicatedStorage").Shared.Config.ToolConfig
-- Decompile time: 1.54 ms

local u0 = {
    Tools = {
        WoodPickaxe = {id = "WoodPickaxe", class = "Pickaxe", tier = "Wood", craftable = false},
        WoodAxe = {id = "WoodAxe", class = "Axe", tier = "Wood", craftable = false},
        StonePickaxe = {id = "StonePickaxe", class = "Pickaxe", tier = "Stone", craftable = true},
        StoneAxe = {id = "StoneAxe", class = "Axe", tier = "Stone", craftable = true},
        IronPickaxe = {id = "IronPickaxe", class = "Pickaxe", tier = "Iron", craftable = true},
        IronAxe = {id = "IronAxe", class = "Axe", tier = "Iron", craftable = true},
    },
    StarterEquipment = {WoodSword = true, WoodPickaxe = true, WoodAxe = true},
    StandardBands = {
        Wood = {GatherCooldown = {min = 0.55, max = 0.65}},
        Stone = {GatherCooldown = {min = 0.4, max = 0.5}},
        Iron = {GatherCooldown = {min = 0.27, max = 0.35}},
    },
    UnrolledTiers = {Wood = true},
    Nodes = {
        Tree = {
            hp = 100,
            yield = 5,
            resource = "Wood",
            requires = "Axe",
            clearanceCells = 1,
            groundHint = "Need Grass to Spawn Trees",
            clearAboveCells = 9,
            bonusDrop = {itemId = "TreeSapling", chance = 0.2},
            growsOn = {GrassBlock = true},
            reachBox = {width = 3, height = 9},
        },
        Stone = {
            hp = 80,
            yield = 4,
            resource = "Stone",
            requires = "Pickaxe",
            clearanceCells = 1,
        },
        IronOre = {
            hp = 120,
            yield = 4,
            resource = "IronOre",
            requires = "Pickaxe",
            clearanceCells = 1,
        },
        Coal = {
            hp = 90,
            yield = 3,
            resource = "Coal",
            requires = "Pickaxe",
            clearanceCells = 1,
        },
        Sand = {
            hp = 50,
            yield = 5,
            resource = "Sand",
            requires = "Pickaxe",
            clearanceCells = 1,
            minTier = "Stone",
        },
        Clay = {
            hp = 50,
            yield = 5,
            resource = "Clay",
            requires = "Pickaxe",
            clearanceCells = 1,
            minTier = "Stone",
        },
    },
    CandyDrop = {active = true, itemId = "CandyCorn", chances = {Node = 0.1, Crop = 0.1, Slime = 0.25}},
    TierRank = {Wood = 1, Stone = 2, Iron = 3},
}

function u0.reachesTier(a1, a2) -- Line: 160; upvalues: u0 (val); types: a1: string?, a2: string
    local v1 = if not a1 then nil else u0.Tools[a1]
    local TierRank = u0.TierRank
    local v2 = TierRank[if not v1 then "Wood" else v1.tier]
    v2 = (u0.TierRank[a2] or 1) <= (v2 or 1)

    return v2
end

u0.TierPower = {Wood = 10, Stone = 20, Iron = 25}
u0.DefaultTierPower = 10

function u0.powerOf(a1) -- Line: 181; upvalues: u0 (val); types: a1: string?
    local v1

    if not (if not a1 then nil else u0.Tools[a1]) then
        return u0.DefaultTierPower
    end

    return u0.TierPower[v1.tier] or u0.DefaultTierPower
end

u0.BlockDamage = {Wood = 25, Stone = 50, Iron = 100}
u0.DefaultBlockDamage = 25
u0.BlockHealSeconds = 3

function u0.blockDamageOf(a1) -- Line: 207; upvalues: u0 (val); types: a1: string?
    local v1

    if not (if not a1 then nil else u0.Tools[a1]) then
        return u0.DefaultBlockDamage
    end

    local DefaultBlockDamage = u0.BlockDamage[v1.tier]

    if not DefaultBlockDamage then
        return u0.DefaultBlockDamage
    end

    return DefaultBlockDamage
end

function u0.hitsFor(a1, a2) -- Line: 216; upvalues: u0 (val); types: a1: string, a2: string
    local v1 = u0.Nodes[a1]
    local DefaultTierPower = u0.TierPower[a2] or u0.DefaultTierPower

    if not v1 then
        return 0
    end

    return (math.ceil(v1.hp / DefaultTierPower))
end

u0.SwingAcceptToleranceSeconds = 0.06

function u0.clearanceOf(a1) -- Line: 238; upvalues: u0 (val); types: a1: string
    local v1 = u0.Nodes[a1]

    if v1 then
        return v1.clearanceCells or 0
    end

    return 0
end

function u0.clearAboveOf(a1) -- Line: 244; upvalues: u0 (val); types: a1: string
    local v1 = u0.Nodes[a1]

    if v1 then
        return v1.clearAboveCells or 0
    end

    return 0
end

function u0.maxClearAbove() -- Line: 250; upvalues: u0 (val)
    local v1 = 0

    for i in u0.Nodes do
        v1 = math.max(v1, (u0.clearAboveOf(i)))
    end

    return v1
end

function u0.growsOn(a1, a2) -- Line: 260; upvalues: u0 (val); types: a1: string, a2: string?
    local v1 = u0.Nodes[a1]

    if (if not v1 then nil else v1.growsOn) == nil then
        return true
    end

    local v2 = false

    if a2 ~= nil then
        local growsOn
        v2 = growsOn[a2] == true
    end

    return v2
end

return u0