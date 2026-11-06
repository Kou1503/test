-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.BuildController
-- Decompile time: 56.61 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local DeviceMode = require(script.Parent.DeviceMode)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local BuildFlags = require(Shared.BuildFlags)
local Config = require(Shared.Config)
local Grid = require(Shared.Grid)
local Palette = require(Shared.Palette)
local Pipes = require(Shared.Pipes)
local Prefabs = require(Shared.Prefabs)
local PlantLook = require(Shared.PlantLook)
local Remotes = require(Shared.Remotes)
local u58 = require(script.Parent.Aim)
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local HudController = require(script.Parent.HudController)
local u69 = {}
local LocalPlayer = Players.LocalPlayer
local u74 = Remotes.get(Remotes.RequestPlace)
local u77 = Remotes.get(Remotes.IslandReady)
local u78 = nil
local u79 = nil
local u80 = nil
local u81 = nil
local u82 = {}
local u83 = nil
local u87 = Config.Build.boundsForTier(0)
local IslandRadiusCells = Config.Build.IslandRadiusCells
local u90 = false
local u91 = false
local u92 = {}
local u97 = Color3.fromRGB(90, 220, 120)
local u102 = Color3.fromRGB(230, 80, 80)

local function setGhostValid(a1) -- Line: 71; upvalues: u80 (ref), u97 (val), u102 (val); types: a1: boolean
    local v1 = u80

    if not v1 then
        return
    end

    v1.Color3 = if not a1 then u102 else u97
    v1.SurfaceColor3 = u102
    v1.SurfaceTransparency = if not a1 then 0.7 else 1
    v1.LineThickness = if not a1 then 0.06 else 0.03
end

local u104 = nil

local function setGhostVisible(a1) -- Line: 86; upvalues: u104 (ref), u82 (ref), u80 (ref); types: a1: boolean
    if not a1 then
        u104()
    end

    local v1 = nil
    local v2 = nil
    local v3 = a1

    for i, j in u82, v1, v2 do
        j.part.Transparency = if not v3 then 1 else j.transparency
    end

    if u80 then
        u80.Visible = v3
    end
end

local u106 = {}

function u69.onUiOpenChanged(a1) -- Line: 104; upvalues: u106 (val); types: a1: function
    table.insert(u106, a1)
end

function u69.isUiOpen() -- Line: 109; upvalues: u92 (val)
    return next(u92) ~= nil
end

local function applyLock() -- Line: 113; upvalues: u91 (ref), u92 (val), u104 (ref), u82 (ref), u80 (ref), u106 (val)
    local v1 = u91
    u91 = next(u92) ~= nil

    if u91 then
        u104()

        for i, j in u82 do
            j.part.Transparency = 1
        end

        if u80 then
            u80.Visible = false
        end
    end

    if u91 ~= v1 then
        for k, n in u106 do
            n(u91)
        end
    end
end

local u110 = {
    selectedBlockId = "GrassBlock",
    available = 0,
    rotations = {},
    tilted = {},
    flipped = {},
}

local function isPlanting() -- Line: 152; upvalues: u110 (val), Config (val)
    local selectedBlockId = u110.selectedBlockId

    if not selectedBlockId then
        return false
    end

    local v1 = true

    if Config.Build.Plantables[selectedBlockId] == nil then
        v1 = Config.Crop.isSeed(selectedBlockId)
            or Config.Bush.isSeed(selectedBlockId)
    end

    return v1
end

local u116 = RaycastParams.new()
u116.FilterType = Enum.RaycastFilterType.Exclude

local function machineTemplate(a1) -- Line: 174; upvalues: ReplicatedStorage (val); types: a1: string
    local MachinePreviews = ReplicatedStorage:FindFirstChild("MachinePreviews")
    local v1 = MachinePreviews and MachinePreviews:FindFirstChild(a1)

    if v1 and v1:IsA("Model") then
        return v1
    end

    return nil
end

local function buildBlockGhost(a1)
    -- Line: 188
    -- upvalues: Prefabs (val), Grid (val), Config (val), Palette (val)
    -- types: a1: string
    local v1, v2, v3, v4
    local v5 = Prefabs.forItem(a1)

    if v5 then
        Prefabs.seatIn(v5, CFrame.identity, Grid.CellSize)

        if not v5:IsA("Model") then
            v5.Parent = (Instance.new("Model"))
        else
            v2 = v5
        end

        v2.PrimaryPart = nil
        v2.WorldPivot = CFrame.identity

        return v2
    end

    local Model = Instance.new("Model")
    local Part = Instance.new("Part")
    Part.Name = a1
    local v6 = Config.Build.footprintOf(a1)
    Part.Size = (Vector3.new(v6.x, v6.y, v6.z)) * Grid.CellSize
    Part.Color = Palette.colorFor(a1)
    Part.Material = Palette.materialFor(a1)
    Part.MaterialVariant = Palette.variantFor(a1)
    Part.Transparency = Palette.transparencyFor(a1)
    Part.CFrame = CFrame.identity
    v6 = Config.Build.Blocks[a1]
    local Shapes = Config.Build.Shapes
    local shape = if not v6 then nil else v6.shape

    if shape and shape ~= "Stairs" then
        v6 = Config.Build.shapeSize(shape, Grid.CellSize)
        Part.Size = Vector3.new(v6.x, v6.y, v6.z)
    end

    if shape == "Slab" then
        Part.CFrame = CFrame.new(0, -Grid.CellSize / 4, 0)
        v1 = a1
    elseif shape == "Trapdoor" then
        Part.CFrame = CFrame.new(0, -Grid.CellSize / 2 + Shapes.TrapdoorThicknessStuds / 2, 0)
        v1 = a1
    elseif shape == "Door" then
        Part.CFrame = CFrame.new(0, 0, -(Grid.CellSize / 2 - Shapes.DoorThicknessStuds / 2))
        v1 = a1
    elseif shape == "Sign" then
        Part.CFrame = CFrame.new(0, Grid.CellSize / 2 - Shapes.SignBoardStuds.y / 2 - 0.1, 0)
        v1 = a1
    elseif shape == "Rail" then
        Part.CFrame = CFrame.new(0, -Grid.CellSize / 2 + Shapes.RailPlateStuds / 2, 0)
        v1 = a1
    else
        local v7

        if shape == "PipeCorner" then
            local v8, v9
            local PipeStuds = Shapes.PipeStuds
            v3 = Grid.CellSize / 2 - PipeStuds / 2
            v4 = {Vector3.new(0, 0, 1), (Vector3.new(1, 0, 0))}
            v7 = nil
            local v10 = nil
            v1 = a1

            for k, n in v4, v7, v10 do
                v8 = Part:Clone()
                v9 = if n.Z == 0 then
                    Vector3.new(v3, PipeStuds, PipeStuds)
                else
                    Vector3.new(PipeStuds, PipeStuds, v3)
                v8.Size = v9
                v8.CFrame = CFrame.new(n * (PipeStuds / 2 + v3 / 2))
                v8.Parent = Model
            end
        elseif not Config.Build.shapePieces(shape, Grid.CellSize) then
            v1 = a1
        else
            local v11
            v3 = Config.Build.shapePieces(shape, Grid.CellSize) or {}
            v4 = nil
            v7 = nil
            v1 = a1

            for i, j in v3, v4, v7 do
                v11 = if i ~= 1 then Part:Clone() else Part
                v11.Size = Vector3.new(j.size.x, j.size.y, j.size.z)
                v11.CFrame = CFrame.new(j.offset.x, j.offset.y, j.offset.z)
                v11.Parent = Model
            end
        end
    end

    Part.Parent = Model
    local v12 = Palette.capFor(v1)

    if v12 then
        local new_6, v13
        local v14 = if not v12.bothEnds then {1} else {1, -1}
        v3 = nil
        v4 = nil

        for m, i5 in v14, v3, v4 do
            v2 = Instance.new("Part")
            v2.Name = if i5 ~= 1 then "CapUnder" else "Cap"
            v2.Size = Vector3.new(Grid.CellSize, v12.heightStuds, Grid.CellSize)
            new_6 = CFrame.new
            v13 = Grid.CellSize / 2
            v2.CFrame = new_6(0, i5 * (v13 - v12.heightStuds / 2), 0)
            v2.Color = v12.color
            v2.Material = v12.material
            v2.MaterialVariant = v12.variant
            v2.Parent = Model
        end
    end

    Model.WorldPivot = CFrame.identity

    return Model
end

local function destroyGhost() -- Line: 319; upvalues: u79 (ref), u80 (ref), u81 (ref), u82 (ref)
    if u79 then
        u79:Destroy()
    end

    u79 = nil
    u80 = nil
    u81 = nil

    table.clear(u82)
end

