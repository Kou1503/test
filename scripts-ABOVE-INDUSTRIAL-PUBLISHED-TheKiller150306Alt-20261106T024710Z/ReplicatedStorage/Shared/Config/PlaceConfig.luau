-- Script path: game:GetService("ReplicatedStorage").Shared.Config.PlaceConfig
-- Decompile time: 1.82 ms

local u0 = {
    Experiences = {
        {name = "ABOVE Testing", main = 101396724920137, showroom = 86509666935522, test = true},
        {name = "ABOVE", main = 124357835578554, showroom = 88152437007055, test = false},
    },
    Showroom = {
        RecordMap = "AboveShowrooms_v1",
        HostWaitSeconds = 20,
        ServerRecordSeconds = 259200,
        UserRecordSeconds = 600,
        UserRecordRefreshSeconds = 180,
        ListMap = "AboveShowroomList_v1",
        ReportSeconds = 30,
        ListEntrySeconds = 90,
        ListRead = 50,
        ListCacheSeconds = 10,
        PublishLikes = 20,
        PublishCooldownSeconds = 60,
        VisitorAttribute = "ShowroomVisitor",
        PublishedAttribute = "PublishedIsland",
        DefaultCategory = "Builds",
        TitleMaxLength = 20,
        JoinCodeLength = 5,
        JoinCodeAlphabet = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789",
        Categories = {"Shops", "Games", "Builds"},
        LeaveWarning = {
            title = "LEAVE YOUR ISLAND?",
            body = "Once nobody from your island is on it, it closes and everyone here is sent home.",
            cancel = "Stay",
            confirm = "Leave",
        },
        UnpublishWarning = {
            title = "UNPUBLISH?",
            body = "Your island comes off the list, and everyone here is sent back to a normal server, you included.",
            cancel = "Nevermind",
            confirm = "Unpublish",
        },
    },
}

function u0.cleanJoinCode(a1) -- Line: 112; upvalues: u0 (val)
    if type(a1) == "string" and not (#a1 > 40) then
        local v1 = string.upper((string.gsub(a1, "%s", "")))

        if #v1 ~= u0.Showroom.JoinCodeLength then
            return nil
        end

        local v2 = #v1

        for i = 1, v2 do
            if not string.find(u0.Showroom.JoinCodeAlphabet, string.sub(v1, i, i), 1, true) then
                return nil
            end
        end

        return v1
    end

    return nil
end

function u0.typedJoinCode(a1) -- Line: 129; upvalues: u0 (val); types: a1: string
    local v1 = {}

    for i in string.gmatch(string.upper(a1), ".") do
        if #v1 < u0.Showroom.JoinCodeLength
            and string.find(u0.Showroom.JoinCodeAlphabet, i, 1, true) then
            table.insert(v1, i)
        end
    end

    return table.concat(v1)
end

function u0.isCategory(a1) -- Line: 142; upvalues: u0 (val)
    local v1 = false

    if type(a1) == "string" then
        v1 = table.find(u0.Showroom.Categories, a1) ~= nil
    end

    return v1
end

function u0.sanitizeTitle(a1) -- Line: 148; upvalues: u0 (val); types: a1: string
    return (string.sub(string.gsub(string.gsub(string.gsub(a1, "[^%w ]", ""), "  +", " "), "^ +", ""), 1, u0.Showroom.TitleMaxLength))
end

function u0.validTitle(a1) -- Line: 157; upvalues: u0 (val)
    if type(a1) == "string" then
        local v1 = #a1

        if not (u0.Showroom.TitleMaxLength < v1) and not string.find(a1, "[^%w ]") then
            v1 = string.match(a1, "^%s*(.-)%s*$") or ""

            if v1 ~= "" then
                return v1
            end

            return nil
        end
    end

    return nil
end

function u0.experienceOf(a1) -- Line: 167; upvalues: u0 (val); types: a1: number
    for i, j in u0.Experiences do
        if j.main ~= a1 and j.showroom ~= a1 then
            continue
        end

        return j
    end

    return nil
end

function u0.mainOf(a1) -- Line: 177; upvalues: u0 (val); types: a1: number
    local v1 = u0.experienceOf(a1)

    if v1 then
        return v1.main
    end

    return a1
end

function u0.showroomOf(a1) -- Line: 183; upvalues: u0 (val); types: a1: number
    local v1 = u0.experienceOf(a1)

    if v1 then
        return v1.showroom
    end

    return nil
end

function u0.isShowroom(a1) -- Line: 189; upvalues: u0 (val); types: a1: number
    local v1 = u0.experienceOf(a1)
    local v2 = false

    if v1 ~= nil then
        v2 = v1.showroom == a1
    end

    return v2
end

function u0.isTest(a1) -- Line: 195; upvalues: u0 (val); types: a1: number
    local v1 = u0.experienceOf(a1)
    local test = false

    if v1 ~= nil then
        test = v1.test
    end

    return test
end

return u0