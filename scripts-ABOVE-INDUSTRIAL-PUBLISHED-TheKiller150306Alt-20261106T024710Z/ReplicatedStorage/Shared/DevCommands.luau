-- Script path: game:GetService("ReplicatedStorage").Shared.DevCommands
-- Decompile time: 7.53 ms

local u0 = {}
local v1 = {0, 1, 2, 3, 4, 5, 6}
u0.list = {
    {
        name = "slab",
        desc = "Show or hide the procedural grass plane. Turn it off to author the island's real shape.",
        group = "ISLAND AUTHORING",
        args = {{name = "state", kind = "onoff", optional = true}},
    },
    {
        name = "protect",
        desc = "Toggle protected volumes. Off lets you build under and around the Hub portal.",
        group = "ISLAND AUTHORING",
        args = {{name = "state", kind = "onoff", optional = true}},
    },
    {
        name = "coords",
        desc = "Show the grid cell of every block you place or break. For reading positions into config.",
        group = "ISLAND AUTHORING",
        args = {{name = "state", kind = "onoff", optional = true}},
    },
    {
        name = "capture",
        desc = "Print this island as starter-template JSON. Paste it into StarterIslandTemplate.json.",
        group = "ISLAND AUTHORING",
        args = {},
    },
    {
        name = "clearblocks",
        desc = "Remove every placed block on this island. Nothing is refunded.",
        group = "ISLAND AUTHORING",
        destructive = true,
        args = {},
    },
    {
        name = "expand",
        desc = "Set the island's expansion tier. No Coins are taken.",
        group = "ISLAND AUTHORING",
        args = {{name = "tier", kind = "number", optional = true, presets = v1}},
    },
    {
        name = "give",
        desc = "Grant items to yourself.",
        group = "SUPPLY",
        args = {
            {name = "item", kind = "item"},
            {name = "amount", kind = "number", optional = true, presets = {1, 10, 64, 100, 1000}},
        },
    },
    {
        name = "giveto",
        desc = "Grant items to another player in this server.",
        group = "SUPPLY",
        args = {
            {name = "player", kind = "player"},
            {name = "item", kind = "item"},
            {name = "amount", kind = "number", optional = true, presets = {1, 10, 64, 100, 1000}},
        },
    },
    {
        name = "giveeveryone",
        desc = "Grant an item to every player online, in EVERY server.",
        group = "SUPPLY",
        destructive = true,
        owner = true,
        args = {
            {name = "item", kind = "item"},
            {name = "amount", kind = "number", optional = true, presets = {1, 5, 10, 64}},
            {name = "limitone", kind = "onoff", optional = true},
        },
    },
    {
        name = "giveall",
        desc = "Grant some of EVERY item in the game. For testing a full backpack.",
        group = "SUPPLY",
        args = {{name = "amount", kind = "number", optional = true, presets = {1, 10, 64, 100}}},
    },
    {
        name = "coins",
        desc = "Grant Coins.",
        group = "SUPPLY",
        args = {{name = "amount", kind = "number", presets = {100, 1000, 10000, 100000, 1000000}}},
    },
    {
        name = "marks",
        desc = "Grant Sky Marks.",
        group = "SUPPLY",
        args = {{name = "amount", kind = "number", presets = {1, 5, 25}}},
    },
    {
        name = "gamepass",
        desc = "Switch a game pass on or off for yourself, this session only, to test it. With no pass, lists them. Never saved, and gives no title or portal skin.",
        group = "SUPPLY",
        args = {{name = "pass", kind = "pass", optional = true}},
    },
    {
        name = "workbench",
        desc = "Set your personal Workbench tier. Bypasses every unlock check.",
        group = "SUPPLY",
        args = {{name = "tier", kind = "number", optional = true, presets = v1}},
    },
    {
        name = "tap",
        desc = "Show what each tap or click hits: the finger point, the part struck, what breaks, where a block goes.",
        group = "SUPPLY",
        args = {{name = "state", kind = "onoff", optional = true}},
    },
    {
        name = "achieve",
        desc = "Raise an achievement's counter to a tier, so it pays through the real path (coins, Max HP).",
        group = "SUPPLY",
        args = {
            {name = "family", kind = "achievement"},
            {name = "tier", kind = "number", optional = true, presets = {1, 2, 3, 4, 5, 6}},
        },
    },
    {
        name = "slot",
        desc = "Switch to another island slot. Saves this one and rejoins you into that one.",
        group = "PERSISTENCE",
        destructive = true,
        args = {{name = "slot", kind = "number", presets = {1, 2, 3, 4}}},
    },
    {
        name = "guestbook",
        desc = "Open the Guest Book panel with invented visitors, to look at it before the pedestal exists.",
        group = "WORLD",
        args = {},
    },
    {
        name = "guides",
        desc = "Open the Island Planner (D-A58): Starter and Advanced guides with your progress. Admin only while it is built.",
        group = "WORLD",
        args = {},
    },
    {
        name = "publish",
        desc = "Publish your island (D-A59): pick a title and category, then everyone on your island goes to a server of its own for others to visit. On your published island, change them. Admin only for now.",
        group = "WORLD",
        args = {},
    },
    {
        name = "published",
        desc = "Open the Published list (D-A59): every published island, busiest first, with Visit and Random. Admin only while it is built.",
        group = "WORLD",
        args = {},
    },
    {
        name = "visitpublished",
        desc = "Go to a player's published island, if it is published right now.",
        group = "WORLD",
        args = {{name = "player", kind = "player", anyone = true}},
    },
    {
        name = "signbook",
        desc = "Sign a player's Guest Book from anywhere in this server, or leave the player out to sign every island here you have not signed yet. Never your own.",
        group = "WORLD",
        args = {{name = "player", kind = "player", optional = true}},
    },
    {
        name = "allflowers",
        desc = "Plant one of every flower on your island, open, to compare them side by side.",
        group = "WORLD",
        args = {},
    },
    {
        name = "beltpaths",
        desc = "Show or hide the lane guides belts steer items along.",
        group = "WORLD",
        args = {},
    },
    {
        name = "ranges",
        desc = "Show or hide the cells every drill, Lumber Mill and crop Harvester on the server works.",
        group = "WORLD",
        args = {},
    },
    {
        name = "allshinies",
        desc = "Lay out every Shiny piece on your island, one per cell.",
        group = "WORLD",
        args = {},
    },
    {
        name = "vendingsales",
        desc = "Invent recent sales of an item so price guidance has something to say.",
        group = "WORLD",
        args = {{name = "item", kind = "item"}, {name = "price", kind = "number", optional = true}},
    },
    {
        name = "weather",
        desc = "Set the weather now, or say what it is. The next roll still happens on schedule.",
        group = "WORLD",
        args = {{name = "state", kind = "weather", optional = true}},
    },
    {
        name = "weatherall",
        desc = "Set the weather in EVERY server, this one included. The next roll still happens on schedule.",
        group = "WORLD",
        args = {{name = "state", kind = "weather"}},
    },
    {
        name = "timeall",
        desc = "Set the time of day (0-24) in EVERY server, this one included. The day keeps running from there.",
        group = "WORLD",
        args = {{name = "hour", kind = "number", presets = {0, 6, 9, 12, 15, 18, 21}}},
    },
    {
        name = "time",
        desc = "Hold the clock at an hour of the day (0-24), for checking lighting. Lighting is left alone until /timerun.",
        group = "WORLD",
        args = {{name = "hour", kind = "number", optional = true, presets = {0, 6, 9, 12, 15, 18, 21}}},
    },
    {
        name = "timerun",
        desc = "Let the clock run again after /time held it.",
        group = "WORLD",
        args = {},
    },
    {
        name = "patch",
        desc = "Stand by a drill or harvester: say what it holds, how many nodes stand, and why each nearby cell was refused.",
        group = "WORLD",
        args = {},
    },
    {
        name = "celebrate",
        desc = "Set off the Celebration firework display over the island you are standing on.",
        group = "WORLD",
        args = {},
    },
    {
        name = "tp",
        desc = "Teleport yourself to a player in this server.",
        group = "MODERATION",
        mod = true,
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "bring",
        desc = "Bring a player in this server to you. Admins only.",
        group = "MODERATION",
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "visit",
        desc = "Go straight to a player's island in this server, even if it is closed or friends only. Admins only. On another server: /join them first.",
        group = "MODERATION",
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "join",
        desc = "Join the server a player is in, wherever it is. Type their username.",
        group = "MODERATION",
        mod = true,
        args = {{name = "username", kind = "text"}},
    },
    {
        name = "kill",
        desc = "Kill a player in this server. They respawn as normal.",
        group = "MODERATION",
        destructive = true,
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "spawn",
        desc = "Spawn mobs beside you. They stay leashed to where they appeared.",
        group = "MODERATION",
        args = {
            {name = "mob", kind = "mob"},
            {name = "count", kind = "number", optional = true, presets = {1, 3, 5, 10}},
        },
    },
    {
        name = "announce",
        desc = "Send an announcement to every player in EVERY server.",
        group = "MODERATION",
        args = {{name = "message", kind = "text"}},
    },
    {
        name = "kick",
        desc = "Kick a player from this server. They can rejoin.",
        group = "MODERATION",
        destructive = true,
        mod = true,
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "ban",
        desc = "Ban a player from the game for good, with an optional reason. /unban lifts it.",
        group = "MODERATION",
        destructive = true,
        mod = true,
        args = {
            {name = "player", kind = "player", anyone = true},
            {name = "reason", kind = "text", optional = true},
        },
    },
    {
        name = "event",
        desc = "Start a server event in EVERY public server with 4+ players: most of the target gathered or slain wins. 'stop' ends it everywhere.",
        group = "EVENTS",
        args = {
            {name = "target", kind = "event"},
            {name = "minutes", kind = "number", optional = true, presets = {3, 6, 10}},
        },
    },
    {
        name = "fling",
        desc = "Launch a player into the air, tumbling.",
        group = "FUN: PLAYERS",
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "explode",
        desc = "Blow a player up. Kills them; hurts nothing and nobody else.",
        group = "FUN: PLAYERS",
        destructive = true,
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "size",
        desc = "Scale a player's character. 1 is normal; resets when they respawn.",
        group = "FUN: PLAYERS",
        args = {
            {name = "player", kind = "player"},
            {name = "multiplier", kind = "number", presets = {0.25, 0.5, 1, 2, 3}},
        },
    },
    {
        name = "bighead",
        desc = "Toggle a giant head on a player.",
        group = "FUN: PLAYERS",
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "morph",
        desc = "Turn a player into a mob. Leave the mob out to turn them back.",
        group = "FUN: PLAYERS",
        args = {{name = "player", kind = "player"}, {name = "mob", kind = "mob", optional = true}},
    },
    {
        name = "blockmorph",
        desc = "Disguise a player as a block. Leave the block out to turn them back.",
        group = "FUN: PLAYERS",
        args = {{name = "player", kind = "player"}, {name = "block", kind = "block", optional = true}},
    },
    {
        name = "slimepartyall",
        desc = "Turn EVERY player in EVERY server into a random slime, or everyone back. Without on/off, back to normal if anyone here is a slime, a slime party if nobody is.",
        group = "FUN: PLAYERS",
        args = {{name = "state", kind = "onoff", optional = true}},
    },
    {
        name = "speed",
        desc = "Set a player's walk speed (16 is normal). Leave it out to put them back.",
        group = "FUN: PLAYERS",
        args = {
            {name = "player", kind = "player"},
            {name = "walkspeed", kind = "number", optional = true, presets = {0, 8, 16, 32, 64, 120}},
        },
    },
    {
        name = "follow",
        desc = "Toggle a harmless slime that follows a player around.",
        group = "FUN: PLAYERS",
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "followall",
        desc = "A harmless following slime for EVERY player in EVERY server, or none. Without on/off, off if anyone here has one, on if nobody does.",
        group = "FUN: PLAYERS",
        args = {{name = "state", kind = "onoff", optional = true}},
    },
    {
        name = "dizzy",
        desc = "Make a player stagger around drunk for a few seconds.",
        group = "FUN: PLAYERS",
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "stun",
        desc = "Freeze a player in place for a few seconds.",
        group = "FUN: PLAYERS",
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "burn",
        desc = "Set a player on fire: 50 damage over 10 seconds.",
        group = "FUN: PLAYERS",
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "jumpscare",
        desc = "Flash a scary image and a loud sound on one player's screen.",
        group = "FUN: PLAYERS",
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "bounty",
        desc = "Put coins on a player's head. The first player to hit them claims it.",
        group = "FUN: PLAYERS",
        args = {
            {name = "player", kind = "player"},
            {name = "coins", kind = "number", presets = {1000, 5000, 25000, 100000}},
        },
    },
    {
        name = "spectate",
        desc = "Watch a player through your camera. Leave the player out to stop.",
        group = "FUN: YOU",
        mod = true,
        args = {{name = "player", kind = "player", optional = true}},
    },
    {
        name = "ghost",
        desc = "Toggle invisibility for yourself, to snoop. Slimes ignore you too.",
        group = "FUN: YOU",
        args = {},
    },
    {
        name = "kingslime",
        desc = "Summon a giant King Slime in front of you. Big reward for whoever kills it.",
        group = "FUN: SERVER",
        args = {},
    },
    {
        name = "kingslimeall",
        desc = "Summon a King Slime in the Hub of EVERY server, this one included. Big reward in each.",
        group = "FUN: SERVER",
        destructive = true,
        args = {},
    },
    {
        name = "meteor",
        desc = "Drop a meteor near you that leaves an ore node in its crater. Random ore if left out.",
        group = "FUN: SERVER",
        args = {{name = "ore", kind = "ore", optional = true}},
    },
    {
        name = "doubledrop",
        desc = "Toggle double drops for gathering, harvests and slime drops.",
        group = "FUN: SERVER",
        args = {},
    },
    {
        name = "hotpotato",
        desc = "Start a hot potato round (or cancel one). Whoever holds it at the end explodes.",
        group = "FUN: SERVER",
        args = {},
    },
    {
        name = "pvp",
        desc = "PvP on or off in this server: swords hurt players. Without on/off, flips it.",
        group = "FUN: SERVER",
        args = {{name = "state", kind = "onoff", optional = true}},
    },
    {
        name = "pvpall",
        desc = "Turn PvP on or off in EVERY server, this one included. Without on/off, flips this server's and sets the rest to match.",
        group = "FUN: SERVER",
        args = {{name = "state", kind = "onoff", optional = true}},
    },
    {name = "party", desc = "Make everyone in the server dance.", group = "FUN: SERVER", args = {}},
    {
        name = "partyall",
        desc = "Make everyone in EVERY server dance, this one included.",
        group = "FUN: SERVER",
        args = {},
    },
    {
        name = "glitch",
        desc = "Make the world look glitchy, with a shaky camera, for 30 seconds.",
        group = "FUN: SERVER",
        args = {},
    },
    {name = "fog", desc = "Toggle a super dense fog.", group = "FUN: SERVER", args = {}},
    {
        name = "skybox",
        desc = "Set the sky to an image asset id for this server. Leave it out to put the sky back.",
        group = "FUN: SERVER",
        args = {{name = "assetId", kind = "number", optional = true}},
    },
    {
        name = "lava",
        desc = "Toggle lava: exposed grass tops become lava that kills on touch. Saves nothing.",
        group = "FUN: SERVER",
        args = {},
    },
    {
        name = "save",
        desc = "Force a save now and say whether it landed, and why if it did not.",
        group = "PERSISTENCE",
        args = {},
    },
    {
        name = "wipe",
        desc = "Wipe your save and kick you, with no confirmation and no cooldown. /reset is the player one.",
        group = "PERSISTENCE",
        destructive = true,
        args = {},
    },
    {
        name = "backup",
        desc = "Copy a player's save into the backup store, as it is in the DataStore right now.",
        group = "PERSISTENCE",
        args = {{name = "player", kind = "player"}},
    },
    {
        name = "rollback",
        desc = "Put a player's save back to how it was N minutes ago. They are kicked first if they are here.",
        group = "PERSISTENCE",
        destructive = true,
        args = {
            {name = "player", kind = "player"},
            {name = "minutesAgo", kind = "number", presets = {5, 30, 60, 180, 720, 1440}},
        },
    },
    {
        name = "freeze",
        desc = "Stop every server saving anything until /unfreeze. For when a build is eating saves.",
        group = "PERSISTENCE",
        destructive = true,
        args = {},
    },
    {name = "unfreeze", desc = "Lift the freeze on every server.", group = "PERSISTENCE", args = {}},
    {
        name = "unban",
        desc = "Lift a ban, by name or user id. For the day the honeypot is wrong about somebody.",
        group = "PERSISTENCE",
        args = {{name = "player", kind = "player", anyone = true}},
    },
    {
        name = "associates",
        desc = "A player's strongest associates, by name or user id: co-ops, roles, trades, drops, value moved, account ages. Printed to the server log (F9, Server).",
        group = "PERSISTENCE",
        args = {{name = "player", kind = "player", anyone = true}},
    },
    {
        name = "forgetassociates",
        desc = "Erase a player from the associates records entirely, theirs and everyone else's. For a Right to Erasure request.",
        group = "PERSISTENCE",
        destructive = true,
        owner = true,
        args = {{name = "player", kind = "player", anyone = true}},
    },
    {
        name = "banlog",
        desc = "The honeypot's newest trips, bans and admin trips alike, printed to the server log (F9, Server).",
        group = "MODERATION",
        args = {},
    },
    {
        name = "baninfo",
        desc = "Roblox's ban history for one player, by name or user id, with the private reason for each ban.",
        group = "MODERATION",
        args = {{name = "player", kind = "player", anyone = true}},
    },
    {
        name = "restart",
        desc = "Save everyone and move them all to a fresh server. Use after publishing an update.",
        group = "PERSISTENCE",
        destructive = true,
        args = {},
    },
    {
        name = "loadtest",
        desc = "Fill the empty island slots with 20k-block islands, build working factories, and report frame time. This is the 8-island profile.",
        group = "PROFILING",
        destructive = true,
        args = {
            {name = "islands", kind = "number", optional = true, presets = {1, 2, 4, 7}},
            {name = "blocks", kind = "number", optional = true, presets = {5000, 10000, 20000}},
        },
    },
    {
        name = "floating",
        desc = "List the machines on an island standing over a gap, block broken out from under them. Your current island, or a player's. Read-only.",
        group = "PROFILING",
        args = {{name = "player", kind = "player", optional = true}},
    },
    {
        name = "census",
        desc = "Count parts, islands and machines in the world right now. Read this after a real playtest, not just after a load test.",
        group = "PROFILING",
        args = {},
    },
    {
        name = "perf",
        desc = "How the server is running: physics FPS, frame cost, the costliest loops, and each island's machines and moving parts. The detail is in the server log (F9, Server).",
        group = "PROFILING",
        args = {},
    },
    {
        name = "memory",
        desc = "This server's memory by category, its instance count and Lua heap, islands loaded, and where the instances are. The detail is in the server log (F9, Server).",
        group = "PROFILING",
        args = {},
    },
    {
        name = "loadtestclear",
        desc = "Remove everything the load test built. The machines on your island stay.",
        group = "PROFILING",
        destructive = true,
        args = {},
    },
}

