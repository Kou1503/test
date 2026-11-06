-- Script path: game:GetService("StarterPlayer").StarterPlayerScripts.Client.Controllers.NewBadges
-- Decompile time: 2.55 ms

local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u15 = {}
local u18 = Remotes.get(Remotes.RequestMarkSeen)
local u19 = {}
local u20 = {}
local u21 = {}
local u22 = false
local u23 = {}
local u24 = 0
local u25 = {}

local function changed() -- Line: 40; upvalues: u25 (val)
    for i, j in u25 do
        task.spawn(j)
    end
end

function u15.onChanged(a1) -- Line: 46; upvalues: u25 (val); types: a1: function
    table.insert(u25, a1)
end

function u15.isNewItem(a1) -- Line: 50; upvalues: u22 (ref), u23 (ref), u19 (val); types: a1: string
    local v1 = u22

    if v1 then
        v1 = false

        if 0 < (u23[a1] or 0) then
            v1 = not u19[a1]
        end
    end

    return v1
end

function u15.hasNewItems() -- Line: 54; upvalues: u22 (ref), u23 (ref), u19 (val)
    if not u22 then
        return false
    end

    for i, j in u23 do
        if j > 0 and not u19[i] then
            return true
        end
    end

    return false
end

function u15.markItemsSeen() -- Line: 67; upvalues: u22 (ref), u23 (ref), u19 (val), u18 (val), u25 (val)
    if not u22 then
        return
    end

    local v1 = {}

    for i, j in u23 do
        if j > 0 and not u19[i] then
            u19[i] = true
            table.insert(v1, i)
        end
    end

    if #v1 > 0 then
        u18:FireServer("item", v1)

        for k, n in u25 do
            task.spawn(n)
        end
    end
end

function u15.isNewRecipe(a1)
    -- Line: 84
    -- upvalues: u22 (ref), u20 (val), Config (val), u24 (ref), u15 (val)
    -- types: a1: string
    if u22 and not u20[a1] then
        local v1 = Config.Recipe.All[a1]
        local v2 = false

        if v1 ~= nil then
            v2 = false

            if v1.workbenchTier <= u24 then
                v2 = u15.knows(v1.output)
            end
        end

        return v2
    end

    return false
end

function u15.markRecipesSeen(a1) -- Line: 94; upvalues: u15 (val), u20 (val), u18 (val), u25 (val); types: a1: table
    local v1 = {}

    for i, j in a1 do
        if u15.isNewRecipe(j) then
            u20[j] = true
            table.insert(v1, j)
        end
    end

    if #v1 > 0 then
        u18:FireServer("recipe", v1)

        for k, n in u25 do
            task.spawn(n)
        end
    end
end

function u15.knows(a1) -- Line: 110; upvalues: Config (val), u21 (val); types: a1: string
    return not Config.Recipe.isSecret(a1) or u21[a1] == true
end

function u15.start()
    -- Line: 114
    -- upvalues: Remotes (val), u21 (val), u19 (val), u20 (val), u22 (ref), u25 (val), u23 (ref), u24 (ref)
    (Remotes.get(Remotes.SeenChanged)).OnClientEvent:Connect(function(a1, a2, a3)
        -- Line: 115
        -- upvalues: u21 (upval), u19 (upval), u20 (upval), u22 (upval), u25 (upval)
        if type(a1) == "table" and type(a2) == "table" then
            table.clear(u21)

            for i, j in if type(a3) ~= "table" then {} else a3 do
                if type(j) == "string" then
                    u21[j] = true
                end
            end

            table.clear(u19)

            for k, n in a1 do
                if type(n) == "string" then
                    u19[n] = true
                end
            end

            table.clear(u20)

            for m, i5 in a2 do
                if type(i5) == "string" then
                    u20[i5] = true
                end
            end

            u22 = true

            for i6, i7 in u25 do
                task.spawn(i7)
            end
        end
    end)

    ;(Remotes.get(Remotes.InventoryChanged)).OnClientEvent:Connect(function(a1)
        -- Line: 141
        -- upvalues: u23 (upval), u25 (upval)
        if type(a1) ~= "table" then
            return
        end

        u23 = table.clone(a1)

        for i, j in u25 do
            task.spawn(j)
        end
    end)

    ;(Remotes.get(Remotes.ProgressionChanged)).OnClientEvent:Connect(function(a1)
        -- Line: 149
        -- upvalues: u24 (upval), u25 (upval)
        if type(a1) == "number" and a1 ~= u24 then
            u24 = a1

            for i, j in u25 do
                task.spawn(j)
            end
        end
    end)
end

return u15