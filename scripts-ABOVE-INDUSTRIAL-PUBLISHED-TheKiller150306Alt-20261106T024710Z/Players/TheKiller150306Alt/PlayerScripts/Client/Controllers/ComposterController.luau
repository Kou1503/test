-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ComposterController
-- Decompile time: 16.04 ms

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local DeviceMode = require(script.Parent.DeviceMode)
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Palette = require(Shared.Palette)
local Remotes = require(Shared.Remotes)
local u39 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local ItemIcon = require(script.Parent.ItemIcon)
local u55 = {}
local LocalPlayer = Players.LocalPlayer
local u60 = Remotes.get(Remotes.RequestCompost)
local u63 = u39.tap(40)
local u65 = DeviceMode.touchOnly()
local u66 = nil
local u67 = nil
local u68 = nil
local u69 = nil
local u70 = nil
local u71 = nil
local u72 = nil

function u55.close() -- Line: 57; upvalues: u72 (ref), u66 (ref), BuildController (val)
    u72 = nil

    if u66 then
        u66.Visible = false
    end

    BuildController.setUiOpen("Composter", false)
end

local function feed(a1, a2) -- Line: 65; upvalues: u72 (ref), u60 (val); types: a1: string, a2: number
    local v1 = u72

    if v1 then
        u60:FireServer(v1.cellKey, a1, a2)
    end
end

