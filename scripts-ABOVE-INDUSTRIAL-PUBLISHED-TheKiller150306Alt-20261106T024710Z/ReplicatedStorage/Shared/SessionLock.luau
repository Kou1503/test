-- Script path: game:GetService("ReplicatedStorage").Shared.SessionLock
-- Decompile time: 0.34 ms

local u0 = {StaleSeconds = 180, LoadAttempts = 6, RetrySeconds = 5}

function u0.heldElsewhere(a1, a2, a3) -- Line: 40; upvalues: u0 (val); types: a2: string, a3: number
    if type(a1) == "table" and type(a1.session) == "string" and a1.session ~= "" then
        if a1.session == a2 then
            return false
        end

        local v1 = tonumber(a1.heartbeat)

        if v1 == nil then
            return false
        end

        return a3 - v1 < u0.StaleSeconds
    end

    return false
end

return u0