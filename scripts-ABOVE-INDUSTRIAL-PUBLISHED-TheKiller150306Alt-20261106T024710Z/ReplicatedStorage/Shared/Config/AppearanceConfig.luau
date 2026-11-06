-- Script path: game:GetService("ReplicatedStorage").Shared.Config.AppearanceConfig
-- Decompile time: 3.63 ms

local u0 = {}
local u1 = {kind = "Block"}
u0.VariantTextures = {
    Bricks = "rbxassetid://106200706458262",
    Clay = "rbxassetid://107823871143321",
    CoalBricks = "rbxassetid://129817175256044",
    Dirt = "rbxassetid://78018409280531",
    GrassTop = "rbxassetid://87602011276499",
    IronBlock = "rbxassetid://73518422683453",
    LogEnd = "rbxassetid://140447507323220",
    LogSide = "rbxassetid://116516357592564",
    Sand = "rbxassetid://74548838917674",
    Stone = "rbxassetid://78884878204110",
    StoneBricks = "rbxassetid://77234319531242",
    Soil = "rbxassetid://133579261742830",
    WoodPlank = "rbxassetid://136679036519999",
    SlimeBlock = "rbxassetid://99946544587972",
}
u0.Of = {
    GrassBlock = {
        kind = "Block",
        variant = "Dirt",
        cap = {
            variant = "PixelGrass",
            colorId = "GrassCap",
            heightStuds = 0.3,
            materialName = "SmoothPlastic",
        },
    },
    DirtBlock = {kind = "Block", variant = "Dirt"},
    StoneBlock = {kind = "Block", variant = "Stone"},
    Wood = {
        kind = "Block",
        variant = "LogSide",
        cap = {
            variant = "LogEnd",
            colorId = "WoodEnd",
            heightStuds = 0.1,
            materialName = "Plastic",
            bothEnds = true,
        },
    },
    WoodBlock = {kind = "Block", variant = "WoodPlank"},
    Coal = {kind = "Mesh", category = "Resources", prefab = "CoalItem"},
    IronOre = {kind = "Mesh", category = "Resources", prefab = "IronOreItem"},
    Stone = {kind = "Mesh", category = "Resources", prefab = "StoneItem"},
    Sand = {kind = "Mesh", category = "Resources", prefab = "SandItem"},
    Clay = {kind = "Mesh", category = "Resources", prefab = "ClayItem"},
    Bucket = {kind = "Model", category = "Tools", hideParts = {"WaterPart"}},
    WaterPump = {kind = "Model", category = "World"},
    Composter = {kind = "Model", category = "World"},
    WaterPipe = {kind = "Model", category = "World", hideParts = {"Spigot"}},
    WaterPipeCorner = {kind = "Model", category = "World", hideParts = {"Spigot"}},
    WaterSpout = {kind = "Model", category = "World"},
    Rail = {kind = "Model", category = "World"},
    RailCorner = {kind = "Model", category = "World"},
    RailRamp = {kind = "Model", category = "World"},
    RailBooster = {kind = "Model", category = "World"},
    RailRampBooster = {kind = "Model", category = "World"},
    Minecart = {kind = "Model", category = "World", prefab = "Railcart"},
    IronRailcart = {kind = "Model", category = "World"},
    WaterBucket = {kind = "Model", category = "Tools", prefab = "Bucket"},
    TreeSapling = {kind = "Model", category = "Resources", prefab = "TreeSapling"},
    SandBlock = {kind = "Block", variant = "Sand"},
    ClayBlock = {kind = "Block", variant = "Clay"},
    BrickBlock = {kind = "Block", variant = "Bricks"},
    CoalBlock = {kind = "Block", variant = "CoalBricks"},
    IronBlock = {kind = "Block", variant = "IronBlock"},
    IronSlab = {kind = "Block", variant = "IronBlock"},
    IronStairs = {kind = "Block", variant = "IronBlock"},
    StoneBrick = {kind = "Block", variant = "StoneBricks"},
    WoodSlab = {kind = "Block", variant = "WoodPlank"},
    WoodStairs = {kind = "Block", variant = "WoodPlank"},
    WoodFence = {kind = "Block", variant = "WoodPlank"},
    WoodFenceGate = {kind = "Block", variant = "WoodPlank"},
    WoodTrapdoor = {kind = "Block", variant = "WoodPlank"},
    WoodChair = {kind = "Model", category = "World"},
    WoodTable = {kind = "Model", category = "World"},
    GreenSlimeBlock = {kind = "Block", variant = "SlimeBlock"},
    BlueSlimeBlock = {kind = "Block", variant = "SlimeBlock"},
    OrangeSlimeBlock = {kind = "Block", variant = "SlimeBlock"},
    PinkSlimeBlock = {kind = "Block", variant = "SlimeBlock"},
    WoodDoor = {kind = "Block", variant = "WoodPlank"},
    VaultDoor = {kind = "Block", variant = "IronBlock"},
    Sign = {kind = "Block", variant = "WoodPlank"},
    StoneSlab = {kind = "Block", variant = "Stone"},
    StoneStairs = {kind = "Block", variant = "Stone"},
    StoneBrickSlab = {kind = "Block", variant = "StoneBricks"},
    StoneBrickStairs = {kind = "Block", variant = "StoneBricks"},
    BrickSlab = {kind = "Block", variant = "Bricks"},
    BrickStairs = {kind = "Block", variant = "Bricks"},
    CoalSlab = {kind = "Block", variant = "CoalBricks"},
    CoalStairs = {kind = "Block", variant = "CoalBricks"},
    SandSlab = {kind = "Block", variant = "Sand"},
    SandStairs = {kind = "Block", variant = "Sand"},
    StoneBrickFence = {kind = "Block", variant = "StoneBricks"},
    FarmSoil = {kind = "Block", variant = "Soil"},
    Torch = {kind = "Model", category = "World", wallPrefab = "Torch_Wall"},
    Lantern = {kind = "Model", category = "World", light = {rangeStuds = 24, brightness = 2}},
    WallLantern = {kind = "Model", category = "World", light = {rangeStuds = 15, brightness = 1.4}},
    WildGrass = {kind = "Model", category = "World"},
    Dough = {kind = "Mesh", category = "Resources"},
    Bread = {kind = "Mesh", category = "Resources"},
    GoldenDough = {kind = "Mesh", category = "Resources", prefab = "Dough", tintParts = {"*"}},
    GoldenBread = {kind = "Mesh", category = "Resources"},
}

