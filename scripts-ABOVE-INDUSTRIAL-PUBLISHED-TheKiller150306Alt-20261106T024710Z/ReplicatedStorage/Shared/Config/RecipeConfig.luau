-- Script path: game:GetService("ReplicatedStorage").Shared.Config.RecipeConfig
-- Decompile time: 10.52 ms

local v1, v2, v3

local function recipe(a1, a2, a3, a4, a5, a6, a7, a8)
    -- Line: 20
    -- types: a1: string, a2: number, a3: table, a4: table, a5: string, a6: number, a7: number, a8: boolean
    return {
        id = a1,
        workbenchTier = a2,
        stations = a3,
        inputs = a4,
        output = a5,
        outputCount = a6,
        timeSeconds = a7,
        qualityEligible = a8,
    }
end

local v4 = {"Workbench"}
local v5 = {"Hand", "Workbench"}
local v6 = {"Fabricator"}
local v7 = {"Workbench", "Fabricator"}
local v8 = {"Furnace", "IndustrialFurnace"}
local v9 = {"CookingStation", "Bakehouse"}
local v10 = {"Bakehouse"}
local v11 = {"Toolsmith"}
local v12 = {"LightingBench"}
local v13 = {"BuilderBench"}
local v14 = {"Workbench", "BuilderBench"}
local u672 = {
    Blocks = {
        WoodBlock = {
            id = "WoodBlock",
            workbenchTier = 1,
            output = "WoodBlock",
            outputCount = 1,
            timeSeconds = 0.5,
            qualityEligible = false,
            stations = v14,
            inputs = {Wood = 1},
        },
        StoneBlock = {
            id = "StoneBlock",
            workbenchTier = 1,
            output = "StoneBlock",
            outputCount = 1,
            timeSeconds = 0.5,
            qualityEligible = false,
            stations = v14,
            inputs = {Stone = 1},
        },
        IronIngot = {
            id = "IronIngot",
            workbenchTier = 1,
            output = "IronIngot",
            outputCount = 1,
            timeSeconds = 3,
            qualityEligible = false,
            stations = v8,
            inputs = {IronOre = 1},
        },
        Glass = {
            id = "Glass",
            workbenchTier = 1,
            output = "Glass",
            outputCount = 1,
            timeSeconds = 4,
            qualityEligible = false,
            stations = v8,
            inputs = {Sand = 2},
        },
        SandBlock = {
            id = "SandBlock",
            workbenchTier = 1,
            output = "SandBlock",
            outputCount = 1,
            timeSeconds = 0.5,
            qualityEligible = false,
            stations = v14,
            inputs = {Sand = 1},
        },
        ClayBlock = {
            id = "ClayBlock",
            workbenchTier = 1,
            output = "ClayBlock",
            outputCount = 1,
            timeSeconds = 0.5,
            qualityEligible = false,
            stations = v14,
            inputs = {Clay = 1},
        },
        BrickBlock = {
            id = "BrickBlock",
            workbenchTier = 1,
            output = "BrickBlock",
            outputCount = 1,
            timeSeconds = 4,
            qualityEligible = false,
            stations = v8,
            inputs = {ClayBlock = 1},
        },
        CoalBlock = {
            id = "CoalBlock",
            workbenchTier = 1,
            output = "CoalBlock",
            outputCount = 1,
            timeSeconds = 1,
            qualityEligible = false,
            stations = v14,
            inputs = {Coal = 1},
        },
        WoodFence = {
            id = "WoodFence",
            workbenchTier = 1,
            output = "WoodFence",
            outputCount = 1,
            timeSeconds = 1,
            qualityEligible = false,
            stations = v14,
            inputs = {WoodBlock = 1},
        },
        WoodFenceGate = {
            id = "WoodFenceGate",
            workbenchTier = 1,
            output = "WoodFenceGate",
            outputCount = 1,
            timeSeconds = 1,
            qualityEligible = false,
            stations = v14,
            inputs = {WoodBlock = 2},
        },
        WoodTrapdoor = {
            id = "WoodTrapdoor",
            workbenchTier = 1,
            output = "WoodTrapdoor",
            outputCount = 1,
            timeSeconds = 1,
            qualityEligible = false,
            stations = v14,
            inputs = {WoodBlock = 2},
        },
        WoodChair = {
            id = "WoodChair",
            workbenchTier = 1,
            output = "WoodChair",
            outputCount = 1,
            timeSeconds = 1,
            qualityEligible = false,
            stations = v14,
            inputs = {WoodBlock = 2},
        },
        WoodTable = {
            id = "WoodTable",
            workbenchTier = 1,
            output = "WoodTable",
            outputCount = 1,
            timeSeconds = 1,
            qualityEligible = false,
            stations = v14,
            inputs = {WoodBlock = 3},
        },
        WoodDoor = {
            id = "WoodDoor",
            workbenchTier = 1,
            output = "WoodDoor",
            outputCount = 1,
            timeSeconds = 2,
            qualityEligible = false,
            stations = v14,
            inputs = {WoodBlock = 3},
        },
        VaultDoor = {
            id = "VaultDoor",
            workbenchTier = 2,
            output = "VaultDoor",
            outputCount = 1,
            timeSeconds = 4,
            qualityEligible = false,
            stations = v13,
            inputs = {IronIngot = 20},
        },
        Sign = {
            id = "Sign",
            workbenchTier = 2,
            output = "Sign",
            outputCount = 1,
            timeSeconds = 1,
            qualityEligible = false,
            stations = v4,
            inputs = {WoodBlock = 1},
        },
        WaterPipe = {
            id = "WaterPipe",
            workbenchTier = 2,
            output = "WaterPipe",
            outputCount = 1,
            timeSeconds = 2,
            qualityEligible = false,
            stations = v6,
            inputs = {IronIngot = 5},
        },
        WaterPipeCorner = {
            id = "WaterPipeCorner",
            workbenchTier = 2,
            output = "WaterPipeCorner",
            outputCount = 1,
            timeSeconds = 2,
            qualityEligible = false,
            stations = v6,
            inputs = {IronIngot = 5},
        },
        WaterSpout = {
            id = "WaterSpout",
            workbenchTier = 2,
            output = "WaterSpout",
            outputCount = 1,
            timeSeconds = 2,
            qualityEligible = false,
            stations = v6,
            inputs = {IronIngot = 5},
        },
        Rail = {
            id = "Rail",
            workbenchTier = 2,
            output = "Rail",
            outputCount = 1,
            timeSeconds = 2,
            qualityEligible = false,
            stations = v6,
            inputs = {IronIngot = 1, Wood = 1},
        },
        RailCorner = {
            id = "RailCorner",
            workbenchTier = 2,
            output = "RailCorner",
            outputCount = 1,
            timeSeconds = 2,
            qualityEligible = false,
            stations = v6,
            inputs = {IronIngot = 1, Wood = 1},
        },
        RailRamp = {
            id = "RailRamp",
            workbenchTier = 2,
            output = "RailRamp",
            outputCount = 1,
            timeSeconds = 2,
            qualityEligible = false,
            stations = v6,
            inputs = {IronIngot = 1, Wood = 1},
        },
        RailBooster = {
            id = "RailBooster",
            workbenchTier = 2,
            output = "RailBooster",
            outputCount = 1,
            timeSeconds = 3,
            qualityEligible = false,
            stations = v6,
            inputs = {Gear = 1, Wood = 1},
        },
        RailRampBooster = {
            id = "RailRampBooster",
            workbenchTier = 2,
            output = "RailRampBooster",
            outputCount = 1,
            timeSeconds = 3,
            qualityEligible = false,
            stations = v6,
            inputs = {Gear = 1, Wood = 1},
        },
        IronBlock = {
            id = "IronBlock",
            workbenchTier = 2,
            output = "IronBlock",
            outputCount = 1,
            timeSeconds = 2.5,
            qualityEligible = false,
            stations = v13,
            inputs = {IronIngot = 1},
        },
        Gear = {
            id = "Gear",
            workbenchTier = 2,
            output = "Gear",
            outputCount = 1,
            timeSeconds = 5,
            qualityEligible = false,
            stations = v7,
            inputs = {IronIngot = 2},
        },
    },
}
u672.Tools = {
    StonePickaxe = {
        id = "StonePickaxe",
        workbenchTier = 1,
        output = "StonePickaxe",
        outputCount = 1,
        timeSeconds = 12,
        qualityEligible = true,
        stations = v5,
        inputs = {Stone = 12, Wood = 6},
    },
    StoneAxe = {
        id = "StoneAxe",
        workbenchTier = 1,
        output = "StoneAxe",
        outputCount = 1,
        timeSeconds = 12,
        qualityEligible = true,
        stations = v5,
        inputs = {Stone = 10, Wood = 8},
    },
    IronPickaxe = {
        id = "IronPickaxe",
        workbenchTier = 2,
        output = "IronPickaxe",
        outputCount = 1,
        timeSeconds = 60,
        qualityEligible = true,
        stations = v11,
        inputs = {IronIngot = 34, Wood = 12},
    },
    IronAxe = {
        id = "IronAxe",
        workbenchTier = 2,
        output = "IronAxe",
        outputCount = 1,
        timeSeconds = 60,
        qualityEligible = true,
        stations = v11,
        inputs = {IronIngot = 34, Wood = 12},
    },
}
u672.Utility = {
    Plow = {
        id = "Plow",
        workbenchTier = 1,
        output = "Plow",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v5,
        inputs = {Wood = 12, Stone = 6},
    },
    Bucket = {
        id = "Bucket",
        workbenchTier = 1,
        output = "Bucket",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v4,
        inputs = {IronOre = 3, Wood = 4},
    },
    WateringCan = {
        id = "WateringCan",
        workbenchTier = 1,
        output = "WateringCan",
        outputCount = 1,
        timeSeconds = 6,
        qualityEligible = true,
        stations = v4,
        inputs = {Wood = 10, Stone = 4},
    },
    Pollinator = {
        id = "Pollinator",
        workbenchTier = 1,
        output = "Pollinator",
        outputCount = 1,
        timeSeconds = 8,
        qualityEligible = false,
        stations = v4,
        inputs = {Wood = 8, IronOre = 4},
    },
    Minecart = {
        id = "Minecart",
        workbenchTier = 2,
        output = "Minecart",
        outputCount = 1,
        timeSeconds = 4,
        qualityEligible = false,
        stations = v6,
        inputs = {Wood = 24},
    },
    IronRailcart = {
        id = "IronRailcart",
        workbenchTier = 2,
        output = "IronRailcart",
        outputCount = 1,
        timeSeconds = 4,
        qualityEligible = false,
        stations = v6,
        inputs = {IronIngot = 16},
    },
}
u672.Food = {
    Dough = {
        id = "Dough",
        workbenchTier = 2,
        output = "Dough",
        outputCount = 1,
        timeSeconds = 6,
        qualityEligible = false,
        stations = v9,
        inputs = {Wheat = 3},
    },
    Bread = {
        id = "Bread",
        workbenchTier = 2,
        output = "Bread",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v9,
        inputs = {Dough = 2},
    },
    GoldenDough = {
        id = "GoldenDough",
        workbenchTier = 2,
        output = "GoldenDough",
        outputCount = 1,
        timeSeconds = 8,
        qualityEligible = false,
        stations = v9,
        inputs = {GoldenWheatSheaf = 1},
    },
    GoldenBread = {
        id = "GoldenBread",
        workbenchTier = 2,
        output = "GoldenBread",
        outputCount = 1,
        timeSeconds = 12,
        qualityEligible = false,
        stations = v9,
        inputs = {GoldenDough = 1},
    },
    RoastedCarrot = {
        id = "RoastedCarrot",
        workbenchTier = 2,
        output = "RoastedCarrot",
        outputCount = 1,
        timeSeconds = 5,
        qualityEligible = false,
        stations = {"CookingStation"},
        inputs = {Carrot = 1},
    },
    TomatoSauce = {
        id = "TomatoSauce",
        workbenchTier = 2,
        output = "TomatoSauce",
        outputCount = 1,
        timeSeconds = 8,
        qualityEligible = false,
        stations = v9,
        inputs = {Onion = 2, Tomato = 2},
    },
    BerryJam = {
        id = "BerryJam",
        workbenchTier = 2,
        output = "BerryJam",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v9,
        inputs = {Berries = 10},
    },
    CarrotCake = {
        id = "CarrotCake",
        workbenchTier = 2,
        output = "CarrotCake",
        outputCount = 1,
        timeSeconds = 15,
        qualityEligible = false,
        stations = v9,
        inputs = {Carrot = 10, Bread = 1},
    },
    BerryPie = {
        id = "BerryPie",
        workbenchTier = 2,
        output = "BerryPie",
        outputCount = 1,
        timeSeconds = 15,
        qualityEligible = false,
        stations = v9,
        inputs = {BerryJam = 1, Bread = 1},
    },
    VegetableSoup = {
        id = "VegetableSoup",
        workbenchTier = 2,
        output = "VegetableSoup",
        outputCount = 1,
        timeSeconds = 12,
        qualityEligible = false,
        stations = v9,
        inputs = {TomatoSauce = 1, Carrot = 2, Onion = 2},
    },
    JumboBerryPie = {
        id = "JumboBerryPie",
        workbenchTier = 2,
        output = "JumboBerryPie",
        outputCount = 1,
        timeSeconds = 20,
        qualityEligible = false,
        stations = v9,
        inputs = {JumboBerry = 5, Bread = 1},
    },
    SlimeSoup = {
        id = "SlimeSoup",
        workbenchTier = 2,
        output = "SlimeSoup",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v10,
        inputs = {RoastedCarrot = 1, SlimeGel = 1},
    },
    PinkberryPie = {
        id = "PinkberryPie",
        workbenchTier = 2,
        output = "PinkberryPie",
        outputCount = 1,
        timeSeconds = 20,
        qualityEligible = false,
        stations = v10,
        inputs = {Bread = 1, BerryJam = 1, PinkSlimeGel = 1},
    },
    HeartySoup = {
        id = "HeartySoup",
        workbenchTier = 2,
        output = "HeartySoup",
        outputCount = 1,
        timeSeconds = 12,
        qualityEligible = false,
        stations = v10,
        inputs = {Tomato = 1, Onion = 1, PinkSlimeGel = 1},
    },
    RocketCarrot = {
        id = "RocketCarrot",
        workbenchTier = 2,
        output = "RocketCarrot",
        outputCount = 1,
        timeSeconds = 15,
        qualityEligible = false,
        stations = v10,
        inputs = {RoastedCarrot = 5, OrangeSlimeGel = 2},
    },
    Bluetato = {
        id = "Bluetato",
        workbenchTier = 2,
        output = "Bluetato",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v10,
        inputs = {Tomato = 1, BlueSlimeGel = 1},
    },
}
u672.Secret = {
    SlimeSoup = true,
    PinkberryPie = true,
    HeartySoup = true,
    RocketCarrot = true,
    Bluetato = true,
}

