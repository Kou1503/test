-- Script path: game:GetService("ReplicatedStorage").Shared.Config.SpendBoardConfig
-- Decompile time: 0.15 ms

return {
    Boards = {
        CoinsSpent = {store = "AboveCoinsSpent_v1", title = "MOST COINS SPENT", unit = "Coins"},
        RobuxSpent = {store = "AboveRobuxSpent_v1", title = "MOST ROBUX SPENT", unit = "Robux"},
        Coins = {store = "AboveCoins_v1", title = "MOST COINS", unit = "Coins"},
    },
    Tag = "AboveLeaderboard",
    Attribute = "AboveLeaderboard",
    Rows = 20,
    Columns = 2,
    RankDepth = 100,
    RefreshSeconds = 120,
    FlushSeconds = 120,
    PixelsPerStud = 40,
}