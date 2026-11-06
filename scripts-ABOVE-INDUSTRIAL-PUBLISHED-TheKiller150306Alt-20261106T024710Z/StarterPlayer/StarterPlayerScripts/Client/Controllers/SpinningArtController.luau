-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.SpinningArtController
-- Decompile time: 9.29 ms

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Prefabs = require(Shared.Prefabs)
local u35 = require(script.Parent.SettingsController)

local function animationsOff() -- Line: 41; upvalues: u35 (val)
    return u35.get("MachineAnimations") == "Off"
end

local v1 = {}
local u38 = {}

local function poseOf(a1) -- Line: 57; types: a1: userdata
    if a1:IsA("Model") then
        return (a1:GetPivot())
    end

    return a1.CFrame
end

local function baseOf(a1) -- Line: 61; upvalues: u38 (val); types: a1: userdata
    local v1 = u38[a1]

    if v1 then
        return v1
    end

    local Pivot = if not a1:IsA("Model") then a1.CFrame else a1:GetPivot()
    u38[a1] = Pivot

    return Pivot
end

local u41 = {}
local u42 = {}

local function isMachineEffect(a1) -- Line: 81; types: a1: userdata
    local v1 = a1:FindFirstAncestorWhichIsA("BasePart")

    while v1 do
        if v1:GetAttribute("MachineId") ~= nil then
            return true
        end

        v1 = v1:FindFirstAncestorWhichIsA("BasePart")
    end

    return false
end

local function quietFarEffects() -- Line: 96; upvalues: Workspace (val), u35 (val), Config (val), u42 (val)
    local Parent, Position_2, Rate, v1
    local CurrentCamera = Workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local Position = CurrentCamera.CFrame.Position
    local MotionStuds = if not (u35.get("MachineAnimations") == "Off") then
        Config.Appearance.MotionStuds
    else
        -1
    local v2 = nil
    local v3 = nil

    for i in u42, v2, v3 do
        Parent = i.Parent

        if Parent then
            Position_2 = if not Parent:IsA("BasePart") then
                if not Parent:IsA("Attachment") then nil else Parent.WorldPosition
            else
                Parent.Position

            if Position_2 then
                v1 = i:GetAttribute("AuthoredRate")

                if not (MotionStuds < (Position_2 - Position).Magnitude) then
                    if type(v1) == "number" then
                        i.Rate = v1
                        i:SetAttribute("AuthoredRate", nil)
                    end
                elseif v1 == nil then
                    Rate = i.Rate
                    i:SetAttribute("AuthoredRate", Rate)

                    i.Rate = 0
                end
            end
        else
            u42[i] = nil
        end
    end
end

