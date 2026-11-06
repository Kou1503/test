-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ShopController
-- Decompile time: 9.63 ms

local Players = game:GetService("Players")
local u11 = (require(script.Parent.DeviceMode)).touchOnly()
local v1 = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(v1.Config)
local Format = require(v1.Format)
local Palette = require(v1.Palette)
local Remotes = require(v1.Remotes)
local u40 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local ItemIcon = require(script.Parent.ItemIcon)
local ItemTooltip = require(script.Parent.ItemTooltip)
local u61 = {}
local LocalPlayer = Players.LocalPlayer
local u66 = Remotes.get(Remotes.ShopOpened)
local u69 = Remotes.get(Remotes.CoinsChanged)
local u72 = Remotes.get(Remotes.InventoryChanged)
local u75 = Remotes.get(Remotes.RequestShopBuy)
local u78 = Remotes.get(Remotes.RequestShopSell)
local u81 = u40.tapRow(42)
local u82 = nil
local u83 = nil
local u84 = nil
local u85 = nil
local u86 = nil
local u87 = {}
local u88 = {}
local u89 = {}
local u90 = 0
local u91 = "Buy"
local u92 = nil
local u93 = 1
local u94 = nil
local u95 = {}
local u98 = u40.tap(26)

local function buyCount(a1) -- Line: 80; upvalues: u93 (ref), u90 (ref), Config (val); types: a1: number
    if u93 == "MAX" then
        return (math.clamp(math.floor(u90 / (math.max(a1, 1))), 1, Config.Shop.MaxBuy))
    end

    return u93
end

local function keysOf(a1) -- Line: 87; types: a1: table
    local v1 = {}

    for i in a1 do
        table.insert(v1, i)
    end

    return v1
end

local u101 = nil
local u102 = nil
local u103 = {}

local function hideTooltip() -- Line: 104; upvalues: u101 (ref)
    u101.hide()
end

local function showTooltip(a1, a2) -- Line: 108; upvalues: u101 (ref); types: a1: string, a2: userdata
    u101.show(a1, a2)
end