function u672.isSecret(a1) -- Line: 359; upvalues: u672 (val); types: a1: string?
    local v1 = false

    if a1 ~= nil then
        v1 = u672.Secret[a1] == true
    end

    return v1
end

u672.Torches = {
    Torch = {
        id = "Torch",
        workbenchTier = 1,
        output = "Torch",
        outputCount = 4,
        timeSeconds = 2,
        qualityEligible = false,
        stations = {"Workbench", "LightingBench"},
        inputs = {Wood = 1, Coal = 1},
    },
}
u672.Lighting = {
    Lantern = {
        id = "Lantern",
        workbenchTier = 2,
        output = "Lantern",
        outputCount = 1,
        timeSeconds = 12,
        qualityEligible = false,
        stations = v12,
        inputs = {IronIngot = 2, Glass = 2, Coal = 1},
    },
    WallLantern = {
        id = "WallLantern",
        workbenchTier = 2,
        output = "WallLantern",
        outputCount = 1,
        timeSeconds = 12,
        qualityEligible = false,
        stations = v12,
        inputs = {IronIngot = 2, Glass = 2, Coal = 1},
    },
}
u672.Structural = {
    WoodSlab = {
        id = "WoodSlab",
        workbenchTier = 2,
        output = "WoodSlab",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {WoodBlock = 1},
    },
    WoodStairs = {
        id = "WoodStairs",
        workbenchTier = 2,
        output = "WoodStairs",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {WoodBlock = 1},
    },
    StoneSlab = {
        id = "StoneSlab",
        workbenchTier = 2,
        output = "StoneSlab",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {StoneBlock = 1},
    },
    StoneStairs = {
        id = "StoneStairs",
        workbenchTier = 2,
        output = "StoneStairs",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {StoneBlock = 1},
    },
    StoneBrick = {
        id = "StoneBrick",
        workbenchTier = 2,
        output = "StoneBrick",
        outputCount = 1,
        timeSeconds = 4,
        qualityEligible = false,
        stations = v13,
        inputs = {StoneBlock = 1},
    },
    StoneBrickSlab = {
        id = "StoneBrickSlab",
        workbenchTier = 2,
        output = "StoneBrickSlab",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {StoneBrick = 1},
    },
    StoneBrickStairs = {
        id = "StoneBrickStairs",
        workbenchTier = 2,
        output = "StoneBrickStairs",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {StoneBrick = 1},
    },
    StoneBrickFence = {
        id = "StoneBrickFence",
        workbenchTier = 2,
        output = "StoneBrickFence",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {StoneBrick = 1},
    },
    IronSlab = {
        id = "IronSlab",
        workbenchTier = 2,
        output = "IronSlab",
        outputCount = 1,
        timeSeconds = 4,
        qualityEligible = false,
        stations = v13,
        inputs = {IronBlock = 1},
    },
    IronStairs = {
        id = "IronStairs",
        workbenchTier = 2,
        output = "IronStairs",
        outputCount = 1,
        timeSeconds = 4,
        qualityEligible = false,
        stations = v13,
        inputs = {IronBlock = 1},
    },
    BrickSlab = {
        id = "BrickSlab",
        workbenchTier = 2,
        output = "BrickSlab",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {BrickBlock = 1},
    },
    BrickStairs = {
        id = "BrickStairs",
        workbenchTier = 2,
        output = "BrickStairs",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {BrickBlock = 1},
    },
    CoalSlab = {
        id = "CoalSlab",
        workbenchTier = 2,
        output = "CoalSlab",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {CoalBlock = 1},
    },
    CoalStairs = {
        id = "CoalStairs",
        workbenchTier = 2,
        output = "CoalStairs",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {CoalBlock = 1},
    },
    SandSlab = {
        id = "SandSlab",
        workbenchTier = 2,
        output = "SandSlab",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {SandBlock = 1},
    },
    SandStairs = {
        id = "SandStairs",
        workbenchTier = 2,
        output = "SandStairs",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {SandBlock = 1},
    },
    GlassBlock = {
        id = "GlassBlock",
        workbenchTier = 2,
        output = "GlassBlock",
        outputCount = 1,
        timeSeconds = 4,
        qualityEligible = false,
        stations = v13,
        inputs = {Glass = 1},
    },
    GreenSlimeBlock = {
        id = "GreenSlimeBlock",
        workbenchTier = 2,
        output = "GreenSlimeBlock",
        outputCount = 1,
        timeSeconds = 2,
        qualityEligible = false,
        stations = v14,
        inputs = {SlimeGel = 4},
    },
    BlueSlimeBlock = {
        id = "BlueSlimeBlock",
        workbenchTier = 2,
        output = "BlueSlimeBlock",
        outputCount = 1,
        timeSeconds = 2,
        qualityEligible = false,
        stations = v14,
        inputs = {BlueSlimeGel = 4},
    },
    OrangeSlimeBlock = {
        id = "OrangeSlimeBlock",
        workbenchTier = 2,
        output = "OrangeSlimeBlock",
        outputCount = 1,
        timeSeconds = 2,
        qualityEligible = false,
        stations = v14,
        inputs = {OrangeSlimeGel = 4},
    },
    PinkSlimeBlock = {
        id = "PinkSlimeBlock",
        workbenchTier = 2,
        output = "PinkSlimeBlock",
        outputCount = 1,
        timeSeconds = 2,
        qualityEligible = false,
        stations = v14,
        inputs = {PinkSlimeGel = 4},
    },
    GlassPane = {
        id = "GlassPane",
        workbenchTier = 2,
        output = "GlassPane",
        outputCount = 1,
        timeSeconds = 3,
        qualityEligible = false,
        stations = v13,
        inputs = {Glass = 1},
    },
}
u672.Weapons = {
    WoodSword = {
        id = "WoodSword",
        workbenchTier = 1,
        output = "WoodSword",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v4,
        inputs = {Wood = 8},
    },
    StoneSword = {
        id = "StoneSword",
        workbenchTier = 1,
        output = "StoneSword",
        outputCount = 1,
        timeSeconds = 15,
        qualityEligible = true,
        stations = v5,
        inputs = {Stone = 10, Wood = 4},
    },
    IronSword = {
        id = "IronSword",
        workbenchTier = 2,
        output = "IronSword",
        outputCount = 1,
        timeSeconds = 90,
        qualityEligible = true,
        stations = v11,
        inputs = {IronIngot = 40, Wood = 12},
    },
}
u672.Machines = {
    CookingStation = {
        id = "CookingStation",
        workbenchTier = 2,
        output = "CookingStation",
        outputCount = 1,
        timeSeconds = 15,
        qualityEligible = false,
        stations = v4,
        inputs = {Stone = 20, Wood = 15},
    },
    Toolsmith = {
        id = "Toolsmith",
        workbenchTier = 2,
        output = "Toolsmith",
        outputCount = 1,
        timeSeconds = 20,
        qualityEligible = false,
        stations = v4,
        inputs = {Stone = 30, IronIngot = 15},
    },
    Composter = {
        id = "Composter",
        workbenchTier = 2,
        output = "Composter",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v4,
        inputs = {Wood = 50, Wheat = 10},
    },
    BuilderBench = {
        id = "BuilderBench",
        workbenchTier = 2,
        output = "BuilderBench",
        outputCount = 1,
        timeSeconds = 20,
        qualityEligible = false,
        stations = v4,
        inputs = {Wood = 40, Stone = 20},
    },
    LightingBench = {
        id = "LightingBench",
        workbenchTier = 2,
        output = "LightingBench",
        outputCount = 1,
        timeSeconds = 20,
        qualityEligible = false,
        stations = v4,
        inputs = {IronIngot = 10, Glass = 30},
    },
    Workbench = {
        id = "Workbench",
        workbenchTier = 1,
        output = "Workbench",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v5,
        inputs = {Wood = 20, Stone = 10},
    },
    GuestBook = {
        id = "GuestBook",
        workbenchTier = 2,
        output = "GuestBook",
        outputCount = 1,
        timeSeconds = 15,
        qualityEligible = false,
        stations = v4,
        inputs = {Wood = 20, Stone = 10},
    },
    StorageChest = {
        id = "StorageChest",
        workbenchTier = 1,
        output = "StorageChest",
        outputCount = 1,
        timeSeconds = 20,
        qualityEligible = false,
        stations = v4,
        inputs = {Wood = 25, IronIngot = 5},
    },
    WeaponDisplay = {
        id = "WeaponDisplay",
        workbenchTier = 1,
        output = "WeaponDisplay",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v4,
        inputs = {Wood = 10, IronIngot = 4},
    },
    WeaponStand = {
        id = "WeaponStand",
        workbenchTier = 2,
        output = "WeaponStand",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v4,
        inputs = {Wood = 10, IronIngot = 4},
    },
    ShinyTank = {
        id = "ShinyTank",
        workbenchTier = 2,
        output = "ShinyTank",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v13,
        inputs = {Glass = 6, Wood = 2},
    },
    FlowerPot = {
        id = "FlowerPot",
        workbenchTier = 2,
        output = "FlowerPot",
        outputCount = 1,
        timeSeconds = 5,
        qualityEligible = false,
        stations = v13,
        inputs = {Stone = 4},
    },
    LargeFlowerPot = {
        id = "LargeFlowerPot",
        workbenchTier = 2,
        output = "LargeFlowerPot",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v13,
        inputs = {Stone = 12},
    },
    PlateDisplay = {
        id = "PlateDisplay",
        workbenchTier = 2,
        output = "PlateDisplay",
        outputCount = 1,
        timeSeconds = 5,
        qualityEligible = false,
        stations = v13,
        inputs = {Clay = 15},
    },
    InputChest = {
        id = "InputChest",
        workbenchTier = 2,
        output = "InputChest",
        outputCount = 1,
        timeSeconds = 25,
        qualityEligible = false,
        stations = v6,
        inputs = {Wood = 30, IronIngot = 8},
    },
    OutputChest = {
        id = "OutputChest",
        workbenchTier = 2,
        output = "OutputChest",
        outputCount = 1,
        timeSeconds = 30,
        qualityEligible = false,
        stations = v6,
        inputs = {Wood = 30, IronIngot = 8},
    },
    LargeChest = {
        id = "LargeChest",
        workbenchTier = 2,
        output = "LargeChest",
        outputCount = 1,
        timeSeconds = 45,
        qualityEligible = false,
        stations = v6,
        inputs = {Wood = 80, IronIngot = 30},
    },
    OverflowChest = {
        id = "OverflowChest",
        workbenchTier = 2,
        output = "OverflowChest",
        outputCount = 1,
        timeSeconds = 45,
        qualityEligible = false,
        stations = v6,
        inputs = {Wood = 80, IronIngot = 38, SlimeGel = 1},
    },
    VendingMachine = {
        id = "VendingMachine",
        workbenchTier = 2,
        output = "VendingMachine",
        outputCount = 1,
        timeSeconds = 90,
        qualityEligible = false,
        stations = v6,
        inputs = {Gear = 60, Glass = 12, PinkSlimeGel = 4},
    },
    Furnace = {
        id = "Furnace",
        workbenchTier = 1,
        output = "Furnace",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = true,
        stations = v4,
        inputs = {Stone = 12, IronOre = 9},
    },
    WaterPump = {
        id = "WaterPump",
        workbenchTier = 2,
        output = "WaterPump",
        outputCount = 1,
        timeSeconds = 60,
        qualityEligible = true,
        stations = v6,
        inputs = {Gear = 16, PinkSlimeGel = 6},
    },
    IndustrialFurnace = {
        id = "IndustrialFurnace",
        workbenchTier = 2,
        output = "IndustrialFurnace",
        outputCount = 1,
        timeSeconds = 150,
        qualityEligible = true,
        stations = v6,
        inputs = {Gear = 30, BlueSlimeGel = 4},
    },
    Bakehouse = {
        id = "Bakehouse",
        workbenchTier = 2,
        output = "Bakehouse",
        outputCount = 1,
        timeSeconds = 120,
        qualityEligible = true,
        stations = v6,
        inputs = {IronIngot = 55, Gear = 6, Stone = 80},
    },
    BlockPress = {
        id = "BlockPress",
        workbenchTier = 2,
        output = "BlockPress",
        outputCount = 1,
        timeSeconds = 90,
        qualityEligible = false,
        stations = v6,
        inputs = {IronIngot = 45, Gear = 6, Stone = 60},
    },
    Conveyor = {
        id = "Conveyor",
        workbenchTier = 2,
        output = "Conveyor",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v6,
        inputs = {IronIngot = 8, SlimeGel = 1},
    },
    ConveyorCorner = {
        id = "ConveyorCorner",
        workbenchTier = 2,
        output = "ConveyorCorner",
        outputCount = 1,
        timeSeconds = 4,
        qualityEligible = false,
        stations = v6,
        inputs = {IronIngot = 8, SlimeGel = 1},
    },
    ConveyorCornerLeft = {
        id = "ConveyorCornerLeft",
        workbenchTier = 2,
        output = "ConveyorCornerLeft",
        outputCount = 1,
        timeSeconds = 4,
        qualityEligible = false,
        stations = v6,
        inputs = {IronIngot = 8, SlimeGel = 1},
    },
    ConveyorRampUp = {
        id = "ConveyorRampUp",
        workbenchTier = 2,
        output = "ConveyorRampUp",
        outputCount = 1,
        timeSeconds = 8,
        qualityEligible = false,
        stations = v6,
        inputs = {IronIngot = 14, SlimeGel = 1},
    },
    ConveyorRampDown = {
        id = "ConveyorRampDown",
        workbenchTier = 2,
        output = "ConveyorRampDown",
        outputCount = 1,
        timeSeconds = 8,
        qualityEligible = false,
        stations = v6,
        inputs = {IronIngot = 14, SlimeGel = 1},
    },
    Splitter = {
        id = "Splitter",
        workbenchTier = 2,
        output = "Splitter",
        outputCount = 1,
        timeSeconds = 10,
        qualityEligible = false,
        stations = v6,
        inputs = {IronIngot = 8, Gear = 2, SlimeGel = 1},
    },
    Fabricator = {
        id = "Fabricator",
        workbenchTier = 2,
        output = "Fabricator",
        outputCount = 1,
        timeSeconds = 180,
        qualityEligible = true,
        stations = v4,
        inputs = {Gear = 30, SlimeGel = 15},
    },
    Recycler = {
        id = "Recycler",
        workbenchTier = 2,
        output = "Recycler",
        outputCount = 1,
        timeSeconds = 180,
        qualityEligible = true,
        stations = v6,
        inputs = {Gear = 20, OrangeSlimeGel = 6},
    },
}
u672.Harvesters = {
    WoodHarvesterI = {
        id = "WoodHarvesterI",
        workbenchTier = 2,
        output = "WoodHarvesterI",
        outputCount = 1,
        timeSeconds = 90,
        qualityEligible = false,
        stations = v6,
        inputs = {Wood = 200, IronIngot = 20},
    },
}
u672.CropHarvesterIds = {}

