-- Script path: game:GetService("StarterPlayer").PlayerModule.CameraModule.CameraToggleStateController
-- Decompile time: 0.94 ms

local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local CameraUI = require(script.Parent:WaitForChild("CameraUI"))
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local u24 = false
local u26 = tick()
local u27 = false
local u28 = false
local u29 = false

CameraUI.setCameraModeToastEnabled(false)

return function(a1)
    -- Line: 16
    -- upvalues: CameraInput (val), u24 (ref), u27 (ref), u26 (ref), CameraUI (val), u29 (ref), u28 (ref)
    -- upvalues: CameraUtils (val)
    -- types: a1: boolean
    local v1 = CameraInput.getTogglePan()

    if a1 and v1 ~= u24 then
        u27 = true
    end

    if u24 ~= v1 or tick() - u26 > 3 then
        CameraUI.setCameraModeToastOpen(v1 and tick() - u26 < 3)

        if v1 then
            u27 = false
        end

        u26 = tick()
        u24 = v1
    end

    if a1 ~= u29 then
        if a1 then
            u28 = CameraInput.getTogglePan()
            CameraInput.setTogglePan(true)
        elseif not u27 then
            CameraInput.setTogglePan(u28)
        end
    end

    if not a1 then
        if CameraInput.getTogglePan() then
            CameraUtils.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
            CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
            CameraUtils.setRotationTypeOverride(Enum.RotationType.MovementRelative)
        elseif not CameraInput.getHoldPan() then
            CameraUtils.restoreMouseIcon()
            CameraUtils.restoreMouseBehavior()
            CameraUtils.restoreRotationType()
        else
            CameraUtils.restoreMouseIcon()
            CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
            CameraUtils.setRotationTypeOverride(Enum.RotationType.MovementRelative)
        end
    else
        if not CameraInput.getTogglePan() then
            CameraUtils.restoreMouseIcon()
            CameraUtils.restoreMouseBehavior()
        else
            CameraUtils.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
            CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
        end

        CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative)
    end

    u29 = a1
end