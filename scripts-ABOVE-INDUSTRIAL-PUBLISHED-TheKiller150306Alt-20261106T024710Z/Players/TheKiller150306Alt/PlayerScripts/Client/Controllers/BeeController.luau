-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.BeeController
-- Decompile time: 9.71 ms

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local DeviceMode = require(script.Parent.DeviceMode)
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u40 = require(script.Parent.TimeController)
local v1 = {}
local u43 = DeviceMode.touchOnly()
local Bees = Config.Flower.Bees
local u46 = nil
local u47 = {}
local u48 = {}
local u49 = nil

local function color(a1) -- Line: 63; types: a1: table
    return Color3.fromRGB(a1.r, a1.g, a1.b)
end

local function between(a1) -- Line: 67; types: a1: table
    return a1.min + math.random() * (a1.max - a1.min)
end

local function bloomTop(a1) -- Line: 72; upvalues: Bees (val); types: a1: userdata
    local Parent = a1.Parent
    local Petals = if not Parent then nil else Parent:FindFirstChild("Petals", true)

    if Petals and Petals:IsA("BasePart") then
        return Petals.Position
            + Vector3.new(0, Petals.Size.Y / 2 + Bees.PerchStuds, 0)
    end

    if Parent and Parent:IsA("Model") then
        local BoundingBox, BoundingBox_2 = Parent:GetBoundingBox()
        return BoundingBox.Position
            + Vector3.new(0, BoundingBox_2.Y / 2 + Bees.PerchStuds, 0)
    end

    return a1.Position + Vector3.new(0, a1.Size.Y / 2 + Bees.PerchStuds, 0)
end

local function rescan()
    -- Line: 85
    -- upvalues: u48 (val), Workspace (val), u49 (ref), CollectionService (val), Bees (val), bloomTop (val)
    table.clear(u48)

    local CurrentCamera = Workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local v1 = u49

    if not v1 then
        return
    end

    for i, j in CollectionService:GetTagged("Flower") do
        if j:IsA("BasePart")
            and j:IsDescendantOf(Workspace)
            and j:GetAttribute("FlowerCell") ~= nil
            and j:GetAttribute("Mature") == true
            and (j.Position - CurrentCamera.CFrame.Position).Magnitude <= Bees.RangeStuds
            and Vector3.new(j.Position.X - v1.X, 0, j.Position.Z - v1.Z).Magnitude
                <= Bees.OwnIslandStuds then
            table.insert(u48, (bloomTop(j)))
        end
    end
end

local function newPart(a1, a2, a3, a4) -- Line: 111; types: a1: string, a2: vector, a3: userdata, a4: number
    local Part = Instance.new("Part")
    Part.Name = a1
    Part.Size = a2
    Part.Color = a3
    Part.Transparency = a4
    Part.Material = Enum.Material.SmoothPlastic
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.CastShadow = false
    Part.Locked = true

    return Part
end

