-- Script path: game:GetService("Workspace").Hub.NPC.BlockDealer.Animate
-- Decompile time: 13.82 ms

local v1
local Parent = script.Parent
local Humanoid = Parent:WaitForChild("Humanoid")
local u6 = "Standing"
local success, err = pcall(function() -- Line: 7
    return UserSettings():IsUserFeatureEnabled("UserNoUpdateOnLoop")
end)
local u11 = success and err
local success_2, err_2 = pcall(function() -- Line: 10
    return UserSettings():IsUserFeatureEnabled("UserAnimateScaleRun")
end)
local u16 = success_2 and err_2

local function getRigScale() -- Line: 13; upvalues: u16 (val), Parent (val)
    if u16 then
        return Parent:GetScale()
    end

    return 1
end

local ScaleDampeningPercent = script:FindFirstChild("ScaleDampeningPercent")
local u23 = ""
local u24 = nil
local u25 = nil
local u26 = nil
local u27 = 1
local u28 = nil
local u29 = nil
local u30 = {}
local u31 = {}
local u32 = {
    idle = {
        {id = "http://www.roblox.com/asset/?id=507766666", weight = 1},
        {id = "http://www.roblox.com/asset/?id=507766951", weight = 1},
        {id = "http://www.roblox.com/asset/?id=507766388", weight = 9},
    },
    walk = {{id = "http://www.roblox.com/asset/?id=507777826", weight = 10}},
    run = {{id = "http://www.roblox.com/asset/?id=507767714", weight = 10}},
    swim = {{id = "http://www.roblox.com/asset/?id=507784897", weight = 10}},
    swimidle = {{id = "http://www.roblox.com/asset/?id=507785072", weight = 10}},
    jump = {{id = "http://www.roblox.com/asset/?id=507765000", weight = 10}},
    fall = {{id = "http://www.roblox.com/asset/?id=507767968", weight = 10}},
    climb = {{id = "http://www.roblox.com/asset/?id=507765644", weight = 10}},
    sit = {{id = "http://www.roblox.com/asset/?id=2506281703", weight = 10}},
    toolnone = {{id = "http://www.roblox.com/asset/?id=507768375", weight = 10}},
    toolslash = {{id = "http://www.roblox.com/asset/?id=522635514", weight = 10}},
    toollunge = {{id = "http://www.roblox.com/asset/?id=522638767", weight = 10}},
    wave = {{id = "http://www.roblox.com/asset/?id=507770239", weight = 10}},
    point = {{id = "http://www.roblox.com/asset/?id=507770453", weight = 10}},
    dance = {
        {id = "http://www.roblox.com/asset/?id=507771019", weight = 10},
        {id = "http://www.roblox.com/asset/?id=507771955", weight = 10},
        {id = "http://www.roblox.com/asset/?id=507772104", weight = 10},
    },
    dance2 = {
        {id = "http://www.roblox.com/asset/?id=507776043", weight = 10},
        {id = "http://www.roblox.com/asset/?id=507776720", weight = 10},
        {id = "http://www.roblox.com/asset/?id=507776879", weight = 10},
    },
    dance3 = {
        {id = "http://www.roblox.com/asset/?id=507777268", weight = 10},
        {id = "http://www.roblox.com/asset/?id=507777451", weight = 10},
        {id = "http://www.roblox.com/asset/?id=507777623", weight = 10},
    },
    laugh = {{id = "http://www.roblox.com/asset/?id=507770818", weight = 10}},
    cheer = {{id = "http://www.roblox.com/asset/?id=507770677", weight = 10}},
}
local u79 = {
    wave = false,
    point = false,
    dance = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false,
}

math.randomseed(tick())

function findExistingAnimationInSet(a1, a2) -- Line: 111
    if a1 ~= nil and a2 ~= nil then
        local count = a1.count

        for i = 1, count do
            if a1[i].anim.AnimationId == a2.AnimationId then
                return i
            end
        end

        return 0
    end

    return 0
end

