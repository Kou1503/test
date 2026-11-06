-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ShiftLockController
-- Decompile time: 3.45 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u32 = require(script.Parent.Aim)
local BuildController = require(script.Parent.BuildController)
local DeviceMode = require(script.Parent.DeviceMode)
local u43 = {}
local LocalPlayer = Players.LocalPlayer
local u47 = DeviceMode.touchOnly()
local u48 = false
local u49 = false
local u50 = false
local u51 = nil

local function humanoidOf() -- Line: 49; upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character

    if Character then
        return (Character:FindFirstChildOfClass("Humanoid"))
    end

    return nil
end

local function release()
    -- Line: 54
    -- upvalues: u50 (ref), u51 (ref), u32 (val), LocalPlayer (val), UserInputService (val), u49 (ref)
    if not u50 then
        return
    end

    u50 = false
    u51 = nil

    u32.setCentred(false)

    local Character = LocalPlayer.Character
    local v1 = if not Character then nil else Character:FindFirstChildOfClass("Humanoid")

    if v1 then
        v1.AutoRotate = true
        v1.CameraOffset = Vector3.new(0, 0, 0)
    end

    UserInputService.MouseIcon = ""

    if not u49 and UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end
end

local function swing(a1, a2) -- Line: 74; upvalues: u51 (ref), Config (val); types: a1: userdata, a2: number
    local v1 = u51

    if not v1 then
        return
    end

    local CFrame_2 = a1.CFrame
    local Position = a1.Focus.Position
    local Magnitude = (CFrame_2.Position - Position).Magnitude
    local LookVector = CFrame_2.LookVector

    if (LookVector:Dot(v1)) > 0.9995 then
        u51 = nil
        return
    end

    local v2 = LookVector:Lerp(v1, 1 - (math.exp(-Config.Touch.ShiftLockTurn.Rate * a2)))

    if v2.Magnitude < 0.001 then
        u51 = nil
        return
    end

    a1.CFrame = CFrame.lookAt(Position - v2.Unit * math.max(Magnitude, 0.5), Position)
end

local function step(a1)
    -- Line: 97
    -- upvalues: LocalPlayer (val), u48 (ref), u49 (ref), release (val), u50 (ref), u47 (val), UserInputService (val)
    -- upvalues: u32 (val), swing (val)
    -- types: a1: number
    local Character = LocalPlayer.Character
    local v1 = if not Character then nil else Character:FindFirstChildOfClass("Humanoid")
    local Character_2 = LocalPlayer.Character
    local HumanoidRootPart = if not Character_2 then nil else Character_2:FindFirstChild("HumanoidRootPart")
    local CurrentCamera = workspace.CurrentCamera
    local v2 = u48

    if v2 then
        v2 = not u49

        if v2 then
            v2 = false

            if v1 ~= nil then
                v2 = false

                if 0 < v1.Health then
                    v2 = not v1.Sit

                    if v2 then
                        v2 = not v1.PlatformStand

                        if v2 then
                            v2 = false

                            if HumanoidRootPart ~= nil then
                                v2 = HumanoidRootPart:IsA("BasePart") and CurrentCamera ~= nil
                            end
                        end
                    end
                end
            end
        end
    end

    if not v2 then
        release()
        return
    end

    u50 = true

    if u47 then
        u32.setCentred(true)
        swing(CurrentCamera, a1)
    else
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        UserInputService.MouseIcon = "rbxasset://textures/MouseLockedCursor.png"
    end

    v1.AutoRotate = false
    v1.CameraOffset = Vector3.new(1.75, 0, 0)
    local LookVector = CurrentCamera.CFrame.LookVector
    local v3 = Vector3.new(LookVector.X, 0, LookVector.Z)

    if 0.01 < v3.Magnitude then
        HumanoidRootPart.CFrame = CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v3.Unit)
    end
end

function u43.turnToward(a1)
    -- Line: 137
    -- upvalues: u50 (ref), u47 (val), Config (val), u51 (ref)
    -- types: a1: userdata
    local CurrentCamera = workspace.CurrentCamera

    if u50 and u47 and CurrentCamera then
        local Direction = CurrentCamera:ViewportPointToRay(a1.X, a1.Y).Direction
        local MaxPitch = Config.Touch.ShiftLockTurn.MaxPitch
        local v1 = math.clamp(Direction.Y, -MaxPitch, MaxPitch)
        local v2 = Vector3.new(Direction.X, 0, Direction.Z)

        if v2.Magnitude < 0.001 then
            return
        end

        u51 = (v2.Unit * math.sqrt(1 - v1 * v1) + Vector3.new(0, v1, 0)).Unit
    end
end

function u43.toggle() -- Line: 154; upvalues: u48 (ref), release (val)
    u48 = not u48

    if not u48 then
        release()
    end

    return u48
end

function u43.start()
    -- Line: 162
    -- upvalues: Config (val), UserInputService (val), u43 (val), BuildController (val), u49 (ref), release (val)
    -- upvalues: RunService (val), step (val)
    local err, success
    local u0 = {}

    for i, j in Config.Player.ShiftLockKeys do
        success, err = pcall(function() -- Line: 165; upvalues: j (val)
            return Enum.KeyCode[j]
        end)

        if success and err then
            u0[err] = true
        end
    end

    UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 173; upvalues: u0 (val), u43 (upval)
        if not a2 and u0[a1.KeyCode] then
            u43.toggle()
        end
    end)

    BuildController.onUiOpenChanged(function(a1) -- Line: 180; upvalues: u49 (upval), release (upval)
        u49 = a1

        if a1 then
            release()
        end
    end)

    RunService:BindToRenderStep("AboveShiftLock", Enum.RenderPriority.Camera.Value + 1, step)
end

return u43