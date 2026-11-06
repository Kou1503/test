-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.ItemTooltip
-- Decompile time: 2.80 ms

local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local ItemStats = require(Shared.ItemStats)
local Palette = require(Shared.Palette)
local u24 = require(script.Parent.Parent.Ui)

return {
    new = function(a1, a2)
        -- Line: 41
        -- upvalues: u24 (val), Config (val), ItemStats (val), Palette (val)
        -- types: a1: userdata, a2: table?
        local u5 = false

        if a2 ~= nil then
            u5 = a2.unmade == true
        end

        local Frame = Instance.new("Frame")
        Frame.Name = "Tooltip"
        Frame.Size = UDim2.fromOffset(270, 0)
        Frame.AutomaticSize = Enum.AutomaticSize.Y
        Frame.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
        Frame.BackgroundTransparency = 0.05
        Frame.BorderSizePixel = 0
        Frame.Active = false
        Frame.Visible = false
        Frame.ZIndex = 20
        Frame.Parent = a1

        u24.corner(Frame, 6)
        u24.stroke(Frame, Color3.fromRGB(64, 70, 88), 1)

        local UIPadding = Instance.new("UIPadding")
        UIPadding.PaddingTop = UDim.new(0, 8)
        UIPadding.PaddingBottom = UDim.new(0, 8)
        UIPadding.PaddingLeft = UDim.new(0, 10)
        UIPadding.PaddingRight = UDim.new(0, 10)
        UIPadding.Parent = Frame
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 4)
        UIListLayout.Parent = Frame
        local TextLabel = Instance.new("TextLabel")
        TextLabel.LayoutOrder = 1
        TextLabel.Size = UDim2.fromScale(1, 0)
        TextLabel.AutomaticSize = Enum.AutomaticSize.Y
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextColor3 = u24.Palette.Gold
        TextLabel.RichText = true
        TextLabel.FontFace = u24.Font.Bold
        TextLabel.TextSize = 13
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.ZIndex = 21
        TextLabel.Parent = Frame
        local TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.LayoutOrder = 2
        TextLabel_2.Size = UDim2.fromScale(1, 0)
        TextLabel_2.AutomaticSize = Enum.AutomaticSize.Y
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.TextColor3 = Color3.fromRGB(196, 203, 220)
        TextLabel_2.FontFace = u24.Font.Regular
        TextLabel_2.TextSize = 12
        TextLabel_2.TextWrapped = true
        TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel_2.TextYAlignment = Enum.TextYAlignment.Top
        TextLabel_2.ZIndex = 21
        TextLabel_2.Parent = Frame
        local u111 = nil

        local function hide() -- Line: 98; upvalues: u111 (ref), Frame (val)
            u111 = nil
            Frame.Visible = false
        end

        local function show(a1_2, a2)
            -- Line: 103
            -- upvalues: Config (upval), ItemStats (upval), u5 (val), u111 (ref), Frame (val), u24 (upval)
            -- upvalues: TextLabel (val), Palette (upval), TextLabel_2 (val), a1 (val)
            -- types: a1_2: string, a2: userdata
            local v1, v2
            local v3 = Config.Description.of(a1_2)
            local v4 = ""
            local v5 = ItemStats.of(Config, a1_2, nil)

            if not u5 then
                v1 = nil
                v2 = nil

                for i, j in v5, v1, v2 do
                    v4 = v4
                        .. ("%*%*  %*"):format(if v4 ~= "" then "     " else "", j.label, j.value)
                end
            elseif not Config.Recipe.isUnique(a1_2) then
                v1 = nil
                v2 = nil

                for k, n in v5, v1, v2 do
                    v4 = v4
                        .. ("%*%*  %*"):format(if v4 ~= "" then "     " else "", n.label, n.value)
                end
            end

            if v3 == "" and v4 == "" then
                u111 = nil
                Frame.Visible = false

                return
            end

            v5 = if not Config.Recipe.isUnique(a1_2) then
                ""
            else
                ("  <font color=\"#%*\">UNIQUE</font>"):format((u24.Palette.Unique:ToHex()))
            TextLabel.Text = ("%*%*"):format(Palette.displayName(a1_2), v5)
            TextLabel_2.Text = if v4 ~= "" then
                if v3 ~= "" then v3 .. "\n\n" .. v4 else v4
            else
                v3
            v5 = a1.AbsoluteSize.Y / math.max(a1.Size.Y.Offset, 1)
            v4 = (a2.AbsolutePosition.X - a1.AbsolutePosition.X) / v5
            v3 = (a2.AbsolutePosition.Y - a1.AbsolutePosition.Y) / v5
            local v6 = v3 + a2.AbsoluteSize.Y / v5
            Frame.AnchorPoint = Vector2.new(0, if not (v3 < a1.Size.Y.Offset / 2) then 1 else 0)
            Frame.Position = UDim2.fromOffset(math.clamp(v4 + 50, 8, (math.max(8, a1.Size.X.Offset - 270 - 8))), if not v5 then v3 - 4 else v6 + 4)
            u111 = a2
            Frame.Visible = true
        end

        return {
            show = show,
            hide = hide,
            attach = function(a1_2, a2)
                -- Line: 142
                -- upvalues: show (val), u111 (ref), Frame (val), a1 (val)
                -- types: a1_2: userdata, a2: string
                a1_2.MouseEnter:Connect(function() -- Line: 143; upvalues: show (upval), a2 (val), a1_2 (val)
                    show(a2, a1_2)
                end)

                a1_2.MouseLeave:Connect(function() -- Line: 146; upvalues: u111 (upval), a1_2 (val), Frame (upval)
                    if u111 == a1_2 then
                        u111 = nil
                        Frame.Visible = false
                    end
                end)

                ;(a1_2:GetPropertyChangedSignal("Visible")):Connect(function()
                    -- Line: 152
                    -- upvalues: u111 (upval), a1_2 (val), Frame (upval)
                    if u111 == a1_2 and not a1_2.Visible then
                        u111 = nil
                        Frame.Visible = false
                    end
                end)

                a1_2.AncestryChanged:Connect(function()
                    -- Line: 157
                    -- upvalues: u111 (upval), a1_2 (val), a1 (upval), Frame (upval)
                    if u111 == a1_2 and not a1_2:IsDescendantOf(a1) then
                        u111 = nil
                        Frame.Visible = false
                    end
                end)
            end,
            hideOnScroll = function(a1) -- Line: 164; upvalues: hide (val); types: a1: userdata
                (a1:GetPropertyChangedSignal("CanvasPosition")):Connect(hide)
            end,
        }
    end,
}