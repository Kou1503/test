-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.BuilderLightController
-- Decompile time: 3.99 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u25 = require(script.Parent.NewPlayerView)
local u26 = {}
local LocalPlayer = Players.LocalPlayer
local BuilderLight = Config.Monetization.BuilderLight
local u30 = nil
local u31 = false
local u32 = false
local u33 = {}

function u26.owns() -- Line: 40; upvalues: LocalPlayer (val), Config (val)
    return LocalPlayer:GetAttribute(Config.Monetization.BuilderLightAttribute) == true
end

local function onOwnIsland() -- Line: 46; upvalues: u30 (ref), LocalPlayer (val), BuilderLight (val)
    local v1 = u30
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

    if v1 and HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local v2 = HumanoidRootPart.Position - v1
        return Vector3.new(v2.X, 0, v2.Z).Magnitude <= BuilderLight.OwnIslandStuds
    end

    return false
end

local function refresh()
    -- Line: 57
    -- upvalues: u31 (ref), u26 (val), u30 (ref), LocalPlayer (val), BuilderLight (val), u32 (ref), u25 (val)
    local v1 = u31

    if v1 then
        v1 = u26.owns()

        if v1 then
            local v2 = u30
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

            if not v2 or not HumanoidRootPart then
                v1 = false
            elseif HumanoidRootPart:IsA("BasePart") then
                local v3 = HumanoidRootPart.Position - v2
                v1 = Vector3.new(v3.X, 0, v3.Z).Magnitude
                    <= BuilderLight.OwnIslandStuds
            else
                v1 = false
            end
        end
    end

    if v1 ~= u32 then
        u25.hold("BuilderLight", v1)
    end
end

function u26.isOn() -- Line: 66; upvalues: u31 (ref), u26 (val)
    return u31 and u26.owns()
end

function u26.setOn(a1)
    -- Line: 70
    -- upvalues: u26 (val), u31 (ref), u30 (ref), LocalPlayer (val), BuilderLight (val), u32 (ref), u25 (val), u33 (val)
    -- types: a1: boolean
    if not u26.owns() then
        a1 = false
    end

    if u31 == a1 then
        return
    end

    local v1 = a1

    if v1 then
        v1 = u26.owns()

        if v1 then
            local v2 = u30
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

            if not v2 or not HumanoidRootPart then
                v1 = false
            elseif HumanoidRootPart:IsA("BasePart") then
                local v3 = HumanoidRootPart.Position - v2
                v1 = Vector3.new(v3.X, 0, v3.Z).Magnitude
                    <= BuilderLight.OwnIslandStuds
            else
                v1 = false
            end
        end
    end

    if v1 ~= u32 then
        u25.hold("BuilderLight", v1)
    end

    for i, j in u33 do
        j()
    end
end

function u26.onChanged(a1) -- Line: 85; upvalues: u33 (val); types: a1: function
    table.insert(u33, a1)
end

function u26.start()
    -- Line: 89
    -- upvalues: Remotes (val), u30 (ref), u31 (ref), u26 (val), LocalPlayer (val), BuilderLight (val), u32 (ref)
    -- upvalues: u25 (val), Config (val), u33 (val)
    (Remotes.get(Remotes.IslandReady)).OnClientEvent:Connect(function(a1)
        -- Line: 91
        -- upvalues: u30 (upval), u31 (upval), u26 (upval), LocalPlayer (upval), BuilderLight (upval), u32 (upval)
        -- upvalues: u25 (upval)
        if typeof(a1) == "Vector3" then
            local v1 = u31

            if v1 then
                v1 = u26.owns()

                if v1 then
                    local v2 = a1
                    local Character = LocalPlayer.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

                    if not v2 or not HumanoidRootPart then
                        v1 = false
                    elseif HumanoidRootPart:IsA("BasePart") then
                        local v3 = HumanoidRootPart.Position - v2
                        v1 = Vector3.new(v3.X, 0, v3.Z).Magnitude
                            <= BuilderLight.OwnIslandStuds
                    else
                        v1 = false
                    end
                end
            end

            if v1 ~= u32 then
                u25.hold("BuilderLight", v1)
            end
        end
    end)

    ;(LocalPlayer:GetAttributeChangedSignal(Config.Monetization.BuilderLightAttribute)):Connect(function()
        -- Line: 97
        -- upvalues: u26 (upval), u31 (upval), u30 (upval), LocalPlayer (upval), BuilderLight (upval), u32 (upval)
        -- upvalues: u25 (upval), u33 (upval)
        if not u26.owns() then
            u31 = false
        end

        local v1 = u31

        if v1 then
            v1 = u26.owns()

            if v1 then
                local v2 = u30
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

                if not v2 or not HumanoidRootPart then
                    v1 = false
                elseif HumanoidRootPart:IsA("BasePart") then
                    local v3 = HumanoidRootPart.Position - v2
                    v1 = Vector3.new(v3.X, 0, v3.Z).Magnitude
                        <= BuilderLight.OwnIslandStuds
                else
                    v1 = false
                end
            end
        end

        if v1 ~= u32 then
            u25.hold("BuilderLight", v1)
        end

        for i, j in u33 do
            j()
        end
    end)

    task.spawn(function()
        -- Line: 108
        -- upvalues: BuilderLight (upval), u31 (upval), u26 (upval), u30 (upval), LocalPlayer (upval), u32 (upval)
        -- upvalues: u25 (upval)
        local Character, HumanoidRootPart, v1, v2, v3

        while true do
            task.wait(BuilderLight.CheckSeconds)

            v1 = u31

            if v1 then
                v1 = u26.owns()

                if v1 then
                    v2 = u30
                    Character = LocalPlayer.Character
                    HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

                    if not v2 or not HumanoidRootPart then
                        v1 = false
                    elseif HumanoidRootPart:IsA("BasePart") then
                        v3 = HumanoidRootPart.Position - v2
                        v1 = Vector3.new(v3.X, 0, v3.Z).Magnitude
                            <= BuilderLight.OwnIslandStuds
                    else
                        v1 = false
                    end
                end
            end

            if v1 ~= u32 then
                u25.hold("BuilderLight", v1)
            end
        end
    end)
end

return u26