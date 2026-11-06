-- Script path: game:GetService("ReplicatedStorage").Shared.Prompts
-- Decompile time: 0.63 ms

local CollectionService = game:GetService("CollectionService")
local Config = require(script.Parent.Config)
local u10 = {}

function u10.new() -- Line: 34; upvalues: CollectionService (val), u10 (val)
    local ProximityPrompt = Instance.new("ProximityPrompt")
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
    ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.F

    CollectionService:AddTag(ProximityPrompt, u10.Tag)

    return ProximityPrompt
end

u10.Tag = "AbovePrompt"
u10.ReachAttribute = "Reach"
u10.BenchedAttribute = "Benched"
u10.RequiresAttribute = "Requires"
u10.MayBuildAttribute = "MayBuildHere"

function u10.setReach(a1, a2) -- Line: 64; upvalues: u10 (val), Config (val); types: a1: userdata, a2: number
    a1:SetAttribute(u10.ReachAttribute, a2)

    a1.MaxActivationDistance = math.max(a2, Config.Player.PointerReachStuds)
end

function u10.pointedReach(a1) -- Line: 70; upvalues: u10 (val), Config (val); types: a1: userdata
    return (math.max(u10.reachOf(a1), Config.Player.PointerReachStuds))
end

function u10.reachOf(a1) -- Line: 75; upvalues: u10 (val); types: a1: userdata
    local Attribute = a1:GetAttribute(u10.ReachAttribute)

    if type(Attribute) == "number" then
        return Attribute
    end

    return a1.MaxActivationDistance
end

return u10