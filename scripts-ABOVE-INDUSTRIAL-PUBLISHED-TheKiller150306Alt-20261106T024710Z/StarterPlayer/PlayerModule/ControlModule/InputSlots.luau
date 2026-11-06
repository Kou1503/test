-- Script path: game:GetService("StarterPlayer").PlayerModule.ControlModule.InputSlots
-- Decompile time: 5.80 ms

local FlagUtil = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil")
game:GetService("StarterPlayer")

local v1 = game:GetService("Players")
local RunService = game:GetService("RunService")

UserSettings():GetService("UserGameSettings")

local UserInputService = game:GetService("UserInputService")
local InputReplication = require(script.Parent:WaitForChild("InputReplication"))
local u58 = require(script.Parent:WaitForChild("AvatarAbilitiesInterface")).get(v1.LocalPlayer)
local u62 = FlagUtil.getUserFlag("UserPlayerScriptsPlayerControlState2")
local u66 = FlagUtil.getUserFlag("UserAbilitiesUserInterfaceB")
local UserPSUseBindToAnimation = FlagUtil.getUserFlag("UserPSUseBindToAnimation")
local u71 = if not u66 then "PlayerControlState" else "ControlState"
local u72 = {}
u72.__index = u72
local u73 = {}
local u74 = {}
local u75 = {}
local u76 = {}
local BindableEvent = Instance.new("BindableEvent")
local u80 = 0
local BindableEvent_2 = Instance.new("BindableEvent")

local function shallow_equal(a1, a2) -- Line: 33
    if a1 == a2 then
        return true
    end

    for k, v in pairs(a1) do
        if a2[k] ~= v then
            return false
        end
    end

    for k2, i in pairs(a2) do
        if a1[k2] == nil then
            return false
        end
    end

    return true
end

local function findInSparseTable(a1, a2) -- Line: 40
    for k, v in pairs(a1) do
        if v == a2 then
            return k
        end
    end

    return nil
end

function u72.GetNumOverflowSlots() -- Line: 49
    return 3
end

function u72.getOverflowScrollIndex() -- Line: 53; upvalues: u80 (ref)
    return u80
end