for i, j in {"Wheat", "Carrot", "Tomato", "Onion"} do
    u672.CropHarvesterIds[(("%*Harvester"):format(j))] = true
end

u672.HarvesterMerges = {
    WoodHarvesterII = {
        id = "WoodHarvesterII",
        workbenchTier = 2,
        output = "WoodHarvesterII",
        outputCount = 1,
        timeSeconds = 60,
        qualityEligible = true,
        stations = v6,
        inputs = {WoodHarvesterI = 8},
    },
    StoneHarvesterII = {
        id = "StoneHarvesterII",
        workbenchTier = 2,
        output = "StoneHarvesterII",
        outputCount = 1,
        timeSeconds = 60,
        qualityEligible = true,
        stations = v6,
        inputs = {StoneHarvesterI = 8},
    },
    IronHarvesterII = {
        id = "IronHarvesterII",
        workbenchTier = 2,
        output = "IronHarvesterII",
        outputCount = 1,
        timeSeconds = 90,
        qualityEligible = true,
        stations = v6,
        inputs = {IronHarvesterI = 8},
    },
    WoodHarvesterIII = {
        id = "WoodHarvesterIII",
        workbenchTier = 2,
        output = "WoodHarvesterIII",
        outputCount = 1,
        timeSeconds = 180,
        qualityEligible = true,
        stations = v6,
        inputs = {WoodHarvesterII = 8},
    },
    StoneHarvesterIII = {
        id = "StoneHarvesterIII",
        workbenchTier = 2,
        output = "StoneHarvesterIII",
        outputCount = 1,
        timeSeconds = 180,
        qualityEligible = true,
        stations = v6,
        inputs = {StoneHarvesterII = 8},
    },
    IronHarvesterIII = {
        id = "IronHarvesterIII",
        workbenchTier = 2,
        output = "IronHarvesterIII",
        outputCount = 1,
        timeSeconds = 300,
        qualityEligible = true,
        stations = v6,
        inputs = {IronHarvesterII = 8},
    },
    CoalHarvesterII = {
        id = "CoalHarvesterII",
        workbenchTier = 2,
        output = "CoalHarvesterII",
        outputCount = 1,
        timeSeconds = 60,
        qualityEligible = true,
        stations = v6,
        inputs = {CoalHarvesterI = 8},
    },
    CoalHarvesterIII = {
        id = "CoalHarvesterIII",
        workbenchTier = 2,
        output = "CoalHarvesterIII",
        outputCount = 1,
        timeSeconds = 180,
        qualityEligible = true,
        stations = v6,
        inputs = {CoalHarvesterII = 8},
    },
}
u672.HarvesterIntervals = {
    Wood = {12, 6, 3},
    Stone = {14, 7, 3.5},
    IronOre = {20, 10, 5},
    Coal = {40, 20, 10},
    Sand = {14, 7, 3.5},
    Clay = {14, 7, 3.5},
}
u672.RecyclerReturnRate = 0.2
u672.RecyclerSecondsPerItem = 10
u672.Compost = {
    Machine = "Composter",
    Output = "Fertilizer",
    Threshold = 100,
    CompostSeconds = 2.5,
    SeedPoints = {
        WheatSeeds = 10,
        CarrotSeeds = 20,
        TomatoSeeds = 25,
        OnionSeeds = 40,
        BerryBushSeed = 50,
    },
    Fertilizer = {GrowthBoost = 0.25, DurationSeconds = 900, ReapplyBelowFraction = 0.5},
}

