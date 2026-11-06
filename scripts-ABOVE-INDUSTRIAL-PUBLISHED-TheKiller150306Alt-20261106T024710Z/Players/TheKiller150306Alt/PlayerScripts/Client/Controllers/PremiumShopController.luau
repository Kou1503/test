-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.PremiumShopController
-- Decompile time: 25.17 ms

local ContextActionService = game:GetService("ContextActionService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)

require(Shared.Config.MonetizationConfig)

local Remotes = require(Shared.Remotes)
local u40 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local BuilderLightController = require(script.Parent.BuilderLightController)
local PortalMoveController = require(script.Parent.PortalMoveController)
local u56 = {}
local LocalPlayer = Players.LocalPlayer
local u61 = Remotes.get(Remotes.RequestPortalReset)
local u64 = Remotes.get(Remotes.RequestSpawnMove)
local u65 = nil
local u66 = nil
local u67 = nil

function u56.isOpen() -- Line: 61; upvalues: u66 (ref)
    local Visible = false

    if u66 ~= nil then
        Visible = u66.Visible
    end

    return Visible
end

local u69 = {}
local u70 = {}

local function fetchPrice(a1) -- Line: 75; upvalues: u69 (val), MarketplaceService (val), u70 (val)
    local v1 = u69[a1.assetId]

    if v1 then
        return v1
    end

    local GamePass = if a1.kind ~= "Pass" then
        Enum.InfoType.Product
    else
        Enum.InfoType.GamePass
    local success, err = pcall(function() -- Line: 81; upvalues: MarketplaceService (upval), a1 (val), GamePass (val)
        return MarketplaceService:GetProductInfo(a1.assetId, GamePass)
    end)

    if success and type(err) == "table" then
        local v2 = tonumber(err.IconImageAssetId)

        if v2 and v2 > 0 then
            u70[a1.assetId] = (("rbxassetid://%*"):format(v2))
        end

        v2 = tonumber(err.PriceInRobux)

        if v2 then
            u69[a1.assetId] = v2
        end

        return v2
    end

    return nil
end

local u72 = {}

local function fetchOwned(a1) -- Line: 103; upvalues: u72 (val), MarketplaceService (val), LocalPlayer (val)
    if a1.kind ~= "Pass" then
        return false
    end

    local v1 = u72[a1.assetId]

    if v1 ~= nil then
        return v1
    end

    local success, err = pcall(function()
        -- Line: 111
        -- upvalues: MarketplaceService (upval), LocalPlayer (upval), a1 (val)
        return MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, a1.assetId)
    end)
    v1 = success and err == true

    if success then
        u72[a1.assetId] = v1
    end

    return v1
end

local u78 = Color3.fromRGB(48, 52, 66)
local u83 = Color3.fromRGB(160, 168, 190)

local function showOwned(a1) -- Line: 124; upvalues: u78 (val), u83 (val); types: a1: userdata
    a1.Text = "OWNED"
    a1.BackgroundColor3 = u78
    a1.TextColor3 = u83
    a1.Active = false
    a1.AutoButtonColor = false

    a1:SetAttribute("Owned", true)
end

local u87 = utf8.char(57346)

local function priceText(a1) -- Line: 137; upvalues: u87 (val); types: a1: number?
    local v1, v2

    if not a1 then
        return "GET"
    end

    local v3 = tostring(a1)

    repeat
        v1, v2 = string.gsub(v3, "^(-?%d+)(%d%d%d)", "%1,%2")
        v3 = v1
    until v2 == 0

    return (("%* %*"):format(u87, v3))
end

local function ordered() -- Line: 156; upvalues: Config (val)
    local v1 = {}

    for i, j in Config.Monetization.Products do
        if Config.Monetization.isListed(j.id) then
            table.insert(v1, j)
        end
    end

    table.sort(
        v1,
        function(a1, a2) -- Line: 164; upvalues: Config (upval)
            if a1.kind ~= a2.kind then
                return a1.kind == "Pass"
            end

            local v1 = a1.id == Config.Monetization.ShelfFirst

            if v1 ~= (a2.id == Config.Monetization.ShelfFirst) then
                return v1
            end

            return a1.displayName < a2.displayName
        end
    )

    return v1
end

local u90 = {
    Pass = {title = "GAME PASSES", note = "Carries over to other profiles"},
    Product = {title = "REPEATABLE PURCHASES"},
}

local function header(a1, a2) -- Line: 189; upvalues: u90 (val), u67 (ref), u40 (val); types: a1: string, a2: number
    local v1 = u90[a1]

    if not v1 then
        return a2
    end

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -12, 0, 30)
    Frame.Position = UDim2.fromOffset(6, a2)
    Frame.BackgroundTransparency = 1
    Frame.Parent = u67
    local TextLabel = Instance.new("TextLabel")
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.Size = UDim2.fromOffset(0, 22)
    TextLabel.Position = UDim2.fromOffset(4, 2)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = v1.title
    TextLabel.TextColor3 = Color3.fromRGB(238, 240, 248)
    TextLabel.TextSize = 13
    TextLabel.FontFace = u40.Font.Bold
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = Frame

    if v1.note then
        local TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Size = UDim2.new(1, -8, 0, 22)
        TextLabel_2.Position = UDim2.fromOffset(4, 2)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.Text = v1.note
        TextLabel_2.TextColor3 = Color3.fromRGB(150, 158, 178)
        TextLabel_2.TextSize = 12
        TextLabel_2.FontFace = u40.Font.Regular
        TextLabel_2.TextXAlignment = Enum.TextXAlignment.Right
        TextLabel_2.Parent = Frame
    end

    return a2 + 30
end

