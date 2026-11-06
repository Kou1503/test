-- Script path: game:GetService("ReplicatedStorage").Shared.DisplayNames
-- Decompile time: 0.24 ms

local u0 = {
    Overrides = {
        Glowlight = "Blue Glowlight",
        Glowstick = "Tester Glowstick",
        VegetableSoup = "Veggie Soup",
        WoodHarvesterI = "Lumber Mill I",
        WoodHarvesterII = "Lumber Mill II",
        WoodHarvesterIII = "Lumber Mill III",
        StoneHarvesterI = "Stone Drill I",
        StoneHarvesterII = "Stone Drill II",
        StoneHarvesterIII = "Stone Drill III",
        IronHarvesterI = "Iron Drill I",
        IronHarvesterII = "Iron Drill II",
        IronHarvesterIII = "Iron Drill III",
        CoalHarvesterI = "Coal Drill I",
        SandHarvesterI = "Sand Drill I",
        ClayHarvesterI = "Clay Drill I",
        CoalHarvesterII = "Coal Drill II",
        CoalHarvesterIII = "Coal Drill III",
        Fabricator = "Machinery Workbench",
        Bakehouse = "Industrial Cooker",
        BlockPress = "Industrial Block Press",
        Minecart = "Railcart",
        StorageChest = "Small Chest",
        Conveyor = "Conveyor",
        ConveyorCorner = "Conveyor Right",
        ConveyorCornerLeft = "Conveyor Left",
        ConveyorRampUp = "Conveyor Ramp Up",
        ConveyorRampDown = "Conveyor Ramp Down",
    },
}

function u0.of(a1) -- Line: 89; upvalues: u0 (val); types: a1: string
    local v1 = u0.Overrides[a1]

    if v1 then
        return v1
    end

    return (string.gsub(string.gsub(a1, "(%l)(%u)", "%1 %2"), "(%u)(%u%l)", "%1 %2"))
end

return u0