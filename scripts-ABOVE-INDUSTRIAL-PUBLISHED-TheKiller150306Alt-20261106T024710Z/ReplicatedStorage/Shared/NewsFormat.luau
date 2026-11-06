-- Script path: game:GetService("ReplicatedStorage").Shared.NewsFormat
-- Decompile time: 4.09 ms

local u0 = {}
local u1 = {
    jack_o_lantern = "🎃",
    ghost = "👻",
    island = "🏝️",
    factory = "🏭",
    twisted_rightwards_arrows = "🔀",
    package = "📦",
    rainbow = "🌈",
    stew = "🍲",
    tulip = "🌷",
    man_cook = "👨‍🍳",
    cook = "🧑‍🍳",
    crossed_swords = "⚔️",
    no_entry_sign = "🚫",
    no_entry = "⛔",
    trophy = "🏆",
    fork_knife_plate = "🍽️",
    fork_and_knife = "🍴",
    tada = "🎉",
    sparkles = "✨",
    star = "⭐",
    star2 = "🌟",
    fire = "🔥",
    zap = "⚡",
    gift = "🎁",
    christmas_tree = "🎄",
    snowflake = "❄️",
    santa = "🎅",
    wrench = "🔧",
    hammer = "🔨",
    hammer_and_wrench = "🛠️",
    tools = "🛠️",
    gear = "⚙️",
    bug = "🐛",
    warning = "⚠️",
    white_check_mark = "✅",
    heavy_check_mark = "✔️",
    x = "❌",
    heart = "❤️",
    new = "🆕",
    construction = "🚧",
    lock = "🔒",
    unlock = "🔓",
    key = "🔑",
    bell = "🔔",
    mega = "📣",
    loudspeaker = "📢",
    calendar = "📅",
    bulb = "💡",
    chart_with_upwards_trend = "📈",
    rocket = "🚀",
    crown = "👑",
    gem = "💎",
    moneybag = "💰",
    money_with_wings = "💸",
    shopping_cart = "🛒",
    pick = "⛏️",
    axe = "🪓",
    dagger = "🗡️",
    shield = "🛡️",
    bow_and_arrow = "🏹",
    seedling = "🌱",
    herb = "🌿",
    ear_of_rice = "🌾",
    sunflower = "🌻",
    rose = "🌹",
    hibiscus = "🌺",
    blossom = "🌼",
    evergreen_tree = "🌲",
    deciduous_tree = "🌳",
    carrot = "🥕",
    tomato = "🍅",
    potato = "🥔",
    onion = "🧅",
    strawberry = "🍓",
    apple = "🍎",
    bread = "🍞",
    cake = "🍰",
    pie = "🥧",
    candy = "🍬",
    lollipop = "🍭",
    honey_pot = "🍯",
    droplet = "💧",
    ocean = "🌊",
    sunny = "☀️",
    crescent_moon = "🌙",
    cloud = "☁️",
    cloud_rain = "🌧️",
    bricks = "🧱",
    house = "🏠",
    homes = "🏘️",
    map = "🗺️",
    compass = "🧭",
    books = "📚",
    scroll = "📜",
    memo = "📝",
    pencil = "📝",
    art = "🎨",
    paintbrush = "🖌️",
    video_game = "🎮",
    joystick = "🕹️",
    robot = "🤖",
    busts_in_silhouette = "👥",
    people_holding_hands = "🧑‍🤝‍🧑",
    handshake = "🤝",
    wave = "👋",
    eyes = "👀",
    point_right = "👉",
    arrow_right = "➡️",
    arrow_up = "⬆️",
    arrow_down = "⬇️",
    hourglass = "⌛",
    stopwatch = "⏱️",
    alarm_clock = "⏰",
    slime = "🟢",
    green_circle = "🟢",
    red_circle = "🔴",
    blue_circle = "🔵",
    yellow_circle = "🟡",
    purple_circle = "🟣",
    magnet = "🧲",
    test_tube = "🧪",
    satellite = "🛰️",
    shooting_star = "🌠",
    balloon = "🎈",
    confetti_ball = "🎊",
    ticket = "🎫",
    medal = "🏅",
    first_place = "🥇",
    chart = "📊",
    bar_chart = "📊",
    speech_balloon = "💬",
    thinking = "🤔",
    smile = "😄",
    partying_face = "🥳",
    pray = "🙏",
    muscle = "💪",
    thumbsup = "👍",
    ["+1"] = "👍",
    ok_hand = "👌",
    clap = "👏",
    raised_hands = "🙌",
}
u0.Emoji = u1