function u69.ghostModel(a1)
    -- Line: 338
    -- upvalues: Config (val), PlantLook (val), Prefabs (val), Grid (val), ReplicatedStorage (val)
    -- upvalues: buildBlockGhost (val), u97 (val)
    -- types: a1: string
    local Transparency, v1, v2
    local v3 = {}
    local v4 = Config.Build.Containers[a1]
    v4 = PlantLook.of(if not v4 then a1 else v4.places)

    if not v4 then
        local places
        local MachinePreviews = ReplicatedStorage:FindFirstChild("MachinePreviews")
        local v5 = MachinePreviews and MachinePreviews:FindFirstChild(places)
        v2 = if not v5 then nil else if not v5:IsA("Model") then nil else v5
        v1 = if not v2 then buildBlockGhost(places) else v2:Clone()
    else
        v2 = PlantLook.model(v4)
        Prefabs.seatIn(v2, CFrame.identity, Grid.CellSize)

        if not v2:IsA("Model") then
            v2.Parent = (Instance.new("Model"))
        else
            v1 = v2
        end

        v1.PrimaryPart = nil
        v1.WorldPivot = CFrame.identity
    end

    v1.Name = "PlacementGhost"
    local v6 = {}
    local v7 = a1

    for i, j in v1:GetDescendants() do
        if j:IsA("Light")
            or j:IsA("ParticleEmitter")
            or j:IsA("Fire")
            or j:IsA("Smoke")
            or j:IsA("Sparkles")
            or j:IsA("Beam")
            or j:IsA("Trail")
            or j:IsA("LayerCollector")
            or j:IsA("ProximityPrompt")
            or j:IsA("Sound") then
            table.insert(v6, j)
        end
    end

    for k, n in v6 do
        n:Destroy()
    end

    for m, i5 in v1:GetDescendants() do
        if i5:IsA("Decal") or i5:IsA("BasePart") then
            Transparency = i5.Transparency
            i5:SetAttribute("AuthoredTransparency", Transparency)
        end

        if i5:IsA("Decal") then
            v6 = math.max(i5.Transparency, 0.5)
            i5.Transparency = v6

            table.insert(
                v3,
                {part = i5, transparency = v6}
            )
        elseif i5:IsA("BasePart") then
            i5.Anchored = true
            i5.CanCollide = false
            i5.CanQuery = false
            i5.CanTouch = false
            i5.CastShadow = false
            v4 = math.max(i5.Transparency, 0.5)
            i5.Transparency = v4

            table.insert(
                v3,
                {part = i5, transparency = v4}
            )
        end
    end

    v2 = v1:FindFirstChild(v7)

    if v2 and v2:IsA("BasePart") then
        local SelectionBox = Instance.new("SelectionBox")
        SelectionBox.Adornee = v2
        SelectionBox.Color3 = u97
        SelectionBox.LineThickness = 0.03
        SelectionBox.SurfaceTransparency = 1
        SelectionBox.Parent = v1

        return v1, v3, SelectionBox
    end

    v2 = Config.Build.footprintOf(v7)
    local CellSize = Grid.CellSize
    local Part = Instance.new("Part")
    Part.Name = "FootprintBox"
    Part.Size = Vector3.new(v2.x * CellSize, v2.y * CellSize, v2.z * CellSize)
    Part.CFrame = CFrame.new((v2.x - 1) * CellSize / 2, (v2.y - 1) * CellSize / 2, (v2.z - 1) * CellSize / 2)
    Part.Transparency = 1
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Massless = true
    Part.Parent = v1
    local v8 = Instance.new("SelectionBox")
    v8.Adornee = Part
    v8.Color3 = u97
    v8.LineThickness = 0.03
    v8.SurfaceTransparency = 1
    v8.Parent = v1

    return v1, v3, v8
end

local function ensureGhost(a1)
    -- Line: 488
    -- upvalues: u79 (ref), u81 (ref), u80 (ref), u82 (ref), u69 (val)
    -- types: a1: string
    local v1 = u79

    if v1 and v1.Parent and u81 == a1 then
        return v1
    end

    if u79 then
        u79:Destroy()
    end

    u79 = nil
    u80 = nil
    u81 = nil

    table.clear(u82)

    local v2, v3, v4 = u69.ghostModel(a1)
    v2.Parent = workspace
    u79 = v2
    u82 = v3
    u80 = v4
    u81 = a1

    return v2
end

local function refreshRayFilter() -- Line: 504; upvalues: u79 (ref), LocalPlayer (val), u116 (val)
    local v1 = {}

    if u79 then
        table.insert(v1, u79)
    end

    local Character = LocalPlayer.Character

    if Character then
        table.insert(v1, Character)
    end

    u116.FilterDescendantsInstances = v1
end

local function rootPart() -- Line: 518; upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    return Character and Character:FindFirstChild("HumanoidRootPart")
end

local function feetPosition() -- Line: 525; upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local v1 = Character and Character:FindFirstChild("HumanoidRootPart")

    if not v1 then
        return nil
    end

    local Humanoid = v1.Parent:FindFirstChildOfClass("Humanoid")
    local Position = v1.Position

    return Position
        - Vector3.new(0, (if not Humanoid then 0 else Humanoid.HipHeight) + v1.Size.Y / 2, 0)
end

local u126 = {
    Stairs = true,
    Door = true,
    Gate = true,
    Trapdoor = true,
    Pane = true,
    Sign = true,
    PipeCorner = true,
    Rail = true,
    RailRamp = true,
}

local function canRotate(a1)
    -- Line: 559
    -- upvalues: ReplicatedStorage (val), Config (val), u126 (val)
    -- types: a1: string
    local MachinePreviews = ReplicatedStorage:FindFirstChild("MachinePreviews")
    local v1 = MachinePreviews and MachinePreviews:FindFirstChild(a1)
    local v2 = if not v1 then nil else if not v1:IsA("Model") then nil else v1

    if v2 then
        return v2:GetAttribute("Directional") == true
    end

    v2 = Config.Build.Blocks[a1]

    if v2 and v2.shape and u126[v2.shape] then
        return true
    end

    local v3 = Config.Appearance.of(a1)

    if v2 and Config.Appearance.isPrefabKind(v3.kind) then
        return true
    end

    if not v2 then
        if Config.Build.tilts(a1) then
            return true
        end

        v3 = Config.Build.footprintOf(a1)

        return v3.x ~= v3.z
    end

    if v3.variant == nil and v3.cap == nil then
        if Config.Build.tilts(a1) then
            return true
        end

        v3 = Config.Build.footprintOf(a1)

        return v3.x ~= v3.z
    end

    return true
end

u69.canRotate = canRotate

local function effectiveRotation() -- Line: 593; upvalues: u110 (val), canRotate (val)
    local selectedBlockId = u110.selectedBlockId

    if selectedBlockId and canRotate(selectedBlockId) then
        return (u110.rotations[selectedBlockId] or 0) % 360
    end

    return 0
end

local function aimLength(a1) -- Line: 612; upvalues: LocalPlayer (val), u58 (val), Grid (val); types: a1: number
    local Character = LocalPlayer.Character
    local v1 = Character and Character:FindFirstChild("HumanoidRootPart")
    local Origin = (u58.ray()).Origin

    return (if not v1 then 0 else (v1.Position - Origin).Magnitude) + a1 + Grid.CellSize
end

function u69.islandOrigin() -- Line: 646; upvalues: u78 (ref)
    return u78
end

function u69.aimedInstance()
    -- Line: 650
    -- upvalues: u79 (ref), LocalPlayer (val), u116 (val), u58 (val), Config (val), Grid (val)
    local Parent
    local v1 = {}

    if u79 then
        table.insert(v1, u79)
    end

    local Character = LocalPlayer.Character

    if Character then
        table.insert(v1, Character)
    end

    u116.FilterDescendantsInstances = v1
    v1 = u58.ray()
    local v2 = Config.Player.BuildReachCells * Grid.CellSize
    local _workspace = workspace
    local Origin = v1.Origin
    local Unit = v1.Direction.Unit
    local Character_2 = LocalPlayer.Character
    local v3 = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")
    local Origin_2 = (u58.ray()).Origin
    local v4 = _workspace:Raycast(Origin, Unit * ((if not v3 then 0 else (v3.Position - Origin_2).Magnitude) + v2 + Grid.CellSize), u116)

    if not v4 then
        return nil
    end

    local Instance_2 = v4.Instance
    local Parent_2 = Instance_2

    while Parent_2 do
        if Parent_2 == workspace then
            break
        end

        if Parent_2:IsA("BasePart") and Parent_2:GetAttribute("CellKey") then
            v1 = Parent_2
            Parent = v1.Parent

            while Parent do
                if not Parent:IsA("BasePart")
                    or (Parent:GetAttribute("CellKey")) ~= v1:GetAttribute("CellKey") then
                    break
                end

                Parent = Parent.Parent
            end

            return v1
        end

        Parent_2 = Parent_2.Parent
    end

    local Parent_3 = Instance_2.Parent

    if Parent_3 and Parent_3:IsA("Model") then
        for i, j in Parent_3:GetChildren() do
            if j:IsA("BasePart") and j:GetAttribute("CellKey") then
                return j
            end
        end
    end

    return Instance_2
end

function u69.aimedBlockPart() -- Line: 707; upvalues: u69 (val)
    local v1 = u69.aimedInstance()

    if not v1 then
        return nil
    end

    local Parent = v1

    while Parent do
        if Parent == workspace then
            break
        end

        if Parent:IsA("BasePart") and type((Parent:GetAttribute("CellKey"))) == "string" then
            return Parent
        end

        Parent = Parent.Parent
    end

    return nil
end

function u69.aimedBlockId() -- Line: 725; upvalues: u69 (val)
    local v1 = u69.aimedBlockPart()

    if v1 then
        return (v1:GetAttribute("BlockId"))
    end

    return nil
end

function u69.aimedBlockCell() -- Line: 730; upvalues: u69 (val), Grid (val)
    local v1 = u69.aimedBlockPart()

    if not v1 then
        return nil
    end

    return Grid.fromKey((v1:GetAttribute("CellKey")))
end

function u69.aimedBlockPartThroughCrops()
    -- Line: 743
    -- upvalues: u79 (ref), LocalPlayer (val), u116 (val), u58 (val), Config (val), Grid (val)
    local Character_2, Instance_2, Origin, Origin_2, Unit, _workspace, v1, v2, v3
    local v4 = {}

    if u79 then
        table.insert(v4, u79)
    end

    local Character = LocalPlayer.Character

    if Character then
        table.insert(v4, Character)
    end

    u116.FilterDescendantsInstances = v4
    v4 = RaycastParams.new()
    v4.FilterType = Enum.RaycastFilterType.Exclude
    local v5 = table.clone(u116.FilterDescendantsInstances)
    local v6 = u58.ray()
    local v7 = Config.Player.BuildReachCells * Grid.CellSize

    for i = 1, 6 do
        v4.FilterDescendantsInstances = v5
        _workspace = workspace
        Origin = v6.Origin
        Unit = v6.Direction.Unit
        Character_2 = LocalPlayer.Character
        v1 = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")
        Origin_2 = (u58.ray()).Origin
        v2 = _workspace:Raycast(Origin, Unit * ((if not v1 then 0 else (v1.Position - Origin_2).Magnitude) + v7 + Grid.CellSize), v4)

        if not v2 then
            return nil
        end

        Instance_2 = v2.Instance
        v2 = nil
        v3 = nil

        while Instance_2 do
            if Instance_2 == workspace then
                break
            end

            if Instance_2:GetAttribute("CropCell") ~= nil then
                v2 = Instance_2
            end

            if not v3
                and Instance_2:IsA("BasePart")
                and type((Instance_2:GetAttribute("CellKey"))) == "string" then
                v3 = Instance_2
            end

            Instance_2 = Instance_2.Parent
        end

        if not v2 then
            return v3
        end

        table.insert(v5, v2)
    end

    return nil
