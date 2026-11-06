-- Script path: game:GetService("ReplicatedStorage").Shared.Prefabs
-- Decompile time: 12.85 ms

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AppearanceConfig = require(script.Parent.Config.AppearanceConfig)
local Palette = require(script.Parent.Palette)
local ShinyConfig = require(script.Parent.Config.ShinyConfig)
local PatternConfig = require(script.Parent.Config.PatternConfig)
local FlowerConfig = require(script.Parent.Config.FlowerConfig)
local u39 = {
    RootName = "Prefabs",
    EffectsCategory = "Effects",
    NameOverrides = {Glowlight = "Blue Glowlight"},
    GripOffsets = {},
}

function u39.gripCFrame(a1) -- Line: 52; upvalues: u39 (val); types: a1: string
    local v1 = u39.GripOffsets[a1]

    if not v1 then
        return CFrame.identity
    end

    local v2 = v1.offset or Vector3.new(0, 0, 0)
    local v3 = v1.rotation or Vector3.new(0, 0, 0)

    return (CFrame.new(v2))
        * CFrame.Angles(math.rad(v3.X), math.rad(v3.Y), (math.rad(v3.Z)))
end

local function root() -- Line: 62; upvalues: ReplicatedStorage (val), u39 (val)
    return ReplicatedStorage:FindFirstChild(u39.RootName)
end

u39.IdAttribute = "ItemId"
u39.ArtAttribute = "PrefabArt"
u39.SpinTag = "SpinningArt"

function u39.streamWhole(a1) -- Line: 91; types: a1: userdata
    a1.ModelStreamingMode = Enum.ModelStreamingMode.Atomic
end

u39.SpinSpeedAttribute = "SpinDegreesPerSecond"
u39.SpinAxisAttribute = "SpinAxis"
u39.SpinWhileWorkingAttribute = "SpinWhileWorking"
u39.HoverStudsAttribute = "HoverStuds"
u39.HoverSecondsAttribute = "HoverSeconds"
local u55 = {}

local function normalise(a1) -- Line: 112; types: a1: string
    return string.lower((string.gsub(a1, "%s", "")))
end

function u39.categoryFolder(a1) -- Line: 123; upvalues: ReplicatedStorage (val), u39 (val); types: a1: string
    local v1 = ReplicatedStorage:FindFirstChild(u39.RootName)

    if not v1 then
        return nil
    end

    for i in string.gmatch(a1, "[^/]+") do
        v1 = v1:FindFirstChild(i)

        if not v1 then
            return nil
        end
    end

    return v1
end

function u39.idOf(a1) -- Line: 138; upvalues: u39 (val); types: a1: userdata
    local Attribute = a1:GetAttribute(u39.IdAttribute)

    if type(Attribute) == "string" then
        return Attribute
    end

    return nil
end

local u59 = {}

function u39.get(a1, a2) -- Line: 157; upvalues: u55 (val), u59 (val), u39 (val); types: a1: string, a2: string
    local v1 = ("%*/%*"):format(a1, a2)
    local v2 = u55[v1]

    if v2 and v2.Parent then
        return v2
    end

    if u59[v1] then
        return nil
    end

    v2 = u39.categoryFolder(a1)

    if not v2 then
        u59[v1] = true
        return nil
    end

    local Children = v2:GetChildren()

    for i, j in Children do
        if u39.idOf(j) == a2 then
            u55[v1] = j
            return j
        end
    end

    local v3 = u39.NameOverrides[a2]
    local v4 = v3 and v2:FindFirstChild(v3) or v2:FindFirstChild(a2)

    if v4 then
        u55[v1] = v4
        return v4
    end

    v4 = string.lower((string.gsub(v3 or a2, "%s", "")))

    for k, n in Children do
        if string.lower((string.gsub(n.Name, "%s", ""))) == v4 then
            u55[v1] = n
            return n
        end
    end

    u59[v1] = true

    return nil
end