local function escape(a1) -- Line: 172; types: a1: string
    return (string.gsub(string.gsub(string.gsub(a1, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))
end

local function emoji(a1) -- Line: 176; upvalues: u1 (val); types: a1: string
    return (string.gsub(
        a1,
        ":([%w_%+%-]+):",
        function(a1) -- Line: 177; upvalues: u1 (upval); types: a1: string
            return u1[string.lower(a1)]
        end
    ))
end

local function inline(a1) -- Line: 184; upvalues: u1 (val); types: a1: string
    return (string.gsub(
        string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(string.gsub(a1, "&lt;a?:[%w_]+:%d+&gt;", ""), "%[([^%]]+)%]%(([^%)]+)%)", "%1"), "`([^`]+)`", "<font face=\"RobotoMono\">%1</font>"), "%*%*(.-)%*%*", "<b>%1</b>"), "__(.-)__", "<u>%1</u>"), "~~(.-)~~", "<s>%1</s>"), "%*([^%*%s][^%*]-)%*", "<i>%1</i>"),
        ":([%w_%+%-]+):",
        function(a1) -- Line: 177; upvalues: u1 (upval); types: a1: string
            return u1[string.lower(a1)]
        end
    ))
end

u0.HeadingSizes = {1.45, 1.25, 1.1}
u0.SmallScale = 0.82
u0.LineGapScale = 0.35
u0.Dim = "#9aa0b4"

