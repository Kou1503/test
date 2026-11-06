-- Script path: game:GetService("StarterPlayer").PlayerModule.CameraModule.VRCameraTeleportDetector
-- Decompile time: 0.27 ms

local u0 = {JUMP_STUDS = 4, SETTLED_STUDS = 1, DEBOUNCE_SECONDS = 0.25}

function u0.shouldRecenter(a1, a2, a3, a4)
    -- Line: 29
    -- upvalues: u0 (val)
    -- types: a1: number?, a2: number, a3: number?, a4: number
    if a2 <= u0.JUMP_STUDS then
        return false
    end

    if a1 ~= nil and u0.SETTLED_STUDS <= a1 then
        return false
    end

    if a3 ~= nil and a4 - a3 < u0.DEBOUNCE_SECONDS then
        return false
    end

    return true
end

return u0