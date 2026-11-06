-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.SwimController
-- Decompile time: 7.05 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Grid = require(Shared.Grid)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local CellSize = Grid.CellSize
local u33 = {
    Enum.HumanoidStateType.Running,
    Enum.HumanoidStateType.RunningNoPhysics,
    Enum.HumanoidStateType.Freefall,
    Enum.HumanoidStateType.Landed,
    Enum.HumanoidStateType.GettingUp,
    Enum.HumanoidStateType.FallingDown,
    Enum.HumanoidStateType.Climbing,
}
local u42 = OverlapParams.new()
u42.FilterType = Enum.RaycastFilterType.Exclude
u42.MaxParts = 8

local function waterAt(a1) -- Line: 52; upvalues: u42 (val); types: a1: vector
    for i, j in workspace:GetPartBoundsInBox(CFrame.new(a1), Vector3.new(0.5, 0.5, 0.5), u42) do
        if j:GetAttribute("BlockId") == "WaterBlock" then
            return j
        end
    end

    return nil
end

local function cellCentre(a1) -- Line: 63; upvalues: CellSize (val); types: a1: userdata
    return a1.Position - Vector3.new(0, a1.Size.Y / 2, 0)
        + Vector3.new(0, CellSize / 2, 0)
end

local function swimmableSurface(a1)
    -- Line: 68
    -- upvalues: waterAt (val), CellSize (val), Config (val)
    -- types: a1: vector
    local v1 = waterAt(a1)

    if not v1 then
        return nil
    end

    local v2 = v1.Position - Vector3.new(0, v1.Size.Y / 2, 0)
        + Vector3.new(0, CellSize / 2, 0)
    local v3 = 1
    local v4 = v2

    while v3 < Config.Player.Swim.MinDepthCells do
        v4 = v4 - Vector3.new(0, CellSize, 0)

        if not waterAt(v4) then
            break
        end

        v3 = v3 + 1
    end

    v4 = v1
    v1 = v2

    while true do
        v1 = v1 + Vector3.new(0, CellSize, 0)
        v2 = waterAt(v1)

        if not v2 then
            break
        end

        v4 = v2
        v3 = v3 + 1
    end

    if v3 < Config.Player.Swim.MinDepthCells then
        return nil
    end

    return v4.Position.Y + v4.Size.Y / 2
end

local u48 = nil
local u49 = 0
local u50 = 0

local function stopSwimming(a1)
    -- Line: 116
    -- upvalues: u48 (ref), u33 (val), u49 (ref), Config (val)
    -- types: a1: boolean
    local v1 = u48

    if not v1 then
        return
    end

    u48 = nil
    v1.stateHook:Disconnect()
    v1.velocity:Destroy()
    v1.attachment:Destroy()

    local humanoid = v1.humanoid

    for i, j in u33 do
        humanoid:SetStateEnabled(j, true)
    end

    local RootPart = humanoid.RootPart

    if a1 and RootPart then
        u49 = os.clock() + Config.Player.Swim.ExitGraceSeconds
        RootPart.AssemblyLinearVelocity = Vector3.new(RootPart.AssemblyLinearVelocity.X, Config.Player.Swim.ExitJumpSpeed, RootPart.AssemblyLinearVelocity.Z)

        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

        return
    end

    humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
end

local function startSwimming(a1, a2)
    -- Line: 140
    -- upvalues: u33 (val), u48 (ref), u50 (ref)
    -- types: a1: userdata, a2: userdata
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "SwimAnchor"
    Attachment.Parent = a2
    local LinearVelocity = Instance.new("LinearVelocity")
    LinearVelocity.Attachment0 = Attachment
    LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
    LinearVelocity.MaxForce = a2.AssemblyMass * workspace.Gravity * 4
    LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0)
    LinearVelocity.Parent = a2

    for i, j in u33 do
        a1:SetStateEnabled(j, false)
    end

    a1:ChangeState(Enum.HumanoidStateType.Swimming)

    u48 = {
        humanoid = a1,
        attachment = Attachment,
        velocity = LinearVelocity,
        stateHook = a1.StateChanged:Connect(function(a1_2, a2) -- Line: 161; upvalues: u48 (upval), a1 (val), u50 (upval)
            if a2 == Enum.HumanoidStateType.Jumping and u48 and u48.humanoid == a1 then
                u50 = os.clock() + 0.2
            end
        end),
    }
end

local function step()
    -- Line: 169
    -- upvalues: LocalPlayer (val), stopSwimming (val), u42 (val), swimmableSurface (val), u48 (ref), u49 (ref)
    -- upvalues: startSwimming (val), u50 (ref), Config (val)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    if Character and Humanoid and RootPart and not (Humanoid.Health <= 0) then
        if not Humanoid.PlatformStand and not Humanoid.Sit then
            local LookVector
            u42.FilterDescendantsInstances = {Character}
            local v1 = swimmableSurface(RootPart.Position)
            local v2 = u48

            if not v1 then
                stopSwimming(false)
                return
            end

            if not v2 then
                if os.clock() < u49 then
                    return
                end

                startSwimming(Humanoid, RootPart)

                v2 = u48
            end

            if not v2 then
                return
            end

            local Jump = Humanoid.Jump or os.clock() < u50

            if not Jump and (Humanoid:GetState()) ~= Enum.HumanoidStateType.Swimming then
                Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
            end

            local Swim = Config.Player.Swim
            local v3 = v1 - Swim.SurfaceDepthStuds

            if Jump then
                local Y = RootPart.Position.Y

                if v3 - 0.5 <= Y then
                    stopSwimming(true)
                    return
                end
            end

            v1 = Humanoid.WalkSpeed * Swim.SpeedFactor
            local MoveDirection = Humanoid.MoveDirection
            local CurrentCamera = workspace.CurrentCamera
            local v4 = Vector3.new((if not CurrentCamera then Vector3.new(0, 0, 1) else CurrentCamera.CFrame.LookVector).X, 0, LookVector.Z)
            local v5 = if not (0.01 < v4.Magnitude) then 0 else MoveDirection:Dot(v4.Unit)
            local RiseSpeed = LookVector.Y * v1 * math.max(v5, 0)

            if Jump then
                RiseSpeed = Swim.RiseSpeed
            elseif MoveDirection.Magnitude < 0.1 then
                RiseSpeed = Swim.FloatSpeed
            end

            if v3 <= RootPart.Position.Y and RiseSpeed > 0 then
                RiseSpeed = math.min(RiseSpeed, (v3 - RootPart.Position.Y) * 4)
            end

            v2.velocity.VectorVelocity = MoveDirection * v1 + Vector3.new(0, RiseSpeed, 0)

            return
        end

        stopSwimming(false)

        return
    end

    stopSwimming(false)
end

function v1.start()
    -- Line: 235
    -- upvalues: UserInputService (val), u50 (ref), RunService (val), step (val), LocalPlayer (val), u48 (ref)
    UserInputService.JumpRequest:Connect(function() -- Line: 236; upvalues: u50 (upval)
        u50 = os.clock() + 0.2
    end)

    RunService.Heartbeat:Connect(step)

    LocalPlayer.CharacterRemoving:Connect(function() -- Line: 240; upvalues: u48 (upval)
        u48 = nil
    end)
end

return v1