function configureAnimationSet(a1, a2) -- Line: 125; upvalues: u31 (val), u30 (val), Humanoid (val)
    local count_2

    if u31[a1] ~= nil then
        for k, v in pairs(u31[a1].connections) do
            v:disconnect()
        end
    end

    u31[a1] = {}
    local v1 = u31[a1]
    v1.count = 0
    v1 = u31[a1]
    v1.totalWeight = 0
    v1 = u31[a1]
    v1.connections = {}
    local u39 = true

    if not (pcall(function() -- Line: 138; upvalues: u39 (ref)
        u39 = game:GetService("StarterPlayer").AllowCustomAnimations
    end)) then
        u39 = true
    end

    local v2 = script:FindFirstChild(a1)

    if u39 and v2 ~= nil then
        local Value, Weight, count, v3
        table.insert(
            u31[a1].connections,
            (v2.ChildAdded:connect(function(a1_2) -- Line: 146; upvalues: a1 (val), a2 (val)
                configureAnimationSet(a1, a2)
            end))
        )

        table.insert(
            u31[a1].connections,
            (v2.ChildRemoved:connect(function(a1_2) -- Line: 147; upvalues: a1 (val), a2 (val)
                configureAnimationSet(a1, a2)
            end))
        )

        for k2, i in pairs(v2:GetChildren()) do
            if i:IsA("Animation") then
                Value = 1
                Weight = i:FindFirstChild("Weight")

                if Weight ~= nil then
                    Value = Weight.Value
                end

                v3 = u31[a1]
                v3.count = u31[a1].count + 1
                count = u31[a1].count
                v3 = u31[a1]
                v3[count] = {}
                u31[a1][count].anim = i
                u31[a1][count].weight = Value
                v3 = u31[a1]
                v3.totalWeight = u31[a1].totalWeight + u31[a1][count].weight

                table.insert(
                    u31[a1].connections,
                    (i.Changed:connect(function(a1_2) -- Line: 163; upvalues: a1 (val), a2 (val)
                        configureAnimationSet(a1, a2)
                    end))
                )

                table.insert(
                    u31[a1].connections,
                    (i.ChildAdded:connect(function(a1_2) -- Line: 164; upvalues: a1 (val), a2 (val)
                        configureAnimationSet(a1, a2)
                    end))
                )

                table.insert(
                    u31[a1].connections,
                    (i.ChildRemoved:connect(function(a1_2) -- Line: 165; upvalues: a1 (val), a2 (val)
                        configureAnimationSet(a1, a2)
                    end))
                )
            end
        end
    end

    if u31[a1].count <= 0 then
        local v4

        for k3, j in pairs(a2) do
            v4 = u31[a1]
            v4[k3] = {}
            v4 = u31[a1][k3]
            v4.anim = Instance.new("Animation")
            u31[a1][k3].anim.Name = a1
            u31[a1][k3].anim.AnimationId = j.id
            v4 = u31[a1][k3]
            v4.weight = j.weight
            v4 = u31[a1]
            v4.count = u31[a1].count + 1
            v4 = u31[a1]
            v4.totalWeight = u31[a1].totalWeight + j.weight
        end
    end

    for k4, k5 in pairs(u31) do
        count_2 = k5.count

        for n = 1, count_2 do
            if u30[k5[n].anim.AnimationId] == nil then
                Humanoid:LoadAnimation(k5[n].anim)

                u30[k5[n].anim.AnimationId] = true
            end
        end
    end
end

