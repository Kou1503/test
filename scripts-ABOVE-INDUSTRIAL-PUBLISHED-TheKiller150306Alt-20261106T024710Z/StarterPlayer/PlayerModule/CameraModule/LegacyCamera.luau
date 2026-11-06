-- Script path: game:GetService("StarterPlayer").PlayerModule.CameraModule.LegacyCamera
-- Decompile time: 1.84 ms

require(script.Parent:WaitForChild("CameraUtils"))

local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local Players = game:GetService("Players")
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
local u32 = setmetatable(
    {},
    BaseCamera
)
u32.__index = u32

function u32.new() -- Line: 20; upvalues: BaseCamera (val), u32 (val)
    local v1 = BaseCamera.new()
    local v2 = setmetatable(v1, u32)
    v2.cameraType = Enum.CameraType.Fixed
    v2.lastUpdate = tick()
    v2.lastDistanceToSubject = nil

    return v2
end

function u32.GetModuleName(a1) -- Line: 30
    return "LegacyCamera"
end

function u32.Update(a1, a2) -- Line: 34; upvalues: Players (val), CameraInput (val); types: a1: table, a2: number
    local v1

    if not a1.cameraType then
        return nil, nil
    end

    local v2 = tick()
    local v3 = v2 - a1.lastUpdate
    local CurrentCamera = workspace.CurrentCamera
    local CFrame_2 = CurrentCamera.CFrame
    local Focus = CurrentCamera.Focus
    local LocalPlayer = Players.LocalPlayer
    local v4 = CameraInput.getRotation(a2)

    if a1.lastUpdate == nil or v3 > 1 then
        a1.lastDistanceToSubject = nil
    end

    v3 = a1:GetSubjectPosition()

    if a1.cameraType == Enum.CameraType.Fixed then
        if v3 and LocalPlayer and CurrentCamera then
            local CameraToSubjectDistance = a1:GetCameraToSubjectDistance()
            v1 = a1:CalculateNewLookVectorFromArg(nil, v4)
            Focus = CurrentCamera.Focus
            CFrame_2 = CFrame.new(CurrentCamera.CFrame.Position, CurrentCamera.CFrame.Position + CameraToSubjectDistance * v1)
        end

        a1.lastUpdate = v2

        return CFrame_2, Focus
    end

    if a1.cameraType == Enum.CameraType.Attach then
        local v5
        local SubjectCFrame = a1:GetSubjectCFrame()
        v1 = CurrentCamera.CFrame:ToEulerAnglesYXZ()
        _, v5 = SubjectCFrame:ToEulerAnglesYXZ()
        v1 = math.clamp(v1 - v4.Y, -1.3962634015954636, 1.3962634015954636)
        Focus = (CFrame.new(SubjectCFrame.Position)) * CFrame.fromEulerAnglesYXZ(v1, v5, 0)
        CFrame_2 = Focus * CFrame.new(0, 0, a1:StepZoom(a2))
        a1.lastUpdate = v2

        return CFrame_2, Focus
    end

    if a1.cameraType ~= Enum.CameraType.Watch then
        return CurrentCamera.CFrame, CurrentCamera.Focus
    end

    if v3 and LocalPlayer and CurrentCamera then
        local v6
        local unit = nil

        if v3 == CurrentCamera.CFrame.Position then
            warn("Camera cannot watch subject in same position as itself")
            return CurrentCamera.CFrame, CurrentCamera.Focus
        end

        local Humanoid = a1:GetHumanoid()

        if Humanoid and Humanoid.RootPart then
            v6 = v3 - CurrentCamera.CFrame.Position
            unit = v6.unit

            if a1.lastDistanceToSubject
                and a1.lastDistanceToSubject == a1:GetCameraToSubjectDistance() then
                a1:SetCameraToSubjectDistance(v6.magnitude)
            end
        end

        local CameraToSubjectDistance_2 = a1:GetCameraToSubjectDistance()
        v6 = a1:CalculateNewLookVectorFromArg(unit, v4)
        Focus = CFrame.new(v3)
        CFrame_2 = CFrame.new(v3 - CameraToSubjectDistance_2 * v6, v3)
        a1.lastDistanceToSubject = CameraToSubjectDistance_2
    end

    a1.lastUpdate = v2

    return CFrame_2, Focus
end

return u32