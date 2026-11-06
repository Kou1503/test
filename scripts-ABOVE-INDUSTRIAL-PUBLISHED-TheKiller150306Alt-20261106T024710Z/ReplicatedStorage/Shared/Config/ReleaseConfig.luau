-- Script path: game:GetService("ReplicatedStorage").Shared.Config.ReleaseConfig
-- Decompile time: 1.31 ms

local u0 = {
    AdminAttribute = "DevAdmin",
    CriticalVersion = 23,
    Features = {
        Irrigation = {released = true, items = {"WaterPump", "WaterPipe", "WaterPipeCorner", "WaterSpout"}},
        Composting = {released = true, items = {"Composter", "Fertilizer"}},
        Rails = {
            released = true,
            items = {
                "Rail",
                "RailCorner",
                "RailRamp",
                "RailBooster",
                "RailRampBooster",
                "Minecart",
                "IronRailcart",
            },
        },
        LoadBalancing = {released = true, items = {"Splitter"}},
        Buffering = {released = true, items = {"OverflowChest"}},
        BlockPressing = {released = true, items = {"BlockPress"}},
        DyedBlocks = {released = true, items = {}},
        Furniture = {released = true, items = {"WeaponDisplay", "WeaponStand"}},
        ShinyTanks = {released = false, items = {"ShinyTank"}},
        FloristPots = {released = true, craftable = false, items = {"FlowerPot", "LargeFlowerPot"}},
    },
}

for i, j in {"Red", "Yellow", "Blue", "White", "Orange", "Pink", "Purple", "Green", "Sky", "Lime", "Black"} do
    table.insert(u0.Features.DyedBlocks.items, (("%*ClayBlock"):format(j)))
    table.insert(u0.Features.DyedBlocks.items, (("%*NeonBlock"):format(j)))
end

function u0.featureOf(a1) -- Line: 109; upvalues: u0 (val); types: a1: string
    for i, j in u0.Features do
        if table.find(j.items, a1) then
            return i
        end
    end

    return nil
end

function u0.isReleased(a1) -- Line: 119; upvalues: u0 (val); types: a1: string
    local v1 = u0.featureOf(a1)
    local v2 = true

    if v1 ~= nil then
        v2 = u0.Features[v1].released == true
    end

    return v2
end

function u0.isAdmin(a1) -- Line: 125; upvalues: u0 (val)
    local v1 = false

    if a1 ~= nil then
        v1 = a1:GetAttribute(u0.AdminAttribute) == true
    end

    return v1
end

function u0.allows(a1, a2) -- Line: 130; upvalues: u0 (val); types: a2: string
    return u0.isReleased(a2) or u0.isAdmin(a1)
end

function u0.isCraftable(a1) -- Line: 135; upvalues: u0 (val); types: a1: string
    local v1 = u0.featureOf(a1)

    if v1 == nil then
        return true
    end

    local v2 = u0.Features[v1]
    local v3 = false

    if v2.released == true then
        v3 = v2.craftable ~= false
    end

    return v3
end

function u0.mayCraft(a1, a2) -- Line: 145; upvalues: u0 (val); types: a2: string
    return u0.isCraftable(a2) or u0.isAdmin(a1)
end

function u0.featureOn(a1, a2) -- Line: 150; upvalues: u0 (val); types: a1: string
    local v1 = u0.Features[a1]
    local v2 = true

    if v1 ~= nil then
        v2 = true

        if v1.released ~= true then
            v2 = u0.isAdmin(a2)
        end
    end

    return v2
end

return u0