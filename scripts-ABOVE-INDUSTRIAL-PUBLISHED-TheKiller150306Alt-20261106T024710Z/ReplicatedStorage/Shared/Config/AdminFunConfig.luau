-- Script path: game:GetService("ReplicatedStorage").Shared.Config.AdminFunConfig
-- Decompile time: 0.33 ms

return {
    Size = {Min = 0.25, Max = 4},
    BigHeadScale = 3,
    Speed = {Min = 0, Max = 200},
    Fling = {UpSpeed = 140, OutSpeed = 110, Spin = 25, TumbleSeconds = 2},
    DizzySeconds = 10,
    StunSeconds = 10,
    GlitchSeconds = 30,
    Burn = {TotalDamage = 50, Seconds = 10},
    Jumpscare = {ImageId = 0, SoundId = 0, Volume = 10, Seconds = 1.6},
    Follow = {Seconds = 180, BehindStuds = 5, HopStuds = 1.5, StepSeconds = 0.1},
    KingSlime = {GelReward = 3, SpawnAheadStuds = 14},
    Meteor = {
        AheadStuds = 24,
        ScatterStuds = 10,
        FallFromStuds = 220,
        FallSeconds = 1.4,
        Types = {"IronOre", "Coal", "Stone", "Sand", "Clay"},
    },
    DoubleDropMultiplier = 2,
    HotPotato = {Seconds = 45, PassStuds = 5, PassCooldownSeconds = 1.2, MinPlayers = 2},
    Bounty = {MaxCoins = 100000, TagStuds = 8},
    Fog = {Density = 0.88, Haze = 3, FogEnd = 70, Color = {r = 190, g = 195, b = 205}},
    Lava = {CheckSeconds = 0.25, MaxBlocks = 6000, Color = {r = 255, g = 90, b = 20}},
    Party = {
        Seconds = 10,
        DancesR15 = {"rbxassetid://507771019", "rbxassetid://507776043", "rbxassetid://507777268"},
        DancesR6 = {"rbxassetid://182435998", "rbxassetid://182491037", "rbxassetid://182491065"},
    },
}