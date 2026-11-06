-- Script path: game:GetService("ReplicatedStorage").Shared.Config.NewsConfig
-- Decompile time: 0.20 ms

return {
    Icon = "rbxassetid://79525715247841",
    StoreName = "AboveNews_v1",
    StoreKey = "feed",
    MaxPosts = 3,
    TitleMaxLength = 100,
    DateMaxLength = 40,
    BodyMaxLength = 8000,
    IdMaxLength = 40,
    PollSeconds = 120,
    UnavailableText = "Can't load update notes at this time. Try again later...",
    Seed = {
        {
            id = "2026-10-31",
            title = "Halloween Update",
            date = "October 31, 2026",
            body = ":jack_o_lantern: **NEW Halloween Event:** Unlock Halloween Portal with 50 candy corn. Earn candy corn via mining, chopping, harvesting and slimes.\n:island: **NEW Published Islands:** Publish your island for up to 50 players! Build shops, minigames, obbies, and more, then share your join code with friends. Unlock publishing with 25 guestbook likes or bypass the requirement with VIP.\n:factory: **Added Industrial Block Press:** use to auto create blocks of various types (i.e. coal, clay, neon, colored clay etc.)\n:twisted_rightwards_arrows: **Added Splitter:** Connect the round robin T splitter to conveyors to help balance factory production.\n:package: **Added Overflow Chest:** Connect your conveyor to a large overflow chest. Once it fills up it sends items out the other side. Chain them together to never lose items from your larger factories.\n:rainbow: **Added 11 Neon and 11 Colored Clay Blocks** (Red, Orange, Yellow, Lime, Green, Sky, Blue, Purple, Pink, White, Black.) Craft from Builder Bench or Industrial Block Press.\n:stew: **Added 7 New foods + 5 secret recipes.** Craft the food from Cooking Station. Some foods can also be auto crafted via Industrial Cooker.\n:tulip: **Added Flower Pots** (buy from the new florist NPC.) Place flowers inside. Large can hold 3 flowers.\n:man_cook: **Added Chef:** You can sell food you craft to him.\n:crossed_swords: **Added Weapon Display and Weapon Stand:** Show off your weapons.\n:no_entry_sign: **Added Banning and Kicking** from your Island to stop harassment/unwelcome guests.\n:trophy: **Added leaderboards** for Coins earned and Donation (find in the hub near machinist.)\n:fork_knife_plate: **Added Plate Display** for storing 1 food item to show off your new foods.\n\n## Changes\n- Optimized grouping of items\n- Decreased despawn timer from 15m to 5m to reduce loose items\n- Fixed vending machine lag bug\n- Increased max limit for vendings to 250\n- Fixed a bug causing a rare data loss to occur on co-ops when someone else is loading your island\n- Fixed a bug where expanding your island didn't update block count right away\n- Contraband blocks (i.e. water blocks, dev items, etc.) are now soulbound and cannot be placed in vendings, storage etc.\n- Fixed some memory leaks\n- Buffed Water Blocks to hold 24 uses\n- Doors and trapdoors now stay open after rejoin\n- Optimized plow and seed planting so it's not reading your entire island to provide hints\n- Fixed bug for mobile UI cutting off workbench upgrade requirements\n- Fixed bug where saplings were spawning on berry bushes\n- Visitors no longer see edit sign button\n- Fixed conveyor corner movements\n- Fixed issue with swing speed, pickaxes and swords with high DPS should feel better\n- Added larger hitbox area for trees so you don't have to hit it so accurate.\n- Various minor fixes and changes",
        },
    },
}