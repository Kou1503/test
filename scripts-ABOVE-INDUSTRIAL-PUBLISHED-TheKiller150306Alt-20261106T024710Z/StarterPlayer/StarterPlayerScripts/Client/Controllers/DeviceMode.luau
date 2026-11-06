-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.DeviceMode
-- Decompile time: 0.64 ms

local UserInputService = game:GetService("UserInputService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u22 = require(script.Parent.SettingsController)
local u23 = {}
local TouchEnabled = UserInputService.TouchEnabled and UserInputService.KeyboardEnabled
u23.Hybrid = TouchEnabled
local u28 = nil

function u23.touchOnly() -- Line: 34; upvalues: u28 (ref), UserInputService (val)
    if u28 ~= nil then
        return u28
    end

    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

function u23.mode() -- Line: 42; upvalues: u22 (val)
    return u22.get("ControlMode")
end

function u23.resolve() -- Line: 47; upvalues: u23 (val), u22 (val), Config (val), u28 (ref), UserInputService (val)
    if u23.Hybrid then
        u22.waitLoaded(Config.Touch.ControlModeWaitSeconds)
    end

    u28 = UserInputService.TouchEnabled
        and (not UserInputService.KeyboardEnabled or u23.mode() == "Touch")
end

return u23