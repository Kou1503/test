-- Script path: game:GetService("StarterPlayer").PlayerModule.CameraModule
-- Decompile time: 8.80 ms

local u0 = {}
u0.__index = u0
local u1 = {
    "CameraMinZoomDistance",
    "CameraMaxZoomDistance",
    "CameraMode",
    "DevCameraOcclusionMode",
    "DevComputerCameraMode",
    "DevTouchCameraMode",
    "DevComputerMovementMode",
    "DevTouchMovementMode",
    "DevEnableMouseLock",
}
local u11 = {
    "ComputerCameraMovementMode",
    "ComputerMovementMode",
    "ControlMode",
    "GamepadCameraSensitivity",
    "MouseSensitivity",
    "RotationType",
    "TouchCameraMovementMode",
    "TouchMovementMode",
}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local CommonUtils = require(script.Parent:WaitForChild("CommonUtils"))
local ConnectionUtil = CommonUtils.get("ConnectionUtil")
local FlagUtil = CommonUtils.get("FlagUtil")
local CameraUtils = require(script:WaitForChild("CameraUtils"))

require(script:WaitForChild("CameraInput"))

local ClassicCamera = require(script:WaitForChild("ClassicCamera"))
local OrbitalCamera = require(script:WaitForChild("OrbitalCamera"))
local LegacyCamera = require(script:WaitForChild("LegacyCamera"))
local VehicleCamera = require(script:WaitForChild("VehicleCamera"))
local VRCamera = require(script:WaitForChild("VRCamera"))
local VRVehicleCamera = require(script:WaitForChild("VRVehicleCamera"))
local Invisicam = require(script:WaitForChild("Invisicam"))
local Poppercam = require(script:WaitForChild("Poppercam"))
local TransparencyController = require(script:WaitForChild("TransparencyController"))
local MouseLockController = require(script:WaitForChild("MouseLockController"))
local u144 = {}
local u145 = {}

if not Players.LocalPlayer then
    return {}
end

assert(Players.LocalPlayer, "Strict typing check")

local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts")
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default)
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow)
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic)
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default)
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow)
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic)
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle)

local UserPlayerConnectionMemoryLeak = FlagUtil.getUserFlag("UserPlayerConnectionMemoryLeak")
local UserPSFixCameraControllerReset = FlagUtil.getUserFlag("UserPSFixCameraControllerReset")
local UserVRFixCameraCloseArticulation = FlagUtil.getUserFlag("UserVRFixCameraCloseArticulation")
local _FFlagUserOrthographicOcclusion = FFlagUserOrthographicOcclusion

if _FFlagUserOrthographicOcclusion then
    _FFlagUserOrthographicOcclusion = pcall(function() -- Line: 107
        return Instance.new("Camera").ProjectionType
    end)
end

local VRFirstPersonState = CommonUtils.get("VRFirstPersonState")

function u0.new()
    -- Line: 151
    -- upvalues: TransparencyController (val), UserPlayerConnectionMemoryLeak (val), ConnectionUtil (val), u0 (val)
    -- upvalues: Players (val), MouseLockController (val), u1 (val), u11 (val), UserGameSettings (val)
    -- upvalues: UserInputService (val)
    local v1 = {
        activeTransparencyController = TransparencyController.new(),
        connectionUtil = if not UserPlayerConnectionMemoryLeak then nil else ConnectionUtil.new(),
    }
    local u13 = setmetatable(v1, u0)
    u13.activeCameraController = nil
    u13.activeOcclusionModule = nil
    u13.activeMouseLockController = nil
    u13.currentComputerCameraMovementMode = nil
    u13.cameraSubjectChangedConn = nil
    u13.cameraTypeChangedConn = nil

    for k, v in pairs(Players:GetPlayers()) do
        u13:OnPlayerAdded(v)
    end

    Players.PlayerAdded:Connect(function(a1) -- Line: 174; upvalues: u13 (val)
        u13:OnPlayerAdded(a1)
    end)

    if UserPlayerConnectionMemoryLeak then
        Players.PlayerRemoving:Connect(function(a1) -- Line: 179; upvalues: u13 (val)
            u13:OnPlayerRemoving(a1)
        end)
    end

    u13.activeTransparencyController:Enable(true)

    u13.activeMouseLockController = MouseLockController.new()
    assert(u13.activeMouseLockController, "Strict typing check")

    local BindableToggleEvent = u13.activeMouseLockController:GetBindableToggleEvent()

    if BindableToggleEvent then
        BindableToggleEvent:Connect(function() -- Line: 191; upvalues: u13 (val)
            u13:OnMouseLockToggled()
        end)
    end

    u13:ActivateCameraController()
    u13:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode)
    u13:OnCurrentCameraChanged()

    for k2, i in pairs(u1) do
        (Players.LocalPlayer:GetPropertyChangedSignal(i)):Connect(function()
            -- Line: 201
            -- upvalues: u13 (val), i (val)
            u13:OnLocalPlayerCameraPropertyChanged(i)
        end)
    end

    for k3, j in pairs(u11) do
        (UserGameSettings:GetPropertyChangedSignal(j)):Connect(function() -- Line: 207; upvalues: u13 (val), j (val)
            u13:OnUserGameSettingsPropertyChanged(j)
        end)
    end

    ;(game.Workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(function() -- Line: 211; upvalues: u13 (val)
        u13:OnCurrentCameraChanged()
    end)

    ;(UserInputService:GetPropertyChangedSignal("PreferredInput")):Connect(function() -- Line: 214; upvalues: u13 (val)
        u13:OnPreferredInputChanged()
    end)

    return u13
end

function u0.GetCameraMovementModeFromSettings(a1)
    -- Line: 221
    -- upvalues: Players (val), CameraUtils (val), UserInputService (val), UserGameSettings (val)
    local v1, v2

    if Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return CameraUtils.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic)
    end

    if UserInputService.PreferredInput ~= Enum.PreferredInput.Touch then
        v1 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevComputerCameraMode)
        v2 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.ComputerCameraMovementMode)
    else
        v1 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevTouchCameraMode)
        v2 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.TouchCameraMovementMode)
    end

    if v1 == Enum.DevComputerCameraMovementMode.UserChoice then
        return v2
    end

    return v1
