-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.WeatherFxController
-- Decompile time: 8.22 ms

local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Config = require(Shared.Config)
local u37 = require(script.Parent.AmbienceController)
local Aim = require(script.Parent.Aim)
local NewPlayerView = require(script.Parent.NewPlayerView)
local v1 = {}
local u49 = nil
local u50 = nil
local u51 = nil
local u52 = nil
local u53 = nil
local u54 = nil
local u55 = nil
local Players = game:GetService("Players")
local u61 = {}
local u62 = 1
local u64 = RaycastParams.new()
local u66 = RaycastParams.new()
u66.FilterType = Enum.RaycastFilterType.Exclude
local u68 = false

local function rgb(a1) -- Line: 57; types: a1: table
    return Color3.fromRGB(a1.r, a1.g, a1.b)
end

local function tweenInfo() -- Line: 61; upvalues: Config (val)
    return TweenInfo.new(Config.Appearance.Weather.TransitionSeconds, Enum.EasingStyle.Sine)
end

local function ensureClouds() -- Line: 65; upvalues: Workspace (val)
    local Terrain = Workspace:FindFirstChildOfClass("Terrain")

    if not Terrain then
        return nil
    end

    local Clouds = Terrain:FindFirstChildOfClass("Clouds")

    if Clouds then
        return Clouds
    end

    local Clouds_2 = Instance.new("Clouds")
    Clouds_2.Parent = Terrain

    return Clouds_2
end

local function apply(a1)
    -- Line: 79
    -- upvalues: Config (val), u68 (ref), u54 (ref), Workspace (val), TweenService (val), u50 (ref), Aim (val)
    -- upvalues: u52 (ref), Lighting (val), u55 (ref), u53 (ref)
    -- types: a1: string
    local Weather = Config.Appearance.Weather
    u68 = a1 == "Rain"
    local Clear = Weather.Clouds[a1] or Weather.Clouds.Clear
    local v1 = u54

    if not v1 then
        local Terrain = Workspace:FindFirstChildOfClass("Terrain")

        if Terrain then
            local Clouds = Terrain:FindFirstChildOfClass("Clouds")

            if not Clouds then
                local Clouds_2 = Instance.new("Clouds")
                Clouds_2.Parent = Terrain
                v1 = Clouds_2
            else
                v1 = Clouds
            end
        else
            v1 = nil
        end
    end

    u54 = v1

    if u54 then
        u54.Enabled = true
        local v2 = u54
        local v3 = TweenInfo.new(Config.Appearance.Weather.TransitionSeconds, Enum.EasingStyle.Sine)
        local v4 = {Cover = Clear.cover, Density = Clear.density}
        local color = Clear.color
        v4.Color = Color3.fromRGB(color.r, color.g, color.b)

        TweenService:Create(v2, v3, v4):Play()
    end

    u50.Enabled = u68
    v1 = u50
    local TouchRate = if not Aim.isTouch() then
        Weather.Rain.Rate
    else
        Weather.Rain.TouchRate
    v1.Rate = TouchRate
    local v5 = a1 == "Windy"
    u52.Enabled = v5
    v1 = u52
    local TouchRate_2 = if not Aim.isTouch() then
        Weather.Wind.Rate
    else
        Weather.Wind.TouchRate
    v1.Rate = TouchRate_2
    local Clear_2 = Weather.Sun[a1] or Weather.Sun.Clear
    local Sky = Lighting:FindFirstChildOfClass("Sky")

    if Sky then
        TweenService:Create(
            Sky,
            TweenInfo.new(Config.Appearance.Weather.TransitionSeconds, Enum.EasingStyle.Sine),
            {SunAngularSize = Clear_2.angularSize}
        ):Play()
    end

    u55.Enabled = true
    v1 = TweenService:Create(
        u55,
        TweenInfo.new(Config.Appearance.Weather.TransitionSeconds, Enum.EasingStyle.Sine),
        {Intensity = Clear_2.rays, Spread = Clear_2.spread}
    )

    v1.Completed:Connect(function() -- Line: 111; upvalues: u55 (upval)
        if u55.Intensity <= 0.001 then
            u55.Enabled = false
        end
    end)

    v1:Play()

    local u156 = Weather.Grade[a1]

    if not u156 then
        v5 = {Saturation = 0, Contrast = 0, Brightness = 0, TintColor = Color3.new(1, 1, 1)}
    else
        v5 = {
            Saturation = u156.Saturation,
            Contrast = u156.Contrast,
            Brightness = u156.Brightness,
        }
        local Tint = u156.Tint
        v5.TintColor = Color3.fromRGB(Tint.r, Tint.g, Tint.b)
    end

    u53.Enabled = true
    local v6 = TweenService:Create(u53, TweenInfo.new(Config.Appearance.Weather.TransitionSeconds, Enum.EasingStyle.Sine), v5)

    v6.Completed:Connect(function() -- Line: 129; upvalues: u156 (val), u53 (upval)
        if not u156 and u53.Saturation == 0 then
            u53.Enabled = false
        end
    end)

    v6:Play()
