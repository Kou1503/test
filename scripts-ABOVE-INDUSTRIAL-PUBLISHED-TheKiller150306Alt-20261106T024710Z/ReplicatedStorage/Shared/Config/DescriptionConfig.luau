-- Script path: game:GetService("ReplicatedStorage").Shared.Config.DescriptionConfig
-- Decompile time: 1.76 ms

local Items, Items_2, v1, v2
local u0 = {
    SoulboundPrefix = "SOULBOUND. Never leaves your inventory: it can't be dropped, stored, sold or traded. ",
    Items = {
        Wood = "Chopped from trees with an axe.",
        Stone = "Mined from stone rock.",
        IronOre = "Mined from iron ore. Useless until a Furnace smelts it into Iron Ingots.",
        Coal = "Mined from coal rocks. Used as Fuel.",
        TreeSapling = "Has a chance to drop from cut trees using an axe. Plant it to grow a tree.",
        Sand = "Mined from sand deposits near pond with a Stone Pickaxe or better. Smelts to Glass.",
        Clay = "Dug from around the pond with a Stone Pickaxe or better. Presses into Clay Blocks at a Workbench.",
        SlimeGel = "Dropped by Green Slimes. Needed by every belt, the Machinery Workbench and the Recycler.",
        PinkSlimeGel = "Dropped only by Pink Slimes, the rarer kind. Seals a Water Pump.",
        WildGrass = "A tuft that grows wild on your lawn. Place it as decoration, or sell it to the Merchant.",
        BlueSlimeGel = "Dropped by Blue Slimes. The Merchant buys it.",
        OrangeSlimeGel = "Dropped by Orange Slimes, the rarest color. The Merchant pays well for it.",
        PurpleSlimeGel = "Only a King Slime drops this. The Merchant pays a fortune for it.",
        IndustrialFurnace = "Smelts continuously off a belt. Requires coal fuel to operate.",
        Bakehouse = "Cooks continuously off a belt, twice as fast as the Cooking Station. Coal fuel required.",
        IronIngot = "Smelted from Iron Ore in a Furnace.",
        Gear = "The mechanical component in belts and machines.",
        WaterPump = "Pumps water through pipes and pours it from the end of the line, filling a pool beneath it a little at a time. Needs no water source. Quality makes it faster.",
        WaterPipe = "Carries a Water Pump's water. Place it at the end of the line.",
        WaterPipeCorner = "Turns a Water Pump's line left or right. Press R to choose which.",
        WaterSpout = "Ends a Water Pump's line. Place it over an empty block and the water pours into it.",
        Rail = "Railcart track. Lay a line of it and set a Railcart on it.",
        RailCorner = "Turns railcart track. Press R to choose which way.",
        RailRamp = "Carries railcart track up a level, or down one turned around. Climbing needs speed.",
        RailBooster = "Railcart track that speeds a cart up, and sends off a cart stopped on it.",
        RailRampBooster = "A ramp that speeds a cart up, so it can climb from a stop. Sends off a cart stopped on it.",
        Minecart = "A wooden cart. Use it on a rail to set it down, then ride it. A Pickaxe picks it back up.",
        IronRailcart = "An iron cart. Use it on a rail to set it down, then ride it. A Pickaxe picks it back up.",
        Glass = "Made from sand.",
        Dough = "Made from 3 Wheat. Used to make bread.",
        Bread = "Requires 2 Dough, baked at a Cooking Station or Industrial Cooker. Eat it for 10 health and 5% more walk speed for five minutes.",
        GoldenDough = "Made from a Golden Wheat Sheaf, at a Cooking Station or Industrial Cooker. Used to make Golden Bread.",
        GoldenBread = "Requires a Golden Dough, baked at a Cooking Station or Industrial Cooker. Eat it for 20 health, 10% more walk speed and double the chance of rare harvests for five minutes.",
        RoastedCarrot = "A Carrot, roasted. Eat it for 6 health.",
        TomatoSauce = "Made from 2 Onions and 2 Tomatoes. Eat it for 12 health.",
        BerryJam = "Made from 10 Berries. Eat it for 15 health.",
        CarrotCake = "Made from 10 Carrots and a Bread. Eat it for 20 health.",
        BerryPie = "Made from a Berry Jam and a Bread. Eat it for 30 health.",
        VegetableSoup = "Made from a Tomato Sauce, 2 Carrots and 2 Onions. Eat it for 40 health.",
        JumboBerryPie = "Made from 5 Jumbo Berries and a Bread. Eat it for 50 health and to grow 50% bigger for 10 minutes. Respawning ends it.",
        SlimeSoup = "Eat it for 10 health and leave a slime trail behind you for two minutes.",
        PinkberryPie = "Eat it for 25 health and low gravity for two minutes.",
        HeartySoup = "Eat it for 20 health and hearts follow you for three minutes.",
        RocketCarrot = "Eat it and blast off. It doesn't hurt.",
        Bluetato = "Eat it to turn blue and freeze in place for 8 seconds.",
        CandyCorn = "Has a chance to drop from mining, chopping, harvesting and slimes. Eat it to become an Orange Slime for 30 seconds, or spend 50 at your portal to unlock the Halloween Portal.",
        WateringCan = "Fill it from the pond, or from a Water Block (which uses up its water). Each use wets 1 soil for ten minutes, and crops on wet soil grow without using up a Water Block.",
        WaterBlock = "Waters farm soil within three blocks. Crops drink it as they grow. Placed only from a Water Bucket or a Water Pump; top it up with a Water Bucket filled in the Hub's pond.",
        GrassBlock = "Starter block.",
        DirtBlock = "Grass with nothing growing on it.",
        WoodBlock = "Made from Wood.",
        StoneBlock = "Made from Stone.",
        SandBlock = "One Sand, pressed at a Workbench.",
        ClayBlock = "1 Clay, pressed at a Workbench. Put in a Furnace to get brick.",
        BrickBlock = "A Clay Block, fired in a Furnace.",
        CoalBlock = "Solid coal.",
        WoodFence = "Fencing.",
        WoodFenceGate = "A gate for a fence. Anyone on the island can open it.",
        WoodTrapdoor = "A hatch that swings up on its back edge. Anyone on the island can open it.",
        WoodChair = "Anyone on the island can sit on it.",
        WoodTable = "A table.",
        StoneBrickFence = "Fencing.",
        Sign = "Stands on a stake, or hangs flat when placed against a wall.",
        WoodDoor = "2 blocks tall. Anyone on the island can open it.",
        VaultDoor = "An iron door with a barred window. Only you, your co-op partners and your Builders can open it.",
        IronBlock = "Solid iron.",
        Workbench = "Crafting workbench. Upgrade it to unlock new craftables.",
        CookingStation = "Turns Wheat into Dough and Dough into Bread, and a Golden Wheat Sheaf into Golden Bread. Unlocked by Workbench II.",
        BuilderBench = "Craft blocks. Unlocked by Workbench II.",
        LightingBench = "Makes light objects. Unlocked by Workbench II.",
        Lantern = "Casts a warm light.",
        WallLantern = "A smaller Lantern for mounting against a wall.",
        Toolsmith = "Forges tools and weapons. Unlocked at Workbench II.",
        Furnace = "Smelts Iron Ore into Iron Ingots. Burns Coal. Manual: you load it, it runs.",
        Fabricator = "Builds heavy components and machinery.",
        BlockPress = "Belt in Wood, Stone, Sand, Clay, Coal, Glass, Iron Ingots or Slime Gel and it presses them into blocks, out the front. Feed it flowers with Clay or Glass Blocks to color them. Burns no Coal.",
        Recycler = "Breaks an item back down into a share of its raw materials.",
        Composter = "Turns spare seeds into Fertilizer. Rarer seeds fill it faster.",
        Fertilizer = "Spread it on Farm Soil. Crops there grow faster while watered, for 15 minutes.",
        Conveyor = "Carries items. Connect with other conveyors.",
        ConveyorCorner = "Right conveyor.",
        ConveyorCornerLeft = "Left conveyor.",
        Splitter = "Run a conveyor into it from any side. Each stack goes out the next belt leading away from it, in turn, and a belt that is backed up is skipped.",
        ConveyorRampUp = "Conveyor items go up.",
        ConveyorRampDown = "Conveyor items go down.",
        GuestBook = "A book visitors can sign. Put it near your spawn and see who has visited and liked your Island.",
        StorageChest = "Store 6 different items, max 99 per slot.",
        WeaponDisplay = "Show off a weapon or tool, turning on its stand.",
        WeaponStand = "Show off a weapon or tool, resting on a stand.",
        ShinyTank = "A glass tank to show off one of your Shinies.",
        FlowerPot = "Show off one of your flowers in a pot.",
        LargeFlowerPot = "Show off up to three of your flowers in one big pot.",
        PlateDisplay = "Show off a dish you cooked, on a plate.",
        LargeChest = "Store 24 different items, max 99 per slot.",
        VendingMachine = "Your shop. Put an item in it, set a price, and anyone who visits can buy it while you are away. Coins go straight to your balance, minus a 5% tax. Switch it to Buy and it purchases for you instead.",
        InputChest = "10 item slots with a belt intake.",
        OutputChest = "Ten slots that feed a belt, exits 1 item per second.",
        OverflowChest = "24 slots, max 99 per slot. A belt fills it from the back; once full, what arrives goes on to the belts at its other sides.",
        WoodHarvesterI = "Grows and fells trees in a patch around itself.",
        StoneHarvesterI = "Grows and mines stone in a patch around itself.",
        IronHarvesterI = "Grows and mines iron ore.",
        CoalHarvesterI = "Coal Drill, place to generate coal. The only way to automate fuel.",
        SandHarvesterI = "Grows and digs sand in a patch around itself.",
        ClayHarvesterI = "Clay Drill. Grows and digs clay in a patch around itself.",
        WoodPickaxe = "Starter Pickaxe for mining.",
        StonePickaxe = "Pickaxe.. made out of stone...",
        StoneAxe = "Axe.. made out of stone...",
        StoneSword = "Sword.. made out of stone...",
        Plow = "Turns grass and soil into Farm Soil, which is what crops are planted in.",
        Pollinator = "Takes pollen from one grown flower and carries it to another of the same kind nearby for breeding.",
        WoodAxe = "Starter axe for cutting trees.",
        IronPickaxe = "Pickaxe... made from Iron.",
        IronAxe = "Axe... made from Iron.",
        WoodSword = "Starter weapon.",
        IronSword = "Roughly double the wooden sword damage, and faster.",
        WheatSeeds = "Grows Wheat.",
        CarrotSeeds = "Grows Carrots.",
        TomatoSeeds = "Grows Tomatoes.",
        OnionSeeds = "Grows Onions.",
        Wheat = "The cheapest crop. Use to make foods like dough for bread or sell for early coins.",
        Carrot = "Yum carrots.",
        Tomato = "Yum Tomatoes.",
        Onion = "Yum Onions...",
        GoldenWheatSheaf = "A rare harvest. Bake it into Golden Bread at a Cooking Station or Industrial Cooker, or sell it.",
        HeirloomCarrot = "A rare harvest.",
        SunRipenedTomato = "Rare harvest.",
        PearlOnion = "A rare harvest.",
        BerryBushSeed = "Takes about four and a half minutes to grow, then makes Berries just as often. Never needs replanting.",
        Berries = "Picked from a Berry Bush.",
        JumboBerry = "A rare harvest.",
        WoodSlab = "Half a wood block.",
        WoodStairs = "Stairs.",
        StoneSlab = "Half a stone block.",
        StoneStairs = "Stairs.",
        StoneBrick = "Finished stone.",
        StoneBrickSlab = "Half a Stone Brick.",
        StoneBrickStairs = "Stairs.",
        IronSlab = "Half an iron block. 2 from one Iron Block, and the toughest slab in the game.",
        IronStairs = "Stairs.",
        BrickSlab = "Half a brick block.",
        BrickStairs = "Stairs.",
        CoalSlab = "Half a coal block.",
        CoalStairs = "Stairs.",
        SandSlab = "Half a sand block.",
        SandStairs = "Stairs.",
        GlassBlock = "A window you can see through and break through.",
        GreenSlimeBlock = "Bounces you 4 blocks high. Fall onto it from higher up and you'll bounce higher.",
        BlueSlimeBlock = "Bounces you 6 blocks high. Fall onto it from higher up and you'll bounce higher.",
        OrangeSlimeBlock = "Bounces you 8 blocks high. Fall onto it from higher up and you'll bounce higher.",
        PinkSlimeBlock = "Bounces you 10 blocks high, the highest of any slime block. Fall onto it from higher up and you'll bounce higher.",
        GlassPane = "A sheet of glass.",
        WoodHarvesterII = "Grows and fells trees in a patch around itself.",
        WoodHarvesterIII = "Grows and fells trees in a patch around itself.",
        StoneHarvesterII = "Grows and mines stone in a patch around itself.",
        StoneHarvesterIII = "Grows and mines stone in a patch around itself.",
        IronHarvesterII = "Grows and mines iron ore.",
        IronHarvesterIII = "Grows and mines iron ore.",
        CoalHarvesterII = "Coal Drill, place to generate coal. The only way to automate fuel.",
        CoalHarvesterIII = "Coal Drill, place to generate coal. The only way to automate fuel.",
        WheatHarvester = "Reaps and replants in the patch around it. Plant seeds near it.",
        CarrotHarvester = "Reaps and replants in the patch around it. Plant seeds near it.",
        TomatoHarvester = "Reaps and replants in the patch around it. Plant seeds near it.",
        OnionHarvester = "Reaps and replants in the patch around it. Plant seeds near it.",
        Bucket = "Fill it in the Hub's pond to carry water home. It becomes a Water Bucket.",
        WaterBucket = "Place it to put down a full Water Block, or use it on a low one to fill it back up. The Bucket comes back empty.",
        Torch = "Lights area around it.",
        FarmSoil = "Tilled ground. Crops only grow on it when it's wet.",
        Glowstick = "A green light worn at the waist, for the game's testers.",
        Glowlight = "A blue light worn at the waist. The reward for completing The Blue Collection.",
        CrimsonGlowlight = "A crimson light worn at the waist. The reward for completing The Ember Collection.",
        SunGlowlight = "A golden light worn at the waist. The reward for completing The Sun Collection.",
    },
    BeltNoteDefault = "Connect conveyors to feed it. It makes whatever the material is for, and anything it can't use passes straight through.",
    BeltNotes = {
        Bakehouse = "Cooks just like the Cooking Station, except automated via connected conveyors. For example, x3 Wheat makes Dough and x2 Dough makes Bread. Combine x1 Berry Jam and x1 Bread to make Berry Pie.\n\nFind recipes in the Cooking Station. Workbench Tier 2 required.",
        BlockPress = "Crafts blocks automatically via connected conveyors. For example, x1 Glass Block + x1 Any Glowing Flower = Neon Block. Find recipes in the Builder Bench. Any materials not supported pass straight through.\n\nWorkbench Tier 2 is required for certain blocks to be crafted.",
        IndustrialFurnace = "Just like the Furnace, except it smelts materials automatically via connected conveyors. For example, x1 Iron Ore makes x1 Iron Ingot, x2 Sand makes x1 Glass, and x1 Clay Block makes x1 Brick Block. Get more ideas from the Furnace.\n\nRequires Coal to operate. Workbench Tier 2 is required for certain outputs.",
    },
    BeltTips = {
        BlockPress = {
            "Clay Block + Colored Flower = Colored Block",
            "Glass Block + Glowing Colored Flower = Neon Colored Block",
            "x4 Slime Gel = Slime Block",
            "Clay = Clay Block",
            "Coal = Coal Block",
            "Glass = Glass Block",
            "Iron Ingot = Iron Block",
            "Sand = Sand Block",
            "Stone = Stone Block",
            "Stone Block = Stone Brick",
            "Wood = Wood Block",
        },
    },
    Nodes = {
        Tree = "Chop with an axe. Five Wood.",
        Stone = "Mine with a pickaxe. Four Stone.",
        IronOre = "Mine with a pickaxe. Four Iron Ore, useless until smelted.",
        Coal = "Mine with a pickaxe. Three Coal, fuel for every crafting station.",
    },
    Soulbound = {
        Glowstick = true,
        Glowlight = true,
        CrimsonGlowlight = true,
        SunGlowlight = true,
        WaterBlock = true,
    },
    FlowerSpecies = {"Daisy", "Lily", "Poppy", "Snapdragon", "Tulip"},
    FlowerPatterns = {
        Glowing = " This one glows. It's the rarest pattern, and you can spot it from across a dark island.",
        Striped = " It got its stripes from its parents.",
        Dotted = " It got its spots from its parents.",
    },
    FlowerText = "A flower. Plant it anywhere on your island, no soil or water needed. Pollinate two different colors and wait twelve minutes for a new color that neither parent had.",
}

