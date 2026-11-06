-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.SlimeController
-- Decompile time: 2.86 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Grid = require(Shared.Grid)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local Slime = Config.Build.Slime

local function bounceUnder(a1, a2, a3, a4)
    -- Line: 44
    -- upvalues: Config (val)
    -- types: a1: userdata, a2: userdata, a3: userdata, a4: number
    local Attribute
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    v1.FilterDescendantsInstances = {a1}
    local v2 = a3.Size.Y / 2 + a2.HipHeight + 1.5 + a4 * 0.05
    local v3 = workspace:Raycast(a3.Position, Vector3.new(0, -v2, 0), v1)
    local Instance = if not v3 then nil else v3.Instance

    while Instance do
        if Instance == workspace then
            break
        end

        Attribute = Instance:GetAttribute("BlockId")

        if type(Attribute) == "string" then
            v1 = Config.Build.Blocks[Attribute]

            if v1 then
                return v1.bounceCells
            end

            return nil
        end

        Instance = Instance.Parent
    end

    return nil
end

local function speedFor(a1) -- Line: 64; upvalues: Grid (val); types: a1: number
    return (math.sqrt(2 * workspace.Gravity * a1 * Grid.CellSize))
end

local function watch(a1)
    -- Line: 68
    -- upvalues: Slime (val), bounceUnder (val), Grid (val), RunService (val)
    -- types: a1: userdata
    local Humanoid = a1:WaitForChild("Humanoid")
    local HumanoidRootPart = a1:WaitForChild("HumanoidRootPart")
    local u9 = 0
    local u10 = (-1 / 0)
    local u11 = 0
    local u12 = (-1 / 0)

    local function landed()
        -- Line: 76
        -- upvalues: u9 (ref), Slime (upval), u10 (ref), Humanoid (val), bounceUnder (upval), a1 (val)
        -- upvalues: HumanoidRootPart (val), Grid (upval), u11 (ref), u12 (ref)
        local v1 = u9
        u9 = 0

        if not (v1 < Slime.MinImpactSpeed) then
            local v2 = os.clock() - u10

            if not (v2 < 0.15) then
                if not Humanoid.SeatPart and not (Humanoid.Health <= 0) then
                    v2 = bounceUnder(a1, Humanoid, HumanoidRootPart, v1)

                    if v2 and not (v2 <= 0) then
                        local v3 = v1 * Slime.Restitution
                        local v4 = math.sqrt(2 * workspace.Gravity * v2 * Grid.CellSize)
                        local v5 = v2 * Slime.MaxBounceMultiplier
                        local v6 = math.clamp(v3, v4, (math.sqrt(2 * workspace.Gravity * v5 * Grid.CellSize)))
                        u10 = os.clock()
                        u11 = v6
                        u12 = u10 + 0.15

                        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

                        local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
                        HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, v6, AssemblyLinearVelocity.Z)
                    end
                end
            end
        end
    end

    local u19 = RunService.Heartbeat:Connect(function()
        -- Line: 99
        -- upvalues: HumanoidRootPart (val), u12 (ref), u11 (ref), u10 (ref), Humanoid (val), u9 (ref)
        local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
        local v1 = os.clock()

        if not (v1 < u12) then
            if Humanoid.FloorMaterial == Enum.Material.Air then
                u9 = math.max(u9, -AssemblyLinearVelocity.Y)
            end

            return
        end

        local v2 = u11 - workspace.Gravity * (v1 - u10)

        if AssemblyLinearVelocity.Y < v2 - 8 then
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, v2, AssemblyLinearVelocity.Z)
        end
    end)

    ;(Humanoid:GetPropertyChangedSignal("FloorMaterial")):Connect(function()
        -- Line: 113
        -- upvalues: Humanoid (val), landed (val)
        if Humanoid.FloorMaterial ~= Enum.Material.Air then
            landed()
        end
    end)

    Humanoid.StateChanged:Connect(function(a1, a2) -- Line: 121; upvalues: landed (val)
        if a2 == Enum.HumanoidStateType.Landed or a2 == Enum.HumanoidStateType.Jumping then
            landed()
        end
    end)

    a1.Destroying:Connect(function() -- Line: 126; upvalues: u19 (val)
        u19:Disconnect()
    end)
end

function v1.start() -- Line: 131; upvalues: LocalPlayer (val), watch (val)
    LocalPlayer.CharacterAdded:Connect(watch)

    if LocalPlayer.Character then
        task.spawn(watch, LocalPlayer.Character)
    end
end

return v1