-- Script path: game:GetService("StarterPlayer").PlayerModule.ControlModule.InputReplication
-- Decompile time: 6.66 ms

local FlagUtil = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local u15 = FlagUtil.getUserFlag("UserPlayerScriptsCCLIntegrationD")
local StarterPlayer = game:GetService("StarterPlayer")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local Workspace = game:GetService("Workspace")
local AvatarAbilitiesInterface = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"))
local UserAbilitiesUserInterfaceB = FlagUtil.getUserFlag("UserAbilitiesUserInterfaceB")
local u44 = if not UserAbilitiesUserInterfaceB then "PlayerControlState" else "ControlState"
local u45 = {}
u45.__index = u45

function u45._calculatePlayerInputValues(a1) -- Line: 14; types: a1: userdata
    local Character = a1.Character

    if Character == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
    end

    local Humanoid = Character:FindFirstChild("Humanoid")

    if Humanoid == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
    end

    local v1 = a1:FindFirstChild("InputContexts")

    if v1 == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
    end

    local CharacterContext = v1:FindFirstChild("CharacterContext")

    if CharacterContext == nil then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
    end

    local MoveAction = CharacterContext.MoveAction
    local RotationAction = CharacterContext:FindFirstChild("RotationAction")
    local v2 = false

    if RotationAction ~= nil then
        v2 = RotationAction:GetState()
    end

    local function isValidInput2D(a1) -- Line: 35; types: a1: userdata
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

    local function isValidInput3D(a1) -- Line: 43; types: a1: vector
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
    local LookVector = a1:GetCameraState().CFrame.LookVector
    local v3 = true

    if State.X == State.X then
        v3 = true

        if State.Y == State.Y then
            v3 = true

            if State.X ~= (1 / 0) then
                v3 = State.Y == (1 / 0)
            end
        end
    end

    if not v3 then
        local v4 = true

        if LookVector.X == LookVector.X then
            v4 = true

            if LookVector.Y == LookVector.Y then
                v4 = true

                if LookVector.Z == LookVector.Z then
                    v4 = true

                    if LookVector.X ~= (1 / 0) then
                        v4 = true

                        if LookVector.Y ~= (1 / 0) then
                            v4 = LookVector.Z == (1 / 0)
                        end
                    end
                end
            end
        end

        if not v4 and 0 < LookVector.Magnitude then
            if Humanoid and (Humanoid:GetState()) ~= Enum.HumanoidStateType.Swimming then
                LookVector = Vector3.new(LookVector.X, 0, LookVector.Z).Unit
            end

            local Unit = (LookVector:Cross((Vector3.new(0, 1, 0)))).Unit

            return LookVector * State.Y + Unit * State.X, LookVector, v2
        end
    end

    return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), false
end

function u45.CloneInputsIfAbsent(a1) -- Line: 73; upvalues: StarterPlayer (val); types: a1: userdata
    if a1:FindFirstChild("InputContexts") then
        return
    end

    local v1 = StarterPlayer.PlayerModule.InputContexts:Clone()
    v1.CharacterContext.Enabled = true
    v1.CameraContext.Enabled = true
    v1.Parent = a1
end

function u45.FireCustomInputs(a1) -- Line: 82; upvalues: UserGameSettings (val); types: a1: userdata
    local InputContexts = a1:FindFirstChild("InputContexts")

    if not InputContexts then
        return
    end

    local CharacterContext = InputContexts:FindFirstChild("CharacterContext")

    if not CharacterContext or not InputContexts:FindFirstChild("CameraContext") then
        return
    end

    local RotationAction = CharacterContext:FindFirstChild("RotationAction")

    if RotationAction then
        local v1 = RotationAction:FindFirstChild("RotationScriptableBinding")

        if v1 then
            v1:Fire(UserGameSettings.RotationType == Enum.RotationType.CameraRelative)
        end
    end
end

