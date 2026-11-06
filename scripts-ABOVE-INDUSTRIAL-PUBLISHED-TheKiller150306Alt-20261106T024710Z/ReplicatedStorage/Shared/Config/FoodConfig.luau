-- Script path: game:GetService("ReplicatedStorage").Shared.Config.FoodConfig
-- Decompile time: 0.62 ms

local u0 = {
    Effects = {
        SlimeTrail = {label = "Slime trail", widthStuds = 2, lifetimeSeconds = 3, color = {r = 110, g = 220, b = 90}},
        LowGravity = {label = "Low gravity", gravityFraction = 0.35},
        Hearts = {
            label = "Hearts",
            texture = "rbxassetid://241778280",
            perSecond = 4,
            color = {r = 255, g = 120, b = 170},
        },
        Rocket = {label = "Rocket", upSpeed = 150, blastRadius = 6},
        Freeze = {label = "Frozen", color = {r = 90, g = 160, b = 255}},
        Giant = {label = "Giant", scale = 1.5},
        SlimeForm = {label = "Slime", enemyId = "OrangeSlime", scale = 1.4},
    },
    CooldownSeconds = 2,
    MaxBuffSeconds = 1800,
    Foods = {
        Berries = {id = "Berries", heal = 4, walkSpeedPercent = 0, buffSeconds = 0},
        Carrot = {id = "Carrot", heal = 2, walkSpeedPercent = 0, buffSeconds = 0},
        Tomato = {id = "Tomato", heal = 3, walkSpeedPercent = 0, buffSeconds = 0},
        Bread = {id = "Bread", heal = 10, walkSpeedPercent = 5, buffSeconds = 300},
        GoldenBread = {
            id = "GoldenBread",
            heal = 20,
            walkSpeedPercent = 10,
            buffSeconds = 300,
            rareLuckMultiplier = 2,
        },
        RoastedCarrot = {id = "RoastedCarrot", heal = 6, walkSpeedPercent = 0, buffSeconds = 0},
        TomatoSauce = {id = "TomatoSauce", heal = 12, walkSpeedPercent = 0, buffSeconds = 0},
        BerryJam = {id = "BerryJam", heal = 15, walkSpeedPercent = 0, buffSeconds = 0},
        CarrotCake = {id = "CarrotCake", heal = 20, walkSpeedPercent = 0, buffSeconds = 0},
        BerryPie = {id = "BerryPie", heal = 30, walkSpeedPercent = 0, buffSeconds = 0},
        VegetableSoup = {id = "VegetableSoup", heal = 40, walkSpeedPercent = 0, buffSeconds = 0},
        JumboBerryPie = {
            id = "JumboBerryPie",
            heal = 50,
            walkSpeedPercent = 0,
            buffSeconds = 0,
            effect = "Giant",
            effectSeconds = 600,
        },
        SlimeSoup = {
            id = "SlimeSoup",
            heal = 10,
            walkSpeedPercent = 0,
            buffSeconds = 0,
            effect = "SlimeTrail",
            effectSeconds = 120,
        },
        PinkberryPie = {
            id = "PinkberryPie",
            heal = 25,
            walkSpeedPercent = 0,
            buffSeconds = 0,
            effect = "LowGravity",
            effectSeconds = 120,
        },
        HeartySoup = {
            id = "HeartySoup",
            heal = 20,
            walkSpeedPercent = 0,
            buffSeconds = 0,
            effect = "Hearts",
            effectSeconds = 180,
        },
        RocketCarrot = {
            id = "RocketCarrot",
            heal = 5,
            walkSpeedPercent = 0,
            buffSeconds = 0,
            effect = "Rocket",
        },
        Bluetato = {
            id = "Bluetato",
            heal = 5,
            walkSpeedPercent = 0,
            buffSeconds = 0,
            effect = "Freeze",
            effectSeconds = 8,
        },
        CandyCorn = {
            id = "CandyCorn",
            heal = 3,
            walkSpeedPercent = 0,
            buffSeconds = 0,
            effect = "SlimeForm",
            effectSeconds = 30,
        },
    },
}

function u0.isFood(a1) -- Line: 172; upvalues: u0 (val); types: a1: string?
    local v1 = false

    if a1 ~= nil then
        v1 = u0.Foods[a1] ~= nil
    end

    return v1
end

return u0