local function render()
    -- Line: 72
    -- upvalues: u72 (ref), u67 (ref), u68 (ref), u69 (ref), u65 (val), ControlGlyphs (val), u39 (val), u70 (ref)
    -- upvalues: u63 (val), ItemIcon (val), Palette (val), u60 (val), u71 (ref)
    local Frame, TextLabel, TextLabel_2
    local v1 = u72

    if not v1 then
        return
    end

    local v2 = if not (0 < v1.threshold) then
        0
    else
        math.clamp(v1.points / v1.threshold, 0, 1)
    u67.Size = UDim2.fromScale(v2, 1)
    u68.Text = ("%* / %*"):format(v1.points, v1.threshold)
    u69.Text = if not v1.working then
        if not u65 then
            if not ControlGlyphs.usingGamepad() then
                "Click a seed to add one. Shift-click to add as many as it needs."
            else
                ControlGlyphs.say("{A} on a seed adds one. Hold {Y} and press {A} to add as many as it needs.")
        else
            "Tap a seed to add one. Hold to add as many as it needs."
    else
        "Composting..."
    local v3 = u69
    local Green = if not v1.working then u39.Palette.Dim else u39.Palette.Green
    v3.TextColor3 = Green

    for i, j in u70:GetChildren() do
        if j:IsA("TextButton") then
            j:Destroy()
        end
    end

    for k, n in v1.seeds do
        v2 = Instance.new("TextButton")
        v2.LayoutOrder = k
        v2.Size = UDim2.new(1, -6, 0, u63)
        v2.BackgroundColor3 = u39.Palette.Track
        v2.BorderSizePixel = 0
        v2.AutoButtonColor = true
        v2.Text = ""
        v2.Parent = u70

        u39.corner(v2, 6)

        Frame = Instance.new("Frame")
        Frame.Name = "Holder"
        Frame.Size = UDim2.fromOffset(30, 30)
        Frame.Position = UDim2.new(0, 6, 0.5, -15)
        Frame.BackgroundTransparency = 1
        Frame.Parent = v2

        ItemIcon.render(Frame, n.id, 30, 4)

        TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, -110, 1, 0)
        TextLabel.Position = UDim2.fromOffset(44, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
        TextLabel.Text = ("%*  x%*"):format(Palette.displayName(n.id), n.count)
        TextLabel.TextColor3 = u39.Palette.Text
        TextLabel.TextSize = u39.tapText(13)
        TextLabel.FontFace = u39.Font.Medium
        TextLabel.Parent = v2
        TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.AnchorPoint = Vector2.new(1, 0)
        TextLabel_2.Size = UDim2.new(0, 60, 1, 0)
        TextLabel_2.Position = UDim2.new(1, -10, 0, 0)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.TextXAlignment = Enum.TextXAlignment.Right
        TextLabel_2.Text = ("+%*"):format(n.points)
        TextLabel_2.TextColor3 = u39.Palette.Green
        TextLabel_2.TextSize = u39.tapText(13)
        TextLabel_2.FontFace = u39.Font.Bold
        TextLabel_2.Parent = v2
        local id = n.id
        local u213 = u39.holdForStack(
            v2,
            function() -- Line: 138; upvalues: id (val), u72 (upval), u60 (upval)
                local v1 = u72

                if v1 then
                    u60:FireServer(v1.cellKey, id, 10000)
                end
            end
        )

        v2.Activated:Connect(function()
            -- Line: 141
            -- upvalues: u213 (val), ControlGlyphs (upval), id (val), u72 (upval), u60 (upval)
            if u213() then
                return
            end

            local v1 = if not ControlGlyphs.bulkHeld() then 1 else 10000
            local v2 = u72

            if v2 then
                u60:FireServer(v2.cellKey, id, v1)
            end
        end)
    end

    u71.Visible = #v1.seeds == 0
    u70.CanvasSize = UDim2.fromOffset(0, #v1.seeds * (u63 + 4))
end

function u55.start()
    -- Line: 153
    -- upvalues: BuildController (val), u55 (val), LocalPlayer (val), u66 (ref), u39 (val), Palette (val), Config (val)
    -- upvalues: u67 (ref), u68 (ref), u69 (ref), u70 (ref), u71 (ref), Remotes (val), u72 (ref), render (val)
    -- upvalues: RunService (val)
    BuildController.registerMenu("Composter", u55.close)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AboveComposter"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u66 = Instance.new("Frame")
    u66.ClipsDescendants = true
    u66.Size = UDim2.fromOffset(320, 300)
    u66.Position = UDim2.new(0.5, -160, 0.5, -150)

    u39.fitToScreen(u66)

    u66.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    u66.BackgroundTransparency = 0.05
    u66.Visible = false
    u66.Active = false
    u66.Parent = ScreenGui

    u39.corner(u66, 8)

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -24, 0, 24)
    TextLabel.Position = UDim2.fromOffset(12, 8)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = Palette.displayName(Config.Recipe.Compost.Machine)
    TextLabel.TextColor3 = u39.Palette.Text
    TextLabel.TextSize = 17
    TextLabel.FontFace = u39.Font.Bold
    TextLabel.Parent = u66

    u39.closeButton(u66, 8, u55.close)

    u67 = u39.bar(u66, UDim2.new(1, -24, 0, 14), UDim2.fromOffset(12, 42), u39.Palette.Green)
    u68 = Instance.new("TextLabel")
    u68.Size = UDim2.fromScale(1, 1)
    u68.BackgroundTransparency = 1
    u68.Text = ""
    u68.TextColor3 = u39.Palette.Text
    u68.TextSize = 11
    u68.FontFace = u39.Font.Bold
    u68.ZIndex = 3
    u68.Parent = u67.Parent
    u69 = Instance.new("TextLabel")
    u69.Size = UDim2.new(1, -24, 0, 30)
    u69.Position = UDim2.fromOffset(12, 60)
    u69.BackgroundTransparency = 1
    u69.TextXAlignment = Enum.TextXAlignment.Left
    u69.TextWrapped = true
    u69.Text = ""
    u69.TextSize = 12
    u69.FontFace = u39.Font.Regular
    u69.Parent = u66
    u70 = Instance.new("ScrollingFrame")
    u70.Size = UDim2.new(1, -18, 1, -102)
    u70.Position = UDim2.fromOffset(12, 94)
    u70.BackgroundTransparency = 1
    u70.BorderSizePixel = 0
    u70.ScrollBarThickness = 4
    u70.Parent = u66
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 4)
    UIListLayout.Parent = u70
    u71 = Instance.new("TextLabel")
    u71.Size = UDim2.new(1, -24, 0, 40)
    u71.Position = UDim2.fromOffset(12, 100)
    u71.BackgroundTransparency = 1
    u71.Text = "No seeds in your backpack. Any seed will do."
    u71.TextColor3 = u39.Palette.Faint
    u71.TextSize = 13
    u71.FontFace = u39.Font.Medium
    u71.TextWrapped = true
    u71.Visible = false
    u71.Parent = u66

    ;(Remotes.get(Remotes.CompostState)).OnClientEvent:Connect(function(a1, a2)
        -- Line: 236
        -- upvalues: u72 (upval), render (upval), u66 (upval), u39 (upval), BuildController (upval)
        if type(a2) == "table" and type(a2.cellKey) == "string" then
            if a1 then
                u72 = a2
                render()

                if a1 and not u66.Visible then
                    u66.Visible = true
                    u39.appear(u66)
                    BuildController.setUiOpen("Composter", true)
                end

                return
            end

            if u72 and u72.cellKey == a2.cellKey then
                u72 = a2
                render()

                if a1 and not u66.Visible then
                    u66.Visible = true
                    u39.appear(u66)
                    BuildController.setUiOpen("Composter", true)
                end
            end
        end
    end)

    local u244 = 0
    RunService.Heartbeat:Connect(function(a1)
        -- Line: 255
        -- upvalues: u244 (ref), u72 (upval), LocalPlayer (upval), u66 (upval), u55 (upval)
        u244 = u244 + a1

        if u244 < 0.3 then
            return
        end

        u244 = 0
        local v1 = u72
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

        if v1
            and u66.Visible
            and HumanoidRootPart
            and HumanoidRootPart:IsA("BasePart")
            and 26 < (HumanoidRootPart.Position - v1.position).Magnitude then
            u55.close()
        end
    end)
end

return u55