-- Script path: game:GetService("ReplicatedStorage").Shared.Config.BuildConfig
-- Decompile time: 9.76 ms

local Blocks, Blocks_2, v1
local u0 = {
    Expansion = {
        {tier = 0, widthCells = 51, blockCapacity = 4000, coins = 0},
        {tier = 1, widthCells = 63, blockCapacity = 6000, coins = 10000},
        {tier = 2, widthCells = 79, blockCapacity = 8000, coins = 75000},
        {tier = 3, widthCells = 103, blockCapacity = 11000, coins = 500000},
        {tier = 4, widthCells = 127, blockCapacity = 14000, coins = 5000000},
        {tier = 5, widthCells = 151, blockCapacity = 17000, coins = 50000000},
        {tier = 6, widthCells = 175, blockCapacity = 20000, coins = 100000000},
        {tier = 7, widthCells = 199, blockCapacity = 25000, coins = 250000000},
    },
    MaxPlacedBlocks = 25000,
    VerticalBounds = {below = 40, above = 440},
}

function u0.boundsForTier(a1) -- Line: 47; upvalues: u0 (val); types: a1: number
    return {
        horizontal = (u0.Expansion[math.clamp(a1, 0, #u0.Expansion - 1) + 1].widthCells - 1)
            // 2,
        below = u0.VerticalBounds.below,
        above = u0.VerticalBounds.above,
    }
end

function u0.expansionForTier(a1) -- Line: 56; upvalues: u0 (val); types: a1: number
    return u0.Expansion[math.clamp(a1, 0, #u0.Expansion - 1) + 1]
end

u0.MaxExpansionTier = #u0.Expansion - 1
u0.MaxFunctionalEntities = 500
u0.MachineLimitExempt = {
    StorageChest = true,
    LargeChest = true,
    InputChest = true,
    OutputChest = true,
    OverflowChest = true,
    Splitter = true,
    VendingMachine = true,
    WeaponDisplay = true,
    WeaponStand = true,
    ShinyTank = true,
    FlowerPot = true,
    LargeFlowerPot = true,
    PlateDisplay = true,
}
u0.MaxHarvesters = 250
u0.VendingMachineId = "VendingMachine"
u0.LooseItemHardCap = 200
u0.LooseStackMax = 50
u0.LooseMerge = {
    AfterSeconds = 1,
    RestingSpeed = 0.75,
    TouchWidths = 2.5,
    IntervalSeconds = 0.5,
    GridStuds = 4,
}
u0.LooseAnchor = {
    AfterSeconds = 3,
    WakeStuds = 2.5,
    ProbeSeconds = 30,
    SupportCheckSeconds = 2,
    SupportStuds = 0.5,
}
u0.LooseItemStuds = 1.35
u0.LooseBlockStuds = 0.9

function u0.looseStudsFor(a1) -- Line: 173; upvalues: u0 (val); types: a1: string
    if u0.Blocks[a1] then
        return u0.LooseBlockStuds
    end

    return u0.LooseItemStuds
end

u0.PlayerDropHardCap = 50
u0.LooseFillAttributes = {World = "LooseItemsFill", PlayerDrops = "DroppedItemsFill"}
u0.LooseFillStep = 0.02
u0.LooseFillColors = {Yellow = 0.5, Orange = 0.75, Red = 1}

function u0.looseBudgetOf(a1) -- Line: 210; types: a1: string
    if a1 == "PlayerDropped" then
        return "PlayerDrops"
    end

    return "World"
end

function u0.looseCapFor(a1) -- Line: 214; upvalues: u0 (val); types: a1: string
    if a1 == "PlayerDrops" then
        return u0.PlayerDropHardCap
    end

    return u0.LooseItemHardCap
end

u0.CapPressure = {
    DespawnEligible = "All",
    DespawnOrder = "OldestFirst",
    UniqueItemsExempt = false,
    PauseProducers = false,
    AlertId = "ITEM_LIMIT_REACHED",
    ShowLiveCount = true,
    DespawnClassOrder = {"FactoryOutput", "HarvesterOutput", "PlayerDropped", "MonsterDrop"},
}
u0.LooseItemTTLSeconds = 300
u0.PlayerDropsExpire = false
u0.VoidKillPlaneDepthStuds = 150
u0.Pickup = {
    RadiusStuds = 14,
    AimConeDegrees = 22,
    TouchRadiusStuds = 7.5,
    TouchFrontBiasStuds = 3,
    ScanIntervalSeconds = 0.25,
    RepeatSeconds = 0.18,
    RequestBurst = 20,
    RequestsPerSecond = 10,
    CountLabelStuds = 8,
    CountLabelMax = 12,
}
u0.Blocks = {
    GrassBlock = {id = "GrassBlock", hp = 50, burns = false},
    DirtBlock = {id = "DirtBlock", hp = 50, burns = false, dropsAs = "GrassBlock"},
    Wood = {id = "Wood", hp = 75, burns = true, tilts = true},
    WoodBlock = {id = "WoodBlock", hp = 50, burns = true},
    StoneBlock = {id = "StoneBlock", hp = 75, burns = false},
    SandBlock = {id = "SandBlock", hp = 50, burns = false},
    ClayBlock = {id = "ClayBlock", hp = 75, burns = false},
    BrickBlock = {id = "BrickBlock", hp = 100, burns = false},
    CoalBlock = {id = "CoalBlock", hp = 75, burns = true},
    WoodFence = {id = "WoodFence", hp = 50, burns = true, shape = "Fence"},
    StoneBrickFence = {id = "StoneBrickFence", hp = 100, burns = false, shape = "Fence"},
    WoodFenceGate = {id = "WoodFenceGate", hp = 50, burns = true, shape = "Gate"},
    WoodTrapdoor = {id = "WoodTrapdoor", hp = 50, burns = true, shape = "Trapdoor"},
    WoodChair = {id = "WoodChair", hp = 50, burns = true, keepsGrass = true},
    WoodTable = {id = "WoodTable", hp = 50, burns = true, keepsGrass = true},
    WoodDoor = {id = "WoodDoor", hp = 50, burns = true, shape = "Door"},
    VaultDoor = {
        id = "VaultDoor",
        hp = 150,
        burns = false,
        shape = "Door",
        vault = true,
    },
    Sign = {id = "Sign", hp = 50, burns = true, shape = "Sign"},
    WaterPipe = {id = "WaterPipe", hp = 50, burns = false, shape = "Pipe"},
    WaterPipeCorner = {id = "WaterPipeCorner", hp = 50, burns = false, shape = "PipeCorner"},
    WaterSpout = {id = "WaterSpout", hp = 50, burns = false, shape = "Pipe"},
    Rail = {id = "Rail", hp = 50, burns = false, shape = "Rail"},
    RailCorner = {id = "RailCorner", hp = 50, burns = false, shape = "Rail"},
    RailRamp = {id = "RailRamp", hp = 50, burns = false, shape = "RailRamp"},
    RailBooster = {id = "RailBooster", hp = 50, burns = false, shape = "Rail"},
    RailRampBooster = {id = "RailRampBooster", hp = 50, burns = false, shape = "RailRamp"},
    IronBlock = {id = "IronBlock", hp = 150, burns = false},
    WaterBlock = {id = "WaterBlock", hp = 40, burns = false, walkThrough = true},
    FarmSoil = {id = "FarmSoil", hp = 50, burns = false, dropsAs = "GrassBlock"},
    Torch = {id = "Torch", hp = 15, burns = false, keepsGrass = true},
    Lantern = {id = "Lantern", hp = 25, burns = false, keepsGrass = true},
    WallLantern = {id = "WallLantern", hp = 25, burns = false, keepsGrass = true},
    WildGrass = {id = "WildGrass", hp = 5, burns = true, keepsGrass = true},
    WoodSlab = {id = "WoodSlab", hp = 50, burns = true, shape = "Slab"},
    WoodStairs = {id = "WoodStairs", hp = 50, burns = true, shape = "Stairs"},
    StoneSlab = {id = "StoneSlab", hp = 75, burns = false, shape = "Slab"},
    StoneStairs = {id = "StoneStairs", hp = 75, burns = false, shape = "Stairs"},
    StoneBrick = {id = "StoneBrick", hp = 100, burns = false},
    StoneBrickSlab = {id = "StoneBrickSlab", hp = 100, burns = false, shape = "Slab"},
    StoneBrickStairs = {id = "StoneBrickStairs", hp = 100, burns = false, shape = "Stairs"},
    IronSlab = {id = "IronSlab", hp = 150, burns = false, shape = "Slab"},
    IronStairs = {id = "IronStairs", hp = 150, burns = false, shape = "Stairs"},
    BrickSlab = {id = "BrickSlab", hp = 100, burns = false, shape = "Slab"},
    BrickStairs = {id = "BrickStairs", hp = 100, burns = false, shape = "Stairs"},
    CoalSlab = {id = "CoalSlab", hp = 75, burns = true, shape = "Slab"},
    CoalStairs = {id = "CoalStairs", hp = 75, burns = true, shape = "Stairs"},
    SandSlab = {id = "SandSlab", hp = 50, burns = false, shape = "Slab"},
    SandStairs = {id = "SandStairs", hp = 50, burns = false, shape = "Stairs"},
    GlassBlock = {id = "GlassBlock", hp = 50, burns = false},
    GlassPane = {id = "GlassPane", hp = 25, burns = false, shape = "Pane"},
    GreenSlimeBlock = {id = "GreenSlimeBlock", hp = 50, burns = false, bounceCells = 4},
    BlueSlimeBlock = {id = "BlueSlimeBlock", hp = 50, burns = false, bounceCells = 6},
    OrangeSlimeBlock = {id = "OrangeSlimeBlock", hp = 50, burns = false, bounceCells = 8},
    PinkSlimeBlock = {id = "PinkSlimeBlock", hp = 50, burns = false, bounceCells = 10},
}
u0.DyeColors = {"Red", "Yellow", "Blue", "White", "Orange", "Pink", "Purple", "Green", "Sky", "Lime", "Black"}

for i, j in u0.DyeColors do
    Blocks = u0.Blocks
    v1 = ("%*ClayBlock"):format(j)
    Blocks[v1] = {hp = 75, burns = false, id = ("%*ClayBlock"):format(j)}
    Blocks_2 = u0.Blocks
    v1 = ("%*NeonBlock"):format(j)
    Blocks_2[v1] = {hp = 50, burns = false, id = ("%*NeonBlock"):format(j)}
end

u0.Slime = {Restitution = 0.8, MaxBounceMultiplier = 2, MinImpactSpeed = 8}
u0.Placement = {
    PlaneLockEnabled = true,
    EdgeMarginFraction = 0.12,
    AllowDiagonal = true,
    BoundaryMessage = "Boundary reached: visit the Landman to expand",
    BoundaryAlertSeconds = 2,
    HubMessage = "You can't build at the Hub: build on an island",
    CooldownSeconds = 0.2,
    PredictSeconds = 4,
    ClientPaceMarginSeconds = 0.04,
    MaxQueuedSeconds = 1,
    SeedCooldownSeconds = 0.15,
    ArrivalSlackSeconds = 0.03,
    RequireAdjacency = true,
    SnapRadiusCells = 2,
}
u0.SignCommits = {Burst = 1, PerSecond = 0.5}

function u0.isProtectedCell(a1, a2, a3) -- Line: 651; upvalues: u0 (val); types: a1: number, a2: number, a3: number
    local v1

    for i, j in u0.ProtectedAnchors do
        v1 = u0.ProtectedVolumes[j.radiusKey]

        if v1
            and math.abs(a1 - j.x) <= v1
            and math.abs(a2 - j.y) <= v1
            and math.abs(a3 - j.z) <= v1 then
            return true
        end
    end

    return false
end

u0.BoundaryGuide = {HeightStuds = 24, ThicknessStuds = 0.5, Transparency = 0.82, FlashSeconds = 5}
u0.ProtectedVolumes = {}
u0.IslandRadiusCells = 14
u0.IslandTopCellY = -1
u0.HubPortalCell = {x = 15, y = 0, z = -6}
u0.SpawnSettledCellY = -1
u0.ProtectedAnchors = {}
u0.HeavyMachineHP = 150
u0.MachineHP = {
    Conveyor = 50,
    ConveyorCorner = 50,
    ConveyorCornerLeft = 50,
    ConveyorRampUp = 50,
    ConveyorRampDown = 50,
    StorageChest = 75,
    WeaponDisplay = 75,
    WeaponStand = 75,
    ShinyTank = 75,
    FlowerPot = 75,
    LargeFlowerPot = 75,
    PlateDisplay = 75,
    LargeChest = 75,
    InputChest = 75,
    OutputChest = 75,
}

function u0.machineHPOf(a1) -- Line: 790; upvalues: u0 (val); types: a1: string
    return u0.MachineHP[a1] or u0.HeavyMachineHP
end

u0.Footprints = {
    ConveyorRampUp = {x = 1, y = 1, z = 2},
    ConveyorRampDown = {x = 1, y = 1, z = 2},
    WoodDoor = {x = 1, y = 2, z = 1},
    VaultDoor = {x = 1, y = 2, z = 1},
    Workbench = {x = 2, y = 1, z = 1},
    CookingStation = {x = 2, y = 1, z = 1},
    BuilderBench = {x = 2, y = 1, z = 1},
    LightingBench = {x = 2, y = 1, z = 1},
    Toolsmith = {x = 2, y = 1, z = 1},
    Fabricator = {x = 2, y = 1, z = 1},
    Furnace = {x = 2, y = 1, z = 1},
    Recycler = {x = 2, y = 1, z = 1},
    VendingMachine = {x = 1, y = 3, z = 1},
}
u0.Shapes = {
    FencePostStuds = 0.9,
    FenceRailStuds = 0.4,
    GateStiles = 3,
    GateStileOverhangStuds = 0.2,
    TrapdoorThicknessStuds = 0.5,
    DoorThicknessStuds = 0.3,
    PaneThicknessStuds = 0.2,
    DoorOpenDegrees = 90,
    DoorKnobStuds = 0.35,
    DoorKnobInsetStuds = 0.4,
    DoorKnobHeightStuds = 2.7,
    DoorKnobMaterial = "Plastic",
    PipeStuds = 1.1,
    RailPlateStuds = 0.3,
    SignStakeStuds = 0.3,
    StairSteps = 2,
    FenceRailHeights = {0.85, -0.45},
    TrapdoorBattenStuds = {width = 0.35, proud = 0.12, inset = 0.75},
    DoorKnobColor = {r = 58, g = 60, b = 66},
    SignBoardStuds = {x = 2.6, y = 1.4, z = 0.2},
}
u0.Vault = {
    MinimumRole = "Builder",
    WindowHeightStuds = 4.4,
    Bars = 2,
    BarStuds = 0.07,
    Window = {x = 0.9, y = 0.36},
}

function u0.stairSteps(a1, a2, a3) -- Line: 942; upvalues: u0 (val); types: a1: number, a2: string?, a3: number?
    local v1, v2, v3
    local StairSteps = u0.Shapes.StairSteps
    local v4 = a1 / StairSteps
    local v5 = a3 or 1
    local v6 = {}
    local v7, v8 = a1, a2

    for i = 1, StairSteps do
        v1 = v7 - (i - 1) * v4
        v2 = -v7 / 2 + (i - 0.5) * v4

        if v8 ~= "Outer" then
            table.insert(
                v6,
                {
                    size = {x = v7, y = v4, z = v1},
                    offset = {x = 0, y = v2, z = v7 / 2 - v1 / 2},
                }
            )

            v3 = v7 - v1

            if v8 == "Inner" and v3 > 0 then
                table.insert(
                    v6,
                    {
                        size = {x = v1, y = v4, z = v3},
                        offset = {
                            x = v5 * (v7 / 2 - v1 / 2),
                            y = v2,
                            z = -v7 / 2 + v3 / 2,
                        },
                    }
                )
            end
        else
            table.insert(
                v6,
                {
                    size = {x = v1, y = v4, z = v1},
                    offset = {x = v5 * (v7 / 2 - v1 / 2), y = v2, z = v7 / 2 - v1 / 2},
                }
            )
        end
    end

    return v6
end

function u0.stairShape(a1, a2) -- Line: 1000; types: a1: table, a2: function
    local v1, v2

    local function across(a1_2) -- Line: 1001; upvalues: a1 (val); types: a1_2: table
        return a1_2.x * a1.x + a1_2.z * a1.z == 0
    end

    local function same(a1_2) -- Line: 1004; upvalues: a1 (val); types: a1_2: table?
        local v1 = false

        if a1_2 ~= nil then
            v1 = false

            if a1_2.x == a1.x then
                v1 = a1_2.z == a1.z
            end
        end

        return v1
    end

    local function sideOf(a1_2) -- Line: 1008; upvalues: a1 (val); types: a1_2: table
        if 0 < a1_2.x * a1.z - a1_2.z * a1.x then
            return 1
        end

        return -1
    end

    local v3 = a2(a1.x, a1.z)

    if v3 then
        v1 = v3.x * a1.x + v3.z * a1.z == 0

        if v1 then
            v2 = a2(-v3.x, -v3.z)
            v1 = false

            if v2 ~= nil then
                v1 = false

                if v2.x == a1.x then
                    v1 = v2.z == a1.z
                end
            end

            if not v1 then
                v1 = "Outer"

                if 0 < v3.x * a1.z - v3.z * a1.x then
                    return v1, 1
                end

                return v1, -1
            end
        end
    end

    v3 = a2(-a1.x, -a1.z)

    if v3 then
        v1 = v3.x * a1.x + v3.z * a1.z == 0

        if v1 then
            v2 = a2(v3.x, v3.z)
            v1 = false

            if v2 ~= nil then
                v1 = false

                if v2.x == a1.x then
                    v1 = v2.z == a1.z
                end
            end

            if not v1 then
                v1 = "Inner"

                if 0 < v3.x * a1.z - v3.z * a1.x then
                    return v1, 1
                end

                return v1, -1
            end
        end
    end

    return "Straight", 0
end

function u0.gateBars(a1) -- Line: 1027; upvalues: u0 (val); types: a1: number
    local Shapes = u0.Shapes
    local v1 = a1 / 3
    local v2 = Shapes.FenceRailStuds * v1
    local v3 = {}
    local v4 = (1 / 0)
    local v5 = (-1 / 0)

    for i, j in Shapes.FenceRailHeights do
        table.insert(
            v3,
            {size = {x = a1, y = v2, z = v2}, offset = {x = 0, z = 0, y = j * v1}}
        )

        v4 = math.min(v4, j * v1)
        v5 = math.max(v5, j * v1)
    end

    local v6 = Shapes.GateStileOverhangStuds * v1
    v1 = v4 - v2 / 2 - v6
    v4 = v5 + v2 / 2 + v6
    local v7 = Shapes.GateStiles - 1

    for k = 0, v7 do
        v6 = -a1 / 2 + v2 / 2
            + k * (a1 - v2) / (math.max(Shapes.GateStiles - 1, 1))
        table.insert(
            v3,
            {
                size = {x = v2, y = v4 - v1, z = v2},
                offset = {z = 0, x = v6, y = (v4 + v1) / 2},
            }
        )
    end

    return v3
end

function u0.shapeSize(a1, a2) -- Line: 1068; upvalues: u0 (val); types: a1: string?, a2: number
    local v1
    local Shapes = u0.Shapes

    if a1 == "Slab" then
        return {x = a2, y = a2 / 2, z = a2}
    end

    if a1 == "Pane" then
        return {x = a2, y = a2, z = Shapes.PaneThicknessStuds / 3 * a2}
    end

    if a1 == "Fence" then
        v1 = Shapes.FencePostStuds / 3 * a2
        return {x = v1, y = a2, z = v1}
    end

    if a1 == "Gate" then
        return {x = a2, y = a2, z = Shapes.FenceRailStuds / 3 * a2}
    end

    if a1 == "Trapdoor" then
        return {x = a2, y = Shapes.TrapdoorThicknessStuds / 3 * a2, z = a2}
    end

    if a1 == "Door" then
        return {x = a2, y = a2 * 2, z = Shapes.DoorThicknessStuds / 3 * a2}
    end

    if a1 == "Sign" then
        local SignBoardStuds = Shapes.SignBoardStuds
        return {
            x = SignBoardStuds.x / 3 * a2,
            y = SignBoardStuds.y / 3 * a2,
            z = SignBoardStuds.z / 3 * a2,
        }
    end

    if a1 == "Pipe" then
        v1 = Shapes.PipeStuds / 3 * a2
        return {x = v1, y = v1, z = a2}
    end

    if a1 == "PipeCorner" then
        v1 = Shapes.PipeStuds / 3 * a2
        return {x = v1, y = v1, z = v1}
    end

    if a1 == "Rail" then
        return {x = a2, y = Shapes.RailPlateStuds / 3 * a2, z = a2}
    end

    return {x = a2, y = a2, z = a2}
end

function u0.shapePieces(a1, a2) -- Line: 1100; upvalues: u0 (val); types: a1: string?, a2: number
    if a1 == "Stairs" then
        return u0.stairSteps(a2)
    end

    if a1 == "Gate" then
        return u0.gateBars(a2)
    end

    return nil
end

local u164 = {x = 1, y = 1, z = 1}

function u0.tilts(a1) -- Line: 1121; upvalues: u0 (val); types: a1: string?
    local v1 = if not a1 then nil else u0.Blocks[a1]
    local v2 = false

    if v1 ~= nil then
        v2 = true

        if v1.tilts ~= true then
            v2 = v1.shape == "Slab"
        end
    end

    return v2
end

u0.TiltRadians = 1.5707963267948966

function u0.footprintOf(a1) -- Line: 1131; upvalues: u0 (val), u164 (val); types: a1: string
    return u0.Footprints[a1] or u164
end

u0.Plantables = {TreeSapling = {node = "Tree", growthSeconds = 90}}
u0.Fillables = {Bucket = {fromBlock = "WaterBlock", becomes = "WaterBucket"}}
u0.Containers = {WaterBucket = {places = "WaterBlock", empties = "Bucket"}}
u0.WellSourceBlock = "WaterBlock"
u0.Converters = {Plow = {from = {GrassBlock = "FarmSoil", FarmSoil = "GrassBlock"}}}
u0.Farm = {
    HydrationRadiusCells = 3,
    HighlightFloorCells = 1,
    WaterTintRadiusCells = 12,
    WaterMinHeightFraction = 0.2,
    WaterUses = 24,
    RainRefillSeconds = 15,
    WateringCan = {ItemId = "WateringCan", Uses = 10, WetSeconds = 600},
}

function u0.breakDropOf(a1) -- Line: 1252; upvalues: u0 (val); types: a1: string
    local v1 = u0.Blocks[a1]

    if v1 and v1.dropsAs then
        return v1.dropsAs
    end

    return a1
end

function u0.conversionFor(a1, a2) -- Line: 1258; upvalues: u0 (val); types: a1: string, a2: string?
    local v1 = u0.Converters[a1]

    if v1 and a2 then
        return v1.from[a2]
    end

    return nil
end

function u0.blockNeedsContainer(a1) -- Line: 1268; upvalues: u0 (val); types: a1: string?
    if not a1 then
        return false
    end

    for i, j in u0.Fillables do
        if j.fromBlock == a1 then
            return true
        end
    end

    return false
end

function u0.worldOnly(a1) -- Line: 1284; upvalues: u0 (val); types: a1: string?
    if u0.blockNeedsContainer(a1) then
        return true
    end

    local v1 = if not a1 then nil else u0.Blocks[a1]
    local v2 = false

    if v1 ~= nil then
        v2 = false

        if v1.dropsAs ~= nil then
            v2 = v1.dropsAs ~= a1
        end
    end

    return v2
end

function u0.containerForBlock(a1) -- Line: 1293; upvalues: u0 (val); types: a1: string?
    if not a1 then
        return nil
    end

    for i, j in u0.Fillables do
        if j.fromBlock == a1 then
            return i
        end
    end

    return nil
end

local v2 = {requiresSupport = false, supportMustBeStructural = false}
local v3 = {requiresSupport = true, supportMustBeStructural = true}
u0.PlacementRuleDefaults = {Block = v2, Machine = v3}
u0.PlacementRuleOverrides = {
    Conveyor = v2,
    ConveyorCorner = v2,
    ConveyorCornerLeft = v2,
    ConveyorRampUp = v2,
    ConveyorRampDown = v2,
    TreeSapling = v3,
    WaterBlock = v3,
}
u0.MayFloatWhenUndermined = {StorageChest = true, LargeChest = true, WaterBlock = true}

function u0.placementRuleFor(a1, a2) -- Line: 1363; upvalues: u0 (val); types: a1: string, a2: boolean
    local v1 = u0.PlacementRuleOverrides[a1]

    if v1 then
        return v1
    end

    if a2 then
        return u0.PlacementRuleDefaults.Machine
    end

    return u0.PlacementRuleDefaults.Block
end

return u0