function v1.start()
    -- Line: 130
    -- upvalues: CollectionService (val), Prefabs (val), u38 (val), u41 (val), isMachineEffect (val), u42 (val)
    -- upvalues: Workspace (val), Config (val), quietFarEffects (val), RunService (val), u35 (val)
    (CollectionService:GetInstanceRemovedSignal(Prefabs.SpinTag)):Connect(function(a1)
        -- Line: 134
        -- upvalues: u38 (upval), u41 (upval)
        u38[a1] = nil
        u41[a1] = nil
    end)

    ;(CollectionService:GetInstanceAddedSignal(Prefabs.SpinTag)):Connect(function(a1)
        -- Line: 139
        -- upvalues: u41 (upval), u38 (upval)
        -- types: a1: userdata
        u41[a1] = true
        a1.Destroying:Connect(function() -- Line: 141; upvalues: u38 (upval), a1 (val), u41 (upval)
            u38[a1] = nil
            u41[a1] = nil
        end)
    end)

    for i, j in CollectionService:GetTagged(Prefabs.SpinTag) do
        u41[j] = true
        j.Destroying:Connect(function() -- Line: 141; upvalues: u38 (upval), j (val), u41 (upval)
            u38[j] = nil
            u41[j] = nil
        end)
    end

    for k, n in Workspace:GetDescendants() do
        if n:IsA("ParticleEmitter") and isMachineEffect(n) then
            u42[n] = true
        end
    end

    Workspace.DescendantAdded:Connect(function(a1)
        -- Line: 152
        -- upvalues: isMachineEffect (upval), u42 (upval)
        -- types: a1: userdata
        if a1:IsA("ParticleEmitter") and isMachineEffect(a1) then
            u42[a1] = true
        end
    end)

    task.spawn(function() -- Line: 161; upvalues: Config (upval), quietFarEffects (upval)
        while true do
            task.wait(Config.Appearance.MotionCheckSeconds)
            quietFarEffects()
        end
    end)

    RunService.RenderStepped:Connect(function()
        -- Line: 168
        -- upvalues: u35 (upval), Workspace (upval), Config (upval), u41 (upval), u38 (upval), Prefabs (upval)
        local Attribute, Attribute_2, Attribute_3, CFrame_2, CurrentCamera, HoverSecondsAttribute,
            HoverStudsAttribute, MotionStuds, Pivot, Position, Position_2, SpinAxisAttribute, SpinSpeedAttribute,
            SpinWhileWorkingAttribute, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
        local dispatch = 0

        while true do
            if dispatch < 5 then
                if dispatch < 2 then
                    if dispatch < 1 then
                        dispatch = if u35.get("MachineAnimations") == "Off" then 2 else 1
                    else
                        v1 = false
                        dispatch = 3
                    end
                elseif dispatch < 3 then
                    v1 = true
                    dispatch = 3
                else
                    if not (dispatch < 4) then
                        return
                    end

                    dispatch = if not v1 then 5 else 4
                end
            elseif dispatch < 7 then
                if dispatch < 6 then
                    v1 = os.clock()
                    CurrentCamera = Workspace.CurrentCamera
                    dispatch = if not CurrentCamera then 7 else 6
                else
                    Position = CurrentCamera.CFrame.Position
                    dispatch = 8
                end
            elseif dispatch < 8 then
                Position = nil
                dispatch = 8
            else
                if not (dispatch < 48) then
                    return
                end

                MotionStuds = Config.Appearance.MotionStuds
                v8 = u41
                v9 = nil
                v10 = nil
                local dispatchExit = nil

                for j in v8, v9, v10 do
                    local dispatch2 = 9

                    while true do
                        if dispatch2 < 28 then
                            if dispatch2 < 18 then
                                if dispatch2 < 13 then
                                    if dispatch2 < 11 then
                                        dispatch2 = if dispatch2 < 10 then
                                            if not Position then 19 else 10
                                        else
                                            if not CurrentCamera then 19 else 11
                                    elseif dispatch2 < 12 then
                                        v2 = u38[j]
                                        dispatch2 = if not v2 then 13 else 12
                                    else
                                        v11 = v2
                                        dispatch2 = 17
                                    end
                                elseif dispatch2 < 15 then
                                    if dispatch2 < 14 then
                                        dispatch2 = if not j:IsA("Model") then 15 else 14
                                    else
                                        Pivot = j:GetPivot()
                                        dispatch2 = 16
                                    end
                                elseif dispatch2 < 16 then
                                    Pivot = j.CFrame
                                    dispatch2 = 16
                                elseif dispatch2 < 17 then
                                    u38[j] = Pivot
                                    v11 = Pivot
                                    dispatch2 = 17
                                else
                                    Position_2 = v11.Position

                                    if MotionStuds < (Position_2 - Position).Magnitude then
                                        break
                                    else
                                        dispatch2 = 18
                                    end
                                end
                            elseif dispatch2 < 23 then
                                if dispatch2 < 20 then
                                    if dispatch2 < 19 then
                                        _, v3 = CurrentCamera:WorldToViewportPoint(Position_2)

                                        if not v3 then
                                            break
                                        else
                                            dispatch2 = 19
                                        end
                                    else
                                        dispatch2 = if j:IsA("BasePart") then 21 else 20
                                    end
                                elseif dispatch2 < 21 then
                                    if not j:IsA("Model") then
                                        break
                                    else
                                        dispatch2 = 21
                                    end
                                elseif dispatch2 < 22 then
                                    SpinSpeedAttribute = Prefabs.SpinSpeedAttribute
                                    Attribute = j:GetAttribute(SpinSpeedAttribute)

                                    if type(Attribute) ~= "number" then
                                        break
                                    else
                                        dispatch2 = 22
                                    end
                                else
                                    SpinWhileWorkingAttribute = Prefabs.SpinWhileWorkingAttribute
                                    dispatch2 = if j:GetAttribute(SpinWhileWorkingAttribute) ~= true then
                                        25
                                    else
                                        23
                                end
                            elseif dispatch2 < 25 then
                                if dispatch2 < 24 then
                                    v2 = j:FindFirstAncestorWhichIsA("BasePart")

                                    if not v2 then
                                        break
                                    else
                                        dispatch2 = 24
                                    end
                                elseif v2:GetAttribute(Prefabs.WorkingAttribute) ~= true then
                                    break
                                else
                                    dispatch2 = 25
                                end
                            elseif dispatch2 < 26 then
                                v2 = math.rad(v1 * Attribute % 360)
                                SpinAxisAttribute = Prefabs.SpinAxisAttribute
                                Attribute_2 = j:GetAttribute(SpinAxisAttribute)
                                dispatch2 = if Attribute_2 ~= "Z" then 27 else 26
                            elseif dispatch2 < 27 then
                                v4 = CFrame.Angles(0, 0, v2)
                                dispatch2 = 30
                            else
                                dispatch2 = if Attribute_2 ~= "X" then 29 else 28
                            end
                        elseif dispatch2 < 37 then
                            if dispatch2 < 32 then
                                if dispatch2 < 30 then
                                    v4 = if dispatch2 < 29 then
                                        CFrame.Angles(v2, 0, 0)
                                    else
                                        CFrame.Angles(0, v2, 0)
                                    dispatch2 = 30
                                elseif dispatch2 < 31 then
                                    HoverStudsAttribute = Prefabs.HoverStudsAttribute
                                    v2 = j:GetAttribute(HoverStudsAttribute)
                                    HoverSecondsAttribute = Prefabs.HoverSecondsAttribute
                                    Attribute_3 = j:GetAttribute(HoverSecondsAttribute)
                                    v6 = 0
                                    dispatch2 = if type(v2) ~= "number" then 34 else 31
                                else
                                    dispatch2 = if type(Attribute_3) ~= "number" then 34 else 32
                                end
                            elseif dispatch2 < 34 then
                                if dispatch2 < 33 then
                                    dispatch2 = if not (Attribute_3 > 0) then 34 else 33
                                else
                                    v6 = math.sin(v1 * 6.283185307179586 / Attribute_3) * v2
                                    dispatch2 = 34
                                end
                            elseif dispatch2 < 35 then
                                v2 = u38[j]
                                dispatch2 = if not v2 then 36 else 35
                            elseif dispatch2 < 36 then
                                v5 = v2
                                dispatch2 = 40
                            else
                                dispatch2 = if not j:IsA("Model") then 38 else 37
                            end
                        elseif dispatch2 < 42 then
                            if dispatch2 < 39 then
                                CFrame_2 = if dispatch2 < 38 then j:GetPivot() else j.CFrame
                                dispatch2 = 39
                            elseif dispatch2 < 40 then
                                u38[j] = CFrame_2
                                v5 = CFrame_2
                                dispatch2 = 40
                            else
                                dispatch2 = if dispatch2 < 41 then
                                    if Attribute_2 == "Z" then 42 else 41
                                else
                                    if Attribute_2 ~= "X" then 43 else 42
                            end
                        elseif not (dispatch2 < 44) then
                            if not (dispatch2 < 45) then
                                if not (dispatch2 < 46) then
                                    j.CFrame = v7
                                    break
                                end

                                j:PivotTo(v7)
                                break
                            end

                            dispatch2 = if not j:IsA("Model") then 46 else 45
                        else
                            v7 = if dispatch2 < 43 then
                                (v5 + Vector3.new(0, v6, 0)) * v4
                            else
                                CFrame.new(v5.Position + Vector3.new(0, v6, 0)) * v4
                                    * v5.Rotation
                            dispatch2 = 44
                        end
                    end

                    if dispatchExit then
                        break
                    end
                end

                dispatch = 48
            end
        end
    end)
end

return v1