function configureAnimationSetOld(a1, a2) -- Line: 196; upvalues: u31 (val), Humanoid (val)
    local count, v1

    if u31[a1] ~= nil then
        for k, v in pairs(u31[a1].connections) do
            v:disconnect()
        end
    end

    u31[a1] = {}
    local v2 = u31[a1]
    v2.count = 0
    v2 = u31[a1]
    v2.totalWeight = 0
    v2 = u31[a1]
    v2.connections = {}
    local u39 = true

    if not (pcall(function() -- Line: 209; upvalues: u39 (ref)
        u39 = game:GetService("StarterPlayer").AllowCustomAnimations
    end)) then
        u39 = true
    end

    local v3 = script:FindFirstChild(a1)

    if u39 and v3 ~= nil then
        local Weight, v4
        table.insert(
            u31[a1].connections,
            (v3.ChildAdded:connect(function(a1_2) -- Line: 217; upvalues: a1 (val), a2 (val)
                configureAnimationSet(a1, a2)
            end))
        )

        table.insert(
            u31[a1].connections,
            (v3.ChildRemoved:connect(function(a1_2) -- Line: 218; upvalues: a1 (val), a2 (val)
                configureAnimationSet(a1, a2)
            end))
        )

        local v5 = 1

        for k2, i in pairs(v3:GetChildren()) do
            if i:IsA("Animation") then
                table.insert(
                    u31[a1].connections,
                    (i.Changed:connect(function(a1_2) -- Line: 222; upvalues: a1 (val), a2 (val)
                        configureAnimationSet(a1, a2)
                    end))
                )

                v1 = u31[a1]
                v1[v5] = {}
                u31[a1][v5].anim = i
                Weight = i:FindFirstChild("Weight")

                if Weight ~= nil then
                    v4 = u31[a1][v5]
                    v4.weight = Weight.Value
                else
                    v4 = u31[a1][v5]
                    v4.weight = 1
                end

                v4 = u31[a1]
                v4.count = u31[a1].count + 1
                v4 = u31[a1]
                v4.totalWeight = u31[a1].totalWeight + u31[a1][v5].weight
                v5 = v5 + 1
            end
        end
    end

    if u31[a1].count <= 0 then
        for k3, j in pairs(a2) do
            v1 = u31[a1]
            v1[k3] = {}
            v1 = u31[a1][k3]
            v1.anim = Instance.new("Animation")
            u31[a1][k3].anim.Name = a1
            u31[a1][k3].anim.AnimationId = j.id
            v1 = u31[a1][k3]
            v1.weight = j.weight
            v1 = u31[a1]
            v1.count = u31[a1].count + 1
            v1 = u31[a1]
            v1.totalWeight = u31[a1].totalWeight + j.weight
        end
    end

    for k4, k5 in pairs(u31) do
        count = k5.count

        for n = 1, count do
            Humanoid:LoadAnimation(k5[n].anim)
        end
    end
end

function scriptChildModified(a1) -- Line: 261; upvalues: u32 (val)
    local v1 = u32[a1.Name]

    if v1 ~= nil then
        configureAnimationSet(a1.Name, v1)
    end
end

script.ChildAdded:connect(scriptChildModified)
script.ChildRemoved:connect(scriptChildModified)

local Animator = if not Humanoid then nil else Humanoid:FindFirstChildOfClass("Animator")

if Animator then
    for i, v in ipairs((Animator:GetPlayingAnimationTracks())) do
        v:Stop(0)
        v:Destroy()
    end
end

for k, i2 in pairs(u32) do
    configureAnimationSet(k, i2)
end

local u143 = "None"
local u144 = 0
local u145 = 0
local u146 = false

function stopAllAnimations()
    -- Line: 302
    -- upvalues: u23 (ref), u79 (val), u146 (ref), u24 (ref), u26 (ref), u25 (ref), u29 (ref), u28 (ref)
    local v1 = u23

    if u79[v1] ~= nil and u79[v1] == false then
        v1 = "idle"
    end

    if u146 then
        v1 = "idle"
        u146 = false
    end

    u23 = ""
    u24 = nil

    if u26 ~= nil then
        u26:disconnect()
    end

    if u25 ~= nil then
        u25:Stop()
        u25:Destroy()

        u25 = nil
    end

    if u29 ~= nil then
        u29:disconnect()
    end

    if u28 ~= nil then
        u28:Stop()
        u28:Destroy()

        u28 = nil
    end

    return v1
end

function getHeightScale() -- Line: 341; upvalues: Humanoid (val), getRigScale (val), ScaleDampeningPercent (ref)
    if not Humanoid or not Humanoid.AutomaticScalingEnabled then
        return getRigScale()
    end

    local v1 = Humanoid.HipHeight / 2

    if ScaleDampeningPercent == nil then
        ScaleDampeningPercent = script:FindFirstChild("ScaleDampeningPercent")
    end

    if ScaleDampeningPercent ~= nil then
        v1 = 1 + (Humanoid.HipHeight - 2) * ScaleDampeningPercent.Value / 2
    end

    return v1
