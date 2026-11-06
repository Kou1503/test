-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.CartController
-- Decompile time: 7.06 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Grid = require(Shared.Grid)
local Rails = require(Shared.Rails)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u30 = nil

local function pushVector(a1) -- Line: 63; types: a1: userdata
    local MoveDirection = a1.MoveDirection

    if MoveDirection.Magnitude < 0.05 then
        return nil
    end

    return {y = 0, x = MoveDirection.X, z = MoveDirection.Z}
end

local function index(a1, a2) -- Line: 71; upvalues: Rails (val); types: a1: table, a2: userdata
    if a2:IsA("BasePart") and Rails.isRail(a2:GetAttribute("BlockId")) then
        local Attribute = a2:GetAttribute("CellKey")

        if type(Attribute) == "string" then
            a1[Attribute] = a2
        end
    end
end

local function lookupFor(a1) -- Line: 81; upvalues: Grid (val); types: a1: table
    return function(a1_2) -- Line: 82; upvalues: a1 (val), Grid (upval)
        local v1 = a1[Grid.key(Grid.cell(a1_2.x, a1_2.y, a1_2.z))]

        if v1 and v1.Parent then
            local Attribute = v1:GetAttribute("Rotation")
            local Attribute_2 = v1:GetAttribute("BlockId")

            if type(Attribute) == "number" then
                return Attribute_2, Attribute
            end

            return Attribute_2, 0
        end

        return nil, nil
    end
end

local function stop() -- Line: 92; upvalues: u30 (ref)
    local v1 = u30
    u30 = nil

    if v1 then
        for i, j in v1.connections do
            j:Disconnect()
        end
    end
end

local function cellKey(a1) -- Line: 102; upvalues: Grid (val)
    return Grid.key(Grid.cell(a1.x, a1.y, a1.z))
end

local function launch(a1, a2) -- Line: 107; upvalues: Rails (val), Config (val), Grid (val); types: a1: table
    local v1, v2 = Rails.point(a2.cell, a2.itemId, a2.yaw, a2.s)
    local v3 = Vector3.new(v2.x, v2.y, v2.z)
    v2 = if not (0 <= a2.v) then -v3 else v3
    local v4 = {
        t = 0,
        position = a1.origin + Vector3.new(v1.x, v1.y, v1.z),
        velocity = v2 * math.abs(a2.v)
            + Vector3.new(0, 1, 0) * Config.Rail.Flight.LiftSpeed,
    }
    local cell = a2.cell
    v4.leftKey = Grid.key(Grid.cell(cell.x, cell.y, cell.z))
    a1.flight = v4
    a1.ride = nil
end

local function crash(a1) -- Line: 122; types: a1: table
    a1.flight = nil
    a1.crashed = true
    a1.humanoid.Sit = false
    a1.humanoid.Jump = true
end

