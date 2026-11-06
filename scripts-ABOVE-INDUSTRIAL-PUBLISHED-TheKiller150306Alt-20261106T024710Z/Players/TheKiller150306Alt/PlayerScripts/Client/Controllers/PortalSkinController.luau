-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.PortalSkinController
-- Decompile time: 4.96 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local DisplayNames = require(Shared.DisplayNames)
local Remotes = require(Shared.Remotes)
local u29 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local HudController = require(script.Parent.HudController)
local PortalMoveController = require(script.Parent.PortalMoveController)
local u45 = {}
local LocalPlayer = Players.LocalPlayer
local u50 = Remotes.get(Remotes.PortalSkins)
local u53 = Remotes.get(Remotes.RequestSetPortalSkin)
local u56 = Remotes.get(Remotes.RequestUnlockPortalSkin)
local u59 = Remotes.get(Remotes.RequestPortalReset)
local u60 = nil
local u61 = nil
local u62 = nil
local u63 = nil
local u64 = {}
local u65 = nil

function u45.isOpen() -- Line: 63; upvalues: u62 (ref)
    local Visible = false

    if u62 ~= nil then
        Visible = u62.Visible
    end

    return Visible
end

local function render()
    -- Line: 68
    -- upvalues: u63 (ref), u64 (ref), u65 (ref), u29 (val), u53 (val), u56 (val), HudController (val)
    -- upvalues: DisplayNames (val)
    local Gold, Gold_2, OnGold, OnGold_2, OnGold_3, TextButton, TextButton_2, TextLabel, TextLabel_2, UICorner, v1

    for i, j in u63:GetChildren() do
        if j:IsA("TextButton") then
            j:Destroy()
        end
    end

    local v2 = 0
    local v3 = nil
    local v4 = nil

    for k, n in u64, v3, v4 do
        TextButton = Instance.new("TextButton")
        TextButton.Size = UDim2.new(1, -12, 0, 34)
        TextButton.Position = UDim2.fromOffset(6, v2)
        Gold = if n.id ~= u65 then Color3.fromRGB(32, 35, 44) else u29.Palette.Gold
        TextButton.BackgroundColor3 = Gold
        TextButton.Text = ""
        TextButton.AutoButtonColor = n.owned
        TextButton.Parent = u63
        UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = TextButton
        TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, -100, 1, 0)
        TextLabel.Position = UDim2.fromOffset(12, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = n.displayName
        OnGold = if n.id ~= u65 then
            if not n.owned then
                Color3.fromRGB(122, 129, 148)
            else
                Color3.fromRGB(236, 239, 247)
        else
            u29.Palette.OnGold
        TextLabel.TextColor3 = OnGold
        TextLabel.TextSize = 13
        TextLabel.FontFace = u29.Font.Medium
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.Parent = TextButton
        TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Size = UDim2.fromOffset(88, 34)
        TextLabel_2.Position = UDim2.new(1, -94, 0, 0)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.Text = if n.id ~= u65 then
            if not n.owned then "LOCKED" else ""
        else
            "EQUIPPED"
        OnGold_2 = if n.id ~= u65 then
            Color3.fromRGB(122, 129, 148)
        else
            u29.Palette.OnGold
        TextLabel_2.TextColor3 = OnGold_2
        TextLabel_2.TextSize = 11
        TextLabel_2.FontFace = u29.Font.Bold
        TextLabel_2.TextXAlignment = Enum.TextXAlignment.Right
        TextLabel_2.Parent = TextButton

        TextButton.MouseButton1Click:Connect(function() -- Line: 116; upvalues: n (val), u65 (upval), u53 (upval)
            if n.owned and n.id ~= u65 then
                u53:FireServer(n.id)
            end
        end)

        local costItem = n.costItem
        local costAmount = n.costAmount

        if not n.owned and costItem and costAmount then
            v1 = n.have or 0

            if costAmount <= v1 then
                u160 = true
            else
                local u160 = false
            end

            TextLabel_2.Visible = false
            TextLabel.Size = UDim2.new(1, -140, 1, 0)
            TextButton_2 = Instance.new("TextButton")
            TextButton_2.Size = UDim2.fromOffset(124, 28)
            TextButton_2.Position = UDim2.new(1, -130, 0, 3)
            Gold_2 = if not u160 then Color3.fromRGB(52, 56, 70) else u29.Palette.Gold
            TextButton_2.BackgroundColor3 = Gold_2
            OnGold_3 = if not u160 then Color3.fromRGB(190, 196, 212) else u29.Palette.OnGold
            TextButton_2.TextColor3 = OnGold_3
            TextButton_2.Text = ("UNLOCK %*/%*"):format(math.min(v1, costAmount), costAmount)
            TextButton_2.TextSize = 11
            TextButton_2.FontFace = u29.Font.Bold
            TextButton_2.AutoButtonColor = u160

            u29.corner(TextButton_2, 5)

            TextButton_2.Parent = TextButton
            TextButton_2.Activated:Connect(function()
                -- Line: 140
                -- upvalues: u160 (val), u56 (upval), n (val), HudController (upval), costAmount (val)
                -- upvalues: DisplayNames (upval), costItem (val)
                if u160 then
                    u56:FireServer(n.id)
                    return
                end

                HudController.showAlert((("Needs %* %*"):format(costAmount, (DisplayNames.of(costItem)))))
            end)
        end

        v2 = v2 + 40
    end

    u63.CanvasSize = UDim2.fromOffset(0, v2)
end

function u45.close() -- Line: 155; upvalues: u62 (ref), BuildController (val)
    local Visible = false

    if u62 ~= nil then
        Visible = u62.Visible
    end

    if not Visible then
        return
    end

    u62.Visible = false
    BuildController.setUiOpen("PortalSkin", false)
end

function u45.start()
    -- Line: 163
    -- upvalues: u61 (ref), LocalPlayer (val), u62 (ref), u29 (val), u45 (val), u63 (ref), u60 (ref)
    -- upvalues: PortalMoveController (val), u59 (val), u50 (val), u64 (ref), u65 (ref), BuildController (val)
    -- upvalues: Config (val), render (val)
    u61 = Instance.new("ScreenGui")
    u61.Name = "PortalSkin"
    u61.ResetOnSpawn = false
    u61.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u62 = Instance.new("CanvasGroup")
    u62.Size = UDim2.fromOffset(340, 320)
    u62.Position = UDim2.new(0.5, -170, 0.5, -160)

    u29.fitToScreen(u62)

    u62.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    u62.BackgroundTransparency = 0.05
    u62.BorderSizePixel = 0
    u62.Visible = false
    u62.Active = true
    u62.Parent = u61

    u29.closeButton(u62, 10, u45.close)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = u62
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(58, 62, 78)
    UIStroke.Parent = u62
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -24, 0, 28)
    TextLabel.Position = UDim2.fromOffset(14, 10)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "YOUR PORTAL"
    TextLabel.TextColor3 = Color3.fromRGB(238, 240, 248)
    TextLabel.TextSize = 16
    TextLabel.FontFace = u29.Font.Bold
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = u62
    u63 = Instance.new("ScrollingFrame")
    u63.Size = UDim2.new(1, -20, 1, -104)
    u63.Position = UDim2.fromOffset(10, 46)
    u63.BackgroundTransparency = 1
    u63.BorderSizePixel = 0
    u63.ScrollBarThickness = 5
    u63.CanvasSize = UDim2.fromOffset(0, 0)
    u63.Parent = u62
    local Frame = Instance.new("Frame")
    Frame.AnchorPoint = Vector2.new(0, 1)
    Frame.Position = UDim2.new(0, 10, 1, -10)
    Frame.Size = UDim2.new(1, -20, 0, 38)
    Frame.BackgroundTransparency = 1
    Frame.Parent = u62
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Frame

    local function footerButton(a1, a2, a3)
        -- Line: 226
        -- upvalues: u29 (upval), Frame (val)
        -- types: a1: string, a2: number, a3: function
        local TextButton = Instance.new("TextButton")
        TextButton.Size = UDim2.new(0.5, -4, 1, 0)
        TextButton.LayoutOrder = a2
        TextButton.BackgroundColor3 = Color3.fromRGB(32, 35, 44)
        TextButton.Text = a1
        TextButton.TextColor3 = Color3.fromRGB(236, 239, 247)
        TextButton.TextSize = 13
        TextButton.FontFace = u29.Font.Bold

        u29.corner(TextButton, 6)

        TextButton.Parent = Frame
        TextButton.Activated:Connect(a3)

        return TextButton
    end

    u60 = footerButton(
        "MOVE PORTAL",
        1,
        function() -- Line: 240; upvalues: u45 (upval), PortalMoveController (upval)
            u45.close()
            PortalMoveController.begin()
        end
    )

    footerButton(
        "RESET LOCATION",
        2,
        function() -- Line: 244; upvalues: u45 (upval), u59 (upval)
            u45.close()
            u59:FireServer()
        end
    )

    u50.OnClientEvent:Connect(function(a1, a2)
        -- Line: 251
        -- upvalues: u64 (upval), u65 (upval), u62 (upval), u29 (upval), BuildController (upval), u60 (upval)
        -- upvalues: LocalPlayer (upval), Config (upval), render (upval)
        if type(a1) ~= "table" then
            return
        end

        u64 = a1
        u65 = if type(a2) ~= "string" then nil else a2
        u62.Visible = true

        u29.appear(u62)
        BuildController.setUiOpen("PortalSkin", true)

        if u60 then
            u60.Visible = LocalPlayer:GetAttribute(Config.Monetization.PortalMoverAttribute) == true
        end

        render()
    end)
end

return u45