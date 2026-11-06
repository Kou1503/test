-- Script path: game:GetService("StarterPlayer").PlayerModule.ControlModule
-- Decompile time: 25.28 ms

local u0 = {}
u0.__index = u0
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local Workspace = game:GetService("Workspace")
local StarterPlayer = game:GetService("StarterPlayer")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local VRService = game:GetService("VRService")
local ContextActionService = game:GetService("ContextActionService")
local CommonUtils = require(script.Parent:WaitForChild("CommonUtils"))
local FlagUtil = CommonUtils.get("FlagUtil")
local UserVRFixCameraCloseArticulation = FlagUtil.getUserFlag("UserVRFixCameraCloseArticulation")
local UserPlayerScriptsCCLIntegrationD = FlagUtil.getUserFlag("UserPlayerScriptsCCLIntegrationD")
local UserPlayerScriptsBindActivateOnIAS = FlagUtil.getUserFlag("UserPlayerScriptsBindActivateOnIAS")
local UserPlayerScriptsPlayerControlState2 = FlagUtil.getUserFlag("UserPlayerScriptsPlayerControlState2")
local UserPlayerScriptsTaskDeferSimulation = FlagUtil.getUserFlag("UserPlayerScriptsTaskDeferSimulation")
local UserPlayerScriptsFixSAuthRenderStepMove = FlagUtil.getUserFlag("UserPlayerScriptsFixSAuthRenderStepMove")
local UserPlayerScriptsSupportMicroGamepad = FlagUtil.getUserFlag("UserPlayerScriptsSupportMicroGamepad")
local UserAbilitiesUserInterfaceC = FlagUtil.getUserFlag("UserAbilitiesUserInterfaceC")
local UserPSUseBindToAnimation = FlagUtil.getUserFlag("UserPSUseBindToAnimation")
local UserServerAuthorityDontSetAutoRotate = FlagUtil.getUserFlag("UserServerAuthorityDontSetAutoRotate")
local ActionController = require(script:WaitForChild("ActionController"))
local InputReplication = if UserPlayerScriptsCCLIntegrationD then
    require(script:WaitForChild("InputReplication"))
else
    if not UserPlayerScriptsPlayerControlState2 then
        nil
    else
        require(script:WaitForChild("InputReplication"))
local InputSlots = if not UserPlayerScriptsCCLIntegrationD then
    nil
else
    require(script:WaitForChild("InputSlots"))
local u128 = nil

if RunService:IsClient() then
    u128 = require(script:WaitForChild("DynamicThumbstick"))
end

local ClassicThumbstick = require(script:WaitForChild("ClassicThumbstick"))
local ClickToMoveController = require(script:WaitForChild("ClickToMoveController"))
local TouchJump = require(script:WaitForChild("TouchJump"))
local TouchAbilities = if not UserPlayerScriptsCCLIntegrationD then
    nil
else
    require(script:WaitForChild("TouchAbilities"))
local VehicleController = require(script:WaitForChild("VehicleController"))
local u177 = nil
local u186 = nil

if UserPlayerScriptsCCLIntegrationD then
    u177 = require(script:WaitForChild("AvatarAbilitiesInterface"))
    u186 = u177.get(Players.LocalPlayer)
end

local u201 = script.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext"):WaitForChild("CameraRotationAction")
local Value = Enum.ContextActionPriority.Medium.Value
local VRFirstPersonState = CommonUtils.get("VRFirstPersonState")
local u213 = {
    [Enum.TouchMovementMode.DPad] = u128,
    [Enum.DevTouchMovementMode.DPad] = u128,
    [Enum.TouchMovementMode.Thumbpad] = u128,
    [Enum.DevTouchMovementMode.Thumbpad] = u128,
    [Enum.TouchMovementMode.Thumbstick] = ClassicThumbstick,
    [Enum.DevTouchMovementMode.Thumbstick] = ClassicThumbstick,
    [Enum.TouchMovementMode.DynamicThumbstick] = u128,
    [Enum.DevTouchMovementMode.DynamicThumbstick] = u128,
    [Enum.TouchMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.DevTouchMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.TouchMovementMode.Default] = u128,
    [Enum.ComputerMovementMode.Default] = ActionController,
    [Enum.ComputerMovementMode.KeyboardMouse] = ActionController,
    [Enum.DevComputerMovementMode.KeyboardMouse] = ActionController,
    [Enum.DevComputerMovementMode.Scriptable] = nil,
    [Enum.ComputerMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.DevComputerMovementMode.ClickToMove] = ClickToMoveController,
}

