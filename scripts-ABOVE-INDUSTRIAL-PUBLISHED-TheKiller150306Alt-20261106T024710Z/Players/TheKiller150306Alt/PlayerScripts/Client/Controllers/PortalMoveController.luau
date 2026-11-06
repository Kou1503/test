-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.PortalMoveController
-- Decompile time: 13.83 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local Grid = require(Shared.Grid)
local PortalPlacement = require(Shared.PortalPlacement)
local u41 = require(script.Parent.Aim)
local BuildController = require(script.Parent.BuildController)
local DeviceMode = require(script.Parent.DeviceMode)
local Ui = require(script.Parent.Parent.Ui)
local u58 = {}
local LocalPlayer = Players.LocalPlayer
local u63 = Remotes.get(Remotes.RequestPortalMove)
local u68 = Color3.fromRGB(110, 230, 140)
local u73 = Color3.fromRGB(240, 110, 100)
local u74 = nil
local u75 = nil
local u76 = nil
local u77 = nil

function u58.isActive() -- Line: 60; upvalues: u75 (ref)
    return u75 ~= nil
end

local function hitboxOf(a1) -- Line: 65; types: a1: userdata
    if a1:IsA("BasePart") then
        return a1
    end

    local HB = a1:FindFirstChild("HB", true)

    if HB and HB:IsA("BasePart") then
        return HB
    end

    return a1.PrimaryPart
end

local function extentsOf(a1) -- Line: 76; types: a1: userdata
    local PrimaryPart

    if not a1:IsA("BasePart") then
        local HB = a1:FindFirstChild("HB", true)
        PrimaryPart = if not HB then
            a1.PrimaryPart
        else
            if not HB:IsA("BasePart") then a1.PrimaryPart else HB
    else
        PrimaryPart = a1
    end

    if not PrimaryPart then
        local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
        return BoundingBox.Position, BoundingBox_2
    end

    local CFrame_2 = PrimaryPart.CFrame
    local Size = PrimaryPart.Size
    local RightVector = CFrame_2.RightVector
    local UpVector = CFrame_2.UpVector
    local LookVector = CFrame_2.LookVector

    return PrimaryPart.Position,
        (Vector3.new((math.abs(RightVector.X)) * Size.X + (math.abs(UpVector.X)) * Size.Y + (math.abs(LookVector.X)) * Size.Z, (math.abs(RightVector.Y)) * Size.X + (math.abs(UpVector.Y)) * Size.Y + (math.abs(LookVector.Y)) * Size.Z, (math.abs(RightVector.Z)) * Size.X + (math.abs(UpVector.Z)) * Size.Y + (math.abs(LookVector.Z)) * Size.Z))
end

local function findPortal() -- Line: 93; upvalues: u74 (ref), Workspace (val)
    local Attribute
    local v1 = u74

    if not v1 then
        return nil, nil
    end

    for i, j in Workspace:GetChildren() do
        Attribute = j:GetAttribute("IslandOrigin")

        if j:IsA("Model") and typeof(Attribute) == "Vector3" and (Attribute - v1).Magnitude < 1 then
            for k, n in j:GetChildren() do
                if n:GetAttribute("PortalRotation") ~= nil then
                    return j, n
                end
            end

            return j, nil
        end
    end

    return nil, nil
end

local function readOccupied(a1, a2) -- Line: 112; types: a1: userdata, a2: userdata
    local Attribute, Attribute_2
    local v1 = {}
    local v2 = a2

    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and j ~= v2 and not j:IsDescendantOf(v2) then
            Attribute = j:GetAttribute("Cells")

            if type(Attribute) == "string" then
                for k in string.gmatch(Attribute, "[^;]+") do
                    v1[k] = j
                end
            end

            Attribute_2 = j:GetAttribute("CellKey")

            if type(Attribute_2) == "string" then
                v1[Attribute_2] = j
            end
        end
    end

    return v1
end

local function makeGhost(a1) -- Line: 134; types: a1: userdata
    local v1 = a1:Clone()
    v1.Name = "PortalGhost"

    for i, j in v1:GetDescendants() do
        if j:IsA("ProximityPrompt")
            or j:IsA("BillboardGui")
            or j:IsA("Light")
            or j:IsA("ParticleEmitter")
            or j:IsA("Sound") then
            j:Destroy()
        end
    end

    local Descendants_4 = if not v1:IsA("BasePart") then v1:GetDescendants() else {v1}
    local v2 = nil
    local v3 = nil

    for k, n in Descendants_4, v2, v3 do
        if n:IsA("BasePart") then
            n.Anchored = true
            n.CanCollide = false
            n.CanQuery = false
            n.CanTouch = false
            n.CastShadow = false
            n.Transparency = math.max(n.Transparency, 0.55)

            for m, i5 in {"Cells", "CellKey", "Indestructible"} do
                n:SetAttribute(i5, nil)
            end
        end
    end

    return v1
