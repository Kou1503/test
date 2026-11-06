-- Script path: game:GetService("ReplicatedStorage").Shared.Palette
-- Decompile time: 5.08 ms

local FlowerConfig = require(script.Parent.Config.FlowerConfig)
local AppearanceConfig = require(script.Parent.Config.AppearanceConfig)
local DisplayNames = require(script.Parent.DisplayNames)
local u17 = {}
local u18 = {}
u18.Wood = Color3.fromRGB(224, 223, 227)
u18.Stone = Color3.fromRGB(140, 140, 140)
u18.IronOre = Color3.fromRGB(160, 120, 95)
u18.Coal = Color3.fromRGB(45, 45, 50)
u18.TreeSapling = Color3.fromRGB(96, 176, 78)
u18.IronIngot = Color3.fromRGB(200, 205, 215)
u18.Gear = Color3.fromRGB(170, 175, 185)
u18.Rail = Color3.fromRGB(163, 162, 165)
u18.RailCorner = Color3.fromRGB(163, 162, 165)
u18.RailRamp = Color3.fromRGB(163, 162, 165)
u18.RailBooster = Color3.fromRGB(196, 160, 82)
u18.RailRampBooster = Color3.fromRGB(196, 160, 82)
u18.Minecart = Color3.fromRGB(150, 110, 60)
u18.IronRailcart = Color3.fromRGB(120, 124, 132)
u18.SlimeGel = Color3.fromRGB(120, 220, 130)
u18.PinkSlimeGel = Color3.fromRGB(240, 130, 190)
u18.WildGrass = Color3.fromRGB(110, 165, 80)
u18.BlueSlimeGel = Color3.fromRGB(86, 150, 236)
u18.OrangeSlimeGel = Color3.fromRGB(245, 145, 55)
u18.PurpleSlimeGel = Color3.fromRGB(150, 90, 235)
u18.GrassBlock = Color3.fromRGB(170, 170, 170)
u18.DirtBlock = Color3.fromRGB(170, 170, 170)
u18.WoodBlock = Color3.fromRGB(224, 223, 227)
u18.StoneBlock = Color3.fromRGB(224, 223, 227)
u18.IronBlock = Color3.fromRGB(224, 223, 227)
u18.WaterBlock = Color3.fromRGB(105, 150, 255)
u18.FarmSoil = Color3.fromRGB(122, 92, 62)
u18.GrassCap = Color3.fromRGB(163, 162, 165)
u18.WoodEnd = Color3.fromRGB(224, 223, 227)
u18.FrozenBlueShiny = Color3.fromRGB(150, 220, 255)
u18.FieryBlueShiny = Color3.fromRGB(90, 150, 255)
u18.ElectricBlueShiny = Color3.fromRGB(70, 210, 255)
u18.OceanBlueShiny = Color3.fromRGB(40, 130, 200)
u18.StormBlueShiny = Color3.fromRGB(120, 140, 200)
u18.MidnightBlueShiny = Color3.fromRGB(45, 60, 140)
u18.EmberRedShiny = Color3.fromRGB(255, 110, 60)
u18.CinderRedShiny = Color3.fromRGB(150, 45, 35)
u18.BlazeRedShiny = Color3.fromRGB(255, 70, 30)
u18.MagmaRedShiny = Color3.fromRGB(220, 60, 20)
u18.InfernoRedShiny = Color3.fromRGB(255, 30, 40)
u18.PhoenixRedShiny = Color3.fromRGB(200, 35, 55)
u18.DawnYellowShiny = Color3.fromRGB(255, 225, 150)
u18.SolarYellowShiny = Color3.fromRGB(255, 210, 40)
u18.RadiantYellowShiny = Color3.fromRGB(255, 240, 90)
u18.SunburstYellowShiny = Color3.fromRGB(255, 180, 30)
u18.ZenithYellowShiny = Color3.fromRGB(255, 250, 200)
u18.CoronaYellowShiny = Color3.fromRGB(240, 170, 20)
u18.BentGearShiny = Color3.fromRGB(210, 170, 80)
u18.CrackedLensShiny = Color3.fromRGB(190, 230, 210)
u18.TarnishedPlateShiny = Color3.fromRGB(160, 140, 110)
u18.SpentCoilShiny = Color3.fromRGB(220, 130, 70)
u18.Wheat = Color3.fromRGB(214, 186, 92)
u18.Carrot = Color3.fromRGB(226, 126, 48)
u18.Tomato = Color3.fromRGB(198, 58, 48)
u18.Onion = Color3.fromRGB(206, 178, 190)
u18.GoldenWheatSheaf = Color3.fromRGB(255, 214, 84)
u18.HeirloomCarrot = Color3.fromRGB(255, 150, 60)
u18.SunRipenedTomato = Color3.fromRGB(236, 66, 52)
u18.PearlOnion = Color3.fromRGB(242, 226, 236)
u18.WheatSeeds = Color3.fromRGB(178, 158, 104)
u18.CarrotSeeds = Color3.fromRGB(180, 140, 96)
u18.TomatoSeeds = Color3.fromRGB(170, 120, 100)
u18.OnionSeeds = Color3.fromRGB(174, 158, 160)
u18.Merchant = Color3.fromRGB(210, 170, 90)
u18.BlockDealer = Color3.fromRGB(150, 150, 160)
u18.SeedDealer = Color3.fromRGB(120, 190, 110)
u18.Berries = Color3.fromRGB(196, 48, 74)
u18.Dough = Color3.fromRGB(232, 224, 200)
u18.Bread = Color3.fromRGB(196, 150, 96)
u18.GoldenDough = Color3.fromRGB(255, 226, 130)
u18.GoldenBread = Color3.fromRGB(255, 196, 64)
u18.RoastedCarrot = Color3.fromRGB(184, 92, 36)
u18.TomatoSauce = Color3.fromRGB(176, 40, 34)
u18.BerryJam = Color3.fromRGB(150, 28, 62)
u18.CarrotCake = Color3.fromRGB(222, 160, 98)
u18.BerryPie = Color3.fromRGB(170, 70, 110)
u18.VegetableSoup = Color3.fromRGB(196, 140, 60)
u18.JumboBerryPie = Color3.fromRGB(200, 50, 110)
u18.SlimeSoup = Color3.fromRGB(120, 210, 100)
u18.PinkberryPie = Color3.fromRGB(240, 130, 190)
u18.HeartySoup = Color3.fromRGB(230, 90, 120)
u18.RocketCarrot = Color3.fromRGB(250, 120, 30)
u18.Bluetato = Color3.fromRGB(86, 150, 236)
u18.CandyCorn = Color3.fromRGB(250, 160, 40)
u18.CookingStation = Color3.fromRGB(146, 108, 84)
u18.Toolsmith = Color3.fromRGB(96, 100, 110)
u18.WorkbenchII = Color3.fromRGB(120, 124, 136)
u18.LightingBench = Color3.fromRGB(206, 190, 150)
u18.Torch = Color3.fromRGB(255, 186, 104)
u18.Lantern = Color3.fromRGB(255, 214, 138)
u18.WallLantern = Color3.fromRGB(255, 208, 150)
u18.Glass = Color3.fromRGB(214, 232, 236)
u18.Sand = Color3.fromRGB(224, 223, 227)
u18.Clay = Color3.fromRGB(224, 223, 227)
u18.ClayBlock = Color3.fromRGB(224, 223, 227)
u18.SandBlock = Color3.fromRGB(224, 223, 227)
u18.BrickBlock = Color3.fromRGB(224, 223, 227)
u18.CoalBlock = Color3.fromRGB(224, 223, 227)
u18.WoodFence = Color3.fromRGB(224, 223, 227)
u18.WoodFenceGate = Color3.fromRGB(224, 223, 227)
u18.WoodTrapdoor = Color3.fromRGB(224, 223, 227)
u18.WoodChair = Color3.fromRGB(224, 223, 227)
u18.WoodTable = Color3.fromRGB(224, 223, 227)
u18.StoneBrickFence = Color3.fromRGB(224, 223, 227)
u18.WoodDoor = Color3.fromRGB(224, 223, 227)
u18.VaultDoor = Color3.fromRGB(224, 223, 227)
u18.Bakehouse = Color3.fromRGB(112, 78, 60)
u18.WateringCan = Color3.fromRGB(96, 150, 110)
u18.Sign = Color3.fromRGB(224, 223, 227)
u18.BuilderBench = Color3.fromRGB(150, 140, 122)
u18.WoodSlab = Color3.fromRGB(224, 223, 227)
u18.WoodStairs = Color3.fromRGB(224, 223, 227)
u18.StoneSlab = Color3.fromRGB(224, 223, 227)
u18.StoneStairs = Color3.fromRGB(224, 223, 227)
u18.StoneBrick = Color3.fromRGB(224, 223, 227)
u18.StoneBrickSlab = Color3.fromRGB(224, 223, 227)
u18.StoneBrickStairs = Color3.fromRGB(224, 223, 227)
u18.IronSlab = Color3.fromRGB(224, 223, 227)
u18.IronStairs = Color3.fromRGB(224, 223, 227)
u18.BrickSlab = Color3.fromRGB(224, 223, 227)
u18.BrickStairs = Color3.fromRGB(224, 223, 227)
u18.CoalSlab = Color3.fromRGB(224, 223, 227)
u18.CoalStairs = Color3.fromRGB(224, 223, 227)
u18.SandSlab = Color3.fromRGB(224, 223, 227)
u18.SandStairs = Color3.fromRGB(224, 223, 227)
u18.GlassBlock = Color3.fromRGB(206, 230, 238)
u18.GlassPane = Color3.fromRGB(206, 230, 238)
u18.GreenSlimeBlock = Color3.fromRGB(120, 220, 130)
u18.BlueSlimeBlock = Color3.fromRGB(86, 150, 236)
u18.OrangeSlimeBlock = Color3.fromRGB(245, 145, 55)
u18.PinkSlimeBlock = Color3.fromRGB(240, 130, 190)
u18.JumboBerry = Color3.fromRGB(232, 62, 92)
u18.BerryBushSeed = Color3.fromRGB(122, 96, 68)
u18.BerryBush = Color3.fromRGB(74, 118, 62)
u18.Bucket = Color3.fromRGB(150, 155, 165)
u18.WaterBucket = Color3.fromRGB(90, 150, 200)
u18.Workbench = Color3.fromRGB(160, 116, 70)
u18.Furnace = Color3.fromRGB(110, 110, 118)
u18.StorageChest = Color3.fromRGB(150, 110, 60)
u18.WeaponDisplay = Color3.fromRGB(150, 110, 60)
u18.WeaponStand = Color3.fromRGB(150, 110, 60)
u18.ShinyTank = Color3.fromRGB(190, 225, 235)
u18.FlowerPot = Color3.fromRGB(176, 104, 72)
u18.LargeFlowerPot = Color3.fromRGB(176, 104, 72)
u18.PlateDisplay = Color3.fromRGB(232, 228, 220)
u18.WoodPickaxe = Color3.fromRGB(140, 120, 100)
u18.StonePickaxe = Color3.fromRGB(150, 150, 155)
u18.StoneAxe = Color3.fromRGB(140, 148, 145)
u18.StoneSword = Color3.fromRGB(160, 160, 168)
u18.Plow = Color3.fromRGB(126, 104, 78)
u18.Pollinator = Color3.fromRGB(214, 196, 120)
u18.WoodAxe = Color3.fromRGB(130, 140, 120)
u18.IronPickaxe = Color3.fromRGB(170, 140, 110)
u18.IronAxe = Color3.fromRGB(150, 175, 140)
u18.WoodSword = Color3.fromRGB(170, 140, 100)
u18.IronSword = Color3.fromRGB(200, 205, 215)
local u803 = Color3.fromRGB(200, 200, 205)
local u804 = {}
u804.Red = Color3.fromRGB(214, 68, 72)
u804.Yellow = Color3.fromRGB(240, 205, 90)
u804.Blue = Color3.fromRGB(86, 130, 226)
u804.White = Color3.fromRGB(238, 238, 232)
u804.Orange = Color3.fromRGB(244, 146, 54)
u804.Pink = Color3.fromRGB(240, 140, 190)
u804.Purple = Color3.fromRGB(160, 104, 214)
u804.Green = Color3.fromRGB(96, 194, 104)
u804.Sky = Color3.fromRGB(132, 206, 240)
u804.Lime = Color3.fromRGB(196, 224, 96)
u804.Black = Color3.fromRGB(46, 38, 58)
local Species = FlowerConfig.Species
local u861 = {}
u861.Purple = Color3.fromHex("#a96cff")
u861.Green = Color3.fromHex("#7eff87")
u861.Lime = Color3.fromHex("#bcff02")
u861.Orange = Color3.fromHex("#ffa200")
u861.Pink = Color3.fromHex("#ff95ca")
u861.Red = Color3.fromHex("#ff3437")
u861.Sky = Color3.fromHex("#77c9ff")
u861.Blue = Color3.fromHex("#547cff")
u861.Yellow = Color3.fromHex("#edf029")
u861.White = Color3.fromHex("#fcfcfc")

