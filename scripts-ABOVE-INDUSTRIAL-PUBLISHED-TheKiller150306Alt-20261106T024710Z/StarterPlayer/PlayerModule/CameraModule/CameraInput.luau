-- Script path: game:GetService("StarterPlayer").PlayerModule.CameraModule.CameraInput
-- Decompile time: 3.66 ms

game:GetService("ContextActionService")

local UserInputService = game:GetService("UserInputService")
game:GetService("Players")

local UserGameSettings = UserSettings():GetService("UserGameSettings")
game:GetService("VRService")

local GuiService = game:GetService("GuiService")
local FlagUtil = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local v1 = FlagUtil.getUserFlag("UserPSTextboxResetCameraInput")
local UserPlayerScriptsSupportTVRemoteKeycodes = FlagUtil.getUserFlag("UserPlayerScriptsSupportTVRemoteKeycodes")
local CameraContext = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext")
local u66 = CameraContext:WaitForChild("CameraRotationAction")
local CameraZoomAction = CameraContext:WaitForChild("CameraZoomAction")
local GamepadBinding = u66:WaitForChild("GamepadBinding")
local MicroGamepadBinding = if not UserPlayerScriptsSupportTVRemoteKeycodes then
    nil
else
    u66:WaitForChild("MicroGamepadBinding")
local MouseBinding = u66:WaitForChild("MouseBinding")
local TrackpadBinding = u66:WaitForChild("TrackpadBinding")
local CameraToggleAction = CameraContext:WaitForChild("CameraToggleAction")
local CameraPanActiveAction = CameraContext:WaitForChild("CameraPanActiveAction")
local u98 = 1

local function updateCameraYInvert() -- Line: 38; upvalues: UserGameSettings (val), u98 (ref), u66 (val)
    local Vector2Scale
    local CameraYInvertValue = UserGameSettings:GetCameraYInvertValue()

    if CameraYInvertValue == u98 then
        return
    end

    u98 = CameraYInvertValue

    for i, j in u66:GetChildren() do
        if j:IsA("InputBinding") then
            Vector2Scale = j.Vector2Scale
            j.Vector2Scale = Vector2.new(Vector2Scale.X, -Vector2Scale.Y)
        end
    end
end

;(UserGameSettings:GetPropertyChangedSignal("GamepadCameraSensitivity")):Connect(function()
    -- Line: 52
    -- upvalues: GamepadBinding (val), UserGameSettings (val), UserPlayerScriptsSupportTVRemoteKeycodes (val)
    -- upvalues: MicroGamepadBinding (val)
    GamepadBinding.Scale = UserGameSettings.GamepadCameraSensitivity

    if UserPlayerScriptsSupportTVRemoteKeycodes and MicroGamepadBinding then
        MicroGamepadBinding.Scale = UserGameSettings.GamepadCameraSensitivity
    end
end)

GamepadBinding.Scale = UserGameSettings.GamepadCameraSensitivity

if UserPlayerScriptsSupportTVRemoteKeycodes and MicroGamepadBinding then
    MicroGamepadBinding.Scale = UserGameSettings.GamepadCameraSensitivity
end

;(UserGameSettings:GetPropertyChangedSignal("MouseSensitivity")):Connect(function()
    -- Line: 59
    -- upvalues: UserGameSettings (val), MouseBinding (val), TrackpadBinding (val)
    local MouseSensitivity = UserGameSettings.MouseSensitivity
    MouseBinding.Scale = MouseSensitivity
    TrackpadBinding.Scale = MouseSensitivity
end)

local MouseSensitivity = UserGameSettings.MouseSensitivity
MouseBinding.Scale = MouseSensitivity
TrackpadBinding.Scale = MouseSensitivity

updateCameraYInvert()