function u0.new()
    -- Line: 105
    -- upvalues: u0 (val), RunService (val), Players (val), VehicleController (val), UserGameSettings (val)
    -- upvalues: UserPlayerScriptsCCLIntegrationD (val), u186 (ref), GuiService (val), UserInputService (val)
    -- upvalues: UserPlayerScriptsBindActivateOnIAS (val), ContextActionService (val)
    local u3 = setmetatable(
        {},
        u0
    )

    if RunService:IsServer() then
        return u3
    end

    u3.controllers = {}
    u3.activeControlModule = nil
    u3.activeController = nil
    u3.touchJumpController = nil
    u3.touchAbilitiesController = nil
    u3.moveFunction = Players.LocalPlayer.Move
    u3.humanoid = nil
    u3.controlsEnabled = true
    u3.enabled = false
    u3.humanoidSeatedConn = nil
    u3.vehicleController = nil
    u3.touchControlFrame = nil
    u3.currentTorsoAngle = 0
    u3.inputMoveVector = Vector3.new(0, 0, 0)
    u3.renderedRotationOverride = nil
    u3.vehicleController = VehicleController.new()

    Players.LocalPlayer.CharacterAdded:Connect(function(a1) -- Line: 138; upvalues: u3 (val)
        u3:OnCharacterAdded(a1)
    end)

    Players.LocalPlayer.CharacterRemoving:Connect(function(a1) -- Line: 139; upvalues: u3 (val)
        u3:OnCharacterRemoving(a1)
    end)

    if Players.LocalPlayer.Character then
        u3:OnCharacterAdded(Players.LocalPlayer.Character)
    end

    ;(UserGameSettings:GetPropertyChangedSignal("TouchMovementMode")):Connect(function()
        -- Line: 144
        -- upvalues: u3 (val)
        u3:UpdateMovementMode()
    end)

    ;(Players.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode")):Connect(function()
        -- Line: 147
        -- upvalues: u3 (val)
        u3:UpdateMovementMode()
    end)

    ;(UserGameSettings:GetPropertyChangedSignal("ComputerMovementMode")):Connect(function()
        -- Line: 151
        -- upvalues: u3 (val)
        u3:UpdateMovementMode()
    end)

    ;(Players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode")):Connect(function()
        -- Line: 154
        -- upvalues: u3 (val)
        u3:UpdateMovementMode()
    end)

    if UserPlayerScriptsCCLIntegrationD then
        (u186:GetEnabledChangedSignal()):Connect(function() -- Line: 158; upvalues: u3 (val)
            u3:UpdateAbilitiesControllers()
        end)
    end

    u3.playerGui = nil
    u3.touchGui = nil
    u3.playerGuiAddedConn = nil

    ;(GuiService:GetPropertyChangedSignal("TouchControlsEnabled")):Connect(function() -- Line: 168; upvalues: u3 (val)
        u3:UpdateMovementMode()
        u3:UpdateActiveControlModuleEnabled()
    end)

    ;(UserInputService:GetPropertyChangedSignal("PreferredInput")):Connect(function() -- Line: 173; upvalues: u3 (val)
        u3:UpdateMovementMode()
    end)

    u3.playerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")

    if not u3.playerGui then
        u3.playerGuiAddedConn = Players.LocalPlayer.ChildAdded:Connect(function(a1) -- Line: 179; upvalues: u3 (val)
            if a1:IsA("PlayerGui") then
                u3.playerGui = a1
                u3.playerGuiAddedConn:Disconnect()

                u3.playerGuiAddedConn = nil
                u3:UpdateMovementMode()
            end
        end)
    end

    if UserPlayerScriptsBindActivateOnIAS then
        ContextActionService:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)
    end

    return u3
end

local function _fireCustomInputs(a1) -- Line: 197; upvalues: UserGameSettings (val); types: a1: userdata
    local InputContexts = a1:FindFirstChild("InputContexts")

    if InputContexts == nil then
        return
    end

    local CharacterContext = InputContexts:FindFirstChild("CharacterContext")

    if CharacterContext == nil then
        return
    end

    local v1 = CharacterContext:FindFirstChild("RotationAction")

    if v1 then
        local RotationScriptableBinding = v1:FindFirstChild("RotationScriptableBinding")

        if RotationScriptableBinding then
            RotationScriptableBinding:Fire(UserGameSettings.RotationType == Enum.RotationType.CameraRelative)
        end
    end
end

function u0:restoreSimulatedRotation() -- Line: 217
    local renderedRotationOverride = self.renderedRotationOverride

    if renderedRotationOverride == nil then
        return
    end

    if renderedRotationOverride.rootPart.Parent ~= nil then
        renderedRotationOverride.rootPart.CFrame = (CFrame.new(renderedRotationOverride.rootPart.CFrame.Position))
            * renderedRotationOverride.simulatedRotation
    end

    self.renderedRotationOverride = nil
end

function u0:applyRenderedRotation() -- Line: 228; upvalues: Workspace (val)
    local CurrentCamera = Workspace.CurrentCamera
    local humanoid = self.humanoid
    local RootPart = humanoid and humanoid.RootPart

    if CurrentCamera ~= nil
        and RootPart ~= nil
        and not humanoid.Sit
        and humanoid.SeatPart == nil
        and not RootPart:IsGrounded()
        and (humanoid:GetState()) ~= Enum.HumanoidStateType.Swimming then
        local LookVector = CurrentCamera.CFrame.LookVector
        local v1 = Vector3.new(LookVector.X, 0, LookVector.Z)

        if v1.Magnitude < 0.001 then
            return
        end

        if self.renderedRotationOverride ~= nil
            and self.renderedRotationOverride.rootPart ~= RootPart then
            self:restoreSimulatedRotation()
        end

        if self.renderedRotationOverride == nil then
            self.renderedRotationOverride = {rootPart = RootPart, simulatedRotation = RootPart.CFrame.Rotation}
        end

        local Position = RootPart.CFrame.Position
        RootPart.CFrame = CFrame.lookAt(Position, Position + v1)
    end