end

function u0:ActivateOcclusionModule(a2)
    -- Line: 246
    -- upvalues: Poppercam (val), Invisicam (val), u145 (val), Players (val)
    local activeOcclusionModule, v1

    if a2 == Enum.DevCameraOcclusionMode.Zoom then
        self.occlusionMode = a2

        if self.activeOcclusionModule and self.activeOcclusionModule:GetOcclusionMode() == a2 then
            if not self.activeOcclusionModule:GetEnabled() then
                self.activeOcclusionModule:Enable(true)
            end

            return
        end

        activeOcclusionModule = self.activeOcclusionModule
        self.activeOcclusionModule = u145[Poppercam]

        if not self.activeOcclusionModule then
            self.activeOcclusionModule = v1.new()

            if self.activeOcclusionModule then
                u145[v1] = self.activeOcclusionModule
            end
        end

        if self.activeOcclusionModule then
            if self.activeOcclusionModule:GetOcclusionMode() ~= a2 then
                warn("CameraScript ActivateOcclusionModule mismatch: ", self.activeOcclusionModule:GetOcclusionMode(), "~=", a2)
            end

            if activeOcclusionModule then
                if activeOcclusionModule == self.activeOcclusionModule then
                    warn("CameraScript ActivateOcclusionModule failure to detect already running correct module")
                else
                    activeOcclusionModule:Enable(false)
                end
            end

            if a2 ~= Enum.DevCameraOcclusionMode.Invisicam then
                for k2, i in pairs(Players:GetPlayers()) do
                    if i and i.Character then
                        self.activeOcclusionModule:CharacterAdded(i.Character, i)
                    end
                end

                self.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject)
            elseif Players.LocalPlayer.Character then
                self.activeOcclusionModule:CharacterAdded(Players.LocalPlayer.Character, Players.LocalPlayer)
            end

            self.activeOcclusionModule:Enable(true)
        end

        return
    end

    if a2 ~= Enum.DevCameraOcclusionMode.Invisicam then
        warn("CameraScript ActivateOcclusionModule called with unsupported mode")
        return
    end

    self.occlusionMode = a2

    if self.activeOcclusionModule and self.activeOcclusionModule:GetOcclusionMode() == a2 then
        if not self.activeOcclusionModule:GetEnabled() then
            self.activeOcclusionModule:Enable(true)
        end

        return
    end

    activeOcclusionModule = self.activeOcclusionModule
    self.activeOcclusionModule = u145[Invisicam]

    if not self.activeOcclusionModule then
        self.activeOcclusionModule = v1.new()

        if self.activeOcclusionModule then
            u145[v1] = self.activeOcclusionModule
        end
    end

    if self.activeOcclusionModule then
        if self.activeOcclusionModule:GetOcclusionMode() ~= a2 then
            warn("CameraScript ActivateOcclusionModule mismatch: ", self.activeOcclusionModule:GetOcclusionMode(), "~=", a2)
        end

        if activeOcclusionModule then
            if activeOcclusionModule == self.activeOcclusionModule then
                warn("CameraScript ActivateOcclusionModule failure to detect already running correct module")
            else
                activeOcclusionModule:Enable(false)
            end
        end

        if a2 ~= Enum.DevCameraOcclusionMode.Invisicam then
            for k, v in pairs(Players:GetPlayers()) do
                if v and v.Character then
                    self.activeOcclusionModule:CharacterAdded(v.Character, v)
                end
            end

            self.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject)
        elseif Players.LocalPlayer.Character then
            self.activeOcclusionModule:CharacterAdded(Players.LocalPlayer.Character, Players.LocalPlayer)
        end

        self.activeOcclusionModule:Enable(true)
    end
