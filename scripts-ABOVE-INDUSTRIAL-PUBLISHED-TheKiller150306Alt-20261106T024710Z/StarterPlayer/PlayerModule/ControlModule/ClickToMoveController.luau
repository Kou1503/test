-- Script path: game:GetService("StarterPlayer").PlayerModule.ControlModule.ClickToMoveController
-- Decompile time: 27.18 ms

local success, err = pcall(function() -- Line: 10
    return UserSettings():IsUserFeatureEnabled("UserExcludeNonCollidableForPathfinding")
end)
local u4 = success and err
local success_2, err_2 = pcall(function() -- Line: 14
    return UserSettings():IsUserFeatureEnabled("UserClickToMoveSupportAgentCanClimb2")
end)
local u9 = success_2 and err_2
local UserInputService = game:GetService("UserInputService")
local u20 = game:GetService("PathfindingService")
local v1 = game:GetService("Players")

game:GetService("Debris")

local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local GuiService = game:GetService("GuiService")
local FlagUtil = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local u62 = FlagUtil.getUserFlag("UserRaycastUpdateAPI2")
local UserPSIASClickToMoveRelaxTeleport = FlagUtil.getUserFlag("UserPSIASClickToMoveRelaxTeleport")
local UserPlayerScriptsRefactor2 = FlagUtil.getUserFlag("UserPlayerScriptsRefactor2")
local UserDoubleJumpButtonFix = FlagUtil.getUserFlag("UserDoubleJumpButtonFix")
local CharacterContext = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CharacterContext")
local u88 = CharacterContext:WaitForChild("ClickToMoveAction")
local ClickToMovePositionAction = CharacterContext:WaitForChild("ClickToMovePositionAction")
local u93 = true
local u94 = true
local u95 = false
local u96 = 1
local u97 = 8
local LocalPlayer = v1.LocalPlayer
local u107 = require(script.Parent:WaitForChild("ClickToMoveDisplay"))
local u109 = RaycastParams.new()
u109.FilterType = Enum.RaycastFilterType.Exclude
local u111 = {}

if not u62 then
    local FindCharacterAncestor, Raycast

    function FindCharacterAncestor(a1) -- Line: 63; upvalues: FindCharacterAncestor (val)
        if not a1 then
            return
        end

        local Humanoid = a1:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            return a1, Humanoid
        end

        return FindCharacterAncestor(a1.Parent)
    end

    u111.FindCharacterAncestor = FindCharacterAncestor

    function Raycast(a1, a2, a3)
        -- Line: 75
        -- upvalues: Workspace (val), FindCharacterAncestor (val), Raycast (val)
        -- types: a2: boolean, a3: table
        local v1 = a3 or {}
        local v2, v3, v4, v5 = Workspace:FindPartOnRayWithIgnoreList(a1, v1)

        if not v2 then
            return nil, nil
        end

        if a2 and v2.CanCollide == false then
            local v6

            if not v2 then
                v6 = nil
            else
                local Humanoid = v2:FindFirstChildOfClass("Humanoid")

                if not Humanoid then
                    local v7, v8 = FindCharacterAncestor(v2.Parent)
                    v6 = v8
                else
                    v6 = Humanoid
                end
            end

            if v6 == nil then
                table.insert(v1, v2)
                return Raycast(a1, a2, v1)
            end
        end

        return v2, v3, v4, v5
    end

    u111.Raycast = Raycast
end

local u114 = {}

local function findPlayerHumanoid(a1) -- Line: 97; upvalues: u114 (val); types: a1: userdata
    local Character = a1 and a1.Character

    if not Character then
        return
    end

    local v1 = u114[a1]

    if v1 and v1.Parent == Character then
        return v1
    end

    u114[a1] = nil
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        u114[a1] = Humanoid
    end

    return Humanoid
end

local u116 = nil
local u117 = nil
local u118 = nil
local u119 = nil

local function GetCharacter() -- Line: 121; upvalues: LocalPlayer (val)
    return LocalPlayer and LocalPlayer.Character
end