function u72.setOverflowScrollIndex(a1) -- Line: 57; upvalues: u80 (ref), u74 (ref), BindableEvent_2 (val)
    local v1 = u80
    u80 = math.max(0, (math.min(#u74 - 3, a1)))

    if u80 ~= v1 then
        BindableEvent_2:Fire()
    end
end

function u72.getScrollIndexChangedEvent() -- Line: 65; upvalues: BindableEvent_2 (val)
    return BindableEvent_2.Event
end

function u72.setupSlotActions(a1, a2)
    -- Line: 69
    -- upvalues: u62 (val), UserPSUseBindToAnimation (val), RunService (val), u58 (val), InputReplication (val)
    -- upvalues: u73 (val), u74 (ref), UserInputService (val), u72 (val), shallow_equal (val), BindableEvent (val)
    -- upvalues: u66 (val), u71 (val), u75 (val), u76 (val), u80 (ref)
    local function getAbilityAction(a1_2) -- Line: 70; upvalues: u62 (upval), a2 (val), a1 (val)
        if not a1_2 then
            return nil
        end

        local InputContexts = if not u62 then
            a1:FindFirstChild("InputContexts")
        else
            if not a2 then
                script.Parent.Parent:FindFirstChild("InputContexts")
            else
                a1:FindFirstChild("InputContexts")

        if not InputContexts then
            return nil
        end

        local CharacterContext = InputContexts:FindFirstChild("CharacterContext")

        if not CharacterContext then
            return nil
        end

        return (CharacterContext:FindFirstChild(a1_2 .. "Action"))
    end

    if not u62 then
        if not UserPSUseBindToAnimation then
            local Hz60_2 = Enum.StepFrequency.Hz60
            RunService:BindToSimulation(
                function(a1_2) -- Line: 92; upvalues: u58 (upval), InputReplication (upval), a1 (val)
                    if u58:isEnabled() then
                        InputReplication.FireCustomInputs(a1)
                        InputReplication.SendInputToCCLCharacter(a1)
                    end
                end,
                Hz60_2
            )
        else
            local Hz60 = Enum.StepFrequency.Hz60
            RunService:BindToAnimation(
                function(a1_2) -- Line: 85; upvalues: u58 (upval), InputReplication (upval), a1 (val)
                    if u58:isEnabled() then
                        InputReplication.FireCustomInputs(a1)
                        InputReplication.SendInputToCCLCharacter(a1)
                    end
                end,
                Hz60
            )
        end
    end

    local u17 = {}

    local function updateSlotMap()
        -- Line: 103
        -- upvalues: u73 (upval), u74 (upval), u58 (upval), UserInputService (upval), u17 (val), u72 (upval)
        -- upvalues: shallow_equal (upval), BindableEvent (upval)
        local AbilityConfig, v1, v2, v3, v4
        local v5 = table.clone(u73)
        local v6 = table.clone(u74)
        local Abilities = u58:GetAbilities()
        local v7 = if UserInputService.PreferredInput ~= Enum.PreferredInput.Touch then 11 else 7

        for k, v in pairs(u73) do
            for k2, i in pairs(Abilities) do
                if i == v then
                    if not k2 or v7 < k then
                        u73[k] = nil
                    end

                    break
                end
            end

            if true then
                u73[k] = nil
            end
        end

        u74 = {}
        local v8 = {}

        for i2, j in ipairs(Abilities) do
            for k3, k4 in pairs(u73) do
                if k4 == j then
                    if not k3 then
                        table.insert(v8, j)
                    end

                    break
                end
            end

            if true then
                table.insert(v8, j)
            end
        end

        for i3, n in ipairs(v8) do
            v4 = u58:GetAbilityConfig(n)

            if v4 then
                v1 = tonumber(v4.Slot)

                if v1 > 0 then
                    if u73[v1] or not (v1 <= v7) then
                        table.insert(u74, n)
                    else
                        u73[v1] = n
                    end
                end
            end
        end

        for i4, m in ipairs(v8) do
            AbilityConfig = u58:GetAbilityConfig(m)

            if AbilityConfig and tonumber(AbilityConfig.Slot) == 0 then
                v2 = u17[m]

                if not v2 then
                    v3 = -1

                    for i5 = 1, v7 do
                        if not u73[i5] then
                            v3 = i5
                            break
                        end
                    end

                    if v3 == -1 then
                        table.insert(u74, m)
                    else
                        u73[v3] = m
                        u17[m] = v3
                    end
                elseif not (v2 > 0) then
                    v3 = -1

                    for i6 = 1, v7 do
                        if not u73[i6] then
                            v3 = i6
                            break
                        end
                    end

                    if v3 == -1 then
                        table.insert(u74, m)
                    else
                        u73[v3] = m
                        u17[m] = v3
                    end
                elseif not (v2 <= v7) then
                    v3 = -1

                    for i7 = 1, v7 do
                        if not u73[i7] then
                            v3 = i7
                            break
                        end
                    end

                    if v3 == -1 then
                        table.insert(u74, m)
                    else
                        u73[v3] = m
                        u17[m] = v3
                    end
                elseif u73[v2] then
                    v3 = -1

                    for i8 = 1, v7 do
                        if not u73[i8] then
                            v3 = i8
                            break
                        end
                    end

                    if v3 == -1 then
                        table.insert(u74, m)
                    else
                        u73[v3] = m
                        u17[m] = v3
                    end
                else
                    u73[v2] = m
                end
            end
        end

        u72.setOverflowScrollIndex(u72.getOverflowScrollIndex())

        if not shallow_equal(u73, v5) or not shallow_equal(u74, v6) then
            BindableEvent:Fire()
        end
    end

    u58:GetAbilitiesChangedSignal():Connect(updateSlotMap)
    ;(UserInputService:GetPropertyChangedSignal("PreferredInput")):Connect(updateSlotMap)
    updateSlotMap()

    task.spawn(function()
        -- Line: 186
        -- upvalues: u66 (upval), u71 (upval), u62 (upval), a2 (val), a1 (val), u75 (upval), u73 (upval)
        -- upvalues: getAbilityAction (val), u76 (upval), u74 (upval), u80 (upval)
        local v1

        local function UpdateAbilityInPCS(a1, a2, a3) -- Line: 187; upvalues: u66 (upval), u71 (upval)
            local v1
            local Character = a1.Character

            if not Character then
                return
            end

            if not (if not u66 then
                Character:FindFirstChild(u71)
            else
                Character:FindFirstChildOfClass(u71)) then
                return
            end

            v1:UpdateFields({[a2] = a3})
        end

        local CharacterContext = (if not u62 then a1:WaitForChild("InputContexts", (1 / 0)) else if not a2 then script.Parent.Parent:FindFirstChild("InputContexts") else a1:WaitForChild("InputContexts", (1 / 0))):WaitForChild("CharacterContext")

        for i = 1, 11 do
            v1 = CharacterContext:WaitForChild("AbilityAction" .. (tostring(i)))
            u75[i] = v1

            v1.StateChanged:Connect(function(a1_2)
                -- Line: 208
                -- upvalues: u62 (upval), u73 (upval), i (val), UpdateAbilityInPCS (val), a1 (upval)
                -- upvalues: getAbilityAction (upval)
                if u62 then
                    if u73[i] ~= nil and u73[i] ~= "" then
                        UpdateAbilityInPCS(a1, u73[i], a1_2)
                        return
                    end

                    return
                end

                local v1 = getAbilityAction(u73[i])

                if v1 then
                    local ScriptableBinding = v1:FindFirstChild("ScriptableBinding")

                    if ScriptableBinding then
                        ScriptableBinding:Fire(a1_2)
                    end
                end
            end)
        end

        if u62 then
            local v2

            for j = 1, 3 do
                v2 = CharacterContext:WaitForChild("OverflowAction" .. (tostring(j)))
                u76[j] = v2

                v2.StateChanged:Connect(function(a1_2)
                    -- Line: 229
                    -- upvalues: u74 (upval), j (val), u80 (upval), UpdateAbilityInPCS (val), a1 (upval)
                    local v1 = u74[j + u80]

                    if v1 ~= nil and v1 ~= "" then
                        UpdateAbilityInPCS(a1, v1, a1_2)
                    end
                end)
            end
        end
    end)
end

function u72.GetSlotMapChangedSignal() -- Line: 240; upvalues: BindableEvent (val)
    return BindableEvent.Event
end

function u72.GetSlotMap() -- Line: 244; upvalues: u73 (val)
    return u73
end

function u72.GetAbilitiesInOverflow() -- Line: 248; upvalues: u74 (ref)
    return u74
end

function u72.GetActionInSlot(a1) -- Line: 252; upvalues: u75 (val)
    return u75[a1]
end

function u72.GetOverflowAction(a1) -- Line: 256; upvalues: u76 (val)
    return u76[a1]
end

return u72