function u39.forEach(a1) -- Line: 206; upvalues: ReplicatedStorage (val), u39 (val); types: a1: function
    local walk

    function walk(a1_2, a2) -- Line: 207; upvalues: walk (val), a1 (val); types: a1_2: userdata, a2: string
        local Name_2
        local v1 = a2

        for i, j in a1_2:GetChildren() do
            if j:IsA("Folder") then
                Name_2 = if v1 ~= "" then ("%*/%*"):format(v1, j.Name) else j.Name
                walk(j, Name_2)
            elseif v1 ~= "" then
                a1(v1, j)
            end
        end
    end

    local v1 = ReplicatedStorage:FindFirstChild(u39.RootName)

    if v1 then
        walk(v1, "")
    end
end

u39.AuthoredAttribute = "AuthoredArt"

function u39.isAuthored(a1) -- Line: 244; upvalues: u39 (val); types: a1: userdata?
    local Parent = a1

    while Parent do
        if Parent:GetAttribute(u39.AuthoredAttribute) == true then
            return true
        end

        Parent = Parent.Parent
    end

    return false
end

function u39.clone(a1, a2) -- Line: 254; upvalues: u39 (val); types: a1: string, a2: string
    local v1 = u39.get(a1, a2)

    if not v1 then
        return nil
    end

    local v2 = v1:Clone()
    v2:SetAttribute(u39.AuthoredAttribute, true)

    return v2
end

function u39.exists(a1, a2) -- Line: 264; upvalues: u39 (val); types: a1: string, a2: string
    return u39.get(a1, a2) ~= nil
end

u39.SearchOrder = {"Tools", "Machines", "Resources", "World", "Wearables"}

function u39.find(a1) -- Line: 281; upvalues: u39 (val); types: a1: string
    local v1

    for i, j in u39.SearchOrder do
        v1 = u39.get(j, a1)

        if v1 then
            return v1, j
        end
    end

    return nil, nil
end

local u73 = {}

local function hideParts(a1, a2) -- Line: 304; upvalues: AppearanceConfig (val); types: a1: userdata, a2: string
    local v1 = AppearanceConfig.hiddenPartsFor(a2)

    if not v1 then
        return a1
    end

    for i, j in if not a1:IsA("BasePart") then a1:GetDescendants() else {a1} do
        if j:IsA("BasePart") and table.find(v1, j.Name) then
            j.Transparency = 1
            j.CanCollide = false
            j.CanQuery = false
        end
    end

    return a1
end

local u75 = {"Petals"}

local function flowerArt(a1) -- Line: 335; upvalues: FlowerConfig (val), u39 (val); types: a1: string
    local v1 = FlowerConfig.speciesOf(a1)

    if v1 then
        return (u39.get("World", (("%*Flower"):format(v1))))
    end

    return nil
end

function u39.paintItem(a1, a2)
    -- Line: 354
    -- upvalues: u39 (val), AppearanceConfig (val), FlowerConfig (val), u75 (val), Palette (val), PatternConfig (val)
    -- types: a1: userdata, a2: string
    local Plastic
    a1:SetAttribute(u39.AuthoredAttribute, true)

    local v1 = AppearanceConfig.tintedPartsFor(a2)
        or (if not FlowerConfig.speciesOf(a2) then nil else u75)

    if not v1 then
        return a1
    end

    local v2 = Palette.colorFor(a2)
    local v3 = PatternConfig.get((PatternConfig.split(a2)))
    local v4 = if not a1:IsA("BasePart") then a1:GetDescendants() else {a1}
    local v5 = nil
    local v6 = nil

    for i, j in v4, v5, v6 do
        if j:IsA("BasePart") then
            if table.find(v1, "*") ~= nil or table.find(v1, j.Name) ~= nil then
                j.Color = v2
                Plastic = v3.material and Enum.Material[v3.material]
                    or Enum.Material.Plastic
                j.Material = Plastic

                u39.wearPattern(j, v3.overlay, v2)
            end
        end
    end

    return a1
end

