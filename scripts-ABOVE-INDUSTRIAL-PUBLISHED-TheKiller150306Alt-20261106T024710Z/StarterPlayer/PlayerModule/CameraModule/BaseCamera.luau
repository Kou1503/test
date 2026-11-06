-- Script path: game:GetService("StarterPlayer").PlayerModule.CameraModule.BaseCamera
-- Decompile time: 8.72 ms

local Players = game:GetService("Players")
local VRService = game:GetService("VRService")
local GuiService = game:GetService("GuiService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"))
local ConnectionUtil = CommonUtils.get("ConnectionUtil")

CommonUtils.get("FlagUtil")

local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local u52 = require(script.Parent:WaitForChild("ZoomController"))
local CameraToggleStateController = require(script.Parent:WaitForChild("CameraToggleStateController"))
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local CameraUI = require(script.Parent:WaitForChild("CameraUI"))
local u92 = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext"):WaitForChild("CameraGamepadZoomAction")
local LocalPlayer = Players.LocalPlayer
local u95 = {}
u95.__index = u95

function u95.new()
    -- Line: 74
    -- upvalues: u95 (val), ConnectionUtil (val), LocalPlayer (val), u92 (val), UserGameSettings (val)
    local u3 = setmetatable(
        {},
        u95
    )
    u3._connections = ConnectionUtil.new()
    u3.gamepadZoomLevels = {0, 10, 20}
    u3.FIRST_PERSON_DISTANCE_THRESHOLD = 1
    u3.cameraType = nil
    u3.cameraMovementMode = nil
    u3.lastCameraTransform = nil
    u3.lastUserPanCamera = tick()
    u3.humanoidRootPart = nil
    u3.humanoidCache = {}
    u3.lastSubject = nil
    u3.lastSubjectPosition = Vector3.new(0, 5, 0)
    u3.lastSubjectCFrame = CFrame.new(u3.lastSubjectPosition)
    u3.currentSubjectDistance = math.clamp(12.5, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance)
    u3.inFirstPerson = false
    u3.inMouseLockedMode = false
    u3.resetCameraAngle = true
    u3.enabled = false
    u3.cameraChangedConn = nil
    u3.shouldUseVRRotation = false
    u3.VRRotationIntensityAvailable = false
    u3.lastVRRotationIntensityCheckTime = 0
    u3.lastVRRotationTime = 0
    u3.vrRotateKeyCooldown = {}
    u3.cameraTranslationConstraints = Vector3.new(1, 1, 1)
    u3.humanoidJumpOrigin = nil
    u3.trackingHumanoid = nil
    u3.cameraFrozen = false
    u3.subjectStateChangedConn = nil
    u3.gamepadZoomPressConnection = u92.Pressed:Connect(function() -- Line: 122; upvalues: u3 (val)
        u3:GamepadZoomPress()
    end)
    u3.mouseLockOffset = Vector3.new(0, 0, 0)

    UserGameSettings:SetCameraYInvertVisible()
    UserGameSettings:SetGamepadCameraSensitivityVisible()

    return u3
end

function u95.GetModuleName(a1) -- Line: 136
    return "BaseCamera"
end

local function onSelectedObjectChanged() -- Line: 140; upvalues: u92 (val), GuiService (val)
    u92.Enabled = not GuiService.SelectedObject
end

function u95:_setUpConfigurations() -- Line: 144; upvalues: LocalPlayer (val), GuiService (val), u92 (val)
    self._connections:trackConnection(
        "CHARACTER_ADDED",
        (LocalPlayer.CharacterAdded:Connect(function(a1) -- Line: 145; upvalues: self (val)
            self:OnCharacterAdded(a1)
        end))
    )

    self.humanoidRootPart = nil
    self._connections:trackConnection(
        "CAMERA_MODE_CHANGED",
        ((LocalPlayer:GetPropertyChangedSignal("CameraMode")):Connect(function() -- Line: 150; upvalues: self (val)
            self:OnPlayerCameraPropertyChange()
        end))
    )

    self._connections:trackConnection(
        "CAMERA_MIN_DISTANCE_CHANGED",
        ((LocalPlayer:GetPropertyChangedSignal("CameraMinZoomDistance")):Connect(function()
            -- Line: 153
            -- upvalues: self (val)
            self:OnPlayerCameraPropertyChange()
        end))
    )

    self._connections:trackConnection(
        "CAMERA_MAX_DISTANCE_CHANGED",
        ((LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance")):Connect(function()
            -- Line: 156
            -- upvalues: self (val)
            self:OnPlayerCameraPropertyChange()
        end))
    )

    self._connections:trackConnection(
        "SELECTION_MODE_CHANGED",
        ((GuiService:GetPropertyChangedSignal("SelectedObject")):Connect(function()
            -- Line: 159
            -- upvalues: u92 (upval), GuiService (upval)
            u92.Enabled = not GuiService.SelectedObject
        end))
    )

    self:OnPlayerCameraPropertyChange()
