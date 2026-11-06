-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.FreecamController
-- Decompile time: 5.43 ms

local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u42 = require(script.Parent.HudController)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local Freecam = Config.Player.Freecam
local u49 = Enum.ContextActionPriority.High.Value + 100
local u50 = {
    Enum.KeyCode.W,
    Enum.KeyCode.A,
    Enum.KeyCode.S,
    Enum.KeyCode.D,
    Enum.KeyCode.Q,
    Enum.KeyCode.E,
    Enum.KeyCode.F,
    Enum.KeyCode.Space,
    Enum.UserInputType.MouseButton1,
    Enum.UserInputType.MouseButton2,
    Enum.UserInputType.MouseWheel,
}
local u62 = false
local Speed = Freecam.Speed
local u64 = 0
local u65 = 0
local u66 = Vector3.new(0, 0, 0)
local u67 = nil

local function isDeveloper() -- Line: 64; upvalues: LocalPlayer (val), Config (val)
    return LocalPlayer:GetAttribute(Config.Release.AdminAttribute) == true
end

local function allowed() -- Line: 68; upvalues: LocalPlayer (val), Freecam (val), Config (val), UserInputService (val)
    local KeyboardEnabled = false

    if LocalPlayer:GetAttribute(Freecam.Attribute) == true then
        KeyboardEnabled = not (LocalPlayer:GetAttribute(Config.Release.AdminAttribute) == true)
            and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled
    end

    return KeyboardEnabled
end

local function controls() -- Line: 78; upvalues: LocalPlayer (val)
    local success, err = pcall(function() -- Line: 79; upvalues: LocalPlayer (upval)
        local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
        local PlayerModule = if not PlayerScripts then nil else PlayerScripts:FindFirstChild("PlayerModule")

        if PlayerModule then
            return (require(PlayerModule):GetControls())
        end

        return nil
    end)

    if success then
        return err
    end

    return nil
end

local function rootPosition() -- Line: 87; upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart.Position
    end

    return nil
end

local function sink(a1, a2, a3) -- Line: 93; upvalues: Freecam (val), Speed (ref); types: a1: string, a3: userdata
    if a3.UserInputType == Enum.UserInputType.MouseWheel
        and a2 == Enum.UserInputState.Change then
        local SpeedStep = if not (0 < a3.Position.Z) then
            1 / Freecam.SpeedStep
        else
            Freecam.SpeedStep
        Speed = math.clamp(Speed * SpeedStep, Freecam.MinSpeed, Freecam.MaxSpeed)
    end

    return Enum.ContextActionResult.Sink
end

local function step(a1)
    -- Line: 101
    -- upvalues: Workspace (val), UserInputService (val), u64 (ref), Freecam (val), u65 (ref), u66 (ref), Speed (ref)
    -- upvalues: LocalPlayer (val)
    -- types: a1: number
    local CurrentCamera = Workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local MouseDelta = UserInputService:GetMouseDelta()
    u64 = u64 - MouseDelta.X * Freecam.LookPerPixel
    u65 = math.clamp(u65 - MouseDelta.Y * Freecam.LookPerPixel, -1.4835298641951802, 1.4835298641951802)
    local v1 = (CFrame.Angles(0, u64, 0)) * CFrame.Angles(u65, 0, 0)
    local v2 = Vector3.new(0, 0, 0)

    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        v2 = v2 + Vector3.new(0, 0, -1)
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        v2 = v2 + Vector3.new(0, 0, 1)
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        v2 = v2 + Vector3.new(-1, 0, 0)
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        v2 = v2 + Vector3.new(1, 0, 0)
    end

    local v3 = 0

    if UserInputService:IsKeyDown(Enum.KeyCode.E) then
        v3 = v3 + 1
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
        v3 = v3 - 1
    end

    local v4 = (v1:VectorToWorldSpace(v2)) + Vector3.new(0, v3, 0)

    if 0 < v4.Magnitude then
        u66 = u66 + v4.Unit * Speed * a1
    end

    local Character = LocalPlayer.Character
    v2 = Character and Character:FindFirstChild("HumanoidRootPart")
    local Position = if not v2 then nil else if not v2:IsA("BasePart") then nil else v2.Position

    if Position then
        local v5 = u66 - Position

        if Freecam.MaxDistanceStuds < v5.Magnitude then
            u66 = Position + v5.Unit * Freecam.MaxDistanceStuds
        end
    end

    CurrentCamera.CFrame = CFrame.new(u66) * v1
end