function u39.forItem(a1, a2)
    -- Line: 389
    -- upvalues: AppearanceConfig (val), FlowerConfig (val), u39 (val), hideParts (val), u73 (val)
    -- types: a1: string, a2: boolean?
    local v1, v2
    local v3, v4 = AppearanceConfig.prefabFor(a1, a2)

    if v3 and v4 then
        local v5
        v1 = u39.get(v3, v4)

        if v1 then
            return u39.paintItem(hideParts(v1:Clone(), a1), a1)
        end

        v2, v5 = u39.find(v4)

        if v2 and v5 then
            if not u73[v4] then
                u73[v4] = true
                warn((("[ABOVE] %* declares its art in %*/%*, but the model is in %*. "):format(a1, v3, v4, v5)) .. ("Using it anyway — move the model, or set category = \"%*\" in AppearanceConfig."):format(v5))
            end

            return u39.paintItem(hideParts(v2:Clone(), a1), a1)
        end

        return nil
    end

    v2 = FlowerConfig.speciesOf(a1)
    v1 = (if not v2 then nil else u39.get("World", (("%*Flower"):format(v2)))) or u39.find(a1)

    if v1 then
        return (u39.paintItem(hideParts(v1:Clone(), a1), a1))
    end

    return nil
end

function u39.artFor(a1) -- Line: 449; upvalues: u39 (val), ShinyConfig (val), Palette (val); types: a1: string
    local v1 = u39.forItem(a1)

    if not v1 and ShinyConfig.isShiny(a1) then
        local v2 = u39.tintableBody("World", "Shiny")

        if v2 then
            v2.Color = Palette.colorFor(a1)
            v2.Material = Enum.Material.Neon
            v1 = v2
        end
    end

    return v1
end

function u39.attachLoose(a1, a2, a3) -- Line: 462; upvalues: u39 (val); types: a1: userdata, a2: string, a3: number
    local v1
    local v2 = u39.artFor(a2)

    if not v2 then
        return nil
    end

    local function largestOf(a1) -- Line: 469; types: a1: userdata
        if a1:IsA("Model") then
            local BoundingBox_2
            _, BoundingBox_2 = a1:GetBoundingBox()

            return (math.max(BoundingBox_2.X, BoundingBox_2.Y, BoundingBox_2.Z))
        end

        if a1:IsA("BasePart") then
            return (math.max(a1.Size.X, a1.Size.Y, a1.Size.Z))
        end

        return 0
    end

    local v3 = largestOf(v2)

    if v3 > 0.01 then
        local v4 = a3 / v3

        if v2:IsA("Model") then
            v2:ScaleTo((v2:GetScale()) * v4)
        elseif v2:IsA("BasePart") then
            v2.Size = v2.Size * v4
        end
    end

    v3 = largestOf(v2)

    if not (a3 * 1.05 < v3) then
        if a3 * 1.05 < v3 and v2:IsA("BasePart") then
            v2.Size = v2.Size * (a3 / v3)
        end
    elseif v2:IsA("Model") then
        v2:ScaleTo((v2:GetScale()) * a3 / v3)
    elseif a3 * 1.05 < v3 and v2:IsA("BasePart") then
        v2.Size = v2.Size * (a3 / v3)
    end

    for i, j in if not v2:IsA("BasePart") then v2:GetDescendants() else {v2} do
        if j:IsA("BasePart") then
            j.Anchored = false
            j.CanCollide = false
            j.CanQuery = false
            j.CanTouch = false
            j.Massless = true
            j.CastShadow = false
        end
    end

    v2:SetAttribute(u39.ArtAttribute, true)

    v2.Parent = a1
    u39.showWorking(a1, false)

    if v2:IsA("Model") then
        local BoundingBox = v2:GetBoundingBox()
        v2:PivotTo(a1.CFrame * (v2:GetPivot():ToObjectSpace(BoundingBox):Inverse()))
    elseif v2:IsA("BasePart") then
        v2.CFrame = a1.CFrame
    end

    for k, n in if not v2:IsA("BasePart") then v2:GetDescendants() else {v2} do
        if n:IsA("BasePart") then
            v1 = Instance.new("WeldConstraint")
            v1.Part0 = a1
            v1.Part1 = n
            v1.Parent = n
        end
    end

    a1.Transparency = 1

    return v2
