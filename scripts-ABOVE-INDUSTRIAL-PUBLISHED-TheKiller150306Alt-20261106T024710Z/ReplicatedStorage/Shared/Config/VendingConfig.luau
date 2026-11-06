-- Script path: game:GetService("ReplicatedStorage").Shared.Config.VendingConfig
-- Decompile time: 0.70 ms

local u0 = {
    Modes = {"Sell", "Buy"},
    States = {
        Open = "Open",
        SoldOut = "SoldOut",
        NoCoins = "NoCoins",
        Full = "Full",
        Offline = "Offline",
    },
    StockCap = 9999,
    MaxTradeQuantity = 100,
    CoinCap = 10000000,
    MaxPerIsland = 250,
    SellerTaxPercent = 5,
    MinimumTaxCoins = 1,
    ScamFlagCoins = 200000,
    MaxPrice = 100000000,
    Guidance = {
        MinimumSamples = 8,
        SampleSize = 64,
        LowPercentile = 25,
        HighPercentile = 75,
        MaxAgeSeconds = 604800,
    },
    OwnerLogSize = 20,
}

function u0.taxOn(a1) -- Line: 140; upvalues: u0 (val); types: a1: number
    if a1 <= 0 then
        return 0
    end

    return (math.max(u0.MinimumTaxCoins, (math.floor(a1 * u0.SellerTaxPercent / 100))))
end

function u0.proceedsOf(a1) -- Line: 148; upvalues: u0 (val); types: a1: number
    return (math.max(0, a1 - (u0.taxOn(a1))))
end

function u0.isValidPrice(a1) -- Line: 153; upvalues: u0 (val)
    local v1 = false

    if type(a1) == "number" then
        v1 = false

        if a1 == math.floor(a1) then
            v1 = false

            if a1 > 0 then
                v1 = a1 <= u0.MaxPrice
            end
        end
    end

    return v1
end

u0.UnlitBulbRgb = {r = 80, g = 80, b = 80}
u0.ClosedGlassRgb = {r = 0, g = 0, b = 0}
u0.ClosedGlassTransparency = 0.3
u0.ShowcaseSpinDegreesPerSecond = 30

function u0.isValidMode(a1) -- Line: 172; upvalues: u0 (val)
    local v1 = false

    if type(a1) == "string" then
        v1 = table.find(u0.Modes, a1) ~= nil
    end

    return v1
end

return u0