function u672.compostPoints(a1) -- Line: 832; upvalues: u672 (val); types: a1: table
    local v1 = 0

    for i, j in a1 do
        v1 = v1 + (u672.Compost.SeedPoints[i] or 0) * j
    end

    return v1
end

function u672.flattenCost(a1, a2) -- Line: 842; upvalues: u672 (val); types: a1: string, a2: table?
    local v1 = a2 or {}
    local v2 = {}
    local All = u672.All
    local v3 = All[a1]

    if v3 and not v1[a1] then
        local v4, v5, v6
        v1[a1] = true
        local v7 = nil
        local v8 = nil

        for i, j in v3.inputs, v7, v8 do
            v4 = All[i]

            if not v4 then
                v2[i] = (v2[i] or 0) + j
            else
                v5 = j / v4.outputCount

                for k, n in u672.flattenCost(i, v1) do
                    v6 = v2[k] or 0
                    v2[k] = v6 + n * v5
                end
            end
        end

        v1[a1] = nil

        return v2
    end

    v2[a1] = 1

    return v2
end

function u672.recyclerRefund(a1) -- Line: 888; upvalues: u672 (val); types: a1: string
    local v1, v2
    local v3 = {}

    for i, j in u672.flattenCost(a1) do
        v1 = j * u672.RecyclerReturnRate
        v2 = math.floor(v1)

        if math.random() < v1 - v2 then
            v2 = v2 + 1
        end

        if v2 > 0 then
            v3[i] = v2
        end
    end

    return v3
