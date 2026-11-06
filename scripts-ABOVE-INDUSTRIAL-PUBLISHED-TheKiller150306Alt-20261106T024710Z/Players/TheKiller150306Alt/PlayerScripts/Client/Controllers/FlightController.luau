-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.FlightController
-- Decompile time: 4.12 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u35 = Remotes.get(Remotes.RequestFlight)
local u36 = false
local u37 = 0
local u38 = nil
local u39 = nil
local u40 = nil

local function character() -- Line: 38; upvalues: LocalPlayer (val)
    return LocalPlayer.Character
end

local function humanoid() -- Line: 42; upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    return Character and Character:FindFirstChildWhichIsA("Humanoid")
end

local function rootPart() -- Line: 47; upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    return Character and Character:FindFirstChild("HumanoidRootPart")
end

local function teardown() -- Line: 52; upvalues: u38 (ref), u39 (ref), u40 (ref)
    if u38 then
        u38:Destroy()
    end

    if u39 then
        u39:Destroy()
    end

    if u40 then
        u40:Destroy()
    end

    u38 = nil
    u39 = nil
    u40 = nil
end

local function setFlying(a1)
    -- Line: 65
    -- upvalues: u36 (ref), LocalPlayer (val), u35 (val), u38 (ref), u39 (ref), u40 (ref)
    -- types: a1: boolean
    local AlignOrientation, Attachment, LinearVelocity

    if a1 == u36 then
        return
    end

    local Character = LocalPlayer.Character
    local v1 = Character and Character:FindFirstChild("HumanoidRootPart")
    local Character_2 = LocalPlayer.Character
    local v2 = Character_2 and Character_2:FindFirstChildWhichIsA("Humanoid")

    if not a1 then
        u36 = a1
        u35:FireServer(a1)

        if not a1 then
            if u38 then
                u38:Destroy()
            end

            if u39 then
                u39:Destroy()
            end

            if u40 then
                u40:Destroy()
            end

            u38 = nil
            u39 = nil
            u40 = nil

            if v2 then
                v2.PlatformStand = false
                v2:ChangeState(Enum.HumanoidStateType.Freefall)
            end

            return
        end

        Attachment = Instance.new("Attachment")
        Attachment.Name = "FlightAnchor"
        Attachment.Parent = v1
        LinearVelocity = Instance.new("LinearVelocity")
        LinearVelocity.Attachment0 = Attachment
        LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
        LinearVelocity.MaxForce = (1 / 0)
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0)
        LinearVelocity.Parent = v1
        AlignOrientation = Instance.new("AlignOrientation")
        AlignOrientation.Attachment0 = Attachment
        AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
        AlignOrientation.RigidityEnabled = true
        AlignOrientation.Parent = v1
        u40 = Attachment
        u38 = LinearVelocity
        u39 = AlignOrientation

        if v2 then
            v2.PlatformStand = true
        end

        return
    end

    if v1 and v2 then
        u36 = a1
        u35:FireServer(a1)

        if not a1 then
            if u38 then
                u38:Destroy()
            end

            if u39 then
                u39:Destroy()
            end

            if u40 then
                u40:Destroy()
            end

            u38 = nil
            u39 = nil
            u40 = nil

            if v2 then
                v2.PlatformStand = false
                v2:ChangeState(Enum.HumanoidStateType.Freefall)
            end

            return
        end

        Attachment = Instance.new("Attachment")
        Attachment.Name = "FlightAnchor"
        Attachment.Parent = v1
        LinearVelocity = Instance.new("LinearVelocity")
        LinearVelocity.Attachment0 = Attachment
        LinearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
        LinearVelocity.MaxForce = (1 / 0)
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0)
        LinearVelocity.Parent = v1
        AlignOrientation = Instance.new("AlignOrientation")
        AlignOrientation.Attachment0 = Attachment
        AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
        AlignOrientation.RigidityEnabled = true
        AlignOrientation.Parent = v1
        u40 = Attachment
        u38 = LinearVelocity
        u39 = AlignOrientation

        if v2 then
            v2.PlatformStand = true
        end
    end
end