end

local function rootMotionCompensation(a1) -- Line: 361
    return a1 * 1.25 / getHeightScale()
end

local function setRunSpeed(a1) -- Line: 369; upvalues: u25 (ref), u28 (ref)
    local v1 = a1 * 1.25 / getHeightScale()
    local v2 = 0.0001
    local v3 = 0.0001
    local v4 = v1 / 0.5
    local v5 = v1 / 1

    if v1 <= 0.5 then
        v2 = 1
    elseif not (v1 < 1) then
        v3 = 1
    else
        local v6 = (v1 - 0.5) / 0.5
        v2 = 1 - v6
        v3 = v6
        v4 = 1
        v5 = 1
    end

    u25:AdjustWeight(v2)
    u28:AdjustWeight(v3)
    u25:AdjustSpeed(v4)
    u28:AdjustSpeed(v5)
end

function setAnimationSpeed(a1) -- Line: 396; upvalues: u23 (ref), setRunSpeed (val), u27 (ref), u25 (ref)
    if u23 == "walk" then
        setRunSpeed(a1)
        return
    end

    if a1 ~= u27 then
        u25:AdjustSpeed(a1)
    end
end

function keyFrameReachedFunc(a1)
    -- Line: 407
    -- upvalues: u23 (ref), u11 (val), u28 (ref), u25 (ref), u79 (val), u146 (ref), u27 (ref), Humanoid (val)
    if a1 == "End" then
        if u23 ~= "walk" then
            local v1 = u23

            if u79[v1] ~= nil and u79[v1] == false then
                v1 = "idle"
            end

            if u146 then
                if u25.Looped then
                    return
                end

                v1 = "idle"
                u146 = false
            end

            local v2 = u27
            playAnimation(v1, 0.15, Humanoid)
            setAnimationSpeed(v2)
        elseif u11 ~= true then
            u28.TimePosition = 0
            u25.TimePosition = 0
        else
            if u28.Looped ~= true then
                u28.TimePosition = 0
            end

            if u25.Looped ~= true then
                u25.TimePosition = 0
            end
        end
    end
end

function rollAnimation(a1) -- Line: 445; upvalues: u31 (val)
    local v1 = math.random(1, u31[a1].totalWeight)
    local v2 = 1

    while u31[a1][v2].weight < v1 do
        v1 = v1 - u31[a1][v2].weight
        v2 = v2 + 1
    end

    return v2
end

local function switchToAnim(a1, a2, a3, a4)
    -- Line: 456
    -- upvalues: u24 (ref), u25 (ref), u28 (ref), u11 (val), u27 (ref), u23 (ref), u26 (ref), u31 (val), u29 (ref)
    if a1 ~= u24 then
        if u25 ~= nil then
            u25:Stop(a3)
            u25:Destroy()
        end

        if u28 ~= nil then
            u28:Stop(a3)
            u28:Destroy()

            if u11 == true then
                u28 = nil
            end
        end

        u27 = 1
        u25 = a4:LoadAnimation(a1)
        u25.Priority = Enum.AnimationPriority.Core

        u25:Play(a3)

        u23 = a2
        u24 = a1

        if u26 ~= nil then
            u26:disconnect()
        end

        u26 = u25.KeyframeReached:connect(keyFrameReachedFunc)

        if a2 == "walk" then
            u28 = a4:LoadAnimation(u31.run[(rollAnimation("run"))].anim)
            u28.Priority = Enum.AnimationPriority.Core

            u28:Play(a3)

            if u29 ~= nil then
                u29:disconnect()
            end

            u29 = u28.KeyframeReached:connect(keyFrameReachedFunc)
        end
    end
end

function playAnimation(a1, a2, a3) -- Line: 507; upvalues: u31 (val), switchToAnim (val), u146 (ref)
    local v1 = rollAnimation(a1)
    switchToAnim(u31[a1][v1].anim, a1, a2, a3)

    u146 = false
