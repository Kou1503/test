-- Script path: game:GetService("ReplicatedStorage").Shared.CoopRules
-- Decompile time: 2.78 ms

local u0 = {}

function u0.has(a1, a2) -- Line: 33; types: a1: table, a2: number
    return table.find(a1, a2) ~= nil
end

function u0.defaultName(a1) -- Line: 46; types: a1: string
    return (string.sub(if string.lower((string.sub(a1, -1))) ~= "s" then a1 .. "s" else a1, 1, 14))
        .. " CO-OP"
end

function u0.isNumberedName(a1) -- Line: 53; types: a1: string
    return string.match(a1, "^CO%-OP %d+$") ~= nil
end

function u0.sanitize(a1, a2, a3) -- Line: 62; types: a2: number, a3: number
    local v1, v2, v3, v4
    local v5 = {owner = a2, name = ("CO-OP %*"):format(a3)}
    v5.members = {a2}
    v5.invites = {}

    if type(a1) ~= "table" then
        return v5
    end

    if type(a1.owner) == "number" then
        v5.owner = a1.owner
    end

    if type(a1.name) == "string" and a1.name ~= "" then
        v5.name = a1.name
    end

    if type(a1.members) == "table" then
        v2 = {}
        v3 = nil
        v4 = nil
        v1 = a1

        for i, j in a1.members, v3, v4 do
            if type(j) == "number" and not (table.find(v2, j) ~= nil) then
                table.insert(v2, j)
            end
        end

        v5.members = v2
    end

    if not (table.find(v5.members, v5.owner) ~= nil) then
        table.insert(v5.members, 1, v5.owner)
    end

    if type(v1.invites) == "table" then
        v2 = {}
        v3 = nil
        v4 = nil

        for k, n in v1.invites, v3, v4 do
            if type(n) == "number"
                and not (table.find(v2, n) ~= nil)
                and not (table.find(v5.members, n) ~= nil) then
                table.insert(v2, n)
            end
        end

        v5.invites = v2
    end

    return v5
end

function u0.seatsTaken(a1) -- Line: 112; types: a1: table
    return #a1.members + #a1.invites
end

function u0.isOwner(a1, a2) -- Line: 116; types: a1: table, a2: number
    return a1.owner == a2
end

function u0.canInvite(a1, a2, a3, a4, a5)
    -- Line: 122
    -- upvalues: u0 (val)
    -- types: a1: table, a2: number, a3: number, a4: number, a5: number
    if not u0.isOwner(a1, a2) then
        return false, "Only the owner can invite people"
    end

    if a3 == a2 then
        return false, "You're already on this island"
    end

    if table.find(a1.members, a3) ~= nil then
        return false, "They're already on this island"
    end

    if table.find(a1.invites, a3) ~= nil then
        return false, "They already have an invite"
    end

    if a5 <= #a1.invites then
        return false, "Too many invites out. Cancel one first."
    end

    if a4 <= u0.seatsTaken(a1) then
        return false, (("This island is full (%*)"):format(a4))
    end

    return true, nil
end

function u0.canAccept(a1, a2, a3) -- Line: 152; types: a1: table, a2: number, a3: number
    if table.find(a1.members, a2) ~= nil then
        return false, "You're already on this island"
    end

    if not (table.find(a1.invites, a2) ~= nil) then
        return false, "That invite is no longer open"
    end

    if a3 <= #a1.members then
        return false, "That island filled up"
    end

    return true, nil
end

function u0.canCancel(a1, a2, a3) -- Line: 165; upvalues: u0 (val); types: a1: table, a2: number, a3: number
    if not u0.isOwner(a1, a2) then
        return false, "Only the owner can cancel invites"
    end

    if not (table.find(a1.invites, a3) ~= nil) then
        return false, "There's no invite to cancel"
    end

    return true, nil
end

function u0.canRemove(a1, a2, a3) -- Line: 177; types: a1: table, a2: number, a3: number
    if a3 == a1.owner then
        return false, "The owner can't be removed"
    end

    if not (table.find(a1.members, a3) ~= nil) then
        return false, "They aren't on this island"
    end

    if a2 ~= a1.owner and a2 ~= a3 then
        return false, "Only the owner can remove someone"
    end

    return true, nil
end

function u0.withMember(a1, a2) -- Line: 197; types: a1: table, a2: number
    local v1 = table.clone(a1.members)

    if not (table.find(v1, a2) ~= nil) then
        table.insert(v1, a2)
    end

    local v2 = {}

    for i, j in a1.invites do
        if j ~= a2 then
            table.insert(v2, j)
        end
    end

    return {owner = a1.owner, name = a1.name, members = v1, invites = v2}
end

function u0.withoutMember(a1, a2) -- Line: 211; types: a1: table, a2: number
    local v1 = {}

    for i, j in a1.members do
        if j ~= a2 then
            table.insert(v1, j)
        end
    end

    return {
        owner = a1.owner,
        name = a1.name,
        members = v1,
        invites = table.clone(a1.invites),
    }
end

function u0.withInvite(a1, a2) -- Line: 221; types: a1: table, a2: number
    local v1 = table.clone(a1.invites)

    if not (table.find(v1, a2) ~= nil) and not (table.find(a1.members, a2) ~= nil) then
        table.insert(v1, a2)
    end

    return {
        owner = a1.owner,
        name = a1.name,
        members = table.clone(a1.members),
        invites = v1,
    }
end

function u0.isInvited(a1, a2) -- Line: 231; types: a1: table, a2: number
    return table.find(a1.invites, a2) ~= nil
end

function u0.withoutInvite(a1, a2) -- Line: 235; types: a1: table, a2: number
    local v1 = {}

    for i, j in a1.invites do
        if j ~= a2 then
            table.insert(v1, j)
        end
    end

    return {
        owner = a1.owner,
        name = a1.name,
        members = table.clone(a1.members),
        invites = v1,
    }
end

return u0