end

function u69.aimedBlockCellThroughCrops() -- Line: 776; upvalues: u69 (val), Grid (val)
    local v1 = u69.aimedBlockPartThroughCrops()

    if v1 then
        return (Grid.fromKey((v1:GetAttribute("CellKey"))))
    end

    return nil
end

function u69.aimedWaterPoint()
    -- Line: 790
    -- upvalues: u79 (ref), LocalPlayer (val), u116 (val), u58 (val), Config (val), Grid (val)
    local v1 = {}

    if u79 then
        table.insert(v1, u79)
    end

    local Character = LocalPlayer.Character

    if Character then
        table.insert(v1, Character)
    end

    u116.FilterDescendantsInstances = v1
    v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    v1.FilterDescendantsInstances = u116.FilterDescendantsInstances
    v1.IgnoreWater = false
    local v2 = u58.ray()
    local InteractReachStuds = Config.Player.InteractReachStuds
    local _workspace = workspace
    local Origin = v2.Origin
    local Unit = v2.Direction.Unit
    local Character_2 = LocalPlayer.Character
    local v3 = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")
    local Origin_2 = (u58.ray()).Origin
    local v4 = _workspace:Raycast(Origin, Unit * ((if not v3 then 0 else (v3.Position - Origin_2).Magnitude) + InteractReachStuds + Grid.CellSize), v1)

    if not v4 then
        return nil
    end

    if v4.Instance == workspace.Terrain and v4.Material == Enum.Material.Water then
        return v4.Position
    end

    return nil
end

local function supportCellY() -- Line: 813; upvalues: LocalPlayer (val), u116 (val), Grid (val)
    local Character = LocalPlayer.Character
    local v1 = Character and Character:FindFirstChild("HumanoidRootPart")

    if not v1 then
        return nil
    end

    local v2 = workspace:Raycast(v1.Position, Vector3.new(0, -12, 0), u116)

    if not v2 then
        return nil
    end

    v1 = v2.Instance:GetAttribute("CellKey")

    if v1 then
        v2 = Grid.fromKey(v1)

        if v2 then
            return v2.y
        end
    end

    return 0
end

local u139 = nil

local function cellFromHit(a1, a2, a3)
    -- Line: 836
    -- upvalues: Grid (val), u139 (ref), Config (val), u110 (val), u58 (val)
    -- types: a1: vector, a2: userdata, a3: number?
    local Normal = a2.Normal
    local Position = a2.Position
    local v1 = Grid.surfaceCell(a1, Position, Normal)
    u139 = Grid.offsetByNormal(v1, Normal)
    local Placement = Config.Build.Placement
    local v2 = 0.9 < Normal.Y

    if Placement.PlaneLockEnabled and v2 and a3 and v1.y == a3 then
        local v3
        local selectedBlockId = u110.selectedBlockId

        if selectedBlockId then
            v3 = true

            if Config.Build.Plantables[selectedBlockId] == nil then
                v3 = Config.Crop.isSeed(selectedBlockId)
                    or Config.Bush.isSeed(selectedBlockId)
            end
        else
            v3 = false
        end

        if not v3 and not u58.isTouch() then
            local v4
            v3, v4 = Grid.rimOffset(a1, v1, Position, Placement.EdgeMarginFraction, Placement.AllowDiagonal)

            if v3 == 0 and v4 == 0 then
                return Grid.offsetByNormal(v1, Normal)
            end

            return Grid.cell(v1.x + v3, v1.y, v1.z + v4)
        end
    end

    return Grid.offsetByNormal(v1, Normal)
end

local u141 = nil
local u142 = false

local function flipFor(a1, a2, a3) -- Line: 889; upvalues: Grid (val); types: a1: vector, a2: userdata
    local Normal = a2.Normal

    if Normal.Y < -0.5 then
        return true
    end

    if not ((math.abs(Normal.Y)) < 0.5) then
        return false
    end

    local Y_2 = a2.Position.Y

    return Grid.cellToWorld(a1, a3).Y < Y_2
end

local function tilting() -- Line: 903; upvalues: u110 (val), Config (val)
    local v1 = false

    if u110.tilted[u110.selectedBlockId] == true then
        v1 = Config.Build.tilts(u110.selectedBlockId)
    end

    return v1
end

local function hasUpsideDown(a1) -- Line: 909; upvalues: Config (val); types: a1: string?
    local v1 = if not a1 then nil else Config.Build.Blocks[a1]
    local v2 = false

    if v1 ~= nil then
        v2 = true

        if v1.shape ~= "Slab" then
            v2 = true

            if v1.shape ~= "Stairs" then
                v2 = v1.shape == "Trapdoor"
            end
        end
    end

    return v2
end

local function flipsShape() -- Line: 914; upvalues: u110 (val), Config (val)
    local selectedBlockId = u110.selectedBlockId
    local v1 = if not selectedBlockId then nil else Config.Build.Blocks[selectedBlockId]
    local v2 = false

    if v1 ~= nil then
        v2 = true

        if v1.shape ~= "Slab" then
            v2 = true

            if v1.shape ~= "Stairs" then
                v2 = v1.shape == "Trapdoor"
            end
        end
    end

    if v2 then
        local v3 = false

        if u110.tilted[u110.selectedBlockId] == true then
            v3 = Config.Build.tilts(u110.selectedBlockId)
        end

        v2 = not v3
    end

    return v2
end

local function wantsFlip() -- Line: 919; upvalues: u110 (val), Config (val), u142 (ref)
    local v1
    local selectedBlockId = u110.selectedBlockId
    local v2 = if not selectedBlockId then nil else Config.Build.Blocks[selectedBlockId]
    local v3 = false

    if v2 ~= nil then
        v3 = true

        if v2.shape ~= "Slab" then
            v3 = true

            if v2.shape ~= "Stairs" then
                v3 = v2.shape == "Trapdoor"
            end
        end
    end

    if v3 then
        v1 = false

        if u110.tilted[u110.selectedBlockId] == true then
            v1 = Config.Build.tilts(u110.selectedBlockId)
        end

        v3 = not v1
    end

    if v3 then
        v1 = u142
        v3 = v1 ~= (u110.flipped[u110.selectedBlockId] == true)
    end

    return v3
end

local function plantingLayerOf(a1) -- Line: 938; types: a1: userdata
    local Parent = a1

    while Parent do
        if Parent == workspace then
            break
        end

        if Parent:IsA("Folder") and Parent.Name == "Nodes" then
            return Parent
        end

        Parent = Parent.Parent
    end

    return nil
end

local function targetCell()
    -- Line: 949
    -- upvalues: u78 (ref), LocalPlayer (val), u79 (ref), u116 (val), u58 (val), Config (val), Grid (val)
    -- upvalues: PlantLook (val), u110 (val), plantingLayerOf (val), supportCellY (val), u141 (ref), u142 (ref)
    -- upvalues: u139 (ref), cellFromHit (val)
    local v1, v2
    local v3 = u78

    if not v3 then
        return nil, false
    end

    local Character = LocalPlayer.Character

    if not (Character and Character:FindFirstChild("HumanoidRootPart")) then
        return nil, false
    end

    local v4 = {}

    if u79 then
        table.insert(v4, u79)
    end

    local Character_2 = LocalPlayer.Character

    if Character_2 then
        table.insert(v4, Character_2)
    end

    u116.FilterDescendantsInstances = v4
    local v5 = u58.ray()
    local v6 = Config.Player.BuildReachCells * Grid.CellSize
    local _workspace = workspace
    local Origin = v5.Origin
    local Unit = v5.Direction.Unit
    local v7 = v6 * 2
    local Character_3 = LocalPlayer.Character
    local v8 = Character_3 and Character_3:FindFirstChild("HumanoidRootPart")
    local Origin_2 = (u58.ray()).Origin
    local v9 = _workspace:Raycast(Origin, Unit * ((if not v8 then 0 else (v8.Position - Origin_2).Magnitude) + v7 + Grid.CellSize), u116)

    if v9 and PlantLook.of(u110.selectedBlockId) then
        v1 = plantingLayerOf(v9.Instance)

        if v1 then
            v2 = table.clone(u116.FilterDescendantsInstances)
            table.insert(v2, v1)

            u116.FilterDescendantsInstances = v2
            local _workspace_2 = workspace
            local Origin_3 = v5.Origin
            local Unit_2 = v5.Direction.Unit
            local v10 = v6 * 2
            local Character_4 = LocalPlayer.Character
            v2 = Character_4 and Character_4:FindFirstChild("HumanoidRootPart")
            local Origin_4 = (u58.ray()).Origin
            v9 = _workspace_2:Raycast(Origin_3, Unit_2 * ((if not v2 then 0 else (v2.Position - Origin_4).Magnitude) + v10 + Grid.CellSize), u116)
        end
    end

    v6 = supportCellY()
    v1 = nil
    u141 = if not v9 then nil else v9.Normal
    u142 = false
    u139 = nil

    if not v9 then
        if Config.Build.Placement.PlaneLockEnabled and v6 then
            v1 = Grid.cellFromPlane(v3, v5.Origin, v5.Direction, v6)
        end

        return v1, false
    end

    v1 = cellFromHit(v3, v9, v6)
    local Normal_2 = v9.Normal

    if Normal_2.Y < -0.5 then
        v2 = true
    elseif not ((math.abs(Normal_2.Y)) < 0.5) then
        v2 = false
    else
        local Y_2 = v9.Position.Y
        v2 = Grid.cellToWorld(v3, v1).Y < Y_2
    end

    u142 = v2

    return v1, true
end