end

function playEmote(a1, a2, a3) -- Line: 515; upvalues: switchToAnim (val), u146 (ref)
    switchToAnim(a1, a1.Name, a2, a3)

    u146 = true
end

local u170 = ""
local u171 = nil
local u172 = nil
local u173 = nil

function toolKeyFrameReachedFunc(a1) -- Line: 528; upvalues: u170 (ref), Humanoid (val)
    if a1 == "End" then
        playToolAnimation(u170, 0, Humanoid)
    end
end

function playToolAnimation(a1, a2, a3, a4)
    -- Line: 535
    -- upvalues: u31 (val), u172 (ref), u171 (ref), u170 (ref), u173 (ref)
    local v1 = rollAnimation(a1)
    local anim = u31[a1][v1].anim

    if u172 ~= anim then
        if u171 ~= nil then
            u171:Stop()
            u171:Destroy()

            a2 = 0
        end

        u171 = a3:LoadAnimation(anim)

        if a4 then
            u171.Priority = a4
        end

        u171:Play(a2)

        u170 = a1
        u172 = anim
        u173 = u171.KeyframeReached:connect(toolKeyFrameReachedFunc)
    end
end

function stopToolAnimations() -- Line: 562; upvalues: u170 (ref), u173 (ref), u172 (ref), u171 (ref)
    local v1 = u170

    if u173 ~= nil then
        u173:disconnect()
    end

    u170 = ""
    u172 = nil

    if u171 ~= nil then
        u171:Stop()
        u171:Destroy()

        u171 = nil
    end

    return v1
end

function onRunning(a1) -- Line: 584; upvalues: u16 (val), u146 (ref), Humanoid (val), u6 (ref), u79 (val), u23 (ref)
    local v1 = if not u16 then 1 else getHeightScale()

    if (u146 and Humanoid.MoveDirection == Vector3.new(0, 0, 0)
        and Humanoid.WalkSpeed / v1
        or 0.75)
        * v1
        < a1 then
        playAnimation("walk", 0.2, Humanoid)
        setAnimationSpeed(a1 / 16)

        u6 = "Running"

        return
    end

    if u79[u23] == nil and not u146 then
        playAnimation("idle", 0.2, Humanoid)

        u6 = "Standing"
    end
end

function onDied() -- Line: 602; upvalues: u6 (ref)
    u6 = "Dead"
end

function onJumping() -- Line: 606; upvalues: Humanoid (val), u145 (ref), u6 (ref)
    playAnimation("jump", 0.1, Humanoid)

    u145 = 0.31
    u6 = "Jumping"
end

function onClimbing(a1) -- Line: 612; upvalues: u16 (val), Humanoid (val), u6 (ref)
    if u16 then
        a1 = a1 / getHeightScale()
    end

    playAnimation("climb", 0.1, Humanoid)
    setAnimationSpeed(a1 / 5)

    u6 = "Climbing"
end

function onGettingUp() -- Line: 622; upvalues: u6 (ref)
    u6 = "GettingUp"
end

function onFreeFall() -- Line: 626; upvalues: u145 (ref), Humanoid (val), u6 (ref)
    if u145 <= 0 then
        playAnimation("fall", 0.2, Humanoid)
    end

    u6 = "FreeFall"
end

function onFallingDown() -- Line: 633; upvalues: u6 (ref)
    u6 = "FallingDown"
end

function onSeated() -- Line: 637; upvalues: u6 (ref)
    u6 = "Seated"
end

function onPlatformStanding() -- Line: 641; upvalues: u6 (ref)
    u6 = "PlatformStanding"
end

function onSwimming(a1) -- Line: 648; upvalues: u16 (val), Humanoid (val), u6 (ref)
    if u16 then
        a1 = a1 / getHeightScale()
    end

    if not (a1 > 1) then
        playAnimation("swimidle", 0.4, Humanoid)

        u6 = "Standing"

        return
    end

    playAnimation("swim", 0.4, Humanoid)
    setAnimationSpeed(a1 / 10)

    u6 = "Swimming"