end

local function pivotOf(a1) -- Line: 165; types: a1: userdata
    if a1:IsA("BasePart") then
        return a1.CFrame
    end

    return (a1:GetPivot())
end

local function pivotTo(a1, a2) -- Line: 169; types: a1: userdata, a2: userdata
    if a1:IsA("BasePart") then
        a1.CFrame = a2
        return
    end

    a1:PivotTo(a2)
end

local function seatGhost(a1, a2) -- Line: 179; upvalues: extentsOf (val), Grid (val); types: a1: table
    local v1
    local ghost = a1.ghost
    local v2 = (CFrame.new((if not ghost:IsA("BasePart") then ghost:GetPivot() else ghost.CFrame).Position))
        * CFrame.Angles(0, math.rad(a1.rotation), 0)

    if not ghost:IsA("BasePart") then
        ghost:PivotTo(v2)
    else
        ghost.CFrame = v2
    end

    v2, v1 = extentsOf(ghost)
    local v3 = Grid.baseOfCell(a1.island:GetAttribute("IslandOrigin") or Vector3.new(0, 0, 0), a2)
    local v4 = v2.Y - v1.Y / 2
    local CFrame_3 = if not ghost:IsA("BasePart") then ghost:GetPivot() else ghost.CFrame
    local v5 = CFrame_3
        + Vector3.new(v3.X - v2.X, v3.Y - v4, v3.Z - v2.Z)

    if ghost:IsA("BasePart") then
        ghost.CFrame = v5
        return
    end

    ghost:PivotTo(v5)
end

local function spawnCells(a1) -- Line: 191; upvalues: Grid (val); types: a1: userdata
    local Attribute
    local v1 = {}
    local v2 = {"Member", "Visitor"}
    local v3 = nil
    local v4 = nil

    for i, j in v2, v3, v4 do
        Attribute = a1:GetAttribute((("%*Spawn"):format(j)))
        table.insert(v1, if typeof(Attribute) ~= "Vector3" then Grid.cell(0, 0, 0) else Grid.cell(Attribute.X, Attribute.Y, Attribute.Z))
    end

    return v1
end

local function refusalFor(a1, a2)
    -- Line: 203
    -- upvalues: PortalPlacement (val), Grid (val), Config (val), spawnCells (val)
    -- types: a1: table
    return PortalPlacement.refusal(
        PortalPlacement.cells(a2, PortalPlacement.sizeAt(a1.size, a1.measuredAt, a1.rotation), Grid.CellSize),
        {
            inBounds = function(a1_2) -- Line: 207; upvalues: Grid (upval), a1 (val)
                return Grid.isInBounds(Grid.cell(a1_2.x, a1_2.y, a1_2.z), a1.bounds)
            end,
            isEmpty = function(a1_2) -- Line: 210; upvalues: a1 (val), Grid (upval)
                return a1.occupied[Grid.key(Grid.cell(a1_2.x, a1_2.y, a1_2.z))]
                    == nil
            end,
            isSolidGround = function(a1_2) -- Line: 213; upvalues: a1 (val), Grid (upval), Config (upval)
                local v1 = a1.occupied[Grid.key(Grid.cell(a1_2.x, a1_2.y, a1_2.z))]
                local Attribute = if not v1 then nil else v1:GetAttribute("BlockId")
                v1 = if not Attribute then nil else Config.Build.Blocks[Attribute]
                local v2 = false

                if v1 ~= nil then
                    v2 = false

                    if v1.shape == nil then
                        v2 = not v1.walkThrough
                    end
                end

                return v2
            end,
            spawns = spawnCells(a1.island),
        },
        Config.Hub.PortalMove.SpawnClearanceCells
    )
end

local function keys() -- Line: 223; upvalues: u41 (val)
    if u41.isTouch() then
        return ""
    end

    return "<b>CLICK</b>  Place     <b>R</b>  Rotate     <b>ESC</b>  Cancel"
end

