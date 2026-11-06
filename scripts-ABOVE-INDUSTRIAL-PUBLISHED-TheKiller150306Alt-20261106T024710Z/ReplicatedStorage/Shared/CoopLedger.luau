-- Script path: game:GetService("ReplicatedStorage").Shared.CoopLedger
-- Decompile time: 1.86 ms

local DisplayNames = require(script.Parent.DisplayNames)
local Format = require(script.Parent.Format)
local Validate = require(script.Parent.Validate)
local v1 = {}
local u16 = {Bought = true, Sold = true, Upgrade = true, Expansion = true}

local function goods(a1) -- Line: 38; upvalues: DisplayNames (val), Format (val); types: a1: table
    local v1 = if not a1.i then "something" else DisplayNames.of(a1.i)
    local v2 = a1.c or 1

    if v2 > 1 then
        return (("%* %*"):format(Format.comma(v2), v1))
    end

    return v1
end

function v1.describe(a1) -- Line: 45; upvalues: Format (val), DisplayNames (val); types: a1: table
    local v1
    local v2 = ("%* coins"):format((Format.comma(a1.a)))

    if a1.k == "Sold" then
        local n = a1.n
        local v3 = if not a1.i then "something" else DisplayNames.of(a1.i)
        v1 = a1.c or 1

        return (("%* sold %* for %*"):format(n, if not (v1 > 1) then v3 else ("%* %*"):format(Format.comma(v1), v3), v2))
    end

    if a1.k ~= "Bought" then
        if a1.k == "Upgrade" then
            return (("%* spent %* on a Workbench upgrade"):format(a1.n, v2))
        end

        return (("%* spent %* on an island expansion"):format(a1.n, v2))
    end

    local n_2 = a1.n
    v1 = if not a1.i then "something" else DisplayNames.of(a1.i)
    local v4 = a1.c or 1

    return (("%* spent %* on %*"):format(n_2, v2, if not (v4 > 1) then v1 else ("%* %*"):format(Format.comma(v4), v1)))
end

function v1.ago(a1) -- Line: 58; types: a1: number
    if a1 < 60 then
        return "now"
    end

    if a1 < 3600 then
        return (("%*m"):format((math.floor(a1 / 60))))
    end

    if a1 < 86400 then
        return (("%*h"):format((math.floor(a1 / 3600))))
    end

    return (("%*d"):format((math.floor(a1 / 86400))))
end

function v1.sanitize(a1) -- Line: 71; upvalues: u16 (val), Validate (val)
    if type(a1) ~= "table" then
        return nil
    end

    if type(a1.u) == "number"
        and type(a1.n) == "string"
        and type(a1.a) == "number"
        and type(a1.t) == "number" then
        if type(a1.k) == "string" and u16[a1.k] then
            return {
                u = a1.u,
                n = Validate.cutText(a1.n, 40),
                k = a1.k,
                a = math.max(0, (math.floor(a1.a))),
                i = if type(a1.i) ~= "string" then nil else Validate.cutText(a1.i, 64),
                c = if type(a1.c) ~= "number" then
                    nil
                else
                    math.max(1, (math.floor(a1.c))),
                t = a1.t,
            }
        end

        return nil
    end

    return nil
end

return v1