local function UpdateIgnoreTag(a1)
    -- Line: 125
    -- upvalues: u117 (ref), u118 (ref), u119 (ref), u116 (ref), LocalPlayer (val), CollectionService (val)
    if a1 == u117 then
        return
    end

    if u118 then
        u118:Disconnect()

        u118 = nil
    end

    if u119 then
        u119:Disconnect()

        u119 = nil
    end

    u117 = a1
    u116 = {LocalPlayer and LocalPlayer.Character}

    if u117 ~= nil then
        for i, v in ipairs((CollectionService:GetTagged(u117))) do
            table.insert(u116, v)
        end

        u118 = (CollectionService:GetInstanceAddedSignal(u117)):Connect(function(a1)
            -- Line: 145
            -- upvalues: u116 (upval)
            table.insert(u116, a1)
        end)
        u119 = (CollectionService:GetInstanceRemovedSignal(u117)):Connect(function(a1)
            -- Line: 149
            -- upvalues: u116 (upval)
            local v1 = #u116

            for i = 1, v1 do
                if u116[i] == a1 then
                    u116[i] = u116[#u116]
                    table.remove(u116)

                    return
                end
            end
        end)
    end
end

local function getIgnoreList() -- Line: 161; upvalues: u116 (ref), LocalPlayer (val)
    if u116 then
        return u116
    end

    u116 = {}
    assert(u116, "")

    local Character = LocalPlayer and LocalPlayer.Character
    table.insert(u116, Character)

    return u116
end

local function minV(a1, a2) -- Line: 171; types: a1: vector, a2: vector
    return (Vector3.new(math.min(a1.X, a2.X), math.min(a1.Y, a2.Y), (math.min(a1.Z, a2.Z))))
end

local function maxV(a1, a2) -- Line: 174
    return (Vector3.new(math.max(a1.X, a2.X), math.max(a1.Y, a2.Y), (math.max(a1.Z, a2.Z))))
end

local function getCollidableExtentsSize(a1) -- Line: 177; types: a1: userdata?
    if a1 ~= nil and a1.PrimaryPart ~= nil then
        local v1, v2, v3
        assert(a1, "")
        assert(a1.PrimaryPart, "")

        local v4 = a1.PrimaryPart.CFrame:Inverse()
        local v5 = Vector3.new((1 / 0), (1 / 0), (1 / 0))
        local v6 = Vector3.new((-1 / 0), (-1 / 0), (-1 / 0))

        for k, v in pairs(a1:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v3 = v4 * v.CFrame
                v1 = Vector3.new(v.Size.X / 2, v.Size.Y / 2, v.Size.Z / 2)

                for i, i2 in ipairs({
                    Vector3.new(v1.X, v1.Y, v1.Z),
                    Vector3.new(v1.X, v1.Y, -v1.Z),
                    Vector3.new(v1.X, -v1.Y, v1.Z),
                    Vector3.new(v1.X, -v1.Y, -v1.Z),
                    Vector3.new(-v1.X, v1.Y, v1.Z),
                    Vector3.new(-v1.X, v1.Y, -v1.Z),
                    Vector3.new(-v1.X, -v1.Y, v1.Z),
                    (Vector3.new(-v1.X, -v1.Y, -v1.Z)),
                }) do
                    v1 = v3 * i2
                    v2 = v5
                    v5 = Vector3.new(math.min(v2.X, v1.X), math.min(v2.Y, v1.Y), (math.min(v2.Z, v1.Z)))
                    v2 = v6
                    v6 = Vector3.new(math.max(v2.X, v1.X), math.max(v2.Y, v1.Y), (math.max(v2.Z, v1.Z)))
                end
            end
        end

        v4 = v6 - v5

        if not (v4.X < 0) and not (v4.Y < 0) and not (v4.Z < 0) then
            return v4
        end

        return nil
    end
end

local function Pather(a1, a2, a3)
    -- Line: 212
    -- upvalues: u95 (ref), LocalPlayer (val), u114 (val), u96 (ref), u4 (val), getCollidableExtentsSize (val), u9 (val)
    -- upvalues: u20 (val), u93 (ref), u107 (val), u97 (ref), UserPSIASClickToMoveRelaxTeleport (val), u62 (val)
    -- upvalues: u109 (val), u116 (ref), Workspace (val)
    -- types: a3: boolean?
    local v1, v2, v3, v4, v5
    local u3 = {}

    if a3 == nil then
        v1 = u95
        v2 = true
    else
        v1 = a3
        v2 = a3
    end

    u3.Cancelled = false
    u3.Started = false
    u3.Finished = Instance.new("BindableEvent")
    u3.PathFailed = Instance.new("BindableEvent")
    u3.PathComputing = false
    u3.PathComputed = false
    u3.OriginalTargetPoint = a1
    u3.TargetPoint = a1
    u3.TargetSurfaceNormal = a2
    u3.DiedConn = nil
    u3.SeatedConn = nil
    u3.BlockedConn = nil
    u3.TeleportedConn = nil
    u3.CurrentPoint = 0
    u3.HumanoidOffsetFromPath = Vector3.new(0, 0, 0)
    u3.CurrentWaypointPosition = nil
    u3.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
    u3.CurrentWaypointPlaneDistance = 0
    u3.CurrentWaypointNeedsJump = false
    u3.CurrentHumanoidPosition = Vector3.new(0, 0, 0)
    u3.CurrentHumanoidVelocity = 0
    u3.NextActionMoveDirection = Vector3.new(0, 0, 0)
    u3.NextActionJump = false
    u3.Timeout = 0
    local v6 = LocalPlayer
    local Character = v6 and v6.Character

    if not Character then
        v3 = nil
    else
        v5 = u114[v6]

        if not v5 or v5.Parent ~= Character then
            u114[v6] = nil
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")

            if Humanoid then
                u114[v6] = Humanoid
            end

            v3 = Humanoid
        else
            v3 = v5
        end
    end

    u3.Humanoid = v3
    u3.OriginPoint = nil
    u3.AgentCanFollowPath = false
    u3.DirectPath = false
    u3.DirectPathRiseFirst = false
    u3.stopTraverseFunc = nil
    u3.setPointFunc = nil
    u3.pointList = nil
    local Humanoid_2 = u3.Humanoid and u3.Humanoid.RootPart

    if Humanoid_2 then
        local v7
        u3.OriginPoint = Humanoid_2.CFrame.Position
        v6 = 2
        v4 = 5
        v5 = true
        local SeatPart = u3.Humanoid.SeatPart

        if not SeatPart or not SeatPart:IsA("VehicleSeat") then
            v7 = nil

            if u4 then
                local Character_2 = LocalPlayer and LocalPlayer.Character

                if Character_2 ~= nil then
                    v7 = getCollidableExtentsSize(Character_2)
                end
            end

            if v7 == nil then
                v7 = (LocalPlayer and LocalPlayer.Character):GetExtentsSize()
            end

            assert(v7, "")

            v6 = u96 * 0.5 * math.sqrt(v7.X * v7.X + v7.Z * v7.Z)
            v4 = u96 * v7.Y
            v5 = 0 < u3.Humanoid.JumpPower
            u3.AgentCanFollowPath = true
            u3.DirectPath = v1
            u3.DirectPathRiseFirst = u3.Humanoid.Sit
        else
            v7 = SeatPart:FindFirstAncestorOfClass("Model")

            if v7 then
                local PrimaryPart = v7.PrimaryPart
                v7.PrimaryPart = SeatPart

                if v2 then
                    local ExtentsSize = v7:GetExtentsSize()
                    v6 = u96 * 0.5
                        * math.sqrt(ExtentsSize.X * ExtentsSize.X + ExtentsSize.Z * ExtentsSize.Z)
                    v4 = u96 * ExtentsSize.Y
                    v5 = false
                    u3.AgentCanFollowPath = true
                    u3.DirectPath = v2
                end

                v7.PrimaryPart = PrimaryPart
            end
        end

        if not u9 then
            u3.pathResult = u20:CreatePath({AgentRadius = v6, AgentHeight = v4, AgentCanJump = v5})
        else
            u3.pathResult = u20:CreatePath({AgentCanClimb = true, AgentRadius = v6, AgentHeight = v4, AgentCanJump = v5})
        end
    end

    function u3.Cleanup(a1) -- Line: 330; upvalues: u3 (val)
        if u3.stopTraverseFunc then
            u3.stopTraverseFunc()

            u3.stopTraverseFunc = nil
        end

        if u3.BlockedConn then
            u3.BlockedConn:Disconnect()

            u3.BlockedConn = nil
        end

        if u3.DiedConn then
            u3.DiedConn:Disconnect()

            u3.DiedConn = nil
        end

        if u3.SeatedConn then
            u3.SeatedConn:Disconnect()

            u3.SeatedConn = nil
        end

        if u3.TeleportedConn then
            u3.TeleportedConn:Disconnect()

            u3.TeleportedConn = nil
        end

        u3.Started = false
    end

    function u3.Cancel(a1) -- Line: 359; upvalues: u3 (val)
        u3.Cancelled = true
        u3:Cleanup()
    end

    function u3.IsActive(a1) -- Line: 364; upvalues: u3 (val)
        return u3.AgentCanFollowPath and u3.Started and not u3.Cancelled
    end

    function u3.OnPathInterrupted(a1) -- Line: 368; upvalues: u3 (val)
        u3.Cancelled = true
        u3:OnPointReached(false)
    end

    function u3.ComputePath(a1) -- Line: 374; upvalues: u3 (val)
        if not u3.OriginPoint then
            return
        end

        if not u3.PathComputed and not u3.PathComputing then
            u3.PathComputing = true

            if u3.AgentCanFollowPath then
                if not u3.DirectPath then
                    u3.pathResult:ComputeAsync(u3.OriginPoint, u3.TargetPoint)

                    u3.pointList = u3.pathResult:GetWaypoints()
                    u3.BlockedConn = u3.pathResult.Blocked:Connect(function(a1) -- Line: 388; upvalues: u3 (upval)
                        u3:OnPathBlocked(a1)
                    end)
                    u3.PathComputed = u3.pathResult.Status == Enum.PathStatus.Success
                else
                    u3.pointList = {
                        PathWaypoint.new(u3.OriginPoint, Enum.PathWaypointAction.Walk),
                        (PathWaypoint.new(u3.TargetPoint, u3.DirectPathRiseFirst and Enum.PathWaypointAction.Jump or Enum.PathWaypointAction.Walk)),
                    }
                    u3.PathComputed = true
                end
            end

            u3.PathComputing = false
        end
    end

    function u3.IsValidPath(a1) -- Line: 396; upvalues: u3 (val)
        u3:ComputePath()
        return u3.PathComputed and u3.AgentCanFollowPath
    end

    u3.Recomputing = false

    function u3.OnPathBlocked(a1, a2) -- Line: 402; upvalues: u3 (val), u93 (upval), u107 (upval)
        if u3.CurrentPoint <= a2 and not u3.Recomputing then
            u3.Recomputing = true

            if u3.stopTraverseFunc then
                u3.stopTraverseFunc()

                u3.stopTraverseFunc = nil
            end

            u3.OriginPoint = u3.Humanoid.RootPart.CFrame.Position
            u3.pathResult:ComputeAsync(u3.OriginPoint, u3.TargetPoint)

            u3.pointList = u3.pathResult:GetWaypoints()

            if #u3.pointList > 0 then
                u3.HumanoidOffsetFromPath = u3.pointList[1].Position - u3.OriginPoint
            end

            u3.PathComputed = u3.pathResult.Status == Enum.PathStatus.Success

            if u93 then
                local v1, v2 = u107.CreatePathDisplay(u3.pointList)
                u3.stopTraverseFunc = v1
                u3.setPointFunc = v2
            end

            if not u3.PathComputed then
                u3.PathFailed:Fire()
                u3:Cleanup()
            else
                u3.CurrentPoint = 1
                u3:OnPointReached(true)
            end

            u3.Recomputing = false
        end
    end

    function u3.OnRenderStepped(a1, a2) -- Line: 438; upvalues: u3 (val), u97 (upval); types: a1: table, a2: number
        if u3.Started and not u3.Cancelled then
            u3.Timeout = u3.Timeout + a2
            local Timeout = u3.Timeout

            if u97 < Timeout then
                u3:OnPointReached(false)
                return
            end

            u3.CurrentHumanoidPosition = u3.Humanoid.RootPart.Position
                + u3.HumanoidOffsetFromPath
            u3.CurrentHumanoidVelocity = u3.Humanoid.RootPart.Velocity

            while u3.Started do
                if not u3:IsCurrentWaypointReached() then
                    break
                end

                u3:OnPointReached(true)
            end

            if u3.Started then
                u3.NextActionMoveDirection = u3.CurrentWaypointPosition - u3.CurrentHumanoidPosition

                if not (1e-06 < u3.NextActionMoveDirection.Magnitude) then
                    u3.NextActionMoveDirection = Vector3.new(0, 0, 0)
                else
                    u3.NextActionMoveDirection = u3.NextActionMoveDirection.Unit
                end

                if u3.CurrentWaypointNeedsJump then
                    u3.NextActionJump = true
                    u3.CurrentWaypointNeedsJump = false

                    return
                end

                u3.NextActionJump = false
            end
        end
    end

    function u3.IsCurrentWaypointReached(a1) -- Line: 476; upvalues: u3 (val)
        local v1

        if if u3.CurrentWaypointPlaneNormal == Vector3.new(0, 0, 0) then
            true
        else
            (u3.CurrentWaypointPlaneNormal:Dot(u3.CurrentHumanoidPosition))
                - u3.CurrentWaypointPlaneDistance
                < math.max(1, 0.0625 * -(u3.CurrentWaypointPlaneNormal:Dot(u3.CurrentHumanoidVelocity))) then
            u3.CurrentWaypointPosition = nil
            u3.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
            u3.CurrentWaypointPlaneDistance = 0
        end

        return v1
    end

    function u3.OnPointReached(a1, a2) -- Line: 502; upvalues: u3 (val)
        if a2 and not u3.Cancelled then
            if u3.setPointFunc then
                u3.setPointFunc(u3.CurrentPoint)
            end

            local v1 = u3.CurrentPoint + 1

            if #u3.pointList < v1 then
                if u3.stopTraverseFunc then
                    u3.stopTraverseFunc()
                end

                u3.Finished:Fire()
                u3:Cleanup()

                return
            end

            local v2 = u3.pointList[u3.CurrentPoint]
            local v3 = u3.pointList[v1]
            local State = u3.Humanoid:GetState()
            local v4 = true

            if State ~= Enum.HumanoidStateType.FallingDown then
                v4 = true

                if State ~= Enum.HumanoidStateType.Freefall then
                    v4 = State == Enum.HumanoidStateType.Jumping
                end
            end

            if v4 then
                local v5 = v3.Action == Enum.PathWaypointAction.Jump

                if not v5 and 1 < u3.CurrentPoint then
                    local v6 = v2.Position - u3.pointList[u3.CurrentPoint - 1].Position
                    local v7 = v3.Position - v2.Position
                    v5 = ((Vector2.new(v6.x, v6.z)).Unit:Dot((Vector2.new(v7.x, v7.z)).Unit))
                        < 0.996
                end

                if v5 then
                    u3.Humanoid.FreeFalling:Wait()
                    wait(0.1)
                end
            end

            u3:MoveToNextWayPoint(v2, v3, v1)

            return
        end

        u3.PathFailed:Fire()
        u3:Cleanup()
    end

    function u3.MoveToNextWayPoint(a1, a2, a3, a4)
        -- Line: 565
        -- upvalues: u3 (val), u9 (upval)
        -- types: a1: table, a2: userdata, a3: userdata, a4: number
        u3.CurrentWaypointPlaneNormal = a2.Position - a3.Position

        if not u9 or a3.Label ~= "Climb" then
            u3.CurrentWaypointPlaneNormal = Vector3.new(u3.CurrentWaypointPlaneNormal.X, 0, u3.CurrentWaypointPlaneNormal.Z)
        end

        if not (1e-06 < u3.CurrentWaypointPlaneNormal.Magnitude) then
            u3.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
            u3.CurrentWaypointPlaneDistance = 0
        else
            u3.CurrentWaypointPlaneNormal = u3.CurrentWaypointPlaneNormal.Unit
            u3.CurrentWaypointPlaneDistance = u3.CurrentWaypointPlaneNormal:Dot(a3.Position)
        end

        u3.CurrentWaypointNeedsJump = a3.Action == Enum.PathWaypointAction.Jump
        u3.CurrentWaypointPosition = a3.Position
        u3.CurrentPoint = a4
        u3.Timeout = 0
    end

    function u3.Start(a1, a2)
        -- Line: 597
        -- upvalues: u3 (val), u107 (upval), u93 (upval), UserPSIASClickToMoveRelaxTeleport (upval)
        if not u3.AgentCanFollowPath then
            u3.PathFailed:Fire()
            return
        end

        if u3.Started then
            return
        end

        u3.Started = true
        u107.CancelFailureAnimation()

        if u93 then
            if a2 == nil or a2 then
                local v1 = u3
                local v2 = u3
                local v3, v4 = u107.CreatePathDisplay(u3.pointList, u3.OriginalTargetPoint)
                v1.stopTraverseFunc = v3
                v2.setPointFunc = v4
            end
        end

        if not (#u3.pointList > 0) then
            u3.PathFailed:Fire()

            if u3.stopTraverseFunc then
                u3.stopTraverseFunc()
            end

            return
        end

        u3.HumanoidOffsetFromPath = Vector3.new(0, u3.pointList[1].Position.Y - u3.OriginPoint.Y, 0)
        u3.CurrentHumanoidPosition = u3.Humanoid.RootPart.Position + u3.HumanoidOffsetFromPath
        u3.CurrentHumanoidVelocity = u3.Humanoid.RootPart.Velocity
        u3.SeatedConn = u3.Humanoid.Seated:Connect(function(a1, a2) -- Line: 624; upvalues: u3 (upval)
            u3:OnPathInterrupted()
        end)
        u3.DiedConn = u3.Humanoid.Died:Connect(function() -- Line: 625; upvalues: u3 (upval)
            u3:OnPathInterrupted()
        end)

        if not UserPSIASClickToMoveRelaxTeleport then
            u3.TeleportedConn = (u3.Humanoid.RootPart:GetPropertyChangedSignal("CFrame")):Connect(function()
                -- Line: 637
                -- upvalues: u3 (upval)
                u3:OnPathInterrupted()
            end)
        else
            u3.lastPosition = u3.Humanoid.RootPart.CFrame.Position
            u3.TeleportedConn = (u3.Humanoid.RootPart:GetPropertyChangedSignal("CFrame")):Connect(function()
                -- Line: 628
                -- upvalues: u3 (upval)
                local Position = u3.Humanoid.RootPart.CFrame.Position
                local Magnitude = (Position - u3.lastPosition).Magnitude
                u3.lastPosition = Position

                if u3.Humanoid.WalkSpeed < Magnitude then
                    u3:OnPathInterrupted()
                end
            end)
        end

        u3.CurrentPoint = 1
        u3:OnPointReached(true)
    end

    v3 = u3.TargetPoint + u3.TargetSurfaceNormal * 1.5

    if not u62 then
        v5 = (Ray.new(v3, (Vector3.new(0, -50, 0))))

        if not u116 then
            u116 = {}
            assert(u116, "")

            local Character_5 = LocalPlayer and LocalPlayer.Character
            table.insert(u116, Character_5)
        end

        v6, v4 = Workspace:FindPartOnRayWithIgnoreList(v5, u116)

        if v6 then
            u3.TargetPoint = v4
        end
    else
        if not u116 then
            u116 = {}
            assert(u116, "")

            local Character_4 = LocalPlayer and LocalPlayer.Character
            table.insert(u116, Character_4)
        end

        u109.FilterDescendantsInstances = u116
        v2 = Workspace:Raycast(v3, Vector3.new(-0, -50, -0), u109)

        if v2 then
            u3.TargetPoint = v2.Position
        end
    end

    u3:ComputePath()

    return u3
end

local function CheckAlive() -- Line: 674; upvalues: LocalPlayer (val), u114 (val)
    local v1
    local v2 = LocalPlayer
    local Character = v2 and v2.Character

    if not Character then
        v1 = nil
    else
        local v3 = u114[v2]

        if not v3 or v3.Parent ~= Character then
            u114[v2] = nil
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")

            if Humanoid then
                u114[v2] = Humanoid
            end

            v1 = Humanoid
        else
            v1 = v3
        end
    end

    v2 = false

    if v1 ~= nil then
        v2 = 0 < v1.Health
    end

    return v2
end

local function GetEquippedTool(a1) -- Line: 679; types: a1: userdata?
    if a1 ~= nil then
        for k, v in pairs(a1:GetChildren()) do
            if v:IsA("Tool") then
                return v
            end
        end
    end
end

local function DisconnectEvent(a1) -- Line: 689
    if a1 then
        a1:Disconnect()
    end
end

local function calculateLocalMoveVector(a1) -- Line: 695; upvalues: Workspace (val); types: a1: vector
    local v1
    local v2 = Vector3.new(a1.X, 0, a1.Z)

    if v2.Magnitude < 1e-06 then
        return Vector2.zero
    end

    local Unit = v2.Unit
    local CurrentCamera = Workspace.CurrentCamera

    if not CurrentCamera then
        return Vector2.new(Unit.X, -Unit.Z)
    end

    _, v1 = CurrentCamera.CFrame:ToEulerAnglesYXZ()
    local v3 = (CFrame.Angles(0, v1, 0)):VectorToObjectSpace(Unit)

    return Vector2.new(v3.X, -v3.Z)
end

local u145 = {}
u145.__index = u145

function u145.new(a1) -- Line: 714; upvalues: u145 (val), UserDoubleJumpButtonFix (val)
    local v1 = setmetatable(
        {},
        u145
    )
    v1.mouse2DownTime = tick()
    v1.mouse2DownPos = Vector2.new()
    v1.mouse2UpTime = tick()
    v1.humanoidDiedConn = nil
    v1.characterChildAddedConn = nil
    v1.onCharacterAddedConn = nil
    v1.characterChildRemovedConn = nil
    v1.renderSteppedConn = nil
    v1.menuOpenedConnection = nil
    v1.preferredInputChangedConnection = nil

    if not UserDoubleJumpButtonFix then
        v1.jumpEnabled = true
    end

    v1.clickPressedConn = nil
    v1.clickReleasedConn = nil
    v1.shouldCleanupPath = false
    v1.lastPatherJumped = false
    v1.data = nil
    v1.running = false

    return v1
end

local u148 = nil
local u149 = nil
local u150 = nil

function u145:CleanupPath() -- Line: 749; upvalues: u148 (ref), u149 (ref), u150 (ref)
    if u148 then
        u148:Cancel()

        u148 = nil
    end

    if u149 then
        u149:Disconnect()

        u149 = nil
    end

    if u150 then
        u150:Disconnect()

        u150 = nil
    end

    self.shouldCleanupPath = true
end

function u145:HandleMoveTo(a2, a3, a4, a5, a6)
    -- Line: 768
    -- upvalues: u148 (ref), u149 (ref), GetEquippedTool (val), u150 (ref), u94 (ref), u107 (val)
    self.shouldCleanupPath = false

    if u148 then
        self:CleanupPath()
    end

    u148 = a2
    a2:Start(a6)

    u149 = a2.Finished.Event:Connect(function()
        -- Line: 777
        -- upvalues: self (val), a4 (val), GetEquippedTool (upval), a5 (val)
        self:CleanupPath()

        if a4 then
            local v1 = GetEquippedTool(a5)

            if v1 then
                v1:Activate()
            end
        end
    end)
    u150 = a2.PathFailed.Event:Connect(function()
        -- Line: 786
        -- upvalues: self (val), a6 (val), u94 (upval), u148 (upval), u107 (upval), a3 (val)
        self:CleanupPath()

        if a6 == nil or a6 then
            if u94 and not (u148 and u148:IsActive()) then
                u107.PlayFailureAnimation()
            end

            u107.DisplayFailureWaypoint(a3)
        end
    end)
end

function u145.ShowPathFailedFeedback(a1, a2) -- Line: 798; upvalues: u148 (ref), u94 (ref), u107 (val)
    if u148 and u148:IsActive() then
        u148:Cancel()
    end

    if u94 then
        u107.PlayFailureAnimation()
    end

    u107.DisplayFailureWaypoint(a2)
end

function u145:OnTap(a2, a3)
    -- Line: 808
    -- upvalues: Workspace (val), LocalPlayer (val), u114 (val), u62 (val), u116 (ref), u109 (val), Pather (val)
    -- upvalues: u111 (val), GetEquippedTool (val)
    -- types: self: table, a2: table, a3: vector?
    local v1, v2
    local CurrentCamera = Workspace.CurrentCamera
    local Character = LocalPlayer.Character
    local v3 = LocalPlayer
    local Character_2 = v3 and v3.Character

    if not Character_2 then
        v1 = nil
    else
        v2 = u114[v3]

        if not v2 or v2.Parent ~= Character_2 then
            u114[v3] = nil
            local Humanoid = Character_2:FindFirstChildOfClass("Humanoid")

            if Humanoid then
                u114[v3] = Humanoid
            end

            v1 = Humanoid
        else
            v1 = v2
        end
    end

    local v4 = false

    if v1 ~= nil then
        v4 = 0 < v1.Health
    end

    if not v4 then
        return
    end

    if #a2 ~= 1 and not a3 then
        if #a2 >= 2 and CurrentCamera then
            v4 = GetEquippedTool(Character)

            if v4 then
                v4:Activate()
            end
        end

        return
    end

    if CurrentCamera then
        local v5, v6
        v4 = CurrentCamera:ScreenPointToRay(a2[1].X, a2[1].Y)

        if u62 then
            local Instance_2
            v3 = nil

            if not u116 then
                u116 = {}
                assert(u116, "")

                local Character_3 = LocalPlayer and LocalPlayer.Character
                table.insert(u116, Character_3)
            end

            v2 = u116 or {}
            local v7, v8 = a3, self

            repeat
                v5 = true
                u109.FilterDescendantsInstances = v2
                v6 = Workspace:Raycast(v4.Origin, v4.Direction * 1000, u109)

                if v6 then
                    Instance_2 = v6.Instance

                    if not Instance_2.CanCollide then
                        repeat
                            v1 = Instance_2:FindFirstChildOfClass("Humanoid")
                            v3 = Instance_2
                            Instance_2 = Instance_2.Parent
                        until v1 or not Instance_2

                        if not v1 and Instance_2 then
                            v3 = nil
                            v5 = false

                            table.insert(v2, Instance_2)
                        end
                    end
                end
            until v5

            if v6 and Character then
                local Position = v6.Position

                if v7 then
                    Position = v7
                    v3 = nil
                end

                v8:CleanupPath()

                v1 = Pather(Position, v6.Normal)

                if v1:IsValidPath() then
                    v8:HandleMoveTo(v1, Position, v3, Character)
                    return
                end

                v1:Cleanup()
                v8:ShowPathFailedFeedback(Position)

                return
            end

            return
        end

        v1 = Ray.new(v4.Origin, v4.Direction * 1000)
        local Raycast = u111.Raycast

        if not u116 then
            u116 = {}
            assert(u116, "")

            local Character_4 = LocalPlayer and LocalPlayer.Character
            table.insert(u116, Character_4)
        end

        v3, v6, v2 = Raycast(v1, true, u116)
        v5 = u111.FindCharacterAncestor(v3)

        if a3 then
            v6 = a3
            v5 = nil
        end

        if v6 and Character then
            self:CleanupPath()

            local v9 = Pather(v6, v2)

            if v9:IsValidPath() then
                self:HandleMoveTo(v9, v6, v5, Character)
                return
            end

            v9:Cleanup()
            self:ShowPathFailedFeedback(v6)
        end
    end
end

function u145:DisconnectEvents() -- Line: 903
    local humanoidDiedConn = self.humanoidDiedConn

    if humanoidDiedConn then
        humanoidDiedConn:Disconnect()
    end

    local characterChildAddedConn = self.characterChildAddedConn

    if characterChildAddedConn then
        characterChildAddedConn:Disconnect()
    end

    local onCharacterAddedConn = self.onCharacterAddedConn

    if onCharacterAddedConn then
        onCharacterAddedConn:Disconnect()
    end

    local renderSteppedConn = self.renderSteppedConn

    if renderSteppedConn then
        renderSteppedConn:Disconnect()
    end

    local characterChildRemovedConn = self.characterChildRemovedConn

    if characterChildRemovedConn then
        characterChildRemovedConn:Disconnect()
    end

    local menuOpenedConnection = self.menuOpenedConnection

    if menuOpenedConnection then
        menuOpenedConnection:Disconnect()
    end

    local preferredInputChangedConnection = self.preferredInputChangedConnection

    if preferredInputChangedConnection then
        preferredInputChangedConnection:Disconnect()
    end

    local clickPressedConn = self.clickPressedConn

    if clickPressedConn then
        clickPressedConn:Disconnect()
    end

    local clickReleasedConn = self.clickReleasedConn

    if clickReleasedConn then
        clickReleasedConn:Disconnect()
    end
end

function u145.OnPreferredInputChanged(a1) -- Line: 915; upvalues: LocalPlayer (val), UserInputService (val)
    local Character = LocalPlayer.Character

    if Character then
        local v1 = UserInputService.PreferredInput == Enum.PreferredInput.Touch

        for k, v in pairs(Character:GetChildren()) do
            if v:IsA("Tool") then
                v.ManualActivationOnly = v1
            end
        end
    end
end

function u145:OnCharacterAdded(a2)
    -- Line: 927
    -- upvalues: u88 (val), GuiService (val), ClickToMovePositionAction (val), UserPlayerScriptsRefactor2 (val)
    -- upvalues: u148 (ref), UserInputService (val)
    self:DisconnectEvents()

    self.clickPressedConn = u88.Pressed:Connect(function()
        -- Line: 930
        -- upvalues: GuiService (upval), ClickToMovePositionAction (upval), UserPlayerScriptsRefactor2 (upval)
        -- upvalues: self (val)
        local v1
        local GuiInset = GuiService:GetGuiInset()
        local State = ClickToMovePositionAction:GetState()

        if State.X == -1 and State.Y == -1 then
            return
        end

        if not UserPlayerScriptsRefactor2 then
            v1 = Vector2.new(State.X - GuiInset.X, State.Y - GuiInset.Y)
        else
            local Min = GuiService:GetInsetArea(Enum.ScreenInsets.None).Min
            v1 = Vector2.new(State.X + Min.X, State.Y + Min.Y)
        end

        self.mouse2DownPos = v1
        self.mouse2DownTime = tick()
    end)
    self.clickReleasedConn = u88.Released:Connect(function() -- Line: 946; upvalues: self (val), u148 (upval)
        self.mouse2UpTime = tick()
        local mouse2DownPos = self.mouse2DownPos

        if self.data and self.data.controlModule.actions.MoveAction then
            local v1 = u148
                or self.data.controlModule.actions.MoveAction:GetState().Magnitude <= 0

            if self.mouse2UpTime - self.mouse2DownTime < 0.25 and v1 then
                self:OnTap({mouse2DownPos})
            end
        end
    end)
    self.menuOpenedConnection = GuiService.MenuOpened:Connect(function() -- Line: 961; upvalues: self (val)
        self:CleanupPath()
    end)

    local function OnCharacterChildAdded(a1) -- Line: 965; upvalues: UserInputService (upval), self (val)
        if UserInputService.PreferredInput == Enum.PreferredInput.Touch and a1:IsA("Tool") then
            a1.ManualActivationOnly = true
        end

        if a1:IsA("Humanoid") then
            local humanoidDiedConn = self.humanoidDiedConn

            if humanoidDiedConn then
                humanoidDiedConn:Disconnect()
            end

            self.humanoidDiedConn = a1.Died:Connect(function() -- Line: 973
            end)
        end
    end

    self.characterChildAddedConn = a2.ChildAdded:Connect(function(a1)
        -- Line: 981
        -- upvalues: OnCharacterChildAdded (val)
        OnCharacterChildAdded(a1)
    end)
    self.characterChildRemovedConn = a2.ChildRemoved:Connect(function(a1)
        -- Line: 984
        -- upvalues: UserInputService (upval)
        if UserInputService.PreferredInput == Enum.PreferredInput.Touch and a1:IsA("Tool") then
            a1.ManualActivationOnly = false
        end
    end)

    for k, v in pairs(a2:GetChildren()) do
        OnCharacterChildAdded(v)
    end

    self.preferredInputChangedConnection = (UserInputService:GetPropertyChangedSignal("PreferredInput")):Connect(function()
        -- Line: 995
        -- upvalues: self (val)
        self:OnPreferredInputChanged()
    end)
end

function u145:Start() -- Line: 1000
    self:Enable(true)
end

function u145.Stop(a1) -- Line: 1004
    a1:Enable(false)
end

function u145:Enable(a2, a3, a4)
    -- Line: 1009
    -- upvalues: LocalPlayer (val), UserDoubleJumpButtonFix (val), UserInputService (val), u88 (val)
    -- upvalues: ClickToMovePositionAction (val)
    -- types: self: table, a2: boolean, a3: boolean
    if not a2 then
        if self.running then
            self:DisconnectEvents()
            self:CleanupPath()

            if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
                local Character_2 = LocalPlayer.Character

                if Character_2 then
                    for k, v in pairs(Character_2:GetChildren()) do
                        if v:IsA("Tool") then
                            v.ManualActivationOnly = false
                        end
                    end
                end
            end

            self.running = false
        end

        if not UserDoubleJumpButtonFix then
            if self.touchJumpController and not self.jumpEnabled then
                self.touchJumpController:Enable(true)
            end

            self.touchJumpController = nil
        end
    else
        if not self.running then
            if LocalPlayer.Character then
                self:OnCharacterAdded(LocalPlayer.Character)
            end

            self.onCharacterAddedConn = LocalPlayer.CharacterAdded:Connect(function(a1)
                -- Line: 1015
                -- upvalues: self (val)
                self:OnCharacterAdded(a1)
            end)
            self.running = true
        end

        if not UserDoubleJumpButtonFix then
            self.touchJumpController = a4

            if self.touchJumpController then
                self.touchJumpController:Enable(self.jumpEnabled)
            end
        end
    end

    u88.Enabled = a2
    ClickToMovePositionAction.Enabled = a2
    self.wasdEnabled = a2 and a3 or false
    self.enabled = a2
end

function u145.Update(a1, a2, a3) -- Line: 1058; upvalues: u148 (ref), calculateLocalMoveVector (val)
    assert(a2.controlModule.actions.MoveAction)
    assert(a2.controlModule.actions.JumpAction)

    if not a1.data then
        a1.data = a2
    end

    local v1 = u148

    if v1 then
        local ClickToMoveScriptableBinding_3
        v1:OnRenderStepped(a3)

        if not u148 then
            if a1.lastPatherJumped then
                if a2.controlModule.actions.JumpAction:GetState() == true then
                    ClickToMoveScriptableBinding_3 = a2.controlModule.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding")

                    if ClickToMoveScriptableBinding_3 then
                        ClickToMoveScriptableBinding_3:Fire(false)
                    end
                end

                a1.lastPatherJumped = false
            end
        elseif u148 == v1 then
            local v2 = calculateLocalMoveVector(v1.NextActionMoveDirection)
            local ClickToMoveScriptableBinding = a2.controlModule.actions.MoveAction:FindFirstChild("ClickToMoveScriptableBinding")

            if ClickToMoveScriptableBinding then
                ClickToMoveScriptableBinding:Fire(v2)
            end

            a2.controlModule.moveVector = v2

            if v1.NextActionJump then
                if a2.controlModule.actions.JumpAction:GetState() ~= true then
                    local ClickToMoveScriptableBinding_2 = a2.controlModule.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding")

                    if ClickToMoveScriptableBinding_2 then
                        ClickToMoveScriptableBinding_2:Fire(true)
                    end
                end

                a1.lastPatherJumped = true
                a2.controlModule.isJumping = true
            elseif a1.lastPatherJumped then
                if a2.controlModule.actions.JumpAction:GetState() == true then
                    v2 = a2.controlModule.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding")

                    if v2 then
                        v2:Fire(false)
                    end
                end

                a1.lastPatherJumped = false
                a2.controlModule.isJumping = false
            end
        elseif a1.lastPatherJumped then
            if a2.controlModule.actions.JumpAction:GetState() == true then
                ClickToMoveScriptableBinding_3 = a2.controlModule.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding")

                if ClickToMoveScriptableBinding_3 then
                    ClickToMoveScriptableBinding_3:Fire(false)
                end
            end

            a1.lastPatherJumped = false
        end
    end

    if a1.shouldCleanupPath then
        a1.shouldCleanupPath = false
        local ClickToMoveScriptableBinding_4 = a2.controlModule.actions.MoveAction:FindFirstChild("ClickToMoveScriptableBinding")

        if ClickToMoveScriptableBinding_4 then
            ClickToMoveScriptableBinding_4:Fire(Vector2.zero)
        end

        a2.controlModule.moveVector = Vector2.zero
        a1.lastPatherJumped = false
        local ClickToMoveScriptableBinding_5 = a2.controlModule.actions.JumpAction:FindFirstChild("ClickToMoveScriptableBinding")

        if ClickToMoveScriptableBinding_5 then
            ClickToMoveScriptableBinding_5:Fire(false)
        end

        a2.controlModule.isJumping = false
    end
end

function u145.SetShowPath(a1, a2) -- Line: 1132; upvalues: u93 (ref)
    u93 = a2
end

function u145.GetShowPath(a1) -- Line: 1136; upvalues: u93 (ref)
    return u93
end

function u145.SetWaypointTexture(a1, a2) -- Line: 1140; upvalues: u107 (val)
    u107.SetWaypointTexture(a2)
end

function u145.GetWaypointTexture(a1) -- Line: 1144; upvalues: u107 (val)
    return u107.GetWaypointTexture()
end

function u145.SetWaypointRadius(a1, a2) -- Line: 1148; upvalues: u107 (val)
    u107.SetWaypointRadius(a2)
end

function u145.GetWaypointRadius(a1) -- Line: 1152; upvalues: u107 (val)
    return u107.GetWaypointRadius()
end

function u145.SetEndWaypointTexture(a1, a2) -- Line: 1156; upvalues: u107 (val)
    u107.SetEndWaypointTexture(a2)
end

function u145.GetEndWaypointTexture(a1) -- Line: 1160; upvalues: u107 (val)
    return u107.GetEndWaypointTexture()
end

function u145.SetWaypointsAlwaysOnTop(a1, a2) -- Line: 1164; upvalues: u107 (val)
    u107.SetWaypointsAlwaysOnTop(a2)
end

function u145.GetWaypointsAlwaysOnTop(a1) -- Line: 1168; upvalues: u107 (val)
    return u107.GetWaypointsAlwaysOnTop()
end

function u145.SetFailureAnimationEnabled(a1, a2) -- Line: 1172; upvalues: u94 (ref)
    u94 = a2
end

function u145.GetFailureAnimationEnabled(a1) -- Line: 1176; upvalues: u94 (ref)
    return u94
end

function u145.SetIgnoredPartsTag(a1, a2) -- Line: 1180; upvalues: UpdateIgnoreTag (val)
    UpdateIgnoreTag(a2)
end

function u145.GetIgnoredPartsTag(a1) -- Line: 1184; upvalues: u117 (ref)
    return u117
end

function u145.SetUseDirectPath(a1, a2) -- Line: 1188; upvalues: u95 (ref)
    u95 = a2
end

function u145.GetUseDirectPath(a1) -- Line: 1192; upvalues: u95 (ref)
    return u95
end

function u145.SetAgentSizeIncreaseFactor(a1, a2) -- Line: 1196; upvalues: u96 (ref); types: a1: table, a2: number
    u96 = a2 / 100 + 1
end

function u145.GetAgentSizeIncreaseFactor(a1) -- Line: 1200; upvalues: u96 (ref)
    return (u96 - 1) * 100
end

function u145.SetUnreachableWaypointTimeout(a1, a2) -- Line: 1204; upvalues: u97 (ref)
    u97 = a2
end

function u145.GetUnreachableWaypointTimeout(a1) -- Line: 1208; upvalues: u97 (ref)
    return u97
end

if not UserDoubleJumpButtonFix then
    function u145.SetUserJumpEnabled(a1, a2) -- Line: 1213
        a1.jumpEnabled = a2

        if a1.touchJumpController then
            a1.touchJumpController:Enable(a2)
        end
    end

    function u145.GetUserJumpEnabled(a1) -- Line: 1220
        return a1.jumpEnabled
    end
end

function u145.MoveTo(a1, a2, a3, a4) -- Line: 1225; upvalues: LocalPlayer (val), Pather (val)
    local Character = LocalPlayer.Character

    if Character == nil then
        return false
    end

    local v1 = Pather(a2, Vector3.new(0, 1, 0), a4)

    if v1 and v1:IsValidPath() then
        a1:HandleMoveTo(v1, a2, nil, Character, a3)
        return true
    end

    return false
end

return u145