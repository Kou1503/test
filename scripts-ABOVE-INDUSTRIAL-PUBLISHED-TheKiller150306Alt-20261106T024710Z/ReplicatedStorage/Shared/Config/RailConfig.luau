-- Script path: game:GetService("ReplicatedStorage").Shared.Config.RailConfig
-- Decompile time: 0.17 ms

return {
    Physics = {
        Gravity = 30,
        Friction = 2,
        MaxSpeed = 36,
        PushAccel = 14,
        PushMaxSpeed = 9,
        BoostAccel = 45,
        BoostKickSpeed = 12,
        LaunchSpeed = 9,
    },
    Flight = {
        Gravity = 60,
        LiftSpeed = 4,
        CatchStuds = 1.5,
        MaxSeconds = 3,
        MaxReachStuds = 120,
    },
    MaxCartsPerIsland = 12,
    CheckSeconds = 0.25,
    OffTrackStuds = 3,
    OffTrackStrikes = 3,
    SeatSettleSeconds = 0.4,
}