end

function u672.isRecyclable(a1) -- Line: 918; upvalues: u672 (val); types: a1: string
    if not u672.NeverRecyclable[a1] and not u672.AlwaysSoulbound[a1] then
        return u672.isUnique(a1)
    end

    return false
end

u672.DyeColors = {"Red", "Yellow", "Blue", "White", "Orange", "Pink", "Purple", "Green", "Sky", "Lime", "Black"}
u672.DyeSpecies = {"Daisy", "Lily", "Poppy", "Snapdragon", "Tulip"}
v14 = {"Glowing"}
local u365 = {"BuilderBench", "BlockPress"}
u672.Dyed = {}
u672.Families = {}
u672.InputGroups = {}

local function dyedFamily(a1, a2, a3, a4, a5)
    -- Line: 961
    -- upvalues: u672 (val), u365 (val)
    -- types: a1: string, a2: string, a3: string, a4: string, a5: table
    local v1, v2, v3
    local v4 = {}
    local v5 = {}
    local DyeSpecies = u672.DyeSpecies
    local v6 = nil
    local v7 = nil
    local v8, v9, v10, v11 = a4, a3, a2, a5

    for i, j in DyeSpecies, v6, v7 do
        for k, n in v11 do
            v1 = ("%*%*%*"):format(n, v12, j)
            v2 = ("%*From%*"):format(v10, v1)
            v3 = {
                workbenchTier = 2,
                outputCount = 1,
                timeSeconds = 2,
                qualityEligible = false,
                id = v2,
                stations = u365,
                inputs = {[v9] = 1, [v1] = 1},
                output = v10,
                family = v10,
            }
            u672.Dyed[v2] = v3

            table.insert(v4, v2)
            table.insert(v5, v1)
        end
    end

    table.sort(v4)
    table.sort(v5)

    u672.InputGroups[v8] = v5
    v5 = {
        workbenchTier = 2,
        outputCount = 1,
        timeSeconds = 2,
        qualityEligible = false,
        id = v10,
        stations = u365,
        inputs = {[v9] = 1, [v8] = 1},
        output = v10,
        variants = v4,
    }
    u672.Families[v10] = v5
