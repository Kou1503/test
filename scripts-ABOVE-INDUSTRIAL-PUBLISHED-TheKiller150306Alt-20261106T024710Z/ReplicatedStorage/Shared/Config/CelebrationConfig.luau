-- Script path: game:GetService("ReplicatedStorage").Shared.Config.CelebrationConfig
-- Decompile time: 0.26 ms

return {
    DisplaySeconds = 18,
    Shells = 16,
    LaunchGapSeconds = {min = 0.4, max = 1.1},
    FinaleShells = 5,
    FinaleGapSeconds = 0.12,
    HeightStuds = {min = 70, max = 120},
    SpreadStuds = 48,
    RiseSeconds = {min = 1.1, max = 1.6},
    BurstSparks = 140,
    BurstSpeed = {min = 28, max = 46},
    SparkLifetimeSeconds = {min = 1.3, max = 2.2},
    SparkSize = {start = 1.4, finish = 0.2},
    SparkGravity = 14,
    FlashRangeStuds = 90,
    FlashSeconds = 0.5,
    Colors = {
        {r = 255, g = 96, b = 96},
        {r = 255, g = 200, b = 72},
        {r = 120, g = 220, b = 140},
        {r = 96, g = 170, b = 255},
        {r = 220, g = 120, b = 255},
        {r = 255, g = 255, b = 255},
    },
    VisibleStuds = 1600,
    LaunchSoundId = "",
    BurstSoundId = "",
    SoundVolume = 0.8,
}