end

function u39.bodyOf(a1) -- Line: 568; types: a1: userdata
    local v1

    if a1:IsA("BasePart") then
        return a1
    end

    if a1.PrimaryPart then
        return a1.PrimaryPart
    end

    local v2 = nil
    local v3 = -1

    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            v1 = j.Size.X * j.Size.Y * j.Size.Z

            if v3 < v1 then
                v2 = j
                v3 = v1
            end
        end
    end

    return v2
end

local function meshIn(a1) -- Line: 597; types: a1: userdata
    if a1:IsA("MeshPart") then
        return a1
    end

    for i, j in a1:GetDescendants() do
        if j:IsA("MeshPart") then
            return j
        end
    end

    return nil
end

local u84 = {}

function u39.tintableBody(a1, a2)
    -- Line: 627
    -- upvalues: u39 (val), meshIn (val), u84 (val)
    -- types: a1: string, a2: string
    local v1 = u39.clone(a1, a2)

    if not v1 then
        return nil
    end

    local u14 = meshIn(v1)

    if not u14 then
        u14 = u39.bodyOf(v1)
    end

    if not u14 then
        v1:Destroy()
        return nil
    end

    u14.Parent = nil

    if v1 ~= u14 then
        v1:Destroy()
    end

    if u14:IsA("MeshPart")
        and u14.TextureID ~= ""
        and not pcall(function() -- Line: 657; upvalues: u14 (val)
            u14.TextureID = ""
        end)
        and not u84[a2] then
        u84[a2] = true
        warn((("[ABOVE] prefab %*/%* has a TextureID baked into the mesh, which a script "):format(a1, a2)) .. "can't clear. It will paint over the tint — clear it on the MeshPart in Studio.")
    end

    for i, j in u14:GetChildren() do
        if j:IsA("SurfaceAppearance") then
            j:Destroy()
        end
    end

    return u14
end

function u39.wearPattern(a1, a2, a3) -- Line: 696; upvalues: u39 (val); types: a1: userdata, a2: string?, a3: CFrame
    local SurfaceAppearance = a1:FindFirstChildOfClass("SurfaceAppearance")

    if SurfaceAppearance then
        SurfaceAppearance:Destroy()
    end

    if a2 and a1:IsA("MeshPart") then
        local v1 = u39.clone("Patterns", a2)

        if not v1 then
            return nil
        end

        if not v1:IsA("SurfaceAppearance") then
            v1:Destroy()
            return nil
        end

        v1.Color = a3
        v1.AlphaMode = Enum.AlphaMode.Overlay
        v1.Parent = a1

        return v1
    end

    return nil
end

function u39.seatIn(a1, a2, a3) -- Line: 734; upvalues: u39 (val); types: a1: userdata, a2: userdata, a3: number
    local v1 = u39.bodyOf(a1)

    if not v1 then
        if a1:IsA("Model") then
            a1:PivotTo(a2)
        end

        return
    end

    local Rotation = a2.Rotation
    local v2 = CFrame.new(a2.Position.X, a2.Position.Y - a3 / 2 + v1.Size.Y / 2, a2.Position.Z)
        * Rotation

    if a1:IsA("BasePart") then
        a1.CFrame = v2
        return
    end

    a1:PivotTo(v2 * (v1.CFrame:ToObjectSpace((a1:GetPivot()))))
end

u39.AuthoredScaleAttribute = "AuthoredScale"

function u39.scaleFromAuthored(a1, a2) -- Line: 774; upvalues: u39 (val); types: a1: userdata, a2: number
    local Attribute = a1:GetAttribute(u39.AuthoredScaleAttribute)

    if type(Attribute) ~= "number" then
        a1:SetAttribute(u39.AuthoredScaleAttribute, (a1:GetScale()))
    end

    a1:ScaleTo(Attribute * a2)
end