function u0.groups() -- Line: 730; upvalues: u0 (val)
    local v1 = {}
    local v2 = {}

    for i, j in u0.list do
        if not v1[j.group] then
            v1[j.group] = true
            table.insert(v2, j.group)
        end
    end

    return v2
end

function u0.find(a1) -- Line: 742; upvalues: u0 (val); types: a1: string
    for i, j in u0.list do
        if j.name == a1 then
            return j
        end
    end

    return nil
end

function u0.itemIds(a1, a2, a3, a4, a5, a6, a7, a8, a9) -- Line: 759
    local becomes, itemId_2, output, resource
    local u395 = {}

    local function add(a1) -- Line: 771; upvalues: u395 (val)
        if type(a1) == "string" then
            u395[a1] = true
        end
    end

    for i in a1.Blocks do
        if type(i) == "string" then
            u395[i] = true
        end
    end

    for j in a1.Plantables do
        if type(j) == "string" then
            u395[j] = true
        end
    end

    for k in a1.Containers do
        if type(k) == "string" then
            u395[k] = true
        end
    end

    local Fillables = a1.Fillables
    local v1 = nil
    local v2 = nil
    local v3, v4, v5, v6, v7, v8, v9, v10 = a2, a3, a4, a5, a6, a7, a8, a9

    for n, m in Fillables, v1, v2 do
        if type(n) == "string" then
            u395[n] = true
        end

        becomes = m.becomes

        if type(becomes) == "string" then
            u395[becomes] = true
        end
    end

    v1 = nil
    v2 = nil

    for i5, i6 in v3.All, v1, v2 do
        output = i6.output

        if type(output) == "string" then
            u395[output] = true
        end

        for i7 in i6.inputs do
            if type(i7) == "string" then
                u395[i7] = true
            end
        end
    end

    for i8 in v3.HarvesterIds do
        if type(i8) == "string" then
            u395[i8] = true
        end
    end

    if v3.Compost then
        local Output = v3.Compost.Output

        if type(Output) == "string" then
            u395[Output] = true
        end
    end

    for i9 in v3.CropHarvesterIds do
        if type(i9) == "string" then
            u395[i9] = true
        end
    end

    for i10 in v4.Tools do
        if type(i10) == "string" then
            u395[i10] = true
        end
    end

    v1 = nil
    v2 = nil

    for i11, i12 in v4.Nodes, v1, v2 do
        resource = i12.resource

        if type(resource) == "string" then
            u395[resource] = true
        end

        if i12.bonusDrop then
            itemId_2 = i12.bonusDrop.itemId

            if type(itemId_2) == "string" then
                u395[itemId_2] = true
            end
        end
    end

    if v4.CandyDrop then
        local itemId = v4.CandyDrop.itemId

        if type(itemId) == "string" then
            u395[itemId] = true
        end
    end

    for i13, i14 in v5.itemIds() do
        if type(i14) == "string" then
            u395[i14] = true
        end
    end

    for i15, i16 in v6.itemIds() do
        if type(i16) == "string" then
            u395[i16] = true
        end
    end

    if v7 then
        for i17 in v7.PieceFamily do
            if type(i17) == "string" then
                u395[i17] = true
            end
        end
    end

    if v8 then
        local dropId

        for i18, i19 in v8.Enemies do
            dropId = i19.dropId

            if type(dropId) == "string" then
                u395[dropId] = true
            end
        end
    end

    if v9 then
        for i20 in v9.Flowers do
            if type(i20) == "string" then
                u395[i20] = true
            end
        end

        if v9.WildGrass then
            local ItemId = v9.WildGrass.ItemId

            if type(ItemId) == "string" then
                u395[ItemId] = true
            end
        end
    end

    if v10 then
        for i21 in v10.Items do
            if type(i21) == "string" then
                u395[i21] = true
            end
        end
    end

    local v11 = {}

    for i22 in u395 do
        table.insert(v11, i22)
    end

    table.sort(v11)

    return v11
end

function u0.signature(a1) -- Line: 890; types: a1: table
    local v1 = {(("/%*"):format(a1.name))}
    local v2 = nil
    local v3 = nil

    for i, j in a1.args, v2, v3 do
        table.insert(v1, if not j.optional then ("<%*>"):format(j.name) else ("[%*]"):format(j.name))
    end

    return table.concat(v1, " ")
end

return u0