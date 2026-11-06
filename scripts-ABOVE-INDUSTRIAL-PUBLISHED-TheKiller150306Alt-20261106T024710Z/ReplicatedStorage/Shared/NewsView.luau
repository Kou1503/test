-- Script path: game:GetService("ReplicatedStorage").Shared.NewsView
-- Decompile time: 1.17 ms

local NewsFormat = require(script.Parent.NewsFormat)
local v1 = {}

local function label(a1, a2, a3, a4, a5, a6)
    -- Line: 20
    -- types: a1: userdata, a2: number, a3: string, a4: userdata, a5: number, a6: userdata
    local TextLabel = Instance.new("TextLabel")
    TextLabel.LayoutOrder = a2
    TextLabel.Size = UDim2.fromScale(1, 0)
    TextLabel.AutomaticSize = Enum.AutomaticSize.Y
    TextLabel.BackgroundTransparency = 1
    TextLabel.RichText = true
    TextLabel.TextWrapped = true
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.TextYAlignment = Enum.TextYAlignment.Top
    TextLabel.FontFace = a4
    TextLabel.TextSize = a5
    TextLabel.TextColor3 = a6
    TextLabel.AutoLocalize = false
    TextLabel.Text = a3
    TextLabel.Parent = a1

    return TextLabel
end

function v1.render(a1, a2, a3, a4)
    -- Line: 41
    -- upvalues: label (val), NewsFormat (val)
    -- types: a1: userdata, a3: table, a4: number
    local ImageLabel, UIAspectRatioConstraint, v1
    local Frame = Instance.new("Frame")
    Frame.Name = "Post"
    Frame.LayoutOrder = a4
    Frame.Size = UDim2.fromScale(1, 0)
    Frame.AutomaticSize = Enum.AutomaticSize.Y
    Frame.BackgroundTransparency = 1
    Frame.Parent = a1
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.Parent = Frame

    label(Frame, 1, NewsFormat.title(a2.title), a3.bold, math.floor(a3.textSize * 1.35 + 0.5), a3.text)

    if a2.date ~= "" then
        label(Frame, 2, NewsFormat.title(a2.date), a3.regular, math.floor(a3.textSize * 0.85 + 0.5), a3.dim)
    end

    for i, j in NewsFormat.blocks(a2.body, a3.textSize) do
        if j.kind ~= "Image" then
            label(Frame, 2 + i, j.text, a3.regular, a3.textSize, a3.text)
        else
            v1 = Instance.new("Frame")
            v1.LayoutOrder = 2 + i
            v1.Size = UDim2.new(1, 0, 0, 4000)
            v1.BackgroundTransparency = 1
            v1.Parent = Frame
            UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
            UIAspectRatioConstraint.AspectRatio = 1.7777777777777777
            UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Width
            UIAspectRatioConstraint.Parent = v1
            ImageLabel = Instance.new("ImageLabel")
            ImageLabel.Size = UDim2.fromScale(1, 1)
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.ScaleType = Enum.ScaleType.Fit
            ImageLabel.Image = ("rbxassetid://%*"):format(j.id)
            ImageLabel.Parent = v1
        end
    end

    return Frame
end

return v1