end

function u95:OnCharacterAdded(a2) -- Line: 165
    local resetCameraAngle = self.resetCameraAngle or self:GetEnabled()
    self.resetCameraAngle = resetCameraAngle
    self.humanoidRootPart = nil
end

function u95.GetHumanoidRootPart(a1) -- Line: 172; upvalues: LocalPlayer (val)
    if not a1.humanoidRootPart and LocalPlayer.Character then
        local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            a1.humanoidRootPart = Humanoid.RootPart
        end
    end

    return a1.humanoidRootPart
end

function u95.GetSubjectCFrame(a1) -- Line: 184
    local lastSubjectCFrame = a1.lastSubjectCFrame
    local CurrentCamera = workspace.CurrentCamera
    local CameraSubject = CurrentCamera and CurrentCamera.CameraSubject

    if not CameraSubject then
        return lastSubjectCFrame
    end

    if CameraSubject:IsA("Humanoid") then
        local v1 = (CameraSubject:GetState()) == Enum.HumanoidStateType.Dead
        local CameraOffset = CameraSubject.CameraOffset

        if a1:GetIsMouseLocked() then
            CameraOffset = Vector3.new()
        end

        local RootPart = CameraSubject.RootPart

        if v1 and CameraSubject.Parent and CameraSubject.Parent:IsA("Model") then
            RootPart = CameraSubject.Parent:FindFirstChild("Head") or RootPart
        end

        if RootPart and RootPart:IsA("BasePart") then
            local v2

            if CameraSubject.RigType ~= Enum.HumanoidRigType.R15 then
                v2 = Vector3.new(0, 1.5, 0)
            elseif not CameraSubject.AutomaticScalingEnabled then
                v2 = Vector3.new(0, 2, 0)
            else
                v2 = Vector3.new(0, 1.5, 0)
                local RootPart_2 = CameraSubject.RootPart

                if RootPart == RootPart_2 then
                    v2 = v2 + Vector3.new(0, (RootPart_2.Size.Y - 2) / 2, 0)
                end
            end

            if v1 then
                v2 = Vector3.new(0, 0, 0)
            end

            lastSubjectCFrame = RootPart.CFrame * CFrame.new(v2 + CameraOffset)
        end
    elseif CameraSubject:IsA("BasePart") then
        lastSubjectCFrame = CameraSubject.CFrame
    elseif CameraSubject:IsA("Model") then
        lastSubjectCFrame = if not CameraSubject.PrimaryPart then
            CFrame.new()
        else
            CameraSubject:GetPrimaryPartCFrame()
    end

    if lastSubjectCFrame then
        a1.lastSubjectCFrame = lastSubjectCFrame
    end

    return lastSubjectCFrame
end

function u95.GetSubjectVelocity(a1) -- Line: 258
    local CurrentCamera = workspace.CurrentCamera
    local CameraSubject = CurrentCamera and CurrentCamera.CameraSubject

    if not CameraSubject then
        return (Vector3.new(0, 0, 0))
    end

    if CameraSubject:IsA("BasePart") then
        return CameraSubject.Velocity
    end

    if CameraSubject:IsA("Humanoid") then
        local RootPart = CameraSubject.RootPart

        if RootPart then
            return RootPart.Velocity
        end

        return (Vector3.new(0, 0, 0))
    end

    if CameraSubject:IsA("Model") then
        local PrimaryPart = CameraSubject.PrimaryPart

        if PrimaryPart then
            return PrimaryPart.Velocity
        end
    end

    return (Vector3.new(0, 0, 0))
end

function u95.GetSubjectRotVelocity(a1) -- Line: 287
    local CurrentCamera = workspace.CurrentCamera
    local CameraSubject = CurrentCamera and CurrentCamera.CameraSubject

    if not CameraSubject then
        return (Vector3.new(0, 0, 0))
    end

    if CameraSubject:IsA("BasePart") then
        return CameraSubject.RotVelocity
    end

    if CameraSubject:IsA("Humanoid") then
        local RootPart = CameraSubject.RootPart

        if RootPart then
            return RootPart.RotVelocity
        end

        return (Vector3.new(0, 0, 0))
    end

    if CameraSubject:IsA("Model") then
        local PrimaryPart = CameraSubject.PrimaryPart

        if PrimaryPart then
            return PrimaryPart.RotVelocity
        end
    end

    return (Vector3.new(0, 0, 0))
