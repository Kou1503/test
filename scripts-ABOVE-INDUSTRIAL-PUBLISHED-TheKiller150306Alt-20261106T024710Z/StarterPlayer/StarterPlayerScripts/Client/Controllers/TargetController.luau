-- Script path: game:GetService("StarterPlayer").StarterPlayerScripts.Client.Controllers.TargetController
-- Decompile time: 17.20 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local RunService = game:GetService("RunService")
local DeviceMode = require(script.Parent.DeviceMode)
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Prefabs = require(Shared.Prefabs)
local Palette = require(Shared.Palette)
local Rails = require(Shared.Rails)
local Prompts = require(Shared.Prompts)
local Remotes = require(Shared.Remotes)
local u58 = require(script.Parent.Parent.Ui)
local Aim = require(script.Parent.Aim)
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local BuildController = require(script.Parent.BuildController)
local HotbarController = require(script.Parent.HotbarController)
local KeyBinds = require(script.Parent.KeyBinds)
local u84 = {}
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local u89 = DeviceMode.touchOnly()
local u94 = Color3.fromRGB(120, 235, 140)
local u99 = Color3.fromRGB(80, 160, 245)
local u104 = Color3.fromRGB(255, 214, 110)
local u109 = Color3.fromRGB(255, 255, 255)
local u110 = nil
local u111 = nil
local u112 = {}
local u113 = nil
local u114 = nil
local u115 = nil
local u116 = nil
local u117 = {}

local function makeHighlight(a1, a2) -- Line: 86; upvalues: CurrentCamera (val); types: a1: userdata, a2: number
    local Highlight = Instance.new("Highlight")
    Highlight.FillColor = a1
    Highlight.FillTransparency = a2
    Highlight.OutlineColor = a1
    Highlight.OutlineTransparency = 0
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Parent = CurrentCamera

    return Highlight
end

local u123 = Color3.fromRGB(240, 170, 230)
local u124 = nil
local u125 = nil

local function flowerAt(a1) -- Line: 115; upvalues: CollectionService (val); types: a1: string
    local Parent

    for i, j in CollectionService:GetTagged("Flower") do
        if j:GetAttribute("FlowerCell") == a1 then
            Parent = j.Parent

            if Parent and Parent:IsA("Model") then
                return Parent
            end

            return j
        end
    end

    return nil
end

local function showPollenSource(a1)
    -- Line: 125
    -- upvalues: u125 (ref), u124 (ref), flowerAt (val)
    -- types: a1: string?
    u125 = a1
    u124.Adornee = if not a1 then nil else flowerAt(a1)
end

local function rootPart() -- Line: 130; upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    return Character and Character:FindFirstChild("HumanoidRootPart")
end

local u129 = {"Cap", "CapUnder", "Step", "GateBar", "TrapdoorBatten"}

