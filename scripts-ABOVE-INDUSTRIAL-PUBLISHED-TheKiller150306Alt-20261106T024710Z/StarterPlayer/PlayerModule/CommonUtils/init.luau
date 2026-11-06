-- Script path: game:GetService("StarterPlayer").PlayerModule.CommonUtils
-- Decompile time: 0.26 ms

local u0 = {_mocks = {}}

function u0.mock(a1, a2) -- Line: 16; upvalues: u0 (val)
    u0._mocks[a1] = a2
end

function u0.get(a1) -- Line: 20; upvalues: u0 (val); types: a1: string
    if u0._mocks[a1] then
        return require(u0._mocks[a1])
    end

    if script:FindFirstChild(a1) then
        return require(script:FindFirstChild(a1))
    end

    assert(false, "Util does not exist: " .. a1)
end

return u0