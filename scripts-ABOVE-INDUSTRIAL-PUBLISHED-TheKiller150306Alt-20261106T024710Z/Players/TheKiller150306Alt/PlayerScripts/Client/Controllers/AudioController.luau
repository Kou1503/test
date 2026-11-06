-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.AudioController
-- Decompile time: 4.14 ms

local CollectionService = game:GetService("CollectionService")
local ContentProvider = game:GetService("ContentProvider")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Remotes = require(Shared.Remotes)
local u40 = require(script.Parent.SettingsController)
local u41 = {}
local u42 = nil
local u43 = nil

function u41.sfxGroup() -- Line: 37; upvalues: u42 (ref)
    return u42
end

function u41.musicGroup() -- Line: 41; upvalues: u43 (ref)
    return u43
end

function u41.playSfx(a1) -- Line: 51; upvalues: u42 (ref), SoundService (val); types: a1: userdata
    a1.SoundGroup = u42
    a1.Parent = SoundService

    SoundService:PlayLocalSound(a1)
end

local u47 = {}

local function templateFor(a1) -- Line: 74; upvalues: u47 (val), SoundService (val); types: a1: string
    local v1 = u47[a1]

    if v1 then
        return v1
    end

    local Sound = Instance.new("Sound")
    Sound.SoundId = a1
    Sound.Name = a1
    Sound.Parent = SoundService
    u47[a1] = Sound

    return Sound
end

local function preload() -- Line: 90; upvalues: Config (val), u47 (val), SoundService (val), ContentProvider (val)
    local Sound, Sound_2, Sound_3, v1, v2, v3, v4, v5
    local u118 = {}
    local v6 = nil
    local v7 = nil

    for i, j in Config.Sound.Cues, v6, v7 do
        v3 = nil
        v4 = nil

        for k, n in j.ids, v3, v4 do
            v2 = u47[n]

            if not v2 then
                Sound_3 = Instance.new("Sound")
                Sound_3.SoundId = n
                Sound_3.Name = n
                Sound_3.Parent = SoundService
                u47[n] = Sound_3
                v1 = Sound_3
            else
                v1 = v2
            end

            table.insert(u118, v1)
        end
    end

    v6 = nil
    v7 = nil

    for m, i5 in Config.Sound.MachineLoops, v6, v7 do
        v3 = nil
        v4 = nil

        for i6, i7 in i5.ids, v3, v4 do
            v2 = u47[i7]

            if not v2 then
                Sound_2 = Instance.new("Sound")
                Sound_2.SoundId = i7
                Sound_2.Name = i7
                Sound_2.Parent = SoundService
                u47[i7] = Sound_2
                v1 = Sound_2
            else
                v1 = v2
            end

            table.insert(u118, v1)
        end
    end

    v6 = nil
    v7 = nil

    for i8, i9 in Config.Sound.HarvesterLoop.ids, v6, v7 do
        v5 = u47[i9]

        if not v5 then
            Sound = Instance.new("Sound")
            Sound.SoundId = i9
            Sound.Name = i9
            Sound.Parent = SoundService
            u47[i9] = Sound
            v4 = Sound
        else
            v4 = v5
        end

        table.insert(u118, v4)
    end

    task.spawn(function() -- Line: 105; upvalues: ContentProvider (upval), u118 (val)
        pcall(function() -- Line: 106; upvalues: ContentProvider (upval), u118 (upval)
            ContentProvider:PreloadAsync(u118)
        end)
    end)
end

local u50 = 0

function u41.suppressPickup() -- Line: 124; upvalues: u50 (ref)
    u50 = os.clock() + 0.2
end

function u41.pickupSuppressed() -- Line: 128; upvalues: u50 (ref)
    return os.clock() < u50
end

local u53 = ""

function u41.setZone(a1) -- Line: 139; upvalues: u53 (ref); types: a1: string
    u53 = a1
end

local function applyCaveTail(a1, a2)
    -- Line: 151
    -- upvalues: Config (val), u53 (ref)
    -- types: a1: userdata, a2: string
    local CaveTail = Config.Sound.CaveTail

    if u53 == Config.Sound.Reverb.Cave and CaveTail.Cues[a2] then
        local ReverbSoundEffect = Instance.new("ReverbSoundEffect")
        ReverbSoundEffect.DecayTime = CaveTail.DecaySeconds
        ReverbSoundEffect.Density = CaveTail.Density
        ReverbSoundEffect.Diffusion = CaveTail.Diffusion
        ReverbSoundEffect.WetLevel = CaveTail.WetLevel
        ReverbSoundEffect.DryLevel = CaveTail.DryLevel
        ReverbSoundEffect.Parent = a1
    end
end

