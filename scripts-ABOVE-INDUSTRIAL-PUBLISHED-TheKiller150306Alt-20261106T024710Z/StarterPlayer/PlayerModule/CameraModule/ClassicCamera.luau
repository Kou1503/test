-- Script path: game:GetService("StarterPlayer").PlayerModule.CameraModule.ClassicCamera
-- Decompile time: 8.57 ms

local u0 = 0
local u5 = CFrame.fromOrientation(-0.2617993877991494, 0, 0)
local u21 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil").getUserFlag("UserFixCameraFPError")
local Players = game:GetService("Players")
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
local u54 = setmetatable(
    {},
    BaseCamera
)
u54.__index = u54

function u54.new() -- Line: 35; upvalues: BaseCamera (val), u54 (val), CameraUtils (val)
    local v1 = BaseCamera.new()
    local v2 = setmetatable(v1, u54)
    v2.isFollowCamera = false
    v2.isCameraToggle = false
    v2.lastUpdate = tick()
    v2.cameraToggleSpring = CameraUtils.Spring.new(5, 0)

    return v2
end

function u54:GetCameraToggleOffset(a2)
    -- Line: 46
    -- upvalues: CameraInput (val), CameraUtils (val)
    -- types: self: table, a2: number
    if not self.isCameraToggle then
        return (Vector3.new())
    end

    local currentSubjectDistance = self.currentSubjectDistance

    if not CameraInput.getTogglePan() then
        self.cameraToggleSpring.goal = 0
    else
        self.cameraToggleSpring.goal = math.clamp(CameraUtils.map(currentSubjectDistance, 0.5, self.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1), 0, 1)
    end

    return (Vector3.new(0, self.cameraToggleSpring:step(a2) * ((math.clamp(CameraUtils.map(currentSubjectDistance, 0.5, 64, 0, 1), 0, 1)) + 1), 0))
end

function u54.SetCameraMovementMode(a1, a2) -- Line: 64; upvalues: BaseCamera (val)
    BaseCamera.SetCameraMovementMode(a1, a2)

    a1.isFollowCamera = a2 == Enum.ComputerCameraMovementMode.Follow
    a1.isCameraToggle = a2 == Enum.ComputerCameraMovementMode.CameraToggle
end

