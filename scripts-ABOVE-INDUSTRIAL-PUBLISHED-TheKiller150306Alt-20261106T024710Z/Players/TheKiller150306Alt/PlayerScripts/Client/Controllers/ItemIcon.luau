-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ItemIcon
-- Decompile time: 6.36 ms

local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Grid = require(Shared.Grid)
local Palette = require(Shared.Palette)
local Prefabs = require(Shared.Prefabs)
local u21 = {}
local u22 = {
    HB = true,
    [Config.Appearance.IntakePartName] = true,
    [Config.Appearance.OutputPartName] = true,
}

local function boundsOf(a1) -- Line: 40; upvalues: u22 (val); types: a1: userdata
    local v1
    local u74 = nil
    local u101 = nil

    local function absorb(a1) -- Line: 46; upvalues: u74 (ref), u101 (ref); types: a1: userdata
        local v1
        local v2 = a1.Size / 2
        local v3 = {
            Vector3.new(-1, -1, -1),
            Vector3.new(-1, -1, 1),
            Vector3.new(-1, 1, -1),
            Vector3.new(-1, 1, 1),
            Vector3.new(1, -1, -1),
            Vector3.new(1, -1, 1),
            Vector3.new(1, 1, -1),
            (Vector3.new(1, 1, 1)),
        }
        local v4 = nil
        local v5 = nil

        for i, j in v3, v4, v5 do
            v1 = a1.CFrame:PointToWorldSpace(v2 * j)
            u74 = if not u74 then v1 else u74:Min(v1)
            u101 = if not u101 then v1 else u101:Max(v1)
        end
    end

    local v2 = {}

    if a1:IsA("BasePart") then
        table.insert(v2, a1)
    end

    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            table.insert(v2, j)
        end
    end

    local v3 = false

    for k, n in v2 do
        if not u22[n.Name] and n.Transparency < 1 then
            v3 = true
            break
        end
    end

    local v4 = nil
    local v5 = nil

    for m, i5 in v2, v4, v5 do
        v1 = u22[i5.Name]

        if v1 then
            v1 = true

            if i5.Name == "HB" then
                v1 = v3
            end
        end

        if v1 then
            i5.Transparency = 1
        elseif i5.Transparency < 1 then
            absorb(i5)
        end
    end

    if not u74 then
        for i6, i7 in v2 do
            absorb(i7)
        end
    end

    return u74, u101
end

function u21.findPrefab(a1) -- Line: 109; upvalues: Config (val), Prefabs (val); types: a1: string
    local v1, v2 = Config.Appearance.prefabFor(a1)

    if v1 and v2 then
        local v3 = Prefabs.get(v1, v2)

        if v3 then
            return v3
        end

        v3 = Prefabs.find(v2)

        if v3 then
            return v3
        end
    end

    return (Prefabs.find(a1))
end

local function buildChip(a1, a2, a3, a4)
    -- Line: 129
    -- upvalues: Palette (val)
    -- types: a1: userdata, a2: string, a3: number, a4: number
    local Frame = Instance.new("Frame")
    Frame.Name = "Icon"
    Frame.Size = UDim2.fromOffset(a3, a3)
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.fromScale(0.5, 0.5)
    Frame.BackgroundColor3 = Palette.colorFor(a2)
    Frame.BorderSizePixel = 0
    Frame.Parent = a1
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, a4)
    UICorner.Parent = Frame

    return Frame
end