function u69.aimReport()
    -- Line: 1013
    -- upvalues: targetCell (val), u139 (ref), u79 (ref), LocalPlayer (val), u116 (val), u58 (val), Config (val)
    -- upvalues: Grid (val), u78 (ref), u69 (val)
    local v1, v2 = targetCell()
    local v3 = u139
    local v4 = {}

    if u79 then
        table.insert(v4, u79)
    end

    local Character = LocalPlayer.Character

    if Character then
        table.insert(v4, Character)
    end

    u116.FilterDescendantsInstances = v4
    v4 = u58.ray()
    local v5 = Config.Player.BuildReachCells * Grid.CellSize * 2
    local Character_2 = LocalPlayer.Character
    local v6 = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")
    local Origin = (u58.ray()).Origin
    local v7 = (if not v6 then 0 else (v6.Position - Origin).Magnitude) + v5
        + Grid.CellSize
    local v8 = workspace:Raycast(v4.Origin, v4.Direction.Unit * v7, u116)

    return {
        ray = v4,
        hit = if not v8 then nil else v8.Instance,
        position = if not v8 then nil else v8.Position,
        normal = if not v8 then nil else v8.Normal,
        cell = v1,
        struck = v2,
        faceCell = v3,
        origin = u78,
        breakPart = u69.aimedInstance(),
    }
end

local u152 = OverlapParams.new()
u152.FilterType = Enum.RaycastFilterType.Exclude
local u154 = {}

local function occupiedCellsNear(a1, a2, a3)
    -- Line: 1046
    -- upvalues: LocalPlayer (val), u152 (val), u79 (ref), Grid (val), u154 (val), Config (val)
    -- types: a1: vector, a3: number
    local Attribute, Attribute_2, Attribute_3, Attribute_4, Attribute_5, Attribute_6, v1
    local Character = LocalPlayer.Character
    u152.FilterDescendantsInstances = if not Character then
        if not u79 then {} else {u79}
    else
        if u79 then {Character, u79} else if not u79 then {} else {u79}
    local v2 = Grid.CellSize * (a3 * 2 + 3)
    local v3 = Grid.cellToWorld(a1, a2)

    table.clear(u154)

    local v4 = {}
    local v5 = {}
    local v6 = {}
    local v7 = {}

    for i, j in workspace:GetPartBoundsInBox(CFrame.new(v3), Vector3.new(v2, v2, v2), u152) do
        Attribute = j:GetAttribute("NodeCell")

        if not Attribute then
            Attribute_2 = j:GetAttribute("CropCell") or j:GetAttribute("BushCell")

            if type(Attribute_2) ~= "string" then
                v1 = j:GetAttribute("MachineId") ~= nil
                Attribute_3 = j:GetAttribute("Cells")

                if not Attribute_3 then
                    Attribute_4 = j:GetAttribute("CellKey")

                    if Attribute_4 then
                        v4[Attribute_4] = true
                        v5[Attribute_4] = v1
                        Attribute_5 = j:GetAttribute("BlockId")

                        if type(Attribute_5) == "string" then
                            v7[Attribute_4] = Attribute_5
                        end

                        Attribute_6 = j:GetAttribute("WaterUses")

                        if Attribute_5 == "WaterBlock"
                            and type(Attribute_6) == "number"
                            and Attribute_6 < Config.Build.Farm.WaterUses then
                            u154[Attribute_4] = true
                        end
                    end
                else
                    for k, n in string.split(Attribute_3, ";") do
                        v4[n] = true
                        v5[n] = v1
                    end
                end
            else
                v4[Attribute_2] = true
            end
        else
            v6[Attribute] = true
        end
    end

    return v4, v5, v6, v7
end

local function rotationAt(a1)
    -- Line: 1122
    -- upvalues: u110 (val), canRotate (val), Config (val), u78 (ref), occupiedCellsNear (val), Grid (val)
    local selectedBlockId = u110.selectedBlockId
    local v1 = if not selectedBlockId then
        0
    else
        if canRotate(selectedBlockId) then (u110.rotations[selectedBlockId] or 0) % 360 else 0
    local v2 = if not u110.selectedBlockId then
        nil
    else
        Config.Build.Blocks[u110.selectedBlockId]

    if a1 and u78 and v2 then
        if v2.shape ~= "Door" and v2.shape ~= "Gate" then
            return v1
        end

        local u33 = occupiedCellsNear(u78, a1, 1)

        local function taken(a1_2, a2)
            -- Line: 1129
            -- upvalues: u33 (val), Grid (upval), a1 (val)
            -- types: a1_2: number, a2: number
            return u33[Grid.key(Grid.cell(a1.x + a1_2, a1.y, a1.z + a2))]
                == true
        end

        local v3 = u33[Grid.key(Grid.cell(a1.x + 1, a1.y, a1.z + 0))]
            == true
            or u33[Grid.key(Grid.cell(a1.x + -1, a1.y, a1.z + 0))]
                == true

        return ((if not (u33[Grid.key(Grid.cell(a1.x + 0, a1.y, a1.z + 1))]
            == true
            or u33[Grid.key(Grid.cell(a1.x + 0, a1.y, a1.z + -1))]
                == true) then
            0
        else
            if v3 then 0 else 90)
            + v1)
            % 360
    end

    return v1
end

local function footprintFor(a1) -- Line: 1141; upvalues: Grid (val), Config (val), u110 (val), canRotate (val)
    local footprintCells = Grid.footprintCells
    local v1 = Config.Build.footprintOf(u110.selectedBlockId)
    local selectedBlockId = u110.selectedBlockId

    return footprintCells(a1, v1, if not selectedBlockId then 0 else if canRotate(selectedBlockId) then (u110.rotations[selectedBlockId] or 0) % 360 else 0)
end

local function looksPlaceable(a1, a2, a3, a4, a5, a6)
    -- Line: 1146
    -- upvalues: u78 (ref), LocalPlayer (val), u110 (val), IslandRadiusCells (ref), Config (val), BuildFlags (val)
    -- upvalues: Grid (val), canRotate (val), u87 (ref), u154 (val), ReplicatedStorage (val)
    -- types: a2: table, a3: table, a4: table, a5: table, a6: number
    local v1 = u78
    local Character = LocalPlayer.Character
    local v2 = Character and Character:FindFirstChild("HumanoidRootPart")

    if v1 and v2 then
        local placementRuleFor, selectedBlockId_3, selectedBlockId_4, u294, v3
        local Character_2 = LocalPlayer.Character
        local v4 = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")

        if v4 then
            local Humanoid = v4.Parent:FindFirstChildOfClass("Humanoid")
            local Position = v4.Position
            v2 = Position
                - Vector3.new(0, (if not Humanoid then 0 else Humanoid.HipHeight) + v4.Size.Y / 2, 0)
        else
            v2 = nil
        end

        if u110.available <= 0 then
            return false
        end

        local u402 = IslandRadiusCells
        local IslandTopCellY = Config.Build.IslandTopCellY
        local v5 = BuildFlags.protectionEnabled()
        local footprintCells = Grid.footprintCells
        local v6 = Config.Build.footprintOf(u110.selectedBlockId)
        local selectedBlockId = u110.selectedBlockId
        local v7 = footprintCells(a1, v6, if not selectedBlockId then 0 else if canRotate(selectedBlockId) then (u110.rotations[selectedBlockId] or 0) % 360 else 0)
        local u432 = {}

        for i, j in v7 do
            u432[(Grid.key(j))] = true
        end

        v6 = (1 / 0)
        local v8 = v7
        local v9 = nil
        local v10 = nil
        local v11, v12, v13, v14 = a6, a1, a5, a4

        for k, n in v8, v9, v10 do
            if not Grid.isInBounds(n, u87) then
                return false
            end

            if not a2[Grid.key(n)] and not Grid.isSolidIsland(n, u402, IslandTopCellY) then
                if v5 and Config.Build.isProtectedCell(n.x, n.y, n.z) then
                    return false
                end

                v6 = math.min(v6, ((Grid.cellToWorld(v1, n)) - v2).Magnitude)
                continue
            end

            return false
        end

        if v11 < v6 then
            return false
        end

        local selectedBlockId_2 = u110.selectedBlockId
        v5 = Grid.key(Grid.cell(v12.x, v12.y - 1, v12.z))
        v2 = v13[v5]
        v1 = Config.Build.Containers[selectedBlockId_2 or ""]

        if selectedBlockId_2 == "WaterBlock" then
            if u154[v5] then
                return false
            end

            if Config.Crop.isSeed(selectedBlockId_2) and v2 ~= Config.Crop.RequiredGround then
                return false
            end

            if Config.Bush.isSeed(selectedBlockId_2)
                and not Config.Bush.GroundBlocks[v2 or ""] then
                return false
            end

            v6 = Config.Build.Plantables[u110.selectedBlockId]

            if v6 then
                v5 = Config.Tool.clearanceOf(v6.node)

                for i12 = -v5, v5 do
                    for i13 = -v5, v5 do
                        if i12 == 0 and i13 == 0 then
                            continue
                        end

                        if v14[Grid.key(Grid.cell(v12.x + i12, v12.y, v12.z + i13))] then
                            return false
                        end
                    end
                end
            end

            placementRuleFor = Config.Build.placementRuleFor
            selectedBlockId_3 = u110.selectedBlockId
            selectedBlockId_4 = u110.selectedBlockId
            v1 = ReplicatedStorage:FindFirstChild("MachinePreviews")
            v3 = v1 and v1:FindFirstChild(selectedBlockId_4)
            u294 = placementRuleFor(selectedBlockId_3, (if not v3 then nil else if not v3:IsA("Model") then nil else v3) ~= nil)

            if u294.requiresSupport then
                v8 = (1 / 0)

                for i14, i15 in v7 do
                    v8 = math.min(v8, i15.y)
                end

                for i16, i17 in v7 do
                    if i17.y == v8
                        and not Grid.isSupported(
                            i17,
                            function(a1)
                                -- Line: 1247
                                -- upvalues: Grid (upval), u432 (val), a2 (val), u294 (val), a3 (val), u402 (val)
                                -- upvalues: IslandTopCellY (val)
                                local v1 = Grid.key(a1)

                                if not u432[v1] then
                                    if not a2[v1] then
                                        return Grid.isSolidIsland(a1, u402, IslandTopCellY)
                                    else
                                        local supportMustBeStructural = u294.supportMustBeStructural

                                        if supportMustBeStructural then
                                            if a3[v1] == true then
                                                supportMustBeStructural = true
                                            else
                                                supportMustBeStructural = false
                                            end
                                        end

                                        return not supportMustBeStructural
                                    end
                                else
                                    return true
                                end
                            end
                        ) then
                        return false
                    end
                end
            end

            if not Config.Build.Placement.RequireAdjacency then
                return true
            end

            for i18, i19 in v7 do
                if Grid.forEachNeighbor(
                    i19,
                    function(a1)
                        -- Line: 1269
                        -- upvalues: Grid (upval), u432 (val), a2 (val), u402 (val), IslandTopCellY (val)
                        local v1 = Grid.key(a1)

                        if not u432[v1] then
                            if not a2[v1] then
                                return Grid.isSolidIsland(a1, u402, IslandTopCellY) or nil
                            else
                                return true
                            end
                        else
                            return nil
                        end
                    end
                ) then
                    return true
                end
            end

            return false
        end

        if v1 and v1.places == "WaterBlock" and u154[v5] then
            return false
        end

        if Config.Crop.isSeed(selectedBlockId_2) and v2 ~= Config.Crop.RequiredGround then
            return false
        end

        if Config.Bush.isSeed(selectedBlockId_2)
            and not Config.Bush.GroundBlocks[v2 or ""] then
            return false
        end

        v6 = Config.Build.Plantables[u110.selectedBlockId]

        if v6 then
            v5 = Config.Tool.clearanceOf(v6.node)

            for m = -v5, v5 do
                for i5 = -v5, v5 do
                    if m == 0 and i5 == 0 then
                        continue
                    end

                    if v14[Grid.key(Grid.cell(v12.x + m, v12.y, v12.z + i5))] then
                        return false
                    end
                end
            end
        end

        placementRuleFor = Config.Build.placementRuleFor
        selectedBlockId_3 = u110.selectedBlockId
        selectedBlockId_4 = u110.selectedBlockId
        v1 = ReplicatedStorage:FindFirstChild("MachinePreviews")
        v3 = v1 and v1:FindFirstChild(selectedBlockId_4)
        u294 = placementRuleFor(selectedBlockId_3, (if not v3 then nil else if not v3:IsA("Model") then nil else v3) ~= nil)

        if u294.requiresSupport then
            v8 = (1 / 0)

            for i6, i7 in v7 do
                v8 = math.min(v8, i7.y)
            end

            for i8, i9 in v7 do
                if i9.y == v8
                    and not Grid.isSupported(
                        i9,
                        function(a1)
                            -- Line: 1247
                            -- upvalues: Grid (upval), u432 (val), a2 (val), u294 (val), a3 (val), u402 (val)
                            -- upvalues: IslandTopCellY (val)
                            local v1 = Grid.key(a1)

                            if not u432[v1] then
                                if not a2[v1] then
                                    return Grid.isSolidIsland(a1, u402, IslandTopCellY)
                                else
                                    local supportMustBeStructural = u294.supportMustBeStructural

                                    if supportMustBeStructural then
                                        if a3[v1] == true then
                                            supportMustBeStructural = true
                                        else
                                            supportMustBeStructural = false
                                        end
                                    end

                                    return not supportMustBeStructural
                                end
                            else
                                return true
                            end
                        end
                    ) then
                    return false
                end
            end
        end

        if not Config.Build.Placement.RequireAdjacency then
            return true
        end

        for i10, i11 in v7 do
            if Grid.forEachNeighbor(
                i11,
                function(a1)
                    -- Line: 1269
                    -- upvalues: Grid (upval), u432 (val), a2 (val), u402 (val), IslandTopCellY (val)
                    local v1 = Grid.key(a1)

                    if not u432[v1] then
                        if not a2[v1] then
                            return Grid.isSolidIsland(a1, u402, IslandTopCellY) or nil
                        else
                            return true
                        end
                    else
                        return nil
                    end
                end
            ) then
                return true
            end
        end

        return false
    end

    return false
