-- Script path: game:GetService("StarterPlayer").StarterPlayerScripts.Client.CopyPicker
-- Decompile time: 3.55 ms

local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local Palette = require(Shared.Palette)
local ItemStats = require(Shared.ItemStats)
local Remotes = require(Shared.Remotes)
local u26 = require(script.Parent.Ui)
local u27 = {}
local u30 = Remotes.get(Remotes.RequestItemCopies)
local u31 = nil
local u32 = nil

function u27.close() -- Line: 30; upvalues: u31 (ref), u32 (ref)
    if u31 then
        u31:Destroy()
    end

    u31 = nil
    u32 = nil
end

local function statsText(a1, a2) -- Line: 38; upvalues: Config (val), ItemStats (val); types: a1: string, a2: table
    local v1 = Config.Tool.Tools[a1] or Config.Weapon.Weapons[a1]
    local v2 = false

    if v1 ~= nil then
        v2 = Config.Tool.UnrolledTiers[v1.tier or ""] == true
    end

    v1 = {}

    for i, j in ItemStats.of(Config, a1, if not v2 then a2 else nil) do
        table.insert(v1, (("%* %*"):format(j.label, j.value)))
    end

    if #v1 > 0 then
        return (table.concat(v1, "   "))
    end

    return "No stats"
end

local function show(a1, a2)
    -- Line: 49
    -- upvalues: u31 (ref), Palette (val), u26 (val), u27 (val), statsText (val)
    -- types: a1: table, a2: table
    local Frame, TextButton_2, TextLabel_3, TextLabel_4
    local itemId = a1.itemId
    local TextButton = Instance.new("TextButton")
    TextButton.Name = "CopyPicker"
    TextButton.Text = ""
    TextButton.AutoButtonColor = false
    TextButton.Size = UDim2.fromScale(1, 1)
    TextButton.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    TextButton.BorderSizePixel = 0
    TextButton.Parent = a1.over
    u31 = TextButton
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -60, 0, 24)
    TextLabel.Position = UDim2.fromOffset(12, 8)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = ("Which %*?"):format((Palette.displayName(itemId)))
    TextLabel.TextColor3 = Color3.fromRGB(255, 226, 130)
    TextLabel.FontFace = u26.Font.Bold
    TextLabel.TextSize = 17
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = TextButton

    u26.closeButton(TextButton, 8, u27.close)

    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, -16, 1, -46)
    ScrollingFrame.Position = UDim2.fromOffset(8, 38)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.ScrollBarThickness = 5
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollingFrame.CanvasSize = UDim2.new()
    ScrollingFrame.Parent = TextButton
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 4)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = ScrollingFrame

    if #a2 == 0 then
        local TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Size = UDim2.new(1, 0, 0, 24)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.Text = "You aren't carrying one."
        TextLabel_2.TextColor3 = Color3.fromRGB(150, 162, 180)
        TextLabel_2.FontFace = u26.Font.Regular
        TextLabel_2.TextSize = 14
        TextLabel_2.Parent = ScrollingFrame
    end

    local v1 = u26.tap(44)

    for i, j in a2 do
        Frame = Instance.new("Frame")
        Frame.LayoutOrder = i
        Frame.Size = UDim2.new(1, -8, 0, v1)
        Frame.BackgroundColor3 = Color3.fromRGB(32, 36, 46)
        Frame.BorderSizePixel = 0
        Frame.Parent = ScrollingFrame

        u26.corner(Frame, 6)

        TextLabel_3 = Instance.new("TextLabel")
        TextLabel_3.Size = UDim2.new(1, -120, 0, 18)
        TextLabel_3.Position = UDim2.fromOffset(10, 4)
        TextLabel_3.BackgroundTransparency = 1
        TextLabel_3.RichText = true
        TextLabel_3.Text = ("#%*  <font color=\"#FFE282\">%*</font>"):format(j.n, j.outcome)
        TextLabel_3.TextColor3 = Color3.fromRGB(238, 240, 248)
        TextLabel_3.FontFace = u26.Font.Bold
        TextLabel_3.TextSize = 14
        TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel_3.Parent = Frame
        TextLabel_4 = Instance.new("TextLabel")
        TextLabel_4.Size = UDim2.new(1, -120, 0, 16)
        TextLabel_4.Position = UDim2.new(0, 10, 1, -20)
        TextLabel_4.BackgroundTransparency = 1
        TextLabel_4.Text = statsText(itemId, j.stats)
        TextLabel_4.TextColor3 = Color3.fromRGB(150, 162, 180)
        TextLabel_4.FontFace = u26.Font.Regular
        TextLabel_4.TextSize = 12
        TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel_4.TextTruncate = Enum.TextTruncate.AtEnd
        TextLabel_4.Parent = Frame
        TextButton_2 = Instance.new("TextButton")
        TextButton_2.Size = UDim2.fromOffset(100, v1 - 10)
        TextButton_2.AnchorPoint = Vector2.new(1, 0.5)
        TextButton_2.Position = UDim2.new(1, -6, 0.5, 0)
        TextButton_2.BorderSizePixel = 0
        TextButton_2.FontFace = u26.Font.Bold
        TextButton_2.TextSize = 14
        TextButton_2.Parent = Frame

        u26.corner(TextButton_2, 6)

        if not j.bound then
            TextButton_2.Text = a1.action
            TextButton_2.BackgroundColor3 = a1.color
            TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)

            TextButton_2.Activated:Connect(function() -- Line: 153; upvalues: a1 (val), u27 (upval), j (val)
                local onPick = a1.onPick
                u27.close()
                onPick(j.n)
            end)
        else
            TextButton_2.Text = "Soulbound"
            TextButton_2.AutoButtonColor = false
            TextButton_2.BackgroundColor3 = Color3.fromRGB(52, 56, 70)
            TextButton_2.TextColor3 = Color3.fromRGB(150, 162, 180)
        end
    end

    TextButton.ZIndex = 50

    for k, n2 in TextButton:GetDescendants() do
        if n2:IsA("GuiObject") then
            n2.ZIndex = 50 + n2.ZIndex
        end
    end
end

function u27.ask(a1, a2, a3, a4, a5)
    -- Line: 172
    -- upvalues: u27 (val), u32 (ref), u30 (val)
    -- types: a1: string, a2: userdata, a3: string, a4: userdata, a5: function
    u27.close()

    u32 = {
        itemId = a1,
        over = a2,
        action = a3,
        color = a4,
        onPick = a5,
    }
    u30:FireServer(a1)
end

function u27.isOpen() -- Line: 178; upvalues: u31 (ref)
    return u31 ~= nil
end

;(Remotes.get(Remotes.ItemCopies)).OnClientEvent:Connect(function(a1, a2)
    -- Line: 183
    -- upvalues: u32 (ref), u31 (ref), show (val)
    local v1 = u32

    if v1 and a1 == v1.itemId and type(a2) == "table" then
        if v1.over.Parent and v1.over.Visible then
            if u31 then
                u31:Destroy()
            end

            show(v1, a2)

            return
        end

        u32 = nil
    end
end)

return u27