local function render()
    -- Line: 228
    -- upvalues: u67 (ref), ordered (val), header (val), u70 (val), u40 (val), Config (val), fetchPrice (val)
    -- upvalues: BuilderLightController (val), u78 (val), u83 (val), LocalPlayer (val), u56 (val)
    -- upvalues: PortalMoveController (val), u61 (val), u64 (val), u69 (val), priceText (val), u72 (val)
    -- upvalues: MarketplaceService (val)
    local Frame, TextButton_2, TextButton_3, TextButton_4, TextLabel, TextLabel_2, TextLabel_3, UICorner, UICorner_2,
        UICorner_3, UICorner_4, UICorner_5, UICorner_6, UICorner_7, fetchIcon, v1, v2, v3, v4

    for i, j in u67:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end

    local v5 = 0
    local kind = nil

    for k, n in ordered() do
        if n.kind ~= kind then
            if kind ~= nil then
                v5 = v5 + 10
            end

            kind = n.kind
            v5 = header(n.kind, v5)
        end

        Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, -12, 0, 76)
        Frame.Position = UDim2.fromOffset(6, v5)
        Frame.BackgroundColor3 = Color3.fromRGB(32, 35, 44)
        Frame.BorderSizePixel = 0
        Frame.Parent = u67
        UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = Frame
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Size = UDim2.fromOffset(56, 56)
        ImageLabel.Position = UDim2.new(0, 10, 0.5, -28)
        ImageLabel.BackgroundColor3 = Color3.fromRGB(24, 26, 33)
        ImageLabel.BorderSizePixel = 0
        ImageLabel.ScaleType = Enum.ScaleType.Fit
        ImageLabel.Image = u70[n.assetId] or ""
        ImageLabel.Parent = Frame
        UICorner_2 = Instance.new("UICorner")
        UICorner_2.CornerRadius = UDim.new(0.5, 0)
        UICorner_2.Parent = ImageLabel
        TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, -218, 0, 20)
        TextLabel.Position = UDim2.fromOffset(76, 10)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = n.displayName
        TextLabel.TextColor3 = Color3.fromRGB(238, 240, 248)
        TextLabel.TextSize = 14
        TextLabel.FontFace = u40.Font.Bold
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.Parent = Frame
        TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Size = UDim2.new(1, -218, 0, 44)
        TextLabel_2.Position = UDim2.fromOffset(76, 30)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.Text = n.description
        TextLabel_2.TextColor3 = Color3.fromRGB(150, 158, 178)
        TextLabel_2.TextSize = 12
        TextLabel_2.FontFace = u40.Font.Regular
        TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel_2.TextYAlignment = Enum.TextYAlignment.Top
        TextLabel_2.TextWrapped = true
        TextLabel_2.Parent = Frame
        local u448 = Config.Monetization.isLive(n.id)

        function fetchIcon()
            -- Line: 302
            -- upvalues: u448 (val), u70 (upval), n (val), fetchPrice (upval), ImageLabel (val)
            if u448 and not u70[n.assetId] then
                task.spawn(function()
                    -- Line: 306
                    -- upvalues: fetchPrice (upval), n (upval), ImageLabel (upval), u70 (upval)
                    fetchPrice(n)

                    if ImageLabel.Parent then
                        ImageLabel.Image = u70[n.assetId] or ""
                    end
                end)
            end
        end

        if n.id ~= "BuilderLight" then
            if n.id == "PortalMover" then
                v1 = LocalPlayer

                if v1:GetAttribute(Config.Monetization.PortalMoverAttribute) == true then
                    v1 = {"MOVE", "RESET"}
                    v2 = nil
                    v3 = nil

                    for i8, i9 in v1, v2, v3 do
                        TextButton_3 = Instance.new("TextButton")
                        TextButton_3.Size = UDim2.fromOffset(57, u40.tap(34))
                        TextButton_3.Position = UDim2.new(1, -132 + (i8 - 1) * 63, 0.5, -u40.tap(34) / 2)
                        TextButton_3.Text = i9
                        TextButton_3.BackgroundColor3 = if i9 ~= "MOVE" then
                            u78
                        else
                            Color3.fromRGB(58, 132, 96)
                        TextButton_3.TextColor3 = if i9 ~= "MOVE" then
                            u83
                        else
                            Color3.fromRGB(245, 246, 252)
                        TextButton_3.TextSize = 13
                        TextButton_3.FontFace = u40.Font.Bold
                        TextButton_3.Parent = Frame
                        UICorner_4 = Instance.new("UICorner")
                        UICorner_4.CornerRadius = UDim.new(0, 5)
                        UICorner_4.Parent = TextButton_3

                        TextButton_3.Activated:Connect(function()
                            -- Line: 355
                            -- upvalues: u56 (upval), i9 (val), PortalMoveController (upval), u61 (upval)
                            u56.close()

                            if i9 == "MOVE" then
                                PortalMoveController.begin()
                                return
                            end

                            u61:FireServer()
                        end)
                    end

                    if u448 and not u70[n.assetId] then
                        task.spawn(function()
                            -- Line: 306
                            -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval)
                            fetchPrice(n)

                            if ImageLabel.Parent then
                                ImageLabel.Image = u70[n.assetId] or ""
                            end
                        end)
                    end
                elseif n.id ~= "SpawnMover" then
                    if not u448 then
                        TextLabel_3 = Instance.new("TextLabel")
                        TextLabel_3.Size = UDim2.fromOffset(110, 30)
                        TextLabel_3.Position = UDim2.new(1, -122, 0.5, -15)
                        TextLabel_3.BackgroundColor3 = Color3.fromRGB(48, 52, 66)
                        TextLabel_3.Text = "COMING SOON"
                        TextLabel_3.TextColor3 = Color3.fromRGB(160, 168, 190)
                        TextLabel_3.TextSize = 11
                        TextLabel_3.FontFace = u40.Font.Bold
                        TextLabel_3.Parent = Frame
                        UICorner_7 = Instance.new("UICorner")
                        UICorner_7.CornerRadius = UDim.new(0, 5)
                        UICorner_7.Parent = TextLabel_3
                    else
                        local TextButton = Instance.new("TextButton")
                        TextButton.Size = UDim2.fromOffset(120, u40.tap(34))
                        TextButton.Position = UDim2.new(1, -132, 0.5, -u40.tap(34) / 2)
                        TextButton.BackgroundColor3 = Color3.fromRGB(58, 132, 96)
                        v2 = u69[n.assetId]
                        TextButton.Text = if not v2 then "…" else priceText(v2)
                        TextButton.TextColor3 = Color3.fromRGB(245, 246, 252)
                        TextButton.TextSize = 17
                        TextButton.FontFace = u40.Font.Bold
                        TextButton.Parent = Frame

                        if u72[n.assetId] then
                            TextButton.Text = "OWNED"
                            TextButton.BackgroundColor3 = u78
                            TextButton.TextColor3 = u83
                            TextButton.Active = false
                            TextButton.AutoButtonColor = false

                            TextButton:SetAttribute("Owned", true)
                        end

                        if not v2 then
                            task.spawn(function()
                                -- Line: 415
                                -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval)
                                -- upvalues: TextButton (val), priceText (upval)
                                local v1 = fetchPrice(n)

                                if ImageLabel.Parent then
                                    ImageLabel.Image = u70[n.assetId] or ""
                                end

                                if TextButton.Parent and not TextButton:GetAttribute("Owned") then
                                    TextButton.Text = priceText(v1)
                                end
                            end)
                        end

                        if n.kind == "Pass" and u72[n.assetId] == nil then
                            task.spawn(function()
                                -- Line: 426
                                -- upvalues: n (val), u72 (upval), MarketplaceService (upval), LocalPlayer (upval)
                                -- upvalues: TextButton (val), u78 (upval), u83 (upval)
                                local v1
                                local u0 = n

                                if u0.kind == "Pass" then
                                    local v2 = u72[u0.assetId]

                                    if v2 == nil then
                                        local success, err = pcall(function()
                                            -- Line: 111
                                            -- upvalues: MarketplaceService (upval), LocalPlayer (upval), u0 (val)
                                            return MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, u0.assetId)
                                        end)
                                        v2 = success and err == true

                                        if success then
                                            u72[u0.assetId] = v2
                                        end
                                    end

                                    v1 = v2
                                else
                                    v1 = false
                                end

                                if v1 and TextButton.Parent then
                                    TextButton.Text = "OWNED"
                                    TextButton.BackgroundColor3 = u78
                                    TextButton.TextColor3 = u83
                                    TextButton.Active = false
                                    TextButton.AutoButtonColor = false

                                    TextButton:SetAttribute("Owned", true)
                                end
                            end)
                        end

                        UICorner_6 = Instance.new("UICorner")
                        UICorner_6.CornerRadius = UDim.new(0, 5)
                        UICorner_6.Parent = TextButton

                        TextButton.MouseButton1Click:Connect(function()
                            -- Line: 437
                            -- upvalues: TextButton (val), n (val), MarketplaceService (upval), LocalPlayer (upval)
                            if TextButton:GetAttribute("Owned") then
                                return
                            end

                            if n.kind == "Pass" then
                                MarketplaceService:PromptGamePassPurchase(LocalPlayer, n.assetId)
                                return
                            end

                            MarketplaceService:PromptProductPurchase(LocalPlayer, n.assetId)
                        end)
                    end
                elseif LocalPlayer:GetAttribute(Config.Monetization.SpawnMoverAttribute) == true then
                    v2 = {
                        {
                            label = "MY SPAWN",
                            kind = "Member",
                            x = 0,
                            y = 0,
                            w = 57,
                            primary = true,
                        },
                        {
                            label = "VISITORS",
                            kind = "Visitor",
                            x = 63,
                            y = 0,
                            w = 57,
                            primary = true,
                        },
                        {
                            label = "RESET",
                            kind = "Reset",
                            x = 0,
                            y = 36,
                            w = 120,
                            primary = false,
                        },
                    }
                    v3 = nil
                    v4 = nil

                    for i6, i7 in v2, v3, v4 do
                        TextButton_4 = Instance.new("TextButton")
                        TextButton_4.Size = UDim2.fromOffset(i7.w, 30)
                        TextButton_4.Position = UDim2.new(1, -132 + i7.x, 0.5, -33 + i7.y)
                        TextButton_4.Text = i7.label
                        TextButton_4.BackgroundColor3 = if not i7.primary then
                            u78
                        else
                            Color3.fromRGB(58, 132, 96)
                        TextButton_4.TextColor3 = if not i7.primary then
                            u83
                        else
                            Color3.fromRGB(245, 246, 252)
                        TextButton_4.TextSize = 11
                        TextButton_4.FontFace = u40.Font.Bold
                        TextButton_4.Parent = Frame
                        UICorner_5 = Instance.new("UICorner")
                        UICorner_5.CornerRadius = UDim.new(0, 5)
                        UICorner_5.Parent = TextButton_4

                        TextButton_4.Activated:Connect(function()
                            -- Line: 391
                            -- upvalues: u56 (upval), u64 (upval), i7 (val)
                            u56.close()
                            u64:FireServer(i7.kind)
                        end)
                    end

                    if u448 and not u70[n.assetId] then
                        task.spawn(function()
                            -- Line: 306
                            -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval)
                            fetchPrice(n)

                            if ImageLabel.Parent then
                                ImageLabel.Image = u70[n.assetId] or ""
                            end
                        end)
                    end
                elseif not u448 then
                    TextLabel_3 = Instance.new("TextLabel")
                    TextLabel_3.Size = UDim2.fromOffset(110, 30)
                    TextLabel_3.Position = UDim2.new(1, -122, 0.5, -15)
                    TextLabel_3.BackgroundColor3 = Color3.fromRGB(48, 52, 66)
                    TextLabel_3.Text = "COMING SOON"
                    TextLabel_3.TextColor3 = Color3.fromRGB(160, 168, 190)
                    TextLabel_3.TextSize = 11
                    TextLabel_3.FontFace = u40.Font.Bold
                    TextLabel_3.Parent = Frame
                    UICorner_7 = Instance.new("UICorner")
                    UICorner_7.CornerRadius = UDim.new(0, 5)
                    UICorner_7.Parent = TextLabel_3
                else
                    local TextButton = Instance.new("TextButton")
                    TextButton.Size = UDim2.fromOffset(120, u40.tap(34))
                    TextButton.Position = UDim2.new(1, -132, 0.5, -u40.tap(34) / 2)
                    TextButton.BackgroundColor3 = Color3.fromRGB(58, 132, 96)
                    v2 = u69[n.assetId]
                    TextButton.Text = if not v2 then "…" else priceText(v2)
                    TextButton.TextColor3 = Color3.fromRGB(245, 246, 252)
                    TextButton.TextSize = 17
                    TextButton.FontFace = u40.Font.Bold
                    TextButton.Parent = Frame

                    if u72[n.assetId] then
                        TextButton.Text = "OWNED"
                        TextButton.BackgroundColor3 = u78
                        TextButton.TextColor3 = u83
                        TextButton.Active = false
                        TextButton.AutoButtonColor = false

                        TextButton:SetAttribute("Owned", true)
                    end

                    if not v2 then
                        task.spawn(function()
                            -- Line: 415
                            -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval), TextButton (val)
                            -- upvalues: priceText (upval)
                            local v1 = fetchPrice(n)

                            if ImageLabel.Parent then
                                ImageLabel.Image = u70[n.assetId] or ""
                            end

                            if TextButton.Parent and not TextButton:GetAttribute("Owned") then
                                TextButton.Text = priceText(v1)
                            end
                        end)
                    end

                    if n.kind == "Pass" and u72[n.assetId] == nil then
                        task.spawn(function()
                            -- Line: 426
                            -- upvalues: n (val), u72 (upval), MarketplaceService (upval), LocalPlayer (upval)
                            -- upvalues: TextButton (val), u78 (upval), u83 (upval)
                            local v1
                            local u0 = n

                            if u0.kind == "Pass" then
                                local v2 = u72[u0.assetId]

                                if v2 == nil then
                                    local success, err = pcall(function()
                                        -- Line: 111
                                        -- upvalues: MarketplaceService (upval), LocalPlayer (upval), u0 (val)
                                        return MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, u0.assetId)
                                    end)
                                    v2 = success and err == true

                                    if success then
                                        u72[u0.assetId] = v2
                                    end
                                end

                                v1 = v2
                            else
                                v1 = false
                            end

                            if v1 and TextButton.Parent then
                                TextButton.Text = "OWNED"
                                TextButton.BackgroundColor3 = u78
                                TextButton.TextColor3 = u83
                                TextButton.Active = false
                                TextButton.AutoButtonColor = false

                                TextButton:SetAttribute("Owned", true)
                            end
                        end)
                    end

                    UICorner_6 = Instance.new("UICorner")
                    UICorner_6.CornerRadius = UDim.new(0, 5)
                    UICorner_6.Parent = TextButton

                    TextButton.MouseButton1Click:Connect(function()
                        -- Line: 437
                        -- upvalues: TextButton (val), n (val), MarketplaceService (upval), LocalPlayer (upval)
                        if TextButton:GetAttribute("Owned") then
                            return
                        end

                        if n.kind == "Pass" then
                            MarketplaceService:PromptGamePassPurchase(LocalPlayer, n.assetId)
                            return
                        end

                        MarketplaceService:PromptProductPurchase(LocalPlayer, n.assetId)
                    end)
                end
            elseif n.id ~= "SpawnMover" then
                if not u448 then
                    TextLabel_3 = Instance.new("TextLabel")
                    TextLabel_3.Size = UDim2.fromOffset(110, 30)
                    TextLabel_3.Position = UDim2.new(1, -122, 0.5, -15)
                    TextLabel_3.BackgroundColor3 = Color3.fromRGB(48, 52, 66)
                    TextLabel_3.Text = "COMING SOON"
                    TextLabel_3.TextColor3 = Color3.fromRGB(160, 168, 190)
                    TextLabel_3.TextSize = 11
                    TextLabel_3.FontFace = u40.Font.Bold
                    TextLabel_3.Parent = Frame
                    UICorner_7 = Instance.new("UICorner")
                    UICorner_7.CornerRadius = UDim.new(0, 5)
                    UICorner_7.Parent = TextLabel_3
                else
                    local TextButton = Instance.new("TextButton")
                    TextButton.Size = UDim2.fromOffset(120, u40.tap(34))
                    TextButton.Position = UDim2.new(1, -132, 0.5, -u40.tap(34) / 2)
                    TextButton.BackgroundColor3 = Color3.fromRGB(58, 132, 96)
                    v2 = u69[n.assetId]
                    TextButton.Text = if not v2 then "…" else priceText(v2)
                    TextButton.TextColor3 = Color3.fromRGB(245, 246, 252)
                    TextButton.TextSize = 17
                    TextButton.FontFace = u40.Font.Bold
                    TextButton.Parent = Frame

                    if u72[n.assetId] then
                        TextButton.Text = "OWNED"
                        TextButton.BackgroundColor3 = u78
                        TextButton.TextColor3 = u83
                        TextButton.Active = false
                        TextButton.AutoButtonColor = false

                        TextButton:SetAttribute("Owned", true)
                    end

                    if not v2 then
                        task.spawn(function()
                            -- Line: 415
                            -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval), TextButton (val)
                            -- upvalues: priceText (upval)
                            local v1 = fetchPrice(n)

                            if ImageLabel.Parent then
                                ImageLabel.Image = u70[n.assetId] or ""
                            end

                            if TextButton.Parent and not TextButton:GetAttribute("Owned") then
                                TextButton.Text = priceText(v1)
                            end
                        end)
                    end

                    if n.kind == "Pass" and u72[n.assetId] == nil then
                        task.spawn(function()
                            -- Line: 426
                            -- upvalues: n (val), u72 (upval), MarketplaceService (upval), LocalPlayer (upval)
                            -- upvalues: TextButton (val), u78 (upval), u83 (upval)
                            local v1
                            local u0 = n

                            if u0.kind == "Pass" then
                                local v2 = u72[u0.assetId]

                                if v2 == nil then
                                    local success, err = pcall(function()
                                        -- Line: 111
                                        -- upvalues: MarketplaceService (upval), LocalPlayer (upval), u0 (val)
                                        return MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, u0.assetId)
                                    end)
                                    v2 = success and err == true

                                    if success then
                                        u72[u0.assetId] = v2
                                    end
                                end

                                v1 = v2
                            else
                                v1 = false
                            end

                            if v1 and TextButton.Parent then
                                TextButton.Text = "OWNED"
                                TextButton.BackgroundColor3 = u78
                                TextButton.TextColor3 = u83
                                TextButton.Active = false
                                TextButton.AutoButtonColor = false

                                TextButton:SetAttribute("Owned", true)
                            end
                        end)
                    end

                    UICorner_6 = Instance.new("UICorner")
                    UICorner_6.CornerRadius = UDim.new(0, 5)
                    UICorner_6.Parent = TextButton

                    TextButton.MouseButton1Click:Connect(function()
                        -- Line: 437
                        -- upvalues: TextButton (val), n (val), MarketplaceService (upval), LocalPlayer (upval)
                        if TextButton:GetAttribute("Owned") then
                            return
                        end

                        if n.kind == "Pass" then
                            MarketplaceService:PromptGamePassPurchase(LocalPlayer, n.assetId)
                            return
                        end

                        MarketplaceService:PromptProductPurchase(LocalPlayer, n.assetId)
                    end)
                end
            elseif LocalPlayer:GetAttribute(Config.Monetization.SpawnMoverAttribute) == true then
                v2 = {
                    {
                        label = "MY SPAWN",
                        kind = "Member",
                        x = 0,
                        y = 0,
                        w = 57,
                        primary = true,
                    },
                    {
                        label = "VISITORS",
                        kind = "Visitor",
                        x = 63,
                        y = 0,
                        w = 57,
                        primary = true,
                    },
                    {
                        label = "RESET",
                        kind = "Reset",
                        x = 0,
                        y = 36,
                        w = 120,
                        primary = false,
                    },
                }
                v3 = nil
                v4 = nil

                for m, i5 in v2, v3, v4 do
                    TextButton_4 = Instance.new("TextButton")
                    TextButton_4.Size = UDim2.fromOffset(i5.w, 30)
                    TextButton_4.Position = UDim2.new(1, -132 + i5.x, 0.5, -33 + i5.y)
                    TextButton_4.Text = i5.label
                    TextButton_4.BackgroundColor3 = if not i5.primary then
                        u78
                    else
                        Color3.fromRGB(58, 132, 96)
                    TextButton_4.TextColor3 = if not i5.primary then
                        u83
                    else
                        Color3.fromRGB(245, 246, 252)
                    TextButton_4.TextSize = 11
                    TextButton_4.FontFace = u40.Font.Bold
                    TextButton_4.Parent = Frame
                    UICorner_5 = Instance.new("UICorner")
                    UICorner_5.CornerRadius = UDim.new(0, 5)
                    UICorner_5.Parent = TextButton_4

                    TextButton_4.Activated:Connect(function()
                        -- Line: 391
                        -- upvalues: u56 (upval), u64 (upval), i5 (val)
                        u56.close()
                        u64:FireServer(i5.kind)
                    end)
                end

                if u448 and not u70[n.assetId] then
                    task.spawn(function()
                        -- Line: 306
                        -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval)
                        fetchPrice(n)

                        if ImageLabel.Parent then
                            ImageLabel.Image = u70[n.assetId] or ""
                        end
                    end)
                end
            elseif not u448 then
                TextLabel_3 = Instance.new("TextLabel")
                TextLabel_3.Size = UDim2.fromOffset(110, 30)
                TextLabel_3.Position = UDim2.new(1, -122, 0.5, -15)
                TextLabel_3.BackgroundColor3 = Color3.fromRGB(48, 52, 66)
                TextLabel_3.Text = "COMING SOON"
                TextLabel_3.TextColor3 = Color3.fromRGB(160, 168, 190)
                TextLabel_3.TextSize = 11
                TextLabel_3.FontFace = u40.Font.Bold
                TextLabel_3.Parent = Frame
                UICorner_7 = Instance.new("UICorner")
                UICorner_7.CornerRadius = UDim.new(0, 5)
                UICorner_7.Parent = TextLabel_3
            else
                local TextButton = Instance.new("TextButton")
                TextButton.Size = UDim2.fromOffset(120, u40.tap(34))
                TextButton.Position = UDim2.new(1, -132, 0.5, -u40.tap(34) / 2)
                TextButton.BackgroundColor3 = Color3.fromRGB(58, 132, 96)
                v2 = u69[n.assetId]
                TextButton.Text = if not v2 then "…" else priceText(v2)
                TextButton.TextColor3 = Color3.fromRGB(245, 246, 252)
                TextButton.TextSize = 17
                TextButton.FontFace = u40.Font.Bold
                TextButton.Parent = Frame

                if u72[n.assetId] then
                    TextButton.Text = "OWNED"
                    TextButton.BackgroundColor3 = u78
                    TextButton.TextColor3 = u83
                    TextButton.Active = false
                    TextButton.AutoButtonColor = false

                    TextButton:SetAttribute("Owned", true)
                end

                if not v2 then
                    task.spawn(function()
                        -- Line: 415
                        -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval), TextButton (val)
                        -- upvalues: priceText (upval)
                        local v1 = fetchPrice(n)

                        if ImageLabel.Parent then
                            ImageLabel.Image = u70[n.assetId] or ""
                        end

                        if TextButton.Parent and not TextButton:GetAttribute("Owned") then
                            TextButton.Text = priceText(v1)
                        end
                    end)
                end

                if n.kind == "Pass" and u72[n.assetId] == nil then
                    task.spawn(function()
                        -- Line: 426
                        -- upvalues: n (val), u72 (upval), MarketplaceService (upval), LocalPlayer (upval)
                        -- upvalues: TextButton (val), u78 (upval), u83 (upval)
                        local v1
                        local u0 = n

                        if u0.kind == "Pass" then
                            local v2 = u72[u0.assetId]

                            if v2 == nil then
                                local success, err = pcall(function()
                                    -- Line: 111
                                    -- upvalues: MarketplaceService (upval), LocalPlayer (upval), u0 (val)
                                    return MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, u0.assetId)
                                end)
                                v2 = success and err == true

                                if success then
                                    u72[u0.assetId] = v2
                                end
                            end

                            v1 = v2
                        else
                            v1 = false
                        end

                        if v1 and TextButton.Parent then
                            TextButton.Text = "OWNED"
                            TextButton.BackgroundColor3 = u78
                            TextButton.TextColor3 = u83
                            TextButton.Active = false
                            TextButton.AutoButtonColor = false

                            TextButton:SetAttribute("Owned", true)
                        end
                    end)
                end

                UICorner_6 = Instance.new("UICorner")
                UICorner_6.CornerRadius = UDim.new(0, 5)
                UICorner_6.Parent = TextButton

                TextButton.MouseButton1Click:Connect(function()
                    -- Line: 437
                    -- upvalues: TextButton (val), n (val), MarketplaceService (upval), LocalPlayer (upval)
                    if TextButton:GetAttribute("Owned") then
                        return
                    end

                    if n.kind == "Pass" then
                        MarketplaceService:PromptGamePassPurchase(LocalPlayer, n.assetId)
                        return
                    end

                    MarketplaceService:PromptProductPurchase(LocalPlayer, n.assetId)
                end)
            end
        elseif BuilderLightController.owns() then
            TextButton_2 = Instance.new("TextButton")
            TextButton_2.Size = UDim2.fromOffset(120, u40.tap(34))
            TextButton_2.Position = UDim2.new(1, -132, 0.5, -u40.tap(34) / 2)
            v2 = BuilderLightController.isOn()
            TextButton_2.Text = if not v2 then "OFF" else "ON"
            TextButton_2.BackgroundColor3 = if not v2 then u78 else Color3.fromRGB(58, 132, 96)
            TextButton_2.TextColor3 = if not v2 then u83 else Color3.fromRGB(245, 246, 252)
            TextButton_2.TextSize = 17
            TextButton_2.FontFace = u40.Font.Bold
            TextButton_2.Parent = Frame
            UICorner_3 = Instance.new("UICorner")
            UICorner_3.CornerRadius = UDim.new(0, 5)
            UICorner_3.Parent = TextButton_2

            TextButton_2.Activated:Connect(function() -- Line: 331; upvalues: BuilderLightController (upval)
                BuilderLightController.setOn(not BuilderLightController.isOn())
            end)

            if u448 and not u70[n.assetId] then
                task.spawn(function()
                    -- Line: 306
                    -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval)
                    fetchPrice(n)

                    if ImageLabel.Parent then
                        ImageLabel.Image = u70[n.assetId] or ""
                    end
                end)
            end
        elseif n.id == "PortalMover" then
            v1 = LocalPlayer

            if v1:GetAttribute(Config.Monetization.PortalMoverAttribute) == true then
                v1 = {"MOVE", "RESET"}
                v2 = nil
                v3 = nil

                for i14, i15 in v1, v2, v3 do
                    TextButton_3 = Instance.new("TextButton")
                    TextButton_3.Size = UDim2.fromOffset(57, u40.tap(34))
                    TextButton_3.Position = UDim2.new(1, -132 + (i14 - 1) * 63, 0.5, -u40.tap(34) / 2)
                    TextButton_3.Text = i15
                    TextButton_3.BackgroundColor3 = if i15 ~= "MOVE" then
                        u78
                    else
                        Color3.fromRGB(58, 132, 96)
                    TextButton_3.TextColor3 = if i15 ~= "MOVE" then
                        u83
                    else
                        Color3.fromRGB(245, 246, 252)
                    TextButton_3.TextSize = 13
                    TextButton_3.FontFace = u40.Font.Bold
                    TextButton_3.Parent = Frame
                    UICorner_4 = Instance.new("UICorner")
                    UICorner_4.CornerRadius = UDim.new(0, 5)
                    UICorner_4.Parent = TextButton_3

                    TextButton_3.Activated:Connect(function()
                        -- Line: 355
                        -- upvalues: u56 (upval), i15 (val), PortalMoveController (upval), u61 (upval)
                        u56.close()

                        if i15 == "MOVE" then
                            PortalMoveController.begin()
                            return
                        end

                        u61:FireServer()
                    end)
                end

                if u448 and not u70[n.assetId] then
                    task.spawn(function()
                        -- Line: 306
                        -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval)
                        fetchPrice(n)

                        if ImageLabel.Parent then
                            ImageLabel.Image = u70[n.assetId] or ""
                        end
                    end)
                end
            elseif n.id ~= "SpawnMover" then
                if not u448 then
                    TextLabel_3 = Instance.new("TextLabel")
                    TextLabel_3.Size = UDim2.fromOffset(110, 30)
                    TextLabel_3.Position = UDim2.new(1, -122, 0.5, -15)
                    TextLabel_3.BackgroundColor3 = Color3.fromRGB(48, 52, 66)
                    TextLabel_3.Text = "COMING SOON"
                    TextLabel_3.TextColor3 = Color3.fromRGB(160, 168, 190)
                    TextLabel_3.TextSize = 11
                    TextLabel_3.FontFace = u40.Font.Bold
                    TextLabel_3.Parent = Frame
                    UICorner_7 = Instance.new("UICorner")
                    UICorner_7.CornerRadius = UDim.new(0, 5)
                    UICorner_7.Parent = TextLabel_3
                else
                    local TextButton = Instance.new("TextButton")
                    TextButton.Size = UDim2.fromOffset(120, u40.tap(34))
                    TextButton.Position = UDim2.new(1, -132, 0.5, -u40.tap(34) / 2)
                    TextButton.BackgroundColor3 = Color3.fromRGB(58, 132, 96)
                    v2 = u69[n.assetId]
                    TextButton.Text = if not v2 then "…" else priceText(v2)
                    TextButton.TextColor3 = Color3.fromRGB(245, 246, 252)
                    TextButton.TextSize = 17
                    TextButton.FontFace = u40.Font.Bold
                    TextButton.Parent = Frame

                    if u72[n.assetId] then
                        TextButton.Text = "OWNED"
                        TextButton.BackgroundColor3 = u78
                        TextButton.TextColor3 = u83
                        TextButton.Active = false
                        TextButton.AutoButtonColor = false

                        TextButton:SetAttribute("Owned", true)
                    end

                    if not v2 then
                        task.spawn(function()
                            -- Line: 415
                            -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval), TextButton (val)
                            -- upvalues: priceText (upval)
                            local v1 = fetchPrice(n)

                            if ImageLabel.Parent then
                                ImageLabel.Image = u70[n.assetId] or ""
                            end

                            if TextButton.Parent and not TextButton:GetAttribute("Owned") then
                                TextButton.Text = priceText(v1)
                            end
                        end)
                    end

                    if n.kind == "Pass" and u72[n.assetId] == nil then
                        task.spawn(function()
                            -- Line: 426
                            -- upvalues: n (val), u72 (upval), MarketplaceService (upval), LocalPlayer (upval)
                            -- upvalues: TextButton (val), u78 (upval), u83 (upval)
                            local v1
                            local u0 = n

                            if u0.kind == "Pass" then
                                local v2 = u72[u0.assetId]

                                if v2 == nil then
                                    local success, err = pcall(function()
                                        -- Line: 111
                                        -- upvalues: MarketplaceService (upval), LocalPlayer (upval), u0 (val)
                                        return MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, u0.assetId)
                                    end)
                                    v2 = success and err == true

                                    if success then
                                        u72[u0.assetId] = v2
                                    end
                                end

                                v1 = v2
                            else
                                v1 = false
                            end

                            if v1 and TextButton.Parent then
                                TextButton.Text = "OWNED"
                                TextButton.BackgroundColor3 = u78
                                TextButton.TextColor3 = u83
                                TextButton.Active = false
                                TextButton.AutoButtonColor = false

                                TextButton:SetAttribute("Owned", true)
                            end
                        end)
                    end

                    UICorner_6 = Instance.new("UICorner")
                    UICorner_6.CornerRadius = UDim.new(0, 5)
                    UICorner_6.Parent = TextButton

                    TextButton.MouseButton1Click:Connect(function()
                        -- Line: 437
                        -- upvalues: TextButton (val), n (val), MarketplaceService (upval), LocalPlayer (upval)
                        if TextButton:GetAttribute("Owned") then
                            return
                        end

                        if n.kind == "Pass" then
                            MarketplaceService:PromptGamePassPurchase(LocalPlayer, n.assetId)
                            return
                        end

                        MarketplaceService:PromptProductPurchase(LocalPlayer, n.assetId)
                    end)
                end
            elseif LocalPlayer:GetAttribute(Config.Monetization.SpawnMoverAttribute) == true then
                v2 = {
                    {
                        label = "MY SPAWN",
                        kind = "Member",
                        x = 0,
                        y = 0,
                        w = 57,
                        primary = true,
                    },
                    {
                        label = "VISITORS",
                        kind = "Visitor",
                        x = 63,
                        y = 0,
                        w = 57,
                        primary = true,
                    },
                    {
                        label = "RESET",
                        kind = "Reset",
                        x = 0,
                        y = 36,
                        w = 120,
                        primary = false,
                    },
                }
                v3 = nil
                v4 = nil

                for i12, i13 in v2, v3, v4 do
                    TextButton_4 = Instance.new("TextButton")
                    TextButton_4.Size = UDim2.fromOffset(i13.w, 30)
                    TextButton_4.Position = UDim2.new(1, -132 + i13.x, 0.5, -33 + i13.y)
                    TextButton_4.Text = i13.label
                    TextButton_4.BackgroundColor3 = if not i13.primary then
                        u78
                    else
                        Color3.fromRGB(58, 132, 96)
                    TextButton_4.TextColor3 = if not i13.primary then
                        u83
                    else
                        Color3.fromRGB(245, 246, 252)
                    TextButton_4.TextSize = 11
                    TextButton_4.FontFace = u40.Font.Bold
                    TextButton_4.Parent = Frame
                    UICorner_5 = Instance.new("UICorner")
                    UICorner_5.CornerRadius = UDim.new(0, 5)
                    UICorner_5.Parent = TextButton_4

                    TextButton_4.Activated:Connect(function()
                        -- Line: 391
                        -- upvalues: u56 (upval), u64 (upval), i13 (val)
                        u56.close()
                        u64:FireServer(i13.kind)
                    end)
                end

                if u448 and not u70[n.assetId] then
                    task.spawn(function()
                        -- Line: 306
                        -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval)
                        fetchPrice(n)

                        if ImageLabel.Parent then
                            ImageLabel.Image = u70[n.assetId] or ""
                        end
                    end)
                end
            elseif not u448 then
                TextLabel_3 = Instance.new("TextLabel")
                TextLabel_3.Size = UDim2.fromOffset(110, 30)
                TextLabel_3.Position = UDim2.new(1, -122, 0.5, -15)
                TextLabel_3.BackgroundColor3 = Color3.fromRGB(48, 52, 66)
                TextLabel_3.Text = "COMING SOON"
                TextLabel_3.TextColor3 = Color3.fromRGB(160, 168, 190)
                TextLabel_3.TextSize = 11
                TextLabel_3.FontFace = u40.Font.Bold
                TextLabel_3.Parent = Frame
                UICorner_7 = Instance.new("UICorner")
                UICorner_7.CornerRadius = UDim.new(0, 5)
                UICorner_7.Parent = TextLabel_3
            else
                local TextButton = Instance.new("TextButton")
                TextButton.Size = UDim2.fromOffset(120, u40.tap(34))
                TextButton.Position = UDim2.new(1, -132, 0.5, -u40.tap(34) / 2)
                TextButton.BackgroundColor3 = Color3.fromRGB(58, 132, 96)
                v2 = u69[n.assetId]
                TextButton.Text = if not v2 then "…" else priceText(v2)
                TextButton.TextColor3 = Color3.fromRGB(245, 246, 252)
                TextButton.TextSize = 17
                TextButton.FontFace = u40.Font.Bold
                TextButton.Parent = Frame

                if u72[n.assetId] then
                    TextButton.Text = "OWNED"
                    TextButton.BackgroundColor3 = u78
                    TextButton.TextColor3 = u83
                    TextButton.Active = false
                    TextButton.AutoButtonColor = false

                    TextButton:SetAttribute("Owned", true)
                end

                if not v2 then
                    task.spawn(function()
                        -- Line: 415
                        -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval), TextButton (val)
                        -- upvalues: priceText (upval)
                        local v1 = fetchPrice(n)

                        if ImageLabel.Parent then
                            ImageLabel.Image = u70[n.assetId] or ""
                        end

                        if TextButton.Parent and not TextButton:GetAttribute("Owned") then
                            TextButton.Text = priceText(v1)
                        end
                    end)
                end

                if n.kind == "Pass" and u72[n.assetId] == nil then
                    task.spawn(function()
                        -- Line: 426
                        -- upvalues: n (val), u72 (upval), MarketplaceService (upval), LocalPlayer (upval)
                        -- upvalues: TextButton (val), u78 (upval), u83 (upval)
                        local v1
                        local u0 = n

                        if u0.kind == "Pass" then
                            local v2 = u72[u0.assetId]

                            if v2 == nil then
                                local success, err = pcall(function()
                                    -- Line: 111
                                    -- upvalues: MarketplaceService (upval), LocalPlayer (upval), u0 (val)
                                    return MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, u0.assetId)
                                end)
                                v2 = success and err == true

                                if success then
                                    u72[u0.assetId] = v2
                                end
                            end

                            v1 = v2
                        else
                            v1 = false
                        end

                        if v1 and TextButton.Parent then
                            TextButton.Text = "OWNED"
                            TextButton.BackgroundColor3 = u78
                            TextButton.TextColor3 = u83
                            TextButton.Active = false
                            TextButton.AutoButtonColor = false

                            TextButton:SetAttribute("Owned", true)
                        end
                    end)
                end

                UICorner_6 = Instance.new("UICorner")
                UICorner_6.CornerRadius = UDim.new(0, 5)
                UICorner_6.Parent = TextButton

                TextButton.MouseButton1Click:Connect(function()
                    -- Line: 437
                    -- upvalues: TextButton (val), n (val), MarketplaceService (upval), LocalPlayer (upval)
                    if TextButton:GetAttribute("Owned") then
                        return
                    end

                    if n.kind == "Pass" then
                        MarketplaceService:PromptGamePassPurchase(LocalPlayer, n.assetId)
                        return
                    end

                    MarketplaceService:PromptProductPurchase(LocalPlayer, n.assetId)
                end)
            end
        elseif n.id ~= "SpawnMover" then
            if not u448 then
                TextLabel_3 = Instance.new("TextLabel")
                TextLabel_3.Size = UDim2.fromOffset(110, 30)
                TextLabel_3.Position = UDim2.new(1, -122, 0.5, -15)
                TextLabel_3.BackgroundColor3 = Color3.fromRGB(48, 52, 66)
                TextLabel_3.Text = "COMING SOON"
                TextLabel_3.TextColor3 = Color3.fromRGB(160, 168, 190)
                TextLabel_3.TextSize = 11
                TextLabel_3.FontFace = u40.Font.Bold
                TextLabel_3.Parent = Frame
                UICorner_7 = Instance.new("UICorner")
                UICorner_7.CornerRadius = UDim.new(0, 5)
                UICorner_7.Parent = TextLabel_3
            else
                local TextButton = Instance.new("TextButton")
                TextButton.Size = UDim2.fromOffset(120, u40.tap(34))
                TextButton.Position = UDim2.new(1, -132, 0.5, -u40.tap(34) / 2)
                TextButton.BackgroundColor3 = Color3.fromRGB(58, 132, 96)
                v2 = u69[n.assetId]
                TextButton.Text = if not v2 then "…" else priceText(v2)
                TextButton.TextColor3 = Color3.fromRGB(245, 246, 252)
                TextButton.TextSize = 17
                TextButton.FontFace = u40.Font.Bold
                TextButton.Parent = Frame

                if u72[n.assetId] then
                    TextButton.Text = "OWNED"
                    TextButton.BackgroundColor3 = u78
                    TextButton.TextColor3 = u83
                    TextButton.Active = false
                    TextButton.AutoButtonColor = false

                    TextButton:SetAttribute("Owned", true)
                end

                if not v2 then
                    task.spawn(function()
                        -- Line: 415
                        -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval), TextButton (val)
                        -- upvalues: priceText (upval)
                        local v1 = fetchPrice(n)

                        if ImageLabel.Parent then
                            ImageLabel.Image = u70[n.assetId] or ""
                        end

                        if TextButton.Parent and not TextButton:GetAttribute("Owned") then
                            TextButton.Text = priceText(v1)
                        end
                    end)
                end

                if n.kind == "Pass" and u72[n.assetId] == nil then
                    task.spawn(function()
                        -- Line: 426
                        -- upvalues: n (val), u72 (upval), MarketplaceService (upval), LocalPlayer (upval)
                        -- upvalues: TextButton (val), u78 (upval), u83 (upval)
                        local v1
                        local u0 = n

                        if u0.kind == "Pass" then
                            local v2 = u72[u0.assetId]

                            if v2 == nil then
                                local success, err = pcall(function()
                                    -- Line: 111
                                    -- upvalues: MarketplaceService (upval), LocalPlayer (upval), u0 (val)
                                    return MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, u0.assetId)
                                end)
                                v2 = success and err == true

                                if success then
                                    u72[u0.assetId] = v2
                                end
                            end

                            v1 = v2
                        else
                            v1 = false
                        end

                        if v1 and TextButton.Parent then
                            TextButton.Text = "OWNED"
                            TextButton.BackgroundColor3 = u78
                            TextButton.TextColor3 = u83
                            TextButton.Active = false
                            TextButton.AutoButtonColor = false

                            TextButton:SetAttribute("Owned", true)
                        end
                    end)
                end

                UICorner_6 = Instance.new("UICorner")
                UICorner_6.CornerRadius = UDim.new(0, 5)
                UICorner_6.Parent = TextButton

                TextButton.MouseButton1Click:Connect(function()
                    -- Line: 437
                    -- upvalues: TextButton (val), n (val), MarketplaceService (upval), LocalPlayer (upval)
                    if TextButton:GetAttribute("Owned") then
                        return
                    end

                    if n.kind == "Pass" then
                        MarketplaceService:PromptGamePassPurchase(LocalPlayer, n.assetId)
                        return
                    end

                    MarketplaceService:PromptProductPurchase(LocalPlayer, n.assetId)
                end)
            end
        elseif LocalPlayer:GetAttribute(Config.Monetization.SpawnMoverAttribute) == true then
            v2 = {
                {
                    label = "MY SPAWN",
                    kind = "Member",
                    x = 0,
                    y = 0,
                    w = 57,
                    primary = true,
                },
                {
                    label = "VISITORS",
                    kind = "Visitor",
                    x = 63,
                    y = 0,
                    w = 57,
                    primary = true,
                },
                {
                    label = "RESET",
                    kind = "Reset",
                    x = 0,
                    y = 36,
                    w = 120,
                    primary = false,
                },
            }
            v3 = nil
            v4 = nil

            for i10, i11 in v2, v3, v4 do
                TextButton_4 = Instance.new("TextButton")
                TextButton_4.Size = UDim2.fromOffset(i11.w, 30)
                TextButton_4.Position = UDim2.new(1, -132 + i11.x, 0.5, -33 + i11.y)
                TextButton_4.Text = i11.label
                TextButton_4.BackgroundColor3 = if not i11.primary then
                    u78
                else
                    Color3.fromRGB(58, 132, 96)
                TextButton_4.TextColor3 = if not i11.primary then
                    u83
                else
                    Color3.fromRGB(245, 246, 252)
                TextButton_4.TextSize = 11
                TextButton_4.FontFace = u40.Font.Bold
                TextButton_4.Parent = Frame
                UICorner_5 = Instance.new("UICorner")
                UICorner_5.CornerRadius = UDim.new(0, 5)
                UICorner_5.Parent = TextButton_4

                TextButton_4.Activated:Connect(function() -- Line: 391; upvalues: u56 (upval), u64 (upval), i11 (val)
                    u56.close()
                    u64:FireServer(i11.kind)
                end)
            end

            if u448 and not u70[n.assetId] then
                task.spawn(function()
                    -- Line: 306
                    -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval)
                    fetchPrice(n)

                    if ImageLabel.Parent then
                        ImageLabel.Image = u70[n.assetId] or ""
                    end
                end)
            end
        elseif not u448 then
            TextLabel_3 = Instance.new("TextLabel")
            TextLabel_3.Size = UDim2.fromOffset(110, 30)
            TextLabel_3.Position = UDim2.new(1, -122, 0.5, -15)
            TextLabel_3.BackgroundColor3 = Color3.fromRGB(48, 52, 66)
            TextLabel_3.Text = "COMING SOON"
            TextLabel_3.TextColor3 = Color3.fromRGB(160, 168, 190)
            TextLabel_3.TextSize = 11
            TextLabel_3.FontFace = u40.Font.Bold
            TextLabel_3.Parent = Frame
            UICorner_7 = Instance.new("UICorner")
            UICorner_7.CornerRadius = UDim.new(0, 5)
            UICorner_7.Parent = TextLabel_3
        else
            local TextButton = Instance.new("TextButton")
            TextButton.Size = UDim2.fromOffset(120, u40.tap(34))
            TextButton.Position = UDim2.new(1, -132, 0.5, -u40.tap(34) / 2)
            TextButton.BackgroundColor3 = Color3.fromRGB(58, 132, 96)
            v2 = u69[n.assetId]
            TextButton.Text = if not v2 then "…" else priceText(v2)
            TextButton.TextColor3 = Color3.fromRGB(245, 246, 252)
            TextButton.TextSize = 17
            TextButton.FontFace = u40.Font.Bold
            TextButton.Parent = Frame

            if u72[n.assetId] then
                TextButton.Text = "OWNED"
                TextButton.BackgroundColor3 = u78
                TextButton.TextColor3 = u83
                TextButton.Active = false
                TextButton.AutoButtonColor = false

                TextButton:SetAttribute("Owned", true)
            end

            if not v2 then
                task.spawn(function()
                    -- Line: 415
                    -- upvalues: fetchPrice (upval), n (val), ImageLabel (val), u70 (upval), TextButton (val)
                    -- upvalues: priceText (upval)
                    local v1 = fetchPrice(n)

                    if ImageLabel.Parent then
                        ImageLabel.Image = u70[n.assetId] or ""
                    end

                    if TextButton.Parent and not TextButton:GetAttribute("Owned") then
                        TextButton.Text = priceText(v1)
                    end
                end)
            end

            if n.kind == "Pass" and u72[n.assetId] == nil then
                task.spawn(function()
                    -- Line: 426
                    -- upvalues: n (val), u72 (upval), MarketplaceService (upval), LocalPlayer (upval), TextButton (val)
                    -- upvalues: u78 (upval), u83 (upval)
                    local v1
                    local u0 = n

                    if u0.kind == "Pass" then
                        local v2 = u72[u0.assetId]

                        if v2 == nil then
                            local success, err = pcall(function()
                                -- Line: 111
                                -- upvalues: MarketplaceService (upval), LocalPlayer (upval), u0 (val)
                                return MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, u0.assetId)
                            end)
                            v2 = success and err == true

                            if success then
                                u72[u0.assetId] = v2
                            end
                        end

                        v1 = v2
                    else
                        v1 = false
                    end

                    if v1 and TextButton.Parent then
                        TextButton.Text = "OWNED"
                        TextButton.BackgroundColor3 = u78
                        TextButton.TextColor3 = u83
                        TextButton.Active = false
                        TextButton.AutoButtonColor = false

                        TextButton:SetAttribute("Owned", true)
                    end
                end)
            end

            UICorner_6 = Instance.new("UICorner")
            UICorner_6.CornerRadius = UDim.new(0, 5)
            UICorner_6.Parent = TextButton

            TextButton.MouseButton1Click:Connect(function()
                -- Line: 437
                -- upvalues: TextButton (val), n (val), MarketplaceService (upval), LocalPlayer (upval)
                if TextButton:GetAttribute("Owned") then
                    return
                end

                if n.kind == "Pass" then
                    MarketplaceService:PromptGamePassPurchase(LocalPlayer, n.assetId)
                    return
                end

                MarketplaceService:PromptProductPurchase(LocalPlayer, n.assetId)
            end)
        end

        v5 = v5 + 84
    end

    u67.CanvasSize = UDim2.fromOffset(0, v5)