local function flowerText(a1) -- Line: 354; upvalues: u0 (val); types: a1: string
    local v1 = false

    for i, j in u0.FlowerSpecies do
        if string.sub(a1, -#j) == j then
            v1 = true
            break
        end
    end

    if not v1 then
        return nil
    end

    for k, n in u0.FlowerPatterns do
        if string.sub(a1, 1, #k) == k then
            return u0.FlowerText .. n
        end
    end

    return u0.FlowerText
end

for i, j in {"Red", "Yellow", "Blue", "White", "Orange", "Pink", "Purple", "Green", "Sky", "Lime", "Black"} do
    v1 = string.lower(j)
    Items = u0.Items
    v2 = ("%*ClayBlock"):format(j)
    Items[v2] = (("A Clay Block colored %*. A Clay Block and any %* flower, at a Builder Bench or a Block Press."):format(v1, v1))
    Items_2 = u0.Items
    v2 = ("%*NeonBlock"):format(j)
    Items_2[v2] = (("Glows %*. A Glass Block and a Glowing %* flower, at a Builder Bench or a Block Press."):format(v1, v1))
end

function u0.of(a1) -- Line: 383; upvalues: u0 (val), flowerText (val); types: a1: string
    local v1 = u0.Items[a1] or u0.Nodes[a1] or flowerText(a1) or ""

    if u0.Soulbound[a1] and v1 ~= "" then
        return u0.SoulboundPrefix .. v1
    end

    return v1
end

return u0