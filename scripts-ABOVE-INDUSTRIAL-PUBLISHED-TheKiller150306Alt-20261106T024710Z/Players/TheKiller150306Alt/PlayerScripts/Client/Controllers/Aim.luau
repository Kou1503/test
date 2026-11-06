-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.Aim
-- Decompile time: 2.45 ms

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local DeviceMode = require(script.Parent.DeviceMode)
local u25 = {}
local u30 = Players.LocalPlayer:GetMouse()
local u31 = nil
local u32 = false
local u33 = (-1 / 0)
local u34 = (-1 / 0)

function u25.setTouchPoint(a1, a2)
    -- Line: 45
    -- upvalues: u31 (ref), u33 (ref), u34 (ref)
    -- types: a1: userdata?, a2: boolean?
    u31 = a1
    u33 = os.clock()

    if not a2 then
        u34 = u33
    end
end

local u36 = false

function u25.setCentred(a1) -- Line: 59; upvalues: u36 (ref); types: a1: boolean
    u36 = a1
end

function u25.isCentred() -- Line: 63; upvalues: u36 (ref)
    return u36
end

function u25.sinceTap() -- Line: 68; upvalues: u34 (ref)
    return os.clock() - u34
end

function u25.isFingerDown() -- Line: 72; upvalues: u32 (ref)
    return u32
end

function u25.setFingerDown(a1) -- Line: 76; upvalues: u32 (ref); types: a1: boolean
    u32 = a1
end

function u25.fingerLive() -- Line: 83; upvalues: u31 (ref), u32 (ref), u33 (ref)
    local v1 = false

    if u31 ~= nil then
        v1 = u32 or os.clock() - u33 < 0.6
    end

    return v1
end

function u25.touchPoint() -- Line: 87; upvalues: u31 (ref)
    return u31
end

function u25.isTouch() -- Line: 91; upvalues: u31 (ref)
    return u31 ~= nil
end

function u25.isVR() -- Line: 96; upvalues: VRService (val)
    return VRService.VREnabled
end

function u25.handRay() -- Line: 101; upvalues: VRService (val)
    local CurrentCamera = workspace.CurrentCamera

    if VRService.VREnabled and CurrentCamera then
        local success, err = pcall(function() -- Line: 106; upvalues: VRService (upval)
            return VRService:GetUserCFrame(Enum.UserCFrame.RightHand)
        end)

        if success and typeof(err) == "CFrame" then
            local v1 = CurrentCamera.CFrame
                * CFrame.new(err.Position * CurrentCamera.HeadScale)
                * err.Rotation
            return Ray.new(v1.Position, v1.LookVector)
        end

        return nil
    end

    return nil
end

function u25.ray() -- Line: 128; upvalues: u25 (val), u31 (ref), u36 (ref), ControlGlyphs (val), u30 (val)
    local CurrentCamera = workspace.CurrentCamera
    local v1 = u25.handRay()

    if v1 then
        return v1
    end

    v1 = u31

    if u36 and CurrentCamera and not u25.fingerLive() then
        v1 = CurrentCamera.ViewportSize / 2
    end

    if not v1 and ControlGlyphs.usingGamepad() and CurrentCamera then
        v1 = CurrentCamera.ViewportSize / 2
    end

    if v1 and CurrentCamera then
        local v2 = CurrentCamera:ViewportPointToRay(v1.X, v1.Y)
        return Ray.new(v2.Origin, v2.Direction)
    end

    return u30.UnitRay
end

if DeviceMode.Hybrid then
    UserInputService.InputChanged:Connect(function(a1) -- Line: 154; upvalues: u31 (ref), u32 (ref)
        if a1.UserInputType == Enum.UserInputType.MouseMovement and u31 and not u32 then
            u31 = nil
        end
    end)
end

local function isGamepad(a1) -- Line: 165; types: a1: userdata
    local UserInputType = a1.UserInputType
    local v1 = true

    if UserInputType ~= Enum.UserInputType.Gamepad1 then
        v1 = true

        if UserInputType ~= Enum.UserInputType.Gamepad2 then
            v1 = true

            if UserInputType ~= Enum.UserInputType.Gamepad3 then
                v1 = UserInputType == Enum.UserInputType.Gamepad4
            end
        end
    end

    return v1
end

UserInputService.InputBegan:Connect(function(a1) -- Line: 172; upvalues: u31 (ref), u32 (ref)
    if u31 and not u32 then
        local UserInputType = a1.UserInputType
        local v1 = true

        if UserInputType ~= Enum.UserInputType.Gamepad1 then
            v1 = true

            if UserInputType ~= Enum.UserInputType.Gamepad2 then
                v1 = true

                if UserInputType ~= Enum.UserInputType.Gamepad3 then
                    v1 = UserInputType == Enum.UserInputType.Gamepad4
                end
            end
        end

        if v1 then
            u31 = nil
        end
    end
end)

UserInputService.InputChanged:Connect(function(a1) -- Line: 177; upvalues: u31 (ref), u32 (ref)
    if u31 and not u32 then
        local UserInputType = a1.UserInputType
        local v1 = true

        if UserInputType ~= Enum.UserInputType.Gamepad1 then
            v1 = true

            if UserInputType ~= Enum.UserInputType.Gamepad2 then
                v1 = true

                if UserInputType ~= Enum.UserInputType.Gamepad3 then
                    v1 = UserInputType == Enum.UserInputType.Gamepad4
                end
            end
        end

        if v1 and 0.3 < a1.Position.Magnitude then
            u31 = nil
        end
    end
end)

function u25.isCentre() -- Line: 184; upvalues: u31 (ref), ControlGlyphs (val), VRService (val)
    local v1 = false

    if u31 == nil then
        v1 = ControlGlyphs.usingGamepad() and not VRService.VREnabled
    end

    return v1
end

return u25