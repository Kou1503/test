-- Script path: game:GetService("ReplicatedStorage").Shared.Config.TutorialConfig
-- Decompile time: 1.21 ms

local u0 = {
    Welcome = {
        Title = "Welcome to ABOVE!",
        Body = "Start with a manual farm and turn your floating island into an automated factory and shop!\n\nIf you like the game please give it a LIKE 👍 and Favorite ⭐ to show your support!",
        Button = "Let's go",
        Height = 214,
    },
    Guide = {
        Plots = 4,
        Seed = "WheatSeeds",
        Grass = "GrassBlock",
        Soil = "FarmSoil",
        Water = "WaterBlock",
        Growing = "Growing: ready in %ds. Each crop drinks from the pond as it grows",
        Ripe = "Ripe! Look at the wheat and press {Pickup}",
        RipeTouch = "Ripe! Look at the wheat and tap the hand button",
        Tools = {
            Till = "Plow",
            Plant = "WheatSeeds",
            Build = "GrassBlock",
            FillBucket = "Bucket",
            PlaceWater = "WaterBucket",
            Replant = "WheatSeeds",
            PlaceBench = "Workbench",
        },
        KeepInHand = {GrassBlock = true},
        Camera = {
            MoveSeconds = 0.9,
            HoldSeconds = 2.6,
            DistanceStuds = 22,
            HeightStuds = 14,
            MaxStuds = 260,
            NearStuds = 30,
            WelcomeGraceSeconds = 0.75,
        },
    },
}
u0.NewPlayerGrowth = {
    Multiplier = 15,
    Until = "Harvest",
    CropId = "Wheat",
    Attribute = "NewPlayerGrowth",
    MaxCrops = u0.Guide.Plots,
}
u0.Showcase = {
    AfterStep = "FirstCrop",
    TourSeconds = 8,
    Title = "Turn your farm into a factory!",
    Skip = "Skip",
    DeliverySeconds = 60,
    At = {x = 0, y = 1500, z = -9000},
}
u0.IslandCounters = {HydratedSoil = true, HydratedCrops = true}
u0.Steps = {
    {
        id = "Till",
        step = "FirstSoil",
        stat = "HydratedSoil",
        orReached = "FirstCrop",
        guided = true,
        text = "Plow the marked grass beside your pond",
        hint = "Crops only grow within 3 blocks of water, so the field goes by the pond",
        touchHint = "Crops only grow within 3 blocks of water, so the field goes by the pond",
        atLeast = u0.Guide.Plots,
    },
    {
        id = "Plant",
        step = "FirstPlant",
        stat = "HydratedCrops",
        orReached = "FirstCrop",
        guided = true,
        text = "Plant your Wheat Seeds in the new soil",
        hint = "It's close enough to the pond to stay watered. Soil far from water grows nothing",
        touchHint = "It's close enough to the pond to stay watered. Soil far from water grows nothing",
        atLeast = u0.Guide.Plots,
    },
    {
        id = "Harvest",
        step = "FirstCrop",
        guided = true,
        text = "Harvest the wheat once it's ripe",
        hint = "Each crop drinks from the pond as it grows. Look at it and press {Pickup}",
        touchHint = "Each crop drinks from the pond as it grows. Look at it and tap the hand button",
    },
    {
        id = "Build",
        step = "FirstBuild",
        text = "Put a block down. The island is yours to change",
        hint = "Select Grass Blocks from the bar and click to place. Use your pickaxe to break them",
        touchHint = "Select Grass Blocks from the bar and tap to place. Use your pickaxe to break them",
    },
    {
        id = "Hub",
        step = "ReachedHub",
        text = "Step through your portal to the Hub",
        guideTo = "Portal",
        hint = "Sell crops, buy seeds and blocks, mine ore, and expand your island",
        touchHint = "Sell crops, buy seeds and blocks, mine ore, and expand your island",
    },
    {
        id = "Sell",
        step = "FirstSale",
        text = "Sell your wheat to the Merchant at the Hub island",
        guideTo = "Merchant",
        hint = "Walk up to them and choose to sell",
        touchHint = "Walk up to them and choose to sell",
    },
    {
        id = "Buy",
        step = "FirstPurchase",
        text = "Buy more seeds from the Seed Dealer",
        guideTo = "SeedDealer",
        hint = "Plant them, sell the harvest, buy more again. Later, machines do the picking",
        touchHint = "Plant them, sell the harvest, buy more again. Later, machines do the picking",
    },
    {
        id = "FillBucket",
        step = "FirstWater",
        stat = "BucketsFilled",
        atLeast = 1,
        orReached = "FirstWater",
        focus = "HubPond",
        guideTo = "HubPond",
        text = "Fill your Bucket in the Hub's pond",
        hint = "Your pond runs dry as crops drink. This one never does. Click the water with your Bucket",
        touchHint = "Your pond runs dry as crops drink. This one never does. Tap the water with your Bucket",
    },
    {
        id = "PlaceWater",
        step = "FirstWater",
        focus = "Pond",
        text = "Bring the water home to your pond",
        hint = "Place the Water Bucket by your field. Each block of water waters crops 3 blocks around it",
        touchHint = "Place the Water Bucket by your field. Each block of water waters crops 3 blocks around it",
    },
    {
        id = "Replant",
        step = "FirstPlant",
        stat = "CropsPlanted",
        guideTo = "HomePortal",
        text = "Plant your new seeds to grow a bigger field",
        hint = "Every harvest gives its seed back, so each seed you buy grows your field",
        touchHint = "Every harvest gives its seed back, so each seed you buy grows your field",
        atLeast = u0.Guide.Plots + 1,
    },
    {
        id = "PlaceBench",
        step = "PlacedWorkbench",
        orReached = "FirstFurnace",
        text = "Place your Workbench on your island",
        hint = "It's on your hotbar. Pick it and click a spot on your island to put it down",
        touchHint = "It's on your hotbar. Pick it and tap a spot on your island to put it down",
    },
    {
        id = "Craft",
        step = "FirstFurnace",
        text = "Craft a Furnace at your Workbench",
        hint = "Mine 12 Stone and 9 Iron Ore, then press {Use} at your Workbench and craft the Furnace",
        touchHint = "Mine 12 Stone and 9 Iron Ore, then tap Craft at your Workbench and craft the Furnace",
    },
}
u0.SharedOnIsland = {FirstFurnace = "Furnace"}
u0.NewPlayerView = {ClockHour = 13}
u0.Finished = "That's the loop. Now grow it: a bigger island, machines to work it, and enough of everything that it runs without you. Industrialize the sky."
u0.FinishedSeconds = 9

function u0.isStep(a1) -- Line: 387; upvalues: u0 (val); types: a1: string
    for i, j in u0.Steps do
        if j.id == a1 then
            return true
        end
    end

    return false
end

function u0.nextStep(a1, a2) -- Line: 400; upvalues: u0 (val); types: a1: function, a2: function
    local v1, v2, v3
    local v4 = nil
    local v5 = nil

    for i, j in u0.Steps, v4, v5 do
        if not j.stat or not j.atLeast then
            v2 = v1(j.step)
        else
            v3 = a2(j.stat)
            v2 = j.atLeast <= v3
        end

        if not v2 and j.orReached then
            v2 = v1(j.orReached)
        end

        if not v2 then
            return j
        end
    end

    return nil
end

return u0