end

function animateTool() -- Line: 663; upvalues: u143 (ref), Humanoid (val)
    if u143 == "None" then
        playToolAnimation("toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle)
        return
    end

    if u143 == "Slash" then
        playToolAnimation("toolslash", 0, Humanoid, Enum.AnimationPriority.Action)
        return
    end

    if u143 ~= "Lunge" then
        return
    end

    playToolAnimation("toollunge", 0, Humanoid, Enum.AnimationPriority.Action)
end

function getToolAnim(a1) -- Line: 680
    for i, v in ipairs(a1:GetChildren()) do
        if v.Name == "toolanim" and v.className == "StringValue" then
            return v
        end
    end

    return nil
end

local u191 = 0

function stepAnimate(a1)
    -- Line: 691
    -- upvalues: u191 (ref), u145 (ref), u6 (ref), Humanoid (val), Parent (val), u143 (ref), u144 (ref), u172 (ref)
    local Tool
    local v1 = a1 - u191
    u191 = a1

    if u145 > 0 then
        u145 = u145 - v1
    end

    if u6 == "FreeFall" and u145 <= 0 then
        playAnimation("fall", 0.2, Humanoid)

        Tool = Parent:FindFirstChildOfClass("Tool")

        if Tool and Tool:FindFirstChild("Handle") then
            v1 = getToolAnim(Tool)

            if v1 then
                u143 = v1.Value
                v1.Parent = nil
                u144 = a1 + 0.3
            end

            if u144 < a1 then
                u144 = 0
                u143 = "None"
            end

            animateTool()

            return
        end

        stopToolAnimations()

        u143 = "None"
        u172 = nil
        u144 = 0

        return
    end

    if u6 == "Seated" then
        playAnimation("sit", 0.5, Humanoid)
        return
    end

    if u6 == "Running" then
        playAnimation("walk", 0.2, Humanoid)
    elseif u6 == "Dead"
        or u6 == "GettingUp"
        or u6 == "FallingDown"
        or u6 == "Seated"
        or u6 == "PlatformStanding" then
        stopAllAnimations()
    end

    Tool = Parent:FindFirstChildOfClass("Tool")

    if Tool and Tool:FindFirstChild("Handle") then
        v1 = getToolAnim(Tool)

        if v1 then
            u143 = v1.Value
            v1.Parent = nil
            u144 = a1 + 0.3
        end

        if u144 < a1 then
            u144 = 0
            u143 = "None"
        end

        animateTool()

        return
    end

    stopToolAnimations()

    u143 = "None"
    u172 = nil
    u144 = 0
end

Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping)
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.Seated:connect(onSeated)
Humanoid.PlatformStanding:connect(onPlatformStanding)
Humanoid.Swimming:connect(onSwimming)

;(game:GetService("Players")).LocalPlayer.Chatted:connect(function(a1)
    -- Line: 757
    -- upvalues: u6 (ref), u79 (val), Humanoid (val)
    local v1 = ""

    if string.sub(a1, 1, 3) == "/e " then
        v1 = string.sub(a1, 4)
    elseif string.sub(a1, 1, 7) == "/emote " then
        v1 = string.sub(a1, 8)
    end

    if u6 == "Standing" and u79[v1] ~= nil then
        playAnimation(v1, 0.1, Humanoid)
    end
end)

local PlayEmote = script:WaitForChild("PlayEmote")

function PlayEmote.OnInvoke(a1) -- Line: 771; upvalues: u6 (ref), u79 (val), Humanoid (val), u25 (ref)
    if u6 ~= "Standing" then
        return
    end

    if u79[a1] ~= nil then
        playAnimation(a1, 0.1, Humanoid)
        return true, u25
    end

    if typeof(a1) == "Instance" and a1:IsA("Animation") then
        playEmote(a1, 0.1, Humanoid)
        return true, u25
    end

    return false
end

if Parent.Parent ~= nil then
    playAnimation("idle", 0.1, Humanoid)

    u6 = "Standing"
end

while Parent.Parent ~= nil do
    _, v1 = wait(0.1)
    stepAnimate(v1)
end