end

function u0:ShouldUseVehicleCamera() -- Line: 325
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return false
    end

    local CameraType = CurrentCamera.CameraType
    local CameraSubject = CurrentCamera.CameraSubject
    local v1 = true

    if CameraType ~= Enum.CameraType.Custom then
        v1 = CameraType == Enum.CameraType.Follow
    end

    local v2 = CameraSubject and CameraSubject:IsA("VehicleSeat") or false
    local v3 = self.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam

    return v2 and v1 and v3
end

function u0:ActivateCameraController()
    -- Line: 341
    -- upvalues: LegacyCamera (val), VRService (val), VRCamera (val), ClassicCamera (val), OrbitalCamera (val)
    -- upvalues: VRVehicleCamera (val), VehicleCamera (val), u144 (val), UserPSFixCameraControllerReset (val)
    local v1
    local CameraType = workspace.CurrentCamera.CameraType
    local CameraMovementModeFromSettings = self:GetCameraMovementModeFromSettings()
    local v2 = nil

    if CameraType == Enum.CameraType.Scriptable then
        if self.activeCameraController then
            self.activeCameraController:Enable(false)

            self.activeCameraController = nil
        end

        return
    end

    if CameraType == Enum.CameraType.Custom then
        CameraMovementModeFromSettings = self:GetCameraMovementModeFromSettings()
    elseif CameraType == Enum.CameraType.Track then
        CameraMovementModeFromSettings = Enum.ComputerCameraMovementMode.Classic
    elseif CameraType == Enum.CameraType.Follow then
        CameraMovementModeFromSettings = Enum.ComputerCameraMovementMode.Follow
    elseif CameraType == Enum.CameraType.Orbital then
        CameraMovementModeFromSettings = Enum.ComputerCameraMovementMode.Orbital
    elseif CameraType == Enum.CameraType.Attach or CameraType == Enum.CameraType.Watch then
        v2 = LegacyCamera
    elseif CameraType ~= Enum.CameraType.Fixed then
        warn("CameraScript encountered an unhandled Camera.CameraType value: ", CameraType)
    else
        v2 = LegacyCamera
    end

    if not v2 then
        if not VRService.VREnabled then
            if CameraMovementModeFromSettings ~= Enum.ComputerCameraMovementMode.Classic
                and CameraMovementModeFromSettings ~= Enum.ComputerCameraMovementMode.Follow
                and CameraMovementModeFromSettings ~= Enum.ComputerCameraMovementMode.Default
                and CameraMovementModeFromSettings ~= Enum.ComputerCameraMovementMode.CameraToggle then
                if CameraMovementModeFromSettings ~= Enum.ComputerCameraMovementMode.Orbital then
                    warn("ActivateCameraController did not select a module.")
                    return
                end

                v2 = OrbitalCamera

                if self:ShouldUseVehicleCamera() then
                    v2 = if not VRService.VREnabled then VehicleCamera else VRVehicleCamera
                end

                if u144[v2] then
                    v1 = u144[v2]

                    if not UserPSFixCameraControllerReset then
                        if v1.Reset then
                            v1:Reset()
                        end
                    elseif v1.Reset and self.activeCameraController ~= v1 then
                        v1:Reset()
                    end
                else
                    u144[v2] = (v2.new())
                end

                if not self.activeCameraController then
                    if v1 ~= nil then
                        self.activeCameraController = v1
                        assert(self.activeCameraController, "Strict typing check")
                        self.activeCameraController:Enable(true)
                    end
                elseif self.activeCameraController ~= v1 then
                    if v1.HandleSubjectDistance then
                        v1:HandleSubjectDistance(self.activeCameraController)
                    end

                    self.activeCameraController:Enable(false)

                    self.activeCameraController = v1
                    self.activeCameraController:Enable(true)
                elseif not self.activeCameraController:GetEnabled() then
                    self.activeCameraController:Enable(true)
                end

                if self.activeCameraController then
                    self.activeCameraController:SetCameraMovementMode(CameraMovementModeFromSettings)
                    self.activeCameraController:SetCameraType(CameraType)
                end

                return
            end

            v2 = ClassicCamera
        else
            v2 = VRCamera
        end
    end

    if self:ShouldUseVehicleCamera() then
        v2 = if not VRService.VREnabled then VehicleCamera else VRVehicleCamera
    end

    if u144[v2] then
        v1 = u144[v2]

        if not UserPSFixCameraControllerReset then
            if v1.Reset then
                v1:Reset()
            end
        elseif v1.Reset and self.activeCameraController ~= v1 then
            v1:Reset()
        end
    else
        u144[v2] = (v2.new())
    end

    if not self.activeCameraController then
        if v1 ~= nil then
            self.activeCameraController = v1
            assert(self.activeCameraController, "Strict typing check")
            self.activeCameraController:Enable(true)
        end
    elseif self.activeCameraController ~= v1 then
        if v1.HandleSubjectDistance then
            v1:HandleSubjectDistance(self.activeCameraController)
        end

        self.activeCameraController:Enable(false)

        self.activeCameraController = v1
        self.activeCameraController:Enable(true)
    elseif not self.activeCameraController:GetEnabled() then
        self.activeCameraController:Enable(true)
    end

    if self.activeCameraController then
        self.activeCameraController:SetCameraMovementMode(CameraMovementModeFromSettings)
        self.activeCameraController:SetCameraType(CameraType)
    end
