-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.VendingController
-- Decompile time: 21.89 ms

local Players = game:GetService("Players")
local u11 = (require(script.Parent.DeviceMode)).touchOnly()
local v1 = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(v1.Config)
local CoinAmount = require(v1.CoinAmount)
local DisplayNames = require(v1.DisplayNames)
local Format = require(v1.Format)
local ItemStats = require(v1.ItemStats)
local Remotes = require(v1.Remotes)
local u46 = require(script.Parent.Parent.Ui)
local CopyPicker = require(script.Parent.Parent.CopyPicker)
local BuildController = require(script.Parent.BuildController)
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local ItemIcon = require(script.Parent.ItemIcon)
local ItemTooltip = require(script.Parent.ItemTooltip)
local u73 = {}
local LocalPlayer = Players.LocalPlayer
local u78 = Remotes.get(Remotes.VendingUpdate)
local u81 = Remotes.get(Remotes.RequestVendingConfigure)
local u84 = Remotes.get(Remotes.RequestVendingStock)
local u87 = Remotes.get(Remotes.RequestVendingTrade)
local u88 = {}
u88.Open = {label = "OPEN", tint = Color3.fromRGB(130, 230, 160)}
u88.SoldOut = {label = "SOLD OUT", tint = Color3.fromRGB(240, 150, 140)}
u88.NoCoins = {label = "OUT OF COINS", tint = Color3.fromRGB(240, 190, 120)}
u88.Full = {label = "FULL", tint = Color3.fromRGB(240, 190, 120)}
u88.Offline = {label = "CLOSED", tint = Color3.fromRGB(150, 162, 180)}
local u119 = nil
local u120 = nil
local u121 = nil
local u122 = {}
local u123 = nil
local u124 = nil
local u125 = 1
local u126 = nil

local function trackDraft(a1) -- Line: 93; types: a1: userdata
    (a1:GetPropertyChangedSignal("Text")):Connect(function() -- Line: 94; upvalues: a1 (val)
        if a1:IsFocused() then
            a1:SetAttribute("Draft", true)
        end
    end)
end

local coins = Format.coins
local u129 = 0
local u130 = nil
local u131 = nil
local u132 = nil
local u133 = ""
local u134 = 0

local function clearPinned() -- Line: 117; upvalues: u120 (ref)
    if u120 then
        local ShopSwitch = u120:FindFirstChild("ShopSwitch")

        if ShopSwitch then
            ShopSwitch:Destroy()
        end
    end
end

local function clearBody() -- Line: 126; upvalues: u121 (ref), u130 (ref)
    local v1 = {u121, u130}
    local v2 = nil
    local v3 = nil

    for i, j in v1, v2, v3 do
        if j then
            for k, n in j:GetChildren() do
                if not n:IsA("UIListLayout") and not n:IsA("UIPadding") then
                    n:Destroy()
                end
            end
        end
    end
end

local function sideRow(a1) -- Line: 139; upvalues: u134 (ref), u130 (ref); types: a1: number
    u134 = u134 + 1
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, a1)
    Frame.BackgroundTransparency = 1
    Frame.LayoutOrder = u134
    Frame.Parent = u130

    return Frame
end

local function row(a1) -- Line: 149; upvalues: u129 (ref), u121 (ref); types: a1: number
    u129 = u129 + 1
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, a1)
    Frame.BackgroundTransparency = 1
    Frame.LayoutOrder = u129
    Frame.Parent = u121

    return Frame
end

local function label(a1, a2, a3, a4, a5)
    -- Line: 159
    -- upvalues: u46 (val)
    -- types: a1: userdata, a2: string, a3: number, a4: userdata, a5: boolean?
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.fromScale(1, 1)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = a2
    TextLabel.TextColor3 = a4
    local Bold = if not a5 then u46.Font.Regular else u46.Font.Bold
    TextLabel.FontFace = Bold
    TextLabel.TextSize = a3
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextWrapped = true
    TextLabel.Parent = a1

    return TextLabel
end

local function button(a1, a2, a3, a4, a5)
    -- Line: 174
    -- upvalues: u46 (val)
    -- types: a1: userdata, a2: string, a3: userdata, a4: userdata, a5: function
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromScale(1, 1)
    TextButton.BackgroundColor3 = a4
    TextButton.TextColor3 = a3
    TextButton.FontFace = u46.Font.Bold
    TextButton.TextSize = 12
    TextButton.Text = a2
    TextButton.AutoButtonColor = true
    TextButton.Parent = a1

    u46.corner(TextButton, 5)
    TextButton.Activated:Connect(a5)

    return TextButton
end

local function configure(a1) -- Line: 189; upvalues: u123 (ref), u81 (val)
    if u123 then
        u81:FireServer(u123, a1)
    end
end

