-- Script path: game:GetService("ReplicatedStorage").Shared.Config.AnimationConfig
-- Decompile time: 0.45 ms

local u0 = {
    ByItem = {
        WoodAxe = {idle = "rbxassetid://16913220551", hitFrame = 3, swings = {"rbxassetid://16925360800"}},
        WoodPickaxe = {idle = "rbxassetid://16913220551", hitFrame = 7, swings = {"rbxassetid://16925268786"}},
        WoodSword = {
            idle = "rbxassetid://16913220551",
            hitFrame = 11,
            swings = {"rbxassetid://86861921756773", "rbxassetid://89881700832616"},
        },
    },
    BySlot = {
        Axe = {idle = "rbxassetid://16913220551", hitFrame = 3, swings = {"rbxassetid://16925360800"}},
        Pickaxe = {idle = "rbxassetid://16913220551", hitFrame = 7, swings = {"rbxassetid://16925268786"}},
        Weapon = {
            idle = "rbxassetid://16913220551",
            hitFrame = 11,
            swings = {"rbxassetid://86861921756773", "rbxassetid://89881700832616"},
        },
    },
}

function u0.resolve(a1, a2) -- Line: 56; upvalues: u0 (val); types: a1: string?, a2: string?
    if a1 and u0.ByItem[a1] then
        return u0.ByItem[a1]
    end

    if a2 then
        return u0.BySlot[a2]
    end

    return nil
end

u0.SwingPriority = Enum.AnimationPriority.Action
u0.SwingFadeSeconds = 0.08
u0.IdleFadeSeconds = 0.2
u0.MinSwingSpeed = 1
u0.MaxSwingSpeed = 3
u0.HitFraction = 0.35
u0.EditorFps = 30
u0.FallbackHitDelaySeconds = 0.15
u0.HitMarkerName = "Hit"
u0.DebugHitTiming = false
u0.MaxHitDelaySeconds = 0.4

return u0