local function nextBloom(a1, a2) -- Line: 129; upvalues: u48 (val), Bees (val); types: a1: vector?, a2: vector?
    if #u48 == 0 then
        return nil
    end

    local v1 = {}
    local v2 = nil
    local v3 = nil
    local v4, v5 = a2, a1

    for i, j in u48, v2, v3 do
        if j ~= v4 then
            if v5 == nil or (j - v5).Magnitude <= Bees.HopStuds then
                table.insert(v1, j)
            end
        end
    end

    if #v1 == 0 then
        for k, n in u48 do
            if n ~= v4 then
                table.insert(v1, n)
            end
        end
    end

    if #v1 == 0 then
        return v4
    end

    return v1[math.random(#v1)]
end

local function bend() -- Line: 153; upvalues: Bees (val)
    local v1 = math.random() * 3.141592653589793 * 2
    local v2 = Bees.CurveStuds * (0.4 + math.random() * 0.6)

    return (Vector3.new(math.cos(v1) * v2, (math.random() - 0.3) * v2 * 0.5, (math.sin(v1)) * v2))
end

local function flyTo(a1, a2, a3)
    -- Line: 159
    -- upvalues: bend (val), Bees (val)
    -- types: a1: table, a2: vector, a3: number
    local at = a1.at
    local v1 = a2 - at
    local v2 = at + v1 / 3 + bend()
    local v3 = at + v1 * 0.6666666666666666 + bend()
    v1 = (v2 - at).Magnitude + (v3 - v2).Magnitude + (a2 - v3).Magnitude
    local v4 = {
        from = at,
        c1 = v2,
        c2 = v3,
        to = a2,
        startedAt = a3,
    }
    local SpeedStuds = Bees.SpeedStuds
    local LegPace = Bees.LegPace
    v4.seconds = math.max(0.4, v1 / (SpeedStuds * (LegPace.min + (math.random()) * (LegPace.max - LegPace.min))))
    a1.leg = v4
end

local function wanderOn(a1, a2) -- Line: 179; upvalues: Bees (val), flyTo (val); types: a1: table, a2: number
    local v1 = math.random() * 3.141592653589793 * 2
    local v2 = Bees.WanderRadiusStuds * (0.3 + math.random() * 0.7)
    local v3 = a1.wanderAround:Lerp(Vector3.new(a1.at.X, a1.wanderAround.Y, a1.at.Z), 0.5)
    local v4 = math.cos(v1) * v2
    local WanderHeightStuds = Bees.WanderHeightStuds
    local v5 = v3
        + Vector3.new(v4, WanderHeightStuds.min + math.random() * (WanderHeightStuds.max - WanderHeightStuds.min), (math.sin(v1)) * v2)
    a1.state = "wander"

    flyTo(a1, v5, a2)
end

local function headForFlower(a1, a2)
    -- Line: 192
    -- upvalues: nextBloom (val), flyTo (val)
    -- types: a1: table, a2: number
    local v1 = nextBloom(a1.at, a1.flower)

    if v1 then
        a1.flower = v1
        a1.state = "fly"

        flyTo(a1, v1, a2)

        return
    end

    a1.state = "hover"
    a1.hoverAt = a1.at
    a1.perchUntil = a2 + 1
    a1.wanderLeft = 0
end

local function spawnBee(a1)
    -- Line: 207
    -- upvalues: nextBloom (val), u46 (ref), Bees (val), wanderOn (val), u47 (val)
    -- types: a1: number
    local v1 = nextBloom(nil, nil)

    if v1 and u46 then
        local v2 = Vector3.new(Bees.BodySize.x, Bees.BodySize.y, Bees.BodySize.z)
        local BodyColor = Bees.BodyColor
        local v3 = Color3.fromRGB(BodyColor.r, BodyColor.g, BodyColor.b)
        local v4 = Instance.new("Part")
        v4.Name = "Body"
        v4.Size = v2
        v4.Color = v3
        v4.Transparency = 0
        v4.Material = Enum.Material.SmoothPlastic
        v4.Anchored = true
        v4.CanCollide = false
        v4.CanQuery = false
        v4.CanTouch = false
        v4.CastShadow = false
        v4.Locked = true
        v3 = Vector3.new(Bees.BodySize.x * 1.05, Bees.BodySize.y * 1.05, Bees.BodySize.z * 0.3)
        local StripeColor = Bees.StripeColor
        local v5 = Color3.fromRGB(StripeColor.r, StripeColor.g, StripeColor.b)
        v2 = Instance.new("Part")
        v2.Name = "Stripe"
        v2.Size = v3
        v2.Color = v5
        v2.Transparency = 0
        v2.Material = Enum.Material.SmoothPlastic
        v2.Anchored = true
        v2.CanCollide = false
        v2.CanQuery = false
        v2.CanTouch = false
        v2.CastShadow = false
        v2.Locked = true
        v3 = Vector3.new(Bees.WingSize.x, Bees.WingSize.y, Bees.WingSize.z)
        v5 = Color3.fromRGB(235, 240, 250)
        local WingTransparency = Bees.WingTransparency
        local v6 = Instance.new("Part")
        v6.Name = "WingLeft"
        v6.Size = v3
        v6.Color = v5
        v6.Transparency = WingTransparency
        v6.Material = Enum.Material.SmoothPlastic
        v6.Anchored = true
        v6.CanCollide = false
        v6.CanQuery = false
        v6.CanTouch = false
        v6.CastShadow = false
        v6.Locked = true
        local WingTransparency_2 = Bees.WingTransparency
        local v7 = Instance.new("Part")
        v7.Name = "WingRight"
        v7.Size = v3
        v7.Color = v5
        v7.Transparency = WingTransparency_2
        v7.Material = Enum.Material.SmoothPlastic
        v7.Anchored = true
        v7.CanCollide = false
        v7.CanQuery = false
        v7.CanTouch = false
        v7.CastShadow = false
        v7.Locked = true
        v5 = {v4, v2, v6, v7}

        for i, j in v5 do
            j.Parent = u46
        end

        v7 = v1
            + Vector3.new((math.random() - 0.5) * 6, 3 + math.random() * 2, ((math.random()) - 0.5) * 6)
        v6 = {
            state = "wander",
            perchUntil = 0,
            heading = Vector3.new(0, 0, -1),
            parts = v5,
            wanderLeft = math.random(1, 2),
            wanderAround = v1,
            hoverAt = v7,
            at = v7,
            flower = v1,
            phase = math.random() * 3.141592653589793 * 2,
        }

        wanderOn(v6, a1)
        table.insert(u47, v6)
    end
end

local function removeBee(a1) -- Line: 252; upvalues: u47 (val); types: a1: number
    local v1 = table.remove(u47, a1)

    if v1 then
        for i, j in v1.parts do
            j:Destroy()
        end
    end
end

local function wanted() -- Line: 262; upvalues: u40 (val), u48 (val), u43 (val), Bees (val)
    if not u40.isNight() and #u48 ~= 0 then
        return (math.min(if not u43 then Bees.MaxBees else Bees.MaxBeesTouch, (math.ceil(#u48 / Bees.FlowersPerBee))))
    end

    return 0
end

local function step(a1, a2)
    -- Line: 271
    -- upvalues: Bees (val), wanderOn (val), nextBloom (val), flyTo (val)
    -- types: a1: table, a2: number
    local v1
    local leg = a1.leg

    if a1.state == "perch" then
        if a1.perchUntil <= a2 then
            a1.wanderAround = a1.at
            a1.wanderLeft = math.random(Bees.WanderLegs.min, Bees.WanderLegs.max)

            wanderOn(a1, a2)
        end

        return
    end

    if a1.state == "hover" then
        a1.at = a1.hoverAt
            + Vector3.new(0, math.sin((a2 + a1.phase) * 4) * 0.08, 0)
        v1 = (a2 + a1.phase) * 0.8
        a1.heading = Vector3.new(math.cos(v1), 0, (math.sin(v1)))

        if a1.perchUntil <= a2 then
            if 0 < a1.wanderLeft then
                wanderOn(a1, a2)
                return
            end

            v1 = nextBloom(a1.at, a1.flower)

            if not v1 then
                a1.state = "hover"
                a1.hoverAt = a1.at
                a1.perchUntil = a2 + 1
                a1.wanderLeft = 0

                return
            end

            a1.flower = v1
            a1.state = "fly"

            flyTo(a1, v1, a2)
        end

        return
    end

    if not leg then
        return
    end

    v1 = math.clamp((a2 - leg.startedAt) / leg.seconds, 0, 1)
    local v2 = v1 * v1 * (3 - v1 * 2)
    local v3 = 1 - v2
    local v4 = leg.from * (v3 * v3 * v3) + leg.c1 * (v3 * 3 * v3 * v2)
        + leg.c2 * (v3 * 3 * v2 * v2)
        + leg.to * (v2 * v2 * v2)
    v3 = leg.to - leg.from
    v2 = Vector3.new(v3.X, 0, v3.Z)
    local Unit = if not (0.001 < v2.Magnitude) then
        Vector3.new(1, 0, 0)
    else
        Vector3.new(-v2.Z, 0, v2.X).Unit
    v2 = math.sin(3.141592653589793 * v1)
    v2 = v4
        + Unit
            * ((math.sin(v1 * 3.141592653589793 * 5 + a1.phase)) * Bees.WobbleStuds
                * v2)
    v4 = v2 - a1.at

    if 0.001 < v4.Magnitude then
        a1.heading = v4.Unit
    end

    a1.at = v2

    if v1 >= 1 then
        a1.leg = nil

        if a1.state == "wander" then
            a1.wanderLeft = a1.wanderLeft - 1

            if math.random() < Bees.HoverChance then
                a1.state = "hover"
                a1.hoverAt = a1.at
                local HoverSeconds = Bees.HoverSeconds
                a1.perchUntil = a2
                    + (HoverSeconds.min
                        + math.random() * (HoverSeconds.max - HoverSeconds.min))

                return
            end

            if 0 < a1.wanderLeft then
                wanderOn(a1, a2)
                return
            end

            v4 = nextBloom(a1.at, a1.flower)

            if v4 then
                a1.flower = v4
                a1.state = "fly"

                flyTo(a1, v4, a2)

                return
            end

            a1.state = "hover"
            a1.hoverAt = a1.at
            a1.perchUntil = a2 + 1
            a1.wanderLeft = 0

            return
        end

        a1.state = "perch"
        local LandSeconds = Bees.LandSeconds
        a1.perchUntil = a2
            + (LandSeconds.min + math.random() * (LandSeconds.max - LandSeconds.min))
    end
end

local function draw(a1, a2, a3, a4)
    -- Line: 337
    -- upvalues: Bees (val)
    -- types: a1: table, a2: number, a3: table, a4: table
    local v1 = Vector3.new(a1.heading.X, if a1.state ~= "perch" then a1.heading.Y * 0.4 else 0, a1.heading.Z)

    if v1.Magnitude < 0.001 then
        v1 = Vector3.new(0, 0, -1)
    end

    local v2 = CFrame.lookAt(a1.at, a1.at + v1.Unit)
    v1 = if a1.state ~= "perch" then
        math.abs((math.sin((a2 + a1.phase) * Bees.WingBeatsPerSecond * 3.141592653589793)))
            * 0.75
            + 0.25
    else
        0.15
    local BodySize = Bees.BodySize
    local v3 = BodySize.x / 2 + Bees.WingSize.x / 2
    local v4 = BodySize.y / 2
    local parts = a1.parts

    table.insert(a4, parts[1])
    table.insert(a3, v2)
    table.insert(a4, parts[2])
    table.insert(a3, v2)
    table.insert(a4, parts[3])
    table.insert(a3, v2 * CFrame.new(-v3 * 0.8, v4, 0) * (CFrame.Angles(0, 0, v1)))
    table.insert(a4, parts[4])
    table.insert(a3, v2 * CFrame.new(v3 * 0.8, v4, 0) * (CFrame.Angles(0, 0, -v1)))
end

function v1.start()
    -- Line: 361
    -- upvalues: Workspace (val), u46 (ref), Remotes (val), u49 (ref), RunService (val), Bees (val), rescan (val)
    -- upvalues: u40 (val), u48 (val), u43 (val), u47 (val), spawnBee (val), step (val), draw (val)
    local Folder = Instance.new("Folder")
    Folder.Name = "Bees"
    Folder.Parent = Workspace
    u46 = Folder

    ;(Remotes.get(Remotes.IslandReady)).OnClientEvent:Connect(function(a1) -- Line: 367; upvalues: u49 (upval)
        if typeof(a1) == "Vector3" then
            u49 = a1
        end
    end)

    local u15 = 0
    RunService.RenderStepped:Connect(function()
        -- Line: 374
        -- upvalues: u15 (ref), Bees (upval), rescan (upval), u40 (upval), u48 (upval), u43 (upval), u47 (upval)
        -- upvalues: spawnBee (upval), step (upval), draw (upval), Workspace (upval)
        local v1, v2
        local v3 = os.clock()

        if u15 <= v3 then
            local v4
            u15 = v3 + Bees.RescanSeconds

            rescan()

            v1 = if u40.isNight() then
                0
            else
                if #u48 ~= 0 then
                    math.min(if not u43 then Bees.MaxBees else Bees.MaxBeesTouch, (math.ceil(#u48 / Bees.FlowersPerBee)))
                else
                    0

            while v1 < #u47 do
                v2 = #u47
                v4 = table.remove(u47, v2)

                if v4 then
                    for i, j in v4.parts do
                        j:Destroy()
                    end
                end
            end

            while #u47 < v1 do
                spawnBee(v3)
            end
        end

        if #u47 == 0 then
            return
        end

        v1 = {}
        v2 = {}

        for k, n in u47 do
            step(n, v3)
            draw(n, v3, v2, v1)
        end

        Workspace:BulkMoveTo(v1, v2, Enum.BulkMoveMode.FireCFrameChanged)
    end)
end

return v1