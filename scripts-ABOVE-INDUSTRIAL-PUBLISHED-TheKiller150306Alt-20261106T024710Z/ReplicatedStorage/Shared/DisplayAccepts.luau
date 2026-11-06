-- Script path: game:GetService("ReplicatedStorage").Shared.DisplayAccepts
-- Decompile time: 0.47 ms

local Config = require(script.Parent.Config)
return {
    takes = function(a1, a2) -- Line: 11; upvalues: Config (val); types: a1: string?, a2: string
        if a1 == nil then
            return true
        end

        if a1 == "Weapon" then
            local v1 = true

            if Config.Weapon.Weapons[a2] == nil then
                v1 = Config.Tool.Tools[a2] ~= nil
            end

            return v1
        end

        if a1 == "Shiny" then
            return Config.Shiny.isShiny(a2)
        end

        if a1 == "Flower" then
            return Config.Flower.isFlower(a2)
        end

        if a1 == "Food" then
            return Config.Food.isFood(a2) and Config.Recipe.Food[a2] ~= nil
        end

        return false
    end,
}