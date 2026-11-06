-- Script path: game:GetService("ReplicatedStorage").Shared.ItemQuality
-- Decompile time: 1.63 ms

local Config = require(script.Parent.Config)
local QualityConfig = require(script.Parent.Config.QualityConfig)
local RecipeConfig = require(script.Parent.Config.RecipeConfig)
local u17 = {}

function u17.classOf(a1) -- Line: 30; upvalues: Config (val), RecipeConfig (val); types: a1: string
    if Config.Weapon.Weapons[a1] then
        return "Weapon"
    end

    if RecipeConfig.HarvesterIds[a1] then
        return "Harvester"
    end

    if Config.Tool.Tools and Config.Tool.Tools[a1] then
        return "Tool"
    end

    if Config.Factory.MachineStandardBands[a1] then
        return "Machine"
    end

    if RecipeConfig.AlwaysSoulbound[a1] then
        return nil
    end

    if RecipeConfig.isUnique(a1) then
        return "Machine"
    end

    return nil
end

function u17.bandsFor(a1) -- Line: 58; upvalues: QualityConfig (val), Config (val); types: a1: string
    local v1 = QualityConfig.Bands[a1]

    if v1 then
        return v1
    end

    v1 = Config.Weapon.Weapons[a1]

    if v1 and v1.standard then
        return v1.standard
    end

    v1 = Config.Factory.MachineStandardBands[a1]

    if v1 then
        return v1
    end

    local Tools = Config.Tool.Tools and Config.Tool.Tools[a1]

    if Tools and Config.Tool.StandardBands[Tools.tier] then
        return Config.Tool.StandardBands[Tools.tier]
    end

    return {}
end

function u17.roll(a1, a2, a3)
    -- Line: 87
    -- upvalues: u17 (val), QualityConfig (val)
    -- types: a1: string, a2: number?, a3: function
    local v1 = u17.classOf(a1)

    if not v1 then
        return "Standard", {}, false
    end

    local v2 = QualityConfig.EligibilityByClass[v1]
    v1 = QualityConfig.rollOutcome(a2, a3())

    if v2 and not table.find(v2, v1) then
        v1 = "Standard"
    end

    local v3, v4 = QualityConfig.rollStats(u17.bandsFor(a1), v1, a3, u17.rollValues(a1, v1))

    return v1, v3, v4
end

function u17.rollValues(a1, a2)
    -- Line: 113
    -- upvalues: QualityConfig (val), Config (val), u17 (val)
    -- types: a1: string, a2: string
    if QualityConfig.Bands[a1] then
        return nil
    end

    if Config.Factory.MachineStandardBands[a1] then
        return QualityConfig.machineRollValues(a1, a2)
    end

    local v1 = u17.classOf(a1)

    if v1 ~= "Tool" and v1 ~= "Weapon" then
        return nil
    end

    return QualityConfig.rollValuesFor(v1, a2)
end

return u17