end

local function _cloneInputs(a1) -- Line: 254; upvalues: StarterPlayer (val); types: a1: userdata
    local v1 = StarterPlayer.PlayerModule.InputContexts:Clone()
    v1.CharacterContext.Enabled = true
    v1.CameraContext.Enabled = true
    v1.Parent = a1
end

function u0.InitializeServerAuthority(a1)
    -- Line: 261
    -- upvalues: RunService (val), UserPlayerScriptsCCLIntegrationD (val), Players (val), InputReplication (val)
    -- upvalues: StarterPlayer (val), _cloneInputs (val), UserPlayerScriptsPlayerControlState2 (val)
    -- upvalues: UserPlayerScriptsTaskDeferSimulation (val), u177 (ref), UserPSUseBindToAnimation (val)
    -- upvalues: UserServerAuthorityDontSetAutoRotate (val), _fireCustomInputs (val), UserGameSettings (val), u186 (ref)
    if not RunService:IsServer() then
        if UserPlayerScriptsPlayerControlState2 then
            InputReplication.watchForPlayerControlState(Players.LocalPlayer)
        end

        if UserServerAuthorityDontSetAutoRotate then
            RunService.PreAnimation:Connect(function() -- Line: 310; upvalues: a1 (val)
                a1:restoreSimulatedRotation()
            end)
        end

        RunService:BindToRenderStep(
            "CameraInput",
            Enum.RenderPriority.Last.Value,
            function()
                -- Line: 316
                -- upvalues: UserPlayerScriptsPlayerControlState2 (upval), InputReplication (upval), Players (upval)
                -- upvalues: a1 (val), UserPlayerScriptsCCLIntegrationD (upval), _fireCustomInputs (upval)
                -- upvalues: UserServerAuthorityDontSetAutoRotate (upval), UserGameSettings (upval), u186 (upval)
                if UserPlayerScriptsPlayerControlState2 then
                    InputReplication.writeInputToPCS(Players.LocalPlayer, a1)
                elseif not UserPlayerScriptsCCLIntegrationD then
                    _fireCustomInputs(Players.LocalPlayer)
                else
                    InputReplication.FireCustomInputs(Players.LocalPlayer)
                end

                if UserServerAuthorityDontSetAutoRotate
                    and UserGameSettings.RotationType == Enum.RotationType.CameraRelative then
                    if not UserPlayerScriptsCCLIntegrationD or not u186:isEnabled() then
                        a1:applyRenderedRotation()
                    end
                end
            end
        )

        if not UserPSUseBindToAnimation then
            local Hz60_4 = Enum.StepFrequency.Hz60
            RunService:BindToSimulation(
                function(a1_2) -- Line: 335; upvalues: a1 (val), Players (upval)
                    a1:ProcessInputs(Players.LocalPlayer, a1_2)
                end,
                Hz60_4
            )
        else
            local Hz60_3 = Enum.StepFrequency.Hz60
            RunService:BindToAnimation(
                function(a1_2) -- Line: 331; upvalues: a1 (val), Players (upval)
                    a1:ProcessInputs(Players.LocalPlayer, a1_2)
                end,
                Hz60_3
            )
        end
    else
        if not UserPlayerScriptsCCLIntegrationD then
            local v1

            for i, j in Players:GetPlayers() do
                v1 = StarterPlayer.PlayerModule.InputContexts:Clone()
                v1.CharacterContext.Enabled = true
                v1.CameraContext.Enabled = true
                v1.Parent = j
            end

            Players.PlayerAdded:Connect(_cloneInputs)
        else
            for k, n in Players:GetPlayers() do
                InputReplication.CloneInputsIfAbsent(n)
            end

            Players.PlayerAdded:Connect(InputReplication.CloneInputsIfAbsent)
        end

        if UserPlayerScriptsPlayerControlState2 then
            for m, i5 in Players:GetPlayers() do
                InputReplication.createPlayerControlState(i5)
            end

            Players.PlayerAdded:Connect(InputReplication.createPlayerControlState)
        end

        if UserPlayerScriptsCCLIntegrationD and UserPlayerScriptsTaskDeferSimulation then
            for i6, i7 in Players:GetPlayers() do
                u177.get(i7)
            end

            Players.PlayerAdded:Connect(function(a1) -- Line: 286; upvalues: u177 (upval)
                u177.get(a1)
            end)
        end

        if not UserPSUseBindToAnimation then
            local Hz60_2 = Enum.StepFrequency.Hz60
            RunService:BindToSimulation(
                function(a1_2) -- Line: 298; upvalues: Players (upval), a1 (val)
                    for i, j in Players:GetPlayers() do
                        a1:ProcessInputs(j, a1_2)
                    end
                end,
                Hz60_2
            )
        else
            local Hz60 = Enum.StepFrequency.Hz60
            RunService:BindToAnimation(
                function(a1_2) -- Line: 292; upvalues: Players (upval), a1 (val)
                    for i, j in Players:GetPlayers() do
                        a1:ProcessInputs(j, a1_2)
                    end
                end,
                Hz60
            )
        end
    end

    if a1.data and a1.data.eventBus then
        a1.data.isServerAuthority = true
        a1.data.eventBus:publish("SERVER_AUTHORITY_CHANGED", true)
    end
