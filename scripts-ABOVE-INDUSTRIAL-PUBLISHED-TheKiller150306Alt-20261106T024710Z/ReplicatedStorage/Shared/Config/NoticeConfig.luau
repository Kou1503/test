-- Script path: game:GetService("ReplicatedStorage").Shared.Config.NoticeConfig
-- Decompile time: 0.16 ms

return {
    Tones = {World = {color = {r = 150, g = 200, b = 255}}, Ready = {color = {r = 150, g = 225, b = 170}}},
    DefaultTone = "World",
    SecondsOnScreen = 5,
    FadeSeconds = 0.4,
    MaxOnScreen = 3,
    RepeatCooldownSeconds = 45,
    Weather = {
        Rain = "It's starting to rain",
        Scorching = "The sun is scorching today",
        Windy = "The wind is picking up",
        Clear = "The sky is clearing",
    },
    CropSweepSeconds = 180,
    WaterDry = "A Water Block ran dry. Fill your Bucket in the Hub's pond and place it to bring water home",
    WaterDrySeconds = 300,
    DrySoil = "That soil is dry. Crops only grow within 3 blocks of water",
}