-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.AmbienceController
-- Decompile time: 4.13 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Config = require(Shared.Config)
local u32 = require(script.Parent.AudioController)
local TimeController = require(script.Parent.TimeController)
local NewPlayerView = require(script.Parent.NewPlayerView)
local v1 = {}
local u44 = {}
local v2 = {name = "MusicDay", music = true, id = Config.Sound.Music.Day}
local v3 = {name = "MusicNight", music = true, id = Config.Sound.Music.Night}
local v4 = {name = "AmbientDay", music = false, id = Config.Sound.Ambient.Day}
local v5 = {name = "AmbientNight", music = false, id = Config.Sound.Ambient.Night}
local v6 = {name = "Rain", music = false, id = Config.Sound.Ambient.Rain}
u44[1] = v2
u44[2] = v3
u44[3] = v4
u44[4] = v5
u44[5] = v6
local u65 = {}
local u66 = false

local function fade(a1, a2)
    -- Line: 56
    -- upvalues: u65 (val), TweenService (val), Config (val)
    -- types: a1: string, a2: number
    local v1 = u65[a1]

    if not v1 then
        return
    end

    TweenService:Create(
        v1,
        TweenInfo.new(Config.Sound.CrossfadeSeconds),
        {Volume = a2}
    ):Play()
end

local function refresh() -- Line: 66; upvalues: TimeController (val), fade (val), u66 (ref)
    local v1 = TimeController.isNight()
    fade("MusicDay", if not v1 then 1 else 0)
    fade("MusicNight", if not v1 then 0 else 1)
    fade("AmbientDay", if not v1 then 1 else 0)
    fade("AmbientNight", if not v1 then 0 else 1)
    fade("Rain", if not u66 then 0 else 1)
end

local u69 = nil
local u70 = ""

function v1.inCave(a1) -- Line: 94; upvalues: ReplicatedStorage (val), Config (val); types: a1: vector
    local Attribute = ReplicatedStorage:GetAttribute(Config.Sound.MineralFieldCentreAttribute)
    local Attribute_2 = ReplicatedStorage:GetAttribute(Config.Sound.MineralFieldRadiusAttribute)

    if typeof(Attribute) == "Vector3" and type(Attribute_2) == "number" then
        return (Attribute - a1).Magnitude <= Attribute_2
    end

    return false
end

local function isSwimming() -- Line: 111; upvalues: Players (val)
    local Character = Players.LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local v1 = false

    if Humanoid ~= nil then
        v1 = (Humanoid:GetState()) == Enum.HumanoidStateType.Swimming
    end

    return v1
end

local u73 = (-1 / 0)

local function splash(a1) -- Line: 129; upvalues: u73 (ref); types: a1: userdata
    local v1 = os.clock()

    if v1 - u73 < 0.6 then
        return
    end

    u73 = v1
    local Splash = a1:FindFirstChild("Splash")

    if Splash and Splash:IsA("Sound") then
        Splash:Play()
    end
end

local function watchWater(a1) -- Line: 143; upvalues: u73 (ref); types: a1: userdata
    local Humanoid = a1:WaitForChild("Humanoid", 10)
    local HumanoidRootPart = a1:WaitForChild("HumanoidRootPart", 10)

    if Humanoid and Humanoid:IsA("Humanoid") and HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local u19 = {}
        HumanoidRootPart.Touched:Connect(function(a1)
            -- Line: 151
            -- upvalues: u19 (val), Humanoid (val), HumanoidRootPart (val), u73 (upval)
            if a1:GetAttribute("BlockId") ~= "WaterBlock" then
                return
            end

            if next(u19) == nil and (Humanoid:GetState()) ~= Enum.HumanoidStateType.Swimming then
                local v1 = os.clock()

                if not (v1 - u73 < 0.6) then
                    u73 = v1
                    local Splash = HumanoidRootPart:FindFirstChild("Splash")

                    if Splash and Splash:IsA("Sound") then
                        Splash:Play()
                    end
                end
            end

            u19[a1] = true
        end)

        HumanoidRootPart.TouchEnded:Connect(function(a1) -- Line: 160; upvalues: u19 (val)
            u19[a1] = nil
        end)
    end
end