end

function u56.close() -- Line: 474; upvalues: u66 (ref), BuildController (val)
    local Visible = false

    if u66 ~= nil then
        Visible = u66.Visible
    end

    if not Visible then
        return
    end

    u66.Visible = false
    BuildController.setUiOpen("PremiumShop", false)
end

function u56.open() -- Line: 482; upvalues: u66 (ref), u40 (val), BuildController (val), render (val)
    u66.Visible = true
    u40.appear(u66)
    BuildController.setUiOpen("PremiumShop", true)
    render()
end

function u56.toggle() -- Line: 489; upvalues: u66 (ref), u56 (val)
    local Visible = false

    if u66 ~= nil then
        Visible = u66.Visible
    end

    if Visible then
        u56.close()
        return
    end

    u56.open()
end

function u56.start()
    -- Line: 497
    -- upvalues: BuildController (val), u56 (val), MarketplaceService (val), u72 (val), u66 (ref), render (val)
    -- upvalues: BuilderLightController (val), Config (val), LocalPlayer (val), u65 (ref), u40 (val), u67 (ref)
    -- upvalues: ContextActionService (val)
    BuildController.registerMenu("PremiumShop", u56.close)

    MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(a1, a2, a3)
        -- Line: 501
        -- upvalues: u72 (upval), u66 (upval), render (upval)
        if a3 then
            u72[a2] = true
            local Visible = false

            if u66 ~= nil then
                Visible = u66.Visible
            end

            if Visible then
                render()
            end
        end
    end)

    BuilderLightController.onChanged(function() -- Line: 511; upvalues: u66 (upval), render (upval)
        local Visible = false

        if u66 ~= nil then
            Visible = u66.Visible
        end

        if Visible then
            render()
        end
    end)

    for i, j in {
        Config.Monetization.PortalMoverAttribute,
        Config.Monetization.SpawnMoverAttribute,
    } do
        (LocalPlayer:GetAttributeChangedSignal(j)):Connect(function()
            -- Line: 518
            -- upvalues: u66 (upval), render (upval)
            local Visible = false

            if u66 ~= nil then
                Visible = u66.Visible
            end

            if Visible then
                render()
            end
        end)
    end

    u65 = Instance.new("ScreenGui")
    u65.Name = "PremiumShop"
    u65.ResetOnSpawn = false
    u65.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    u65.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u66 = Instance.new("CanvasGroup")
    u66.Size = UDim2.fromOffset(470, 420)
    u66.Position = UDim2.new(0.5, -235, 0.5, -210)

    u40.fitToScreen(u66)

    u66.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    u66.BackgroundTransparency = 0.05
    u66.BorderSizePixel = 0
    u66.Visible = false
    u66.Active = true
    u66.Parent = u65

    u40.closeButton(u66, 10, u56.close)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = u66
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(58, 62, 78)
    UIStroke.Thickness = 1
    UIStroke.Parent = u66
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -24, 0, 30)
    TextLabel.Position = UDim2.fromOffset(14, 10)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "SHOP"
    TextLabel.TextColor3 = Color3.fromRGB(238, 240, 248)
    TextLabel.TextSize = 17
    TextLabel.FontFace = u40.Font.Bold
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = u66
    u67 = Instance.new("ScrollingFrame")
    u67.Size = UDim2.new(1, -20, 1, -56)
    u67.Position = UDim2.fromOffset(10, 46)
    u67.BackgroundTransparency = 1
    u67.BorderSizePixel = 0
    u67.ScrollBarThickness = 5
    u67.CanvasSize = UDim2.fromOffset(0, 0)
    u67.Parent = u66

    if Config.Monetization.ShopInMenuBar then
        local M = Enum.KeyCode.M
        ContextActionService:BindAction(
            "ToggleShop",
            function(a1, a2) -- Line: 581; upvalues: u56 (upval)
                if a2 == Enum.UserInputState.Begin then
                    u56.toggle()
                end

                return Enum.ContextActionResult.Sink
            end,
            false,
            M
        )
    end
end

return u56