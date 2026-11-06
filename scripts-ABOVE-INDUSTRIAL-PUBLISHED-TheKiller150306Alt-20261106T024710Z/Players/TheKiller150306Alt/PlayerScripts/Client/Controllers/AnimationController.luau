-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.AnimationController
-- Decompile time: 6.86 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local AnimationConfig = require(Shared.Config.AnimationConfig)
local Remotes = require(Shared.Remotes)
local u26 = require(script.Parent.TargetController)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u32 = Remotes.get(Remotes.EquippedChanged)
local u33 = nil
local u34 = {}
local u35 = nil
local u36 = nil
local u37 = nil
local u38 = nil
local u39 = 1
local u40 = 0
local u41 = true

local function trackFor(a1) -- Line: 39; upvalues: u33 (ref), u34 (ref); types: a1: string
    local u1 = u33

    if not u1 then
        return nil
    end

    local v1 = u34[a1]

    if v1 then
        return v1
    end

    local Animation = Instance.new("Animation")
    Animation.AnimationId = a1
    local success, err = pcall(function() -- Line: 54; upvalues: u1 (val), Animation (val)
        return u1:LoadAnimation(Animation)
    end)

    if success and err then
        u34[a1] = err
        return err
    end

    warn((("[ABOVE] could not load animation %* - check it is owned by this game's creator"):format(a1)))

    return nil
end

local function stopIdle() -- Line: 66; upvalues: u38 (ref), AnimationConfig (val)
    if u38 then
        u38:Stop(AnimationConfig.IdleFadeSeconds)

        u38 = nil
    end
end

local function playIdle()
    -- Line: 73
    -- upvalues: u38 (ref), AnimationConfig (val), u35 (ref), u41 (ref), trackFor (val)
    if u38 then
        u38:Stop(AnimationConfig.IdleFadeSeconds)

        u38 = nil
    end

    local v1 = u35

    if v1 and v1.idle and u41 then
        local v2 = trackFor(v1.idle)

        if not v2 then
            return
        end

        v2.Looped = true
        v2:Play(AnimationConfig.IdleFadeSeconds)

        u38 = v2
    end
end

local function preload(a1) -- Line: 93; upvalues: trackFor (val)
    if a1.idle then
        trackFor(a1.idle)
    end

    for i, j in a1.swings do
        trackFor(j)
    end
end

local function hitDelayFor(a1, a2, a3) -- Line: 109; upvalues: AnimationConfig (val); types: a2: number, a3: number
    local hitFraction, hitSeconds

    if not a1.hitFrame then
        if not a1.hitSeconds then
            hitFraction = a1.hitFraction or AnimationConfig.HitFraction
            hitSeconds = a3 * hitFraction
        else
            hitSeconds = a1.hitSeconds
        end
    elseif a2 > 0 then
        hitSeconds = (math.min(a1.hitFrame / AnimationConfig.EditorFps, a2)) * (a3 / a2)
    elseif not a1.hitSeconds then
        hitFraction = a1.hitFraction or AnimationConfig.HitFraction
        hitSeconds = a3 * hitFraction
    else
        hitSeconds = a1.hitSeconds
    end

    return (math.min(hitSeconds, AnimationConfig.MaxHitDelaySeconds))
end

