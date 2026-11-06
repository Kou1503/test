-- Script path: game:GetService("ReplicatedStorage").Shared.Config.FactoryConfig
-- Decompile time: 2.39 ms

local u0 = {
    Conveyor = {
        SpeedStudsPerSecond = 4,
        MinItemSpacingStuds = 1.5,
        ItemsCanFallOff = true,
        HeightStuds = 0.7,
        SurfacePartName = "Mover",
        ColliderPartName = "Collider",
        IntakeRadiusStuds = 3.4,
        NeighbourCacheSeconds = 0.5,
        ItemIndexScanAllAtMost = 200,
        IntakeReachStuds = 1,
        IntakeSideToleranceStuds = 1,
        SurfaceFriction = 2,
        SurfaceFrictionWeight = 100,
        CornerTurnRadiusStuds = 0.1,
        LaneWidthStuds = 2.5,
        LaneCenteringPerSecond = 9,
        LaneDampingPerSecond = 6,
        LaneDeadbandStuds = 0.15,
        LaneDriftDeadbandStudsPerSecond = 0.3,
        LaneKeepIntervalSeconds = 0.05,
        RampOverlapStuds = 0.8,
        OutputClearanceStuds = 1.2,
        OutputPushStuds = 4,
        OutputStackStuds = 1.5,
        OutputLiftStuds = 1.5,
        LooseItemPhysics = {
            density = 0.7,
            friction = 0.4,
            elasticity = 0.1,
            frictionWeight = 1,
            elasticityWeight = 1,
        },
    },
    ConveyorKinds = {
        Conveyor = {turnDegrees = 0, risePerCell = 0, runCells = 1, batch = 1},
        ConveyorCorner = {
            turnDegrees = 180,
            isCorner = true,
            intakeSide = 1,
            risePerCell = 0,
            runCells = 1,
            batch = 1,
        },
        ConveyorCornerLeft = {
            turnDegrees = 180,
            isCorner = true,
            intakeSide = -1,
            risePerCell = 0,
            runCells = 1,
            batch = 1,
        },
        ConveyorRampUp = {turnDegrees = 0, risePerCell = 1, runCells = 2, batch = 1},
        ConveyorRampDown = {turnDegrees = 0, risePerCell = -1, runCells = 2, batch = 1},
    },
    ConveyorRampSpeedMultiplier = 1.6,
}

function u0.conveyorKind(a1) -- Line: 326; upvalues: u0 (val); types: a1: string?
    if a1 then
        return u0.ConveyorKinds[a1]
    end

    return nil
end

function u0.headingFrom(a1) -- Line: 335; types: a1: number
    local v1 = math.rad(a1)
    return (Vector3.new(math.sin(v1), 0, (math.cos(v1))))
end

function u0.conveyorVelocity(a1, a2) -- Line: 347; upvalues: u0 (val); types: a1: string?, a2: number
    local SpeedStudsPerSecond = u0.Conveyor.SpeedStudsPerSecond
    local v1 = u0.conveyorKind(a1)

    if not v1 then
        return u0.headingFrom(a2) * SpeedStudsPerSecond
    end

    local v2 = u0.headingFrom(a2 + v1.turnDegrees)

    if v1.risePerCell == 0 then
        return v2 * SpeedStudsPerSecond
    end

    local v3 = if not (0 < v1.risePerCell) then -1 else 1

    return (v2 * v1.runCells + Vector3.new(0, v3, 0)).Unit * SpeedStudsPerSecond
        * u0.ConveyorRampSpeedMultiplier
end

function u0.conveyorIntakeDirection(a1, a2) -- Line: 384; upvalues: u0 (val); types: a1: string?, a2: number
    local v1 = u0.conveyorKind(a1)

    if v1 and v1.isCorner then
        local v2 = u0.conveyorVelocity(a1, a2)
        local v3 = Vector3.new(v2.X, 0, v2.Z)

        if v3.Magnitude < 0.01 then
            return nil
        end

        return (v3.Unit:Cross((Vector3.new(0, 1, 0)))) * (v1.intakeSide or 1)
    end

    return nil
end

function u0.cornerRotationFacing(a1, a2) -- Line: 404; upvalues: u0 (val); types: a1: string?, a2: vector
    local v1 = Vector3.new(a2.X, 0, a2.Z)

    if v1.Magnitude < 0.01 then
        return nil
    end

    for i, j in {0, 90, 180, 270} do
        v1 = u0.conveyorIntakeDirection(a1, j)

        if v1 and 0.9 < (v1:Dot(v1.Unit)) then
            return j
        end
    end

    return nil
end

function u0.conveyorPitch(a1) -- Line: 422; upvalues: u0 (val); types: a1: string?
    local v1 = u0.conveyorKind(a1)

    if v1 and v1.risePerCell ~= 0 then
        return -math.atan2(v1.risePerCell, v1.runCells)
    end

    return 0
end

function u0.conveyorLengthCells(a1) -- Line: 432; upvalues: u0 (val); types: a1: string?
    local v1 = u0.conveyorKind(a1)

    if not v1 then
        return 1
    end

    return (math.sqrt(v1.runCells * v1.runCells + v1.risePerCell * v1.risePerCell))
end

u0.Splitter = {CatchRadiusStuds = 2.25, ArmClearStuds = 1.2}
u0.OverflowBackStuds = 0.75
u0.MachineSpeed = {IndustrialFurnace = 1.875, Bakehouse = 2}

function u0.speedOf(a1) -- Line: 499; upvalues: u0 (val); types: a1: string?
    if not a1 then
        return 1
    end

    return u0.MachineSpeed[a1] or 1
