-- Script path: game:GetService("ReplicatedStorage").Shared.Config.HubFieldConfig
-- Decompile time: 1.04 ms

local u0 = {
    Pools = {
        {
            id = "Mineral",
            anchors = 20,
            maxActive = 10,
            mix = {
                {
                    nodeType = "Stone",
                    weight = 45,
                    minActive = 3,
                    respawnMin = 15,
                    respawnMax = 24,
                },
                {
                    nodeType = "Coal",
                    weight = 30,
                    minActive = 2,
                    respawnMin = 18,
                    respawnMax = 28,
                },
                {
                    nodeType = "IronOre",
                    weight = 25,
                    minActive = 2,
                    respawnMin = 20,
                    respawnMax = 30,
                },
            },
        },
        {
            id = "Beach",
            anchors = 24,
            maxActive = 6,
            mix = {
                {
                    nodeType = "Sand",
                    weight = 3,
                    minActive = 1,
                    respawnMin = 14,
                    respawnMax = 22,
                },
                {
                    nodeType = "Clay",
                    weight = 2,
                    minActive = 1,
                    respawnMin = 14,
                    respawnMax = 22,
                },
            },
        },
        {
            id = "Tree",
            anchors = 24,
            maxActive = 12,
            mix = {
                {
                    nodeType = "Tree",
                    weight = 1,
                    minActive = 0,
                    respawnMin = 12,
                    respawnMax = 20,
                },
            },
        },
    },
    Layout = {
        Seed = 20260820,
        InnerRadiusStuds = 70,
        OuterRadiusStuds = 260,
        MinSpacingStuds = 14,
        FixtureClearanceStuds = 30,
        GroundSampleStuds = 1,
        GroundSinkStuds = 0.05,
    },
}

function u0.chooseMineral(a1, a2, a3) -- Line: 151; types: a1: table, a2: table, a3: number
    if #a1.mix == 0 then
        return nil
    end

    local v1 = {}

    for i, j in a1.mix do
        if (a2[j.nodeType] or 0) < j.minActive then
            table.insert(v1, j)
        end
    end

    local mix_2 = if not (#v1 > 0) then a1.mix else v1
    v1 = 0

    for k, n in mix_2 do
        v1 = v1 + math.max(0, n.weight)
    end

    if v1 <= 0 then
        return mix_2[1]
    end

    local v2 = math.clamp(a3, 0, 0.999999) * v1
    v1 = 0

    for m, i5 in mix_2 do
        v1 = v1 + math.max(0, i5.weight)

        if v2 < v1 then
            return i5
        end
    end

    return mix_2[#mix_2]
end

function u0.poolById(a1) -- Line: 187; upvalues: u0 (val); types: a1: string
    for i, j in u0.Pools do
        if j.id == a1 then
            return j
        end
    end

    return nil
end

function u0.mineralFor(a1, a2) -- Line: 196; types: a1: table, a2: string
    for i, j in a1.mix do
        if j.nodeType == a2 then
            return j
        end
    end

    return nil
end

return u0