function u45.SendInputToCCLCharacter(a1)
    -- Line: 101
    -- upvalues: AvatarAbilitiesInterface (val), u45 (val)
    -- types: a1: userdata
    local State, v1

    if not a1 then
        return
    end

    local v2 = AvatarAbilitiesInterface.get(a1)
    local InputContexts = a1:FindFirstChild("InputContexts")

    if not InputContexts then
        return
    end

    local CharacterContext = InputContexts:FindFirstChild("CharacterContext")

    if not CharacterContext then
        return
    end

    for i, j in v2:GetAbilities() do
        v1 = CharacterContext:FindFirstChild(j .. "Action")

        if v1 then
            State = v1:GetState()
            v2:SendInput(j, State)
        end
    end

    local v3, v4, v5 = u45._calculatePlayerInputValues(a1)
    v2:SendInput("Move", v3)
    v2:SendInput("CameraLookDirection", v4)
    v2:SendInput("CameraRelativeRotation", v5)
end

function u45.SendInputToHumanoidForServerAuth(a1) -- Line: 122; upvalues: u45 (val); types: a1: userdata
    local Character = a1.Character

    if Character == nil then
        return
    end

    local Humanoid = Character:FindFirstChild("Humanoid")

    if Humanoid == nil then
        return
    end

    local v1 = a1:FindFirstChild("InputContexts")

    if v1 == nil then
        return
    end

    local CharacterContext = v1:FindFirstChild("CharacterContext")

    if CharacterContext == nil then
        return
    end

    local JumpAction = CharacterContext.JumpAction
    local v2, v3, v4 = u45._calculatePlayerInputValues(a1)

    Humanoid:Move(v2)

    Humanoid.AutoRotate = not v4

    if v4
        and Humanoid.SeatPart == nil
        and Humanoid.RootPart ~= nil
        and not Humanoid.Sit
        and not Humanoid.RootPart:IsGrounded() then
        Humanoid.RootPart.CFrame = CFrame.new(Humanoid.RootPart.CFrame.Position, Humanoid.RootPart.CFrame.Position + v3)
    end

    Humanoid.Jump = if JumpAction == nil then false else JumpAction:GetState()
end

function u45.setupPlayerControlState(a1) -- Line: 151
    a1:AddVector3Field("Move", Vector3.new(0, 0, 0), 1)
    a1:AddBoolField("Jump", false)
    a1:AddBoolField("RotateToLookDirection", false)
    a1:AddUnitVector3Field("LookDirection", (Vector3.new(0, 0, 1)))
end

function u45.watchForPlayerControlState(a1) -- Line: 159; upvalues: u44 (val), u45 (val); types: a1: userdata
    local function watchCharacter(a1) -- Line: 160; upvalues: u44 (upval), u45 (upval); types: a1: userdata
        local v1 = a1:FindFirstChildOfClass(u44)

        if v1 then
            u45.setupPlayerControlState(v1)
        end

        a1.ChildAdded:Connect(function(a1) -- Line: 161; upvalues: u44 (upval), u45 (upval); types: a1: userdata
            if a1:IsA(u44) then
                u45.setupPlayerControlState(a1)
            end
        end)
    end

    if a1.Character then
        local Character = a1.Character
        local v1 = Character:FindFirstChildOfClass(u44)

        if v1 then
            u45.setupPlayerControlState(v1)
        end

        Character.ChildAdded:Connect(function(a1)
            -- Line: 161
            -- upvalues: u44 (upval), u45 (upval)
            -- types: a1: userdata
            if a1:IsA(u44) then
                u45.setupPlayerControlState(a1)
            end
        end)
    end

    a1.CharacterAdded:Connect(watchCharacter)
end

