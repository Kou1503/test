-- Script path: game:GetService("ReplicatedStorage").Shared.Validate
-- Decompile time: 1.08 ms

local u0 = {}

function u0.finite(a1) -- Line: 26
    if type(a1) ~= "number" then
        return nil
    end

    if a1 == a1 and a1 ~= (1 / 0) and a1 ~= (-1 / 0) then
        return a1
    end

    return nil
end

function u0.integer(a1, a2, a3) -- Line: 41; upvalues: u0 (val); types: a2: number, a3: number
    local v1 = u0.finite(a1)

    if not v1 then
        return nil
    end

    v1 = math.floor(v1)

    if not (v1 < a2) and not (a3 < v1) then
        return v1
    end

    return nil
end

function u0.wholeNumber(a1, a2, a3) -- Line: 56; upvalues: u0 (val); types: a2: number, a3: number
    local v1 = u0.finite(a1)

    if v1 and v1 == math.floor(v1) and not (v1 < a2) and not (a3 < v1) then
        return v1
    end

    return nil
end

function u0.cutText(a1, a2) -- Line: 73; types: a1: string, a2: number
    local v1, v2
    local v3 = string.sub(a1, 1, a2 + 4)
    local v4 = #v3

    for i = 1, v4 do
        v1, v2 = utf8.len(v3)

        if v1 then
            break
        end

        v3 = (string.sub(v3, 1, v2 - 1)) .. "?" .. string.sub(v3, v2 + 1)
    end

    v4 = if not (a2 < #v3) then v3 else string.sub(v3, 1, a2)

    for j = 1, 4 do
        if utf8.len(v4) then
            return v4
        end

        v4 = string.sub(v4, 1, #v4 - 1)
    end

    return v4
end

u0.MaxStackKey = 160

function u0.stackKey(a1) -- Line: 104; upvalues: u0 (val)
    if type(a1) ~= "string" then
        return nil
    end

    if #a1 ~= 0 and not (u0.MaxStackKey < #a1) then
        if not string.match(a1, "^%w[%w _;=%.%-@]*$") then
            return nil
        end

        return a1
    end

    return nil
end

return u0