end

local u159 = nil
local u160 = false
local u161 = (-1 / 0)
local u162 = false

local function pastBoundary(a1)
    -- Line: 1316
    -- upvalues: Grid (val), Config (val), u110 (val), canRotate (val), u87 (ref)
    local v1, v2
    local footprintCells = Grid.footprintCells
    local v3 = Config.Build.footprintOf(u110.selectedBlockId)
    local selectedBlockId = u110.selectedBlockId
    v1, v2, v3 = footprintCells(a1, v3, if not selectedBlockId then 0 else if canRotate(selectedBlockId) then (u110.rotations[selectedBlockId] or 0) % 360 else 0)

    for i, j in v1, v2, v3 do
        if not Grid.isInBounds(j, u87) then
            return true
        end
    end

    return false
end

local function pipeLineAt(a1) -- Line: 1334; upvalues: Grid (val), CollectionService (val), Pipes (val)
    local v1 = Grid.key(a1)

    for i, j in CollectionService:GetTagged("WaterPump") do
        if j:GetAttribute("PipeNext") == v1 then
            return Pipes.dirFromKey(j:GetAttribute("PipeFlow"))
        end
    end

    return nil
end

local function pipeTurnsRight() -- Line: 1345; upvalues: u110 (val)
    return (u110.rotations[u110.selectedBlockId] or 0) // 90 % 2 == 0
end

local u166 = nil
local u167 = nil
local u168 = nil
local u173 = Color3.fromRGB(90, 160, 235)

local function ensurePipePreview() -- Line: 1356; upvalues: u166 (ref), u167 (ref), u168 (ref), u173 (val)
    if u166 and u166.Parent and u167 and u168 then
        return u167, u168
    end

    local Folder = Instance.new("Folder")
    Folder.Name = "PipePreview"
    Folder.Parent = workspace
    local Part = Instance.new("Part")
    Part.Name = "StreamHolder"
    Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
    Part.Transparency = 1
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Parent = Folder
    local Attachment = Instance.new("Attachment")
    Attachment.Parent = Part
    local Attachment_2 = Instance.new("Attachment")
    Attachment_2.Parent = Part
    local v1 = Instance.new("Beam")
    v1.Attachment0 = Attachment
    v1.Attachment1 = Attachment_2
    v1.Color = ColorSequence.new(u173)
    v1.Transparency = NumberSequence.new(0.3)
    v1.Width0 = 0.5
    v1.Width1 = 0.7
    v1.LightEmission = 0.4
    v1.FaceCamera = true
    v1.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    v1.TextureMode = Enum.TextureMode.Wrap
    v1.TextureLength = 1.5
    v1.TextureSpeed = -2
    v1.Parent = Folder
    u166 = Folder
    u167 = Attachment
    u168 = Attachment_2

    return Attachment, Attachment_2
end

function u104() -- Line: 1396; upvalues: u166 (ref), u167 (ref), u168 (ref)
    local v1 = u166

    if v1 then
        u166 = nil
        u167 = nil
        u168 = nil

        v1:Destroy()
    end
end

local function showPipePreview(a1, a2)
    -- Line: 1404
    -- upvalues: Grid (val), Config (val), u79 (ref), LocalPlayer (val), u104 (ref), ensurePipePreview (val)
    -- types: a1: vector
    local CellSize = Grid.CellSize
    local v1 = Config.Factory.Pump.DepthCells * CellSize
    local v2 = (Grid.cellToWorld(a1, a2)) - Vector3.new(0, CellSize / 2, 0)
    local v3 = RaycastParams.new()
    v3.FilterType = Enum.RaycastFilterType.Exclude
    local v4 = {}

    if u79 then
        table.insert(v4, u79)
    end

    if LocalPlayer.Character then
        table.insert(v4, LocalPlayer.Character)
    end

    v3.FilterDescendantsInstances = v4
    v4 = workspace:Raycast(v2, Vector3.new(0, -v1, 0), v3)

    if v4 and (v2 - v4.Position).Magnitude < CellSize - 0.05 then
        u104()
        return
    end

    local v5, v6 = ensurePipePreview()
    v5.WorldPosition = v2
    local Position = if not v4 then v2 - Vector3.new(0, v1, 0) else v4.Position
    v6.WorldPosition = Position
end