local function showToolHighlight(a1, a2)
    -- Line: 147
    -- upvalues: u94 (val), u110 (ref), u111 (ref), Aim (val), u129 (val), Prefabs (val), u112 (val)
    -- upvalues: CurrentCamera (val)
    -- types: a1: userdata?, a2: userdata?
    local Highlight
    local v1 = a2 or u94
    u110.FillColor = v1
    u110.OutlineColor = v1
    u110.Adornee = a1

    if u111 then
        u111.Color3 = v1
        u111.SurfaceColor3 = v1
        u111.Adornee = if not a1 then
            nil
        else
            if not Aim.isTouch() then
                nil
            else
                if not a1:IsA("BasePart") then
                    nil
                else
                    if a1:GetAttribute("BlockId") == nil then nil else a1
    end

    local v2 = {}

    if a1 and a1:IsA("BasePart") then
        local ArtAttribute, v3

        for i, j in a1:GetChildren() do
            v3 = j:IsA("BasePart") and table.find(u129, j.Name) ~= nil

            if v3 then
                table.insert(v2, j)
            else
                ArtAttribute = Prefabs.ArtAttribute

                if j:GetAttribute(ArtAttribute) then
                    table.insert(v2, j)
                end
            end
        end
    end

    for k = 1, (math.max(#v2, #u112)) do
        Highlight = u112[k]

        if not Highlight and v2[k] then
            Highlight = Instance.new("Highlight")
            Highlight.FillColor = v1
            Highlight.FillTransparency = 0.82
            Highlight.OutlineColor = v1
            Highlight.OutlineTransparency = 0
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
            Highlight.Parent = CurrentCamera
            u112[k] = Highlight
        end

        if Highlight then
            Highlight.FillColor = v1
            Highlight.OutlineColor = v1
            Highlight.Adornee = v2[k]
        end
    end
end

local function requiredToolFor(a1, a2)
    -- Line: 205
    -- upvalues: CollectionService (val), Config (val)
    -- types: a1: userdata, a2: string?
    local v1

    if a1:GetAttribute("Indestructible") then
        return nil, false
    end

    if a1:GetAttribute("BushCell") then
        return if a2 ~= "Axe" then "Pickaxe" else "Axe", false
    end

    if a1:GetAttribute("CropCell") then
        local PrimaryPart = a1
        v1 = a1:FindFirstAncestorOfClass("Model")

        if v1 and v1.PrimaryPart then
            PrimaryPart = v1.PrimaryPart
        end

        if CollectionService:HasTag(PrimaryPart, "RipeCrop") and a2 ~= nil then
            return a2, false
        end

        return "Pickaxe", false
    end

    local Attribute = a1:GetAttribute("NodeType")

    if Attribute then
        v1 = Config.Tool.Nodes[Attribute]
        return if not v1 then nil else v1.requires, Config.Player.AutoEquipForTarget
    end

    if a1:GetAttribute("CartId") or a1:GetAttribute("CellKey") then
        return "Pickaxe", false
    end

    return nil, false
end

local function updateToolTarget(a1)
    -- Line: 245
    -- upvalues: BuildController (val), showToolHighlight (val), HotbarController (val), Rails (val), Config (val)
    -- upvalues: u94 (val), u99 (val), Palette (val), requiredToolFor (val)
    -- types: a1: userdata
    local v1, v2, v3, v4, v5
    local v6 = BuildController.aimedInstance()

    if not v6 then
        showToolHighlight(nil)
        return
    end

    local v7 = HotbarController.selected()

    if Rails.isCart(v7.itemId) then
        v1 = BuildController.aimedBlockPart()
        v2 = false

        if v1 ~= nil then
            v2 = Rails.isRail(v1:GetAttribute("BlockId"))

            if v2 then
                v2 = false

                if 0 < v7.count then
                    v2 = (v1.Position - a1.Position).Magnitude
                        <= Config.Player.InteractReachStuds
                end
            end
        end

        showToolHighlight(if not v2 then nil else v1, u94)

        return
    end

    if v7.itemId == Config.Build.Farm.WateringCan.ItemId then
        v1 = BuildController.aimedBlockPartThroughCrops()
        local Attribute = if not v1 then nil else v1:GetAttribute("BlockId")
        v3 = false

        if v1 ~= nil then
            v3 = false

            if 0 < v7.count then
                if Attribute == "FarmSoil" then
                    v3 = (v1.Position - a1.Position).Magnitude
                        <= Config.Player.InteractReachStuds
                else
                    v3 = false

                    if Attribute == "WaterBlock" then
                        v3 = (v1.Position - a1.Position).Magnitude
                            <= Config.Player.InteractReachStuds
                    end
                end
            end
        end

        showToolHighlight(if not v3 then nil else v1, u99)

        return
    end

    if v7.itemId == Config.Recipe.Compost.Output then
        v1 = BuildController.aimedBlockPartThroughCrops()
        v2 = false

        if v1 ~= nil then
            v2 = false

            if 0 < v7.count then
                v2 = false

                if (v1:GetAttribute("BlockId")) == Config.Crop.RequiredGround then
                    v2 = (v1.Position - a1.Position).Magnitude
                        <= Config.Player.InteractReachStuds
                end
            end
        end

        showToolHighlight(if not v2 then nil else v1, u94)

        return
    end

    local Attribute_3 = v6:GetAttribute("BlockId")
    v2 = BuildController.aimedBlockPart()

    if v2 then
        v6 = v2
        Attribute_3 = v2:GetAttribute("BlockId")
    end

    v2 = Config.Build.containerForBlock(Attribute_3)
    v3 = if not v7.itemId then
        nil
    else
        Config.Build.conversionFor(v7.itemId, Attribute_3)

    if v2 == nil then
        v1 = v3 ~= nil
    else
        v1 = true

        if v7.itemId ~= v2 then
            v1 = v3 ~= nil
        end
    end

    if v1 then
        v2 = (v6.Position - a1.Position).Magnitude <= Config.Player.InteractReachStuds
        v4 = false

        if 0 < v7.count then
            v4 = v2
        end

        showToolHighlight(if not v4 then nil else v6, if not v3 then u94 else Palette.colorFor(v3))

        return
    end

    v4, v5 = requiredToolFor(v6, v7.toolSlot)

    if not v4 or v7.kind ~= "Tool" then
        showToolHighlight(nil)
        return
    end

    if v7.toolSlot ~= v4 and not v5 then
        showToolHighlight(nil)
        return
    end

    if Config.Player.InteractReachStuds < (v6.Position - a1.Position).Magnitude then
        showToolHighlight(nil)
        return
    end

    v5 = v6:FindFirstAncestorOfClass("Model")

    if not v5 then
        showToolHighlight(v6)
        return
    end

    if not v5:GetAttribute("NodeType")
        and not v6:GetAttribute("BushCell")
        and not v6:GetAttribute("CropCell") then
        showToolHighlight(v6)
        return
    end

    showToolHighlight(v5)
end

local u138 = {"LooseItem", "RipeCrop", "Flower", "WildGrass"}

local function isPickup(a1) -- Line: 380; upvalues: u138 (val), CollectionService (val); types: a1: userdata
    for i, j in u138 do
        if CollectionService:HasTag(a1, j) then
            return true
        end
    end

    return false
end

local function pickupPartAt(a1) -- Line: 391; upvalues: u138 (val), CollectionService (val); types: a1: userdata?
    local Parent = a1
    local v1 = a1

    while Parent do
        if Parent == workspace then
            break
        end

        if Parent:IsA("BasePart") then
            for i, j in u138 do
                if CollectionService:HasTag(Parent, j) then
                    if true then
                        return Parent
                    end

                    Parent = Parent.Parent
                    break
                end
            end

            if false then
                return Parent
            end
        end

        Parent = Parent.Parent
    end

    local Parent_2 = if not v1 then nil else v1.Parent

    if Parent_2 and Parent_2:IsA("Model") then
        local PrimaryPart = Parent_2.PrimaryPart or Parent_2:FindFirstChild("HB")

        if PrimaryPart and PrimaryPart:IsA("BasePart") then
            for k, n in u138 do
                if CollectionService:HasTag(PrimaryPart, n) then
                    if true then
                        return PrimaryPart
                    end

                    return nil
                end
            end

            if false then
                return PrimaryPart
            end
        end
    end

    return nil
end

local u146 = RaycastParams.new()
u146.FilterType = Enum.RaycastFilterType.Exclude

local function promptDistance(a1, a2)
    -- Line: 421
    -- upvalues: LocalPlayer (val), u146 (val), Prompts (val)
    -- types: a1: vector, a2: vector
    local Distance, Enabled, ProximityPrompt, v1
    local Character = LocalPlayer.Character
    u146.FilterDescendantsInstances = if not Character then {} else {Character}
    local v2 = workspace:Raycast(a1, a2 * 300, u146)

    if not v2 then
        return nil, nil, nil
    end

    local Instance_2 = v2.Instance

    while Instance_2 do
        if Instance_2 == workspace then
            break
        end

        if Instance_2:IsA("BasePart") then
            ProximityPrompt = Instance_2:FindFirstChildOfClass("ProximityPrompt")

            if ProximityPrompt then
                Enabled = ProximityPrompt.Enabled
                    or ProximityPrompt:GetAttribute(Prompts.BenchedAttribute) == true
                Distance = v2.Distance
                v1 = Instance_2

                if Enabled then
                    return Distance, v1, ProximityPrompt
                end

                return Distance, v1, nil
            end
        end

        Instance_2 = Instance_2.Parent
    end

    return nil, nil, nil
end

local u149 = nil
local u150 = nil
local u151 = nil

local function outlineOf(a1) -- Line: 462; upvalues: Prefabs (val); types: a1: userdata
    local ArtAttribute

    if a1.Transparency < 1 then
        return a1
    end

    for i, j in a1:GetChildren() do
        ArtAttribute = Prefabs.ArtAttribute

        if j:GetAttribute(ArtAttribute) then
            return j
        end
    end

    return a1
end

local function inPromptReach(a1, a2, a3)
    -- Line: 475
    -- upvalues: Prompts (val)
    -- types: a1: userdata, a2: userdata, a3: userdata
    return (a1.Position - a3.Position).Magnitude <= Prompts.pointedReach(a2)
end

function u84.pointedPrompt() -- Line: 479; upvalues: u149 (ref)
    local v1 = u149

    if v1 and v1.Parent then
        return v1
    end

    return nil
end

local u155 = nil

local function showItemLabel(a1, a2)
    -- Line: 487
    -- upvalues: u155 (ref), ControlGlyphs (val), u114 (ref), u115 (ref)
    -- types: a1: string
    if not a2 then
        if u155 then
            ControlGlyphs.clear(u114)

            u155 = nil
        end

        u115.Visible = true
        u115.Text = a1

        return
    end

    local v1 = ("%*|%*"):format(a2.Name, a1)

    if u155 ~= v1 then
        u155 = v1
        local v2 = ControlGlyphs.row(
            u114,
            {{key = a2, text = a1}},
            u115
        )
        v2.AnchorPoint = Vector2.new(0.5, 0.5)
        v2.Position = UDim2.fromScale(0.5, 0.5)
    end

    u115.Visible = false
end

local function updateItemTarget(a1)
    -- Line: 507
    -- upvalues: Config (val), Aim (val), CurrentCamera (val), u89 (val), promptDistance (val), Prompts (val)
    -- upvalues: u151 (ref), u149 (ref), u150 (ref), outlineOf (val), pickupPartAt (val), BuildController (val)
    -- upvalues: CollectionService (val), u117 (val), KeyBinds (val), u116 (ref), u84 (val), u113 (ref), u114 (ref)
    -- upvalues: HotbarController (val), Palette (val), u155 (ref), ControlGlyphs (val), u115 (ref), showItemLabel (val)
    -- types: a1: userdata
    local v1, v2, v3, v4, v5
    local Pickup = Config.Build.Pickup
    local u6 = Aim.ray()
    local Unit = u6.Direction.Unit
    local Position = CurrentCamera.CFrame.Position
    local u80 = nil

    if not u89 then
        v4, v5, v1 = promptDistance(u6.Origin, Unit)
        u80 = v4
        v3 = v5
        local v6 = v1
        v4 = false

        if v3 ~= nil then
            v4 = false

            if v6 ~= nil then
                v4 = (v3.Position - a1.Position).Magnitude <= Prompts.pointedReach(v6)
            end
        end

        u149 = if not v4 then nil else v6
        u150.Adornee = if not v4 then nil else if not v3 then nil else outlineOf(v3)
    else
        if Aim.fingerLive() then
            _, v5, v1 = promptDistance(u6.Origin, Unit)

            if v5
                and v1
                and (v5.Position - a1.Position).Magnitude <= Prompts.pointedReach(v1) then
                u151 = {part = v5, prompt = v1}
            end
        end

        v4 = u151

        if v4 then
            if not v4.part.Parent or not v4.prompt.Parent then
                u151 = nil
            else
                local part = v4.part
                local prompt = v4.prompt

                if not ((part.Position - a1.Position).Magnitude
                    <= Prompts.pointedReach(prompt)) then
                    u151 = nil
                end
            end
        end

        u149 = if not u151 then nil else u151.prompt
        u150.Adornee = if not u151 then nil else outlineOf(u151.part)
    end

    local u127 = math.cos((math.rad(Pickup.AimConeDegrees)))
    v4 = a1.CFrame.LookVector * Vector3.new(1, 0, 1)
    local Unit_2 = if not (0.001 < v4.Magnitude) then Vector3.new(0, 0, 0) else v4.Unit
    local u219 = nil
    local u147 = (1 / 0)

    local function consider(a1_2)
        -- Line: 552
        -- upvalues: u89 (upval), a1 (val), Pickup (val), Unit_2 (ref), u147 (ref), u219 (ref), Position (val)
        -- upvalues: u149 (upval), u80 (ref), u6 (val), Unit (val), u127 (val)
        -- types: a1_2: userdata
        if a1_2:IsA("BasePart") and a1_2.Parent then
            local v1

            if u89 then
                v1 = a1_2.Position - a1.Position
                local Magnitude = v1.Magnitude

                if Pickup.TouchRadiusStuds < Magnitude then
                    return
                end

                local v2 = v1 * Vector3.new(1, 0, 1)
                v2 = Magnitude
                    - (if not (0.001 < v2.Magnitude) then 1 else v2.Unit:Dot(Unit_2))
                        * Pickup.TouchFrontBiasStuds

                if v2 < u147 then
                    u147 = v2
                    u219 = a1_2
                end

                return
            end

            if Pickup.RadiusStuds < (a1_2.Position - a1.Position).Magnitude then
                return
            end

            v1 = a1_2.Position - Position

            if v1.Magnitude < 0.001 or u149 then
                return
            end

            if u80 then
                local Magnitude_3 = (a1_2.Position - u6.Origin).Magnitude

                if u80 + 1 < Magnitude_3 then
                    return
                end
            end

            local v3 = v1.Unit:Dot(Unit)

            if u127 < v3 and -v3 < u147 then
                u147 = -v3
                u219 = a1_2
            end
        end
    end

    if u89 and Aim.fingerLive() then
        v2 = pickupPartAt(BuildController.aimedInstance())

        if v2 and (v2.Position - a1.Position).Magnitude <= Pickup.RadiusStuds then
            u219 = v2
            u147 = (-1 / 0)
        end
    end

    for i, j in CollectionService:GetTagged("LooseItem") do
        consider(j)
    end

    for k, n in CollectionService:GetTagged("RipeCrop") do
        consider(n)
    end

    if not u89 then
        for m, i5 in CollectionService:GetTagged("Flower") do
            consider(i5)
        end
    end

    for i6, i7 in CollectionService:GetTagged("WildGrass") do
        consider(i7)
    end

    v3 = false
    local v7 = nil

    for i8 in u117, nil, v7 do
        if not i8.Parent then
            u117[i8] = nil
        else
            v3 = true
        end
    end

    if u219 and not u89 and KeyBinds.shared() and v3 then
        u116 = u219

        if not u84.pickupUnderAim() then
            u219 = nil
        end
    end

    u116 = u219
    u113.Adornee = u219

    if not u219 then
        u114.Enabled = false
        return
    end

    u114.Adornee = u219
    u114.Enabled = true
    local Name = u219:GetAttribute("CropId")
        or u219:GetAttribute("ItemId") or u219:GetAttribute("FlowerId")
        or u219.Name
    v2 = HotbarController.selected().assignedItemId == Config.Flower.PollinatorItem
    local v8 = CollectionService:HasTag(u219, "Flower")

    if v8 and v2 then
        if u219:GetAttribute("Mature") ~= true then
            v7 = ("GROWING  %*"):format((Palette.displayName(Name)))

            if u155 then
                ControlGlyphs.clear(u114)

                u155 = nil
            end

            u115.Visible = true
            u115.Text = v7

            return
        end

        if u219:GetAttribute("Breeding") == true then
            v7 = ("POLLINATED  %*"):format((Palette.displayName(Name)))

            if u155 then
                ControlGlyphs.clear(u114)

                u155 = nil
            end

            u115.Visible = true
            u115.Text = v7

            return
        end
    end

    local Attribute = u219:GetAttribute("Count")
    local v9 = if type(Attribute) ~= "number" then
        ""
    else
        if not (Attribute > 1) then "" else (" x%*"):format(Attribute)

    if ControlGlyphs.usingGamepad() and not Aim.isTouch() then
        local ButtonR2 = if not v2 then
            Enum.KeyCode.ButtonY
        else
            if not v8 then Enum.KeyCode.ButtonY else Enum.KeyCode.ButtonR2
        showItemLabel(("%*%*"):format(Palette.displayName(Name), v9), ButtonR2)

        return
    end

    local v10 = ("[%*]  %*%*"):format(if not Aim.isTouch() then if not v2 then KeyBinds.pickup().Name else if not v8 then KeyBinds.pickup().Name else "CLICK" else "HOLD", Palette.displayName(Name), v9)

    if u155 then
        ControlGlyphs.clear(u114)

        u155 = nil
    end

    u115.Visible = true
    u115.Text = v10
end

function u84.hasToolTarget() -- Line: 720; upvalues: u110 (ref)
    local v1 = false

    if u110 ~= nil then
        v1 = u110.Adornee ~= nil
    end

    return v1
end

function u84.hasPickupTarget() -- Line: 726; upvalues: u116 (ref)
    local v1 = false

    if u116 ~= nil then
        v1 = u116.Parent ~= nil
    end

    return v1
end

function u84.pickupUnderAim() -- Line: 737; upvalues: u116 (ref), BuildController (val)
    local v1 = u116

    if v1 and v1.Parent then
        local v2 = BuildController.aimedInstance()

        if not v2 then
            return false
        end

        if v2 ~= v1 and not v2:IsDescendantOf(v1) then
            local Parent = v1.Parent

            if Parent and Parent:IsA("Model") then
                local v3 = true

                if Parent.PrimaryPart ~= v1 then
                    v3 = Parent:FindFirstChild("HB") == v1
                end

                return v3 and v2:IsDescendantOf(Parent)
            end

            return false
        end

        return true
    end

    return false
end

function u84.pickupEntityId() -- Line: 761; upvalues: u116 (ref)
    local v1 = u116

    if v1 and v1.Parent then
        return (v1:GetAttribute("EntityId"))
    end

    return nil
end

function u84.harvestTarget() -- Line: 775; upvalues: u116 (ref), CollectionService (val)
    local v1 = u116

    if v1 and v1.Parent then
        if not CollectionService:HasTag(v1, "RipeCrop")
            and not CollectionService:HasTag(v1, "Flower")
            and not CollectionService:HasTag(v1, "WildGrass") then
            return nil
        end

        return v1
    end

    return nil
end

function u84.flowerTarget() -- Line: 794; upvalues: u116 (ref), CollectionService (val)
    local v1 = u116

    if v1 and v1.Parent then
        if CollectionService:HasTag(v1, "Flower") then
            return v1
        end

        return nil
    end

    return nil
end

function u84.start()
    -- Line: 802
    -- upvalues: ProximityPromptService (val), u117 (val), u110 (ref), u94 (val), CurrentCamera (val), u89 (val)
    -- upvalues: DeviceMode (val), u111 (ref), u150 (ref), u109 (val), u113 (ref), u104 (val), u124 (ref), u123 (val)
    -- upvalues: Remotes (val), u125 (ref), flowerAt (val), u114 (ref), u115 (ref), u58 (val), RunService (val)
    -- upvalues: LocalPlayer (val), showToolHighlight (val), u116 (ref), u149 (ref), updateToolTarget (val)
    -- upvalues: updateItemTarget (val)
    ProximityPromptService.PromptShown:Connect(function(a1) -- Line: 804; upvalues: u117 (upval)
        u117[a1] = true
    end)

    ProximityPromptService.PromptHidden:Connect(function(a1) -- Line: 807; upvalues: u117 (upval)
        u117[a1] = nil
    end)

    local v1 = Instance.new("Highlight")
    v1.FillColor = u94
    v1.FillTransparency = 0.82
    v1.OutlineColor = u94
    v1.OutlineTransparency = 0
    v1.DepthMode = Enum.HighlightDepthMode.Occluded
    v1.Parent = CurrentCamera
    u110 = v1

    if u89 or DeviceMode.Hybrid then
        local SelectionBox = Instance.new("SelectionBox")
        SelectionBox.Name = "ToolTargetBox"
        SelectionBox.Color3 = u94
        SelectionBox.LineThickness = 0.06
        SelectionBox.SurfaceColor3 = u94
        SelectionBox.SurfaceTransparency = 0.8
        SelectionBox.Parent = CurrentCamera
        u111 = SelectionBox
    end

    v1 = Instance.new("Highlight")
    v1.FillColor = u109
    v1.FillTransparency = 1
    v1.OutlineColor = u109
    v1.OutlineTransparency = 0
    v1.DepthMode = Enum.HighlightDepthMode.Occluded
    v1.Parent = CurrentCamera
    u150 = v1
    v1 = Instance.new("Highlight")
    v1.FillColor = u104
    v1.FillTransparency = 0.7
    v1.OutlineColor = u104
    v1.OutlineTransparency = 0
    v1.DepthMode = Enum.HighlightDepthMode.Occluded
    v1.Parent = CurrentCamera
    u113 = v1
    v1 = Instance.new("Highlight")
    v1.FillColor = u123
    v1.FillTransparency = 0.72
    v1.OutlineColor = u123
    v1.OutlineTransparency = 0
    v1.DepthMode = Enum.HighlightDepthMode.Occluded
    v1.Parent = CurrentCamera
    u124 = v1

    ;(Remotes.get(Remotes.PollenSource)).OnClientEvent:Connect(function(a1)
        -- Line: 827
        -- upvalues: u125 (upval), u124 (upval), flowerAt (upval)
        local v1
        u125 = if type(a1) ~= "string" then nil else a1
        u124.Adornee = if not v1 then nil else flowerAt(v1)
    end)

    u114 = Instance.new("BillboardGui")
    u114.Size = UDim2.fromOffset(120, 20)
    u114.StudsOffset = Vector3.new(0, 1.600000023841858, 0)
    u114.AlwaysOnTop = true
    u114.Enabled = false
    u114.Parent = CurrentCamera
    u115 = Instance.new("TextLabel")
    u115.Size = UDim2.fromScale(1, 1)
    u115.BackgroundTransparency = 1
    u115.TextColor3 = u104
    u115.TextStrokeTransparency = 0.4
    u115.FontFace = u58.Font.Bold
    u115.TextSize = 13
    u115.Parent = u114
    local u108 = 0

    RunService.RenderStepped:Connect(function(a1)
        -- Line: 857
        -- upvalues: LocalPlayer (upval), showToolHighlight (upval), u113 (upval), u114 (upval), u116 (upval)
        -- upvalues: u149 (upval), u150 (upval), u125 (upval), u124 (upval), flowerAt (upval), updateToolTarget (upval)
        -- upvalues: u108 (ref), updateItemTarget (upval)
        local Character = LocalPlayer.Character
        local v1 = Character and Character:FindFirstChild("HumanoidRootPart")

        if not v1 then
            showToolHighlight(nil)

            u113.Adornee = nil
            u114.Enabled = false
            u116 = nil
            u149 = nil
            u150.Adornee = nil

            return
        end

        if u125 and not u124.Adornee then
            u124.Adornee = flowerAt(u125)
        end

        updateToolTarget(v1)

        u108 = u108 + a1

        if u108 < 0.05 then
            return
        end

        u108 = 0
        updateItemTarget(v1)
    end)
end

return u84