end

for k, n in u672.DyeColors do
    v2 = ("%*ClayBlock"):format(n)
    v3 = ("Any%*Flower"):format(n)

    dyedFamily(
        n,
        v2,
        "ClayBlock",
        v3,
        {"", "Striped", "Dotted"}
    )

    v2 = ("%*NeonBlock"):format(n)
    v3 = ("AnyGlowing%*Flower"):format(n)

    dyedFamily(n, v2, "GlassBlock", v3, v14)
end

function u672.heldOf(a1, a2) -- Line: 989; upvalues: u672 (val); types: a1: table, a2: string
    local v1 = u672.InputGroups[a2]

    if not v1 then
        return a1[a2] or 0
    end

    local v2 = 0

    for i, j in v1 do
        v2 = v2 + (a1[j] or 0)
    end

    return v2
end

local u671 = {}
local v15 = {
    u672.Blocks,
    u672.Tools,
    u672.Utility,
    u672.Food,
    u672.Lighting,
    u672.Torches,
    u672.Structural,
    u672.Weapons,
    u672.Machines,
    u672.Harvesters,
    u672.HarvesterMerges,
    u672.Dyed,
}
local v16 = nil
local v17 = nil

for m, i5 in v15, v16, v17 do
    for i6, i7 in i5 do
        u671[i6] = i7
    end
