-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.CelebrationController
-- Decompile time: 3.70 ms

local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u35 = require(script.Parent.AudioController)
local v1 = {}
local u37 = nil

local function rgb(a1) -- Line: 26; types: a1: table
    return Color3.fromRGB(a1.r, a1.g, a1.b)
end

local function between(a1, a2) -- Line: 30; types: a1: userdata, a2: table
    return a1:NextNumber(a2.min, a2.max)
end

local function playOn(a1, a2) -- Line: 36; upvalues: Config (val), u35 (val); types: a1: userdata, a2: string
    if a2 == "" then
        return
    end

    local Sound = Instance.new("Sound")
    Sound.SoundId = a2
    Sound.Volume = Config.Celebration.SoundVolume
    Sound.SoundGroup = u35.sfxGroup()
    Sound.Parent = a1

    Sound:Play()
end

local function burst(a1, a2)
    -- Line: 50
    -- upvalues: Config (val), u37 (ref), TweenService (val), u35 (val), Debris (val)
    -- types: a1: vector, a2: userdata
    local Celebration = Config.Celebration
    local Part = Instance.new("Part")
    Part.Name = "Burst"
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1)
    Part.Position = a1
    Part.Parent = u37
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Enabled = false
    ParticleEmitter.Rate = 0
    ParticleEmitter.Color = ColorSequence.new(a2)
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.LightInfluence = 0
    ParticleEmitter.Lifetime = NumberRange.new(Celebration.SparkLifetimeSeconds.min, Celebration.SparkLifetimeSeconds.max)
    ParticleEmitter.Speed = NumberRange.new(Celebration.BurstSpeed.min, Celebration.BurstSpeed.max)
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
    ParticleEmitter.Acceleration = Vector3.new(0, -Celebration.SparkGravity, 0)
    ParticleEmitter.Drag = 1.5
    ParticleEmitter.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, Celebration.SparkSize.start),
        (NumberSequenceKeypoint.new(1, Celebration.SparkSize.finish)),
    })
    ParticleEmitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.7, 0.1),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    ParticleEmitter.Parent = Part

    ParticleEmitter:Emit(Celebration.BurstSparks)

    local PointLight = Instance.new("PointLight")
    PointLight.Color = a2
    PointLight.Brightness = 6
    PointLight.Range = Celebration.FlashRangeStuds
    PointLight.Parent = Part

    TweenService:Create(
        PointLight,
        TweenInfo.new(Celebration.FlashSeconds, Enum.EasingStyle.Quad),
        {Brightness = 0, Range = 0}
    ):Play()

    local BurstSoundId = Celebration.BurstSoundId

    if BurstSoundId ~= "" then
        local v1 = Instance.new("Sound")
        v1.SoundId = BurstSoundId
        v1.Volume = Config.Celebration.SoundVolume
        v1.SoundGroup = u35.sfxGroup()
        v1.Parent = Part

        v1:Play()
    end

    Debris:AddItem(Part, Celebration.SparkLifetimeSeconds.max + 0.5)
end

local function shell(a1, a2, a3)
    -- Line: 105
    -- upvalues: Config (val), u37 (ref), u35 (val), TweenService (val), burst (val), Debris (val)
    -- types: a1: userdata, a2: vector, a3: userdata
    local Celebration = Config.Celebration
    local v1 = a1:NextNumber(0, 6.283185307179586)
    local v2 = a1:NextNumber(0, Celebration.SpreadStuds)
    local v3 = a2 + Vector3.new(math.cos(v1) * v2, 0, (math.sin(v1)) * v2)
    local HeightStuds = Celebration.HeightStuds
    v2 = a1:NextNumber(HeightStuds.min, HeightStuds.max)
    local v4 = Vector3.new(a1:NextNumber(-8, 8), 0, (a1:NextNumber(-8, 8)))
    local u54 = v3 + Vector3.new(0, v2, 0) + v4
    local RiseSeconds = Celebration.RiseSeconds
    v2 = a1:NextNumber(RiseSeconds.min, RiseSeconds.max)
    local u65 = Instance.new("Part")
    u65.Name = "Shell"
    u65.Anchored = true
    u65.CanCollide = false
    u65.CanQuery = false
    u65.CanTouch = false
    u65.Shape = Enum.PartType.Ball
    u65.Material = Enum.Material.Neon
    u65.Color = a3
    u65.Size = Vector3.new(0.6000000238418579, 0.6000000238418579, 0.6000000238418579)
    u65.Position = v3
    u65.Parent = u37
    local u78 = Instance.new("ParticleEmitter")
    u78.Color = ColorSequence.new(a3)
    u78.LightEmission = 1
    u78.LightInfluence = 0
    u78.Rate = 60
    u78.Lifetime = NumberRange.new(0.35, 0.6)
    u78.Speed = NumberRange.new(0)
    u78.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), (NumberSequenceKeypoint.new(1, 0))})
    u78.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), (NumberSequenceKeypoint.new(1, 1))})
    u78.Parent = u65
    local LaunchSoundId = Celebration.LaunchSoundId

    if LaunchSoundId ~= "" then
        local Sound = Instance.new("Sound")
        Sound.SoundId = LaunchSoundId
        Sound.Volume = Config.Celebration.SoundVolume
        Sound.SoundGroup = u35.sfxGroup()
        Sound.Parent = u65

        Sound:Play()
    end

    local v5 = TweenService:Create(
        u65,
        TweenInfo.new(v2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = u54}
    )
    v5.Completed:Once(function()
        -- Line: 154
        -- upvalues: burst (upval), u54 (val), a3 (val), u65 (val), u78 (val), Debris (upval)
        burst(u54, a3)

        u65.Transparency = 1
        u78.Enabled = false

        Debris:AddItem(u65, 1)
    end)

    v5:Play()
end

local function display(a1, a2)
    -- Line: 164
    -- upvalues: Config (val), shell (val), between (val)
    -- types: a1: vector, a2: number
    local v1
    local Celebration = Config.Celebration
    local v2 = Random.new(a2)
    local Colors = Celebration.Colors
    local v3 = Celebration.Shells - Celebration.FinaleShells + 1

    for i = 1, Celebration.Shells do
        v1 = Colors[v2:NextInteger(1, #Colors)]
        shell(v2, a1, (Color3.fromRGB(v1.r, v1.g, v1.b)))

        if i < v3 then
            task.wait(between(v2, Celebration.LaunchGapSeconds))
        elseif i < Celebration.Shells then
            task.wait(Celebration.FinaleGapSeconds)
        end
    end
end

function v1.start() -- Line: 181; upvalues: u37 (ref), Workspace (val), Remotes (val), Config (val), display (val)
    u37 = Instance.new("Folder")
    u37.Name = "Celebrations"
    u37.Parent = Workspace

    ;(Remotes.get(Remotes.Celebration)).OnClientEvent:Connect(function(a1, a2)
        -- Line: 186
        -- upvalues: Workspace (upval), Config (upval), display (upval)
        if typeof(a1) == "Vector3" and type(a2) == "number" then
            local CurrentCamera = Workspace.CurrentCamera
            local Magnitude = ((if not CurrentCamera then a1 else CurrentCamera.CFrame.Position) - a1).Magnitude

            if Config.Celebration.VisibleStuds < Magnitude then
                return
            end

            task.spawn(display, a1, a2)
        end
    end)
end

return v1