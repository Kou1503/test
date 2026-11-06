-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.FriendPresence
-- Decompile time: 1.75 ms

local v1 = {}
local LocalPlayer = (game:GetService("Players")).LocalPlayer
local u7 = {}
local u8 = (-1 / 0)

function v1.fetch() -- Line: 33; upvalues: u8 (ref), u7 (ref), LocalPlayer (val)
    if os.clock() - u8 < 30 then
        return u7
    end

    local success, err = pcall(function() -- Line: 37; upvalues: LocalPlayer (upval)
        return LocalPlayer:GetFriendsOnlineAsync(200)
    end)

    if success and type(err) == "table" then
        local v1, v2
        u8 = os.clock()
        local v3 = {}
        local v4 = nil
        local v5 = nil

        for i, j in err, v4, v5 do
            v1 = tonumber(j.VisitorId)

            if v1 then
                v2 = false

                if j.PlaceId ~= nil then
                    v2 = (tostring(j.PlaceId)) == tostring(game.PlaceId)
                end

                v3[v1] = {
                    group = if not v2 then "Online" else "OtherServer",
                    name = tostring(j.UserName),
                    displayName = tostring(j.DisplayName or j.UserName),
                }
            end
        end

        u7 = v3

        return v3
    end

    return u7
end

function v1.apply(a1, a2) -- Line: 63; upvalues: LocalPlayer (val); types: a1: table, a2: table
    local v1
    local v2 = {}

    for i, j in a1 do
        v2[j.userId] = true
        v1 = a2[j.userId]

        if v1 and j.group ~= "Self" and j.group ~= "InServer" then
            j.group = v1.group
        end
    end

    for k, n in a2 do
        if not v2[k] and k ~= LocalPlayer.UserId then
            table.insert(
                a1,
                {
                    userId = k,
                    name = n.name,
                    displayName = n.displayName,
                    group = n.group,
                }
            )
        end
    end
end

return v1