end

function u95.StepZoom(a1, a2) -- Line: 316; upvalues: CameraInput (val), u52 (val); types: a1: table, a2: number?
    local currentSubjectDistance = a1.currentSubjectDistance
    local v1 = CameraInput.getZoomDelta(a2)
    local v2 = math.abs(v1)

    if v2 > 0 then
        v2 = if not (v1 > 0) then
            math.max((currentSubjectDistance + v1) / (1 - v1 * 0.5), 0.5)
        else
            math.max(currentSubjectDistance + v1 * (currentSubjectDistance * 0.5 + 1), a1.FIRST_PERSON_DISTANCE_THRESHOLD)

        if v2 < a1.FIRST_PERSON_DISTANCE_THRESHOLD then
            v2 = 0.5
        end

        a1:SetCameraToSubjectDistance(v2)
    end

    return u52.GetZoomRadius()
end

function u95:GetSubjectPosition() -- Line: 341
    local lastSubjectPosition = self.lastSubjectPosition
    local CurrentCamera = game.Workspace.CurrentCamera
    local CameraSubject = CurrentCamera and CurrentCamera.CameraSubject

    if not CameraSubject then
        return nil
    end

    if CameraSubject:IsA("Humanoid") then
        local v1 = (CameraSubject:GetState()) == Enum.HumanoidStateType.Dead
        local CameraOffset = CameraSubject.CameraOffset

        if self:GetIsMouseLocked() then
            CameraOffset = Vector3.new()
        end

        local RootPart = CameraSubject.RootPart

        if v1 and CameraSubject.Parent and CameraSubject.Parent:IsA("Model") then
            RootPart = CameraSubject.Parent:FindFirstChild("Head") or RootPart
        end

        if RootPart and RootPart:IsA("BasePart") then
            local v2

            if CameraSubject.RigType ~= Enum.HumanoidRigType.R15 then
                v2 = Vector3.new(0, 1.5, 0)
            elseif not CameraSubject.AutomaticScalingEnabled then
                v2 = Vector3.new(0, 2, 0)
            else
                v2 = Vector3.new(0, 1.5, 0)

                if RootPart == CameraSubject.RootPart then
                    v2 = v2 + Vector3.new(0, CameraSubject.RootPart.Size.Y / 2 - 1, 0)
                end
            end

            if v1 then
                v2 = Vector3.new(0, 0, 0)
            end

            lastSubjectPosition = RootPart.CFrame.Position
                + RootPart.CFrame:vectorToWorldSpace(v2 + CameraOffset)
        end
    elseif CameraSubject:IsA("VehicleSeat") then
        lastSubjectPosition = CameraSubject.CFrame.Position
            + CameraSubject.CFrame:vectorToWorldSpace((Vector3.new(0, 5, 0)))
    elseif CameraSubject:IsA("SkateboardPlatform") then
        lastSubjectPosition = CameraSubject.CFrame.Position + Vector3.new(0, 5, 0)
    elseif CameraSubject:IsA("BasePart") then
        lastSubjectPosition = CameraSubject.CFrame.Position
    elseif CameraSubject:IsA("Model") then
        lastSubjectPosition = if not CameraSubject.PrimaryPart then
            CameraSubject:GetModelCFrame().Position
        else
            CameraSubject:GetPrimaryPartCFrame().Position
    end

    self.lastSubject = CameraSubject
    self.lastSubjectPosition = lastSubjectPosition

    return lastSubjectPosition
end

function u95:OnCurrentCameraChanged() -- Line: 419
    if self.cameraSubjectChangedConn then
        self.cameraSubjectChangedConn:Disconnect()

        self.cameraSubjectChangedConn = nil
    end

    local CurrentCamera = game.Workspace.CurrentCamera

    if CurrentCamera then
        self.cameraSubjectChangedConn = (CurrentCamera:GetPropertyChangedSignal("CameraSubject")):Connect(function()
            -- Line: 428
            -- upvalues: self (val)
            self:OnNewCameraSubject()
        end)
        self:OnNewCameraSubject()
    end
end

function u95:OnPlayerCameraPropertyChange() -- Line: 435
    self:SetCameraToSubjectDistance(self.currentSubjectDistance)
end