end

local function NormalizeAngle(a1) -- Line: 348
    local v1 = (a1 + 12.566370614359172) % 6.283185307179586

    if v1 > 3.141592653589793 then
        v1 = v1 - 6.283185307179586
    end

    return v1
end

local function AverageAngle(a1, a2) -- Line: 356
    local v1 = (a2 - a1 + 12.566370614359172) % 6.283185307179586

    if v1 > 3.141592653589793 then
        v1 = v1 - 6.283185307179586
    end

    local v2 = (a1 + v1 / 2 + 12.566370614359172) % 6.283185307179586

    if v2 > 3.141592653589793 then
        v2 = v2 - 6.283185307179586
    end

    return v2
end

function u0:GetEstimatedVRTorsoFrame() -- Line: 361; upvalues: VRService (val)
    local v1
    local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head)
    _, v1 = UserCFrame:ToEulerAnglesYXZ()
    v1 = -v1

    if not VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) then
        self.currentTorsoAngle = v1
    elseif VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
        local UserCFrame_2 = VRService:GetUserCFrame(Enum.UserCFrame.LeftHand)
        local v2 = VRService:GetUserCFrame(Enum.UserCFrame.RightHand)
        local v3 = UserCFrame.Position - UserCFrame_2.Position
        local v4 = UserCFrame.Position - v2.Position
        v2 = -math.atan2(v3.X, v3.Z)
        local v5 = (-math.atan2(v4.X, v4.Z) - v2 + 12.566370614359172)
            % 6.283185307179586

        if v5 > 3.141592653589793 then
            v5 = v5 - 6.283185307179586
        end

        v4 = (v2 + v5 / 2 + 12.566370614359172) % 6.283185307179586

        if v4 > 3.141592653589793 then
            v4 = v4 - 6.283185307179586
        end

        v3 = (v1 - self.currentTorsoAngle + 12.566370614359172) % 6.283185307179586

        if v3 > 3.141592653589793 then
            v3 = v3 - 6.283185307179586
        end

        v2 = (v4 - self.currentTorsoAngle + 12.566370614359172) % 6.283185307179586

        if v2 > 3.141592653589793 then
            v2 = v2 - 6.283185307179586
        end

        v4 = false

        if v2 > -1.5707963267948966 then
            v4 = v2 < 1.5707963267948966
        end

        if not v4 then
            v2 = v3
        end

        v4 = math.min(v2, v3)
        v5 = math.max(v2, v3)
        v3 = 0

        if v4 > 0 then
            v3 = v4
        elseif v5 < 0 then
            v3 = v5
        end

        self.currentTorsoAngle = v3 + self.currentTorsoAngle
    else
        self.currentTorsoAngle = v1
    end

    return (CFrame.new(UserCFrame.Position))
        * CFrame.fromEulerAnglesYXZ(0, -self.currentTorsoAngle, 0)
end

function u0.GetActiveController(a1) -- Line: 405
    return a1.activeController
end

function u0:UpdateAbilitiesControllers()
    -- Line: 409
    -- upvalues: UserInputService (val), ClickToMoveController (val), ClassicThumbstick (val), u128 (ref), u186 (ref)
    -- upvalues: TouchJump (val), TouchAbilities (val)
    local enabled = self.enabled

    if enabled then
        enabled = self.touchControlFrame

        if enabled then
            enabled = false

            if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
                enabled = true

                if self.activeControlModule ~= ClickToMoveController then
                    enabled = true

                    if self.activeControlModule ~= ClassicThumbstick then
                        enabled = self.activeControlModule == u128
                    end
                end
            end
        end
    end

    local v1 = enabled and not u186:isEnabled()
    local v2 = enabled and u186:isEnabled()

    if v1 then
        if not self.controllers[TouchJump] then
            self.controllers[TouchJump] = (TouchJump.new(self.data))
        end

        self.touchJumpController = self.controllers[TouchJump]
        self.touchJumpController:Enable(true, self.touchControlFrame)
    elseif self.touchJumpController then
        self.touchJumpController:Enable(false)
    end

    if not v2 then
        if self.touchAbilitiesController then
            self.touchAbilitiesController:Enable(false)
        end

        return
    end

    if not self.controllers[TouchAbilities] then
        self.controllers[TouchAbilities] = (TouchAbilities.new(self.touchControlFrame))
    end

    self.touchAbilitiesController = self.controllers[TouchAbilities]
    self.touchAbilitiesController:Enable(true)