local function refreshZone()
    -- Line: 165
    -- upvalues: Players (val), Config (val), ReplicatedStorage (val), u70 (ref), SoundService (val), u32 (val)
    -- upvalues: u69 (ref)
    local Character = Players.LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Character_2 = Players.LocalPlayer.Character
    local Humanoid = Character_2 and Character_2:FindFirstChildOfClass("Humanoid")
    local v1 = false

    if Humanoid ~= nil then
        v1 = (Humanoid:GetState()) == Enum.HumanoidStateType.Swimming
    end

    local Default = Config.Sound.Reverb.Default

    if v1 then
        Default = Config.Sound.Reverb.UnderWater
    elseif HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local Position = HumanoidRootPart.Position
        local Attribute = ReplicatedStorage:GetAttribute(Config.Sound.MineralFieldCentreAttribute)
        local Attribute_2 = ReplicatedStorage:GetAttribute(Config.Sound.MineralFieldRadiusAttribute)

        if if typeof(Attribute) ~= "Vector3" then
            false
        else
            if type(Attribute_2) == "number" then
                (Attribute - Position).Magnitude <= Attribute_2
            else
                false then
            Default = Config.Sound.Reverb.Cave
        end
    end

    if Default ~= u70 then
        u70 = Default
        SoundService.AmbientReverb = Enum.ReverbType[Default]

        u32.setZone(Default)
    end

    u69.Enabled = v1
end

function v1.start()
    -- Line: 189
    -- upvalues: u44 (val), u32 (val), SoundService (val), u65 (val), u69 (ref), Config (val), Players (val)
    -- upvalues: watchWater (val), ReplicatedStorage (val), u66 (ref), NewPlayerView (val), refresh (val)
    -- upvalues: TimeController (val), refreshZone (val)
    local Sound, v1
    local v2 = nil
    local v3 = nil

    for i, j in u44, v2, v3 do
        Sound = Instance.new("Sound")
        Sound.Name = j.name
        Sound.SoundId = j.id
        Sound.Looped = true
        Sound.Volume = 0
        v1 = if not j.music then u32.sfxGroup() else u32.musicGroup()
        Sound.SoundGroup = v1
        Sound.Parent = SoundService

        Sound:Play()

        u65[j.name] = Sound
    end

    u69 = Instance.new("EqualizerSoundEffect")
    u69.Name = "UnderWater"
    u69.HighGain = Config.Sound.UnderWaterMuffle.HighGain
    u69.MidGain = Config.Sound.UnderWaterMuffle.MidGain
    u69.LowGain = Config.Sound.UnderWaterMuffle.LowGain
    u69.Enabled = false
    u69.Parent = u32.sfxGroup()
    local LocalPlayer = Players.LocalPlayer

    LocalPlayer.CharacterAdded:Connect(function(a1) -- Line: 221; upvalues: watchWater (upval)
        task.spawn(watchWater, a1)
    end)

    if LocalPlayer.Character then
        task.spawn(watchWater, LocalPlayer.Character)
    end

    local Attribute = Config.Weather.Attribute

    local function readWeather()
        -- Line: 229
        -- upvalues: ReplicatedStorage (upval), Attribute (val), u66 (upval), NewPlayerView (upval), Config (upval)
        -- upvalues: refresh (upval)
        local Attribute_2 = ReplicatedStorage:GetAttribute(Attribute)
        local weather = NewPlayerView.weather
        u66 = weather(if type(Attribute_2) ~= "string" then Config.Weather.Default else Attribute_2)
            == "Rain"

        refresh()
    end

    ;(ReplicatedStorage:GetAttributeChangedSignal(Attribute)):Connect(readWeather)
    NewPlayerView.onChanged(readWeather)

    local Attribute_2 = ReplicatedStorage:GetAttribute(Attribute)
    local weather = NewPlayerView.weather
    u66 = weather(if type(Attribute_2) ~= "string" then Config.Weather.Default else Attribute_2)
        == "Rain"

    refresh()

    task.spawn(function() -- Line: 242; upvalues: TimeController (upval), refresh (upval), refreshZone (upval)
        local v1
        local v2 = TimeController.isNight()

        while true do
            task.wait(1)

            v1 = TimeController.isNight()

            if v1 ~= v2 then
                v2 = v1
                refresh()
            end

            refreshZone()
        end
    end)
end

return v1