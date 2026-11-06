-- Script path: game:GetService("ReplicatedStorage").Shared.Config.WearableConfig
-- Decompile time: 1.96 ms

local u0 = {PrefabCategory = "Wearables"}

local function torso(a1) -- Line: 69; types: a1: string
    return {part = "Torso", attachment = a1}
end

u0.Slots = {
    {
        id = "Head",
        label = "Head",
        enabled = false,
        mounts = {
            {
                name = "Head",
                r15 = {part = "Head", attachment = "HatAttachment"},
                r6 = {part = "Head", attachment = "HatAttachment"},
            },
        },
    },
    {
        id = "Neck",
        label = "Neck",
        enabled = false,
        mounts = {
            {
                name = "Neck",
                r15 = {part = "UpperTorso", attachment = "NeckAttachment"},
                r6 = {part = "Torso", attachment = "NeckAttachment"},
            },
        },
    },
    {
        id = "Shoulder",
        label = "Shoulder",
        enabled = false,
        mounts = {
            {
                name = "Left",
                r15 = {part = "LeftUpperArm", attachment = "LeftShoulderAttachment"},
                r6 = {part = "Left Arm", attachment = "LeftShoulderAttachment"},
            },
            {
                name = "Right",
                r15 = {part = "RightUpperArm", attachment = "RightShoulderAttachment"},
                r6 = {part = "Right Arm", attachment = "RightShoulderAttachment"},
            },
        },
    },
    {
        id = "Chest",
        label = "Chest",
        enabled = false,
        mounts = {
            {
                name = "Chest",
                r15 = {part = "UpperTorso", attachment = "BodyFrontAttachment"},
                r6 = {part = "Torso", attachment = "BodyFrontAttachment"},
            },
        },
    },
    {
        id = "Back",
        label = "Back",
        enabled = false,
        mounts = {
            {
                name = "Back",
                r15 = {part = "UpperTorso", attachment = "BodyBackAttachment"},
                r6 = {part = "Torso", attachment = "BodyBackAttachment"},
            },
        },
    },
    {
        id = "Waist",
        label = "Waist",
        enabled = true,
        mounts = {
            {
                name = "Waist",
                r15 = {part = "LowerTorso", attachment = "WaistCenterAttachment"},
                r6 = {part = "Torso", attachment = "WaistCenterAttachment"},
            },
        },
    },
    {
        id = "Legs",
        label = "Legs",
        enabled = false,
        mounts = {
            {name = "LeftUpper", r15 = {part = "LeftUpperLeg"}, r6 = {part = "Left Leg"}},
            {name = "LeftLower", r15 = {part = "LeftLowerLeg"}},
            {name = "RightUpper", r15 = {part = "RightUpperLeg"}, r6 = {part = "Right Leg"}},
            {name = "RightLower", r15 = {part = "RightLowerLeg"}},
        },
    },
    {
        id = "Feet",
        label = "Feet",
        enabled = false,
        mounts = {
            {
                name = "Left",
                r15 = {part = "LeftFoot", attachment = "LeftFootAttachment"},
                r6 = {part = "Left Leg", attachment = "LeftFootAttachment"},
            },
            {
                name = "Right",
                r15 = {part = "RightFoot", attachment = "RightFootAttachment"},
                r6 = {part = "Right Leg", attachment = "RightFootAttachment"},
            },
        },
    },
}
u0.Items = {
    Glowlight = {slot = "Waist"},
    CrimsonGlowlight = {slot = "Waist"},
    SunGlowlight = {slot = "Waist"},
    Glowstick = {slot = "Waist"},
}
local u62 = {}

for i, j in u0.Slots do
    u62[j.id] = j
end

function u0.slot(a1) -- Line: 207; upvalues: u62 (val); types: a1: string
    return u62[a1]
end

function u0.isEnabled(a1) -- Line: 212; upvalues: u62 (val); types: a1: string
    local v1 = u62[a1]
    local enabled = false

    if v1 ~= nil then
        enabled = v1.enabled
    end

    return enabled
end

function u0.slotOf(a1) -- Line: 218; upvalues: u0 (val); types: a1: string
    local v1 = u0.Items[a1]

    if v1 then
        return v1.slot
    end

    return nil
end

function u0.mountsFor(a1) -- Line: 224; upvalues: u0 (val), u62 (val); types: a1: string
    local v1 = u0.Items[a1]
    local v2 = if not v1 then nil else u62[v1.slot]

    if v1 and v2 then
        if v1.side == nil then
            return v2.mounts
        end

        local v3 = {}

        for i, j in v2.mounts do
            if j.name == v1.side then
                table.insert(v3, j)
            end
        end

        return v3
    end

    return {}
end

function u0.cframeOf(a1) -- Line: 243; types: a1: table?
    if not a1 then
        return CFrame.identity
    end

    local v1 = a1.rotation or Vector3.new(0, 0, 0)

    return (CFrame.new(a1.offset or Vector3.new(0, 0, 0)))
        * CFrame.Angles(math.rad(v1.X), math.rad(v1.Y), (math.rad(v1.Z)))
end

function u0.offsetFor(a1, a2) -- Line: 254; upvalues: u0 (val), u62 (val); types: a1: string, a2: string
    local v1 = u0.Items[a1]
    local v2 = if not v1 then nil else u62[v1.slot]

    if v1 and v2 then
        local v3 = if not v1.mounts then nil else v1.mounts[a2]
        return (u0.cframeOf(v2.placement)) * u0.cframeOf(v1.placement)
            * u0.cframeOf(v3)
    end

    return CFrame.identity
end

return u0