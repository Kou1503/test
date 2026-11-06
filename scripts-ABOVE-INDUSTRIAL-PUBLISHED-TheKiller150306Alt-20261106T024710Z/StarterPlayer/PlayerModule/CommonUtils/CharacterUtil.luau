-- Script path: game:GetService("StarterPlayer").PlayerModule.CommonUtils.CharacterUtil
-- Decompile time: 1.47 ms

local Players = game:GetService("Players")
local ConnectionUtil = require(script.Parent).get("ConnectionUtil")
local u13 = {}
u13._connectionUtil = ConnectionUtil.new()
u13._boundEvents = {}

function u13.getLocalPlayer() -- Line: 55; upvalues: Players (val)
    return Players.LocalPlayer
end

function u13.onLocalPlayer(a1) -- Line: 59; upvalues: u13 (val), Players (val)
    local v1 = u13.getLocalPlayer()

    if v1 then
        a1(v1)
    end

    u13._connectionUtil:trackConnection(
        "LOCAL_PLAYER",
        ((Players:GetPropertyChangedSignal("LocalPlayer")):Connect(function() -- Line: 68; upvalues: u13 (upval)
            local v1 = u13.getLocalPlayer()
            assert(v1)
            u13._getOrCreateBoundEvent("LOCAL_PLAYER"):Fire(v1)
        end))
    )

    return u13._getOrCreateBoundEvent("LOCAL_PLAYER").Event:Connect(a1)
end

function u13.getCharacter() -- Line: 79; upvalues: u13 (val)
    local v1 = u13.getLocalPlayer()

    if not v1 then
        return nil
    end

    return v1.Character
end

function u13.onCharacter(a1) -- Line: 87; upvalues: u13 (val)
    u13._connectionUtil:trackConnection(
        "ON_LOCAL_PLAYER",
        (u13.onLocalPlayer(function(a1_2) -- Line: 91; upvalues: u13 (upval), a1 (val)
            local v1 = u13.getCharacter()

            if v1 then
                a1(v1)
            end

            u13._connectionUtil:trackConnection(
                "CHARACTER_ADDED",
                (a1_2.CharacterAdded:Connect(function(a1) -- Line: 100; upvalues: u13 (upval)
                    assert(a1)
                    u13._getOrCreateBoundEvent("CHARACTER_ADDED"):Fire(a1)
                end))
            )
        end))
    )
    return u13._getOrCreateBoundEvent("CHARACTER_ADDED").Event:Connect(a1)
end

function u13.getChild(a1, a2) -- Line: 112; upvalues: u13 (val); types: a1: string, a2: string
    local v1 = u13.getCharacter()

    if not v1 then
        return nil
    end

    local v2 = v1:FindFirstChild(a1)

    if v2 and v2:IsA(a2) then
        return v2
    end

    return nil
end

function u13.onChild(a1, a2, a3) -- Line: 124; upvalues: u13 (val); types: a1: string, a2: string
    u13._connectionUtil:trackConnection(
        "ON_CHARACTER",
        (u13.onCharacter(function(a1_2) -- Line: 128; upvalues: u13 (upval), a1 (val), a2 (val), a3 (val)
            local v1 = u13.getChild(a1, a2)

            if v1 then
                a3(v1)
            end

            u13._connectionUtil:trackConnection(
                "CHARACTER_CHILD_ADDED",
                (a1_2.ChildAdded:Connect(function(a1_2) -- Line: 137; upvalues: a1 (upval), a2 (upval), u13 (upval)
                    if a1_2.Name == a1 and a1_2:IsA(a2) then
                        u13._getOrCreateBoundEvent("CHARACTER_CHILD_ADDED" .. a1 .. a2):Fire(a1_2)
                    end
                end))
            )
        end))
    )
    return u13._getOrCreateBoundEvent("CHARACTER_CHILD_ADDED" .. a1 .. a2).Event:Connect(a3)
end

function u13._getOrCreateBoundEvent(a1) -- Line: 151; upvalues: u13 (val); types: a1: string
    if not u13._boundEvents[a1] then
        u13._boundEvents[a1] = (Instance.new("BindableEvent"))
    end

    return u13._boundEvents[a1]
end

return u13