local function stop()
    -- Line: 146
    -- upvalues: u62 (ref), RunService (val), ContextActionService (val), Workspace (val), u67 (ref)
    -- upvalues: UserInputService (val), LocalPlayer (val)
    if not u62 then
        return
    end

    u62 = false
    RunService:UnbindFromRenderStep("AboveFreecamStep")
    ContextActionService:UnbindAction("AboveFreecam")

    local CurrentCamera = Workspace.CurrentCamera
    local v1 = u67
    u67 = nil

    if v1 then
        if CurrentCamera then
            CurrentCamera.CameraType = v1.cameraType
        end

        UserInputService.MouseBehavior = v1.mouseBehavior
        UserInputService.MouseIconEnabled = v1.mouseIcon
    end

    local success, err = pcall(function() -- Line: 79; upvalues: LocalPlayer (upval)
        local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
        local PlayerModule = if not PlayerScripts then nil else PlayerScripts:FindFirstChild("PlayerModule")

        if PlayerModule then
            return (require(PlayerModule):GetControls())
        end

        return nil
    end)
    v1 = if not success then nil else err

    if v1 then
        v1:Enable()
    end

    print("[ABOVE] freecam off")
end

local function start()
    -- Line: 170
    -- upvalues: Workspace (val), u62 (ref), LocalPlayer (val), Freecam (val), Config (val), UserInputService (val)
    -- upvalues: u67 (ref), u66 (ref), u64 (ref), u65 (ref), Speed (ref), ContextActionService (val), sink (val)
    -- upvalues: u49 (val), u50 (val), RunService (val), step (val), u42 (val)
    local CurrentCamera = Workspace.CurrentCamera

    if not u62 and CurrentCamera then
        local KeyboardEnabled = false

        if LocalPlayer:GetAttribute(Freecam.Attribute) == true then
            KeyboardEnabled = not (LocalPlayer:GetAttribute(Config.Release.AdminAttribute) == true)
                and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled
        end

        if KeyboardEnabled then
            if CurrentCamera.CameraType ~= Enum.CameraType.Custom then
                return
            end

            u62 = true
            u67 = {
                cameraType = CurrentCamera.CameraType,
                mouseBehavior = UserInputService.MouseBehavior,
                mouseIcon = UserInputService.MouseIconEnabled,
            }
            u66 = CurrentCamera.CFrame.Position
            local LookVector = CurrentCamera.CFrame.LookVector
            u64 = math.atan2(-LookVector.X, -LookVector.Z)
            u65 = math.asin((math.clamp(LookVector.Y, -1, 1)))
            Speed = Freecam.Speed
            CurrentCamera.CameraType = Enum.CameraType.Scriptable
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
            UserInputService.MouseIconEnabled = false
            local success, err = pcall(function() -- Line: 79; upvalues: LocalPlayer (upval)
                local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
                local PlayerModule = if not PlayerScripts then
                    nil
                else
                    PlayerScripts:FindFirstChild("PlayerModule")

                if PlayerModule then
                    return (require(PlayerModule):GetControls())
                end

                return nil
            end)
            local v1 = if not success then nil else err

            if v1 then
                v1:Disable()
            end

            ContextActionService:BindActionAtPriority("AboveFreecam", sink, false, u49, (table.unpack(u50)))
            RunService:BindToRenderStep("AboveFreecamStep", Enum.RenderPriority.Camera.Value + 1, step)
            print("[ABOVE] freecam on")
            u42.showAlert("Freecam: WASD, E/Q up and down, scroll for speed. Shift+P to leave")
        end
    end
end

function v1.isActive() -- Line: 206; upvalues: u62 (ref)
    return u62
end

function v1.start()
    -- Line: 210
    -- upvalues: UserInputService (val), u62 (ref), stop (val), start (val), LocalPlayer (val), Freecam (val)
    -- upvalues: Config (val)
    UserInputService.InputBegan:Connect(function(a1, a2)
        -- Line: 211
        -- upvalues: UserInputService (upval), u62 (upval), stop (upval), start (upval)
        if not a2 and a1.KeyCode == Enum.KeyCode.P then
            if not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
                and not UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                return
            end

            if u62 then
                stop()
                return
            end

            start()
        end
    end)

    local v1 = stop
    LocalPlayer.CharacterAdded:Connect(v1)

    for i, j in {Freecam.Attribute, Config.Release.AdminAttribute} do
        (LocalPlayer:GetAttributeChangedSignal(j)):Connect(function()
            -- Line: 232
            -- upvalues: LocalPlayer (upval), Freecam (upval), Config (upval), UserInputService (upval), stop (upval)
            local KeyboardEnabled = false

            if LocalPlayer:GetAttribute(Freecam.Attribute) == true then
                KeyboardEnabled = not (LocalPlayer:GetAttribute(Config.Release.AdminAttribute)
                    == true)
                    and UserInputService.KeyboardEnabled and UserInputService.MouseEnabled
            end

            if not KeyboardEnabled then
                stop()
            end
        end)
    end
end

return v1