function u39.stillArt(a1) -- Line: 791; upvalues: CollectionService (val), u39 (val); types: a1: userdata
    local SpinTag, SpinTag_2

    for i, j in a1:GetDescendants() do
        SpinTag = u39.SpinTag

        if CollectionService:HasTag(j, SpinTag) then
            SpinTag_2 = u39.SpinTag
            CollectionService:RemoveTag(j, SpinTag_2)
        end
    end
end

u39.WorkingAttribute = "Working"

function u39.showWorking(a1, a2)
    -- Line: 810
    -- upvalues: u39 (val), AppearanceConfig (val)
    -- types: a1: userdata, a2: boolean
    local ArtAttribute, WorkLightPart, WorkVfxAttachment, v1
    a1:SetAttribute(u39.WorkingAttribute, a2)

    local v2 = a2

    for i, j in a1:GetChildren() do
        ArtAttribute = u39.ArtAttribute

        if j:GetAttribute(ArtAttribute) then
            WorkVfxAttachment = AppearanceConfig.WorkVfxAttachment
            v1 = j:FindFirstChild(WorkVfxAttachment, true)

            if v1 then
                for k, n in v1:GetDescendants() do
                    if n:IsA("ParticleEmitter") then
                        n.Enabled = v2
                    end
                end
            end

            WorkLightPart = AppearanceConfig.WorkLightPart
            v1 = j:FindFirstChild(WorkLightPart, true)

            if v1 then
                for m, i5 in v1:GetDescendants() do
                    if i5:IsA("Light") then
                        i5.Enabled = v2
                    end
                end
            end
        end
    end
end

function u39.showActive(a1, a2, a3)
    -- Line: 851
    -- upvalues: AppearanceConfig (val), u39 (val)
    -- types: a1: userdata, a2: string, a3: boolean
    local ArtAttribute, fromRGB, v1, v2
    local v3 = AppearanceConfig.ActiveLook[a2]

    if not v3 then
        return
    end

    local active = if not a3 then v3.idle else v3.active

    for i, j in a1:GetChildren() do
        ArtAttribute = u39.ArtAttribute

        if j:GetAttribute(ArtAttribute) then
            for k, n in j:GetDescendants() do
                if n:IsA("BasePart") and n.Name == v3.partName then
                    if active.transparency ~= nil then
                        n.Transparency = active.transparency
                    end

                    if active.material ~= nil then
                        n.Material = Enum.Material[active.material]
                    end

                    if active.color ~= nil then
                        fromRGB = Color3.fromRGB
                        v1 = active.color[1]
                        v2 = active.color[2]
                        n.Color = fromRGB(v1, v2, active.color[3])
                    end
                end
            end
        end
    end
end