for i, j in {"Red", "Yellow", "Blue", "White", "Orange", "Pink", "Purple", "Green", "Sky", "Lime", "Black"} do
    u0.Of[(("%*ClayBlock"):format(j))] = {kind = "Block", variant = "Clay"}
    u0.Of[(("%*NeonBlock"):format(j))] = {kind = "Block"}
end

function u0.hiddenPartsFor(a1) -- Line: 421; upvalues: u0 (val); types: a1: string
    return u0.of(a1).hideParts
end

function u0.tintedPartsFor(a1) -- Line: 426; upvalues: u0 (val); types: a1: string
    return u0.of(a1).tintParts
end

function u0.lightFor(a1) -- Line: 431; upvalues: u0 (val); types: a1: string
    return u0.of(a1).light
end

function u0.of(a1) -- Line: 436; upvalues: u0 (val), u1 (val); types: a1: string
    return u0.Of[a1] or u1
end

function u0.isPrefabKind(a1) -- Line: 441; types: a1: string
    local v1 = true

    if a1 ~= "Mesh" then
        v1 = a1 == "Model"
    end

    return v1
end

function u0.prefabFor(a1, a2) -- Line: 447; upvalues: u0 (val); types: a1: string, a2: boolean?
    local v1 = u0.of(a1)

    if not u0.isPrefabKind(v1.kind) then
        return nil, nil
    end

    if a2 and v1.wallPrefab then
        return v1.category, v1.wallPrefab
    end

    return v1.category, v1.prefab or a1
end

function u0.isMountable(a1) -- Line: 464; upvalues: u0 (val); types: a1: string
    return u0.of(a1).wallPrefab ~= nil
end

