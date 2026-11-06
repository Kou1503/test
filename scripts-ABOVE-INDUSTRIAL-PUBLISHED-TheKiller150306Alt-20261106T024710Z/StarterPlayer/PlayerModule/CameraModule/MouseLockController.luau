-- Script path: game:GetService("StarterPlayer").PlayerModule.CameraModule.MouseLockController
-- Decompile time: 1.90 ms

local FlagUtil = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
local u28 = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext"):WaitForChild("MouseLockSwitchAction")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GameSettings = UserSettings().GameSettings
local u50 = require(script.Parent:WaitForChild("CameraUtils"))
local UserFixStuckShiftLock = FlagUtil.getUserFlag("UserFixStuckShiftLock")
local u54 = {}
u54.__index = u54

function u54.new()
    -- Line: 33
    -- upvalues: u54 (val), GameSettings (val), Players (val), UserInputService (val), u28 (val)
    local u3 = setmetatable(
        {},
        u54
    )
    u3.isMouseLocked = false
    u3.savedMouseCursor = nil
    u3.enabled = false
    u3.mouseLockToggledEvent = Instance.new("BindableEvent")

    GameSettings.Changed:Connect(function(a1) -- Line: 43; upvalues: u3 (val)
        if a1 == "ControlMode" or a1 == "ComputerMovementMode" then
            u3:UpdateMouseLockAvailability()
        end
    end)

    ;(Players.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock")):Connect(function()
        -- Line: 50
        -- upvalues: u3 (val)
        u3:UpdateMouseLockAvailability()
    end)

    ;(Players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode")):Connect(function()
        -- Line: 55
        -- upvalues: u3 (val)
        u3:UpdateMouseLockAvailability()
    end)

    ;(UserInputService:GetPropertyChangedSignal("PreferredInput")):Connect(function() -- Line: 59; upvalues: u3 (val)
        u3:UpdateMouseLockAvailability()
    end)

    u3:UpdateMouseLockAvailability()

    u28.Pressed:Connect(function() -- Line: 65; upvalues: u3 (val)
        u3:OnMouseLockToggled()
    end)

    return u3
end

function u54.GetIsMouseLocked(a1) -- Line: 72
    return a1.isMouseLocked
end

function u54.GetBindableToggleEvent(a1) -- Line: 76
    return a1.mouseLockToggledEvent.Event
end

function u54.GetMouseLockOffset(a1) -- Line: 80
    return (Vector3.new(1.75, 0, 0))
end

function u54:UpdateMouseLockAvailability()
    -- Line: 84
    -- upvalues: Players (val), GameSettings (val), UserInputService (val)
    local DevEnableMouseLock = Players.LocalPlayer.DevEnableMouseLock
    local v1 = Players.LocalPlayer.DevComputerMovementMode
        == Enum.DevComputerMovementMode.Scriptable
    local v2 = GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch
    local v3 = GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
    local v4 = UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse
        and DevEnableMouseLock and v2 and not v3 and not v1

    if v4 ~= self.enabled then
        self:EnableMouseLock(v4)
    end
end

function u54:OnMouseLockToggled() -- Line: 98; upvalues: u50 (val)
    self.isMouseLocked = not self.isMouseLocked

    if not self.isMouseLocked then
        u50.restoreMouseIcon()
    else
        local CursorImage = script:FindFirstChild("CursorImage")

        if not CursorImage or not CursorImage:IsA("StringValue") or not CursorImage.Value then
            if CursorImage then
                CursorImage:Destroy()
            end

            local v1 = Instance.new("StringValue")
            assert(v1, "")

            v1.Name = "CursorImage"
            v1.Value = "rbxasset://textures/MouseLockedCursor.png"
            v1.Parent = script

            u50.setMouseIconOverride("rbxasset://textures/MouseLockedCursor.png")
        else
            u50.setMouseIconOverride(CursorImage.Value)
        end
    end

    self.mouseLockToggledEvent:Fire()
end

function u54.IsMouseLocked(a1) -- Line: 123
    return a1.enabled and a1.isMouseLocked
end

function u54:EnableMouseLock(a2)
    -- Line: 127
    -- upvalues: u28 (val), u50 (val), UserFixStuckShiftLock (val)
    -- types: self: table, a2: boolean
    if a2 == self.enabled then
        return
    end

    self.enabled = a2

    if self.enabled then
        u28.Enabled = true
        return
    end

    u50.restoreMouseIcon()

    u28.Enabled = false

    if not UserFixStuckShiftLock then
        if self.isMouseLocked then
            self.mouseLockToggledEvent:Fire()
        end

        self.isMouseLocked = false

        return
    end

    if not self.isMouseLocked then
        return
    end

    self.isMouseLocked = false
    self.mouseLockToggledEvent:Fire()
end

return u54