local function scheduleHit(a1, a2, a3)
    -- Line: 125
    -- upvalues: AnimationConfig (val)
    -- types: a1: userdata, a2: number, a3: function
    local u4 = os.clock()
    local u5 = false

    local function fire(a1)
        -- Line: 128
        -- upvalues: u5 (ref), AnimationConfig (upval), u4 (val), a3 (val)
        -- types: a1: string
        if u5 then
            return
        end

        u5 = true

        if AnimationConfig.DebugHitTiming then
            print((("[ABOVE] hit via %* at %*s"):format(a1, (string.format("%.3f", (os.clock()) - u4)))))
        end

        a3()
    end

    local u11 = nil

    if not pcall(function()
        -- Line: 140
        -- upvalues: u11 (ref), a1 (val), AnimationConfig (upval), u5 (ref), u4 (val), a3 (val)
        u11 = (a1:GetMarkerReachedSignal(AnimationConfig.HitMarkerName)):Connect(function()
            -- Line: 141
            -- upvalues: u11 (upval), u5 (upval), AnimationConfig (upval), u4 (upval), a3 (upval)
            if u11 then
                u11:Disconnect()
            end

            if not u5 then
                u5 = true

                if AnimationConfig.DebugHitTiming then
                    print((("[ABOVE] hit via marker at %*s"):format((string.format("%.3f", (os.clock()) - u4)))))
                end

                a3()
            end
        end)
    end) then
        u11 = nil
    end

    task.delay(
        a2,
        function() -- Line: 152; upvalues: u11 (ref), u5 (ref), AnimationConfig (upval), u4 (val), a3 (val)
            if u11 then
                u11:Disconnect()
            end

            if u5 then
                return
            end

            u5 = true

            if AnimationConfig.DebugHitTiming then
                print((("[ABOVE] hit via timer at %*s"):format((string.format("%.3f", (os.clock()) - u4)))))
            end

            a3()
        end
    )
end

function v1.swingReady() -- Line: 167; upvalues: u40 (ref)
    local v1 = os.clock()
    return u40 <= v1
end

