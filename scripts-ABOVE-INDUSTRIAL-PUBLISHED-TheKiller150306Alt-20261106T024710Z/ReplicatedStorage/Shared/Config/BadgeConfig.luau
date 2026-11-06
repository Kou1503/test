-- Script path: game:GetService("ReplicatedStorage").Shared.Config.BadgeConfig
-- Decompile time: 0.23 ms

return {
    Ids = {
        Welcome = 437486528089337,
        Supporter = 2.86274461933557e+15,
        Millionaire = 92310465970124,
        Industrial = 2765133499335964,
        BlueCollection = 4144539285383897,
        EmberCollection = 574703520161054,
        SunCollection = 2438469699661674,
        FoundDVPlush = 2800015474269612,
        FoundTechnoblade = 291165944571616,
    },
    MillionaireCoins = 1000000,
    Collections = {Blue = "BlueCollection", Red = "EmberCollection", Yellow = "SunCollection"},
    Finds = {
        {badge = "FoundDVPlush", radius = 15, path = {"Decoration", "DV"}},
        {badge = "FoundTechnoblade", radius = 25, path = {"Decoration", "Technoblade"}},
    },
    CheckSeconds = 2,
    RetrySeconds = 60,
    MaxAttempts = 5,
}