u0.MaxTextGrowth = 1
u0.HealthPulse = {BelowFraction = 0.4, PeriodSeconds = 0.9, Strength = 0.45}
u0.LowHealthVignette = {
    BelowHp = 50,
    MinAlpha = 0.2,
    MaxAlpha = 0.6,
    EdgeFraction = 0.3,
    Color = {r = 150, g = 10, b = 16},
}
u0.HitFlash = {Alpha = 0.35, Seconds = 0.45}
u0.EnemyHealthBar = {MaxDistanceStuds = 60}
u0.Weather = {
    TransitionSeconds = 5,
    Clouds = {
        Clear = {cover = 0.5, density = 1, color = {r = 217, g = 246, b = 255}},
        Rain = {cover = 0.92, density = 0.72, color = {r = 128, g = 134, b = 146}},
        Windy = {cover = 0.65, density = 0.4, color = {r = 215, g = 220, b = 230}},
        Scorching = {cover = 0.1, density = 0.12, color = {r = 255, g = 250, b = 240}},
    },
    Rain = {
        Rate = 320,
        TouchRate = 120,
        CoverStuds = 120,
        AreaStuds = 90,
        HeightStuds = 28,
        SpeedStuds = 55,
        LifetimeSeconds = 1.1,
        DropSize = 0.18,
        Squash = -4,
        Transparency = 0.4,
        Color = {r = 200, g = 214, b = 236},
    },
    Splashes = {
        PerFrame = 8,
        TouchPerFrame = 2,
        RadiusStuds = 26,
        RayHeightStuds = 24,
        PoolSize = 32,
        LifetimeSeconds = 0.35,
        RiseStudsPerSecond = 0.02,
        StartSize = 0.25,
        EndSize = 1.1,
        Transparency = 0.35,
        Color = {r = 214, g = 226, b = 244},
    },
    Wind = {
        Rate = 70,
        TouchRate = 24,
        AreaStuds = 90,
        DepthStuds = 36,
        SpeedStuds = 18,
        LifetimeSeconds = 3.2,
        StreakSize = 0.6,
        Squash = -8,
        Transparency = 0.5,
        Color = {r = 236, g = 240, b = 248},
    },
    Sun = {
        Clear = {angularSize = 11, rays = 0.04, spread = 0.1},
        Rain = {angularSize = 11, rays = 0, spread = 0.6},
        Windy = {angularSize = 11, rays = 0.04, spread = 0.1},
        Scorching = {angularSize = 21, rays = 0.4, spread = 0},
    },
    Grade = {
        Rain = {Saturation = -0.3, Contrast = -0.06, Brightness = -0.05, Tint = {r = 186, g = 204, b = 240}},
        Scorching = {Saturation = 0.12, Contrast = 0.08, Brightness = 0.06, Tint = {r = 255, g = 226, b = 190}},
    },
}
u0.Panel = {Enabled = false, OpenSeconds = 0.12, FromScale = 0.94, RisePixels = 12}
u0.Camera = {
    UiFovBonus = 8,
    OpenSeconds = 0.14,
    CloseSeconds = 0.09,
    UiBlurSize = 6,
    SprintFovBonus = 6,
    SprintFovSeconds = 0.25,
    FaceForwardAfterStuds = 40,
    FaceForwardBackStuds = 10,
    FaceForwardUpStuds = 3,
}
u0.GatherFx = {
    CountPerItem = 5,
    MaxCount = 14,
    MaxOnScreen = 60,
    SizePixels = 7,
    Seconds = 0.52,
    SpreadPixels = 22,
    DriftPixels = 70,
    StaggerSeconds = 0.12,
    ArriveScale = 0.35,
    Colors = {
        Wheat = {r = 240, g = 205, b = 90},
        Coal = {r = 120, g = 120, b = 128},
        IronOre = {r = 215, g = 180, b = 150},
        Stone = {r = 200, g = 200, b = 205},
        Wood = {r = 190, g = 140, b = 85},
        SlimeGel = {r = 130, g = 235, b = 145},
    },
}
u0.BreakFx = {
    Count = 10,
    SizeStuds = 0.35,
    SpeedStuds = 20,
    UpwardMinStuds = 10,
    UpwardStuds = 22,
    Seconds = 0.9,
    CollectDelaySeconds = 0.22,
    MaxDistanceStuds = 220,
}
u0.Floaters = {
    Seconds = 0.9,
    RisePixels = 64,
    DriftPixels = 34,
    TextSize = 20,
    MaxOnScreen = 24,
    GainColor = {r = 236, g = 240, b = 248},
    DamageColor = {r = 255, g = 168, b = 120},
    CritColor = {r = 255, g = 222, b = 92},
    CoinColor = {r = 255, g = 214, b = 110},
}
u0.Backpack = {
    DragHoldSeconds = 0.18,
    DragThresholdPixels = 6,
    ArrangeSaveSeconds = 1.5,
    ArrangeMaxCells = 2400,
    ArrangeMaxEntries = 1500,
}
u0.Travel = {
    OutSeconds = 0.45,
    HoldSeconds = 0.22,
    InSeconds = 0.35,
    MaxLoadHoldSeconds = 10,
    ArrivedStuds = 50,
    GroundCheckStuds = 12,
    ZoomFraction = 0.94,
}
u0.Kinds = {"Block", "Mesh", "Model"}
u0.FontFamily = "rbxasset://fonts/families/Ubuntu.json"
u0.IntakePartName = "Intake"
u0.OutputPartName = "Output"
u0.WorkVfxAttachment = "Attachment"
u0.WorkLightPart = "Spotlight"
u0.ArtYawDegrees = {
    CookingStation = 180,
    BuilderBench = 180,
    LightingBench = 180,
    Toolsmith = 180,
    Furnace = 180,
}
u0.ArtOffsetStuds = {Recycler = {x = 1.04, y = 0, z = 0}}
u0.CompostArt = {HeapPart = "Compost", MinHeightStuds = 0.1, Indicators = {20, 40, 60, 80, 100}, LitRgb = {83, 132, 76}}
u0.FillGauges = {OverflowChest = {Indicators = {"1", "2", "3", "4", "5"}, LitRgb = {255, 132, 24}}}
u0.RevealTransparencyAttribute = "RevealTransparency"
u0.PressStrokes = {
    BlockPress = {
        Model = "Hydraulic",
        Studs = 0.95,
        DownSeconds = 0.12,
        HoldSeconds = 0.3,
        UpSeconds = 0.6,
        Sound = "PressClank",
        SoundLeadSeconds = 0.03,
        Reveal = "FAKEBLOCK",
    },
}
u0.PressStrokeTag = "AbovePressStroke"
u0.PressStrokeAttribute = "PressStrokes"