end

local function makeSplashPool(a1) -- Line: 138; upvalues: Config (val), rgb (val), u61 (val); types: a1: userdata
    local Part, ParticleEmitter
    local Splashes = Config.Appearance.Weather.Splashes
    local PoolSize = Splashes.PoolSize

    for i = 1, PoolSize do
        Part = Instance.new("Part")
        Part.Name = "Splash"
        Part.Size = Vector3.new(1, 1, 1)
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanQuery = false
        Part.CanTouch = false
        Part.CastShadow = false
        Part.Transparency = 1
        Part.Parent = a1
        ParticleEmitter = Instance.new("ParticleEmitter")
        ParticleEmitter.Enabled = false
        ParticleEmitter.Rate = 0
        ParticleEmitter.Lifetime = NumberRange.new(Splashes.LifetimeSeconds)
        ParticleEmitter.EmissionDirection = Enum.NormalId.Top
        ParticleEmitter.SpreadAngle = Vector2.zero
        ParticleEmitter.Speed = NumberRange.new(Splashes.RiseStudsPerSecond)
        ParticleEmitter.Acceleration = Vector3.new(0, 0, 0)
        ParticleEmitter.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
        ParticleEmitter.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, Splashes.StartSize),
            (NumberSequenceKeypoint.new(1, Splashes.EndSize)),
        })
        ParticleEmitter.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, Splashes.Transparency),
            (NumberSequenceKeypoint.new(1, 1)),
        })
        ParticleEmitter.Color = ColorSequence.new(rgb(Splashes.Color))
        ParticleEmitter.LightEmission = 0.3
        ParticleEmitter.Parent = Part

        table.insert(
            u61,
            {part = Part, emitter = ParticleEmitter}
        )
    end
end

local function shelteredAt(a1)
    -- Line: 188
    -- upvalues: u37 (val), Workspace (val), Players (val), u66 (val), Config (val)
    -- types: a1: vector
    if u37.inCave(a1) then
        return true
    end

    local CurrentCamera = Workspace.CurrentCamera
    local Character = Players.LocalPlayer.Character
    u66.FilterDescendantsInstances = if not Character then
        if not CurrentCamera then {} else {CurrentCamera}
    else
        if CurrentCamera then
            {CurrentCamera, Character}
        else
            if not CurrentCamera then {} else {CurrentCamera}

    return Workspace:Raycast(a1, Vector3.new(0, Config.Appearance.Weather.Rain.CoverStuds, 0), u66)
        ~= nil
end