local function update()
    -- Line: 230
    -- upvalues: u75 (ref), u58 (val), u41 (val), Workspace (val), Grid (val), u77 (ref), refusalFor (val)
    -- upvalues: seatGhost (val), u73 (val), u68 (val)
    local v1 = u75

    if not v1 then
        return
    end

    if v1.island.Parent and v1.portal.Parent then
        local v2 = u41.ray()
        local v3 = RaycastParams.new()
        v3.FilterType = Enum.RaycastFilterType.Include
        v3.FilterDescendantsInstances = {v1.island}
        local v4 = Workspace:Raycast(v2.Origin, v2.Direction.Unit * 400, v3)
        v3 = nil
        local Instance_2 = if not v4 then nil else v4.Instance

        while Instance_2 do
            if Instance_2 == v1.island then
                break
            end

            v3 = Instance_2:GetAttribute("CellKey")

            if type(v3) == "string" then
                break
            end

            Instance_2 = Instance_2.Parent
        end

        if not (if not v4 then
            nil
        else
            if type(v3) ~= "string" then
                nil
            else
                if not (0.5 < v4.Normal.Y) then nil else Grid.fromKey(v3)) then
            v1.target = nil
            v1.ghost.Parent = nil
            u77.Text = (if not u41.isTouch() then
                "<b>CLICK</b>  Place     <b>R</b>  Rotate     <b>ESC</b>  Cancel"
            else
                "")
                .. (if (if not u41.isTouch() then
                    "<b>CLICK</b>  Place     <b>R</b>  Rotate     <b>ESC</b>  Cancel"
                else
                    "")
                    == "" then
                    ""
                else
                    "     ")
                    .. "Aim at the top of a block"

            return
        end

        v4 = Grid.cell(v2.x, v2.y + 1, v2.z)
        v1.target = v4
        v1.refusal = refusalFor(v1, v4)

        seatGhost(v1, v4)

        v1.ghost.Parent = Workspace
        v4 = if not v1.refusal then u68 else u73
        v1.highlight.FillColor = v4
        v1.highlight.OutlineColor = v4
        u77.Text = if not v1.refusal then
            if (if not u41.isTouch() then
                "<b>CLICK</b>  Place     <b>R</b>  Rotate     <b>ESC</b>  Cancel"
            else
                "")
                == "" then
                "Tap PLACE to move your portal here"
            else
                if not u41.isTouch() then
                    "<b>CLICK</b>  Place     <b>R</b>  Rotate     <b>ESC</b>  Cancel"
                else
                    ""
        else
            ("<font color=\"#F07064\">%*</font>"):format(v1.refusal)

        return
    end

    u58.cancel()
end

local function stop() -- Line: 276; upvalues: u75 (ref), u76 (ref), BuildController (val)
    local v1 = u75

    if not v1 then
        return
    end

    u75 = nil

    if v1.connection then
        v1.connection:Disconnect()
    end

    v1.ghost:Destroy()

    u76.Enabled = false
    BuildController.setUiOpen("PortalMove", false)
end

function u58.begin()
    -- Line: 292
    -- upvalues: u75 (ref), LocalPlayer (val), Config (val), findPortal (val), extentsOf (val), makeGhost (val)
    -- upvalues: readOccupied (val), BuildController (val), u76 (ref), RunService (val), update (val)
    if u75 or LocalPlayer:GetAttribute(Config.Monetization.PortalMoverAttribute) ~= true then
        return
    end

    local v1, v2 = findPortal()

    if v1 and v2 then
        local v3
        _, v3 = extentsOf(v2)
        local v4 = v2:GetAttribute("PortalRotation") or 0
        local v5 = makeGhost(v2)
        local Highlight = Instance.new("Highlight")
        Highlight.FillTransparency = 0.6
        Highlight.OutlineTransparency = 0.2
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
        Highlight.Parent = v5
        local v6 = {
            island = v1,
            portal = v2,
            ghost = v5,
            highlight = Highlight,
            size = {x = v3.X, y = v3.Y, z = v3.Z},
            measuredAt = v4,
            rotation = v4,
            occupied = readOccupied(v1, v2),
            bounds = Config.Build.boundsForTier(v1:GetAttribute("ExpansionTier") or 0),
        }
        u75 = v6

        BuildController.setUiOpen("PortalMove", true)

        u76.Enabled = true
        v6.connection = RunService.RenderStepped:Connect(update)
    end
end

function u58.rotate() -- Line: 332; upvalues: u75 (ref)
    local v1 = u75

    if v1 then
        v1.rotation = (v1.rotation + 90) % 360
    end
end

