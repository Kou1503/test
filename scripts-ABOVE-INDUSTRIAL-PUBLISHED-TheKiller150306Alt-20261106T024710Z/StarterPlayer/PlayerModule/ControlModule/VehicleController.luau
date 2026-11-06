-- Script path: game:GetService("StarterPlayer").PlayerModule.ControlModule.VehicleController
-- Decompile time: 1.65 ms

local VehicleContext = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("VehicleContext")
local u15 = VehicleContext:WaitForChild("ThrottleAction")
local SteerAction = VehicleContext:WaitForChild("SteerAction")

require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")

local u32 = {}
u32.__index = u32

function u32.new() -- Line: 23; upvalues: u32 (val)
    local v1 = setmetatable(
        {},
        u32
    )
    v1.enabled = false
    v1.vehicleSeat = nil

    return v1
end

function u32.Enable(a1, a2, a3)
    -- Line: 32
    -- upvalues: VehicleContext (val)
    -- types: a1: table, a2: boolean, a3: userdata
    if a2 == a1.enabled and a3 == a1.vehicleSeat then
        return
    end

    a1.enabled = a2

    if not a2 then
        VehicleContext.Enabled = false
        a1.vehicleSeat = nil

        return
    end

    if not a3 then
        return
    end

    a1.vehicleSeat = a3
    VehicleContext.Enabled = true
end

function u32.Update(a1, a2, a3)
    -- Line: 53
    -- upvalues: u15 (val), SteerAction (val)
    -- types: a1: table, a2: vector, a3: boolean
    if not a1.vehicleSeat then
        return a2, false
    end

    if not a3 then
        local v1 = a1.vehicleSeat.Occupant.RootPart.CFrame:VectorToObjectSpace(a2)
        a1.vehicleSeat.ThrottleFloat = a1:ComputeThrottle(v1)
        a1.vehicleSeat.SteerFloat = a1:ComputeSteer(v1)

        return Vector3.new(0, 0, 0), true
    end

    local State = u15:GetState()
    local v2 = a2 + Vector3.new(SteerAction:GetState(), 0, -State)
    a1.vehicleSeat.ThrottleFloat = -v2.Z
    a1.vehicleSeat.SteerFloat = v2.X

    return v2, true
end

function u32.ComputeThrottle(a1, a2) -- Line: 80
    if a2 ~= Vector3.new(0, 0, 0) then
        return -a2.Z
    end

    return 0
end

function u32.ComputeSteer(a1, a2) -- Line: 88
    if a2 ~= Vector3.new(0, 0, 0) then
        return -math.atan2(-a2.x, -a2.z) * 57.29577951308232
    end

    return 0
end

return u32