local function dyedColorWord(a1) -- Line: 314; upvalues: u804 (val); types: a1: string
    local v1, v2 = string.match(a1, "^(%u%l+)(%u%l+)Block$")

    if v1 then
        if v2 ~= "Clay" and v2 ~= "Neon" then
            return nil, nil
        end

        if u804[v1] then
            return v1, v2
        end
    end

    return nil, nil
end

function u17.colorFor(a1)
    -- Line: 322
    -- upvalues: u18 (val), u804 (val), u861 (val), Species (val), u803 (val)
    -- types: a1: string
    local v1, v2
    local v3 = u18[a1]

    if v3 then
        return v3
    end

    local v4, v5 = string.match(a1, "^(%u%l+)(%u%l+)Block$")

    if not v4 then
        v1 = nil
        v2 = nil
    elseif v5 == "Clay" then
        if not u804[v4] then
            v1 = nil
            v2 = nil
        else
            v1 = v4
            v2 = v5
        end
    elseif v5 ~= "Neon" or not u804[v4] then
        v1 = nil
        v2 = nil
    else
        v1 = v4
        v2 = v5
    end

    if v1 then
        return (if v2 ~= "Clay" then nil else u861[v1]) or u804[v1]
    end

    v5 = nil
    local v6 = nil

    for i, j in Species, v5, v6 do
        if string.sub(a1, -#j) == j then
            for k, n in u804 do
                if string.find(a1, k, 1, true) then
                    return n
                end
            end
        end
    end

    return u803
end

local u894 = {
    GrassBlock = Enum.Material.SmoothPlastic,
    DirtBlock = Enum.Material.SmoothPlastic,
    Wood = Enum.Material.Plastic,
    WoodBlock = Enum.Material.Plastic,
    StoneBlock = Enum.Material.SmoothPlastic,
    IronBlock = Enum.Material.Plastic,
    WaterBlock = Enum.Material.Glass,
    FarmSoil = Enum.Material.SmoothPlastic,
    WorkbenchII = Enum.Material.Metal,
    Torch = Enum.Material.Neon,
    FrozenBlueShiny = Enum.Material.Neon,
    FieryBlueShiny = Enum.Material.Neon,
    ElectricBlueShiny = Enum.Material.Neon,
    OceanBlueShiny = Enum.Material.Neon,
    StormBlueShiny = Enum.Material.Neon,
    MidnightBlueShiny = Enum.Material.Neon,
    EmberRedShiny = Enum.Material.Neon,
    CinderRedShiny = Enum.Material.Neon,
    BlazeRedShiny = Enum.Material.Neon,
    MagmaRedShiny = Enum.Material.Neon,
    InfernoRedShiny = Enum.Material.Neon,
    PhoenixRedShiny = Enum.Material.Neon,
    DawnYellowShiny = Enum.Material.Neon,
    SolarYellowShiny = Enum.Material.Neon,
    RadiantYellowShiny = Enum.Material.Neon,
    SunburstYellowShiny = Enum.Material.Neon,
    ZenithYellowShiny = Enum.Material.Neon,
    CoronaYellowShiny = Enum.Material.Neon,
    BentGearShiny = Enum.Material.Neon,
    CrackedLensShiny = Enum.Material.Neon,
    TarnishedPlateShiny = Enum.Material.Neon,
    SpentCoilShiny = Enum.Material.Neon,
    Lantern = Enum.Material.Neon,
    WallLantern = Enum.Material.Neon,
    Glass = Enum.Material.Glass,
    Sand = Enum.Material.Plastic,
    Clay = Enum.Material.Plastic,
    ClayBlock = Enum.Material.Plastic,
    SandBlock = Enum.Material.Plastic,
    BrickBlock = Enum.Material.Plastic,
    CoalBlock = Enum.Material.Plastic,
    WoodFence = Enum.Material.Plastic,
    WoodFenceGate = Enum.Material.Plastic,
    WoodTrapdoor = Enum.Material.Plastic,
    WoodChair = Enum.Material.Plastic,
    WoodTable = Enum.Material.Plastic,
    StoneBrickFence = Enum.Material.Plastic,
    WoodDoor = Enum.Material.Plastic,
    VaultDoor = Enum.Material.Plastic,
    Bakehouse = Enum.Material.Brick,
    WateringCan = Enum.Material.Metal,
    Sign = Enum.Material.Plastic,
    WoodSlab = Enum.Material.Plastic,
    WoodStairs = Enum.Material.Plastic,
    StoneSlab = Enum.Material.SmoothPlastic,
    StoneStairs = Enum.Material.SmoothPlastic,
    StoneBrick = Enum.Material.Plastic,
    StoneBrickSlab = Enum.Material.Plastic,
    StoneBrickStairs = Enum.Material.Plastic,
    IronSlab = Enum.Material.Plastic,
    IronStairs = Enum.Material.Plastic,
    BrickSlab = Enum.Material.Plastic,
    BrickStairs = Enum.Material.Plastic,
    CoalSlab = Enum.Material.Plastic,
    CoalStairs = Enum.Material.Plastic,
    SandSlab = Enum.Material.Plastic,
    SandStairs = Enum.Material.Plastic,
    GlassBlock = Enum.Material.Glass,
    GlassPane = Enum.Material.Glass,
    GreenSlimeBlock = Enum.Material.Plastic,
    BlueSlimeBlock = Enum.Material.Plastic,
    OrangeSlimeBlock = Enum.Material.Plastic,
    PinkSlimeBlock = Enum.Material.Plastic,
}
local u968 = {}
u968.FarmSoil = Color3.fromRGB(74, 54, 36)
u17.FertilizedSoil = Color3.fromRGB(104, 98, 58)
u17.FertilizedSoilWet = Color3.fromRGB(62, 60, 34)
u17.FertilizerPellet = Color3.fromRGB(20, 138, 130)

function u17.hydratedColorFor(a1) -- Line: 479; upvalues: u968 (val), u17 (val); types: a1: string
    return u968[a1] or u17.colorFor(a1)
end

function u17.materialFor(a1) -- Line: 483; upvalues: u894 (val), u804 (val); types: a1: string
    local v1
    local v2 = u894[a1]

    if v2 then
        return v2
    end

    local v3, v4 = string.match(a1, "^(%u%l+)(%u%l+)Block$")

    if (if not v3 then
        nil
    else
        if v4 == "Clay" then
            if not u804[v3] then nil else v4
        else
            if v4 ~= "Neon" then nil else if not u804[v3] then nil else v4)
        == "Neon" then
        return Enum.Material.Neon
    end

    if v1 == "Clay" then
        return Enum.Material.Plastic
    end

    return Enum.Material.SmoothPlastic
end

local u991 = {WaterBlock = 0.25, GlassBlock = 0.6, GlassPane = 0.55}

function u17.transparencyFor(a1) -- Line: 512; upvalues: u991 (val); types: a1: string
    return u991[a1] or 0
end

function u17.variantFor(a1) -- Line: 535; upvalues: AppearanceConfig (val); types: a1: string
    return AppearanceConfig.of(a1).variant or ""
end

function u17.capFor(a1) -- Line: 552; upvalues: AppearanceConfig (val), u17 (val); types: a1: string
    local cap = AppearanceConfig.of(a1).cap

    if not cap then
        return nil
    end

    local materialName = cap.materialName
    local v1 = if not materialName then nil else Enum.Material[materialName]

    return {
        variant = cap.variant,
        color = u17.colorFor(cap.colorId),
        material = v1 or Enum.Material.Grass,
        heightStuds = cap.heightStuds,
        bothEnds = cap.bothEnds == true,
    }
end

u17.DisplayNames = DisplayNames.Overrides
u17.displayName = DisplayNames.of
local u997 = {"I", "II", "III", "IV", "V"}

function u17.roman(a1) -- Line: 584; upvalues: u997 (val); types: a1: number
    return u997[a1] or tostring(a1)
end

return u17