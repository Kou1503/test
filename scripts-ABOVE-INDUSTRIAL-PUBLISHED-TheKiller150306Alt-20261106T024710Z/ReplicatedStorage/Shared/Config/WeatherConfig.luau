-- Script path: game:GetService("ReplicatedStorage").Shared.Config.WeatherConfig
-- Decompile time: 0.21 ms

return {
    Attribute = "Weather",
    Default = "Clear",
    CheckIntervalMinSeconds = 720,
    CheckIntervalMaxSeconds = 900,
    RainResidualSeconds = 120,
    Order = {"Clear", "Rain", "Windy", "Scorching"},
    States = {
        Clear = {displayName = "Clear", glyph = "", weight = 0.5},
        Rain = {displayName = "Rain", glyph = "☂", weight = 0.22},
        Windy = {displayName = "Windy", glyph = "🌬", weight = 0.13},
        Scorching = {displayName = "Scorching", glyph = "☀", weight = 0.15},
    },
    WaterTapCost = {Scorching = 2},
}