function u45.createPlayerControlState(a1)
    -- Line: 175
    -- upvalues: UserAbilitiesUserInterfaceB (val), u44 (val), u45 (val)
    -- types: a1: userdata
    local function createForCharacter(a1_2)
        -- Line: 176
        -- upvalues: UserAbilitiesUserInterfaceB (upval), u44 (upval), a1 (val), u45 (upval)
        -- types: a1_2: userdata
        local v1

        if UserAbilitiesUserInterfaceB then
            if a1_2:FindFirstChildOfClass(u44) then
                return
            end

            v1 = Instance.new(u44)
            v1.Owner = a1
            v1.Parent = a1_2

            u45.setupPlayerControlState(v1)

            return
        end

        if a1_2:FindFirstChild(u44) then
            return
        end

        v1 = Instance.new(u44)
        v1.Owner = a1
        v1.Parent = a1_2

        u45.setupPlayerControlState(v1)
    end

    if a1.Character then
        local v1
        local Character = a1.Character

        if not UserAbilitiesUserInterfaceB then
            if not Character:FindFirstChild(u44) then
                v1 = Instance.new(u44)
                v1.Owner = a1
                v1.Parent = Character

                u45.setupPlayerControlState(v1)
            end
        elseif not Character:FindFirstChildOfClass(u44) then
            v1 = Instance.new(u44)
            v1.Owner = a1
            v1.Parent = Character

            u45.setupPlayerControlState(v1)
        end
    end

    a1.CharacterAdded:Connect(createForCharacter)
end

function u45.writeInputToPCS(a1, a2)
    -- Line: 192
    -- upvalues: UserAbilitiesUserInterfaceB (val), u44 (val), UserGameSettings (val), Workspace (val), u15 (val)
    -- upvalues: AvatarAbilitiesInterface (val)
    -- types: a1: userdata
    local v1
    local data = a2.data
    local Character = a1.Character

    if not Character then
        return
    end

    if not (if not UserAbilitiesUserInterfaceB then
            Character:FindFirstChild(u44)
        else
            Character:FindFirstChildOfClass(u44))
        or not a2.humanoid then
        return
    end

    local isJumping = data.controlModule.isJumping
    local worldMoveVector = data.controlModule.worldMoveVector
    local v2 = UserGameSettings.RotationType == Enum.RotationType.CameraRelative
    local LookVector = Workspace.CurrentCamera and Workspace.CurrentCamera.CFrame.LookVector
        or Vector3.new(0, 0, 1)
    local v3 = Vector3.new(LookVector.X, 0, LookVector.Z)
    v3 = {
        Move = worldMoveVector,
        RotateToLookDirection = v2,
        LookDirection = if not (0.001 < v3.Magnitude) then Vector3.new(0, 0, 1) else v3.Unit,
    }

    if not u15 or not AvatarAbilitiesInterface.get(a1):isEnabled() then
        v3.Jump = isJumping
    end

    v1:UpdateFields(v3)
end

function u45.processPCSInputs(a1)
    -- Line: 224
    -- upvalues: UserAbilitiesUserInterfaceB (val), u44 (val)
    -- types: a1: userdata
    local v1
    local Character = a1.Character

    if Character == nil then
        return
    end

    local Humanoid = Character:FindFirstChild("Humanoid")

    if Humanoid == nil then
        return
    end

    if (if not UserAbilitiesUserInterfaceB then
        Character:FindFirstChild(u44)
    else
        Character:FindFirstChildOfClass(u44))
        == nil then
        return
    end

    local v2 = v1:GetState()
    local Move = v2.Move
    local Jump = v2.Jump
    local RotateToLookDirection = v2.RotateToLookDirection
    local LookDirection = v2.LookDirection

    if Move then
        Humanoid:Move(Move)
    end

    Humanoid.AutoRotate = not RotateToLookDirection

    if RotateToLookDirection
        and LookDirection ~= nil
        and Humanoid.RootPart ~= nil
        and not Humanoid.Sit
        and Humanoid.SeatPart == nil
        and not Humanoid.RootPart:IsGrounded() then
        Humanoid.RootPart.CFrame = CFrame.new(Humanoid.RootPart.CFrame.Position, Humanoid.RootPart.CFrame.Position + LookDirection)
    end

    Humanoid.Jump = Jump or false
end

return u45