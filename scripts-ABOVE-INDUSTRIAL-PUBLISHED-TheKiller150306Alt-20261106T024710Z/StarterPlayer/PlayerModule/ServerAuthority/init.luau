-- Script path: game:GetService("StarterPlayer").PlayerModule.ServerAuthority
-- Decompile time: 0.87 ms

local u0 = {}
u0.__index = u0
local ControlModule = require(script.Parent:WaitForChild("ControlModule"))
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CommonUtils = require(script.Parent:WaitForChild("CommonUtils"))
local FlagUtil = CommonUtils.get("FlagUtil")
local PlayerModuleEventBus = CommonUtils.get("PlayerModuleEventBus")
local u36 = FlagUtil.getUserFlag("UserDisableForceLocalHumanoidPrediction")
local u38 = false

function u0.PredictLocalHumanoid() -- Line: 26; upvalues: RunService (val), Players (val)
    if not Players.LocalPlayer.Character then
        Players.LocalPlayer.CharacterAdded:Connect(function(a1)
            -- Line: 27
            -- upvalues: RunService (upval)
            -- types: a1: userdata
            local HumanoidRootPart = a1:WaitForChild("HumanoidRootPart")
            RunService:SetPredictionMode(HumanoidRootPart, Enum.PredictionMode.On)
        end)
        return
    end

    local HumanoidRootPart = Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    RunService:SetPredictionMode(HumanoidRootPart, Enum.PredictionMode.On)
end

function u0.initialize(a1) -- Line: 38; upvalues: u38 (ref)
    a1.isServerAuthority = u38
end

function u0.Initialize()
    -- Line: 42
    -- upvalues: u36 (val), RunService (val), u0 (val), PlayerModuleEventBus (val), ControlModule (val), u38 (ref)
    if not u36 and RunService:IsClient() then
        u0.PredictLocalHumanoid()
    end

    if not PlayerModuleEventBus.data.inputsSetupComplete and RunService:IsServer() then
        PlayerModuleEventBus:subscribe("INPUTS_SETUP"):Wait()
    end

    ControlModule:InitializeServerAuthority()

    u38 = true
end

return u0