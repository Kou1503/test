-- Script path: game:GetService("ReplicatedStorage").Shared.ItemKinds
-- Decompile time: 7.84 ms

local u0 = {
    Categories = {"Blocks", "Machines", "Items", "Farm", "Collectibles", "Tools"},
    Overrides = {IronIngot = "Items", Gear = "Items", TreeSapling = "Farm", Glass = "Items"},
}
local u9 = {}

function u0.build(a1) -- Line: 96; upvalues: u9 (val), u0 (val); types: a1: table
    local dropId, id, itemId, output, output_2, output_3, output_4, output_5, produce, rareItemId, rareItemId_2,
        resource, seed, seed_2, v1, v2
    local v3 = u9[a1]

    if v3 then
        return v3
    end

    local Build = a1.Build
    local Bush = a1.Bush
    local Crop = a1.Crop
    local Enemy = a1.Enemy
    local Food = a1.Food
    local Recipe = a1.Recipe
    local Flower = a1.Flower
    local Shiny = a1.Shiny
    local Tool = a1.Tool
    local u866 = {}
    local u868 = {}
    local u870 = {}

    local function classify(a1, a2) -- Line: 117; upvalues: u866 (val); types: a1: string?, a2: string
        if type(a1) == "string" and not u866[a1] then
            u866[a1] = a2
        end
    end

    for i, j in u0.Overrides do
        u866[i] = j
    end

    for k in Build.Blocks do
        if type(k) == "string" and not u866[k] then
            u866[k] = "Blocks"
        end
    end

    for n in Build.Plantables do
        if type(n) == "string" and not u866[n] then
            u866[n] = "Blocks"
        end
    end

    for m, i5 in Recipe.Machines do
        output_5 = i5.output

        if type(output_5) == "string" and not u866[output_5] then
            u866[output_5] = "Machines"
        end
    end

    for i6, i7 in Recipe.HarvesterMerges do
        output_4 = i7.output

        if type(output_4) == "string" and not u866[output_4] then
            u866[output_4] = "Machines"
        end
    end

    for i8 in Recipe.CropHarvesterIds do
        if type(i8) == "string" and not u866[i8] then
            u866[i8] = "Machines"
        end
    end

    for i9 in Recipe.HarvesterIds do
        if type(i9) == "string" and not u866[i9] then
            u866[i9] = "Machines"
        end
    end

    local v4 = {Recipe.Tools, Recipe.Weapons, Recipe.Utility}
    local v5 = nil
    local v6 = nil

    for i10, i11 in v4, v5, v6 do
        for i12, i13 in i11 do
            output_3 = i13.output

            if type(output_3) == "string" and not u866[output_3] then
                u866[output_3] = "Tools"
            end
        end
    end

    for i14 in Tool.Tools do
        if type(i14) == "string" and not u866[i14] then
            u866[i14] = "Tools"
        end
    end

    for i15 in Build.Containers do
        if type(i15) == "string" and not u866[i15] then
            u866[i15] = "Tools"
        end
    end

    if v1.Wearable then
        for i16 in v1.Wearable.Items do
            if type(i16) == "string" and not u866[i16] then
                u866[i16] = "Tools"
            end
        end
    end

    for i17, i18 in Crop.Crops do
        seed_2 = i18.seed

        if type(seed_2) == "string" and not u866[seed_2] then
            u866[seed_2] = "Farm"
        end
    end

    if Recipe.Compost then
        local Output = Recipe.Compost.Output

        if type(Output) == "string" and not u866[Output] then
            u866[Output] = "Farm"
        end
    end

    for i19, i20 in Bush.Bushes do
        seed = i20.seed

        if type(seed) == "string" and not u866[seed] then
            u866[seed] = "Farm"
        end
    end

    v5 = nil
    v6 = nil

    for i21, i22 in Crop.Crops, v5, v6 do
        id = i22.id

        if type(id) == "string" and not u866[id] then
            u866[id] = "Farm"
        end

        rareItemId_2 = i22.rareItemId

        if type(rareItemId_2) == "string" and not u866[rareItemId_2] then
            u866[rareItemId_2] = "Farm"
        end
    end

    v5 = nil
    v6 = nil

    for i23, i24 in Bush.Bushes, v5, v6 do
        produce = i24.produce

        if type(produce) == "string" and not u866[produce] then
            u866[produce] = "Farm"
        end

        rareItemId = i24.rareItemId

        if type(rareItemId) == "string" and not u866[rareItemId] then
            u866[rareItemId] = "Farm"
        end
    end

    v5 = nil
    v6 = nil

    for i25 in Flower.Flowers, v5, v6 do
        if type(i25) == "string" and not u866[i25] then
            u866[i25] = "Farm"
        end

        u868[i25] = true
    end

    for i26 in Shiny.PieceFamily do
        if type(i26) == "string" and not u866[i26] then
            u866[i26] = "Collectibles"
        end
    end

    for i27, i28 in Recipe.Food do
        output_2 = i28.output

        if type(output_2) == "string" and not u866[output_2] then
            u866[output_2] = "Farm"
        end
    end

    for i29 in Food.Foods do
        if type(i29) == "string" and not u866[i29] then
            u866[i29] = "Farm"
        end
    end

    v5 = nil
    v6 = nil

    for i30, i31 in Tool.Nodes, v5, v6 do
        resource = i31.resource

        if type(resource) == "string" and not u866[resource] then
            u866[resource] = "Items"
        end

        if i31.bonusDrop then
            itemId = i31.bonusDrop.itemId

            if type(itemId) == "string" and not u866[itemId] then
                u866[itemId] = "Items"
            end
        end
    end

    for i32, i33 in Enemy.Enemies do
        dropId = i33.dropId

        if type(dropId) == "string" and not u866[dropId] then
            u866[dropId] = "Items"
        end
    end

    for i34 in Build.Blocks do
        u868[i34] = true
    end

    v4 = {Recipe.Machines, Recipe.HarvesterMerges}
    v5 = nil
    v6 = nil

    for i35, i36 in v4, v5, v6 do
        for i37, i38 in i36 do
            u868[i38.output] = true
        end
    end

    for i39 in Recipe.HarvesterIds do
        u868[i39] = true
    end

    for i40 in Recipe.CropHarvesterIds do
        u868[i40] = true
    end

    for i41 in Build.Plantables do
        u868[i41] = true
    end

    for i42 in Build.Containers do
        u868[i42] = true
    end

    for i43, i44 in Bush.Bushes do
        u868[i44.seed] = true
    end

    for i45, i46 in Crop.Crops do
        u868[i46.seed] = true
    end

    v5 = nil
    v6 = nil

    for i47, i48 in Recipe.Tools, v5, v6 do
        v2 = Tool.Tools[i48.output]
        output = i48.output
        u870[output] = if not v2 then "Pickaxe" else v2.class
    end

    for i49, i50 in Recipe.Weapons do
        u870[i50.output] = "Weapon"
    end

    for i51, i52 in Tool.Tools do
        if not i52.craftable then
            u870[i51] = i52.class
        end
    end

    u870.WoodSword = "Weapon"
    local v7 = {
        categoryOf = function(a1) -- Line: 314; upvalues: u866 (val); types: a1: string?
            if type(a1) == "string" then
                return u866[a1]
            end

            return nil
        end,
        isPlaceable = function(a1) -- Line: 318; upvalues: u868 (val); types: a1: string?
            local v1 = false

            if type(a1) == "string" then
                v1 = u868[a1] == true
            end

            return v1
        end,
        equipSlotOf = function(a1) -- Line: 322; upvalues: u870 (val); types: a1: string?
            if type(a1) == "string" then
                return u870[a1]
            end

            return nil
        end,
        equipmentFor = function(a1) -- Line: 327; upvalues: u870 (val); types: a1: string
            local v1 = {}

            for i, j in u870 do
                if j == a1 then
                    table.insert(v1, i)
                end
            end

            table.sort(v1)

            return v1
        end,
    }
    u9[v1] = v7

    return v7
end

return u0