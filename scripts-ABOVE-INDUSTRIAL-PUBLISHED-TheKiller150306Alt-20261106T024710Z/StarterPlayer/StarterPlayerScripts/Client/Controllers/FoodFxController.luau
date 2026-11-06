-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.FoodFxController
-- Decompile time: 3.89 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local Effects = Config.Food.Effects

local function humanoidAndRoot() -- Line: 22; upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character

    if not Character then
        return nil, nil
    end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    local v1 = Humanoid

    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return v1, HumanoidRootPart
    end

    return v1, nil
end

local u30 = 0

local function lowGravity(a1)
    -- Line: 37
    -- upvalues: u30 (ref), LocalPlayer (val), Effects (val), RunService (val)
    -- types: a1: number
    local u29
    local v1 = os.clock()
    local v2 = u30 <= v1
    u30 = os.clock() + a1

    if not v2 then
        return
    end

    local Character = LocalPlayer.Character

    if Character then
        Character:FindFirstChildOfClass("Humanoid")

        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        u29 = if not HumanoidRootPart then
            nil
        else
            if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
    else
        u29 = nil
    end

    if not u29 then
        u30 = 0
        return
    end

    local u35 = Instance.new("Attachment")
    u35.Name = "FoodLowGravity"
    u35.Parent = u29
    local VectorForce = Instance.new("VectorForce")
    VectorForce.Name = "FoodLowGravity"
    VectorForce.Attachment0 = u35
    VectorForce.RelativeTo = Enum.ActuatorRelativeTo.World
    VectorForce.ApplyAtCenterOfMass = true
    VectorForce.Parent = u29
    local u46 = 1 - Effects.LowGravity.gravityFraction
    local u47 = nil
    u47 = (RunService.Heartbeat:Connect(function()
        -- Line: 59
        -- upvalues: u30 (upval), u29 (val), u47 (ref), VectorForce (val), u35 (val), u46 (val)
        local v1 = os.clock()

        if not (u30 <= v1) and u29.Parent then
            VectorForce.Force = Vector3.new(0, u29.AssemblyMass * workspace.Gravity * u46, 0)
            return
        end

        u47:Disconnect()
        VectorForce:Destroy()
        u35:Destroy()
    end))
end

local function rocket() -- Line: 77; upvalues: LocalPlayer (val), Effects (val), RunService (val)
    local u18, v1
    local Character = LocalPlayer.Character

    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        v1 = Humanoid
        u18 = if not HumanoidRootPart then
            nil
        else
            if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
    else
        v1 = nil
        u18 = nil
    end

    if v1 and u18 and not v1.SeatPart then
        local upSpeed = Effects.Rocket.upSpeed
        local u27 = os.clock()

        v1:ChangeState(Enum.HumanoidStateType.Jumping)

        local AssemblyLinearVelocity = u18.AssemblyLinearVelocity
        u18.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, upSpeed, AssemblyLinearVelocity.Z)
        local u38 = nil
        u38 = (RunService.Heartbeat:Connect(function()
            -- Line: 88
            -- upvalues: u27 (val), u18 (val), u38 (ref), upSpeed (val)
            local v1 = os.clock() - u27

            if not (v1 >= 0.2) and u18.Parent then
                local AssemblyLinearVelocity = u18.AssemblyLinearVelocity
                local v2 = upSpeed - workspace.Gravity * v1

                if AssemblyLinearVelocity.Y < v2 - 2 then
                    u18.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, v2, AssemblyLinearVelocity.Z)
                end

                return
            end

            u38:Disconnect()
        end))
    end
end

local u33 = nil
local u34 = nil
local u35 = nil
local u36 = 0

local function thaw() -- Line: 116; upvalues: u35 (ref), u34 (ref), u33 (ref)
    local Animation

    if u35 then
        u35:Disconnect()

        u35 = nil
    end

    local v1 = u34
    local v2 = nil
    local v3 = nil

    for i, j in u33 or {}, v2, v3 do
        if i.IsPlaying then
            Animation = i.Animation

            if not v1 or not Animation or not Animation:IsDescendantOf(v1) then
                i:AdjustSpeed(j)
            else
                i:Stop(0.2)
            end
        end
    end

    u33 = nil
    u34 = nil

    if v1 and v1.Parent then
        v1.Enabled = true
    end
end

local function freeze(a1)
    -- Line: 139
    -- upvalues: u36 (ref), u33 (ref), LocalPlayer (val), u34 (ref), u35 (ref), thaw (val)
    -- types: a1: number
    local v1
    u36 = os.clock() + a1

    if u33 then
        task.delay(
            a1,
            function() -- Line: 163; upvalues: u33 (upval), u36 (upval), thaw (upval)
                if u33 then
                    local v1 = os.clock()

                    if u36 - 0.05 <= v1 then
                        thaw()
                    end
                end
            end
        )
        return
    end

    local Character = LocalPlayer.Character

    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        v1 = Humanoid

        if HumanoidRootPart and not HumanoidRootPart:IsA("BasePart") then end
    else
        v1 = nil
    end

    local Animator = v1 and v1:FindFirstChildOfClass("Animator")

    if v1 and Animator then
        local Parent = v1.Parent and v1.Parent:FindFirstChild("Animate")

        if Parent and Parent:IsA("BaseScript") and Parent.Enabled then
            Parent.Enabled = false
            u34 = Parent
        end

        local v2 = {}

        for i, j in Animator:GetPlayingAnimationTracks() do
            v2[j] = j.Speed
            j:AdjustSpeed(0)
        end

        u33 = v2
        u35 = Animator.AnimationPlayed:Connect(function(a1) -- Line: 159
            a1:Stop(0)
        end)

        task.delay(
            a1,
            function() -- Line: 163; upvalues: u33 (upval), u36 (upval), thaw (upval)
                if u33 then
                    local v1 = os.clock()

                    if u36 - 0.05 <= v1 then
                        thaw()
                    end
                end
            end
        )
    end
end

function v1.start()
    -- Line: 170
    -- upvalues: Remotes (val), lowGravity (val), rocket (val), freeze (val), LocalPlayer (val), u30 (ref), u35 (ref)
    -- upvalues: u33 (ref), u34 (ref), u36 (ref)
    (Remotes.get(Remotes.FoodFx)).OnClientEvent:Connect(function(a1, a2)
        -- Line: 171
        -- upvalues: lowGravity (upval), rocket (upval), freeze (upval)
        -- types: a1: string
        local v1 = if type(a2) ~= "number" then 0 else a2

        if a1 == "LowGravity" and v1 > 0 then
            lowGravity(v1)
            return
        end

        if a1 == "Rocket" then
            rocket()
            return
        end

        if a1 == "Freeze" and v1 > 0 then
            freeze(v1)
        end
    end)

    LocalPlayer.CharacterAdded:Connect(function()
        -- Line: 182
        -- upvalues: u30 (upval), u35 (upval), u33 (upval), u34 (upval), u36 (upval)
        u30 = 0

        if u35 then
            u35:Disconnect()

            u35 = nil
        end

        u33 = nil
        u34 = nil
        u36 = 0
    end)
end

return v1