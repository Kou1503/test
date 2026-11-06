-- Script path: game:GetService("ReplicatedStorage").Shared.Config.StorageConfig
-- Decompile time: 1.11 ms

local u0 = {
    StackSize = 99,
    RequestCap = 1000000000,
    Containers = {
        StorageChest = {
            id = "StorageChest",
            slots = 6,
            hasInputPort = false,
            hasOutputPort = false,
            acceptsUniqueItems = true,
            vaultPermissions = true,
        },
        InputChest = {
            id = "InputChest",
            slots = 10,
            hasInputPort = true,
            hasOutputPort = false,
            acceptsUniqueItems = true,
            vaultPermissions = true,
        },
        OutputChest = {
            id = "OutputChest",
            slots = 10,
            hasInputPort = true,
            hasOutputPort = true,
            acceptsUniqueItems = true,
            vaultPermissions = false,
        },
        OverflowChest = {
            id = "OverflowChest",
            slots = 24,
            hasInputPort = true,
            hasOutputPort = false,
            acceptsUniqueItems = true,
            vaultPermissions = false,
            overflows = true,
        },
        Recycler = {
            id = "Recycler",
            slots = 6,
            hasInputPort = true,
            hasOutputPort = false,
            acceptsUniqueItems = true,
            vaultPermissions = false,
            takesOnlyRecyclable = true,
            ownStatus = true,
        },
        LargeChest = {
            id = "LargeChest",
            slots = 24,
            hasInputPort = false,
            hasOutputPort = false,
            acceptsUniqueItems = true,
            vaultPermissions = true,
        },
        VendingMachine = {
            id = "VendingMachine",
            slots = 1,
            hasInputPort = false,
            hasOutputPort = false,
            acceptsUniqueItems = true,
            vaultPermissions = false,
            externallyManaged = true,
        },
        WeaponDisplay = {
            id = "WeaponDisplay",
            slots = 1,
            maxCount = 1,
            accepts = "Weapon",
            hasInputPort = false,
            hasOutputPort = false,
            acceptsUniqueItems = true,
            vaultPermissions = true,
            ownStatus = true,
            hover = {studs = 0.12, seconds = 3},
        },
        WeaponStand = {
            id = "WeaponStand",
            slots = 1,
            maxCount = 1,
            accepts = "Weapon",
            hasInputPort = false,
            hasOutputPort = false,
            acceptsUniqueItems = true,
            vaultPermissions = true,
            ownStatus = true,
        },
        ShinyTank = {
            id = "ShinyTank",
            slots = 1,
            maxCount = 1,
            accepts = "Shiny",
            hasInputPort = false,
            hasOutputPort = false,
            acceptsUniqueItems = false,
            vaultPermissions = true,
            ownStatus = true,
        },
        FlowerPot = {
            id = "FlowerPot",
            slots = 1,
            maxCount = 1,
            accepts = "Flower",
            hasInputPort = false,
            hasOutputPort = false,
            acceptsUniqueItems = false,
            vaultPermissions = true,
            ownStatus = true,
        },
        LargeFlowerPot = {
            id = "LargeFlowerPot",
            slots = 3,
            maxCount = 3,
            accepts = "Flower",
            hasInputPort = false,
            hasOutputPort = false,
            acceptsUniqueItems = false,
            vaultPermissions = true,
            ownStatus = true,
            eachOnItsOwnDisplay = true,
        },
        PlateDisplay = {
            id = "PlateDisplay",
            slots = 1,
            maxCount = 1,
            accepts = "Food",
            hasInputPort = false,
            hasOutputPort = false,
            acceptsUniqueItems = false,
            vaultPermissions = true,
            ownStatus = true,
        },
    },
    OutputChestEmission = {IntervalSeconds = 1, ItemsPerPulse = 1, SupportsFilter = false},
}

function u0.slotsUsedBy(a1) -- Line: 330; upvalues: u0 (val); types: a1: number
    return (math.ceil((math.max(0, a1)) / u0.StackSize))
end

function u0.slotsUsed(a1) -- Line: 334; upvalues: u0 (val); types: a1: table
    local v1 = 0

    for i, j in a1 do
        v1 = v1 + u0.slotsUsedBy(j)
    end

    return v1
end

function u0.spaceFor(a1, a2, a3) -- Line: 344; upvalues: u0 (val); types: a1: table, a2: table, a3: string
    local v1 = a2[a3] or 0

    if a1.maxCount then
        local v2 = 0

        for i, j in a2 do
            v2 = v2 + j
        end

        return (math.max(0, a1.maxCount - v2))
    end

    local v3 = a1.slots - ((u0.slotsUsed(a2)) - u0.slotsUsedBy(v1))

    if v3 <= 0 then
        return 0
    end

    return (math.max(0, v3 * u0.StackSize - v1))
end

function u0.isFull(a1, a2) -- Line: 362; upvalues: u0 (val); types: a1: table, a2: table
    return a1.slots <= (u0.slotsUsed(a2))
end

u0.EnforceStackLimits = false
u0.StackLimits = {RawResource = 9999, Component = 9999, Block = 999, Unique = 1}
u0.DisplayLook = {
    Weapon = {natural = true},
    Shiny = {natural = true},
    Flower = {natural = true, standing = true},
    Food = {standing = true},
}
u0.RefuseDismantleWhileHolding = {
    StorageChest = true,
    LargeChest = true,
    InputChest = true,
    OutputChest = true,
    OverflowChest = true,
    VendingMachine = true,
    WeaponDisplay = true,
    WeaponStand = true,
    ShinyTank = true,
    FlowerPot = true,
    LargeFlowerPot = true,
    PlateDisplay = true,
}

return u0