local function fly(a1, a2, a3)
    -- Line: 130
    -- upvalues: Config (val), Grid (val), Rails (val)
    -- types: a1: table, a2: table, a3: number
    local v1
    local Flight = Config.Rail.Flight
    local root = a1.root
    a2.t = a2.t + a3
    local v2 = a2.velocity - Vector3.new(0, 1, 0) * Flight.Gravity * a3
    local v3 = a2.position + (a2.velocity + v2) / 2 * a3

    if v2.Y <= 0 then
        v1 = v3 - a1.origin
        local rails = a1.rails
        local v4, v5 = Rails.nearest(
            {x = v1.X, y = v1.Y, z = v1.Z},
            function(a1) -- Line: 82; upvalues: rails (val), Grid (upval)
                local v1 = rails[Grid.key(Grid.cell(a1.x, a1.y, a1.z))]

                if v1 and v1.Parent then
                    local Attribute = v1:GetAttribute("Rotation")
                    local Attribute_2 = v1:GetAttribute("BlockId")

                    if type(Attribute) == "number" then
                        return Attribute_2, Attribute
                    end

                    return Attribute_2, 0
                end

                return nil, nil
            end
        )

        if v4 and v5 <= Flight.CatchStuds then
            local cell = v4.cell

            if Grid.key(Grid.cell(cell.x, cell.y, cell.z)) ~= a2.leftKey then
                local v6
                _, v6 = Rails.point(v4.cell, v4.itemId, v4.yaw, v4.s)
                v4.v = math.clamp(v2:Dot((Vector3.new(v6.x, v6.y, v6.z))), -Config.Rail.Physics.MaxSpeed, Config.Rail.Physics.MaxSpeed)
                a1.facing = if not (0 <= v4.v) then -1 else 1
                a1.ride = v4
                a1.flight = nil

                return
            end
        end
    end

    v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    v1.FilterDescendantsInstances = {root:FindFirstAncestorOfClass("Model") or root, a1.humanoid.Parent}
    local v7 = workspace:Raycast(a2.position + Vector3.new(0, 0.5, 0), v3 - a2.position, v1)
    v1 = false

    if v7 ~= nil then
        v1 = Rails.isRail(v7.Instance:GetAttribute("BlockId"))
    end

    if v7 and not v1 then
        a1.flight = nil
        a1.crashed = true
        a1.humanoid.Sit = false
        a1.humanoid.Jump = true

        return
    end

    if Flight.MaxSeconds < a2.t then
        a1.flight = nil
        a1.crashed = true
        a1.humanoid.Sit = false
        a1.humanoid.Jump = true

        return
    end

    a2.position = v3
    a2.velocity = v2
    v7 = Vector3.new(v2.X, 0, v2.Z)
    root.CFrame = (CFrame.lookAt(v3, v3 + (if not (0.01 < v7.Magnitude) then root.CFrame.LookVector else v7.Unit)))
        * CFrame.new(0, root.Size.Y / 2, 0)
    root.AssemblyLinearVelocity = v2
    root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
end

local function step(a1)
    -- Line: 175
    -- upvalues: u30 (ref), fly (val), Grid (val), Rails (val), Config (val), launch (val)
    -- types: a1: number
    local v1
    local v2 = u30

    if not v2 then
        return
    end

    local root = v2.root

    if not root.Parent then
        v1 = u30
        u30 = nil

        if v1 then
            for i, j in v1.connections do
                j:Disconnect()
            end
        end

        return
    end

    if not root.Anchored and not v2.crashed then
        local v3, v4, v5
        local flight = v2.flight

        if flight then
            fly(v2, flight, (math.min(a1, 0.1)))
            return
        end

        local rails = v2.rails

        function v1(a1) -- Line: 82; upvalues: rails (val), Grid (upval)
            local v1 = rails[Grid.key(Grid.cell(a1.x, a1.y, a1.z))]

            if v1 and v1.Parent then
                local Attribute = v1:GetAttribute("Rotation")
                local Attribute_2 = v1:GetAttribute("BlockId")

                if type(Attribute) == "number" then
                    return Attribute_2, Attribute
                end

                return Attribute_2, 0
            end

            return nil, nil
        end

        if not v2.ride then
            local v6 = (root.CFrame * CFrame.new(0, -root.Size.Y / 2, 0)).Position
                - v2.origin
            v3 = Rails.nearest(
                {x = v6.X, y = v6.Y, z = v6.Z},
                v1
            )

            if not v3 then
                return
            end

            _, v5 = Rails.point(v3.cell, v3.itemId, v3.yaw, v3.s)
            local LookVector = root.CFrame.LookVector
            v2.facing = if not (0
                <= LookVector.X * v5.x + LookVector.Y * v5.y
                    + LookVector.Z * v5.z) then
                -1
            else
                1
            v2.ride = v3
        end

        local ride = v2.ride
        local step = Rails.step
        v5 = math.min(a1, 0.1)
        local MoveDirection = v2.humanoid.MoveDirection

        step(
            ride,
            v5,
            v1,
            if not (MoveDirection.Magnitude < 0.05) then
                {y = 0, x = MoveDirection.X, z = MoveDirection.Z}
            else
                nil,
            Config.Rail.Physics
        )

        if ride.launched then
            launch(v2, ride)
        end

        if 0 < ride.v then
            v2.facing = 1
        elseif ride.v < 0 then
            v2.facing = -1
        end

        v3, v4 = Rails.point(ride.cell, ride.itemId, ride.yaw, ride.s)
        v1 = v2.origin + Vector3.new(v3.x, v3.y, v3.z)
        v3 = Vector3.new(v4.x, v4.y, v4.z)
        root.CFrame = (CFrame.lookAt(v1, v1 + v3 * v2.facing))
            * CFrame.new(0, root.Size.Y / 2, 0)
        root.AssemblyLinearVelocity = v3 * ride.v
        root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end
