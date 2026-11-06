-- Script path: game:GetService("ReplicatedStorage").Shared.Config.SpecialDropConfig
-- Decompile time: 0.70 ms

local u0 = {}
u0.Tiers = {
    Bonus = {
        soundId = "",
        volume = 0.5,
        pitch = 1,
        particles = 14,
        particleSeconds = 0.6,
        beam = false,
        bannerSeconds = 2,
        textSize = 22,
        bannerColor = Color3.fromRGB(235, 235, 215),
    },
    Rare = {
        soundId = "",
        volume = 0.75,
        pitch = 1.15,
        particles = 60,
        particleSeconds = 1.6,
        beam = true,
        banner = "SPECIAL DROP!",
        bannerSeconds = 3.5,
        textSize = 34,
        bannerColor = Color3.fromRGB(255, 214, 110),
    },
}
u0.Bonus = "Bonus"
u0.Rare = "Rare"

function u0.tierFor(a1) -- Line: 86; upvalues: u0 (val); types: a1: string?
    return (if not a1 then nil else u0.Tiers[a1]) or u0.Tiers.Bonus
end

function u0.lifetimeOf(a1) -- Line: 93; types: a1: table
    return math.max(a1.particleSeconds, a1.bannerSeconds) + 0.5
end

return u0