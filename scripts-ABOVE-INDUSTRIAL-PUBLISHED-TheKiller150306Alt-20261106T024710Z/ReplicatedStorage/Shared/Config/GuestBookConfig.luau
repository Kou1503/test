-- Script path: game:GetService("ReplicatedStorage").Shared.Config.GuestBookConfig
-- Decompile time: 0.49 ms

local u0 = {Tiers = {"VideoStar", "Dev", "Verified", "VIP", "Other"}}

function u0.sortTier(a1, a2) -- Line: 42; types: a1: string?, a2: boolean?
    if a1 then
        return a1
    end

    if a2 then
        return "VIP"
    end

    return nil
end

u0.Groups = {VideoStar = 4199740}

function u0.rankOf(a1) -- Line: 64; upvalues: u0 (val); types: a1: string?
    if a1 then
        local v1 = table.find(u0.Tiers, a1)

        if v1 then
            return v1
        end
    end

    return #u0.Tiers + 1
end

function u0.isDetectable(a1) -- Line: 75; upvalues: u0 (val); types: a1: string
    local v1 = u0.Groups[a1]
    local v2 = true

    if v1 ~= nil then
        v2 = v1 > 0
    end

    return v2
end

u0.PageSize = 100
u0.MaxStored = 9999
u0.HeartsLiftStuds = 3
u0.HeartsVisibleStuds = 80
u0.ResolveTimeoutSeconds = 3

return u0