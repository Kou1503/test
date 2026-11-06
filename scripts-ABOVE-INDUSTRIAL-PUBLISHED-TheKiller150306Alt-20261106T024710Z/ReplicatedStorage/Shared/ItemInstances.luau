-- Script path: game:GetService("ReplicatedStorage").Shared.ItemInstances
-- Decompile time: 1.82 ms

local u0 = {
    States = {
        "Inventory",
        "Storage",
        "Placed",
        "Display",
        "VendingEscrow",
        "TransactionEscrow",
        "LooseWorld",
        "MachineInput",
        "MachineBuffer",
        "Consumed",
        "Destroyed",
    },
    NotYetLegal = {VendingEscrow = true},
    NoCrafter = 0,
}

function u0.new(a1, a2, a3, a4, a5, a6)
    -- Line: 89
    -- upvalues: u0 (val)
    -- types: a1: string, a2: string, a3: number, a4: number, a5: number, a6: number?
    return {
        version = 1,
        state = "Inventory",
        favoriteLocked = false,
        achievementBound = false,
        outcome = "Standard",
        perfect = false,
        id = a1,
        itemId = a2,
        ownerUserId = a3,
        craftedByUserId = a6 or u0.NoCrafter,
        craftedAtUnix = a4,
        stats = {},
        sequence = a5,
    }
end

function u0.isState(a1) -- Line: 117; upvalues: u0 (val); types: a1: string
    return table.find(u0.States, a1) ~= nil
end

function u0.canEnter(a1) -- Line: 123; upvalues: u0 (val); types: a1: string
    if not u0.isState(a1) then
        return false, (("unknown state '%*'"):format(a1))
    end

    if u0.NotYetLegal[a1] then
        return false, (("'%*' is reserved and not yet legal"):format(a1))
    end

    return true, nil
end

function u0.setState(a1, a2) -- Line: 135; upvalues: u0 (val); types: a1: table, a2: string
    local v1, v2 = u0.canEnter(a2)

    if not v1 then
        return false, v2
    end

    a1.state = a2

    return true, nil
end

function u0.transfer(a1, a2) -- Line: 149; types: a1: table, a2: number
    if a1.achievementBound then
        return false, "achievement-bound items never change owner"
    end

    if a2 == a1.ownerUserId then
        return true, nil
    end

    a1.ownerUserId = a2
    a1.version = a1.version + 1

    return true, nil
end

function u0.encode(a1) -- Line: 171; upvalues: u0 (val); types: a1: table
    local v1 = {i = a1.id, t = a1.itemId}

    if a1.ownerUserId ~= 0 then
        v1.o = a1.ownerUserId
    end

    if a1.version ~= 1 then
        v1.v = a1.version
    end

    if a1.state ~= "Inventory" then
        v1.s = a1.state
    end

    if a1.holder ~= nil then
        v1.h = a1.holder
    end

    if a1.craftedByUserId ~= u0.NoCrafter then
        v1.cb = a1.craftedByUserId
    end

    if a1.craftedAtUnix ~= 0 then
        v1.ca = a1.craftedAtUnix
    end

    if a1.favoriteLocked then
        v1.f = true
    end

    if a1.achievementBound then
        v1.b = true
    end

    if a1.accomplishment then
        v1.ac = a1.accomplishment
    end

    if a1.outcome ~= "Standard" then
        v1.q = a1.outcome
    end

    if a1.perfect then
        v1.p = true
    end

    if next(a1.stats) ~= nil then
        v1.st = a1.stats
    end

    if a1.charge ~= nil then
        v1.c = a1.charge
    end

    return v1
end

function u0.decode(a1, a2) -- Line: 220; upvalues: u0 (val); types: a2: number
    if type(a1) == "table" and type(a1.i) == "string" and type(a1.t) == "string" then
        local s_2 = if type(a1.s) ~= "string" then "Inventory" else a1.s

        if not u0.canEnter(s_2) then
            s_2 = "Inventory"
        end

        local v1 = {}

        if type(a1.st) == "table" then
            for i2, j in a1.st do
                if type(i2) == "string" and type(j) == "number" then
                    v1[i2] = j
                end
            end
        end

        local v2 = {id = a1.i, itemId = a1.t}
        v2.ownerUserId = tonumber(a1.o) or 0
        v2.version = tonumber(a1.v) or 1
        v2.state = s_2
        v2.holder = if s_2 == "Inventory" then
            nil
        else
            if type(a1.h) ~= "string" then nil else a1.h
        local NoCrafter = tonumber(a1.cb) or u0.NoCrafter
        v2.craftedByUserId = NoCrafter
        v2.craftedAtUnix = tonumber(a1.ca) or 0
        v2.favoriteLocked = a1.f == true
        v2.achievementBound = a1.b == true
        v2.accomplishment = if type(a1.ac) ~= "string" then nil else a1.ac
        v2.outcome = if type(a1.q) ~= "string" then "Standard" else a1.q
        v2.perfect = a1.p == true
        v2.stats = v1
        v2.sequence = a2
        v2.charge = if type(a1.c) ~= "number" then nil else a1.c

        return v2
    end

    return nil
end

return u0