local function render()
    -- Line: 117
    -- upvalues: u86 (ref), u103 (val), u84 (ref), Format (val), u90 (ref), u91 (ref), u87 (ref), u88 (ref), u94 (ref)
    -- upvalues: u98 (val), u95 (val), u93 (ref), Config (val), u89 (ref), u92 (ref), u40 (val), u81 (val), u102 (ref)
    -- upvalues: u101 (ref), ItemIcon (val), Palette (val), u75 (val), ControlGlyphs (val), u78 (val), u85 (ref)
    -- upvalues: u11 (val)
    local Frame_2, TextButton, TextButton_2, UICorner, v1, v2, v3, v4, v5, v6, v7

    for i, j in u86:GetChildren() do
        if j:IsA("Frame") or j.Name == "NothingToSell" then
            j:Destroy()
        end
    end

    table.clear(u103)

    u84.Text = ("%* coins"):format((Format.short(u90)))
    local u758 = u91 == "Buy"
    local u763 = if not u758 then u88 else u87
    local v8 = {}

    for k in u763 do
        table.insert(v8, k)
    end

    u94.Visible = u758
    local v9 = if not u758 then 62 else 40 + u98 + 6
    u86.Position = UDim2.fromOffset(6, v9)
    u86.Size = UDim2.new(1, -12, 1, -(v9 + 30))
    local v10 = nil
    local v11 = nil

    for n, m in u95, v10, v11 do
        v7 = if not (n == u93) then Color3.fromRGB(36, 40, 50) else Color3.fromRGB(46, 76, 60)
        m.BackgroundColor3 = v7
        v7 = if not v9 then Color3.fromRGB(150, 156, 170) else Color3.fromRGB(200, 240, 210)
        m.TextColor3 = v7
    end

    table.sort(
        v8,
        function(a1, a2)
            -- Line: 159
            -- upvalues: u758 (val), u90 (upval), u763 (val), u93 (upval), Config (upval), u89 (upval)
            local v1, v2, v3

            if not u758 then
                v1 = 0 < (u89[a1] or 0)
            else
                v2 = u90
                v3 = u763[a1]
                local v4 = u763[a1]
                v1 = v3
                    * (if u93 ~= "MAX" then
                        u93
                    else
                        math.clamp(math.floor(u90 / (math.max(v4, 1))), 1, Config.Shop.MaxBuy))
                    <= v2
            end

            if not u758 then
                v2 = 0 < (u89[a2] or 0)
            else
                local v5 = u90
                local v6 = u763[a2]
                local v7 = u763[a2]
                v2 = v6
                    * (if u93 ~= "MAX" then
                        u93
                    else
                        math.clamp(math.floor(u90 / (math.max(v7, 1))), 1, Config.Shop.MaxBuy))
                    <= v5
            end

            if v1 ~= v2 then
                return v1
            end

            if u763[a1] == u763[a2] then
                return a1 < a2
            end

            if u758 then
                return u763[a1] < u763[a2]
            end

            v3 = u763[a1]

            return u763[a2] < v3
        end
    )

    if not u758 and #v8 == 0 then
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "NothingToSell"
        TextLabel.Size = UDim2.new(1, 0, 0, 40)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = ("You have nothing to sell to %* yet."):format(u92.Text)
        TextLabel.TextColor3 = Color3.fromRGB(150, 158, 178)
        TextLabel.TextSize = 14
        TextLabel.FontFace = u40.Font.Bold
        TextLabel.TextWrapped = true
        TextLabel.Parent = u86
    end

    local v12 = v8
    v10 = nil
    v11 = nil

    for i5, i6 in v12, v10, v11 do
        v7 = u763[i6]
        v1 = u89[i6] or 0

        if not u758 then
            u190 = 1
        elseif u93 ~= "MAX" then
            u190 = u93
        else
            local u190 = math.clamp(math.floor(u90 / (math.max(v7, 1))), 1, Config.Shop.MaxBuy)
        end

        if not u758 then
            v2 = v1 > 0
        else
            v3 = u90
            v2 = v7 * u190 <= v3
        end

        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -12, 0, u81 - 4)
        Frame.Position = UDim2.fromOffset(6, (i5 - 1) * u81 + 4)
        v4 = if not v2 then Color3.fromRGB(30, 32, 38) else Color3.fromRGB(38, 44, 56)
        Frame.BackgroundColor3 = v4
        Frame.BorderSizePixel = 0
        Frame.Active = true
        Frame.Parent = u86
        u103[i6] = Frame

        Frame.MouseEnter:Connect(function() -- Line: 201; upvalues: u102 (upval), i6 (val), Frame (val), u101 (upval)
            u102 = i6
            u101.show(i6, Frame)
        end)

        Frame.MouseLeave:Connect(function() -- Line: 205; upvalues: u102 (upval), i6 (val), u101 (upval)
            if u102 == i6 then
                u102 = nil
                u101.hide()
            end
        end)

        UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = Frame
        Frame_2 = Instance.new("Frame")
        Frame_2.Size = UDim2.fromOffset(28, 28)
        Frame_2.Position = UDim2.fromOffset(6, 5)
        Frame_2.BackgroundTransparency = 1
        Frame_2.Parent = Frame

        ItemIcon.render(Frame_2, i6, 28, 3)

        v5 = (if not u758 then 98 else 78) + 8 + 148
        v4 = Instance.new("TextLabel")
        v4.Size = UDim2.new(1, -(v5 + 42 + 8), 1, 0)
        v4.Position = UDim2.fromOffset(42, 0)
        v4.TextTruncate = Enum.TextTruncate.AtEnd
        v4.BackgroundTransparency = 1
        v6 = if u758 or not (v1 > 0) then
            Palette.displayName(i6)
        else
            ("%*  ×%*"):format(Palette.displayName(i6), v1)
        v4.Text = v6
        v6 = if not v2 then Color3.fromRGB(140, 145, 158) else Color3.fromRGB(225, 230, 240)
        v4.TextColor3 = v6
        v4.FontFace = u40.Font.Regular
        v4.TextSize = 13
        v4.TextXAlignment = Enum.TextXAlignment.Left
        v4.Parent = Frame
        v4 = Instance.new("TextLabel")
        v4.Size = UDim2.new(0, 148, 1, 0)
        v4.Position = UDim2.new(1, -v5, 0, 0)
        v4.BackgroundTransparency = 1
        v6 = if not u758 then
            if not (v1 > 0) then
                ("%* each"):format((Format.short(v7)))
            else
                ("%* coins  ·  %* each"):format(Format.short(v7 * v1), (Format.short(v7)))
        else
            if not (u190 > 1) then
                ("%* coins"):format((Format.short(v7, true)))
            else
                ("%* coins  ·  %* each"):format(Format.short(v7 * u190, true), (Format.short(v7, true)))
        v4.Text = v6
        v4.TextColor3 = Color3.fromRGB(255, 226, 130)
        v4.FontFace = u40.Font.Regular
        v4.TextSize = 12
        v4.TextXAlignment = Enum.TextXAlignment.Right
        v4.Parent = Frame
        TextButton = Instance.new("TextButton")
        TextButton.Size = UDim2.fromOffset(if not u758 then 44 else 72, u40.tap(24))
        TextButton.Position = UDim2.new(1, if not u758 then -98 else -78, 0.5, -u40.tap(24) / 2)
        v6 = if not v2 then Color3.fromRGB(40, 42, 48) else Color3.fromRGB(46, 76, 60)
        TextButton.BackgroundColor3 = v6
        v6 = if not v2 then Color3.fromRGB(120, 124, 132) else Color3.fromRGB(200, 240, 210)
        TextButton.TextColor3 = v6
        TextButton.FontFace = u40.Font.Bold
        TextButton.TextSize = u40.tapText(12)
        TextButton.Text = if not u758 then
            "SELL"
        else
            if not (u190 > 1) then "BUY" else ("BUY ×%*"):format(u190)
        TextButton.AutoButtonColor = v2
        TextButton.Parent = Frame
        v4 = Instance.new("UICorner")
        v4.CornerRadius = UDim.new(0, 4)
        v4.Parent = TextButton

        TextButton.Activated:Connect(function()
            -- Line: 310
            -- upvalues: u758 (val), u75 (upval), i6 (val), u190 (val), ControlGlyphs (upval), u78 (upval)
            if u758 then
                u75:FireServer(i6, u190)
                return
            end

            u78:FireServer(i6, if not (ControlGlyphs.bulkHeld()) then 1 else 10)
        end)

        if not u758 then
            TextButton_2 = Instance.new("TextButton")
            TextButton_2.Size = UDim2.fromOffset(48, u40.tap(24))
            TextButton_2.Position = UDim2.new(1, -50, 0.5, -u40.tap(24) / 2)
            v6 = if not v2 then Color3.fromRGB(40, 42, 48) else Color3.fromRGB(66, 58, 40)
            TextButton_2.BackgroundColor3 = v6
            v6 = if not v2 then Color3.fromRGB(120, 124, 132) else Color3.fromRGB(255, 226, 130)
            TextButton_2.TextColor3 = v6
            TextButton_2.FontFace = u40.Font.Bold
            TextButton_2.TextSize = u40.tapText(12)
            TextButton_2.Text = "ALL"
            TextButton_2.AutoButtonColor = v2
            TextButton_2.Parent = Frame
            v4 = Instance.new("UICorner")
            v4.CornerRadius = UDim.new(0, 4)
            v4.Parent = TextButton_2

            TextButton_2.Activated:Connect(function() -- Line: 338; upvalues: u78 (upval), i6 (val), Config (upval)
                u78:FireServer(i6, Config.Shop.SellAll)
            end)
        end
    end

    u86.CanvasSize = UDim2.fromOffset(0, #v8 * u81 + 8)
    v8 = if not u102 then nil else u103[u102]

    if not u102 or not v8 then
        u102 = nil
        u101.hide()
    else
        v12 = u102
        u101.show(v12, v8)
    end

    v12 = u85

    if u11 then
        v10 = if not u758 then
            "Tap SELL to sell one, or ALL for the whole stack."
        else
            "Pick how many above, then tap BUY."
    elseif not ControlGlyphs.usingGamepad() then
        v10 = if not u758 then
            "Click SELL to sell one, shift-click for ten, or ALL for the whole stack."
        else
            "Pick how many above, then click BUY. MAX buys as many as you can afford."
    else
        v11 = if not u758 then
            "{A} on SELL sells one, hold {Y} and press {A} for ten, or ALL for the whole stack."
        else
            "Pick how many above, then press {A} on BUY. MAX buys as many as you can afford."
        v10 = ControlGlyphs.say(v11)
    end

    v12.Text = v10
end

function u61.isOpen() -- Line: 371; upvalues: u83 (ref)
    local Visible = false

    if u83 ~= nil then
        Visible = u83.Visible
    end

    return Visible
end

function u61.close() -- Line: 375; upvalues: u102 (ref), u101 (ref), u83 (ref), BuildController (val)
    u102 = nil
    u101.hide()

    u83.Visible = false
    BuildController.setUiOpen("Shop", false)
end

function u61.start()
    -- Line: 382
    -- upvalues: BuildController (val), u61 (val), u82 (ref), LocalPlayer (val), u83 (ref), u40 (val), u92 (ref)
    -- upvalues: u84 (ref), u94 (ref), u98 (val), Config (val), u93 (ref), render (val), u95 (val), u86 (ref), u85 (ref)
    -- upvalues: u101 (ref), ItemTooltip (val), u102 (ref), Remotes (val), u66 (val), u87 (ref), u88 (ref), u91 (ref)
    -- upvalues: u69 (val), u90 (ref), u72 (val), u89 (ref)
    local TextButton, UICorner_2
    BuildController.registerMenu("Shop", u61.close)

    u82 = Instance.new("ScreenGui")
    u82.Name = "AboveShop"
    u82.ResetOnSpawn = false
    u82.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u83 = Instance.new("Frame")
    u83.ClipsDescendants = true
    u83.Size = UDim2.fromOffset(460, 420)
    u83.Position = UDim2.new(0.5, -230, 0.5, -260)

    u40.fitToScreen(u83)

    u83.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    u83.BackgroundTransparency = 0.05
    u83.Visible = false
    u83.Active = true
    u83.Parent = u82
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = u83
    u92 = Instance.new("TextLabel")
    local v1 = u92
    v1.Size = UDim2.fromOffset(200, 24)
    v1.Position = UDim2.fromOffset(12, 10)
    v1.BackgroundTransparency = 1
    v1.Text = "Merchant"
    v1.TextColor3 = Color3.fromRGB(255, 226, 130)
    v1.FontFace = u40.Font.Bold
    v1.TextSize = 17
    v1.TextXAlignment = Enum.TextXAlignment.Left
    v1.Parent = u83
    u84 = Instance.new("TextLabel")
    u84.Size = UDim2.fromOffset(180, 24)
    u84.Position = UDim2.new(1, -226, 0, 10)
    u84.BackgroundTransparency = 1
    u84.Text = "0 coins"
    u84.TextColor3 = Color3.fromRGB(255, 226, 130)
    u84.FontFace = u40.Font.Bold
    u84.TextSize = 15
    u84.TextXAlignment = Enum.TextXAlignment.Right
    u84.Parent = u83

    u40.closeButton(u83, 10, u61.close)

    u94 = Instance.new("Frame")
    u94.Size = UDim2.new(1, -24, 0, u98)
    u94.Position = UDim2.fromOffset(12, 40)
    u94.BackgroundTransparency = 1
    u94.Visible = false
    u94.Parent = u83
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(0, 40, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "QTY"
    TextLabel.TextColor3 = Color3.fromRGB(130, 145, 170)
    TextLabel.FontFace = u40.Font.Bold
    TextLabel.TextSize = 12
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = u94
    v1 = table.clone(Config.Shop.BuyQuantities)

    table.insert(v1, "MAX")

    local v2 = nil
    local v3 = nil

    for i, j in v1, v2, v3 do
        TextButton = Instance.new("TextButton")
        TextButton.Size = UDim2.new(0, 52, 1, 0)
        TextButton.Position = UDim2.fromOffset((i - 1) * 58 + 40, 0)
        TextButton.FontFace = u40.Font.Bold
        TextButton.TextSize = u40.tapText(12)
        TextButton.Text = if j ~= "MAX" then ("×%*"):format(j) else "MAX"
        TextButton.Parent = u94
        UICorner_2 = Instance.new("UICorner")
        UICorner_2.CornerRadius = UDim.new(0, 4)
        UICorner_2.Parent = TextButton

        TextButton.Activated:Connect(function() -- Line: 472; upvalues: u93 (upval), j (val), render (upval)
            u93 = j
            render()
        end)

        u95[j] = TextButton
    end

    u86 = Instance.new("ScrollingFrame")
    u86.Size = UDim2.new(1, -12, 1, -92)
    u86.Position = UDim2.fromOffset(6, 62)
    u86.BackgroundTransparency = 1
    u86.BorderSizePixel = 0
    u86.ScrollBarThickness = 5
    u86.Active = true
    u86.Parent = u83
    u85 = Instance.new("TextLabel")
    u85.Size = UDim2.new(1, -24, 0, 18)
    u85.Position = UDim2.new(0, 12, 1, -26)
    u85.BackgroundTransparency = 1
    u85.Text = ""
    u85.TextColor3 = Color3.fromRGB(130, 145, 170)
    u85.FontFace = u40.Font.Regular
    u85.TextSize = 12
    u85.TextXAlignment = Enum.TextXAlignment.Left
    u85.Parent = u83
    u101 = ItemTooltip.new(u83)

    ;(u86:GetPropertyChangedSignal("CanvasPosition")):Connect(function()
        -- Line: 503
        -- upvalues: u102 (upval), u101 (upval)
        u102 = nil
        u101.hide()
    end)

    ;(Remotes.get(Remotes.NpcDialogue)).OnClientEvent:Connect(function(a1) -- Line: 514; upvalues: u61 (upval)
        if type(a1) == "table" and a1.close and u61.isOpen() then
            u61.close()
        end
    end)

    u66.OnClientEvent:Connect(function(a1, a2, a3, a4, a5)
        -- Line: 521
        -- upvalues: u87 (upval), u88 (upval), u92 (upval), u91 (upval), u83 (upval), u93 (upval), u40 (upval)
        -- upvalues: BuildController (upval), render (upval)
        u87 = a1 or {}
        u88 = a2 or {}
        u92.Text = a3 or "Merchant"
        local v1 = next(u87) ~= nil
        local v2 = next(u88) ~= nil

        if a4 == "Buy" or a4 == "Sell" then
            u91 = a4
        end

        if u91 ~= "Buy" then
            if u91 == "Sell" and not v2 then
                u91 = if not v1 then "Sell" else "Buy"
            end
        elseif not v1 or u91 == "Sell" and not v2 then
            u91 = if not v1 then "Sell" else "Buy"
        end

        if not u83.Visible then
            u93 = 1
        end

        u83.Visible = true
        u40.appear(u83)
        BuildController.setUiOpen("Shop", true)
        render()
    end)

    u69.OnClientEvent:Connect(function(a1)
        -- Line: 555
        -- upvalues: u90 (upval), u83 (upval), render (upval)
        -- types: a1: number
        u90 = a1

        if u83.Visible then
            render()
        end
    end)

    u72.OnClientEvent:Connect(function(a1, a2, a3, a4, a5)
        -- Line: 562
        -- upvalues: u89 (upval), u83 (upval), render (upval)
        u89 = table.clone(a1)

        if type(a5) == "table" then
            local v1, v2

            for i, j in a5 do
                v1 = u89
                v2 = (u89[i] or 0) - j
                v1[i] = (math.max(0, v2))
            end
        end

        if u83.Visible then
            render()
        end
    end)
end

return u61