local function buildPrimitive(a1)
    -- Line: 152
    -- upvalues: Grid (val), Config (val), Prefabs (val), Palette (val)
    -- types: a1: string
    local Part_2, v1, v2
    local CellSize = Grid.CellSize
    local v3 = Config.Build.Blocks[a1]
    local shape = if not v3 then nil else v3.shape
    v3 = if not Config.Shiny.isShiny(a1) then
        nil
    else
        Prefabs.tintableBody("World", "Shiny")

    if not v3 then
        local Part = Instance.new("Part")

        if Config.Shiny.isShiny(a1) then
            Part.Shape = Enum.PartType.Ball
        end

        v1 = Part
    else
        v1 = v3
    end

    v1.Name = a1
    v3 = Config.Build.shapeSize(shape, CellSize)
    v1.Size = Vector3.new(v3.x, v3.y, v3.z)
    v1.CFrame = CFrame.identity
    v1.Color = Palette.colorFor(a1)
    v1.Material = Palette.materialFor(a1)
    v1.MaterialVariant = Palette.variantFor(a1)
    v1.Transparency = Palette.transparencyFor(a1)
    v1.Anchored = true
    v1.CanCollide = false
    v3 = Config.Build.shapePieces(shape, CellSize)

    if v3 then
        local v4
        local v5 = Instance.new("Model")
        v2 = nil
        local v6 = nil

        for k, n in v3, v2, v6 do
            v4 = if k ~= 1 then v1:Clone() else v1
            v4.Size = Vector3.new(n.size.x, n.size.y, n.size.z)
            v4.CFrame = CFrame.new(n.offset.x, n.offset.y, n.offset.z)
            v4.Parent = v5
        end

        v5.PrimaryPart = v1

        return v5
    end

    v3 = Palette.capFor(a1)

    if not v3 then
        return v1
    end

    local Model = Instance.new("Model")
    v1.Parent = Model
    v2 = if not v3.bothEnds then {1} else {1, -1}
    local v7 = nil
    local v8 = nil

    for i, j in v2, v7, v8 do
        Part_2 = Instance.new("Part")
        Part_2.Name = if j ~= 1 then "CapUnder" else "Cap"
        Part_2.Size = Vector3.new(CellSize, v3.heightStuds, CellSize)
        Part_2.CFrame = CFrame.new(0, j * (CellSize / 2 - v3.heightStuds / 2), 0)
        Part_2.Color = v3.color
        Part_2.Material = v3.material
        Part_2.MaterialVariant = v3.variant
        Part_2.Anchored = true
        Part_2.CanCollide = false
        Part_2.Parent = Model
    end

    Model.PrimaryPart = v1

    return Model
end

local function buildViewport(a1, a2, a3)
    -- Line: 237
    -- upvalues: boundsOf (val)
    -- types: a1: userdata, a2: userdata, a3: number
    local v1, v2 = boundsOf(a2)

    if v1 and v2 then
        local ViewportFrame = Instance.new("ViewportFrame")
        ViewportFrame.Name = "Icon"
        ViewportFrame.Size = UDim2.fromOffset(a3, a3)
        ViewportFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        ViewportFrame.Position = UDim2.fromScale(0.5, 0.5)
        ViewportFrame.BackgroundTransparency = 1
        ViewportFrame.Ambient = Color3.fromRGB(190, 190, 200)
        ViewportFrame.LightColor = Color3.fromRGB(255, 255, 255)
        ViewportFrame.LightDirection = Vector3.new(-0.4000000059604645, -1, -0.6000000238418579)
        ViewportFrame.Parent = a1

        for i, j in a2:GetDescendants() do
            if j:IsA("BasePart") then
                j.Anchored = true
                j.CanCollide = false
            end
        end

        if a2:IsA("BasePart") then
            a2.Anchored = true
        end

        a2.Parent = ViewportFrame
        local Camera = Instance.new("Camera")
        Camera.Parent = ViewportFrame
        ViewportFrame.CurrentCamera = Camera
        local v3 = (v1 + v2) / 2
        local v4 = (v2 - v1).Magnitude / 2
        v2 = math.max(v4 / math.tan((math.rad(Camera.FieldOfView / 2))) * 1.15, v4 + 1)
        Camera.CFrame = CFrame.lookAt(v3 + Vector3.new(1, 0.550000011920929, 1).Unit * v2, v3)

        return ViewportFrame
    end

    return nil
end

u21.ItemAttribute = "ItemId"

function u21.existing(a1, a2) -- Line: 291; upvalues: u21 (val); types: a1: userdata, a2: string
    local Icon = a1:FindFirstChild("Icon")

    if Icon and Icon:IsA("GuiObject") and Icon:GetAttribute(u21.ItemAttribute) == a2 then
        return Icon
    end

    return nil
end

function u21.render(a1, a2, a3, a4)
    -- Line: 299
    -- upvalues: u21 (val), Prefabs (val), buildPrimitive (val), buildViewport (val), buildChip (val)
    -- types: a1: userdata, a2: string, a3: number, a4: number?
    local v1 = u21.existing(a1, a2)

    if v1 then
        return v1
    end

    local Icon = a1:FindFirstChild("Icon")

    if Icon then
        Icon:Destroy()
    end

    v1 = Prefabs.forItem(a2) or buildPrimitive(a2)
    local v2 = buildViewport(a1, v1, a3)

    if not v2 then
        v1:Destroy()

        v2 = buildChip(a1, a2, a3, a4 or 3)
    end

    v1 = v2
    v1:SetAttribute(u21.ItemAttribute, a2)

    return v1
end

return u21