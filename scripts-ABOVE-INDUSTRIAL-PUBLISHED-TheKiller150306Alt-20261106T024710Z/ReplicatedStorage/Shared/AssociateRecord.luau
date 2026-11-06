-- Script path: game:GetService("ReplicatedStorage").Shared.AssociateRecord
-- Decompile time: 2.75 ms

local u0 = {}

function u0.score(a1, a2) -- Line: 15; types: a1: table, a2: table
    return (a1.c or 0) * a2.coop + (a1.cm or 0) * a2.coopMinute
        + ((a1.g or 0) + (a1.gr or 0)) * a2.grant
        + (a1.q or 0) * a2.quickRevoke
        + (a1.v or 0) * a2.trade
        + ((a1.p or 0) + (a1.pd or 0)) * a2.pickup
        + (a1.s or 0) * a2.chest
        + ((a1.b or 0) + (a1.bd or 0)) * a2.place
        + ((a1.m or 0) + (a1.md or 0)) * a2.visitMinute
        + (a1.f or 0) * a2.follow
        + ((a1.o or 0) + (a1.i or 0)) / 1000 * a2.valuePerThousand
end

function u0.grantedThenMoved(a1) -- Line: 30; types: a1: table
    local v1 = 0 < (a1.g or 0) + (a1.gr or 0)
    local v2 = (a1.o or 0) + (a1.i or 0) + (a1.p or 0) + (a1.pd or 0)
        + (a1.s or 0)
        + (a1.b or 0)
        + (a1.bd or 0)

    return v1 and v2 > 0
end

local function short(a1) -- Line: 43; types: a1: number
    local v1, v2
    local v3 = math.floor(a1)

    for i, j in {{1000000000, "B"}, {1000000, "M"}, {1000, "K"}} do
        v1 = j[1]

        if v1 <= v3 then
            v2 = math.floor(v3 / (v1 / 10))
            return (string.gsub(string.format("%d.%d", v2 // 10, v2 % 10), "%.0$", ""))
                .. j[2]
        end
    end

    return (tostring(v3))
end

function u0.summary(a1) -- Line: 57; upvalues: short (val); types: a1: table
    local u1 = {}

    local function say(a1_2, a2) -- Line: 59; upvalues: a1 (val), u1 (val); types: a1_2: string, a2: string
        local v1 = a1[a1_2]

        if v1 and v1 > 0 then
            table.insert(u1, (("%* %*"):format(math.floor(v1), a2)))
        end
    end

    if 0 < (a1.c or 0) then
        table.insert(u1, "co-op")
    end

    local g = a1.g

    if g and g > 0 then
        table.insert(u1, (("%* role(s) granted to them"):format((math.floor(g)))))
    end

    local gr = a1.gr

    if gr and gr > 0 then
        table.insert(u1, (("%* role(s) granted by them"):format((math.floor(gr)))))
    end

    local q = a1.q

    if q and q > 0 then
        table.insert(u1, (("%* quick revoke(s)"):format((math.floor(q)))))
    end

    local v = a1.v

    if v and v > 0 then
        table.insert(u1, (("%* trade(s)"):format((math.floor(v)))))
    end

    local p = a1.p

    if p and p > 0 then
        table.insert(u1, (("%* of their drops picked up"):format((math.floor(p)))))
    end

    local pd = a1.pd

    if pd and pd > 0 then
        table.insert(u1, (("%* drops picked up by them"):format((math.floor(pd)))))
    end

    local s = a1.s

    if s and s > 0 then
        table.insert(u1, (("%* chest move(s)"):format((math.floor(s)))))
    end

    local b = a1.b

    if b and b > 0 then
        table.insert(u1, (("%* placed on their island"):format((math.floor(b)))))
    end

    local bd = a1.bd

    if bd and bd > 0 then
        table.insert(u1, (("%* placed here by them"):format((math.floor(bd)))))
    end

    local f = a1.f

    if f and f > 0 then
        table.insert(u1, (("%* follow(s)"):format((math.floor(f)))))
    end

    local v1 = (a1.m or 0) + (a1.md or 0) + (a1.cm or 0)

    if v1 > 0 then
        table.insert(u1, (("%* min together"):format((math.floor(v1)))))
    end

    local v2 = a1.o or 0
    local v3 = a1.i or 0

    if v2 > 0 or v3 > 0 then
        table.insert(u1, (("gave %* / got %*"):format(short(v2), (short(v3)))))
    end

    return table.concat(u1, ", ")
end

function u0.ranked(a1, a2) -- Line: 90; upvalues: u0 (val); types: a2: table
    local v1 = {}

    if type(a1) == "table" and type(a1.a) == "table" then
        local v2
        local v3 = nil
        local v4 = nil

        for i, j in a1.a, v3, v4 do
            v2 = if type(i) ~= "string" then nil else tonumber(i)

            if v2 and type(j) == "table" then
                table.insert(
                    v1,
                    {id = v2, edge = j, score = u0.score(j, v5)}
                )
            end
        end

        table.sort(
            v1,
            function(a1, a2) -- Line: 101
                return a2.score < a1.score
            end
        )

        return v1
    end

    return v1
end

return u0