end

function u0:UpdateActiveControlModuleEnabled()
    -- Line: 445
    -- upvalues: UserPlayerScriptsCCLIntegrationD (val), u186 (ref), Players (val), UserInputService (val)
    -- upvalues: ClickToMoveController (val), ClassicThumbstick (val), u128 (ref), TouchJump (val), GuiService (val)
    local function v1()
        -- Line: 447
        -- upvalues: UserPlayerScriptsCCLIntegrationD (upval), self (val), u186 (upval), Players (upval)
        if UserPlayerScriptsCCLIntegrationD then
            self.enabled = false
        end

        self.activeController:Enable(false)

        if UserPlayerScriptsCCLIntegrationD then
            self:UpdateAbilitiesControllers()
        elseif self.touchJumpController then
            self.touchJumpController:Enable(false)
        end

        if self.moveFunction then
            if not UserPlayerScriptsCCLIntegrationD or not u186:isEnabled() then
                self.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true)
            end
        end
    end

    local function v2()
        -- Line: 467
        -- upvalues: UserPlayerScriptsCCLIntegrationD (upval), self (val), UserInputService (upval)
        -- upvalues: ClickToMoveController (upval), ClassicThumbstick (upval), u128 (upval), TouchJump (upval)
        -- upvalues: Players (upval)
        if UserPlayerScriptsCCLIntegrationD then
            self.enabled = true
            self:UpdateAbilitiesControllers()
        elseif not self.touchControlFrame
            or UserInputService.PreferredInput ~= Enum.PreferredInput.Touch then
            if self.touchJumpController then
                self.touchJumpController:Enable(false)
            end
        elseif self.activeControlModule == ClickToMoveController
            or self.activeControlModule == ClassicThumbstick
            or self.activeControlModule == u128 then
            if not self.controllers[TouchJump] then
                self.controllers[TouchJump] = (TouchJump.new(self.data))
            end

            self.touchJumpController = self.controllers[TouchJump]
            self.touchJumpController:Enable(true, self.touchControlFrame)
        elseif self.touchJumpController then
            self.touchJumpController:Enable(false)
        end

        if self.activeControlModule == ClickToMoveController then
            self.activeController:Enable(true, Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, self.touchJumpController)
            return
        end

        if self.touchControlFrame then
            self.activeController:Enable(true, self.touchControlFrame)
            return
        end

        self.activeController:Enable(true)
    end

    if not self.activeController then
        return
    end

    if not self.controlsEnabled then
        v1()
        return
    end

    if not GuiService.TouchControlsEnabled
        and UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        if self.activeControlModule ~= ClickToMoveController
            and self.activeControlModule ~= ClassicThumbstick
            and self.activeControlModule ~= u128 then
            v2()
            return
        end

        v1()

        return
    end

    v2()
end

function u0:Enable(a2) -- Line: 532; types: self: table, a2: boolean?
    if a2 == nil then
        a2 = true
    end

    if self.controlsEnabled == a2 then
        return
    end

    self.controlsEnabled = a2

    if not self.activeController then
        return
    end

    self:UpdateActiveControlModuleEnabled()
end

function u0.Disable(a1) -- Line: 547
    a1:Enable(false)
end

function u0.SelectComputerMovementModule(a1)
    -- Line: 553
    -- upvalues: UserPlayerScriptsSupportMicroGamepad (val), UserInputService (val), ActionController (val)
    -- upvalues: Players (val), UserGameSettings (val), ClickToMoveController (val), u213 (val)
    local u1 = false

    if UserPlayerScriptsSupportMicroGamepad then
        pcall(function() -- Line: 556; upvalues: u1 (ref), UserInputService (upval)
            u1 = UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad
        end)
    end

    if UserInputService.PreferredInput ~= Enum.PreferredInput.KeyboardAndMouse
        and UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad
        and not u1 then
        return nil, false
    end

    local v1 = ActionController
    local DevComputerMovementMode = Players.LocalPlayer.DevComputerMovementMode

    if DevComputerMovementMode ~= Enum.DevComputerMovementMode.UserChoice then
        v1 = u213[DevComputerMovementMode]

        if not v1 and DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable then
            warn("No character control module is associated with DevComputerMovementMode ", DevComputerMovementMode)
        end
    elseif UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
        v1 = ClickToMoveController
    end

    if v1 then
        return v1, true
    end

    if DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
        return nil, true
    end

    return nil, false
end

function u0.SelectTouchModule(a1) -- Line: 597; upvalues: Players (val), u213 (val), UserGameSettings (val)
    local v1
    local DevTouchMovementMode = Players.LocalPlayer.DevTouchMovementMode

    if DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        v1 = u213[UserGameSettings.TouchMovementMode]
        return v1, true
    end

    if DevTouchMovementMode == Enum.DevTouchMovementMode.Scriptable then
        return nil, true
    end

    v1 = u213[DevTouchMovementMode]

    return v1, true
