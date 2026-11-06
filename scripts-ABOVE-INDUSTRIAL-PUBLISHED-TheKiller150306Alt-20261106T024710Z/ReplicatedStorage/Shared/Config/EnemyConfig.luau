-- Script path: game:GetService("ReplicatedStorage").Shared.Config.EnemyConfig
-- Decompile time: 1.75 ms

local u0 = {
    ArtCategory = "Enemies",
    ArtName = "Slime",
    ArtScale = 0.78,
    TintedParts = {"Outside"},
    ShadedParts = {InsideBody = 0.75},
    Enemies = {
        GreenSlime = {
            id = "GreenSlime",
            jelly = true,
            hp = 40,
            moveSpeed = 10,
            flying = false,
            attack = 8,
            attackCooldown = 1.2,
            dropId = "SlimeGel",
            dropChance = 0.6,
            coinReward = 20,
            behavior = "BasicGround",
            mass = 1,
            color = {r = 96, g = 200, b = 110},
        },
        BlueSlime = {
            id = "BlueSlime",
            jelly = true,
            hp = 85,
            moveSpeed = 11,
            flying = false,
            attack = 10,
            attackCooldown = 1.2,
            dropId = "BlueSlimeGel",
            dropChance = 1,
            coinReward = 90,
            behavior = "BasicGround",
            mass = 1.4,
            color = {r = 86, g = 150, b = 236},
        },
        PinkSlime = {
            id = "PinkSlime",
            jelly = true,
            hp = 150,
            moveSpeed = 14,
            flying = false,
            attack = 12,
            attackCooldown = 1.1,
            dropId = "PinkSlimeGel",
            dropChance = 1,
            coinReward = 300,
            behavior = "BasicGround",
            mass = 1.8,
            color = {r = 240, g = 130, b = 190},
        },
        OrangeSlime = {
            id = "OrangeSlime",
            jelly = true,
            hp = 320,
            moveSpeed = 8,
            flying = false,
            attack = 15,
            attackCooldown = 1.5,
            dropId = "OrangeSlimeGel",
            dropChance = 1,
            coinReward = 1100,
            behavior = "BasicGround",
            mass = 3,
            color = {r = 245, g = 145, b = 55},
        },
        KingSlime = {
            id = "KingSlime",
            jelly = true,
            hp = 4000,
            moveSpeed = 7,
            flying = false,
            attack = 20,
            attackCooldown = 1.5,
            dropId = "PurpleSlimeGel",
            dropChance = 1,
            coinReward = 15000,
            behavior = "BasicGround",
            mass = 12,
            scale = 4,
            color = {r = 120, g = 70, b = 220},
        },
    },
    HubGuardians = {
        anchors = 20,
        maxAlive = 7,
        spawnRadiusStuds = 150,
        minSpawnDistanceFromCenterStuds = 45,
        minSpawnDistanceFromPlayerStuds = 30,
        respawnMinSeconds = 30,
        respawnMaxSeconds = 45,
        refillCheckSeconds = 60,
        leashStuds = 55,
        recoverStuds = 250,
        maxRiseStuds = 12,
        hopIntervalSeconds = 0.85,
        hopSecondsInAir = 0.42,
        hopRiseStuds = 2.4,
        aggroRadiusStuds = 26,
        loseInterestRadiusStuds = 40,
        contactCooldownSeconds = 1.4,
        contactRangeStuds = 4.5,
        family = {
            {enemyId = "GreenSlime", weight = 62},
            {enemyId = "BlueSlime", weight = 25},
            {enemyId = "PinkSlime", weight = 6},
            {enemyId = "OrangeSlime", weight = 3},
        },
    },
}

function u0.chooseGuardian(a1) -- Line: 289; upvalues: u0 (val); types: a1: number
    local family = u0.HubGuardians.family
    local v1 = 0

    for i, j in family do
        v1 = v1 + j.weight
    end

    local v2 = math.clamp(a1, 0, 0.999999) * v1
    v1 = 0

    for k, n in family do
        v1 = v1 + n.weight

        if v2 < v1 then
            return n.enemyId
        end
    end

    return family[1].enemyId
end

u0.SharedLoot = {Players = 2, MinShareOfHP = 0.1}

function u0.sharedLootWinners(a1, a2) -- Line: 323; upvalues: u0 (val); types: a1: table, a2: number
    local v1 = a2 * u0.SharedLoot.MinShareOfHP
    local v2 = {}

    for i, j in a1 do
        if 0 < j.damage and v1 <= j.damage then
            table.insert(v2, j)
        end
    end

    table.sort(
        v2,
        function(a1, a2) -- Line: 331
            if a1.damage ~= a2.damage then
                return a2.damage < a1.damage
            end

            return a1.order < a2.order
        end
    )

    v1 = {}

    for k = 1, (math.min(#v2, u0.SharedLoot.Players)) do
        table.insert(v1, v2[k].who)
    end

    return v1
end

u0.Knockback = {StudsPerHit = 7, Seconds = 0.22, MaxStuds = 12}

function u0.knockbackVelocity(a1, a2) -- Line: 370; upvalues: u0 (val); types: a1: string, a2: vector
    local v1 = u0.Enemies[a1]
    local mass = if not v1 then 1 else if not v1.mass then 1 else v1.mass
    v1 = Vector3.new(a2.X, 0, a2.Z)

    if not (0.001 <= v1.Magnitude) then
        return (Vector3.new(0, 0, 0))
    end

    return v1.Unit
        * ((math.min(u0.Knockback.MaxStuds, u0.Knockback.StudsPerHit / (math.max(0.1, mass))))
            / u0.Knockback.Seconds)
end

function u0.wanderDirection(a1, a2, a3) -- Line: 398; types: a1: vector, a2: vector, a3: number
    local Magnitude = a1.Magnitude

    if Magnitude < 0.001 then
        return a2
    end

    local v1 = Magnitude / math.max(1, a3)

    if v1 >= 1 then
        return a1
    end

    return a2 * (1 - v1) + a1.Unit * v1
end

return u0