local function resolveTarget()
    -- Line: 1431
    -- upvalues: u78 (ref), targetCell (val), u162 (ref), u160 (ref), Grid (val), u110 (val), canRotate (val)
    -- upvalues: Config (val), u142 (ref), u159 (ref), pastBoundary (val), LocalPlayer (val), occupiedCellsNear (val)
    -- upvalues: looksPlaceable (val), u139 (ref)
    local v1 = u78
    local v2, v3 = targetCell()

    if v1 and v2 then
        local Character_2, Humanoid, Position, SnapRadiusCells, footprintCells, selectedBlockId_4, selectedBlockId_5,
            v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15

        if u162 then
            u160 = false
            return nil, false
        end

        local v16 = Grid.key(v2)
        local selectedBlockId = u110.selectedBlockId
        local selectedBlockId_2 = u110.selectedBlockId
        local v17 = if not selectedBlockId_2 then
            0
        else
            if canRotate(selectedBlockId_2) then
                (u110.rotations[selectedBlockId_2] or 0) % 360
            else
                0
        local available = u110.available
        local v18 = tostring(v3)
        local selectedBlockId_3 = u110.selectedBlockId
        local v19 = if not selectedBlockId_3 then nil else Config.Build.Blocks[selectedBlockId_3]
        local v20 = false

        if v19 ~= nil then
            v20 = true

            if v19.shape ~= "Slab" then
                v20 = true

                if v19.shape ~= "Stairs" then
                    v20 = v19.shape == "Trapdoor"
                end
            end
        end

        if v20 then
            v5 = false

            if u110.tilted[u110.selectedBlockId] == true then
                v5 = Config.Build.tilts(u110.selectedBlockId)
            end

            v20 = not v5
        end

        if v20 then
            v5 = u142
            v20 = v5 ~= (u110.flipped[u110.selectedBlockId] == true)
        end

        local u125 = ("%*|%*|%*|%*|%*|%*"):format(v16, selectedBlockId, v17, available, v18, (tostring(v20)))
        local v21 = u159
        local u128 = os.clock()

        if v21 and v21.key == u125 and u128 - v21.at < 0.2 then
            u160 = v21.boundary
            return v21.cell, v21.placeable
        end

        local function answer(a1, a2, a3)
            -- Line: 1453
            -- upvalues: u159 (upval), u125 (val), u128 (val), u160 (upval)
            -- types: a2: boolean, a3: boolean?
            u159 = {
                key = u125,
                cell = a1,
                placeable = a2,
                boundary = a3 == true,
                at = u128,
            }
            u160 = a3 == true

            return a1, a2
        end

        if not pastBoundary(v2) then
            if v3 then
                Character_2 = LocalPlayer.Character
                v17 = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")

                if v17 then
                    Humanoid = v17.Parent:FindFirstChildOfClass("Humanoid")
                    Position = v17.Position
                    v14 = Position
                        - Vector3.new(0, (if not Humanoid then 0 else Humanoid.HipHeight) + v17.Size.Y / 2, 0)
                else
                    v14 = nil
                end

                if v14 then
                    v17 = (1 / 0)
                    footprintCells = Grid.footprintCells
                    v19 = Config.Build.footprintOf(u110.selectedBlockId)
                    selectedBlockId_4 = u110.selectedBlockId
                    v20, v5, v19 = footprintCells(v2, v19, if not selectedBlockId_4 then 0 else if canRotate(selectedBlockId_4) then (u110.rotations[selectedBlockId_4] or 0) % 360 else 0)

                    for i6, i7 in v20, v5, v19 do
                        v17 = math.min(v17, ((Grid.cellToWorld(v1, i7)) - v14).Magnitude)
                    end

                    if Config.Player.BuildReachCells * Grid.CellSize < v17 then
                        return answer(v2, false)
                    end
                end
            end

            SnapRadiusCells = Config.Build.Placement.SnapRadiusCells
            v17 = Config.Player.BuildReachCells * Grid.CellSize
            v15, v18, v4, v20 = occupiedCellsNear(v1, v2, SnapRadiusCells)

            if looksPlaceable(v2, v15, v18, v4, v20, v17) then
                return answer(v2, true)
            end

            v1 = u139

            if v3
                and v1
                and (Grid.key(v1)) ~= Grid.key(v2)
                and looksPlaceable(v1, v15, v18, v4, v20, v17) then
                return answer(v1, true)
            end

            selectedBlockId_5 = u110.selectedBlockId

            if selectedBlockId_5 then
                v5 = true

                if Config.Build.Plantables[selectedBlockId_5] == nil then
                    v5 = Config.Crop.isSeed(selectedBlockId_5)
                        or Config.Bush.isSeed(selectedBlockId_5)
                end
            else
                v5 = false
            end

            if v5 then
                return answer(if not v3 then nil else v2, false)
            end

            for i8 = 1, SnapRadiusCells do
                v6 = nil
                v7 = (1 / 0)
                v8 = i8

                for i9 = -i8, v8 do
                    v9 = i8

                    for i10 = -i8, v9 do
                        v10 = i8

                        for i11 = -i8, v10 do
                            v12 = math.abs(i9)
                            v13 = math.abs(i10)

                            if math.max(v12, v13, (math.abs(i11))) == i8 then
                                v11 = Grid.cell(v2.x + i9, v2.y + i10, v2.z + i11)

                                if looksPlaceable(v11, v15, v18, v4, v20, v17) then
                                    v12 = i9 * i9 + i10 * i10 + i11 * i11
                                    v13 = true

                                    if not (v12 < v7) then
                                        v13 = false

                                        if v12 == v7 then
                                            v13 = false

                                            if v6 ~= nil then
                                                v13 = v6.y < v11.y
                                            end
                                        end
                                    end

                                    if v13 then
                                        v7 = v12
                                        v6 = v11
                                    end
                                end
                            end
                        end
                    end
                end

                if v6 then
                    return answer(v6, true)
                end
            end

            return answer(if not v3 then nil else v2, false)
        end

        local Character = LocalPlayer.Character
        v14 = Character and Character:FindFirstChild("HumanoidRootPart")
        v17 = Config.Player.BuildReachCells * Grid.CellSize + Grid.CellSize
        v15 = false

        if v14 ~= nil then
            v15 = ((Grid.cellToWorld(v1, v2)) - v14.Position).Magnitude <= v17
        end

        if not v3 and not v15 then
            if v3 then
                Character_2 = LocalPlayer.Character
                v17 = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")

                if v17 then
                    Humanoid = v17.Parent:FindFirstChildOfClass("Humanoid")
                    Position = v17.Position
                    v14 = Position
                        - Vector3.new(0, (if not Humanoid then 0 else Humanoid.HipHeight) + v17.Size.Y / 2, 0)
                else
                    v14 = nil
                end

                if v14 then
                    v17 = (1 / 0)
                    footprintCells = Grid.footprintCells
                    v19 = Config.Build.footprintOf(u110.selectedBlockId)
                    selectedBlockId_4 = u110.selectedBlockId
                    v20, v5, v19 = footprintCells(v2, v19, if not selectedBlockId_4 then 0 else if canRotate(selectedBlockId_4) then (u110.rotations[selectedBlockId_4] or 0) % 360 else 0)

                    for i, j in v20, v5, v19 do
                        v17 = math.min(v17, ((Grid.cellToWorld(v1, j)) - v14).Magnitude)
                    end

                    if Config.Player.BuildReachCells * Grid.CellSize < v17 then
                        return answer(v2, false)
                    end
                end
            end

            SnapRadiusCells = Config.Build.Placement.SnapRadiusCells
            v17 = Config.Player.BuildReachCells * Grid.CellSize
            v15, v18, v4, v20 = occupiedCellsNear(v1, v2, SnapRadiusCells)

            if looksPlaceable(v2, v15, v18, v4, v20, v17) then
                return answer(v2, true)
            end

            v1 = u139

            if v3
                and v1
                and (Grid.key(v1)) ~= Grid.key(v2)
                and looksPlaceable(v1, v15, v18, v4, v20, v17) then
                return answer(v1, true)
            end

            selectedBlockId_5 = u110.selectedBlockId

            if selectedBlockId_5 then
                v5 = true

                if Config.Build.Plantables[selectedBlockId_5] == nil then
                    v5 = Config.Crop.isSeed(selectedBlockId_5)
                        or Config.Bush.isSeed(selectedBlockId_5)
                end
            else
                v5 = false
            end

            if v5 then
                return answer(if not v3 then nil else v2, false)
            end

            for k = 1, SnapRadiusCells do
                v6 = nil
                v7 = (1 / 0)
                v8 = k

                for n = -k, v8 do
                    v9 = k

                    for m = -k, v9 do
                        v10 = k

                        for i5 = -k, v10 do
                            v12 = math.abs(n)
                            v13 = math.abs(m)

                            if math.max(v12, v13, (math.abs(i5))) == k then
                                v11 = Grid.cell(v2.x + n, v2.y + m, v2.z + i5)

                                if looksPlaceable(v11, v15, v18, v4, v20, v17) then
                                    v12 = n * n + m * m + i5 * i5
                                    v13 = true

                                    if not (v12 < v7) then
                                        v13 = false

                                        if v12 == v7 then
                                            v13 = false

                                            if v6 ~= nil then
                                                v13 = v6.y < v11.y
                                            end
                                        end
                                    end

                                    if v13 then
                                        v7 = v12
                                        v6 = v11
                                    end
                                end
                            end
                        end
                    end
                end

                if v6 then
                    return answer(v6, true)
                end
            end

            return answer(if not v3 then nil else v2, false)
        end

        return answer(v2, false, true)
    end

    return nil, false
end

function u69.setSelectedBlock(a1, a2, a3)
    -- Line: 1569
    -- upvalues: u110 (val)
    -- types: a1: string, a2: number, a3: string?
    u110.selectedBlockId = a1
    u110.available = a2
    u110.selectedRoll = a3
end

function u69.setBuildMode(a1)
    -- Line: 1575
    -- upvalues: u90 (ref), u104 (ref), u82 (ref), u80 (ref)
    -- types: a1: boolean
    u90 = a1

    if not a1 then
        u104()

        for i, j in u82 do
            j.part.Transparency = 1
        end

        if u80 then
            u80.Visible = false
        end
    end
end

local u180 = {}
local u181 = {}

function u69.registerMenu(a1, a2) -- Line: 1595; upvalues: u180 (val), u181 (val); types: a1: string, a2: function
    u180[a1] = a2
    u181[a1] = a2
end

function u69.registerClose(a1, a2) -- Line: 1602; upvalues: u181 (val); types: a1: string, a2: function
    u181[a1] = a2
end

function u69.closeOpen() -- Line: 1607; upvalues: u181 (val), u92 (val)
    local v1 = {}

    for i, j in u181 do
        if u92[i] then
            table.insert(v1, j)
        end
    end

    for k, n in v1 do
        n()
    end

    return #v1 > 0
end

function u69.setUiOpen(a1, a2)
    -- Line: 1620
    -- upvalues: u180 (val), u92 (val), applyLock (val)
    -- types: a1: string, a2: boolean
    if a2 and u180[a1] then
        for i, j in u180 do
            if i ~= a1 and u92[i] then
                j()
            end
        end
    end

    if not a2 then
        u92[a1] = nil
    else
        u92[a1] = true
    end

    applyLock()
end

local u186 = {}
local u187 = 0
local u188 = 0
local u189 = nil

local function clearPrediction(a1) -- Line: 1650; upvalues: u186 (val); types: a1: string
    local v1 = u186[a1]

    if v1 then
        u186[a1] = nil
        v1:Destroy()
    end
end

local function growsAfterPlanting(a1) -- Line: 1665; upvalues: Config (val), PlantLook (val); types: a1: string
    local v1 = Config.Crop.isSeed(a1)

    if not v1 then
        v1 = Config.Bush.isSeed(a1)

        if not v1 then
            v1 = Config.Flower.isFlower(a1)

            if not v1 then
                v1 = true

                if Config.Build.Plantables[a1] == nil then
                    v1 = PlantLook.of(a1) ~= nil
                end
            end
        end
    end

    return v1
end