function u54.Update(a1, a2)
    -- Line: 71
    -- upvalues: u5 (val), Players (val), CameraInput (val), u0 (ref), CameraUtils (val), u21 (val)
    local CFrame_2, CameraHeight, CameraSubject, CameraToSubjectDistance, CameraToggleOffset, CurrentCamera, Focus,
        Humanoid, HumanoidRootPart, LocalPlayer, MouseLockOffset, Position, SubjectPosition, lookVector, lookVector_2,
        v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13
    local dispatch = 0

    while true do
        if dispatch < 40 then
            if dispatch < 20 then
                if dispatch < 10 then
                    if dispatch < 5 then
                        if dispatch < 2 then
                            if dispatch < 1 then
                                v8 = tick()
                                CurrentCamera = workspace.CurrentCamera
                                CFrame_2 = CurrentCamera.CFrame
                                Focus = CurrentCamera.Focus
                                lookVector = nil
                                dispatch = if not a1.resetCameraAngle then 5 else 1
                            else
                                HumanoidRootPart = a1:GetHumanoidRootPart()
                                dispatch = if not HumanoidRootPart then 3 else 2
                            end
                        elseif dispatch < 3 then
                            lookVector = (HumanoidRootPart.CFrame * u5).lookVector
                            dispatch = 4
                        elseif dispatch < 4 then
                            lookVector = u5.lookVector
                            dispatch = 4
                        else
                            a1.resetCameraAngle = false
                            dispatch = 5
                        end
                    elseif dispatch < 7 then
                        if dispatch < 6 then
                            LocalPlayer = Players.LocalPlayer
                            Humanoid = a1:GetHumanoid()
                            CameraSubject = CurrentCamera.CameraSubject
                            v1 = CameraSubject
                            dispatch = if not v1 then 7 else 6
                        else
                            v1 = CameraSubject:IsA("VehicleSeat")
                            dispatch = 7
                        end
                    elseif dispatch < 8 then
                        v2 = CameraSubject
                        dispatch = if not v2 then 9 else 8
                    elseif dispatch < 9 then
                        v2 = CameraSubject:IsA("SkateboardPlatform")
                        dispatch = 9
                    else
                        v3 = Humanoid
                        dispatch = if not v3 then 13 else 10
                    end
                elseif dispatch < 15 then
                    if dispatch < 12 then
                        if dispatch < 11 then
                            dispatch = if (Humanoid:GetState()) == Enum.HumanoidStateType.Climbing then
                                12
                            else
                                11
                        else
                            v3 = false
                            dispatch = 13
                        end
                    elseif dispatch < 13 then
                        v3 = true
                        dispatch = 13
                    else
                        dispatch = if dispatch < 14 then
                            if a1.lastUpdate == nil then 15 else 14
                        else
                            if not (a2 > 1) then 16 else 15
                    end
                elseif dispatch < 17 then
                    if dispatch < 16 then
                        a1.lastCameraTransform = nil
                        dispatch = 16
                    else
                        v4 = CameraInput.getRotation(a2)
                        a1:StepZoom(a2)

                        CameraHeight = a1:GetCameraHeight()
                        dispatch = if v4 == Vector2.new() then 18 else 17
                    end
                elseif dispatch < 18 then
                    u0 = 0
                    a1.lastUserPanCamera = tick()
                    dispatch = 18
                elseif dispatch < 19 then
                    dispatch = if v8 - a1.lastUserPanCamera < 2 then 20 else 19
                else
                    v5 = false
                    dispatch = 21
                end
            elseif dispatch < 30 then
                if dispatch < 25 then
                    if dispatch < 22 then
                        if dispatch < 21 then
                            v5 = true
                            dispatch = 21
                        else
                            SubjectPosition = a1:GetSubjectPosition()
                            dispatch = if not SubjectPosition then 79 else 22
                        end
                    elseif dispatch < 23 then
                        dispatch = if not LocalPlayer then 79 else 23
                    elseif dispatch < 24 then
                        dispatch = if not CurrentCamera then 79 else 24
                    else
                        CameraToSubjectDistance = a1:GetCameraToSubjectDistance()
                        dispatch = if not (CameraToSubjectDistance < 0.5) then 26 else 25
                    end
                elseif dispatch < 27 then
                    if dispatch < 26 then
                        CameraToSubjectDistance = 0.5
                        dispatch = 26
                    else
                        dispatch = if not a1:GetIsMouseLocked() then 32 else 27
                    end
                elseif dispatch < 28 then
                    dispatch = if a1:IsInFirstPerson() then 32 else 28
                elseif dispatch < 29 then
                    v6 = a1:CalculateNewLookCFrameFromArg(lookVector, v4)
                    MouseLockOffset = a1:GetMouseLockOffset()
                    dispatch = if not Humanoid then 30 else 29
                else
                    MouseLockOffset = MouseLockOffset + Humanoid.CameraOffset
                    dispatch = 30
                end
            elseif dispatch < 35 then
                if dispatch < 32 then
                    if dispatch < 31 then
                        v9 = MouseLockOffset.X * v6.RightVector
                            + MouseLockOffset.Y * v6.UpVector
                            + MouseLockOffset.Z * v6.LookVector
                        dispatch = if not CameraUtils.IsFiniteVector3(v9) then 67 else 31
                    else
                        SubjectPosition = SubjectPosition + v9
                        dispatch = 67
                    end
                elseif dispatch < 33 then
                    dispatch = if v4 ~= Vector2.new() then 34 else 33
                else
                    v6 = not (dispatch < 34)
                    dispatch = 35
                end
            elseif dispatch < 37 then
                dispatch = if dispatch < 36 then
                    if v6 then 67 else 36
                else
                    if not a1.lastCameraTransform then 67 else 37
            elseif dispatch < 38 then
                v7 = a1:IsInFirstPerson()
                dispatch = if v1 then 41 else 38
            else
                dispatch = if dispatch < 39 then
                    if v2 then 41 else 39
                else
                    if not a1.isFollowCamera then 60 else 40
            end
        elseif dispatch < 60 then
            if dispatch < 50 then
                if dispatch < 45 then
                    dispatch = if dispatch < 42 then
                        if dispatch < 41 then
                            if not v3 then 60 else 41
                        else
                            if not a1.lastUpdate then 60 else 42
                    else
                        if dispatch < 43 then
                            if not Humanoid then 60 else 43
                        else
                            if dispatch < 44 then
                                if not Humanoid.Torso then 60 else 44
                            else
                                if not v7 then 52 else 45
                elseif dispatch < 47 then
                    dispatch = if dispatch < 46 then
                        if not a1.lastSubjectCFrame then 67 else 46
                    else
                        if v1 then 48 else 47
                elseif dispatch < 48 then
                    dispatch = if not v2 then 67 else 48
                elseif dispatch < 49 then
                    dispatch = if not CameraSubject:IsA("BasePart") then 67 else 49
                else
                    v9 = -CameraUtils.GetAngleBetweenXZVectors(a1.lastSubjectCFrame.lookVector, CameraSubject.CFrame.lookVector)
                    dispatch = if not CameraUtils.IsFinite(v9) then 51 else 50
                end
            elseif dispatch < 55 then
                if dispatch < 52 then
                    if dispatch < 51 then
                        v4 = v4 + Vector2.new(v9, 0)
                        dispatch = 51
                    else
                        u0 = 0
                        dispatch = 67
                    end
                elseif dispatch < 53 then
                    dispatch = if v5 then 67 else 53
                elseif dispatch < 54 then
                    lookVector_2 = Humanoid.Torso.CFrame.lookVector
                    u0 = math.clamp(u0 + 3.839724354387525 * a2, 0, 4.363323129985824)
                    v10 = math.clamp(u0 * a2, 0, 1)
                    dispatch = if not a1:IsInFirstPerson() then 57 else 54
                else
                    dispatch = if not a1.isFollowCamera then 56 else 55
                end
            elseif dispatch < 57 then
                if dispatch < 56 then
                    dispatch = if a1.isClimbing then 57 else 56
                else
                    v10 = 1
                    dispatch = 57
                end
            elseif dispatch < 58 then
                v11 = CameraUtils.GetAngleBetweenXZVectors(lookVector_2, a1:GetCameraLookVector())
                dispatch = if not CameraUtils.IsFinite(v11) then 67 else 58
            elseif dispatch < 59 then
                dispatch = if not (0.0001 < (math.abs(v11))) then 67 else 59
            else
                v4 = v4 + Vector2.new(v11 * v10, 0)
                dispatch = 67
            end
        elseif dispatch < 70 then
            if dispatch < 65 then
                if dispatch < 62 then
                    dispatch = if dispatch < 61 then
                        if not a1.isFollowCamera then 67 else 61
                    else
                        if v7 then 67 else 62
                elseif dispatch < 63 then
                    dispatch = if v5 then 67 else 63
                elseif dispatch < 64 then
                    v10 = CameraUtils.GetAngleBetweenXZVectors(-(a1.lastCameraTransform.Position - SubjectPosition), a1:GetCameraLookVector())
                    dispatch = if not CameraUtils.IsFinite(v10) then 67 else 64
                else
                    dispatch = if not (0.0001 < (math.abs(v10))) then 67 else 65
                end
            elseif dispatch < 67 then
                if dispatch < 66 then
                    v11 = math.abs(v10)
                    dispatch = if not (0.4 * a2 < v11) then 67 else 66
                else
                    v4 = v4 + Vector2.new(v10, 0)
                    dispatch = 67
                end
            elseif dispatch < 68 then
                dispatch = if a1.isFollowCamera then 71 else 68
            elseif dispatch < 69 then
                v13 = CFrame.new(SubjectPosition)
                Position = v13.Position
                v7 = a1:CalculateNewLookVectorFromArg(lookVector, v4)
                dispatch = if not u21 then 70 else 69
            else
                v12 = CFrame.lookAlong(Position - CameraToSubjectDistance * v7, v7)
                dispatch = 74
            end
        elseif dispatch < 75 then
            if dispatch < 72 then
                if dispatch < 71 then
                    v12 = CFrame.new(Position - CameraToSubjectDistance * v7, Position)
                    dispatch = 74
                else
                    v6 = a1:CalculateNewLookVectorFromArg(lookVector, v4)
                    v13 = CFrame.new(SubjectPosition)
                    dispatch = if not u21 then 73 else 72
                end
            elseif dispatch < 73 then
                v12 = CFrame.lookAlong(v13.Position - CameraToSubjectDistance * v6, v6)
                dispatch = 74
            elseif dispatch < 74 then
                v12 = (CFrame.new(v13.Position - CameraToSubjectDistance * v6, v13.Position))
                    + Vector3.new(0, CameraHeight, 0)
                dispatch = 74
            else
                CameraToggleOffset = a1:GetCameraToggleOffset(a2)
                Focus = v13 + CameraToggleOffset
                CFrame_2 = v12 + CameraToggleOffset
                a1.lastCameraTransform = CFrame_2
                a1.lastCameraFocus = Focus
                dispatch = if v1 then 76 else 75
            end
        elseif dispatch < 77 then
            dispatch = if dispatch < 76 then
                if not v2 then 78 else 76
            else
                if not CameraSubject:IsA("BasePart") then 78 else 77
        else
            if dispatch < 78 then
                a1.lastSubjectCFrame = CameraSubject.CFrame
            else
                if not (dispatch < 79) then
                    a1.lastUpdate = v8
                    return CFrame_2, Focus
                end

                a1.lastSubjectCFrame = nil
            end

            dispatch = 79
        end
    end
end

return u54