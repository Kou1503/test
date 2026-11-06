-- Script path: game:GetService("ReplicatedStorage").Shared.Config.GuideConfig
-- Decompile time: 1.43 ms

local u0 = {
    Groups = {"Starter", "Advanced"},
    RefreshSeconds = 2,
    MinRequestSeconds = 1,
    BeltStats = {Wood = "WoodByBelt", Bread = "BreadByBelt"},
    Guides = {
        {
            id = "WorkbenchII",
            title = "Upgrade your Workbench to Tier 2",
            group = "Starter",
            blurb = "Unlocks the Toolsmith, the Machinery Workbench, belts and almost everything in these guides.",
            steps = {
                {
                    kind = "upgrade",
                    tier = 2,
                    label = "Meet the upgrade's requirements, then upgrade at your Workbench",
                },
            },
        },
        {
            id = "BreedFlower",
            title = "Breed a Flower",
            group = "Starter",
            blurb = "Carry pollen between two grown flowers of the same kind and a new one grows beside them.",
            steps = {
                {kind = "have", item = "Pollinator", count = 1, label = "Craft a Pollinator"},
                {
                    kind = "stat",
                    stat = "FlowersBred",
                    count = 1,
                    label = "Take pollen from a grown flower to another of the same kind",
                    hint = "Wild flowers turn up on your island and at the Hub. A new one grows a while after.",
                },
            },
        },
        {
            id = "IronTools",
            title = "Craft Iron Tools and Weapons",
            group = "Starter",
            blurb = "Faster mining and chopping, and a sword that hits twice as hard as the wooden one.",
            unordered = true,
            steps = {
                {kind = "have", item = "Toolsmith", count = 1, label = "Craft a Toolsmith"},
                {kind = "have", item = "IronPickaxe", count = 1, label = "Craft an Iron Pickaxe"},
                {kind = "have", item = "IronAxe", count = 1, label = "Craft an Iron Axe"},
                {kind = "have", item = "IronSword", count = 1, label = "Craft an Iron Sword"},
            },
        },
        {
            id = "GuestBook",
            title = "Get Friends to Sign your Guest Book",
            group = "Starter",
            blurb = "Visitors sign it and like your island, and you see who came.",
            steps = {
                {
                    kind = "have",
                    item = "GuestBook",
                    count = 1,
                    label = "Craft a Guest Book and place it near your spawn",
                },
                {
                    kind = "signatures",
                    count = 5,
                    label = "Get 5 visitors to sign it",
                    action = "Invite",
                    hint = "Invite friends to play, then send them to your island from the Islands menu.",
                },
            },
        },
        {
            id = "IronFactory",
            title = "Build an Automated Iron Factory",
            group = "Starter",
            blurb = "Drills mine the ore, belts carry it, and a furnace smelts it into a chest while you do something else.",
            steps = {
                {
                    kind = "have",
                    item = "IronHarvesterI",
                    count = 1,
                    label = "Buy an Iron Drill from the Machinist",
                    guideTo = "Machinist",
                },
                {
                    kind = "have",
                    item = "CoalHarvesterI",
                    count = 1,
                    label = "Buy a Coal Drill to fuel the furnace",
                    guideTo = "Machinist",
                },
                {
                    kind = "have",
                    item = "IndustrialFurnace",
                    count = 1,
                    label = "Craft an Industrial Furnace",
                },
                {kind = "have", item = "Conveyor", count = 6, label = "Craft Conveyors"},
                {kind = "have", item = "OutputChest", count = 1, label = "Craft an Output Chest"},
                {
                    kind = "reached",
                    reached = "FirstAutomatedIron",
                    label = "Belt Iron Ingots from the furnace into the Output Chest",
                },
            },
        },
        {
            id = "RailTrack",
            title = "Build a Rail Track",
            group = "Advanced",
            blurb = "Lay track across your island and ride it.",
            steps = {
                {kind = "have", item = "Rail", count = 8, label = "Craft Rails"},
                {kind = "have", item = "Minecart", count = 1, label = "Craft a Minecart"},
                {
                    kind = "stat",
                    stat = "CartRides",
                    count = 1,
                    label = "Lay the track, set the cart on it and ride",
                },
            },
        },
        {
            id = "Shop",
            title = "Build a Shop",
            group = "Advanced",
            blurb = "Sell to visitors while you are away.",
            steps = {
                {kind = "have", item = "VendingMachine", count = 1, label = "Craft a Vending Machine"},
                {
                    kind = "reached",
                    reached = "VendingConfigured",
                    label = "Place it, stock it and set a price",
                },
            },
        },
        {
            id = "BreadFactory",
            title = "Build an Automated Bread Factory",
            group = "Advanced",
            blurb = "A Harvester reaps the wheat and a Bakehouse turns it into Bread off the belt.",
            steps = {
                {
                    kind = "have",
                    item = "WheatHarvester",
                    count = 1,
                    label = "Buy a Wheat Harvester from the Machinist",
                    guideTo = "Machinist",
                },
                {
                    kind = "have",
                    item = "Bakehouse",
                    count = 1,
                    label = "Craft a Bakehouse",
                    hint = "It burns Coal: belt it from a Coal Drill, or load it by hand.",
                },
                {kind = "have", item = "Conveyor", count = 6, label = "Craft Conveyors"},
                {
                    kind = "stat",
                    stat = "BreadByBelt",
                    count = 1,
                    label = "Belt Bread from the Bakehouse into a chest",
                },
            },
        },
        {
            id = "WaterPump",
            title = "Build an Automated Water Pump",
            group = "Advanced",
            blurb = "Water your fields without carrying a single bucket.",
            steps = {
                {
                    kind = "have",
                    item = "WaterPump",
                    count = 1,
                    label = "Craft a Water Pump",
                    hint = "Its seals need Pink Slime Gel, dropped by the rare Pink Slime at the Hub.",
                },
                {kind = "have", item = "WaterPipe", count = 4, label = "Craft Water Pipes"},
                {kind = "have", item = "WaterSpout", count = 1, label = "Craft a Water Spout"},
            },
        },
        {
            id = "LumberMill",
            title = "Build a Lumber Mill",
            group = "Advanced",
            blurb = "The machine that stops you chopping: it grows trees, fells them and puts the Wood on a belt.",
            steps = {
                {kind = "have", item = "WoodHarvesterI", count = 1, label = "Craft a Lumber Mill"},
                {kind = "have", item = "Conveyor", count = 4, label = "Craft Conveyors"},
                {kind = "stat", stat = "WoodByBelt", count = 1, label = "Belt its Wood into a chest"},
            },
        },
        {
            id = "BlueShinies",
            title = "Complete the Blue Collection",
            group = "Advanced",
            blurb = "Six Shinies, found everywhere. The set most players finish first.",
            steps = {{kind = "shiny", family = "Blue", label = "Find all six and turn them in"}},
        },
        {
            id = "EmberShinies",
            title = "Complete the Ember Collection",
            group = "Advanced",
            blurb = "Six fire Shinies, about one find in five.",
            steps = {{kind = "shiny", family = "Red", label = "Find all six and turn them in"}},
        },
        {
            id = "SunShinies",
            title = "Complete the Sun Collection",
            group = "Advanced",
            blurb = "The rarest set: about one Shiny in twelve.",
            steps = {{kind = "shiny", family = "Yellow", label = "Find all six and turn them in"}},
        },
    },
}

function u0.byId(a1) -- Line: 266; upvalues: u0 (val); types: a1: string
    for i, j in u0.Guides do
        if j.id == a1 then
            return j
        end
    end

    return nil
end

return u0