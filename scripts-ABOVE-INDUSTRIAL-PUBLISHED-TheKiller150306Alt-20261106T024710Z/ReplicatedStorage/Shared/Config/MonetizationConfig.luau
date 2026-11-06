-- Script path: game:GetService("ReplicatedStorage").Shared.Config.MonetizationConfig
-- Decompile time: 1.08 ms

local u0 = {SlotPassesOnSale = {IslandSlot3 = true}}

function u0.slotPassOnSale(a1) -- Line: 35; upvalues: u0 (val); types: a1: string
    return u0.SlotPassesOnSale[a1] == true
end

u0.ShelfFirst = "VipPass"
u0.ShopInMenuBar = true
u0.PassVerify = {Attempts = 3, RetrySeconds = 1}
u0.BuilderLight = {OwnIslandStuds = 600, CheckSeconds = 0.5}
u0.BuilderLightAttribute = "BuilderLight"
u0.PortalMoverAttribute = "PortalMover"
u0.SpawnMoverAttribute = "SpawnMover"
u0.CoopSlotPasses = {[2] = "CoopSlot2", [3] = "CoopSlot3", [4] = "CoopSlot4"}
u0.SlotPasses = {[3] = "IslandSlot3", [4] = "IslandSlot4", [5] = "IslandSlot5", [6] = "IslandSlot6"}
u0.Products = {
    IslandSlot3 = {
        id = "IslandSlot3",
        kind = "Pass",
        displayName = "Island Slot #3",
        description = "Unlock additional Island profile slot. Access under Island Management.",
        assetId = 2017436251,
        suggestedRobux = {min = 149, max = 249},
        grants = {},
    },
    IslandSlot4 = {
        id = "IslandSlot4",
        kind = "Pass",
        displayName = "Fourth Island",
        description = "A fourth island slot, started fresh.",
        assetId = 2017304265,
        suggestedRobux = {min = 249, max = 399},
        grants = {},
    },
    IslandSlot5 = {
        id = "IslandSlot5",
        kind = "Pass",
        displayName = "Fifth Island",
        description = "A fifth island slot, started fresh.",
        assetId = 2013224481,
        suggestedRobux = {min = 399, max = 599},
        grants = {},
    },
    IslandSlot6 = {
        id = "IslandSlot6",
        kind = "Pass",
        displayName = "Sixth Island",
        description = "A sixth island slot, started fresh. The last one.",
        assetId = 2013266497,
        suggestedRobux = {min = 599, max = 899},
        grants = {},
    },
    CoopSlot2 = {
        id = "CoopSlot2",
        kind = "Pass",
        displayName = "Second Co-op Island",
        description = "A second cooperative island. Its own world, and up to three friends on it.",
        assetId = 2014526495,
        suggestedRobux = {min = 199, max = 299},
        grants = {},
    },
    CoopSlot3 = {
        id = "CoopSlot3",
        kind = "Pass",
        displayName = "Third Co-op Island",
        description = "A third cooperative island.",
        assetId = 2016566310,
        suggestedRobux = {min = 299, max = 449},
        grants = {},
    },
    CoopSlot4 = {
        id = "CoopSlot4",
        kind = "Pass",
        displayName = "Fourth Co-op Island",
        description = "A fourth cooperative island. The last one.",
        assetId = 2013962496,
        suggestedRobux = {min = 449, max = 699},
        grants = {},
    },
    VipPass = {
        id = "VipPass",
        kind = "Pass",
        displayName = "VIP Rank",
        description = "Exclusive VIP title, portal skin & bypass 20 likes to publish island.",
        assetId = 2016218313,
        suggestedRobux = {min = 399, max = 599},
        grants = {title = "VIP", cosmetics = {"VipPortal"}},
    },
    BuilderLight = {
        id = "BuilderLight",
        kind = "Pass",
        displayName = "Builder Light",
        description = "Switch your island to daylight and clear skies while you build.",
        assetId = 2047718338,
        suggestedRobux = {min = 49, max = 149},
        grants = {buildLight = true},
    },
    PortalMover = {
        id = "PortalMover",
        kind = "Pass",
        displayName = "Portal Mover",
        description = "Move your island's portal anywhere on your island. Type /resetportal to put it back.",
        assetId = 2044593009,
        suggestedRobux = {min = 149, max = 299},
        grants = {portalMover = true},
    },
    SpawnMover = {
        id = "SpawnMover",
        kind = "Pass",
        displayName = "Spawn Mover",
        description = "Change spawn locations. /setspawn for owner spawn. /visitorspawn for visitors. /resetspawn to reset it.",
        assetId = 2047958255,
        suggestedRobux = {min = 149, max = 299},
        grants = {spawnMover = true},
    },
    Celebration = {
        id = "Celebration",
        kind = "Product",
        displayName = "Celebration",
        description = "Sets off a firework display over the island for everyone in the server to see.",
        assetId = 3717132094,
        suggestedRobux = {min = 25, max = 75},
        grants = {celebration = true},
    },
    SmallTip = {
        id = "SmallTip",
        kind = "Product",
        displayName = "Small Tip",
        description = "A small tip to show your support to the dev team.",
        assetId = 3717132058,
        suggestedRobux = {min = 50, max = 100},
        grants = {title = "Supporter"},
    },
}

function u0.isLive(a1) -- Line: 305; upvalues: u0 (val); types: a1: string
    local v1 = u0.Products[a1]
    local v2 = false

    if v1 ~= nil then
        v2 = 0 < v1.assetId
    end

    return v2
end

local u62 = {}

for i, j in u0.SlotPasses do
    u62[j] = true
end

for k, n in u0.CoopSlotPasses do
    u62[n] = true
end

function u0.isListed(a1) -- Line: 324; upvalues: u0 (val), u62 (val); types: a1: string
    if u0.Products[a1] == nil then
        return false
    end

    if u62[a1] then
        return u0.slotPassOnSale(a1)
    end

    return true
end

return u0