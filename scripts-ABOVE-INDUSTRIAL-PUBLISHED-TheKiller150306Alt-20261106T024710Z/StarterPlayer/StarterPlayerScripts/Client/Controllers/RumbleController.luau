-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.RumbleController
-- Decompile time: 0.93 ms

local HapticService = game:GetService("HapticService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local u22 = require(script.Parent.ControlGlyphs)
local SettingsController = require(script.Parent.SettingsController)
local v1 = {}
local Gamepad1 = Enum.UserInputType.Gamepad1
local u30 = {}

function v1.pulse(a1)
    -- Line: 25
    -- upvalues: u22 (val), SettingsController (val), Config (val), HapticService (val), Gamepad1 (val), u30 (val)
    -- types: a1: string
    if u22.usingGamepad() and SettingsController.get("ControllerVibration") ~= "Off" then
        local u11 = Config.Player.Rumble[a1]

        if not u11 then
            return
        end

        pcall(function() -- Line: 33; upvalues: u11 (val), HapticService (upval), Gamepad1 (upval), u30 (upval)
            local u3 = Enum.VibrationMotor[u11.motor]

            if HapticService:IsVibrationSupported(Gamepad1)
                and HapticService:IsMotorSupported(Gamepad1, u3) then
                local u18 = (u30[u3] or 0) + 1
                u30[u3] = u18

                HapticService:SetMotor(Gamepad1, u3, u11.strength)

                task.delay(
                    u11.seconds,
                    function()
                        -- Line: 41
                        -- upvalues: u30 (upval), u3 (val), u18 (val), HapticService (upval), Gamepad1 (upval)
                        if u30[u3] == u18 then
                            HapticService:SetMotor(Gamepad1, u3, 0)
                        end
                    end
                )
            end
        end)
    end
end

return v1