local function predictPlacement(a1, a2)
    -- Line: 1674
    -- upvalues: u79 (ref), Grid (val), u83 (ref), u81 (ref), growsAfterPlanting (val), u186 (val), u187 (ref)
    -- upvalues: Config (val)
    -- types: a2: number
    local v1 = u79
    local u86 = Grid.key(a1)

    if v1 and v1.Parent and u83 == u86 then
        if u81 and growsAfterPlanting(u81) then
            return
        end

        local v2 = u186[u86]

        if v2 then
            u186[u86] = nil
            v2:Destroy()
        end

        local u102 = v1:Clone()
        u102.Name = "PlacedAtOnce"

        for i, j in u102:GetDescendants() do
            if j:IsA("SelectionBox") then
                j:Destroy()
            elseif j:IsA("BasePart") or j:IsA("Decal") then
                v1 = j:GetAttribute("AuthoredTransparency")

                if type(v1) == "number" then
                    j.Transparency = v1
                end

                if j:IsA("BasePart") then
                    j.CanQuery = true
                    j:SetAttribute("CellKey", u86)
                    j:SetAttribute("PlacedAtOnce", true)
                end
            end
        end

        u102.Parent = workspace
        u186[u86] = u102
        u187 = os.clock()

        task.delay(
            a2 + Config.Build.Placement.PredictSeconds,
            function() -- Line: 1706; upvalues: u186 (upval), u86 (val), u102 (val)
                if u186[u86] == u102 then
                    local v1 = u186[u86]

                    if v1 then
                        u186[u86] = nil
                        v1:Destroy()
                    end
                end
            end
        )
    end
end