local function line(a1, a2) -- Line: 205; upvalues: u0 (val), inline (val); types: a1: string, a2: number
    local v1, v2 = string.match(a1, "^(#+)%s+(.+)$")

    if v1 and v2 and #v1 <= #u0.HeadingSizes then
        return (("<font size=\"%*\"><b>%*</b></font>"):format(math.floor(a2 * u0.HeadingSizes[#v1] + 0.5), (inline((string.gsub(string.gsub(string.gsub(v2, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))))))
    end

    v2 = string.match(a1, "^%-#%s+(.+)$")

    if v2 then
        return (("<font size=\"%*\" color=\"%*\">%*</font>"):format(math.floor(a2 * u0.SmallScale + 0.5), u0.Dim, (inline((string.gsub(string.gsub(string.gsub(v2, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))))))
    end

    v2 = string.match(a1, "^>%s?(.*)$")

    if v2 then
        return (("<font color=\"%*\">| <i>%*</i></font>"):format(u0.Dim, (inline((string.gsub(string.gsub(string.gsub(v2, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))))))
    end

    local v3, v4 = string.match(a1, "^(%s*)[%-%*]%s+(.+)$")

    if v4 then
        return (("%*• %*"):format(if not v3 then "  " else if not (#v3 >= 2) then "  " else "      ", (inline((string.gsub(string.gsub(string.gsub(v4, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))))))
    end

    return (inline((string.gsub(string.gsub(string.gsub(a1, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))))
end

function u0.blocks(a1, a2) -- Line: 231; upvalues: u0 (val), line (val); types: a1: string, a2: number
    local v1
    local u77 = {}
    local u3 = {}
    local u16 = ("<font size=\"%*\"> </font>"):format((math.max(1, (math.floor(a2 * u0.LineGapScale + 0.5)))))

    local function flush() -- Line: 236; upvalues: u3 (val), u16 (val), u77 (val)
        while true do
            if not (#u3 > 0) or u3[1] ~= "" then
                break
            end

            table.remove(u3, 1)
        end

        while true do
            if not (#u3 > 0) or u3[#u3] ~= "" then
                break
            end

            table.remove(u3)
        end

        local v1 = #u3

        if v1 > 0 then
            v1 = {}
            local v2 = nil
            local v3 = nil

            for i, j in u3, v2, v3 do
                if i > 1 and j ~= "" and u3[i - 1] ~= "" then
                    table.insert(v1, u16)
                end

                table.insert(v1, j)
            end

            table.insert(
                u77,
                {kind = "Text", text = table.concat(v1, "\n")}
            )
        end

        table.clear(u3)
    end

    for i in string.gmatch((string.gsub(a1, "\r", "")) .. "\n", "([^\n]*)\n") do
        v1 = string.match(i, "^%s*%[image:(%d+)%]%s*$")

        if not v1 or not tonumber(v1) then
            table.insert(u3, if not string.match(i, "^%s*$") then line(i, a2) else "")
        else
            flush()

            table.insert(
                u77,
                {kind = "Image", id = tonumber(v1)}
            )
        end
    end

    flush()

    return u77
end

function u0.title(a1) -- Line: 272; upvalues: inline (val); types: a1: string
    return (inline((string.gsub(string.gsub(string.gsub(a1, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))))
end

local function text(a1, a2) -- Line: 278; types: a2: number
    if type(a1) == "string" and utf8.len(a1) ~= nil and not (a2 < #a1) then
        return a1
    end

    return nil
end

function u0.post(a1, a2) -- Line: 287
    if type(a1) ~= "table" then
        return nil, "not a post"
    end

    local id = a1.id
    local IdMaxLength = a2.IdMaxLength
    local v1 = if type(id) ~= "string" then
        nil
    else
        if utf8.len(id) == nil then nil else if not (IdMaxLength < #id) then id else nil
    local title = a1.title
    local TitleMaxLength = a2.TitleMaxLength
    local v2 = if type(title) ~= "string" then
        nil
    else
        if utf8.len(title) == nil then
            nil
        else
            if not (TitleMaxLength < #title) then title else nil
    local date = a1.date
    local DateMaxLength = a2.DateMaxLength
    local v3 = if type(date) ~= "string" then
        nil
    else
        if utf8.len(date) == nil then
            nil
        else
            if not (DateMaxLength < #date) then date else nil
    local body = a1.body
    local BodyMaxLength = a2.BodyMaxLength
    local v4 = if type(body) ~= "string" then
        nil
    else
        if utf8.len(body) == nil then
            nil
        else
            if not (BodyMaxLength < #body) then body else nil

    if v1 and v1 ~= "" then
        if not v2 then
            return nil, (("title over %* characters"):format(a2.TitleMaxLength))
        end

        if not v3 then
            return nil, (("date over %* characters"):format(a2.DateMaxLength))
        end

        if not v4 then
            return nil, (("body over %* characters"):format(a2.BodyMaxLength))
        end

        return {id = v1, title = v2, date = v3, body = v4}, nil
    end

    return nil, "missing id"
end

function u0.feed(a1, a2) -- Line: 311; upvalues: u0 (val)
    if type(a1) == "table" and type(a1.posts) == "table" then
        local v1, v2
        local v3 = {}

        for i, j in a1.posts do
            if type(i) ~= "number" then
                return nil, "not a list"
            end

            v1, v2 = u0.post(j, a2)

            if not v1 then
                return nil, (("post %*: %*"):format(i, v2))
            end

            table.insert(v3, v1)
        end

        while true do
            if not (a2.MaxPosts < #v3) then
                break
            end

            table.remove(v3)
        end

        return v3, nil
    end

    return nil, "not a feed"
end

return u0