local function renderShopFront(a1)
    -- Line: 198
    -- upvalues: u88 (val), label (val), u129 (ref), u121 (ref), ItemIcon (val), Config (val), ItemStats (val)
    -- upvalues: coins (val)
    local Offline = u88[a1.state] or u88.Offline
    u129 = u129 + 1
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 18)
    Frame.BackgroundTransparency = 1
    Frame.LayoutOrder = u129
    Frame.Parent = u121

    label(Frame, Offline.label, 13, Offline.tint, true)

    if not a1.itemId then
        u129 = u129 + 1
        local Frame_2 = Instance.new("Frame")
        Frame_2.Size = UDim2.new(1, 0, 0, 34)
        Frame_2.BackgroundTransparency = 1
        Frame_2.LayoutOrder = u129
        Frame_2.Parent = u121

        label(Frame_2, "This shop hasn't been set up yet.", 12, Color3.fromRGB(150, 162, 180))

        return
    end

    u129 = u129 + 1
    local Frame_3 = Instance.new("Frame")
    Frame_3.Size = UDim2.new(1, 0, 0, 46)
    Frame_3.BackgroundTransparency = 1
    Frame_3.LayoutOrder = u129
    Frame_3.Parent = u121
    local Frame_4 = Instance.new("Frame")
    Frame_4.Size = UDim2.fromOffset(38, 38)
    Frame_4.Position = UDim2.fromOffset(0, 4)
    Frame_4.BackgroundTransparency = 1
    Frame_4.Parent = Frame_3

    ItemIcon.render(Frame_4, a1.itemId, 38, 5)

    local Frame_5 = Instance.new("Frame")
    Frame_5.Size = UDim2.new(1, -48, 1, 0)
    Frame_5.Position = UDim2.fromOffset(48, 0)
    Frame_5.BackgroundTransparency = 1
    Frame_5.Parent = Frame_3
    local v1 = label(Frame_5, if a1.mode ~= "Sell" then "BUYING" else "SELLING", 10, if a1.mode ~= "Sell" then Color3.fromRGB(240, 130, 120) else Color3.fromRGB(120, 215, 140), true)
    v1.Size = UDim2.new(1, 0, 0, 12)
    local v2 = label(Frame_5, if not Config.Recipe.isUnique(a1.itemId) then a1.itemName else if a1.quality ~= "Standard" then ("%*  ·  %*"):format(a1.itemName, if not a1.quality then "UNIQUE" else string.upper(a1.quality)) else a1.itemName, 15, Color3.fromRGB(235, 240, 250), true)
    v2.Size = UDim2.new(1, 0, 0, 20)
    v2.Position = UDim2.fromOffset(0, 12)
    v2 = label(Frame_5, if a1.mode ~= "Sell" then ("wants %* more  ·  %* collected"):format(a1.wanted, a1.stock) else ("%* in stock"):format(a1.stock), 12, Color3.fromRGB(150, 162, 180))
    v2.Size = UDim2.new(1, 0, 0, 16)
    v2.Position = UDim2.fromOffset(0, 33)

    if type(a1.stats) == "table" then
        local v3
        v2 = Config.Tool.Tools[a1.itemId]
        local v4 = false

        if v2 ~= nil then
            v4 = Config.Tool.UnrolledTiers[v2.tier or ""] == true
        end

        v2 = {}
        local of = ItemStats.of
        local itemId = a1.itemId

        for i, j in of(Config, itemId, if not v4 then a1.stats else nil) do
            v3 = ItemStats.paint(j)
            table.insert(v2, (("%*  %*"):format(j.label, v3)))
        end

        if #v2 > 0 then
            u129 = u129 + 1
            local Frame_6 = Instance.new("Frame")
            Frame_6.Size = UDim2.new(1, 0, 0, 18)
            Frame_6.BackgroundTransparency = 1
            Frame_6.LayoutOrder = u129
            Frame_6.Parent = u121
            v4 = label(Frame_6, table.concat(v2, "     "), 12, Color3.fromRGB(200, 208, 222))
            v4.RichText = true
        end
    end

    if a1.price then
        local v5 = if a1.mode ~= "Sell" then "paid each" else "each"
        u129 = u129 + 1
        local Frame_7 = Instance.new("Frame")
        Frame_7.Size = UDim2.new(1, 0, 0, 24)
        Frame_7.BackgroundTransparency = 1
        Frame_7.LayoutOrder = u129
        Frame_7.Parent = u121

        label(Frame_7, ("%* coins %*"):format(coins(a1.price), v5), 17, Color3.fromRGB(255, 226, 130), true)
    end

    if not a1.guidance then
        u129 = u129 + 1
        local Frame_9 = Instance.new("Frame")
        Frame_9.Size = UDim2.new(1, 0, 0, 18)
        Frame_9.BackgroundTransparency = 1
        Frame_9.LayoutOrder = u129
        Frame_9.Parent = u121

        label(Frame_9, "Not enough recent sales for price guidance.", 11, Color3.fromRGB(130, 145, 170))
    else
        local guidance = a1.guidance
        u129 = u129 + 1
        local Frame_8 = Instance.new("Frame")
        Frame_8.Size = UDim2.new(1, 0, 0, 30)
        Frame_8.BackgroundTransparency = 1
        Frame_8.LayoutOrder = u129
        Frame_8.Parent = u121

        label(Frame_8, ("Recent median %*  ·  typical %*–%*  (%* sales)"):format(coins(guidance.median), coins(guidance.low), coins(guidance.high), guidance.samples), 11, Color3.fromRGB(140, 175, 220))
    end

    if a1.flagged then
        u129 = u129 + 1
        local Frame_10 = Instance.new("Frame")
        Frame_10.Size = UDim2.new(1, 0, 0, 30)
        Frame_10.BackgroundTransparency = 1
        Frame_10.LayoutOrder = u129
        Frame_10.Parent = u121

        label(Frame_10, "This price is well above what this item usually sells for.", 11, Color3.fromRGB(245, 180, 110))
    end