function u39.dress(a1, a2, a3, a4, a5)
    -- Line: 881
    -- upvalues: AppearanceConfig (val), u39 (val), CollectionService (val)
    -- types: a1: userdata, a2: string, a3: boolean?, a4: userdata?, a5: number?
    local HoverSecondsAttribute, HoverSecondsAttribute_2, HoverStudsAttribute, HoverStudsAttribute_2,
        SpinAxisAttribute, SpinAxisAttribute_2, SpinSpeedAttribute, SpinSpeedAttribute_2, SpinSpeedAttribute_3,
        SpinTag, SpinTag_2, SpinTag_3, SpinWhileWorkingAttribute, SpinWhileWorkingAttribute_2, axis, axis_2, seconds,
        seconds_2, speed, speed_2, studs, studs_2, v1, v2

    if AppearanceConfig.of(a2).cap then
        return nil
    end

    local v3 = u39.forItem(a2, a3)

    if not v3 then
        return nil
    end

    local Descendants = if not v3:IsA("BasePart") then v3:GetDescendants() else {v3}
    local v4 = AppearanceConfig.PressStrokes[a2]
    local Reveal = if not v4 then nil else v4.Reveal

    if Reveal then
        local RevealTransparencyAttribute, Transparency

        for i, j in Descendants do
            if j:IsA("BasePart") and j.Name == Reveal then
                RevealTransparencyAttribute = AppearanceConfig.RevealTransparencyAttribute
                Transparency = j.Transparency

                j:SetAttribute(RevealTransparencyAttribute, Transparency)

                j.Transparency = 1
            end
        end
    end

    local v5 = nil
    local v6 = nil
    local v7, v8, v9, v10 = a1, a2, a4, a5

    for k, n in Descendants, v5, v6 do
        if n:IsA("Model") then
            v2 = AppearanceConfig.SpinningParts[n.Name]

            if type(v2) == "table" then
                SpinSpeedAttribute = u39.SpinSpeedAttribute
                speed = v2.speed

                n:SetAttribute(SpinSpeedAttribute, speed)

                SpinAxisAttribute = u39.SpinAxisAttribute
                axis = v2.axis

                n:SetAttribute(SpinAxisAttribute, axis or "Y")

                SpinWhileWorkingAttribute = u39.SpinWhileWorkingAttribute
                v1 = v2.whileWorking == true

                n:SetAttribute(SpinWhileWorkingAttribute, v1)

                if type(v2.hover) == "table" then
                    HoverStudsAttribute = u39.HoverStudsAttribute
                    studs = v2.hover.studs

                    n:SetAttribute(HoverStudsAttribute, studs)

                    HoverSecondsAttribute = u39.HoverSecondsAttribute
                    seconds = v2.hover.seconds

                    n:SetAttribute(HoverSecondsAttribute, seconds)
                end

                SpinTag = u39.SpinTag
                CollectionService:AddTag(n, SpinTag)
                u39.streamWhole(n)
            end
        end

        if n:IsA("BasePart") then
            n.Anchored = true
            n.CanQuery = false
            n.CanTouch = false

            if n.Name == AppearanceConfig.IntakePartName
                or n.Name == AppearanceConfig.OutputPartName then
                n.CanCollide = false
                n.Transparency = 1
            end

            v4 = AppearanceConfig.SpinningParts[n.Name]

            if type(v4) == "number" then
                SpinSpeedAttribute_2 = u39.SpinSpeedAttribute
                n:SetAttribute(SpinSpeedAttribute_2, v4)

                SpinTag_2 = u39.SpinTag
                CollectionService:AddTag(n, SpinTag_2)
            elseif type(v4) == "table" then
                SpinSpeedAttribute_3 = u39.SpinSpeedAttribute
                speed_2 = v4.speed

                n:SetAttribute(SpinSpeedAttribute_3, speed_2)

                SpinAxisAttribute_2 = u39.SpinAxisAttribute
                axis_2 = v4.axis

                n:SetAttribute(SpinAxisAttribute_2, axis_2 or "Y")

                SpinWhileWorkingAttribute_2 = u39.SpinWhileWorkingAttribute
                v1 = v4.whileWorking == true

                n:SetAttribute(SpinWhileWorkingAttribute_2, v1)

                if type(v4.hover) == "table" then
                    HoverStudsAttribute_2 = u39.HoverStudsAttribute
                    studs_2 = v4.hover.studs

                    n:SetAttribute(HoverStudsAttribute_2, studs_2)

                    HoverSecondsAttribute_2 = u39.HoverSecondsAttribute
                    seconds_2 = v4.hover.seconds

                    n:SetAttribute(HoverSecondsAttribute_2, seconds_2)
                end

                SpinTag_3 = u39.SpinTag
                CollectionService:AddTag(n, SpinTag_3)
            end
        end
    end

    v3:SetAttribute(u39.ArtAttribute, true)

    v3.Parent = v7
    u39.showWorking(v7, false)

    local v11 = AppearanceConfig.ArtYawDegrees[v8]
    local CFrame_2 = v9 or v7.CFrame

    if v11 then
        CFrame_2 = CFrame_2 * CFrame.Angles(0, math.rad(v11), 0)
    end

    v11 = AppearanceConfig.ArtOffsetStuds[v8]

    if v11 then
        CFrame_2 = CFrame_2 * CFrame.new(v11.x, v11.y, v11.z)
    end

    u39.seatIn(v3, CFrame_2, v10 or v7.Size.Y)

    v7.Transparency = 1

    return v3
end

return u39