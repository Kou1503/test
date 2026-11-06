-- Script path: game:GetService("ReplicatedStorage").Shared.Config.PermissionConfig
-- Decompile time: 1.14 ms

local u0 = {
    Roles = {
        Visitor = {
            id = "Visitor",
            walk = true,
            fight = true,
            dropOwnItems = true,
            pickupCombatLoot = false,
            operateMachines = false,
            placeFromOwnInventory = false,
            dismantleOwnerStructures = false,
        },
        Helper = {
            id = "Helper",
            walk = true,
            fight = true,
            dropOwnItems = true,
            pickupCombatLoot = true,
            operateMachines = true,
            placeFromOwnInventory = false,
            dismantleOwnerStructures = false,
        },
        Builder = {
            id = "Builder",
            walk = true,
            fight = true,
            dropOwnItems = true,
            pickupCombatLoot = true,
            operateMachines = true,
            placeFromOwnInventory = true,
            dismantleOwnerStructures = false,
        },
        TrustedBuilder = {
            id = "TrustedBuilder",
            walk = true,
            fight = true,
            dropOwnItems = true,
            pickupCombatLoot = true,
            operateMachines = true,
            placeFromOwnInventory = true,
            dismantleOwnerStructures = true,
        },
    },
    DismantleReturnsTo = "Owner",
    StorageToggles = {
        Deposit = {default = false, warnOnEnable = false, label = "Put items in storage"},
        View = {default = false, warnOnEnable = false, label = "See what storage holds"},
        Withdraw = {default = false, warnOnEnable = true, label = "Take items out of storage"},
    },
    IslandToggles = {
        HarvestCrops = {default = true, minimum = "Helper", label = "Harvest crops and bushes"},
        GatherResources = {default = true, minimum = "Helper", label = "Chop trees and mine ore"},
        PlantCrops = {default = false, minimum = "Helper", label = "Plant crops and flowers"},
        UseMachines = {default = true, minimum = "Helper", label = "Use machines and stations"},
        CollectFactoryOutputs = {default = false, minimum = "Helper", label = "Collect factory output"},
        ManageCropHarvesters = {default = false, minimum = "Builder", label = "Set up crop harvesters"},
        ManageVending = {default = false, minimum = "TrustedBuilder", label = "Manage vending"},
        ManageDisplays = {default = false, minimum = "Builder", label = "Manage displays", deferred = true},
        MoveMachines = {default = false, minimum = "TrustedBuilder", label = "Move and dismantle machines"},
    },
    RoleOrder = {"Visitor", "Helper", "Builder", "TrustedBuilder"},
}

function u0.rank(a1) -- Line: 135; upvalues: u0 (val); types: a1: string
    return table.find(u0.RoleOrder, a1) or 0
end

function u0.toggleAllows(a1, a2) -- Line: 141; upvalues: u0 (val); types: a1: string, a2: string
    local v1 = u0.IslandToggles[a1]

    if not v1 then
        return false
    end

    local v2 = u0.rank(a2)

    return u0.rank(v1.minimum) <= v2
end

u0.PickupDefaults = {
    Visitor = {CombatLoot = false, LooseOwnerItems = false, FactoryOutputs = false},
    Helper = {CombatLoot = true, LooseOwnerItems = false, FactoryOutputs = false},
    Builder = {CombatLoot = true, LooseOwnerItems = false, FactoryOutputs = false},
    TrustedBuilder = {CombatLoot = true, LooseOwnerItems = true, FactoryOutputs = true},
}
u0.PlayerDropPickupPolicy = "Anyone"

function u0.pickupCategoryOf(a1) -- Line: 181; types: a1: string
    if a1 == "MonsterDrop" then
        return "CombatLoot"
    end

    if a1 ~= "FactoryOutput" and a1 ~= "HarvesterOutput" and a1 ~= "RecyclerOutput" then
        return "LooseOwnerItems"
    end

    return "FactoryOutputs"
end

u0.MaxBans = 100
u0.BanWarning = {
    title = "BAN FROM YOUR ISLAND?",
    body = "They won't be able to visit your island, including when it's published, until you unban them from this list.",
    cancel = "Nevermind",
    confirm = "Ban them",
}
u0.VisitPolicies = {"Closed", "FriendsOnly", "Open"}
u0.DefaultVisitPolicy = "Open"
u0.RoleLabels = {Visitor = "Visitor", Helper = "Helper", Builder = "Builder", TrustedBuilder = "Trusted Builder"}
u0.RoleBlurbs = {
    Visitor = "Everyone starts as a visitor. Can visit and look around.",
    Helper = "Can harvest crops.",
    Builder = "Can place things from their inventory and harvest crops.",
    TrustedBuilder = "ONLY GIVE TO TRUSTED PEOPLE. Gives full access to break blocks and take stuff from your island.",
}
u0.TrustedBuilderWarning = {
    title = "ARE YOU SURE?",
    body = "Beware of scammers. Giving this role means they can take things from you and your island. We cannot restore stolen items.",
    cancel = "Nevermind",
    confirm = "Yes, I'm sure",
}
u0.VerbLabels = {
    {verb = "walk", label = "Visit and walk around"},
    {verb = "fight", label = "Fight slimes"},
    {verb = "pickupCombatLoot", label = "Pick up slime drops"},
    {verb = "placeFromOwnInventory", label = "Build with their own blocks"},
    {verb = "dismantleOwnerStructures", label = "Break your blocks"},
}
u0.VisitPolicyLabels = {
    Open = {label = "Open", detail = "Anyone in the server can come through your portal."},
    FriendsOnly = {label = "Friends", detail = "Only your Roblox friends can come through your portal."},
    Closed = {label = "Closed", detail = "Nobody can come through your portal. Co-op partners always can."},
}

function u0.reachOf(a1) -- Line: 262; upvalues: u0 (val); types: a1: string
    if a1 == "TrustedBuilder" then
        return "Trusted Builders"
    end

    return (("%*s and up"):format(u0.RoleLabels[a1] or a1))
end

return u0