function u41.play(a1, a2)
    -- Line: 176
    -- upvalues: Config (val), u47 (val), SoundService (val), u42 (ref), applyCaveTail (val)
    -- types: a1: string
    local v1 = Config.Sound.Cues[a1]

    if v1 and #v1.ids ~= 0 then
        local v2
        local v3 = v1.ids[math.random(#v1.ids)]
        local v4 = u47[v3]

        if not v4 then
            local Sound = Instance.new("Sound")
            Sound.SoundId = v3
            Sound.Name = v3
            Sound.Parent = SoundService
            u47[v3] = Sound
            v2 = Sound
        else
            v2 = v4
        end

        local u26 = v2:Clone()
        u26.Volume = v1.volume or 1
        u26.SoundGroup = u42

        applyCaveTail(u26, a1)

        local u36 = nil

        if a2 then
            u26.RollOffMode = Enum.RollOffMode.InverseTapered
            u26.RollOffMinDistance = Config.Sound.CueRollOff.MinStuds
            u26.RollOffMaxDistance = Config.Sound.CueRollOff.MaxStuds
        end

        if typeof(a2) == "Vector3" then
            v1 = Instance.new("Attachment")
            v1.WorldPosition = a2
            v1.Parent = workspace.Terrain
            u36 = v1
            u26.Parent = v1

            u26:Play()
        elseif not a2 then
            u26.Parent = SoundService
            SoundService:PlayLocalSound(u26)
        else
            u26.Parent = a2
            u26:Play()
        end

        u26.Ended:Connect(function() -- Line: 213; upvalues: u26 (val), u36 (ref)
            u26:Destroy()

            if u36 then
                u36:Destroy()
            end
        end)

        return u26
    end

    return nil
end

local function adoptWorldSounds() -- Line: 239; upvalues: u42 (ref), CollectionService (val)
    for i, j in CollectionService:GetTagged("WorldSfx") do
        if j:IsA("Sound") then
            j.SoundGroup = u42
        end
    end

    ;(CollectionService:GetInstanceAddedSignal("WorldSfx")):Connect(function(a1)
        -- Line: 240
        -- upvalues: u42 (upval)
        -- types: a1: userdata
        if a1:IsA("Sound") then
            a1.SoundGroup = u42
        end
    end)

    for k, n in workspace:GetDescendants() do
        if n:IsA("Sound") and n.SoundGroup == nil then
            n.SoundGroup = u42
        end
    end

    workspace.DescendantAdded:Connect(function(a1) -- Line: 245; upvalues: u42 (upval); types: a1: userdata
        if a1:IsA("Sound") and a1.SoundGroup == nil then
            a1.SoundGroup = u42
        end
    end)
end

local function clickEveryButton() -- Line: 269; upvalues: Players (val), u41 (val)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

    for i, j in PlayerGui:GetDescendants() do
        if j:IsA("GuiButton") then
            j.Activated:Connect(function() -- Line: 273; upvalues: u41 (upval)
                u41.play("UiClick")
            end)
        end
    end

    PlayerGui.DescendantAdded:Connect(function(a1) -- Line: 271; upvalues: u41 (upval); types: a1: userdata
        if a1:IsA("GuiButton") then
            a1.Activated:Connect(function() -- Line: 273; upvalues: u41 (upval)
                u41.play("UiClick")
            end)
        end
    end)
end

local function playServerSounds() -- Line: 289; upvalues: Remotes (val), u41 (val)
    (Remotes.get(Remotes.WorldSound)).OnClientEvent:Connect(function(a1, a2) -- Line: 290; upvalues: u41 (upval)
        if type(a1) ~= "string" then
            return
        end

        u41.play(a1, if typeof(a2) ~= "Vector3" then nil else a2)
    end)
end

local function apply() -- Line: 303; upvalues: u42 (ref), Config (val), u40 (val), u43 (ref)
    u42.Volume = Config.Settings.volumeOf(u40.get("SfxVolume"))
    u43.Volume = Config.Settings.volumeOf(u40.get("MusicVolume"))
end

function u41.start()
    -- Line: 308
    -- upvalues: u42 (ref), SoundService (val), u43 (ref), preload (val), adoptWorldSounds (val), clickEveryButton (val)
    -- upvalues: Remotes (val), u41 (val), Config (val), u40 (val), apply (val)
    u42 = Instance.new("SoundGroup")
    u42.Name = "Sfx"
    u42.Parent = SoundService
    u43 = Instance.new("SoundGroup")
    u43.Name = "Music"
    u43.Parent = SoundService

    preload()
    adoptWorldSounds()
    clickEveryButton()

    ;(Remotes.get(Remotes.WorldSound)).OnClientEvent:Connect(function(a1, a2) -- Line: 290; upvalues: u41 (upval)
        if type(a1) ~= "string" then
            return
        end

        u41.play(a1, if typeof(a2) ~= "Vector3" then nil else a2)
    end)

    u42.Volume = Config.Settings.volumeOf(u40.get("SfxVolume"))
    u43.Volume = Config.Settings.volumeOf(u40.get("MusicVolume"))

    u40.onChanged(apply)
end

return u41