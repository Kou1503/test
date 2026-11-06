-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.SpecialDropController
-- Decompile time: 4.03 ms

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)

require(Shared.Config.SpecialDropConfig)

local Palette = require(Shared.Palette)
local Remotes = require(Shared.Remotes)
local u48 = require(script.Parent.Parent.Ui)
local AudioController = require(script.Parent.AudioController)
local SettingsController = require(script.Parent.SettingsController)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u64 = Remotes.get(Remotes.SpecialDrop)
local u65 = nil
local u66 = nil
local u67 = 0

local function fallbackOrigin() -- Line: 45; upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart.Position
    end

    return nil
end

local function chime(a1) -- Line: 59; upvalues: AudioController (val), Debris (val)
    if a1.soundId == "" then
        return
    end

    local Sound = Instance.new("Sound")
    Sound.SoundId = a1.soundId
    Sound.Volume = a1.volume
    Sound.PlaybackSpeed = a1.pitch

    AudioController.playSfx(Sound)
    Debris:AddItem(Sound, 6)
end

local function sparkle(a1, a2, a3)
    -- Line: 80
    -- upvalues: SettingsController (val), Workspace (val), Palette (val), TweenService (val), Debris (val)
    -- upvalues: Config (val)
    -- types: a1: string, a3: vector
    local v1 = SettingsController.is("RareDropEffects", "Reduced")
    local Part = Instance.new("Part")
    Part.Name = "SpecialDropVfx"
    Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    Part.Position = a3
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Parent = Workspace
    local v2 = Palette.colorFor(a1)
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Color = ColorSequence.new(v2)
    ParticleEmitter.LightEmission = 0.8
    ParticleEmitter.Lifetime = NumberRange.new(0.4, a2.particleSeconds)
    ParticleEmitter.Speed = NumberRange.new(4, 9)
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180)
    ParticleEmitter.Rate = 0
    ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.35), (NumberSequenceKeypoint.new(1, 0))})
    ParticleEmitter.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), (NumberSequenceKeypoint.new(1, 1))})
    ParticleEmitter.Parent = Part

    ParticleEmitter:Emit(if not v1 then a2.particles else math.max(4, (math.floor(a2.particles * 0.25))))

    if a2.beam and not v1 then
        local Part_2 = Instance.new("Part")
        Part_2.Name = "SpecialDropBeam"
        Part_2.Size = Vector3.new(1.2000000476837158, 40, 1.2000000476837158)
        Part_2.Position = a3 + Vector3.new(0, 20, 0)
        Part_2.Anchored = true
        Part_2.CanCollide = false
        Part_2.CanQuery = false
        Part_2.CanTouch = false
        Part_2.Material = Enum.Material.Neon
        Part_2.Color = v2
        Part_2.Transparency = 0.55
        Part_2.Parent = Workspace

        TweenService:Create(
            Part_2,
            TweenInfo.new(a2.particleSeconds),
            {Transparency = 1}
        ):Play()

        Debris:AddItem(Part_2, a2.particleSeconds + 0.2)
    end

    Debris:AddItem(Part, (Config.SpecialDrop.lifetimeOf(a2)))
end

local function callout(a1, a2, a3)
    -- Line: 143
    -- upvalues: u67 (ref), u65 (ref), Palette (val), u66 (ref), TweenService (val)
    -- types: a1: string, a3: boolean
    if not a3 and os.clock() < u67 then
        return
    end

    if a3 then
        u67 = os.clock() + a2.bannerSeconds
    end

    u65.Text = a2.banner or ""
    u65.TextColor3 = a2.bannerColor
    u65.TextTransparency = if not a2.banner then 1 else 0
    local u32 = string.upper(Palette.displayName(a1))
    u66.Text = u32
    u66.TextSize = a2.textSize
    u66.TextColor3 = Palette.colorFor(a1)
    u66.TextTransparency = 0

    task.delay(
        a2.bannerSeconds,
        function() -- Line: 164; upvalues: u66 (upval), u32 (val), TweenService (upval), u65 (upval)
            if u66.Text == u32 then
                TweenService:Create(
                    u65,
                    TweenInfo.new(0.35),
                    {TextTransparency = 1}
                ):Play()

                TweenService:Create(
                    u66,
                    TweenInfo.new(0.35),
                    {TextTransparency = 1}
                ):Play()
            end
        end
    )
end

local function build() -- Line: 172; upvalues: LocalPlayer (val), u48 (val), u65 (ref), u66 (ref)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SpecialDrop"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 20
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 90)
    Frame.Position = UDim2.fromScale(0, 0.22)
    Frame.BackgroundTransparency = 1
    Frame.Parent = ScreenGui

    local function line(a1, a2, a3) -- Line: 188; upvalues: u48 (upval), Frame (val); types: a1: number, a2: number
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, 0, 0, a1 + 8)
        TextLabel.Position = UDim2.fromOffset(0, a2)
        TextLabel.BackgroundTransparency = 1
        TextLabel.FontFace = Font.new(u48.Font.Family, a3)
        TextLabel.TextSize = a1
        TextLabel.TextTransparency = 1
        TextLabel.TextStrokeTransparency = 0.4
        TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        TextLabel.Text = ""
        TextLabel.Parent = Frame

        return TextLabel
    end

    u65 = line(26, 0, Enum.FontWeight.Bold)
    u66 = line(34, 34, Enum.FontWeight.Heavy)
end

function v1.start()
    -- Line: 207
    -- upvalues: build (val), u64 (val), Config (val), AudioController (val), Debris (val), LocalPlayer (val)
    -- upvalues: sparkle (val), callout (val)
    build()

    u64.OnClientEvent:Connect(function(a1, a2, a3)
        -- Line: 210
        -- upvalues: Config (upval), AudioController (upval), Debris (upval), LocalPlayer (upval), sparkle (upval)
        -- upvalues: callout (upval)
        -- types: a1: string, a2: string, a3: vector?
        if type(a1) ~= "string" then
            return
        end

        local v1 = Config.SpecialDrop.tierFor(a2)
        local v2 = a2 == Config.SpecialDrop.Rare

        AudioController.play("SpecialFind")
        AudioController.suppressPickup()

        if v1.soundId ~= "" then
            local Sound = Instance.new("Sound")
            Sound.SoundId = v1.soundId
            Sound.Volume = v1.volume
            Sound.PlaybackSpeed = v1.pitch

            AudioController.playSfx(Sound)
            Debris:AddItem(Sound, 6)
        end

        local Position = a3

        if not Position then
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            Position = if not HumanoidRootPart then
                nil
            else
                if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart.Position
        end

        if Position then
            sparkle(a1, v1, Position)
        end

        callout(a1, v1, v2)
    end)
end

return v1