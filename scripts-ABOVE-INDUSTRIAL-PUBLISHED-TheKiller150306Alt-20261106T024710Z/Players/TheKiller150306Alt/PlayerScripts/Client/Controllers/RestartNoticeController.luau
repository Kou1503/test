-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.RestartNoticeController
-- Decompile time: 5.19 ms

local v1
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Remotes = require(Shared.Remotes)
local u33 = require(script.Parent.Parent.Ui)
local v2 = {}
local LocalPlayer = Players.LocalPlayer
local u41 = Color3.fromRGB(176, 38, 38)
local u46 = Color3.fromRGB(110, 20, 20)
local u51 = Color3.fromRGB(255, 255, 255)
local u56 = Color3.fromRGB(255, 214, 214)
local u57 = {
    {gui = "AboveTopStrip", child = "Stats"},
    {gui = "MenuBar", child = "Frame"},
    {gui = "Tutorial", child = "Frame"},
    {gui = "Objective", child = "TextLabel"},
    {gui = "ServerEvent", child = "Frame"},
}

local function clock(a1) -- Line: 40; types: a1: number
    local v1 = math.max(0, (math.floor(a1)))
    return string.format("%d:%02d", v1 // 60, v1 % 60)
end

local function escaped(a1) -- Line: 46; types: a1: string
    return (string.gsub(string.gsub(string.gsub(a1, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))
end

local function red(a1) -- Line: 50; upvalues: u41 (val), u51 (val), u33 (val), u46 (val); types: a1: userdata
    a1.AutoButtonColor = false
    a1.BackgroundColor3 = u41
    a1.BorderSizePixel = 0
    a1.TextColor3 = u51
    a1.FontFace = u33.Font.Bold

    u33.corner(a1, 8)
    u33.stroke(a1, u46, 1)
end

function v2.start()
    -- Line: 60
    -- upvalues: LocalPlayer (val), u41 (val), u51 (val), u33 (val), u46 (val), Remotes (val), u57 (val)
    -- upvalues: RunService (val), Workspace (val), u56 (val)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "RestartNotice"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 3
    ScreenGui.Parent = PlayerGui
    local TextButton = Instance.new("TextButton")
    TextButton.Name = "Banner"
    TextButton.AutoButtonColor = false
    TextButton.BackgroundColor3 = u41
    TextButton.BorderSizePixel = 0
    TextButton.TextColor3 = u51
    TextButton.FontFace = u33.Font.Bold

    u33.corner(TextButton, 8)
    u33.stroke(TextButton, u46, 1)

    TextButton.AnchorPoint = Vector2.new(0.5, 0)
    TextButton.Position = UDim2.new(0.5, 0, 0, 8)
    TextButton.Size = UDim2.new(1, -32, 0, u33.tap(28))
    TextButton.AutomaticSize = Enum.AutomaticSize.Y
    TextButton.RichText = true
    TextButton.TextWrapped = true
    TextButton.TextSize = 14
    TextButton.TextXAlignment = Enum.TextXAlignment.Center
    TextButton.Visible = false

    u33.asWritten(TextButton)

    local UISizeConstraint = Instance.new("UISizeConstraint")
    UISizeConstraint.MaxSize = Vector2.new(640, (1 / 0))
    UISizeConstraint.Parent = TextButton
    local UIPadding_2 = Instance.new("UIPadding")
    UIPadding_2.PaddingTop = UDim.new(0, 6)
    UIPadding_2.PaddingBottom = UDim.new(0, 6)
    UIPadding_2.PaddingLeft = UDim.new(0, 12)
    UIPadding_2.PaddingRight = UDim.new(0, 12)
    UIPadding_2.Parent = TextButton
    TextButton.Parent = ScreenGui
    local TextButton_2 = Instance.new("TextButton")
    TextButton_2.Name = "Timer"
    TextButton_2.AutoButtonColor = false
    TextButton_2.BackgroundColor3 = u41
    TextButton_2.BorderSizePixel = 0
    TextButton_2.TextColor3 = u51
    TextButton_2.FontFace = u33.Font.Bold

    u33.corner(TextButton_2, 8)
    u33.stroke(TextButton_2, u46, 1)

    TextButton_2.Size = UDim2.fromOffset(0, u33.tap(26))
    TextButton_2.AutomaticSize = Enum.AutomaticSize.X
    TextButton_2.TextSize = 13
    TextButton_2.Visible = false
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 10)
    UIPadding.PaddingRight = UDim.new(0, 10)
    UIPadding.Parent = TextButton_2
    TextButton_2.Parent = ScreenGui

    local function measurer()
        -- Line: 109
        -- upvalues: u33 (upval), TextButton_2 (val), UIPadding (val), ScreenGui (val)
        local TextLabel = Instance.new("TextLabel")
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextTransparency = 1
        TextLabel.FontFace = u33.Font.Bold
        TextLabel.TextSize = TextButton_2.TextSize
        TextLabel.Size = UDim2.fromOffset(0, u33.tap(26))
        TextLabel.AutomaticSize = Enum.AutomaticSize.X
        TextLabel.Position = UDim2.fromOffset(-2000, 0)
        UIPadding:Clone().Parent = TextLabel
        TextLabel.Parent = ScreenGui

        return TextLabel
    end

    local u133 = measurer()
    local u135 = measurer()
    local u136 = 0
    local u137 = ""
    local u138 = false
    local u139 = 0

    ;(Remotes.get(Remotes.RestartNotice)).OnClientEvent:Connect(function(a1)
        -- Line: 136
        -- upvalues: u136 (ref), u137 (ref), u138 (ref), u139 (ref)
        if type(a1) == "table"
            and type(a1.at) == "number"
            and type(a1.message) == "string" then
            u136 = a1.at
            u137 = string.gsub(string.gsub(string.gsub(a1.message, "&", "&amp;"), "<", "&lt;"), ">", "&gt;")
            u138 = true
            u139 = os.clock() + 6
        end
    end)

    TextButton_2.Activated:Connect(function() -- Line: 132; upvalues: u139 (ref)
        u139 = os.clock() + 6
    end)

    TextButton.Activated:Connect(function() -- Line: 146; upvalues: u139 (ref)
        u139 = 0
    end)

    local function boxesAcross(a1, a2)
        -- Line: 151
        -- upvalues: u57 (upval), PlayerGui (val)
        -- types: a1: number, a2: number
        local Y, v1
        local v2 = {}
        local v3 = u57
        local v4 = nil
        local v5 = nil
        local v6, v7 = a1, a2

        for i, j in v3, v4, v5 do
            v1 = PlayerGui:FindFirstChild(j.gui)

            if v1 and v1:IsA("ScreenGui") and v1.Enabled then
                for k, n in v1:GetChildren() do
                    if n:IsA("GuiObject") and n.Visible then
                        if n.Name == j.child then
                            if n.AbsolutePosition.X < v7
                                and v6 < n.AbsolutePosition.X + n.AbsoluteSize.X then
                                Y = n.AbsolutePosition.Y
                                table.insert(
                                    v2,
                                    {top = Y, bottom = Y + n.AbsoluteSize.Y}
                                )
                            end
                        elseif n.ClassName == j.child
                            and n.AbsolutePosition.X < v7
                            and v6 < n.AbsolutePosition.X + n.AbsoluteSize.X then
                            Y = n.AbsolutePosition.Y
                            table.insert(
                                v2,
                                {top = Y, bottom = Y + n.AbsoluteSize.Y}
                            )
                        end
                    end
                end
            end
        end

        return v2
    end

    local function clearOf(a1, a2, a3) -- Line: 174; types: a1: table, a2: number, a3: number
        local v1
        local v2 = a2
        local v3 = #a1 + 1

        for i = 1, v3 do
            v1 = false

            for j, k in a1 do
                if k.top < v2 + v4 and v2 < k.bottom then
                    v2 = k.bottom + 6
                    v1 = true
                end
            end

            if not v1 then
                break
            end
        end

        return v2
    end

    local function uiScale() -- Line: 194; upvalues: ScreenGui (val)
        local UIScale = ScreenGui:FindFirstChildOfClass("UIScale")

        if UIScale and 0 < UIScale.Scale then
            return UIScale.Scale
        end

        return 1
    end

    local function placePill(a1, a2)
        -- Line: 203
        -- upvalues: ScreenGui (val), PlayerGui (val), TextButton_2 (val), u133 (val), u135 (val), clearOf (val)
        -- upvalues: boxesAcross (val)
        -- types: a1: string, a2: string
        local UIScale = ScreenGui:FindFirstChildOfClass("UIScale")
        local Scale = if not UIScale then
            1
        else
            if not (0 < UIScale.Scale) then 1 else UIScale.Scale
        local AboveTopStrip = PlayerGui:FindFirstChild("AboveTopStrip")
        local Stats = AboveTopStrip and AboveTopStrip:FindFirstChild("Stats")
        local Y = TextButton_2.AbsoluteSize.Y

        if Stats and Stats.Visible then
            local v1
            local v2 = Stats.AbsolutePosition.Y + (Stats.AbsoluteSize.Y - Y) / 2

            for i, j in {
                {text = a1, width = u133.AbsoluteSize.X},
                {text = a2, width = u135.AbsoluteSize.X},
            } do
                v1 = Stats.AbsolutePosition.X - Scale * 6 - j.width

                if v1 > 0 and clearOf(boxesAcross(v1, v1 + j.width), v2, Y) == v2 then
                    TextButton_2.Text = j.text
                    TextButton_2.Position = UDim2.fromOffset(v1 / Scale, v2 / Scale)

                    return
                end
            end
        end

        TextButton_2.Text = a1
        local X = u133.AbsoluteSize.X
        local v3 = if not Stats or not Stats.Visible then
            ScreenGui.AbsoluteSize.X - X - Scale * 16
        else
            Stats.AbsolutePosition.X + Stats.AbsoluteSize.X - X
        TextButton_2.Position = UDim2.fromOffset(v3 / Scale, clearOf(boxesAcross(v3, v3 + X), Scale * 8, Y) / Scale)
    end

    RunService.Heartbeat:Connect(function()
        -- Line: 232
        -- upvalues: u138 (ref), u136 (ref), Workspace (upval), u139 (ref), TextButton (val), TextButton_2 (val)
        -- upvalues: u137 (ref), u56 (upval), ScreenGui (val), clearOf (val), boxesAcross (val), u133 (val), u135 (val)
        -- upvalues: placePill (val)
        local v1, v2, v3

        if not u138 then
            return
        end

        local v4 = u136 - Workspace:GetServerTimeNow()

        if not (v4 > 0) then
            v1 = "soon"
        else
            v2 = math.max(0, (math.floor(v4)))
            v1 = string.format("%d:%02d", v2 // 60, v2 % 60)
        end

        v4 = false

        if u139 > 0 then
            v4 = os.clock() < u139
        end

        if not v4 then
            u139 = 0
        end

        TextButton.Visible = v4
        TextButton_2.Visible = not v4

        if not v4 then
            v2 = ("RESTART %*"):format((string.upper(v1)))
            v3 = string.upper(v1)
            u133.Text = v2
            u135.Text = v3

            placePill(v2, v3)

            return
        end

        TextButton.Text = (("<b>SERVER RESTART IN %*</b>   %*\n"):format(string.upper(v1), u137))
            .. ("<font size=\"12\" color=\"#%*\">You'll move to the new server. Your progress is saved. Tap to hide.</font>"):format((u56:ToHex()))
        local UIScale = ScreenGui:FindFirstChildOfClass("UIScale")
        local Scale = if not UIScale then
            1
        else
            if not (0 < UIScale.Scale) then 1 else UIScale.Scale
        v3 = clearOf(boxesAcross(TextButton.AbsolutePosition.X, TextButton.AbsolutePosition.X + TextButton.AbsoluteSize.X), Scale * 8, TextButton.AbsoluteSize.Y)
            / Scale

        if TextButton.Position.Y.Offset == v3 then
            return
        end

        TextButton.Position = UDim2.new(0.5, 0, 0, v3)
    end)
end

return v2