local function onJump() -- Line: 124; upvalues: LocalPlayer (val), u37 (ref), Config (val), setFlying (val), u36 (ref)
    if LocalPlayer:GetAttribute("DevAdmin") ~= true then
        return
    end

    local v1 = os.clock()

    if not (v1 - u37 <= Config.Player.Flight.DoubleTapSeconds) then
        u37 = v1
        return
    end

    u37 = 0
    setFlying(not u36)
end

local function step()
    -- Line: 137
    -- upvalues: u36 (ref), u38 (ref), u39 (ref), LocalPlayer (val), u35 (val), u40 (ref), Config (val)
    -- upvalues: UserInputService (val)
    local v1

    if not u36 then
        return
    end

    local v2 = u38
    local v3 = u39
    local Character = LocalPlayer.Character
    local v4 = Character and Character:FindFirstChild("HumanoidRootPart")
    local Character_2 = LocalPlayer.Character
    local v5 = Character_2 and Character_2:FindFirstChildWhichIsA("Humanoid")

    if v2 and v3 and v4 and v5 then
        local Flight = Config.Player.Flight
        local MoveDirection = v5.MoveDirection
        v5 = 0

        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            v5 = v5 + 1
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            v5 = v5 - 1
        end

        v1 = MoveDirection + Vector3.new(0, v5, 0)
        local SpeedStuds = Flight.SpeedStuds

        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            SpeedStuds = SpeedStuds * Flight.BoostMultiplier
        end

        v2.VectorVelocity = if not (0.01 < v1.Magnitude) then
            Vector3.new(0, 0, 0)
        else
            v1.Unit * SpeedStuds
        local v6 = Vector3.new(v1.X, 0, v1.Z)

        if 0.01 < v6.Magnitude then
            v3.CFrame = CFrame.lookAt(Vector3.new(0, 0, 0), v6.Unit)
            return
        end

        v3.CFrame = CFrame.lookAt(Vector3.new(0, 0, 0), (Vector3.new(v4.CFrame.LookVector.X, 0, v4.CFrame.LookVector.Z)))

        return
    end

    if u36 == false then
        return
    end

    local Character_3 = LocalPlayer.Character

    if Character_3 then
        Character_3:FindFirstChild("HumanoidRootPart")
    end

    local Character_4 = LocalPlayer.Character
    v1 = Character_4 and Character_4:FindFirstChildWhichIsA("Humanoid")
    u36 = false

    u35:FireServer(false)

    if u38 then
        u38:Destroy()
    end

    if u39 then
        u39:Destroy()
    end

    if u40 then
        u40:Destroy()
    end

    u38 = nil
    u39 = nil
    u40 = nil

    if v1 then
        v1.PlatformStand = false
        v1:ChangeState(Enum.HumanoidStateType.Freefall)
    end
end

function v1.start()
    -- Line: 182
    -- upvalues: UserInputService (val), LocalPlayer (val), u37 (ref), Config (val), setFlying (val), u36 (ref)
    -- upvalues: RunService (val), step (val), u38 (ref), u39 (ref), u40 (ref), u35 (val)
    UserInputService.InputBegan:Connect(function(a1, a2)
        -- Line: 183
        -- upvalues: LocalPlayer (upval), u37 (upval), Config (upval), setFlying (upval), u36 (upval)
        if not a2 and a1.KeyCode == Enum.KeyCode.Space then
            if LocalPlayer:GetAttribute("DevAdmin") ~= true then
                return
            end

            local v1 = os.clock()

            if not (v1 - u37 <= Config.Player.Flight.DoubleTapSeconds) then
                u37 = v1
                return
            end

            u37 = 0
            setFlying(not u36)
        end
    end)

    RunService.RenderStepped:Connect(step)

    LocalPlayer.CharacterAdded:Connect(function()
        -- Line: 194
        -- upvalues: u36 (upval), u38 (upval), u39 (upval), u40 (upval), u35 (upval)
        if u36 then
            u36 = false

            if u38 then
                u38:Destroy()
            end

            if u39 then
                u39:Destroy()
            end

            if u40 then
                u40:Destroy()
            end

            u38 = nil
            u39 = nil
            u40 = nil

            u35:FireServer(false)
        end
    end)
end

return v1