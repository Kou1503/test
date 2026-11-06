-- Script path: game:GetService("ReplicatedStorage").Shared.Config.FriendConfig
-- Decompile time: 0.19 ms

return {
    ListCacheSeconds = 300,
    Luck = {FirstFriendPercent = 5, AdditionalFriendPercent = 2.5, MaxPercent = 15},
    Eligible = {"SeedSpecialDrop", "SaplingReturn", "PrizedCropChance", "SpecialSurpriseDrop"},
    Excluded = {
        "BaseOreProduction",
        "SteelOutput",
        "BrassOutput",
        "CoinSalePrices",
        "VendingIncome",
        "PrimeMasterworkOdds",
        "PerfectStatOdds",
        "AchievementProgress",
        "GuaranteedShinyRewards",
    },
    Menu = {ListRefreshSeconds = 15, ActionBurst = 3, ActionsPerSecond = 1},
    IslandInvite = {
        LifetimeSeconds = 20,
        PassSeconds = 90,
        PerTargetCooldownSeconds = 30,
        Burst = 3,
        PerSecond = 0.25,
        MaxShown = 3,
        Topic = "IslandInvite",
    },
}