function u58.confirm() -- Line: 340; upvalues: u75 (ref), u63 (val), u76 (ref), BuildController (val)
    local v1 = u75

    if v1 and v1.target then
        if v1.refusal then
            return
        end

        u63:FireServer(v1.target, v1.rotation)

        v1 = u75

        if not v1 then
            return
        end

        u75 = nil

        if v1.connection then
            v1.connection:Disconnect()
        end

        v1.ghost:Destroy()

        u76.Enabled = false
        BuildController.setUiOpen("PortalMove", false)
    end
end

function u58.cancel() -- Line: 352; upvalues: u75 (ref), u76 (ref), BuildController (val)
    local v1 = u75

    if not v1 then
        return
    end

    u75 = nil

    if v1.connection then
        v1.connection:Disconnect()
    end

    v1.ghost:Destroy()

    u76.Enabled = false
    BuildController.setUiOpen("PortalMove", false)
end

local function button(a1, a2, a3, a4)
    -- Line: 356
    -- upvalues: Ui (val)
    -- types: a1: userdata, a2: string, a3: number, a4: function
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromOffset(110, 40)
    TextButton.LayoutOrder = a3
    TextButton.BackgroundColor3 = Color3.fromRGB(26, 29, 36)
    TextButton.BackgroundTransparency = 0.15
    TextButton.Text = a2
    TextButton.TextColor3 = Color3.fromRGB(232, 236, 245)
    TextButton.TextSize = 14
    TextButton.FontFace = Ui.Font.Bold

    Ui.corner(TextButton, 8)
    Ui.stroke(TextButton, Color3.fromRGB(58, 62, 78))

    TextButton.Parent = a1
    TextButton.Activated:Connect(a4)

    return TextButton
end

function u58.start()
    -- Line: 373
    -- upvalues: u76 (ref), LocalPlayer (val), DeviceMode (val), u77 (ref), Config (val), Ui (val), button (val)
    -- upvalues: u58 (val), Remotes (val), u74 (ref), stop (val)
    u76 = Instance.new("ScreenGui")
    u76.Name = "PortalMove"
    u76.ResetOnSpawn = false
    u76.Enabled = false
    u76.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local Frame = Instance.new("Frame")
    Frame.AnchorPoint = Vector2.new(0.5, 1)
    Frame.Position = UDim2.new(0.5, 0, 1, if not DeviceMode.touchOnly() then -100 else -110)
    Frame.Size = UDim2.fromOffset(0, 80)
    Frame.AutomaticSize = Enum.AutomaticSize.X
    Frame.BackgroundTransparency = 1
    Frame.Parent = u76
    u77 = Instance.new("TextLabel")
    u77.AnchorPoint = Vector2.new(0.5, 0)
    u77.Position = UDim2.fromScale(0.5, 0)
    u77.Size = UDim2.fromOffset(0, 28)
    u77.AutomaticSize = Enum.AutomaticSize.X
    u77.BackgroundColor3 = Color3.fromRGB(24, 27, 34)
    u77.BackgroundTransparency = 0.2
    u77.RichText = true
    u77.Text = ""
    u77.TextColor3 = Color3.fromRGB(225, 230, 240)
    u77.TextSize = 13
    u77.FontFace = Font.new(Config.Appearance.FontFamily, Enum.FontWeight.Medium)
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 12)
    UIPadding.PaddingRight = UDim.new(0, 12)
    UIPadding.Parent = u77

    Ui.corner(u77, 6)

    u77.Parent = Frame
    local Frame_2 = Instance.new("Frame")
    Frame_2.AnchorPoint = Vector2.new(0.5, 1)
    Frame_2.Position = UDim2.fromScale(0.5, 1)
    Frame_2.Size = UDim2.fromOffset(0, 40)
    Frame_2.AutomaticSize = Enum.AutomaticSize.X
    Frame_2.BackgroundTransparency = 1
    Frame_2.Parent = Frame
    local v1 = Instance.new("UIListLayout")
    v1.FillDirection = Enum.FillDirection.Horizontal
    v1.Padding = UDim.new(0, 8)
    v1.SortOrder = Enum.SortOrder.LayoutOrder
    v1.Parent = Frame_2

    button(Frame_2, "ROTATE", 1, u58.rotate)
    button(Frame_2, "PLACE", 2, u58.confirm)
    button(Frame_2, "CANCEL", 3, u58.cancel)

    ;(Remotes.get(Remotes.IslandReady)).OnClientEvent:Connect(function(a1) -- Line: 424; upvalues: u74 (upval)
        if typeof(a1) == "Vector3" then
            u74 = a1
        end
    end)

    ;(Remotes.get(Remotes.PortalMoveOpen)).OnClientEvent:Connect(u58.begin)
    LocalPlayer.CharacterRemoving:Connect(stop)
end

return u58