end

local function renderAction(a1)
    -- Line: 298
    -- upvalues: u129 (ref), u121 (ref), label (val), Config (val), u122 (ref), u125 (ref), coins (val), u46 (val)
    -- upvalues: button (val), u123 (ref), u87 (val)
    if a1.manage then
        return
    end

    u129 = u129 + 1
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 32)
    Frame.BackgroundTransparency = 1
    Frame.LayoutOrder = u129
    Frame.Parent = u121

    if a1.state == "Open" and a1.price then
        local u20 = a1.mode == "Sell"
        local u44 = math.max(math.min(Config.Vending.MaxTradeQuantity, if not u20 then math.min(a1.wanted or 0, u122[a1.itemId] or 0) else a1.stock or 0), 1)
        u125 = math.clamp(u125, 1, u44)

        local function caption() -- Line: 320; upvalues: u125 (upval), u20 (val), coins (upval), a1 (val)
            local v1 = if u125 ~= 1 then tostring(u125) else "ONE"

            if u20 then
                return (("BUY %* - %* COINS"):format(v1, (coins(a1.price * u125))))
            end

            return (("SELL %* - YOU GET %* COINS"):format(v1, (coins(a1.proceeds * u125))))
        end

        local TextBox = Instance.new("TextBox")
        TextBox.Size = UDim2.new(0, 56, 1, 0)
        TextBox.BackgroundColor3 = Color3.fromRGB(30, 34, 42)
        TextBox.TextColor3 = Color3.fromRGB(235, 240, 250)
        TextBox.Name = "QuantityBox"
        TextBox.PlaceholderText = "1"
        TextBox.Text = tostring(u125)
        TextBox.FontFace = u46.Font.Bold
        TextBox.TextSize = 13
        TextBox.ClearTextOnFocus = false
        TextBox.Parent = Frame

        u46.corner(TextBox, 5)

        local Frame_2 = Instance.new("Frame")
        Frame_2.Size = UDim2.new(1, -62, 1, 0)
        Frame_2.Position = UDim2.fromOffset(62, 0)
        Frame_2.BackgroundTransparency = 1
        Frame_2.Parent = Frame
        local v1 = if u125 ~= 1 then tostring(u125) else "ONE"
        local u153 = button(
            Frame_2,
            if not u20 then ("SELL %* - YOU GET %* COINS"):format(v1, (coins(a1.proceeds * u125))) else ("BUY %* - %* COINS"):format(v1, (coins(a1.price * u125))),
            Color3.fromRGB(215, 245, 225),
            Color3.fromRGB(40, 80, 58),
            function() -- Line: 348; upvalues: u123 (upval), u87 (upval), a1 (val), u125 (upval)
                if u123 then
                    u87:FireServer(u123, a1.price, a1.itemId, u125)
                end
            end
        )

        ;(TextBox:GetPropertyChangedSignal("Text")):Connect(function()
            -- Line: 358
            -- upvalues: TextBox (val), u44 (ref), u125 (upval), u153 (val), u20 (val), coins (upval), a1 (val)
            local v1 = string.gsub(string.gsub(TextBox.Text, "%D", ""), "^0+", "")
            local v2 = tonumber(v1)

            if v2 and u44 < v2 then
                v1 = tostring(u44)
                v2 = u44
            end

            if v1 ~= TextBox.Text then
                TextBox.Text = v1
                return
            end

            u125 = v2 or 1
            v2 = if u125 ~= 1 then tostring(u125) else "ONE"
            local v3 = if not u20 then
                ("SELL %* - YOU GET %* COINS"):format(v2, (coins(a1.proceeds * u125)))
            else
                ("BUY %* - %* COINS"):format(v2, (coins(a1.price * u125)))
            u153.Text = v3
        end)

        TextBox.FocusLost:Connect(function() -- Line: 373; upvalues: TextBox (val), u125 (upval)
            TextBox.Text = tostring(u125)
        end)

        ;(TextBox:GetPropertyChangedSignal("Text")):Connect(function() -- Line: 94; upvalues: TextBox (val)
            if TextBox:IsFocused() then
                TextBox:SetAttribute("Draft", true)
            end
        end)

        return
    end

    local v2 = label(Frame, "Nothing to buy here right now.", 12, Color3.fromRGB(130, 145, 170))
    v2.TextXAlignment = Enum.TextXAlignment.Center
end

