-- Script path: game:GetService("ReplicatedStorage").Shared.SignText
-- Decompile time: 0.98 ms

local u0 = {
    MaxLength = 20,
    AllowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 !@#$^&*()_+-=.,?/<>~|{}[]",
}
local u3 = {}
local v1 = #u0.AllowedCharacters

for i = 1, v1 do
    u3[(string.sub(u0.AllowedCharacters, i, i))] = true
end

function u0.sanitize(a1) -- Line: 52; upvalues: u3 (val), u0 (val); types: a1: string
    local v1

    if utf8.len(a1) == nil then
        return ""
    end

    local v2 = {}
    local v3 = #a1

    for i = 1, v3 do
        v1 = string.sub(a1, i, i)

        if u3[v1] then
            table.insert(v2, v1)

            if u0.MaxLength <= #v2 then
                break
            end
        end
    end

    return table.concat(v2)
end

function u0.validate(a1) -- Line: 71; upvalues: u0 (val), u3 (val)
    if type(a1) ~= "string" then
        return nil, "not text"
    end

    if utf8.len(a1) == nil then
        return nil, "not valid text"
    end

    if u0.MaxLength < #a1 then
        return nil, "too long"
    end

    local v1 = #a1

    for i = 1, v1 do
        if not u3[string.sub(a1, i, i)] then
            return nil, "letters, digits, spaces and punctuation only"
        end
    end

    return a1, nil
end

return u0