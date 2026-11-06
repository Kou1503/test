-- Script path: game:GetService("ReplicatedStorage").Shared.BuildFlags
-- Decompile time: 0.31 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u5 = {ProtectionAttribute = "ProtectedVolumesEnabled"}

function u5.protectionEnabled() -- Line: 25; upvalues: ReplicatedStorage (val), u5 (val)
    return ReplicatedStorage:GetAttribute(u5.ProtectionAttribute) ~= false
end

function u5.setProtectionEnabled(a1) -- Line: 30; upvalues: ReplicatedStorage (val), u5 (val); types: a1: boolean
    ReplicatedStorage:SetAttribute(u5.ProtectionAttribute, a1)
end

return u5