function u95.InputTranslationToCameraAngleChange(a1, a2, a3) -- Line: 440
    return a2 * a3
end

function u95:GamepadZoomPress() -- Line: 446; upvalues: LocalPlayer (val)
    local CameraMinZoomDistance
    local CameraToSubjectDistance = self:GetCameraToSubjectDistance()
    local CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance

    for i = #self.gamepadZoomLevels, 1, -1 do
        CameraMinZoomDistance = self.gamepadZoomLevels[i]

        if not (CameraMaxZoomDistance < CameraMinZoomDistance) then
            if CameraMinZoomDistance < LocalPlayer.CameraMinZoomDistance then
                CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance

                if CameraMaxZoomDistance == CameraMinZoomDistance then
                    break
                end
            end

            if CameraMinZoomDistance + (CameraMaxZoomDistance - CameraMinZoomDistance) / 2
                < CameraToSubjectDistance then
                self:SetCameraToSubjectDistance(CameraMinZoomDistance)
                return
            end

            CameraMaxZoomDistance = CameraMinZoomDistance
        end
    end

    self:SetCameraToSubjectDistance(self.gamepadZoomLevels[#self.gamepadZoomLevels])
end

function u95.Enable(a1, a2) -- Line: 483; types: a1: table, a2: boolean
    if a1.enabled ~= a2 then
        a1.enabled = a2
        a1:OnEnabledChanged()
    end
end

function u95:OnEnabledChanged() -- Line: 491; upvalues: CameraInput (val), u92 (val), LocalPlayer (val)
    if not self.enabled then
        self._connections:disconnectAll()
        CameraInput.setInputEnabled(false)

        u92.Enabled = false
        self:Cleanup()

        return
    end

    self:_setUpConfigurations()
    CameraInput.setInputEnabled(true)

    u92.Enabled = true

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        self.currentSubjectDistance = 0.5

        if not self.inFirstPerson then
            self:EnterFirstPerson()
        end
    end

    if self.cameraChangedConn then
        self.cameraChangedConn:Disconnect()

        self.cameraChangedConn = nil
    end

    self.cameraChangedConn = (workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(function()
        -- Line: 507
        -- upvalues: self (val)
        self:OnCurrentCameraChanged()
    end)
    self:OnCurrentCameraChanged()
end

function u95:GetEnabled() -- Line: 522
    return self.enabled
end

function u95:Cleanup() -- Line: 526; upvalues: CameraUtils (val)
    if self.subjectStateChangedConn then
        self.subjectStateChangedConn:Disconnect()

        self.subjectStateChangedConn = nil
    end

    if self.cameraChangedConn then
        self.cameraChangedConn:Disconnect()

        self.cameraChangedConn = nil
    end

    self.lastCameraTransform = nil
    self.lastSubjectCFrame = nil

    CameraUtils.restoreMouseBehavior()
end

function u95:UpdateMouseBehavior()
    -- Line: 543
    -- upvalues: UserGameSettings (val), CameraUI (val), CameraInput (val), CameraToggleStateController (val)
    -- upvalues: CameraUtils (val)
    local v1 = UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove

    if self.isCameraToggle and not v1 then
        CameraUI.setCameraModeToastEnabled(true)
        CameraInput.enableCameraToggleInput()
        CameraToggleStateController(self.inFirstPerson)

        return
    end

    CameraUI.setCameraModeToastEnabled(false)
    CameraInput.disableCameraToggleInput()

    if not self.inFirstPerson and not self.inMouseLockedMode then
        CameraUtils.restoreRotationType()

        if CameraInput.getPanActivated() then
            CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
            return
        end

        CameraUtils.restoreMouseBehavior()

        return
    end

    CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative)
    CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
end

function u95.UpdateForDistancePropertyChange(a1) -- Line: 571
    a1:SetCameraToSubjectDistance(a1.currentSubjectDistance)
end

function u95:SetCameraToSubjectDistance(a2)
    -- Line: 577
    -- upvalues: LocalPlayer (val), u52 (val)
    -- types: self: table, a2: number
    local currentSubjectDistance = self.currentSubjectDistance

    if LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
        local v1 = math.clamp(a2, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance)

        if not (v1 < 1) then
            self.currentSubjectDistance = v1

            if self.inFirstPerson then
                self:LeaveFirstPerson()
            end
        else
            self.currentSubjectDistance = 0.5

            if not self.inFirstPerson then
                self:EnterFirstPerson()
            end
        end
    else
        self.currentSubjectDistance = 0.5

        if not self.inFirstPerson then
            self:EnterFirstPerson()
        end
    end

    u52.SetZoomParameters(self.currentSubjectDistance, (math.sign(a2 - currentSubjectDistance)))

    return self.currentSubjectDistance
end

function u95.SetCameraType(a1, a2) -- Line: 611
    a1.cameraType = a2
end

function u95.GetCameraType(a1) -- Line: 616
    return a1.cameraType
end

function u95.SetCameraMovementMode(a1, a2) -- Line: 621
    a1.cameraMovementMode = a2
end

function u95.GetCameraMovementMode(a1) -- Line: 625
    return a1.cameraMovementMode
end

function u95.SetIsMouseLocked(a1, a2) -- Line: 629; types: a1: table, a2: boolean
    a1.inMouseLockedMode = a2
end

function u95:GetIsMouseLocked() -- Line: 633
    return self.inMouseLockedMode
end

function u95.SetMouseLockOffset(a1, a2) -- Line: 637
    a1.mouseLockOffset = a2
end

function u95.GetMouseLockOffset(a1) -- Line: 641
    return a1.mouseLockOffset
end

function u95.InFirstPerson(a1) -- Line: 645
    return a1.inFirstPerson
end

function u95:EnterFirstPerson() -- Line: 649
    self.inFirstPerson = true
    self:UpdateMouseBehavior()
end

function u95:LeaveFirstPerson() -- Line: 654
    self.inFirstPerson = false
    self:UpdateMouseBehavior()
end

function u95:GetCameraToSubjectDistance() -- Line: 660
    return self.currentSubjectDistance
end

function u95.GetMeasuredDistanceToFocus(a1) -- Line: 667
    local CurrentCamera = game.Workspace.CurrentCamera

    if CurrentCamera then
        return (CurrentCamera.CoordinateFrame.Position - CurrentCamera.Focus.Position).magnitude
    end

    return nil
end

function u95.GetCameraLookVector(a1) -- Line: 675
    return game.Workspace.CurrentCamera
        and game.Workspace.CurrentCamera.CFrame.LookVector
        or Vector3.new(0, 0, 1)
end

function u95:CalculateNewLookCFrameFromArg(a2, a3) -- Line: 679; types: self: table, a2: vector?, a3: userdata
    local CameraLookVector = a2 or self:GetCameraLookVector()
    local v1 = math.asin(CameraLookVector.Y)
    v1 = Vector2.new(a3.X, (math.clamp(a3.Y, v1 + -1.3962634015954636, v1 + 1.3962634015954636)))
    local v2 = CFrame.new(Vector3.new(0, 0, 0), CameraLookVector)

    return CFrame.Angles(0, -v1.X, 0) * v2 * CFrame.Angles(-v1.Y, 0, 0)
end

function u95.CalculateNewLookVectorFromArg(a1, a2, a3) -- Line: 689; types: a1: table, a2: vector?, a3: userdata
    return a1:CalculateNewLookCFrameFromArg(a2, a3).LookVector
end

function u95.CalculateNewLookVectorVRFromArg(a1, a2) -- Line: 694; types: a1: table, a2: userdata
    local unit = ((a1:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.Position) * Vector3.new(1, 0, 1)).unit
    local v1 = Vector2.new(a2.X, 0)
    local v2 = CFrame.new(Vector3.new(0, 0, 0), unit)

    return ((CFrame.Angles(0, -v1.X, 0) * v2 * CFrame.Angles(-v1.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit
end

function u95.GetHumanoid(a1) -- Line: 704; upvalues: LocalPlayer (val)
    local Character = LocalPlayer and LocalPlayer.Character

    if not Character then
        return nil
    end

    local v1 = a1.humanoidCache[LocalPlayer]

    if v1 and v1.Parent == Character then
        return v1
    end

    a1.humanoidCache[LocalPlayer] = nil
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        a1.humanoidCache[LocalPlayer] = Humanoid
    end

    return Humanoid
end

function u95:OnNewCameraSubject() -- Line: 722
    if self.subjectStateChangedConn then
        self.subjectStateChangedConn:Disconnect()

        self.subjectStateChangedConn = nil
    end
end

function u95.IsInFirstPerson(a1) -- Line: 729
    return a1.inFirstPerson
end

function u95.Update(a1, a2) -- Line: 733
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2)
end

function u95.GetCameraHeight(a1) -- Line: 737; upvalues: VRService (val)
    if VRService.VREnabled and not a1.inFirstPerson then
        return 0.25881904510252074 * a1.currentSubjectDistance
    end

    return 0
end

return u95