function u0.pressStrokeSeconds(a1) -- Line: 1098; upvalues: u0 (val); types: a1: string
    local v1 = u0.PressStrokes[a1]

    if not v1 then
        return 0
    end

    return v1.DownSeconds + v1.HoldSeconds + v1.UpSeconds
end

u0.MotionStuds = 100
u0.MotionCheckSeconds = 0.5
u0.SpinningParts = {
    Drill = {speed = 200, whileWorking = true},
    Blades = {speed = 360, whileWorking = true},
    Blade = {speed = 240, whileWorking = true},
    ["Inside Gear Rotate R"] = {speed = -120, axis = "Z", whileWorking = true},
    ["Shredder Gear Rotate L"] = {speed = 240, axis = "Z", whileWorking = true},
    ["Shredder Gear Rotate R"] = {speed = -240, axis = "Z", whileWorking = true},
    Object = {speed = 40, axis = "Y", hover = {studs = 0.3, seconds = 2.8}},
}
u0.PollenPartName = "Pollen"
u0.WateringCanWaterPart = "WaterPart"
u0.ActiveLook = {
    IndustrialFurnace = {partName = "HotPlate", active = {transparency = 0}, idle = {transparency = 1}},
    Furnace = {
        partName = "LavaBlock",
        active = {material = "Neon", color = {255, 97, 65}},
        idle = {material = "SmoothPlastic", color = {20, 20, 20}},
    },
    Bakehouse = {
        partName = "HotPlate",
        active = {material = "Neon", color = {255, 97, 65}},
        idle = {material = "Plastic", color = {26, 26, 26}},
    },
}
u0.Icons = {
    Shop = "rbxassetid://104831984032150",
    Backpack = "rbxassetid://118779877903614",
    Collections = "rbxassetid://70894091622997",
    Achievements = "rbxassetid://81464234999367",
    Settings = "rbxassetid://127263561746400",
    Islands = "rbxassetid://102761900848398",
    Published = "rbxassetid://71839230276612",
    People = "rbxassetid://129759718001332",
    Teleport = "rbxassetid://121444205509793",
    Coins = "rbxassetid://136718789184071",
    Blocks = "rbxassetid://117767885984586",
    Weather = "rbxassetid://72595373985414",
}
u0.Viewmodel = {firstPersonStuds = 1, offset = {x = 0.15, y = 0.55, z = -0.7}}

return u0