end

local function start(a1, a2)
    -- Line: 229
    -- upvalues: u30 (ref), index (val), RunService (val), step (val)
    -- types: a1: userdata, a2: userdata
    local v1 = u30
    u30 = nil

    if v1 then
        for i, j in v1.connections do
            j:Disconnect()
        end
    end

    local Parent = a1.Parent

    if Parent and Parent:IsA("Model") then
        local PrimaryPart = Parent.PrimaryPart
        local Attribute = Parent:GetAttribute("IslandOrigin")

        if PrimaryPart and PrimaryPart:GetAttribute("CartId") ~= nil and typeof(Attribute) == "Vector3" then
            local Parent_2 = Parent.Parent and Parent.Parent.Parent
            v1 = Parent_2 and Parent_2:FindFirstChild("Blocks")

            if not v1 then
                return
            end

            local u47 = {}

            for k, n in v1:GetChildren() do
                index(u47, n)
            end

            local v2 = {
                facing = 1,
                seat = a1,
                humanoid = a2,
                root = PrimaryPart,
                origin = Attribute,
                rails = u47,
                connections = {},
            }
            table.insert(
                v2.connections,
                (v1.ChildAdded:Connect(function(a1) -- Line: 263; upvalues: index (upval), u47 (val)
                    index(u47, a1)
                end))
            )

            table.insert(
                v2.connections,
                (v1.ChildRemoved:Connect(function(a1) -- Line: 269; upvalues: u47 (val)
                    local Attribute = a1:GetAttribute("CellKey")

                    if type(Attribute) == "string" and u47[Attribute] == a1 then
                        u47[Attribute] = nil
                    end
                end))
            )

            table.insert(v2.connections, (RunService.PreSimulation:Connect(step)))

            u30 = v2
        end
    end
end

local function watch(a1) -- Line: 280; upvalues: start (val), u30 (ref); types: a1: userdata
    local Humanoid = a1:WaitForChild("Humanoid", 10)

    if not Humanoid then
        return
    end

    ;(Humanoid:GetPropertyChangedSignal("SeatPart")):Connect(function()
        -- Line: 285
        -- upvalues: Humanoid (val), start (upval), u30 (upval)
        local SeatPart = Humanoid.SeatPart

        if SeatPart and SeatPart.Name == "CartSeat" then
            start(SeatPart, Humanoid)
            return
        end

        local v1 = u30
        u30 = nil

        if v1 then
            for i, j in v1.connections do
                j:Disconnect()
            end
        end
    end)
end

function v1.start() -- Line: 295; upvalues: LocalPlayer (val), watch (val), u30 (ref), start (val)
    if LocalPlayer.Character then
        task.spawn(watch, LocalPlayer.Character)
    end

    LocalPlayer.CharacterAdded:Connect(function(a1) -- Line: 299; upvalues: u30 (upval), start (upval)
        local v1 = u30
        u30 = nil

        if v1 then
            for i, j in v1.connections do
                j:Disconnect()
            end
        end

        local Humanoid = a1:WaitForChild("Humanoid", 10)

        if not Humanoid then
            return
        end

        ;(Humanoid:GetPropertyChangedSignal("SeatPart")):Connect(function()
            -- Line: 285
            -- upvalues: Humanoid (val), start (upval), u30 (upval)
            local SeatPart = Humanoid.SeatPart

            if SeatPart and SeatPart.Name == "CartSeat" then
                start(SeatPart, Humanoid)
                return
            end

            local v1 = u30
            u30 = nil

            if v1 then
                for i, j in v1.connections do
                    j:Disconnect()
                end
            end
        end)
    end)
end

return v1