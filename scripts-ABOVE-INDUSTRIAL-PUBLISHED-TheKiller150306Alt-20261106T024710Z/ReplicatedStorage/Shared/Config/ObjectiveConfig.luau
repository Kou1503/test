-- Script path: game:GetService("ReplicatedStorage").Shared.Config.ObjectiveConfig
-- Decompile time: 0.27 ms

return {
    Objectives = {
        {
            step = "FirstSoil",
            orReached = "FirstCrop",
            orStat = "SoilTilled",
            orBlock = "FarmSoil",
            marker = "Pond",
            text = "Plow the grass beside your pond. Crops only grow near water",
        },
        {
            step = "FirstPlant",
            orReached = "FirstCrop",
            orStat = "CropsPlanted",
            text = "Plant your Wheat Seeds in the new soil",
        },
        {
            step = "FirstTree",
            orStat = "TreesChopped",
            marker = "Tree",
            text = "Chop a tree while your wheat grows. Hold click with your axe",
        },
        {
            step = "FirstStone",
            orStat = "StoneMined",
            marker = "Stone",
            text = "Mine some stone with your pickaxe",
        },
        {step = "FirstCrop", orStat = "CropsHarvested", text = "Harvest your wheat once it's ripe"},
        {step = "ReachedHub", text = "Step through your portal to reach the Hub", marker = "Portal"},
        {
            step = "PlacedWorkbench",
            orMachine = "Workbench",
            orReached = "FirstFurnace",
            text = "Place your Workbench on your island. It's in your backpack",
        },
        {
            step = "FirstIronOre",
            orReached = "FirstFurnace",
            marker = "IronOre",
            text = "Mine the Iron Ore on your island with your pickaxe",
        },
        {
            step = "FirstFurnace",
            orMachine = "Furnace",
            orReached = "FirstIron",
            text = "Craft a Furnace at your Workbench. Your island has the Stone and Iron Ore",
        },
        {
            step = "FirstIron",
            text = "Place your Furnace, give it Coal, and smelt your Iron Ore",
            hint = "You can get Coal from the mines in the Hub",
        },
        {step = "WorkbenchII", text = "Upgrade your Workbench. Check what it needs"},
    },
    EndsAtWorkbenchTier = 2,
    ShowLine = false,
    Completed = "",
}