-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.CameraController
-- Decompile time: 3.12 ms

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u37 = require(script.Parent.BuildController)
local InputController = require(script.Parent.InputController)
local v1 = {}
local u44 = 70
local u45 = 0
local u46 = 0
local u47 = 0
local u48 = 0
local u49 = nil
local u50 = nil

local function approach(a1, a2, a3, a4) -- Line: 56; types: a1: number, a2: number, a3: number, a4: number
    local v1 = a2 - a1
    local v2 = a3 * a4

    if math.abs(v1) <= v2 then
        return a2
    end

    return a1 + (if not (v1 > 0) then -v2 else v2)
end

local function sprinting() -- Line: 69; upvalues: InputController (val)
    return InputController.sprinting == true
end

local function step(a1)
    -- Line: 73
    -- upvalues: Config (val), InputController (val), u46 (ref), u45 (ref), u47 (ref), Workspace (val), u48 (ref)
    -- upvalues: u44 (ref), u49 (ref)
    -- types: a1: number
    local Camera = Config.Appearance.Camera
    local SprintFovBonus = if not (InputController.sprinting == true) then
        0
    else
        Camera.SprintFovBonus

    if u46 == u45 and u47 == SprintFovBonus then
        return
    end

    local CurrentCamera = Workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local OpenSeconds = if not (u46 < u45) then Camera.CloseSeconds else Camera.OpenSeconds
    local v1 = u46
    local v2 = u45
    local v3 = Camera.UiFovBonus / math.max(0.01, OpenSeconds)
    local v4 = v2 - v1
    local v5 = v3 * a1
    u46 = if not (math.abs(v4) <= v5) then
        v1 + (if not (v4 > 0) then -v5 else v5)
    else
        v2
    v1 = u47
    v2 = Camera.SprintFovBonus / (math.max(0.01, Camera.SprintFovSeconds))
    local v6 = SprintFovBonus - v1
    v3 = v2 * a1
    local v7 = if not (math.abs(v6) <= v3) then
        v1 + (if not (v6 > 0) then -v3 else v3)
    else
        SprintFovBonus
    u48 = u46 + v7
    CurrentCamera.FieldOfView = u44 + u48
    local v8 = if not (0 < Camera.UiFovBonus) then 0 else u46 / Camera.UiFovBonus
    u49.Size = Camera.UiBlurSize * v8
    u49.Enabled = 0.05 < u49.Size
end

local function faceForward(a1) -- Line: 108; upvalues: Workspace (val), Config (val); types: a1: userdata
    local CurrentCamera = Workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local Camera = Config.Appearance.Camera
    local LookVector = a1.CFrame.LookVector
    local v1 = Vector3.new(LookVector.X, 0, LookVector.Z)

    if v1.Magnitude < 0.01 then
        return
    end

    CurrentCamera.CFrame = CFrame.lookAt(a1.Position - v1.Unit * Camera.FaceForwardBackStuds + Vector3.new(0, Camera.FaceForwardUpStuds, 0), a1.Position)
end

local function watchPlacement() -- Line: 127; upvalues: Players (val), u50 (ref), Config (val), faceForward (val)
    local Character = Players.LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local Position = HumanoidRootPart.Position
        local v1 = u50
        u50 = Position

        if v1
            and Config.Appearance.Camera.FaceForwardAfterStuds <= (Position - v1).Magnitude then
            faceForward(HumanoidRootPart)
        end

        return
    end

    u50 = nil
end

local function readBaseline() -- Line: 142; upvalues: Workspace (val), u44 (ref), u48 (ref)
    local CurrentCamera = Workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    u44 = CurrentCamera.FieldOfView - u48
end

function v1.start()
    -- Line: 153
    -- upvalues: u49 (ref), Lighting (val), Workspace (val), u44 (ref), u48 (ref), readBaseline (val), u37 (val)
    -- upvalues: u45 (ref), Config (val), RunService (val), step (val), u50 (ref), faceForward (val), Players (val)
    -- upvalues: watchPlacement (val)
    u49 = Instance.new("BlurEffect")
    u49.Name = "UiBlur"
    u49.Size = 0
    u49.Enabled = false
    u49.Parent = Lighting
    local CurrentCamera = Workspace.CurrentCamera

    if CurrentCamera then
        u44 = CurrentCamera.FieldOfView - u48
    end

    ;(Workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(readBaseline)

    u37.onUiOpenChanged(function(a1) -- Line: 166; upvalues: u45 (upval), Config (upval); types: a1: boolean
        u45 = if not a1 then 0 else Config.Appearance.Camera.UiFovBonus
    end)

    RunService.RenderStepped:Connect(step)

    local function onCharacter(a1) -- Line: 172; upvalues: u50 (upval), faceForward (upval); types: a1: userdata
        u50 = nil
        local HumanoidRootPart = a1:WaitForChild("HumanoidRootPart", 10)

        if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
            faceForward(HumanoidRootPart)
        end
    end

    local LocalPlayer = Players.LocalPlayer

    if LocalPlayer.Character then
        task.spawn(onCharacter, LocalPlayer.Character)
    end

    LocalPlayer.CharacterAdded:Connect(onCharacter)
    RunService.Heartbeat:Connect(watchPlacement)
end

return v1