end

function u0:OnCameraSubjectChanged() -- Line: 450
    local CurrentCamera = workspace.CurrentCamera
    local CameraSubject = if not CurrentCamera then nil else CurrentCamera.CameraSubject

    if self.activeTransparencyController then
        self.activeTransparencyController:SetSubject(CameraSubject)
    end

    if self.activeOcclusionModule then
        self.activeOcclusionModule:OnCameraSubjectChanged(CameraSubject)
    end

    self:ActivateCameraController()
end

function u0:OnCameraTypeChanged(a2) -- Line: 465; upvalues: UserInputService (val), CameraUtils (val)
    if a2 == Enum.CameraType.Scriptable
        and UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        CameraUtils.restoreMouseBehavior()
    end

    self:ActivateCameraController()
end

function u0:OnCurrentCameraChanged() -- Line: 477
    local CurrentCamera = game.Workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    if self.cameraSubjectChangedConn then
        self.cameraSubjectChangedConn:Disconnect()
    end

    if self.cameraTypeChangedConn then
        self.cameraTypeChangedConn:Disconnect()
    end

    self.cameraSubjectChangedConn = (CurrentCamera:GetPropertyChangedSignal("CameraSubject")):Connect(function()
        -- Line: 489
        -- upvalues: self (val)
        self:OnCameraSubjectChanged()
    end)
    self.cameraTypeChangedConn = (CurrentCamera:GetPropertyChangedSignal("CameraType")):Connect(function()
        -- Line: 493
        -- upvalues: self (val), CurrentCamera (val)
        self:OnCameraTypeChanged(CurrentCamera.CameraType)
    end)

    self:OnCameraSubjectChanged()
    self:OnCameraTypeChanged(CurrentCamera.CameraType)
end

function u0:OnLocalPlayerCameraPropertyChanged(a2)
    -- Line: 501
    -- upvalues: Players (val)
    -- types: self: table, a2: string
    if a2 == "CameraMode" then
        if Players.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
            if Players.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
                self:ActivateCameraController()
                return
            end

            warn("Unhandled value for property player.CameraMode: ", Players.LocalPlayer.CameraMode)

            return
        end

        if not self.activeCameraController
            or self.activeCameraController:GetModuleName() ~= "ClassicCamera" then
            self:ActivateCameraController()
        end

        if not self.activeCameraController then
            return
        end

        self.activeCameraController:UpdateForDistancePropertyChange()

        return
    end

    if a2 ~= "DevComputerCameraMode" and a2 ~= "DevTouchCameraMode" then
        if a2 == "DevCameraOcclusionMode" then
            self:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode)
            return
        end

        if a2 ~= "CameraMinZoomDistance" and a2 ~= "CameraMaxZoomDistance" then
            if a2 == "DevTouchMovementMode" or a2 == "DevComputerMovementMode" then
                return
            end

            return
        end

        if not self.activeCameraController then
            return
        end

        self.activeCameraController:UpdateForDistancePropertyChange()

        return
    end

    self:ActivateCameraController()