local function adjustTouchPitchSensitivity(a1) -- Line: 75; types: a1: userdata
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return a1
    end

    local v1 = CurrentCamera.CFrame:ToEulerAnglesYXZ()

    if 0 <= a1.Y * v1 then
        return a1
    end

    v1 = (1 - ((math.abs(v1)) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25

    return Vector2.new(1, v1) * a1
end

local v2 = {}
local u134 = 0

local function resetPanInputCount() -- Line: 114; upvalues: u134 (ref)
    u134 = 0
end

function v2.getRotationActivated() -- Line: 118; upvalues: u134 (ref), u66 (val)
    local v1 = true

    if not (u134 > 0) then
        v1 = 0 < u66:GetState().Magnitude
    end

    return v1
end

function v2.getPanActivated() -- Line: 123; upvalues: u134 (ref)
    return u134 > 0
end

function v2.getRotation(a1)
    -- Line: 127
    -- upvalues: updateCameraYInvert (val), u66 (val), UserInputService (val), adjustTouchPitchSensitivity (val)
    updateCameraYInvert()

    local v1 = u66:GetState() * a1

    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        v1 = adjustTouchPitchSensitivity(v1)
    end

    return v1
end

function v2.getZoomDelta(a1) -- Line: 136; upvalues: CameraZoomAction (val)
    return CameraZoomAction:GetState() * a1
end

CameraPanActiveAction.Pressed:Connect(function() -- Line: 106; upvalues: u134 (ref)
    u134 = math.max(0, u134 + 1)
end)

CameraPanActiveAction.Released:Connect(function() -- Line: 110; upvalues: u134 (ref)
    u134 = math.max(0, u134 - 1)
end)

local u158 = false

function v2.setInputEnabled(a1)
    -- Line: 147
    -- upvalues: u158 (ref), u134 (ref), CameraZoomAction (val), u66 (val), CameraPanActiveAction (val)
    if u158 == a1 then
        return
    end

    u134 = 0

    if a1 then
        CameraZoomAction.Enabled = true
        u66.Enabled = true
        CameraPanActiveAction.Enabled = true

        return
    end

    CameraZoomAction.Enabled = false
    u66.Enabled = false
    CameraPanActiveAction.Enabled = false
end

function v2.getInputEnabled() -- Line: 168; upvalues: u158 (ref)
    return u158
end

UserInputService.WindowFocused:Connect(resetPanInputCount)
UserInputService.WindowFocusReleased:Connect(resetPanInputCount)
GuiService.MenuOpened:Connect(resetPanInputCount)

if v1 then
    UserInputService.TextBoxFocusReleased:Connect(resetPanInputCount)
end

local u185 = false
local u186 = false
local u187 = 0

function v2.getHoldPan() -- Line: 187; upvalues: u185 (ref)
    return u185
end

function v2.getTogglePan() -- Line: 191; upvalues: u186 (ref)
    return u186
end

function v2.getPanning() -- Line: 195; upvalues: u186 (ref), u185 (ref)
    return u186 or u185
end

function v2.setTogglePan(a1) -- Line: 199; upvalues: u186 (ref); types: a1: boolean
    u186 = a1
end

local u193 = false

CameraToggleAction.Pressed:Connect(function() -- Line: 207; upvalues: u185 (ref), u187 (ref)
    u185 = true
    u187 = tick()
end)

CameraToggleAction.Released:Connect(function()
    -- Line: 212
    -- upvalues: u185 (ref), u187 (ref), u186 (ref), UserInputService (val)
    u185 = false

    if tick() - u187 < 0.3 then
        if u186 or UserInputService:GetMouseDelta().Magnitude < 2 then
            u186 = not u186
        end
    end
end)

function v2.enableCameraToggleInput()
    -- Line: 219
    -- upvalues: u193 (ref), u185 (ref), u186 (ref), CameraToggleAction (val)
    if u193 then
        return
    end

    u193 = true
    u185 = false
    u186 = false
    CameraToggleAction.Enabled = true
end

function v2.disableCameraToggleInput() -- Line: 231; upvalues: u193 (ref), CameraToggleAction (val)
    if not u193 then
        return
    end

    u193 = false
    CameraToggleAction.Enabled = false
end

return v2