end

function u0:calculateRawMoveVector(a2, a3)
    -- Line: 610
    -- upvalues: Workspace (val), VRService (val), u201 (val)
    -- types: self: table, a2: userdata, a3: vector
    local v1, v2
    local CurrentCamera = Workspace.CurrentCamera

    if not CurrentCamera then
        return a3
    end

    local CFrame_2 = CurrentCamera.CFrame

    if VRService.VREnabled and a2.RootPart then
        local EstimatedVRTorsoFrame = self:GetEstimatedVRTorsoFrame()
        CFrame_2 = if not ((CurrentCamera.Focus.Position - CFrame_2.Position).Magnitude
            < 3) then
            CurrentCamera.CFrame
                * (EstimatedVRTorsoFrame.Rotation
                    + EstimatedVRTorsoFrame.Position * CurrentCamera.HeadScale)
        else
            CFrame_2 * EstimatedVRTorsoFrame
    end

    if (a2:GetState()) ~= Enum.HumanoidStateType.Swimming then
        local Components_10, Components_11, Components_12, Components_3, Components_9, v3
        _, _, _, Components_9, Components_10, Components_11, _, _, Components_3, _, _, Components_12 = CFrame_2:GetComponents()

        if not (Components_3 < 1) or not (Components_3 > -1) then
            v1 = Components_9
            v3 = -Components_10 * math.sign(Components_3)
        else
            v1 = Components_12
            v3 = Components_11
        end

        local v4 = math.sqrt(v1 * v1 + v3 * v3)

        return (Vector3.new((v1 * a3.X + v3 * a3.Z) / v4, 0, (v1 * a3.Z - v3 * a3.X) / v4))
    end

    if not VRService.VREnabled then
        return CFrame_2:VectorToWorldSpace(a3)
    end

    local v5 = Vector3.new(a3.X, 0, a3.Z)

    if v5.Magnitude < 0.01 then
        return (Vector3.new(0, 0, 0))
    end

    local v6 = 0

    if u201 and u201.Enabled then
        v6 = -u201:GetState().Y / 2.31
    end

    v1 = math.atan2(-v5.X, -v5.Z)
    _, v2 = CFrame_2:ToEulerAnglesYXZ()
    v1 = v1 + v2

    return CFrame.fromEulerAnglesYXZ(v6, v1, 0).LookVector
end

function u0.initialize(a1, a2)
    -- Line: 671
    -- upvalues: ActionController (val), UserPlayerScriptsCCLIntegrationD (val), InputSlots (val)
    a1.data = a2
    a1:UpdateMovementMode()
    ActionController.initializeActions(a1.data)

    if UserPlayerScriptsCCLIntegrationD then
        InputSlots.setupSlotActions(a1.data.player, a1.data.isServerAuthority)
    end
end

function u0:Update(a2, a3) -- Line: 682; upvalues: ActionController (val), VRService (val)
    assert(a2.player)
    assert(a2.character)

    if not self.humanoid then
        return
    end

    local controlModule = a2.controlModule

    if not a2.playerModule.ControlModule.Enabled then
        controlModule.isJumping = false
        controlModule.moveVector = Vector2.new()
        controlModule.worldMoveVector = Vector3.new()

        ActionController.update(a2)

        self.inputMoveVector = Vector3.new()

        if self.vehicleController then
            self.vehicleController:Update(Vector3.new(), true)
        end

        self:characterMove(a2)

        return
    end

    ActionController.initializeActions(a2)

    if self.activeController and self.activeController.enabled and self.humanoid then
        ActionController.update(a2)
        self:GetClickToMoveController():Update(a2, a3)

        local v1 = Vector3.new(a2.controlModule.moveVector.X, 0, -a2.controlModule.moveVector.Y)

        if self.vehicleController then
            local v2, v3 = self.vehicleController:Update(v1, true)
            _ = v3
            v1 = v2
        end

        v1 = self:calculateRawMoveVector(self.humanoid, v1)
        self.inputMoveVector = v1

        if VRService.VREnabled then
            v1 = self:updateVRMoveVector(v1)
        end

        controlModule.worldMoveVector = v1
        self:characterMove(a2)
    end
end

function u0:characterMove(a2)
    -- Line: 737
    -- upvalues: UserPlayerScriptsPlayerControlState2 (val), UserPlayerScriptsCCLIntegrationD (val), u186 (ref)
    -- upvalues: InputReplication (val), Players (val), UserPlayerScriptsFixSAuthRenderStepMove (val)
    local controlModule = a2.controlModule

    if UserPlayerScriptsPlayerControlState2 then
        if a2.isServerAuthority then
            return
        end

        if UserPlayerScriptsCCLIntegrationD and u186:isEnabled() then
            InputReplication.writeInputToPCS(Players.LocalPlayer, self)
            return
        end

        self.moveFunction(Players.LocalPlayer, controlModule.worldMoveVector, false)

        self.humanoid.Jump = controlModule.isJumping

        return
    end

    if not UserPlayerScriptsFixSAuthRenderStepMove or not a2.isServerAuthority then
        if not UserPlayerScriptsCCLIntegrationD or not u186:isEnabled() then
            self.moveFunction(Players.LocalPlayer, controlModule.worldMoveVector, false)

            self.humanoid.Jump = controlModule.isJumping
        end
    end
