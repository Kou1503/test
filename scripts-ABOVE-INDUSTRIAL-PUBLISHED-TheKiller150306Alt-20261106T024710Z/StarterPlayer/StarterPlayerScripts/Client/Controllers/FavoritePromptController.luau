-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.FavoritePromptController
-- Decompile time: 3.18 ms

local AvatarEditorService = game:GetService("AvatarEditorService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Remotes = require(Shared.Remotes)
local u33 = require(script.Parent.Parent.Ui)
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u39 = Remotes.get(Remotes.PromptFavorite)
local u42 = Remotes.get(Remotes.FavoriteResult)
local u43 = nil
local u44 = nil
local u45 = nil

local function hide(a1) -- Line: 43; upvalues: u44 (ref), u45 (ref), u42 (val); types: a1: string?
    if not u44.Visible then
        return
    end

    u44.Visible = false
    u45 = nil

    if a1 then
        u42:FireServer(a1)
    end
end

local function show() -- Line: 54; upvalues: u44 (ref), u45 (ref), TweenService (val)
    u44.Visible = true
    u44.Position = UDim2.new(1, 20, 1, -160)
    u45 = os.clock() + 12

    TweenService:Create(
        u44,
        TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = UDim2.new(1, -300, 1, -160)}
    ):Play()
end

function v1.start()
    -- Line: 66
    -- upvalues: u43 (ref), LocalPlayer (val), u44 (ref), u33 (val), u45 (ref), u42 (val), AvatarEditorService (val)
    -- upvalues: u39 (val), show (val)
    u43 = Instance.new("ScreenGui")
    u43.Name = "FavoritePrompt"
    u43.ResetOnSpawn = false
    u43.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u44 = Instance.new("Frame")
    u44.Size = UDim2.fromOffset(280, 78 + u33.tap(30))
    u44.Position = UDim2.new(1, 20, 1, -160)
    u44.BackgroundColor3 = Color3.fromRGB(24, 27, 34)
    u44.BorderSizePixel = 0
    u44.Visible = false
    u44.Active = true
    u44.Parent = u43
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = u44
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(64, 70, 88)
    UIStroke.Parent = u44
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -24, 0, 48)
    TextLabel.Position = UDim2.fromOffset(12, 12)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "Enjoying the game? Favorite it so you can find it again."
    TextLabel.TextColor3 = Color3.fromRGB(236, 239, 247)
    TextLabel.TextSize = 13
    TextLabel.FontFace = u33.Font.Medium
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top
    TextLabel.TextWrapped = true
    TextLabel.Parent = u44
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromOffset(120, u33.tap(30))
    TextButton.Position = UDim2.fromOffset(12, 66)
    TextButton.BackgroundColor3 = Color3.fromRGB(58, 132, 96)
    TextButton.Text = "FAVORITE"
    TextButton.TextColor3 = Color3.fromRGB(245, 246, 252)
    TextButton.TextSize = u33.tapText(12)
    TextButton.FontFace = u33.Font.Bold
    TextButton.Parent = u44
    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.CornerRadius = UDim.new(0, 5)
    UICorner_2.Parent = TextButton
    local TextButton_2 = Instance.new("TextButton")
    TextButton_2.Size = UDim2.fromOffset(120, u33.tap(30))
    TextButton_2.Position = UDim2.fromOffset(144, 66)
    TextButton_2.BackgroundColor3 = Color3.fromRGB(48, 52, 66)
    TextButton_2.Text = "NO THANKS"
    TextButton_2.TextColor3 = Color3.fromRGB(170, 176, 194)
    TextButton_2.TextSize = u33.tapText(12)
    TextButton_2.FontFace = u33.Font.Bold
    TextButton_2.Parent = u44
    local UICorner_3 = Instance.new("UICorner")
    UICorner_3.CornerRadius = UDim.new(0, 5)
    UICorner_3.Parent = TextButton_2

    TextButton.MouseButton1Click:Connect(function()
        -- Line: 132
        -- upvalues: u44 (upval), u45 (upval), u42 (upval), AvatarEditorService (upval)
        if u44.Visible then
            u44.Visible = false
            u45 = nil

            u42:FireServer("Accepted")
        end

        pcall(function() -- Line: 136; upvalues: AvatarEditorService (upval)
            AvatarEditorService:PromptSetFavorite(game.PlaceId, Enum.AvatarItemType.Asset, true)
        end)
    end)

    TextButton_2.MouseButton1Click:Connect(function() -- Line: 141; upvalues: u44 (upval), u45 (upval), u42 (upval)
        if not u44.Visible then
            return
        end

        u44.Visible = false
        u45 = nil

        u42:FireServer("Declined")
    end)

    AvatarEditorService.PromptSetFavoriteCompleted:Connect(function(a1) -- Line: 150; upvalues: u42 (upval)
        u42:FireServer((tostring(a1)))
    end)

    u39.OnClientEvent:Connect(show)

    ;(game:GetService("RunService")).Heartbeat:Connect(function()
        -- Line: 158
        -- upvalues: u45 (upval), u44 (upval), u42 (upval)
        local v1 = u45

        if v1 and v1 <= os.clock() then
            if not u44.Visible then
                return
            end

            u44.Visible = false
            u45 = nil

            u42:FireServer("Ignored")
        end
    end)
end

return v1