local function renderControls(a1)
    -- Line: 381
    -- upvalues: label (val), u129 (ref), u121 (ref), button (val), u123 (ref), u81 (val), u46 (val), CoinAmount (val)
    -- upvalues: coins (val), DisplayNames (val), u84 (val), u134 (ref), u130 (ref), u122 (ref), u133 (ref)
    -- upvalues: Config (val), ItemIcon (val), u131 (ref), CopyPicker (val), u120 (ref), ControlGlyphs (val), u11 (val)
    local Frame_19, new, v1, v2, v3, v4

    if not a1.manage then
        return
    end

    u129 = u129 + 1
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 22)
    Frame.BackgroundTransparency = 1
    Frame.LayoutOrder = u129
    Frame.Parent = u121

    label(Frame, "- YOUR SHOP -", 11, Color3.fromRGB(120, 135, 160), true)

    u129 = u129 + 1
    local Frame_2 = Instance.new("Frame")
    Frame_2.Size = UDim2.new(1, 0, 0, 28)
    Frame_2.BackgroundTransparency = 1
    Frame_2.LayoutOrder = u129
    Frame_2.Parent = u121
    local v5 = {"Sell", "Buy"}
    local v6 = nil
    local v7 = nil

    for i, j in v5, v6, v7 do
        Frame_19 = Instance.new("Frame")
        Frame_19.Size = UDim2.new(0.5, -3, 1, 0)
        new = UDim2.new
        v1 = if i ~= 1 then 3 else 0
        Frame_19.Position = new(0.5 * (i - 1), v1, 0, 0)
        Frame_19.BackgroundTransparency = 1
        Frame_19.Parent = Frame_2
        v4 = a1.mode == j
        v2 = string.upper(j)
        v3 = if not v4 then Color3.fromRGB(38, 43, 54) else Color3.fromRGB(255, 226, 130)

        button(
            Frame_19,
            v2,
            if not v4 then Color3.fromRGB(180, 195, 215) else Color3.fromRGB(20, 26, 34),
            v3,
            function() -- Line: 403; upvalues: j (val), u123 (upval), u81 (upval)
                local v1 = {mode = j}

                if u123 then
                    u81:FireServer(u123, v1)
                end
            end
        )
    end

    u129 = u129 + 1
    local Frame_3 = Instance.new("Frame")
    Frame_3.Size = UDim2.new(1, 0, 0, 30)
    Frame_3.BackgroundTransparency = 1
    Frame_3.LayoutOrder = u129
    Frame_3.Parent = u121
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1, -64, 1, 0)
    TextBox.BackgroundColor3 = Color3.fromRGB(30, 34, 42)
    TextBox.TextColor3 = Color3.fromRGB(255, 226, 130)
    TextBox.Name = "PriceBox"
    TextBox.PlaceholderText = "Price in coins (10k works)"
    TextBox.Text = if not a1.price then "" else tostring(a1.price)
    TextBox.FontFace = u46.Font.Bold
    TextBox.TextSize = 13
    TextBox.ClearTextOnFocus = false
    TextBox.Parent = Frame_3

    u46.corner(TextBox, 5)

    local function submitPrice()
        -- Line: 426
        -- upvalues: CoinAmount (upval), TextBox (val), a1 (val), u123 (upval), u81 (upval)
        local v1 = CoinAmount.parse(TextBox.Text)

        if v1 then
            local v2 = if a1.mode ~= "Buy" then
                {price = v1}
            else
                {price = v1, budget = v1 * (a1.wanted or 0)}

            if u123 then
                u81:FireServer(u123, v2)
            end

            TextBox.Text = tostring(v1)
            TextBox:SetAttribute("Draft", nil)
        end
    end

    ;(TextBox:GetPropertyChangedSignal("Text")):Connect(function() -- Line: 94; upvalues: TextBox (val)
        if TextBox:IsFocused() then
            TextBox:SetAttribute("Draft", true)
        end
    end)

    TextBox.FocusLost:Connect(function(a1) -- Line: 443; upvalues: submitPrice (val)
        if a1 then
            submitPrice()
        end
    end)

    local Frame_4 = Instance.new("Frame")
    Frame_4.Size = UDim2.new(0, 58, 1, 0)
    Frame_4.Position = UDim2.new(1, -58, 0, 0)
    Frame_4.BackgroundTransparency = 1
    Frame_4.Parent = Frame_3

    button(Frame_4, "SET", Color3.fromRGB(20, 26, 34), Color3.fromRGB(255, 226, 130), submitPrice)

    if a1.price then
        u129 = u129 + 1
        local Frame_5 = Instance.new("Frame")
        Frame_5.Size = UDim2.new(1, 0, 0, 30)
        Frame_5.BackgroundTransparency = 1
        Frame_5.LayoutOrder = u129
        Frame_5.Parent = u121

        label(Frame_5, if a1.mode ~= "Buy" then ("You receive %* of every %* - a %*%% tax."):format(coins(a1.proceeds), coins(a1.price), a1.taxPercent) else ("You pay %* each. Sellers get %* after the %*%% tax."):format(coins(a1.price), coins(a1.proceeds), a1.taxPercent), 11, Color3.fromRGB(130, 145, 170))
    end

    if a1.mode == "Buy" then
        u129 = u129 + 1
        local Frame_6 = Instance.new("Frame")
        Frame_6.Size = UDim2.new(1, 0, 0, 30)
        Frame_6.BackgroundTransparency = 1
        Frame_6.LayoutOrder = u129
        Frame_6.Parent = u121
        local u221 = Instance.new("TextBox")
        u221.Size = UDim2.new(1, -64, 1, 0)
        u221.BackgroundColor3 = Color3.fromRGB(30, 34, 42)
        u221.TextColor3 = Color3.fromRGB(235, 240, 250)
        u221.Name = "WantBox"
        u221.PlaceholderText = "How many to buy"
        u221.Text = if not (0 < (a1.wanted or 0)) then "" else tostring(a1.wanted)
        u221.FontFace = u46.Font.Bold
        u221.TextSize = 13
        u221.ClearTextOnFocus = false
        u221.Parent = Frame_6

        u46.corner(u221, 5)

        local function submitWanted() -- Line: 488; upvalues: u221 (val), a1 (val), u123 (upval), u81 (upval)
            local v1 = tonumber(u221.Text)

            if v1 and v1 == v1 and v1 >= 0 then
                v1 = math.floor(v1)
                local v2 = {wanted = v1, budget = v1 * (a1.price or 0)}

                if u123 then
                    u81:FireServer(u123, v2)
                end

                u221.Text = tostring(v1)
                u221:SetAttribute("Draft", nil)
            end
        end

        ;(u221:GetPropertyChangedSignal("Text")):Connect(function() -- Line: 94; upvalues: u221 (val)
            if u221:IsFocused() then
                u221:SetAttribute("Draft", true)
            end
        end)

        u221.FocusLost:Connect(function(a1) -- Line: 498; upvalues: submitWanted (val)
            if a1 then
                submitWanted()
            end
        end)

        local Frame_7 = Instance.new("Frame")
        Frame_7.Size = UDim2.new(0, 58, 1, 0)
        Frame_7.Position = UDim2.new(1, -58, 0, 0)
        Frame_7.BackgroundTransparency = 1
        Frame_7.Parent = Frame_6

        button(Frame_7, "SET", Color3.fromRGB(20, 26, 34), Color3.fromRGB(255, 226, 130), submitWanted)
    end

    if 0 < a1.stock and a1.itemId then
        u129 = u129 + 1
        local Frame_8 = Instance.new("Frame")
        Frame_8.Size = UDim2.new(1, 0, 0, 28)
        Frame_8.BackgroundTransparency = 1
        Frame_8.LayoutOrder = u129
        Frame_8.Parent = u121

        button(
            Frame_8,
            ("TAKE BACK %* %*"):format(a1.stock, (string.upper((DisplayNames.of(a1.itemId))))),
            Color3.fromRGB(230, 210, 200),
            Color3.fromRGB(70, 52, 46),
            function() -- Line: 519; upvalues: u123 (upval), u84 (upval), a1 (val)
                if u123 then
                    u84:FireServer(u123, -a1.stockCap, a1.itemId)
                end
            end
        )
    end

    local u927 = a1.mode == "Sell"
    u134 = u134 + 1
    local Frame_9 = Instance.new("Frame")
    Frame_9.Size = UDim2.new(1, 0, 0, 20)
    Frame_9.BackgroundTransparency = 1
    Frame_9.LayoutOrder = u134
    Frame_9.Parent = u130

    label(Frame_9, if not u927 then "WHAT DO YOU WANT TO BUY?" else ("STOCK IT  ·  %* / %* held"):format(a1.stock, a1.stockCap), 11, Color3.fromRGB(120, 135, 160), true)

    local itemId_2 = if not (0 < a1.stock) then nil else a1.itemId
    local v8 = {}
    v4 = u122
    local v9 = nil
    v1 = nil

    for k, n in v4, v9, v1 do
        v3 = true

        if u133 ~= "" then
            v3 = string.find(string.lower(DisplayNames.of(k)), u133, 1, true) ~= nil
        end

        if n > 0 and v3 then
            if not itemId_2 then
                if not Config.Build.worldOnly(k) then
                    table.insert(v8, k)
                end
            elseif itemId_2 == k and not Config.Build.worldOnly(k) then
                table.insert(v8, k)
            end
        end
    end

    table.sort(v8)

    if #v8 ~= 0 then
        local Frame_18, TextLabel, TextLabel_2, v10
        v4 = math.ceil(#v8 / 4) * 68
        u134 = u134 + 1
        local v11 = Instance.new("Frame")
        v11.Size = UDim2.new(1, 0, 0, v4)
        v11.BackgroundTransparency = 1
        v11.LayoutOrder = u134
        v11.Parent = u130
        local Frame_11 = Instance.new("Frame")
        Frame_11.Size = UDim2.fromScale(1, 1)
        Frame_11.BackgroundTransparency = 1
        Frame_11.Parent = v11
        v11 = Instance.new("UIGridLayout")
        v11.CellSize = UDim2.fromOffset(62, 62)
        v11.CellPadding = UDim2.fromOffset(6, 6)
        v11.SortOrder = Enum.SortOrder.LayoutOrder
        v11.Parent = Frame_11
        v1 = nil
        v2 = nil

        for m, i5 in v8, v1, v2 do
            v11 = Instance.new("TextButton")
            v11.Size = UDim2.fromOffset(62, 62)
            v10 = if a1.itemId ~= i5 then
                Color3.fromRGB(30, 34, 42)
            else
                Color3.fromRGB(52, 46, 30)
            v11.BackgroundColor3 = v10
            v11.BackgroundTransparency = 0.15
            v11.Text = ""
            v11.AutoButtonColor = true
            v11.LayoutOrder = m
            v11.Parent = Frame_11

            u46.corner(v11, 6)

            Frame_18 = Instance.new("Frame")
            Frame_18.Size = UDim2.fromOffset(30, 30)
            Frame_18.Position = UDim2.new(0.5, -15, 0, 9)
            Frame_18.BackgroundTransparency = 1
            Frame_18.Parent = v11

            ItemIcon.render(Frame_18, i5, 30, 4)

            TextLabel = Instance.new("TextLabel")
            TextLabel.Size = UDim2.new(1, -8, 0, 14)
            TextLabel.Position = UDim2.fromOffset(4, 3)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Text = ("x%*"):format(u122[i5])
            TextLabel.TextColor3 = u46.Palette.Gold
            TextLabel.FontFace = u46.Font.Bold
            TextLabel.TextSize = 12
            TextLabel.TextXAlignment = Enum.TextXAlignment.Right
            TextLabel.Parent = v11
            TextLabel_2 = Instance.new("TextLabel")
            TextLabel_2.Size = UDim2.new(1, -6, 0, 22)
            TextLabel_2.Position = UDim2.new(0, 3, 1, -24)
            TextLabel_2.BackgroundTransparency = 1
            TextLabel_2.Text = DisplayNames.of(i5)
            TextLabel_2.TextColor3 = Color3.fromRGB(210, 215, 228)
            TextLabel_2.FontFace = u46.Font.Regular
            TextLabel_2.TextSize = 10
            TextLabel_2.TextWrapped = true
            TextLabel_2.TextTruncate = Enum.TextTruncate.AtEnd
            TextLabel_2.TextYAlignment = Enum.TextYAlignment.Center
            TextLabel_2.Parent = v11

            u131.attach(v11, i5)

            local function stockOne()
                -- Line: 639
                -- upvalues: u123 (upval), Config (upval), i5 (val), CopyPicker (upval), u120 (upval), u84 (upval)
                if not u123 then
                    return
                end

                if Config.Recipe.isUnique(i5) then
                    CopyPicker.ask(
                        i5,
                        u120,
                        "Sell",
                        Color3.fromRGB(52, 140, 80),
                        function(a1) -- Line: 644; upvalues: u123 (upval), u84 (upval), i5 (upval)
                            if u123 then
                                u84:FireServer(u123, 1, i5, a1)
                            end
                        end
                    )
                    return
                end

                u84:FireServer(u123, 1, i5)
            end

            local u879 = u46.holdForStack(
                v11,
                function()
                    -- Line: 654
                    -- upvalues: u123 (upval), u927 (val), Config (upval), i5 (val), stockOne (val), u84 (upval)
                    -- upvalues: a1 (val)
                    if u123 and u927 then
                        if Config.Recipe.isUnique(i5) then
                            stockOne()
                            return
                        end

                        u84:FireServer(u123, a1.stockCap, i5)
                    end
                end
            )

            v11.Activated:Connect(function()
                -- Line: 663
                -- upvalues: u879 (val), u123 (upval), u927 (val), i5 (val), u81 (upval), ControlGlyphs (upval)
                -- upvalues: Config (upval), u84 (upval), a1 (val), stockOne (val)
                if u879() or not u123 then
                    return
                end

                if not u927 then
                    local v1 = {itemId = i5}

                    if u123 then
                        u81:FireServer(u123, v1)
                    end

                    return
                end

                if ControlGlyphs.bulkHeld() and not Config.Recipe.isUnique(i5) then
                    u84:FireServer(u123, a1.stockCap, i5)
                    return
                end

                stockOne()
            end)
        end

        if u927 then
            u129 = u129 + 1
            local Frame_12 = Instance.new("Frame")
            Frame_12.Size = UDim2.new(1, 0, 0, 16)
            Frame_12.BackgroundTransparency = 1
            Frame_12.LayoutOrder = u129
            Frame_12.Parent = u121

            label(Frame_12, if not u11 then if not ControlGlyphs.usingGamepad() then "Click to add one. Shift-click adds the stack." else ControlGlyphs.say("{A} adds one. Hold {Y} and press {A} to add the stack.") else "Tap to add one. Hold to add the stack.", 11, Color3.fromRGB(120, 135, 160))
        end
    else
        u134 = u134 + 1
        local Frame_10 = Instance.new("Frame")
        Frame_10.Size = UDim2.new(1, 0, 0, 30)
        Frame_10.BackgroundTransparency = 1
        Frame_10.LayoutOrder = u134
        Frame_10.Parent = u130

        label(Frame_10, "Nothing in your backpack to point at.", 11, Color3.fromRGB(130, 145, 170))
    end

    if not u927 and 0 < a1.stock then
        u129 = u129 + 1
        local Frame_13 = Instance.new("Frame")
        Frame_13.Size = UDim2.new(1, 0, 0, 28)
        Frame_13.BackgroundTransparency = 1
        Frame_13.LayoutOrder = u129
        Frame_13.Parent = u121

        button(
            Frame_13,
            ("COLLECT %* %*"):format(a1.stock, (string.upper((DisplayNames.of(a1.itemId))))),
            Color3.fromRGB(200, 240, 210),
            Color3.fromRGB(40, 60, 50),
            function() -- Line: 711; upvalues: u123 (upval), u84 (upval), a1 (val)
                if u123 then
                    u84:FireServer(u123, -a1.stockCap, a1.itemId)
                end
            end
        )
    end

    if a1.mode == "Buy" then
        u129 = u129 + 1
        local Frame_14 = Instance.new("Frame")
        Frame_14.Size = UDim2.new(1, 0, 0, 30)
        Frame_14.BackgroundTransparency = 1
        Frame_14.LayoutOrder = u129
        Frame_14.Parent = u121

        label(Frame_14, ("Budget left: %* coins  ·  still wants %*"):format(coins(a1.budget), a1.wanted), 11, Color3.fromRGB(150, 162, 180))
    end

    local Frame_15 = Instance.new("Frame")
    Frame_15.Size = UDim2.fromOffset(283, 30)
    Frame_15.Position = UDim2.new(0, 16, 1, -44)
    Frame_15.BackgroundTransparency = 1
    Frame_15.Name = "ShopSwitch"
    Frame_15.Parent = u120
    local u618 = a1.state == "Offline"

    button(
        Frame_15,
        if not u618 then "CLOSE THE SHOP" else "OPEN THE SHOP",
        Color3.fromRGB(230, 236, 246),
        if not u618 then Color3.fromRGB(70, 44, 44) else Color3.fromRGB(40, 80, 58),
        function() -- Line: 750; upvalues: u618 (val), u123 (upval), u81 (upval)
            local v1 = {off = not u618}

            if u123 then
                u81:FireServer(u123, v1)
            end
        end
    )

    if a1.log and #a1.log > 0 then
        local Frame_17, count_2
        u129 = u129 + 1
        local Frame_16 = Instance.new("Frame")
        Frame_16.Size = UDim2.new(1, 0, 0, 22)
        Frame_16.BackgroundTransparency = 1
        Frame_16.LayoutOrder = u129
        Frame_16.Parent = u121

        label(Frame_16, "RECENT SALES", 11, Color3.fromRGB(120, 135, 160), true)

        v2 = nil
        local v12 = nil

        for i6, i7 in a1.log, v2, v12 do
            count_2 = if type(i7.count) ~= "number" then 1 else i7.count
            u129 = u129 + 1
            Frame_17 = Instance.new("Frame")
            Frame_17.Size = UDim2.new(1, 0, 0, 16)
            Frame_17.BackgroundTransparency = 1
            Frame_17.LayoutOrder = u129
            Frame_17.Parent = u121

            label(Frame_17, if not (count_2 > 1) then ("%*  ·  %* coins"):format(i7.other, (coins(i7.price))) else ("%*  ·  %* x %*  ·  %* coins"):format(i7.other, count_2, coins(i7.price), (coins(i7.price * count_2))), 11, Color3.fromRGB(150, 162, 180))
        end
    end
end

local function render()
    -- Line: 774
    -- upvalues: u124 (ref), u126 (ref), u123 (ref), u120 (ref), u132 (ref), u129 (ref), u134 (ref), clearBody (val)
    -- upvalues: renderShopFront (val), renderAction (val), renderControls (val)
    local v1

    if not u124 then
        return
    end

    local v2 = {}
    local Name = nil
    local CursorPosition = -1

    if u126 == u123 then
        for i, j in u120:GetDescendants() do
            if j:IsA("TextBox") and j ~= u132 then
                if j:GetAttribute("Draft") then
                    v2[j.Name] = j.Text
                end

                if j:IsFocused() then
                    Name = j.Name
                    CursorPosition = j.CursorPosition
                end
            end
        end
    end

    u129 = 0
    u134 = 0

    clearBody()

    if u120 then
        local ShopSwitch = u120:FindFirstChild("ShopSwitch")

        if ShopSwitch then
            ShopSwitch:Destroy()
        end
    end

    renderShopFront(u124)
    renderAction(u124)
    renderControls(u124)

    u126 = u123

    for k, n in u120:GetDescendants() do
        if n:IsA("TextBox") and n ~= u132 then
            v1 = v2[n.Name]

            if v1 then
                n.Text = v1
                n:SetAttribute("Draft", true)
            end

            if Name and n.Name == Name then
                n:CaptureFocus()

                n.CursorPosition = CursorPosition
            end
        end
    end
end

function u73.close()
    -- Line: 824
    -- upvalues: CopyPicker (val), u120 (ref), u133 (ref), u132 (ref), u123 (ref), u124 (ref), u126 (ref)
    CopyPicker.close()

    if u120 then
        for i, j in u120:GetDescendants() do
            if j:IsA("TextBox") then
                j:ReleaseFocus()
            end
        end
    end

    u133 = ""

    if u132 then
        u132.Text = ""
    end

    u123 = nil
    u124 = nil
    u126 = nil

    if u120 then
        u120.Visible = false
    end
end

function u73.start()
    -- Line: 849
    -- upvalues: BuildController (val), u73 (val), u119 (ref), LocalPlayer (val), u120 (ref), u46 (val), u121 (ref)
    -- upvalues: u132 (ref), u133 (ref), render (val), u130 (ref), u131 (ref), ItemTooltip (val), Remotes (val)
    -- upvalues: u122 (ref), u78 (val), u123 (ref), u125 (ref), u124 (ref)
    BuildController.registerMenu("Vending", u73.close)

    u119 = Instance.new("ScreenGui")
    u119.Name = "VendingGui"
    u119.ResetOnSpawn = false
    u119.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    u119.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u120 = Instance.new("Frame")
    u120.ClipsDescendants = true
    u120.Size = UDim2.fromOffset(640, 430)
    u120.Position = UDim2.new(0.5, -320, 0.5, -215)

    u46.fitToScreen(u120)

    u120.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    u120.BackgroundTransparency = 0.05
    u120.Visible = false
    u120.Active = true
    u120.Parent = u119

    u46.corner(u120, 8)

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "Title"
    TextLabel.Size = UDim2.new(1, -44, 0, 24)
    TextLabel.Position = UDim2.fromOffset(12, 8)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "Shop"
    TextLabel.TextColor3 = Color3.fromRGB(255, 226, 130)
    TextLabel.FontFace = u46.Font.Bold
    TextLabel.TextSize = 17
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = u120

    u46.closeButton(u120, 8, u73.close)

    ;(u120:GetPropertyChangedSignal("Visible")):Connect(function()
        -- Line: 891
        -- upvalues: BuildController (upval), u120 (upval)
        BuildController.setUiOpen("Vending", u120.Visible)
    end)

    u121 = Instance.new("ScrollingFrame")
    u121.Size = UDim2.new(0, 300, 1, -92)
    u121.Position = UDim2.fromOffset(12, 40)
    u121.BackgroundTransparency = 1
    u121.BorderSizePixel = 0
    u121.ScrollBarThickness = 5
    u121.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    u121.ScrollingDirection = Enum.ScrollingDirection.Y
    u121.AutomaticCanvasSize = Enum.AutomaticSize.Y
    u121.CanvasSize = UDim2.new()
    u121.Active = true
    u121.Parent = u120
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 4)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = u121
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 4)
    UIPadding.PaddingRight = UDim.new(0, 8)
    UIPadding.Parent = u121
    u132 = Instance.new("TextBox")
    u132.Size = UDim2.fromOffset(300, u46.tap(24))
    u132.Position = UDim2.fromOffset(324, 40)
    u132.BackgroundColor3 = Color3.fromRGB(26, 30, 38)
    u132.BorderSizePixel = 0
    u132.PlaceholderText = "Search your backpack"
    u132.PlaceholderColor3 = Color3.fromRGB(96, 106, 124)
    u132.Text = ""
    u132.TextColor3 = Color3.fromRGB(226, 232, 244)
    u132.FontFace = u46.Font.Regular
    u132.TextSize = 12
    u132.TextXAlignment = Enum.TextXAlignment.Left
    u132.ClearTextOnFocus = false
    u132.Parent = u120

    u46.corner(u132, 4)

    local UIPadding_2 = Instance.new("UIPadding")
    UIPadding_2.PaddingLeft = UDim.new(0, 8)
    UIPadding_2.Parent = u132

    ;(u132:GetPropertyChangedSignal("Text")):Connect(function()
        -- Line: 950
        -- upvalues: u133 (upval), u132 (upval), render (upval)
        u133 = string.lower(u132.Text)
        render()
    end)

    u130 = Instance.new("ScrollingFrame")
    u130.Size = UDim2.new(0, 300, 1, -(84 + u46.tap(24) - 24))
    u130.Position = UDim2.fromOffset(324, 72 + u46.tap(24) - 24)
    u130.BackgroundTransparency = 1
    u130.BorderSizePixel = 0
    u130.ScrollBarThickness = 5
    u130.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    u130.ScrollingDirection = Enum.ScrollingDirection.Y
    u130.AutomaticCanvasSize = Enum.AutomaticSize.Y
    u130.CanvasSize = UDim2.new()
    u130.Active = true
    u130.Parent = u120
    u131 = ItemTooltip.new(u120)

    u131.hideOnScroll(u130)

    local UIListLayout_2 = Instance.new("UIListLayout")
    UIListLayout_2.Padding = UDim.new(0, 4)
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.Parent = u130
    local UIPadding_3 = Instance.new("UIPadding")
    UIPadding_3.PaddingRight = UDim.new(0, 8)
    UIPadding_3.Parent = u130

    ;(Remotes.get(Remotes.InventoryChanged)).OnClientEvent:Connect(function(a1, a2, a3, a4, a5)
        -- Line: 978
        -- upvalues: u122 (upval), u120 (upval), render (upval)
        if type(a1) ~= "table" then
            return
        end

        u122 = table.clone(a1)

        if type(a5) == "table" then
            local v1, v2

            for i, j in a5 do
                v1 = u122
                v2 = (u122[i] or 0) - j
                v1[i] = (math.max(0, v2))
            end
        end

        if u120.Visible then
            render()
        end
    end)

    u78.OnClientEvent:Connect(function(a1)
        -- Line: 996
        -- upvalues: u120 (upval), u123 (upval), u125 (upval), u124 (upval), TextLabel (val), render (upval)
        -- upvalues: u46 (upval)
        if type(a1) ~= "table" then
            return
        end

        if u120.Visible then
            if u123 ~= a1.cellKey then
                return
            end

            if u123 ~= a1.cellKey or not u120.Visible then
                u125 = 1
            end

            u123 = a1.cellKey
            u124 = a1
            TextLabel.Text = if not a1.manage then ("%*'s Shop"):format(a1.owner) else "Your Shop"

            render()

            if not u120.Visible then
                u120.Visible = true
                u46.appear(u120)
            end

            return
        end

        if a1.opening ~= true then
            return
        end

        if u123 ~= a1.cellKey or not u120.Visible then
            u125 = 1
        end

        u123 = a1.cellKey
        u124 = a1
        TextLabel.Text = if not a1.manage then ("%*'s Shop"):format(a1.owner) else "Your Shop"

        render()

        if not u120.Visible then
            u120.Visible = true
            u46.appear(u120)
        end
    end)
end

return u73