-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.KeyBinds
-- Decompile time: 1.23 ms

local ControlGlyphs = require(script.Parent.ControlGlyphs)
local SettingsController = require(script.Parent.SettingsController)
local u10 = {}

local function keyFor(a1) -- Line: 15; upvalues: SettingsController (val); types: a1: string
    local u4 = SettingsController.get(a1)
    local success, err = pcall(function() -- Line: 17; upvalues: u4 (val)
        return Enum.KeyCode[u4]
    end)

    if success and typeof(err) == "EnumItem" then
        return err
    end

    return Enum.KeyCode.F
end

function u10.pickup() -- Line: 23; upvalues: keyFor (val)
    return (keyFor("PickupKey"))
end

function u10.use() -- Line: 27; upvalues: keyFor (val)
    return (keyFor("UseKey"))
end

function u10.shared() -- Line: 33; upvalues: u10 (val)
    return u10.pickup() == u10.use()
end

function u10.onChanged(a1) -- Line: 38; upvalues: SettingsController (val); types: a1: function
    SettingsController.onChanged(function(a1_2) -- Line: 39; upvalues: a1 (val)
        if a1_2 == "PickupKey" or a1_2 == "UseKey" then
            a1()
        end
    end)
end

function u10.fill(a1) -- Line: 48; upvalues: ControlGlyphs (val), u10 (val); types: a1: string
    return (string.gsub(string.gsub(a1, "{Pickup}", if not ControlGlyphs.usingGamepad() then u10.pickup().Name else ControlGlyphs.name(Enum.KeyCode.ButtonY)), "{Use}", if not ControlGlyphs.usingGamepad() then u10.use().Name else ControlGlyphs.name(Enum.KeyCode.ButtonX)))
end

return u10