end

u0.MaxCraftSeconds = {Workbench = 120, Fabricator = 120}
u0.FixedCraftSeconds = {BlockPress = 3}

function u0.craftSeconds(a1, a2) -- Line: 527; upvalues: u0 (val); types: a1: string?, a2: number
    local v1 = if not a1 then nil else u0.FixedCraftSeconds[a1]

    if v1 then
        return (math.max(0.05, v1))
    end

    v1 = math.max(0.05, a2 / (math.max(0.01, (u0.speedOf(a1)))))
    local v2 = if not a1 then nil else u0.MaxCraftSeconds[a1]

    if v2 then
        return (math.min(v1, v2))
    end

    return v1
end

u0.Placement = {InitSeconds = 5}
u0.Buffers = {
    InputPerResource = 500,
    HarvesterHoldsItems = 12,
    OutputSlots = 20,
    HoldCompletedOutputWhenBlocked = true,
    BlockedAlertId = "FACTORY_OUTPUT_BLOCKED",
}
u0.MachineStandardBands = {
    Furnace = {CraftSpeedPercent = {min = 95, max = 110}},
    IndustrialFurnace = {CraftSpeedPercent = {min = 95, max = 118}},
    Bakehouse = {CraftSpeedPercent = {min = 95, max = 118}},
    WoodHarvesterII = {HarvestIntervalSeconds = {min = 25, max = 25}},
    WoodHarvesterIII = {HarvestIntervalSeconds = {min = 20, max = 20}},
    StoneHarvesterII = {HarvestIntervalSeconds = {min = 25, max = 25}},
    StoneHarvesterIII = {HarvestIntervalSeconds = {min = 20, max = 20}},
    CoalHarvesterII = {HarvestIntervalSeconds = {min = 25, max = 25}},
    CoalHarvesterIII = {HarvestIntervalSeconds = {min = 20, max = 20}},
    IronHarvesterII = {HarvestIntervalSeconds = {min = 25, max = 25}},
    IronHarvesterIII = {HarvestIntervalSeconds = {min = 20, max = 20}},
    Fabricator = {CraftSpeedPercent = {min = 95, max = 110}, QualityLuckPercent = {min = 0, max = 1}},
    WaterPump = {HarvestIntervalSeconds = {min = 180, max = 180}},
    Recycler = {RecyclerProcessSeconds = {min = 8, max = 12}},
}
u0.Harvester = {
    PlacedClearanceCells = 2,
    KeepClearAboveCells = 3,
    CropKeepClearAboveCells = 2,
    MinDistanceCells = 2,
    AreaRadiusCells = 5,
    MaxNodes = 8,
    ReserveOutputLane = true,
    FirstCycleSpread = 1,
    PlacedClearanceIgnoredBy = {Tree = true},
    AreaRadiusByMachine = {WoodHarvesterI = 4, WoodHarvesterII = 4, WoodHarvesterIII = 4},
    SaplingSecondsByMachine = {WoodHarvesterI = 90, WoodHarvesterII = 50, WoodHarvesterIII = 30},
    MaxNodesByMachine = {WoodHarvesterI = 1, WoodHarvesterII = 1, WoodHarvesterIII = 1},
    GrowsOnBelt = {Tree = true},
    Default = {SpawnSeconds = 30, HarvestSeconds = 30},
    FirstCycleOffsetSeconds = {min = 1, max = 3},
    PerMachine = {
        WoodHarvesterI = {SpawnSeconds = 30, HarvestSeconds = 30},
        WoodHarvesterII = {SpawnSeconds = 25, HarvestSeconds = 25},
        WoodHarvesterIII = {SpawnSeconds = 20, HarvestSeconds = 20},
        StoneHarvesterI = {SpawnSeconds = 30, HarvestSeconds = 30},
        StoneHarvesterII = {SpawnSeconds = 25, HarvestSeconds = 25},
        StoneHarvesterIII = {SpawnSeconds = 20, HarvestSeconds = 20},
        CoalHarvesterI = {SpawnSeconds = 30, HarvestSeconds = 30},
        CoalHarvesterII = {SpawnSeconds = 25, HarvestSeconds = 25},
        CoalHarvesterIII = {SpawnSeconds = 20, HarvestSeconds = 20},
        IronHarvesterI = {SpawnSeconds = 30, HarvestSeconds = 30},
        IronHarvesterII = {SpawnSeconds = 25, HarvestSeconds = 25},
        IronHarvesterIII = {SpawnSeconds = 20, HarvestSeconds = 20},
        SandHarvesterI = {SpawnSeconds = 30, HarvestSeconds = 30},
        ClayHarvesterI = {SpawnSeconds = 30, HarvestSeconds = 30},
    },
}
u0.Fuel = {
    ItemId = "Coal",
    MaxStoredCrafts = 200,
    EmptyAlertId = "MACHINE_OUT_OF_FUEL",
    CraftsPerUnit = {Furnace = 8, Fabricator = 4, IndustrialFurnace = 8, Bakehouse = 8},
}
u0.Pump = {
    IntervalSeconds = 180,
    SpreadCells = 3,
    DepthCells = 3,
    MaxPipes = 256,
    CheckSeconds = 0.5,
    IdleSearchSeconds = 3,
}
u0.StatusBar = {
    PublishSeconds = 0.3333333333333333,
    ProgressStep = 0.01,
    TweenMinSeconds = 0.1,
    TweenMaxSeconds = 0.6,
    Tag = "MachineStatus",
    ProgressAttribute = "StatusProgress",
    FillName = "Fill",
}

return u0