-- Script path: game:GetService("ReplicatedStorage").Shared.PlantLook
-- Decompile time: 0.78 ms

local Grid = require(script.Parent.Grid)
local Palette = require(script.Parent.Palette)
local Prefabs = require(script.Parent.Prefabs)
local BushConfig = require(script.Parent.Config.BushConfig)
local CropConfig = require(script.Parent.Config.CropConfig)

return {
    of = function(a1) -- Line: 44; upvalues: CropConfig (val), Grid (val), BushConfig (val); types: a1: string?
        if not a1 then
            return nil
        end

        local v1 = CropConfig.cropForSeed(a1)

        if v1 then
            return {
                category = "Crops",
                id = v1.id,
                size = Vector3.new(Grid.CellSize * 0.6, Grid.CellSize, Grid.CellSize * 0.6),
                colorId = v1.id,
                material = Enum.Material.Grass,
            }
        end

        for i, j in BushConfig.Bushes do
            if j.seed == a1 then
                return {
                    category = "Bushes",
                    id = j.id,
                    size = Vector3.new(Grid.CellSize * 0.7, Grid.CellSize * 0.8, Grid.CellSize * 0.7),
                    colorId = j.produce,
                    material = Enum.Material.LeafyGrass,
                }
            end
        end

        return nil
    end,
    model = function(a1) -- Line: 80; upvalues: Prefabs (val), Palette (val); types: a1: table
        local v1 = Prefabs.clone(a1.category, a1.id)

        if v1 then
            return v1
        end

        local Part = Instance.new("Part")
        Part.Name = a1.id
        Part.Size = a1.size
        Part.Color = Palette.colorFor(a1.colorId)
        Part.Material = a1.material

        return Part
    end,
}