-- Script path: game:GetService("ReplicatedStorage").Shared.Config.CosmeticConfig
-- Decompile time: 0.36 ms

local u0 = {
    PortalPrefabCategory = "Hub/Portals",
    PortalSkins = {
        Default = {id = "Default", displayName = "Default Portal", prefab = "Default", unlock = "Default"},
        VipPortal = {id = "VipPortal", displayName = "VIP Portal", prefab = "VIP", unlock = "Purchase"},
        HalloweenPortal = {
            id = "HalloweenPortal",
            displayName = "Halloween Portal",
            prefab = "Halloween",
            unlock = "Event",
            cost = {itemId = "CandyCorn", amount = 50},
        },
    },
    FreeOnJoin = {},
    DefaultPortalSkin = "Default",
}

function u0.portalSkin(a1) -- Line: 69; upvalues: u0 (val); types: a1: string?
    return (if not a1 then nil else u0.PortalSkins[a1])
        or u0.PortalSkins[u0.DefaultPortalSkin]
end

function u0.isDefaultSkin(a1) -- Line: 77; upvalues: u0 (val); types: a1: string
    local v1 = u0.PortalSkins[a1]
    local v2 = false

    if v1 ~= nil then
        v2 = v1.unlock == "Default"
    end

    return v2
end

return u0