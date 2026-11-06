-- Script path: game:GetService("ReplicatedStorage").Shared.Config.WeaponConfig
-- Decompile time: 0.27 ms

local v1 = {
    Weapons = {
        WoodSword = {
            id = "WoodSword",
            tier = "Wood",
            ranged = false,
            reachStuds = 5.4,
            standard = {Damage = {min = 8, max = 12}, AttackCooldown = {min = 0.55, max = 0.7}},
        },
        StoneSword = {
            id = "StoneSword",
            tier = "Stone",
            ranged = false,
            reachStuds = 5.4,
            standard = {Damage = {min = 13, max = 19}, AttackCooldown = {min = 0.5, max = 0.65}},
        },
        IronSword = {
            id = "IronSword",
            tier = "Iron",
            ranged = false,
            reachStuds = 5.4,
            standard = {Damage = {min = 18, max = 26}, AttackCooldown = {min = 0.45, max = 0.6}},
        },
    },
    Crit = {Chance = 0.12, Multiplier = 2},
}
v1.Crit = {Chance = 0.12, Multiplier = 2}
v1.WrongToolMessageCooldownSeconds = 2
v1.MeleeSweepBufferStuds = 5.4

return v1