end

u672.All = u671

function u672.forDisplay(a1) -- Line: 1027; upvalues: u671 (val), u672 (val); types: a1: string
    return u671[a1] or u672.Families[a1]
end

u672.BlockPressMakes = {
    "WoodBlock",
    "StoneBlock",
    "StoneBrick",
    "SandBlock",
    "ClayBlock",
    "CoalBlock",
    "GlassBlock",
    "IronBlock",
    "GreenSlimeBlock",
    "BlueSlimeBlock",
    "OrangeSlimeBlock",
    "PinkSlimeBlock",
}

for i8, i9 in u672.BlockPressMakes do
    v14 = u671[i9]

    if v14 and not table.find(v14.stations, "BlockPress") then
        v12 = table.clone(v14.stations)
        table.insert(v12, "BlockPress")

        v14.stations = v12
    end
end

local u670 = {}
v16 = nil
v17 = nil

for i10, i11 in u671, v16, v17 do
    v1 = nil
    v2 = nil

    for i12, i13 in i11.stations, v1, v2 do
        v10 = u670[i13]

        if not v10 then
            u670[i13] = {}
        end

        for i14 in i11.inputs do
            v10[i14] = true
        end
    end
end

u672.StationInputs = u670

function u672.stationAccepts(a1, a2) -- Line: 1090; upvalues: u670 (val); types: a1: string, a2: string
    local v1 = u670[a1]
    local v2 = false

    if v1 ~= nil then
        v2 = v1[a2] == true
    end

    return v2