end

function u0:OnUserGameSettingsPropertyChanged(a2) -- Line: 543; types: self: table, a2: string
    if a2 == "ComputerCameraMovementMode" then
        self:ActivateCameraController()
    end
end

function u0:OnPreferredInputChanged() -- Line: 549
    self:ActivateCameraController()
end

function u0:Update(a2, a3)
    -- Line: 559
    -- upvalues: UserVRFixCameraCloseArticulation (val), VRService (val), VRFirstPersonState (val)
    -- upvalues: _FFlagUserOrthographicOcclusion (val)
    local v1, v2

    if not self.activeCameraController then
        if UserVRFixCameraCloseArticulation and VRService.VREnabled then
            VRFirstPersonState.inFirstPerson = false
        end

        return
    end

    self.activeCameraController:UpdateMouseBehavior()

    local v3, v4 = self.activeCameraController:Update(a3)

    if UserVRFixCameraCloseArticulation
        and VRService.VREnabled
        and self.activeCameraController.IsInFirstPerson then
        VRFirstPersonState.inFirstPerson = self.activeCameraController:IsInFirstPerson()
    end

    local CurrentCamera = game.Workspace.CurrentCamera

    if not _FFlagUserOrthographicOcclusion then
        if self.activeOcclusionModule and not self.activeCameraController.skipOcclusion then
            v1, v2 = self.activeOcclusionModule:Update(a3, v3, v4)
            v3 = v1
            v4 = v2
        end
    elseif self.activeOcclusionModule
        and not self.activeCameraController.skipOcclusion
        and CurrentCamera.ProjectionType ~= Enum.ProjectionType.Orthographic then
        v1, v2 = self.activeOcclusionModule:Update(a3, v3, v4)
        v3 = v1
        v4 = v2
    end

    CurrentCamera.CFrame = v3
    CurrentCamera.Focus = v4

    if not self.activeTransparencyController then
        return
    end

    self.activeTransparencyController:Update(a3)
end

function u0:OnCharacterAdded(a2, a3) -- Line: 596; types: self: table, a2: userdata, a3: userdata
    if self.activeOcclusionModule then
        self.activeOcclusionModule:CharacterAdded(a2, a3)
    end
end

function u0:OnCharacterRemoving(a2, a3) -- Line: 602
    if self.activeOcclusionModule then
        self.activeOcclusionModule:CharacterRemoving(a2, a3)
    end
end

function u0:OnPlayerAdded(a2)
    -- Line: 608
    -- upvalues: UserPlayerConnectionMemoryLeak (val)
    -- types: self: table, a2: userdata
    if not UserPlayerConnectionMemoryLeak then
        a2.CharacterAdded:Connect(function(a1) -- Line: 620; upvalues: self (val), a2 (val)
            self:OnCharacterAdded(a1, a2)
        end)

        a2.CharacterRemoving:Connect(function(a1) -- Line: 623; upvalues: self (val), a2 (val)
            self:OnCharacterRemoving(a1, a2)
        end)

        return
    end

    if not self.connectionUtil then
        return
    end

    self.connectionUtil:trackConnection(
        ("%*CharacterAdded"):format(a2.UserId),
        (a2.CharacterAdded:Connect(function(a1) -- Line: 612; upvalues: self (val), a2 (val)
            self:OnCharacterAdded(a1, a2)
        end))
    )

    self.connectionUtil:trackConnection(
        ("%*CharacterRemoving"):format(a2.UserId),
        (a2.CharacterRemoving:Connect(function(a1) -- Line: 615; upvalues: self (val), a2 (val)
            self:OnCharacterRemoving(a1, a2)
        end))
    )
end

function u0:OnPlayerRemoving(a2) -- Line: 629; types: self: table, a2: userdata
    if self.connectionUtil then
        self.connectionUtil:disconnect((("%*CharacterAdded"):format(a2.UserId)))
        self.connectionUtil:disconnect((("%*CharacterRemoving"):format(a2.UserId)))
    end
end

function u0:OnMouseLockToggled() -- Line: 637
    if self.activeMouseLockController then
        local IsMouseLocked = self.activeMouseLockController:GetIsMouseLocked()
        local MouseLockOffset = self.activeMouseLockController:GetMouseLockOffset()

        if self.activeCameraController then
            self.activeCameraController:SetIsMouseLocked(IsMouseLocked)
            self.activeCameraController:SetMouseLockOffset(MouseLockOffset)
        end
    end
end

if RunService:IsClient() then
    return u0.new()
end

return u0