end

function u0:updateVRMoveVector(a2)
    -- Line: 759
    -- upvalues: UserVRFixCameraCloseArticulation (val), VRFirstPersonState (val), VRService (val)
    local inFirstPerson, v1
    local CurrentCamera = workspace.CurrentCamera
    local v2 = CurrentCamera.Focus.Position - CurrentCamera.CFrame.Position

    if not UserVRFixCameraCloseArticulation then
        v1 = false

        if v2.Magnitude < 5 then
            v1 = true
        end

        inFirstPerson = v1
    else
        inFirstPerson = VRFirstPersonState.inFirstPerson
    end

    if a2.Magnitude == 0
        and inFirstPerson
        and VRService.AvatarGestures
        and self.humanoid
        and not self.humanoid.Sit then
        v2 = VRService:GetUserCFrame(Enum.UserCFrame.Head)
        v2 = v2.Rotation + v2.Position * CurrentCamera.HeadScale
        v1 = -0.7 * self.humanoid.RootPart.Size.Y / 2
        v1 = (CurrentCamera.CFrame * v2 * CFrame.new(0, v1, 0)).Position
            - self.humanoid.RootPart.CFrame.Position
        local v3 = Vector3.new(v1.x, 0, v1.z)

        if UserVRFixCameraCloseArticulation then
            local Magnitude = (CurrentCamera.Focus.Position - CurrentCamera.CFrame.Position).Magnitude

            if math.max(4 * CurrentCamera.HeadScale, 1) < Magnitude then
                return a2
            end
        end

        return v3
    end

    return a2
end

function u0:OnHumanoidSeated(a2, a3) -- Line: 800; types: self: table, a2: boolean, a3: userdata
    if not a2 then
        if self.vehicleController then
            self.vehicleController:Enable(false, a3)
        end

        return
    end

    if a3 and a3:IsA("VehicleSeat") then
        if not self.vehicleController then
            self.vehicleController = self.vehicleController.new()
        end

        self.vehicleController:Enable(true, a3)
    end
end

function u0:OnCharacterAdded(a2) -- Line: 815
    self.humanoid = a2:FindFirstChildOfClass("Humanoid")

    while not self.humanoid do
        a2.ChildAdded:wait()

        self.humanoid = a2:FindFirstChildOfClass("Humanoid")
    end

    if self.humanoidSeatedConn then
        self.humanoidSeatedConn:Disconnect()

        self.humanoidSeatedConn = nil
    end

    self.humanoidSeatedConn = self.humanoid.Seated:Connect(function(a1, a2) -- Line: 826; upvalues: self (val)
        self:OnHumanoidSeated(a1, a2)
    end)
    self:UpdateMovementMode()
end

function u0:OnCharacterRemoving(a2) -- Line: 833
    self.humanoid = nil
    self:UpdateMovementMode()
end

function u0:UpdateTouchGuiVisibility() -- Line: 839; upvalues: GuiService (val), UserInputService (val)
    local humanoid = self.humanoid
        and GuiService.TouchControlsEnabled
            and UserInputService.PreferredInput == Enum.PreferredInput.Touch

    if humanoid and not self.touchGui then
        self:CreateTouchGuiContainer()
    end

    if self.touchGui then
        self.touchGui.Enabled = not not humanoid
    end
end

function u0:SwitchToController(a2) -- Line: 858
    if not a2 then
        if self.activeController then
            self.activeController:Enable(false)
        end

        self.activeController = nil
        self.activeControlModule = nil

        return
    end

    if not self.controllers[a2] then
        self.controllers[a2] = (a2.new(self.data))
    end

    if self.activeController ~= self.controllers[a2] then
        if self.activeController then
            self.activeController:Enable(false)
        end

        self.activeController = self.controllers[a2]
        self.activeControlModule = a2

        self:UpdateActiveControlModuleEnabled()
    end
end

function u0:UpdateMovementMode() -- Line: 897; upvalues: UserInputService (val)
    self:UpdateTouchGuiVisibility()

    if UserInputService.PreferredInput ~= Enum.PreferredInput.Touch then
        self:SwitchToController((self:SelectComputerMovementModule()))
        return
    end

    local v1, v2 = self:SelectTouchModule()

    if v2 and self.touchControlFrame then
        self:SwitchToController(v1)
    end
end

