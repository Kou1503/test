-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.CollectionController
-- Decompile time: 5.11 ms

local Players = game:GetService("Players")
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Remotes = require(Shared.Remotes)
local u23 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local ItemIcon = require(script.Parent.ItemIcon)
local ItemTooltip = require(script.Parent.ItemTooltip)
local u39 = {}
local LocalPlayer = Players.LocalPlayer
local u44 = Remotes.get(Remotes.RequestCollection)
local u47 = Remotes.get(Remotes.CollectionData)
local u48 = nil
local u49 = nil
local u50 = nil
local u51 = nil
local u52 = nil
local u53 = {}
local u54 = 0

function u39.isOpen() -- Line: 59; upvalues: u49 (ref)
    local Visible = false

    if u49 ~= nil then
        Visible = u49.Visible
    end

    return Visible
end

local function render()
    -- Line: 64
    -- upvalues: u52 (ref), u50 (ref), u53 (ref), u23 (val), ItemIcon (val), u51 (ref), u54 (ref)
    local Frame, TextLabel, TextLabel_2, v1, v2, v3, v4, v5, v6, v7
    u52.hide()

    for i, j in u50:GetChildren() do
        if j:IsA("Frame") or j:IsA("TextLabel") then
            j:Destroy()
        end
    end

    local v8 = 0
    local v9 = 0
    local v10 = 0
    local v11 = 0
    local v12 = nil
    local v13 = nil

    for k, n in u53, v12, v13 do
        TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, -12, 0, 24)
        TextLabel.Position = UDim2.fromOffset(6, v8)
        TextLabel.BackgroundTransparency = 1
        v1 = 0

        for m, i5 in n.pieces do
            if i5.submitted then
                v1 = v1 + 1
            end
        end

        TextLabel.Text = (("%*   %*/%*"):format(string.upper(n.title), v1, #n.pieces))
            .. (if not n.complete then "" else "   ✅ COMPLETE")
        v2 = if not n.complete then
            Color3.fromRGB(150, 158, 178)
        else
            Color3.fromRGB(140, 225, 175)
        TextLabel.TextColor3 = v2
        TextLabel.TextSize = 12
        TextLabel.FontFace = u23.Font.Bold
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.Parent = u50
        v8 = v8 + 26
        v3 = nil
        v4 = nil

        for i6, i7 in n.pieces, v3, v4 do
            v9 = v9 + 1
            v1 = true

            if not (0 < i7.found) then
                v1 = i7.submitted == true
            end

            if v1 then
                v10 = v10 + 1
            end

            if i7.submitted then
                v11 = v11 + 1
            end

            v7 = (i6 - 1) % 6
            v5 = (i6 - 1) // 6
            Frame = Instance.new("Frame")
            Frame.Size = UDim2.fromOffset(56, 56)
            Frame.Position = UDim2.fromOffset(v7 * 64 + 6, v8 + v5 * 78)
            Frame.BackgroundColor3 = Color3.fromRGB(30, 33, 41)
            Frame.BackgroundTransparency = if not v1 then 0.55 else 0
            Frame.BorderSizePixel = 0
            Frame.Parent = u50

            u23.corner(Frame, 6)

            if v1 then
                v7 = Instance.new("Frame")
                v7.AnchorPoint = Vector2.new(0.5, 0.5)
                v7.Position = UDim2.fromScale(0.5, 0.5)
                v7.Size = UDim2.fromOffset(46, 46)
                v7.BackgroundTransparency = 1
                v7.Parent = Frame

                ItemIcon.render(v7, i7.id, 46, 4)
                u52.attach(Frame, i7.id)

                v7 = Instance.new("TextLabel")
                v7.Size = UDim2.fromOffset(64, 14)
                v7.Position = UDim2.new(0.5, 0, 1, 1)
                v7.AnchorPoint = Vector2.new(0.5, 0)
                v7.BackgroundTransparency = 1
                v7.Text = string.match(tostring(i7.name or ""), "^(%S+)") or ""
                v6 = if not i7.submitted then
                    Color3.fromRGB(235, 240, 250)
                else
                    Color3.fromRGB(150, 158, 178)
                v7.TextColor3 = v6
                v7.TextSize = 11
                v7.FontFace = u23.Font.Bold
                v7.TextTruncate = Enum.TextTruncate.AtEnd
                v7.Parent = Frame

                if not i7.submitted then
                    u23.stroke(Frame, u23.Palette.Gold, 1.5)

                    if 1 < i7.found then
                        TextLabel_2 = Instance.new("TextLabel")
                        TextLabel_2.AnchorPoint = Vector2.new(1, 1)
                        TextLabel_2.Position = UDim2.new(1, -3, 1, -1)
                        TextLabel_2.Size = UDim2.fromOffset(28, 14)
                        TextLabel_2.BackgroundTransparency = 1
                        TextLabel_2.Text = ("×%*"):format(i7.found)
                        TextLabel_2.TextColor3 = u23.Palette.Gold
                        TextLabel_2.TextStrokeTransparency = 0.4
                        TextLabel_2.TextSize = 11
                        TextLabel_2.FontFace = u23.Font.Bold
                        TextLabel_2.TextXAlignment = Enum.TextXAlignment.Right
                        TextLabel_2.ZIndex = 3
                        TextLabel_2.Parent = Frame
                    end
                else
                    v7 = Instance.new("Frame")
                    v7.Size = UDim2.fromScale(1, 1)
                    v7.BackgroundColor3 = Color3.fromRGB(10, 12, 16)
                    v7.BackgroundTransparency = 0.6
                    v7.BorderSizePixel = 0
                    v7.ZIndex = 3
                    v7.Parent = Frame

                    u23.corner(v7, 6)

                    v7 = Instance.new("TextLabel")
                    v7.AnchorPoint = Vector2.new(1, 0)
                    v7.Position = UDim2.new(1, -2, 0, 2)
                    v7.Size = UDim2.fromOffset(18, 18)
                    v7.BackgroundTransparency = 1
                    v7.Text = "✅"
                    v7.TextSize = 15
                    v7.ZIndex = 4
                    v7.Parent = Frame
                end
            else
                v5 = Instance.new("TextLabel")
                v5.Size = UDim2.fromScale(1, 1)
                v5.BackgroundTransparency = 1
                v5.Text = "???"
                v5.TextColor3 = Color3.fromRGB(110, 117, 136)
                v5.TextSize = 14
                v5.FontFace = u23.Font.Bold
                v5.Parent = Frame
            end
        end

        v8 = v8 + (math.max(1, (math.ceil(#n.pieces / 6))) * 78 + 8)
    end

    u50.CanvasSize = UDim2.fromOffset(0, v8)
    u51.Text = (("%*/%* handed in · %* kinds found · %* total finds"):format(v11, v9, v10, u54))
        .. "\nTake Shinies to the Collector at the Hub to complete a set."
end

local u57 = nil

function u39.close() -- Line: 213; upvalues: u49 (ref), u52 (ref), BuildController (val), u57 (ref)
    local Visible = false

    if u49 ~= nil then
        Visible = u49.Visible
    end

    if not Visible then
        return
    end

    u52.hide()

    u49.Visible = false
    BuildController.setUiOpen("Collection", false)

    local v1 = u57
    u57 = nil

    if v1 then
        v1()
    end
end

function u39.open(a1)
    -- Line: 228
    -- upvalues: u57 (ref), u49 (ref), u23 (val), BuildController (val), u44 (val), render (val)
    -- types: a1: function?
    u57 = a1
    u49.Visible = true

    u23.appear(u49)
    BuildController.setUiOpen("Collection", true)
    u44:FireServer()
    render()
end

function u39.toggle() -- Line: 239; upvalues: u49 (ref), u39 (val)
    local Visible = false

    if u49 ~= nil then
        Visible = u49.Visible
    end

    if Visible then
        u39.close()
        return
    end

    u39.open()
end

function u39.start()
    -- Line: 247
    -- upvalues: BuildController (val), u39 (val), u48 (ref), LocalPlayer (val), u49 (ref), u23 (val), u51 (ref)
    -- upvalues: u50 (ref), u52 (ref), ItemTooltip (val), u47 (val), u53 (ref), u54 (ref), render (val)
    BuildController.registerMenu("Collection", u39.close)

    u48 = Instance.new("ScreenGui")
    u48.Name = "Collection"
    u48.ResetOnSpawn = false
    u48.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u49 = Instance.new("Frame")
    u49.Size = UDim2.fromOffset(420, 460)
    u49.Position = UDim2.new(0.5, -210, 0.5, -230)

    u23.fitToScreen(u49)

    u49.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    u49.BackgroundTransparency = 0.05
    u49.BorderSizePixel = 0
    u49.Visible = false
    u49.Active = true
    u49.Parent = u48

    u23.closeButton(u49, 10, u39.close)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = u49
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(58, 62, 78)
    UIStroke.Parent = u49
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -24, 0, 28)
    TextLabel.Position = UDim2.fromOffset(14, 10)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "COLLECTIONS"
    TextLabel.TextColor3 = Color3.fromRGB(238, 240, 248)
    TextLabel.TextSize = 17
    TextLabel.FontFace = u23.Font.Bold
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = u49
    u51 = Instance.new("TextLabel")
    u51.Size = UDim2.new(1, -28, 0, 32)
    u51.Position = UDim2.fromOffset(14, 36)
    u51.BackgroundTransparency = 1
    u51.Text = ""
    u51.TextColor3 = Color3.fromRGB(126, 133, 152)
    u51.TextSize = 11
    u51.FontFace = u23.Font.Regular
    u51.TextXAlignment = Enum.TextXAlignment.Left
    u51.TextYAlignment = Enum.TextYAlignment.Top
    u51.Parent = u49
    u50 = Instance.new("ScrollingFrame")
    u50.Size = UDim2.new(1, -20, 1, -84)
    u50.Position = UDim2.fromOffset(10, 74)
    u50.BackgroundTransparency = 1
    u50.BorderSizePixel = 0
    u50.ScrollBarThickness = 5
    u50.CanvasSize = UDim2.fromOffset(0, 0)
    u50.Parent = u49
    u52 = ItemTooltip.new(u49)

    u52.hideOnScroll(u50)

    u47.OnClientEvent:Connect(function(a1)
        -- Line: 316
        -- upvalues: u53 (upval), u54 (upval), u49 (upval), render (upval)
        if type(a1) ~= "table" then
            return
        end

        u53 = a1.families or {}
        u54 = a1.distinctFinds or 0
        local Visible = false

        if u49 ~= nil then
            Visible = u49.Visible
        end

        if Visible then
            render()
        end
    end)
end

return u39