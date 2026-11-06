-- Script path: game:GetService("ReplicatedStorage").Shared.Format
-- Decompile time: 1.33 ms

local u0 = {}

function u0.comma(a1) -- Line: 15; types: a1: number
    local v1, v2
    local v3 = tostring((math.floor(a1)))

    repeat
        v1, v2 = string.gsub(v3, "^(-?%d+)(%d%d%d)", "%1,%2")
        v3 = v1
    until v2 == 0

    return v3
end

function u0.coins(a1) -- Line: 29; upvalues: u0 (val); types: a1: number
    local v1
    local v2 = math.floor(a1)

    for i, j in {{1000000000, "B"}, {1000000, "M"}, {1000, "K"}} do
        v1 = j[1]

        if v1 <= math.abs(v2) then
            if v2 % (v1 / 100) ~= 0 then
                break
            end

            return string.gsub(string.gsub(string.format("%.2f", v2 / v1), "0+$", ""), "%.$", "")
                .. j[2]
        end
    end

    return u0.comma(v2)
end

function u0.short(a1, a2) -- Line: 55; upvalues: u0 (val); types: a1: number, a2: boolean?
    local v1, v2, v3
    local v4 = math.floor(a1)
    local v5 = {{1000000000, "B"}, {1000000, "M"}, {1000, "K"}}

    for i, j in v5 do
        v3 = j[1]

        if v3 <= math.abs(v4) then
            v1 = v3 / 100
            v2 = if not a2 then math.floor(v4 / v1) else math.ceil(v4 / v1)
            v1 = v5[i - 1]

            if a2 and v2 >= 100000 and v1 then
                v2 = math.ceil(v4 / (v1[1] / 100))
                j = v1
            end

            return string.gsub(string.gsub(string.format("%d.%02d", v2 // 100, v2 % 100), "0+$", ""), "%.$", "")
                .. j[2]
        end
    end

    return u0.comma(v4)
end

return u0