local function splash(a1)
    -- Line: 201
    -- upvalues: Config (val), Aim (val), Players (val), u64 (val), Workspace (val), shelteredAt (val), u61 (val)
    -- upvalues: u62 (ref)
    -- types: a1: userdata
    local v1, v2, v3
    local Splashes = Config.Appearance.Weather.Splashes
    local TouchPerFrame = if not Aim.isTouch() then
        Splashes.PerFrame
    else
        Splashes.TouchPerFrame
    local Character = Players.LocalPlayer.Character
    u64.FilterDescendantsInstances = if not Character then {a1} else {Character, a1}
    u64.FilterType = Enum.RaycastFilterType.Exclude

    for i = 1, TouchPerFrame do
        v1 = math.random() * 3.141592653589793 * 2
        v2 = (math.sqrt((math.random()))) * Splashes.RadiusStuds
        v2 = Workspace:Raycast(a1.CFrame.Position + Vector3.new(math.cos(v1) * v2, Splashes.RayHeightStuds, (math.sin(v1)) * v2), Vector3.new(0, -(Splashes.RayHeightStuds + 60), 0), u64)

        if v2 and not shelteredAt(v2.Position + Vector3.new(0, 0.5, 0)) then
            v3 = u61[u62]
            u62 = u62 % #u61 + 1
            v3.part.Position = v2.Position + Vector3.new(0, 0.15000000596046448, 0)

            v3.emitter:Emit(1)
        end
    end
end