function u69.tryPlace()
    -- Line: 1713
    -- upvalues: u91 (ref), u90 (ref), u78 (ref), u110 (val), resolveTarget (val), Config (val), u161 (ref), u162 (ref)
    -- upvalues: HudController (val), u160 (ref), rotationAt (val), Pipes (val), pipeLineAt (val), u188 (ref)
    -- upvalues: u186 (val), u141 (ref), u142 (ref), u74 (val), u83 (ref), Grid (val), u189 (ref)
    -- upvalues: predictPlacement (val)
    if not u91 and u90 and u78 and not (u110.available <= 0) then
        local u7, v1 = resolveTarget()

        if u7 and v1 then
            local v2
            local u44 = rotationAt(u7)

            if Pipes.isPipe(u110.selectedBlockId) then
                local v3
                v1 = pipeLineAt(u7)

                if not (if not v1 then
                    nil
                else
                    Pipes.yawFor(u110.selectedBlockId, v1, (u110.rotations[u110.selectedBlockId] or 0) // 90 % 2 == 0)) then
                    return false
                end

                u44 = v3
            end

            local selectedBlockId = u110.selectedBlockId
            local Placement = Config.Build.Placement
            local v4 = os.clock()
            local v5 = math.max(v4, u188)

            if Placement.MaxQueuedSeconds < v5 - v4 then
                return false
            end

            local v6 = 0

            for i in u186 do
                v6 = v6 + 1
            end

            if u110.available <= v6 then
                return false
            end

            local CooldownSeconds = if Config.Crop.isSeed(selectedBlockId) then
                Placement.SeedCooldownSeconds
            else
                if not Config.Bush.isSeed(selectedBlockId) then
                    Placement.CooldownSeconds
                else
                    Placement.SeedCooldownSeconds
            u188 = v5 + CooldownSeconds + Placement.ClientPaceMarginSeconds
            local u96 = u141
            local selectedBlockId_3 = u110.selectedBlockId
            v6 = if not selectedBlockId_3 then nil else Config.Build.Blocks[selectedBlockId_3]
            local u140 = false

            if v6 ~= nil then
                u140 = true

                if v6.shape ~= "Slab" then
                    u140 = true

                    if v6.shape ~= "Stairs" then
                        u140 = v6.shape == "Trapdoor"
                    end
                end
            end

            if u140 then
                v2 = false

                if u110.tilted[u110.selectedBlockId] == true then
                    v2 = Config.Build.tilts(u110.selectedBlockId)
                end

                u140 = not v2
            end

            if u140 then
                v2 = u142
                u140 = v2 ~= (u110.flipped[u110.selectedBlockId] == true)
            end

            local selectedRoll = u110.selectedRoll
            local u155 = false

            if u110.tilted[u110.selectedBlockId] == true then
                u155 = Config.Build.tilts(u110.selectedBlockId)
            end

            if not (v5 <= v4) then
                task.delay(
                    v5 - v4,
                    function()
                        -- Line: 1768
                        -- upvalues: u74 (upval), u7 (val), selectedBlockId (val), u44 (ref), u96 (val), u140 (val)
                        -- upvalues: selectedRoll (val), u155 (val)
                        u74:FireServer(u7, selectedBlockId, u44, u96, u140, selectedRoll, u155)
                    end
                )
            else
                u74:FireServer(u7, selectedBlockId, u44, u96, u140, selectedRoll, u155)
            end

            if u83 ~= Grid.key(u7) then
                u189()
            end

            predictPlacement(u7, v5 - v4)

            return true
        end

        local Placement_2 = Config.Build.Placement

        if Placement_2.BoundaryAlertSeconds < os.clock() - u161 then
            if u162 then
                u161 = os.clock()
                HudController.showAlert(Placement_2.HubMessage)
            elseif u7 and u160 then
                u161 = os.clock()
                HudController.showAlert(Placement_2.BoundaryMessage)
            end
        end

        return false
    end

    return false
end

local u194 = nil
local u195 = nil

local function setHint(a1)
    -- Line: 1790
    -- upvalues: u194 (ref), u195 (ref), ControlGlyphs (val), u58 (val), canRotate (val), Config (val)
    -- types: a1: string?
    local v1 = u194

    if not v1 then
        return
    end

    if not a1 then
        v1.Visible = false
        u195 = nil

        return
    end

    local v2 = ControlGlyphs.usingGamepad() and not u58.isTouch()
    local v3 = ("%*|%*"):format(a1, v2)

    if v3 ~= u195 then
        u195 = v3

        if not v2 then
            ControlGlyphs.clear(v1)

            v1.Text = (if not u58.isTouch() then "<b>LEFT CLICK</b>  Place" else "<b>TAP</b>  Place")
                .. (if not canRotate(a1) then
                    ""
                else
                    if u58.isTouch() then "" else "     <b>R</b>  Rotate")
                    .. (if not Config.Build.tilts(a1) then
                        ""
                    else
                        if u58.isTouch() then "" else "     <b>Y</b>  Tilt")
        else
            local v4 = {{text = "Place", key = Enum.KeyCode.ButtonR2}}

            if canRotate(a1) then
                table.insert(
                    v4,
                    {text = "Rotate", key = Enum.KeyCode.DPadLeft}
                )
            end

            local v5 = if not a1 then nil else Config.Build.Blocks[a1]
            local v6 = false

            if v5 ~= nil then
                v6 = true

                if v5.shape ~= "Slab" then
                    v6 = true

                    if v5.shape ~= "Stairs" then
                        v6 = v5.shape == "Trapdoor"
                    end
                end
            end

            if v6 then
                table.insert(
                    v4,
                    {text = "Flip", key = Enum.KeyCode.ButtonL2}
                )
            elseif Config.Build.tilts(a1) then
                table.insert(
                    v4,
                    {text = "Tilt", key = Enum.KeyCode.ButtonL2}
                )
            end

            v1.Text = ""
            ControlGlyphs.row(v1, v4, v1)
        end
    end

    v1.Visible = true
end

function u69.tilt() -- Line: 1833; upvalues: Config (val), u110 (val)
    if Config.Build.tilts(u110.selectedBlockId) then
        local selectedBlockId = u110.selectedBlockId
        u110.tilted[selectedBlockId] = not u110.tilted[selectedBlockId]
    end
end

function u69.canFlip(a1) -- Line: 1843; upvalues: Config (val); types: a1: string?
    local v1 = if not a1 then nil else Config.Build.Blocks[a1]
    local v2 = false

    if v1 ~= nil then
        v2 = true

        if v1.shape ~= "Slab" then
            v2 = true

            if v1.shape ~= "Stairs" then
                v2 = v1.shape == "Trapdoor"
            end
        end
    end

    if not v2 then
        v2 = Config.Build.tilts(a1)
    end

    return v2
end

function u69.flip() -- Line: 1851; upvalues: u110 (val), Config (val), u69 (val)
    local selectedBlockId = u110.selectedBlockId

    if selectedBlockId then
        local v1 = if not selectedBlockId then nil else Config.Build.Blocks[selectedBlockId]
        local v2 = false

        if v1 ~= nil then
            v2 = true

            if v1.shape ~= "Slab" then
                v2 = true

                if v1.shape ~= "Stairs" then
                    v2 = v1.shape == "Trapdoor"
                end
            end
        end

        if v2 then
            u110.flipped[selectedBlockId] = not u110.flipped[selectedBlockId]
            return
        end
    end

    if selectedBlockId and Config.Build.tilts(selectedBlockId) then
        u69.tilt()
    end
end

function u69.rotate() -- Line: 1861; upvalues: u110 (val)
    local selectedBlockId = u110.selectedBlockId

    if selectedBlockId then
        u110.rotations[selectedBlockId] = ((u110.rotations[selectedBlockId] or 0) + 90) % 360
    end
end

local function onRenderStep()
    -- Line: 1868
    -- upvalues: u78 (ref), u90 (ref), u91 (ref), u104 (ref), u82 (ref), u80 (ref), u194 (ref), u195 (ref)
    -- upvalues: LocalPlayer (val), Config (val), setHint (val), u110 (val), resolveTarget (val), u79 (ref), u81 (ref)
    -- upvalues: u69 (val), Grid (val), footprintFor (val), rotationAt (val), Pipes (val), pipeLineAt (val), u142 (ref)
    -- upvalues: u83 (ref), u97 (val), u102 (val), showPipePreview (val)
    local v1

    if u78 and u90 and not u91 then
        local identity, v2, v3, v4, v5, v6, v7
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

        if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
            v1 = Config.Hub.SizeStuds / 2
            v3 = HumanoidRootPart.Position - Config.Hub.Origin
            v4 = math.abs(v3.X)

            if v4 <= v1.X then
                v4 = math.abs(v3.Z)

                if v4 <= v1.Z then
                    u104()

                    for i, j in u82 do
                        j.part.Transparency = 1
                    end

                    if u80 then
                        u80.Visible = false
                    end

                    v4 = u194

                    if not v4 then
                        return
                    end

                    v4.Visible = false
                    u195 = nil

                    return
                end
            end
        end

        setHint(u110.selectedBlockId)

        v3, v4 = resolveTarget()

        if not v3 then
            u104()

            for m, i5 in u82 do
                i5.part.Transparency = 1
            end

            if u80 then
                u80.Visible = false
            end

            return
        end

        local selectedBlockId = u110.selectedBlockId
        local v8 = u79

        if not v8 or not v8.Parent or u81 ~= selectedBlockId then
            if u79 then
                u79:Destroy()
            end

            u79 = nil
            u80 = nil
            u81 = nil

            table.clear(u82)

            v5, v6, v7 = u69.ghostModel(selectedBlockId)
            v5.Parent = workspace
            u79 = v5
            u82 = v6
            u80 = v7
            u81 = selectedBlockId
            v2 = v5
        else
            v2 = v8
        end

        local v9 = Grid.footprintCenter(u78, footprintFor(v3))
        v8 = if v2:GetAttribute("Directional") ~= false then rotationAt(v3) else 0
        v5 = nil

        if Pipes.isPipe(u110.selectedBlockId) then
            v6 = pipeLineAt(v3)
            v7 = if not v6 then
                nil
            else
                Pipes.yawFor(u110.selectedBlockId, v6, (u110.rotations[u110.selectedBlockId] or 0) // 90 % 2 == 0)
            v4 = v4 and v7 ~= nil
            v8 = v7 or v8

            if v4 and Pipes.isSpout(u110.selectedBlockId) then
                v5 = v3
            end
        end

        v7 = false

        if u110.tilted[u110.selectedBlockId] == true then
            v7 = Config.Build.tilts(u110.selectedBlockId)
        end

        if not v7 then
            local v10
            local selectedBlockId_3 = u110.selectedBlockId
            local v11 = if not selectedBlockId_3 then
                nil
            else
                Config.Build.Blocks[selectedBlockId_3]
            v7 = false

            if v11 ~= nil then
                v7 = true

                if v11.shape ~= "Slab" then
                    v7 = true

                    if v11.shape ~= "Stairs" then
                        v7 = v11.shape == "Trapdoor"
                    end
                end
            end

            if v7 then
                v10 = false

                if u110.tilted[u110.selectedBlockId] == true then
                    v10 = Config.Build.tilts(u110.selectedBlockId)
                end

                v7 = not v10
            end

            if v7 then
                v10 = u142
                v7 = v10 ~= (u110.flipped[u110.selectedBlockId] == true)
            end

            identity = if not v7 then CFrame.identity else CFrame.Angles(0, 0, 3.141592653589793)
        else
            identity = CFrame.Angles(Config.Build.TiltRadians, 0, 0)
        end

        v2:PivotTo((CFrame.new(v9)) * (CFrame.Angles(0, math.rad(v8), 0)) * identity)

        u83 = Grid.key(v3)
        v6 = u80

        if v6 then
            v6.Color3 = if not v4 then u102 else u97
            v6.SurfaceColor3 = u102
            v6.SurfaceTransparency = if not v4 then 0.7 else 1
            v6.LineThickness = if not v4 then 0.06 else 0.03
        end

        for k, n in u82 do
            n.part.Transparency = n.transparency
        end

        if u80 then
            u80.Visible = true
        end

        if v5 then
            showPipePreview(u78, v5)
            return
        end

        u104()

        return
    end

    u104()

    for i6, i7 in u82 do
        i7.part.Transparency = 1
    end

    if u80 then
        u80.Visible = false
    end

    v1 = u194

    if not v1 then
        return
    end

    v1.Visible = false
    u195 = nil
end

u189 = onRenderStep
local u203 = nil
local IslandRadiusCells_2 = Config.Build.IslandRadiusCells
local u206 = 0
local u207 = 0

local function useGrid(a1, a2, a3)
    -- Line: 1956
    -- upvalues: u78 (ref), IslandRadiusCells (ref), u87 (ref), Config (val)
    -- types: a1: vector?, a2: number, a3: number
    u78 = a1
    IslandRadiusCells = a2
    u87 = Config.Build.boundsForTier(a3)
end

local function refreshIsland()
    -- Line: 1962
    -- upvalues: u207 (ref), LocalPlayer (val), u162 (ref), u203 (ref), Config (val), u78 (ref), IslandRadiusCells (ref)
    -- upvalues: u87 (ref), IslandRadiusCells_2 (ref), u206 (ref)
    local Attribute_3, Magnitude
    local v1 = os.clock()

    if v1 < u207 then
        return
    end

    u207 = v1 + 0.5
    local Character = LocalPlayer.Character
    v1 = Character and Character:FindFirstChild("HumanoidRootPart")

    if not v1 then
        return
    end

    local v2 = nil
    local v3 = 1500

    for i, j in workspace:GetChildren() do
        Attribute_3 = j:GetAttribute("IslandOrigin")

        if typeof(Attribute_3) == "Vector3" then
            Magnitude = Vector3.new(Attribute_3.X - v1.Position.X, 0, Attribute_3.Z - v1.Position.Z).Magnitude

            if Magnitude < v3 then
                v2 = j
                v3 = Magnitude
            end
        end
    end

    local v4 = false

    if v2 == nil then
        v4 = true

        if u203 ~= nil then
            v4 = 1500
                < Vector3.new(u203.X - v1.Position.X, 0, u203.Z - v1.Position.Z).Magnitude
        end
    end

    u162 = v4

    if not v2 then
        local v5 = IslandRadiusCells_2
        local v6 = u206
        u78 = u203
        IslandRadiusCells = v5
        u87 = Config.Build.boundsForTier(v6)

        return
    end

    local Attribute = v2:GetAttribute("IslandOrigin")
    v1 = v2:GetAttribute("TerrainRadius")
    local Attribute_2 = v2:GetAttribute("ExpansionTier")
    local IslandRadiusCells_3 = if type(v1) ~= "number" then
        Config.Build.IslandRadiusCells
    else
        v1
    u78 = Attribute
    IslandRadiusCells = IslandRadiusCells_3
    u87 = Config.Build.boundsForTier(if type(Attribute_2) ~= "number" then 0 else Attribute_2)
end

function u69.start()
    -- Line: 2007
    -- upvalues: u186 (val), Remotes (val), u187 (ref), Config (val), LocalPlayer (val), DeviceMode (val), u194 (ref)
    -- upvalues: u77 (val), u203 (ref), IslandRadiusCells_2 (ref), u206 (ref), u78 (ref), IslandRadiusCells (ref)
    -- upvalues: u87 (ref), u207 (ref), RunService (val), refreshIsland (val), u58 (val), onRenderStep (val)
    workspace.DescendantAdded:Connect(function(a1) -- Line: 2010; upvalues: u186 (upval)
        if next(u186) ~= nil and a1:IsA("BasePart") and not a1:GetAttribute("PlacedAtOnce") then
            local Attribute = a1:GetAttribute("CellKey")

            if type(Attribute) == "string" then
                local v1 = u186[Attribute]

                if v1 then
                    u186[Attribute] = nil
                    v1:Destroy()
                end
            end
        end
    end)

    ;(Remotes.get(Remotes.Alert)).OnClientEvent:Connect(function()
        -- Line: 2019
        -- upvalues: u187 (upval), Config (upval), u186 (upval)
        if os.clock() - u187 < Config.Build.Placement.PredictSeconds then
            local v1

            for i in u186 do
                v1 = u186[i]

                if v1 then
                    u186[i] = nil
                    v1:Destroy()
                end
            end
        end
    end)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PlacementHint"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "Hint"
    local v1 = DeviceMode.touchOnly()
    local HotbarScale = Config.Touch.Hud.HotbarScale
    local v2 = 18 + 62 * HotbarScale + 8 + 26 * HotbarScale + 6
    local v3 = if not v1 then Vector2.new(1, 1) else Vector2.new(0.5, 1)
    TextLabel.AnchorPoint = v3
    v3 = if not v1 then UDim2.new(1, -16, 1, -96) else UDim2.new(0.5, 0, 1, -v2)
    TextLabel.Position = v3
    TextLabel.Size = UDim2.fromOffset(0, 28)
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.BackgroundColor3 = Color3.fromRGB(24, 27, 34)
    TextLabel.BackgroundTransparency = 0.2
    TextLabel.BorderSizePixel = 0
    TextLabel.RichText = true
    TextLabel.Text = ""
    TextLabel.TextColor3 = Color3.fromRGB(225, 230, 240)
    TextLabel.TextSize = 13
    TextLabel.FontFace = Font.new(Config.Appearance.FontFamily, Enum.FontWeight.Medium)
    TextLabel.Visible = false
    TextLabel.Parent = ScreenGui
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 12)
    UIPadding.PaddingRight = UDim.new(0, 12)
    UIPadding.Parent = TextLabel
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = TextLabel
    u194 = TextLabel

    u77.OnClientEvent:Connect(function(a1, a2, a3)
        -- Line: 2063
        -- upvalues: u203 (upval), IslandRadiusCells_2 (upval), Config (upval), u206 (upval), u78 (upval)
        -- upvalues: IslandRadiusCells (upval), u87 (upval), u207 (upval)
        -- types: a1: vector, a2: number, a3: number?
        IslandRadiusCells_2 = if type(a2) ~= "number" then Config.Build.IslandRadiusCells else a2
        u206 = a3 or 0
        local v1 = IslandRadiusCells_2
        local v2 = u206
        u78 = a1
        IslandRadiusCells = v1
        u87 = Config.Build.boundsForTier(v2)
        u207 = 0
    end)

    local u125 = 0
    RunService.RenderStepped:Connect(function(a1)
        -- Line: 2081
        -- upvalues: refreshIsland (upval), u58 (upval), onRenderStep (upval), u125 (ref), Config (upval)
        refreshIsland()

        if not u58.isTouch() then
            onRenderStep()
            return
        end

        u125 = u125 + a1

        if u125 < Config.Touch.Reduced.GhostIntervalSeconds then
            return
        end

        u125 = 0
        onRenderStep()
    end)
end

return u69