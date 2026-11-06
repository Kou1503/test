-- Script path: game:GetService("ReplicatedStorage").Shared.Config.TimeConfig
-- Decompile time: 0.38 ms

local u0 = {
    {from = 1, to = 5, grey = 170},
    {from = 6, to = 6, grey = 190},
    {from = 7, to = 16, grey = 110},
    {from = 17, to = 17, grey = 150},
    {from = 18, to = 20, grey = 190},
    {from = 21, to = 24, grey = 150},
}
return {
    SecondsPerGameHour = 60,
    DayStartHour = 6,
    NightStartHour = 21,
    DayGlyph = "☀",
    NightGlyph = "🌙",
    DayLengthSeconds = 900,
    NightLengthSeconds = 540,
    FullCycleSeconds = 1440,
    LightingApplySeconds = 0.5,
    LightingJumpSeconds = 5,
    PowerToggleCooldownSeconds = 60,
    OwnerDisconnectGraceSeconds = 300,
    AmbientByHour = u0,
    ambientGrey = function(a1) -- Line: 27; upvalues: u0 (val); types: a1: number
        local v1 = math.floor(a1) % 24

        if v1 == 0 then
            v1 = 24
        end

        for i, j in u0 do
            if j.from <= v1 and v1 <= j.to then
                return j.grey
            end
        end

        return 110
    end,
}