function v1.start()
    -- Line: 225
    -- upvalues: Config (val), u49 (ref), Workspace (val), u50 (ref), rgb (val), u51 (ref), u52 (ref), Lighting (val)
    -- upvalues: u55 (ref), u53 (ref), u54 (ref), makeSplashPool (val), RunService (val), u68 (ref), Players (val)
    -- upvalues: shelteredAt (val), splash (val), ReplicatedStorage (val), apply (val), NewPlayerView (val)
    local v1
    local Weather = Config.Appearance.Weather
    u49 = Instance.new("Part")
    u49.Name = "RainVolume"
    u49.Size = Vector3.new(Weather.Rain.AreaStuds, 1, Weather.Rain.AreaStuds)
    u49.Anchored = true
    u49.CanCollide = false
    u49.CanQuery = false
    u49.CanTouch = false
    u49.CastShadow = false
    u49.Transparency = 1
    local v2 = u49
    local CurrentCamera = Workspace.CurrentCamera or Workspace
    v2.Parent = CurrentCamera
    u50 = Instance.new("ParticleEmitter")
    u50.Name = "Rain"
    u50.Enabled = false
    u50.Rate = Weather.Rain.Rate
    u50.Lifetime = NumberRange.new(Weather.Rain.LifetimeSeconds)
    u50.Speed = NumberRange.new(Weather.Rain.SpeedStuds)
    u50.Acceleration = Vector3.new(0, -20, 0)
    u50.EmissionDirection = Enum.NormalId.Bottom
    u50.Shape = Enum.ParticleEmitterShape.Box
    u50.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
    u50.Orientation = Enum.ParticleOrientation.VelocityParallel
    u50.Size = NumberSequence.new(Weather.Rain.DropSize)
    u50.Squash = NumberSequence.new(Weather.Rain.Squash)
    u50.Transparency = NumberSequence.new(Weather.Rain.Transparency)
    u50.Color = ColorSequence.new(rgb(Weather.Rain.Color))
    u50.LightEmission = 0.2
    u50.LightInfluence = 0.8
    u50.Drag = 0
    u50.Parent = u49
    u51 = Instance.new("Part")
    u51.Name = "WindVolume"
    u51.Size = Vector3.new(Weather.Wind.AreaStuds, Weather.Wind.DepthStuds, Weather.Wind.AreaStuds)
    u51.Anchored = true
    u51.CanCollide = false
    u51.CanQuery = false
    u51.CanTouch = false
    u51.CastShadow = false
    u51.Transparency = 1
    v2 = u51
    local CurrentCamera_2 = Workspace.CurrentCamera or Workspace
    v2.Parent = CurrentCamera_2
    u52 = Instance.new("ParticleEmitter")
    u52.Name = "Wind"
    u52.Enabled = false
    u52.Rate = Weather.Wind.Rate
    u52.Lifetime = NumberRange.new(Weather.Wind.LifetimeSeconds)
    u52.Speed = NumberRange.new(Weather.Wind.SpeedStuds)
    u52.Acceleration = Vector3.new(0, 0, 0)
    u52.EmissionDirection = Enum.NormalId.Right
    u52.SpreadAngle = Vector2.new(4, 8)
    u52.Shape = Enum.ParticleEmitterShape.Box
    u52.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
    u52.Orientation = Enum.ParticleOrientation.VelocityParallel
    u52.Size = NumberSequence.new(Weather.Wind.StreakSize)
    u52.Squash = NumberSequence.new(Weather.Wind.Squash)
    u52.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.3, Weather.Wind.Transparency),
        NumberSequenceKeypoint.new(0.7, Weather.Wind.Transparency),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    u52.Color = ColorSequence.new(rgb(Weather.Wind.Color))
    u52.LightEmission = 0.7
    u52.LightInfluence = 0.3
    u52.Parent = u51
    local SunRaysEffect = Lighting:FindFirstChildOfClass("SunRaysEffect")

    if not SunRaysEffect then
        u55 = Instance.new("SunRaysEffect")
        u55.Name = "WeatherSunRays"
        u55.Intensity = 0
        u55.Enabled = false
        u55.Parent = Lighting
    else
        u55 = SunRaysEffect
    end

    u53 = Instance.new("ColorCorrectionEffect")
    u53.Name = "WeatherGrade"
    u53.Enabled = false
    u53.Parent = Lighting
    v2 = Workspace:FindFirstChildOfClass("Terrain")

    if v2 then
        local Clouds = v2:FindFirstChildOfClass("Clouds")

        if not Clouds then
            local Clouds_2 = Instance.new("Clouds")
            Clouds_2.Parent = v2
            v1 = Clouds_2
        else
            v1 = Clouds
        end
    else
        v1 = nil
    end

    u54 = v1
    makeSplashPool(Workspace.CurrentCamera or Workspace)

    RunService.Heartbeat:Connect(function()
        -- Line: 320
        -- upvalues: Workspace (upval), u49 (upval), Weather (val), u68 (upval), Players (upval), shelteredAt (upval)
        -- upvalues: u50 (upval), u51 (upval), splash (upval)
        local CurrentCamera = Workspace.CurrentCamera

        if not CurrentCamera then
            return
        end

        if u49.Parent ~= CurrentCamera then
            u49.Parent = CurrentCamera
        end

        u49.CFrame = CFrame.new(CurrentCamera.CFrame.Position + Vector3.new(0, Weather.Rain.HeightStuds, 0))

        if u68 then
            local Character = Players.LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            local v1 = shelteredAt(CurrentCamera.CFrame.Position)

            if not v1 then
                v1 = false

                if HumanoidRootPart ~= nil then
                    v1 = HumanoidRootPart:IsA("BasePart") and shelteredAt(HumanoidRootPart.Position)
                end
            end

            u50.Enabled = not v1
        end

        if u51.Parent ~= CurrentCamera then
            u51.Parent = CurrentCamera
        end

        u51.CFrame = CFrame.new(CurrentCamera.CFrame.Position)

        if u68 then
            splash(CurrentCamera)
        end
    end)

    local Attribute = Config.Weather.Attribute

    local function read()
        -- Line: 353
        -- upvalues: ReplicatedStorage (upval), Attribute (val), apply (upval), NewPlayerView (upval), Config (upval)
        local Attribute_2 = ReplicatedStorage:GetAttribute(Attribute)
        apply(NewPlayerView.weather(if type(Attribute_2) ~= "string" then Config.Weather.Default else Attribute_2))
    end

    ;(ReplicatedStorage:GetAttributeChangedSignal(Attribute)):Connect(read)
    NewPlayerView.onChanged(read)

    local Attribute_2 = ReplicatedStorage:GetAttribute(Attribute)
    apply(NewPlayerView.weather(if type(Attribute_2) ~= "string" then Config.Weather.Default else Attribute_2))
end

return v1