function v1.playSwing(a1)
    -- Line: 172
    -- upvalues: u35 (ref), u40 (ref), u39 (ref), u36 (ref), u26 (val), trackFor (val), AnimationConfig (val), u38 (ref)
    -- upvalues: u41 (ref), scheduleHit (val)
    -- types: a1: function?
    local u1 = u35
    local v1 = os.clock()

    if v1 < u40 then
        return "Cooldown"
    end

    u40 = v1 + u39

    if u1 and #u1.swings ~= 0 then
        if u36 ~= "Weapon" and not u26.hasToolTarget() then
            return "NoTarget"
        end

        v1 = u1.swings[math.random(#u1.swings)]
        local u24 = trackFor(v1)

        if not u24 then
            return "NoAnimation"
        end

        u24.Priority = AnimationConfig.SwingPriority
        u24.Looped = false

        if u38 then
            u38:Stop(AnimationConfig.IdleFadeSeconds)

            u38 = nil
        end

        local v2 = 1
        local v3 = AnimationConfig.FallbackHitDelaySeconds / AnimationConfig.HitFraction

        if not (0 < u24.Length) or not (u39 > 0) then
            u24:Play(AnimationConfig.SwingFadeSeconds)
        else
            v2 = math.clamp(u24.Length / u39, AnimationConfig.MinSwingSpeed, AnimationConfig.MaxSwingSpeed)
            u24:Play(AnimationConfig.SwingFadeSeconds, 1, v2)

            v3 = u24.Length / v2
        end

        if AnimationConfig.DebugHitTiming then
            print((("[ABOVE] swing %* length=%* "):format(v1, (string.format("%.3f", u24.Length)))) .. (("cooldown=%* speed=%* "):format(string.format("%.3f", u39), (string.format("%.2f", v2)))) .. ("plays for %*s"):format((string.format("%.3f", v3))))
        end

        task.delay(
            v3,
            function()
                -- Line: 234
                -- upvalues: u24 (val), u35 (upval), u1 (val), u38 (upval), AnimationConfig (upval), u41 (upval)
                -- upvalues: trackFor (upval)
                if not u24.IsPlaying and u35 == u1 then
                    if u38 then
                        u38:Stop(AnimationConfig.IdleFadeSeconds)

                        u38 = nil
                    end

                    local v1 = u35

                    if v1 and v1.idle then
                        if not u41 then
                            return
                        end

                        local v2 = trackFor(v1.idle)

                        if not v2 then
                            return
                        end

                        v2.Looped = true
                        v2:Play(AnimationConfig.IdleFadeSeconds)

                        u38 = v2
                    end
                end
            end
        )

        if a1 then
            local hitFraction, hitSeconds
            local Length_2 = u24.Length

            if not u1.hitFrame then
                if not u1.hitSeconds then
                    hitFraction = u1.hitFraction or AnimationConfig.HitFraction
                    hitSeconds = v3 * hitFraction
                else
                    hitSeconds = u1.hitSeconds
                end
            elseif Length_2 > 0 then
                hitSeconds = (math.min(u1.hitFrame / AnimationConfig.EditorFps, Length_2))
                    * (v3 / Length_2)
            elseif not u1.hitSeconds then
                hitFraction = u1.hitFraction or AnimationConfig.HitFraction
                hitSeconds = v3 * hitFraction
            else
                hitSeconds = u1.hitSeconds
            end

            scheduleHit(u24, math.min(hitSeconds, AnimationConfig.MaxHitDelaySeconds), a1)
        end

        return "Scheduled"
    end

    return "NoAnimation"
end

function v1.setToolInHand(a1)
    -- Line: 248
    -- upvalues: u41 (ref), u38 (ref), AnimationConfig (val), u35 (ref), trackFor (val)
    -- types: a1: boolean
    if a1 == u41 then
        return
    end

    if not a1 then
        if u38 then
            u38:Stop(AnimationConfig.IdleFadeSeconds)

            u38 = nil
        end

        return
    end

    if u38 then
        u38:Stop(AnimationConfig.IdleFadeSeconds)

        u38 = nil
    end

    local v1 = u35

    if v1 and v1.idle then
        if not a1 then
            return
        end

        local v2 = trackFor(v1.idle)

        if not v2 then
            return
        end

        v2.Looped = true
        v2:Play(AnimationConfig.IdleFadeSeconds)

        u38 = v2
    end
end

local function bindCharacter(a1)
    -- Line: 260
    -- upvalues: u33 (ref), u34 (ref), u38 (ref), u35 (ref), trackFor (val), AnimationConfig (val), u41 (ref)
    -- types: a1: userdata
    local v1
    local Humanoid = a1:WaitForChild("Humanoid", 10)

    if not Humanoid then
        return
    end

    u33 = Humanoid:WaitForChild("Animator", 10)
    u34 = {}
    u38 = nil

    if u35 then
        v1 = u35

        if v1.idle then
            trackFor(v1.idle)
        end

        for i, j in v1.swings do
            trackFor(j)
        end
    end

    if u38 then
        u38:Stop(AnimationConfig.IdleFadeSeconds)

        u38 = nil
    end

    local v2 = u35

    if v2 and v2.idle then
        if not u41 then
            return
        end

        v1 = trackFor(v2.idle)

        if not v1 then
            return
        end

        v1.Looped = true
        v1:Play(AnimationConfig.IdleFadeSeconds)

        u38 = v1
    end
end

function v1.start()
    -- Line: 275
    -- upvalues: u32 (val), u36 (ref), u37 (ref), u35 (ref), AnimationConfig (val), u39 (ref), u40 (ref), trackFor (val)
    -- upvalues: u38 (ref), u41 (ref), LocalPlayer (val), bindCharacter (val)
    u32.OnClientEvent:Connect(function(a1, a2, a3)
        -- Line: 276
        -- upvalues: u36 (upval), u37 (upval), u35 (upval), AnimationConfig (upval), u39 (upval), u40 (upval)
        -- upvalues: trackFor (upval), u38 (upval), u41 (upval)
        -- types: a1: string, a2: string?, a3: number?
        local v1 = true

        if a1 == u36 then
            v1 = a2 ~= u37
        end

        u35 = AnimationConfig.resolve(a2, a1)
        u36 = a1
        u37 = a2
        u39 = a3 or 1

        if v1 then
            local v2
            u40 = 0

            if u35 then
                v2 = u35

                if v2.idle then
                    trackFor(v2.idle)
                end

                for i, j in v2.swings do
                    trackFor(j)
                end
            end

            if u38 then
                u38:Stop(AnimationConfig.IdleFadeSeconds)

                u38 = nil
            end

            v2 = u35

            if v2 and v2.idle then
                if not u41 then
                    return
                end

                local v3 = trackFor(v2.idle)

                if not v3 then
                    return
                end

                v3.Looped = true
                v3:Play(AnimationConfig.IdleFadeSeconds)

                u38 = v3
            end
        end
    end)

    if LocalPlayer.Character then
        bindCharacter(LocalPlayer.Character)
    end

    LocalPlayer.CharacterAdded:Connect(bindCharacter)
end

return v1