end

function u672.stationAcceptsAtTier(a1, a2, a3)
    -- Line: 1105
    -- upvalues: u672 (val), u671 (val)
    -- types: a1: string, a2: string, a3: number
    if not u672.stationAccepts(a1, a2) then
        return false
    end

    for i, j in u671 do
        if j.workbenchTier <= a3
            and table.find(j.stations, a1)
            and j.inputs[a2] then
            return true
        end
    end

    return false
end

local u604 = {}
v9 = {}
v16 = nil
v17 = nil

for i15, i16 in u671, v16, v17 do
    if not u672.Secret[i16.output] then
        v8 = nil
        v7 = 0

        for i17 in i16.inputs do
            v7 = v7 + 1
            v8 = i17
        end

        v1 = nil
        v2 = nil

        for i18, i19 in i16.stations, v1, v2 do
            if v7 ~= 1 then
                v9[i19] = true
            elseif v8 ~= nil then
                v6 = u604[i19]

                if not v6 then
                    u604[i19] = {}
                end

                if not v6[v8] then
                    v6[v8] = i15
                else
                    v9[i19] = true
                end
            else
                v9[i19] = true
            end
        end
    end
end

for i20 in v9 do
    u604[i20] = nil
end

u672.Converters = u604

function u672.converterInputs(a1) -- Line: 1180; upvalues: u604 (val); types: a1: string
    return u604[a1]
end

u672.HarvesterIds = {
    WoodHarvesterI = true,
    WoodHarvesterII = true,
    WoodHarvesterIII = true,
    StoneHarvesterI = true,
    StoneHarvesterII = true,
    StoneHarvesterIII = true,
    IronHarvesterI = true,
    IronHarvesterII = true,
    IronHarvesterIII = true,
    CoalHarvesterI = true,
    CoalHarvesterII = true,
    CoalHarvesterIII = true,
    SandHarvesterI = true,
    ClayHarvesterI = true,
}
v5 = {}

for i21 in u672.HarvesterIds do
    v5[i21] = true
end

for i22 in u672.CropHarvesterIds do
    v5[i22] = true
end

u672.NeverRecyclable = v5
local u498 = {}

for i23, i24 in u672.All do
    if i24.qualityEligible then
        u498[i24.output] = true
    end
end

for i25, i26 in {} do
    u498[i26] = true
end

u672.AlwaysSoulbound = {
    Glowstick = true,
    Glowlight = true,
    CrimsonGlowlight = true,
    SunGlowlight = true,
    WaterBlock = true,
}

for i27 in u672.AlwaysSoulbound do
    u498[i27] = true
end

u672.UniqueItems = u498

function u672.isUnique(a1) -- Line: 1304; upvalues: u498 (val); types: a1: string
    return u498[a1] == true
end

u672.QueueMax = 10
u672.Recommended = {BelowTier = 2, Items = {Furnace = "Smelts Iron Ore into Iron Ingots"}}

return u672