function u0:CreateTouchGuiContainer()
    -- Line: 913
    -- upvalues: UserPlayerScriptsCCLIntegrationD (val), UserAbilitiesUserInterfaceC (val)
    if not self.playerGui then
        return
    end

    if self.touchGui then
        self.touchGui:Destroy()
    end

    self.touchGui = Instance.new("ScreenGui")
    self.touchGui.Name = "TouchGui"
    self.touchGui.ResetOnSpawn = false
    self.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    if UserPlayerScriptsCCLIntegrationD and UserAbilitiesUserInterfaceC then
        self.touchGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    end

    self.touchGui.ClipToDeviceSafeArea = false
    self.touchControlFrame = Instance.new("Frame")
    self.touchControlFrame.Name = "TouchControlFrame"
    self.touchControlFrame.Size = UDim2.new(1, 0, 1, 0)
    self.touchControlFrame.BackgroundTransparency = 1
    self.touchControlFrame.Parent = self.touchGui
    self.touchGui.Parent = self.playerGui
end

function u0:GetClickToMoveController() -- Line: 940; upvalues: ClickToMoveController (val)
    if not self.controllers[ClickToMoveController] then
        self.controllers[ClickToMoveController] = (ClickToMoveController.new())
    end

    return self.controllers[ClickToMoveController]
end

function u0.ProcessInputs(a1, a2, a3)
    -- Line: 947
    -- upvalues: UserPlayerScriptsCCLIntegrationD (val), u177 (ref), UserPlayerScriptsPlayerControlState2 (val)
    -- upvalues: InputReplication (val)
    -- types: a1: table, a2: userdata, a3: number
    if UserPlayerScriptsCCLIntegrationD then
        if u177.get(a2):isEnabled() then
            return
        end

        if UserPlayerScriptsPlayerControlState2 then
            InputReplication.processPCSInputs(a2)
            return
        end

        InputReplication.SendInputToHumanoidForServerAuth(a2)

        return
    end

    if UserPlayerScriptsPlayerControlState2 then
        InputReplication.processPCSInputs(a2)
        return
    end

    local Character = a2.Character

    if Character == nil then
        return
    end

    local Humanoid = Character:FindFirstChild("Humanoid")

    if Humanoid == nil then
        return
    end

    local v1 = a2:FindFirstChild("InputContexts")

    if v1 == nil then
        return
    end

    local CharacterContext = v1:FindFirstChild("CharacterContext")

    if CharacterContext == nil then
        return
    end

    local MoveAction = CharacterContext.MoveAction
    local RotationAction = CharacterContext.RotationAction
    local JumpAction = CharacterContext.JumpAction

    local function isValidInput2D(a1) -- Line: 983; types: a1: userdata
        local v1 = true

        if a1.X == a1.X then
            v1 = true

            if a1.Y == a1.Y then
                v1 = true

                if a1.X ~= (1 / 0) then
                    v1 = a1.Y == (1 / 0)
                end
            end
        end

        return not v1
    end

    local function isValidInput3D(a1) -- Line: 991; types: a1: vector
        local v1 = true

        if a1.X == a1.X then
            v1 = true

            if a1.Y == a1.Y then
                v1 = true

                if a1.Z == a1.Z then
                    v1 = true

                    if a1.X ~= (1 / 0) then
                        v1 = true

                        if a1.Y ~= (1 / 0) then
                            v1 = a1.Z == (1 / 0)
                        end
                    end
                end
            end
        end

        return not v1
    end

    local State = if MoveAction == nil then Vector2.new(0, 0) else MoveAction:GetState()
    local LookVector = a2:GetCameraState().CFrame.LookVector
    local v2 = true

    if State.X == State.X then
        v2 = true

        if State.Y == State.Y then
            v2 = true

            if State.X ~= (1 / 0) then
                v2 = State.Y == (1 / 0)
            end
        end
    end

    if not v2 then
        local v3 = true

        if LookVector.X == LookVector.X then
            v3 = true

            if LookVector.Y == LookVector.Y then
                v3 = true

                if LookVector.Z == LookVector.Z then
                    v3 = true

                    if LookVector.X ~= (1 / 0) then
                        v3 = true

                        if LookVector.Y ~= (1 / 0) then
                            v3 = LookVector.Z == (1 / 0)
                        end
                    end
                end
            end
        end

        if not v3 and 0 < LookVector.Magnitude then
            if (Humanoid:GetState()) ~= Enum.HumanoidStateType.Swimming then
                LookVector = Vector3.new(LookVector.X, 0, LookVector.Z).Unit
            end

            local Unit = (LookVector:Cross((Vector3.new(0, 1, 0)))).Unit
            Humanoid:Move(LookVector * State.Y + Unit * State.X)

            if not RotationAction:GetState() then
                Humanoid.AutoRotate = true
            else
                Humanoid.AutoRotate = false

                if Humanoid.SeatPart == nil
                    and Humanoid.RootPart ~= nil
                    and not Humanoid.Sit
                    and not Humanoid.RootPart:IsGrounded() then
                    Humanoid.RootPart.CFrame = CFrame.new(Humanoid.RootPart.CFrame.Position, Humanoid.RootPart.CFrame.Position + LookVector)
                end
            end
        end
    end

    Humanoid.Jump = if JumpAction == nil then false else JumpAction:GetState()
end

if RunService:IsClient() then
    return (u0.new())
end

return u0