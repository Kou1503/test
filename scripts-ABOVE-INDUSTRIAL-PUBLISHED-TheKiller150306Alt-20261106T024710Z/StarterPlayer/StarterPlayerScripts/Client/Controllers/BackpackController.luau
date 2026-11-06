-- Script path: game:GetService("StarterPlayer").StarterPlayerScripts.Client.Controllers.BackpackController
-- Decompile time: 77.41 ms

local rebuildEquipment
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local u21 = require(script.Parent.DeviceMode).touchOnly()
local v1 = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(v1.Config)
local ItemKinds = require(v1.ItemKinds)
local ItemStats = require(v1.ItemStats)
local Palette = require(v1.Palette)
local Remotes = require(v1.Remotes)
local StackKey = require(v1.StackKey)
local u56 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local PanelTabs = require(script.Parent.PanelTabs)
local HotbarController = require(script.Parent.HotbarController)
local NewBadges = require(script.Parent.NewBadges)
local ItemIcon = require(script.Parent.ItemIcon)
local u87 = {}
local LocalPlayer = Players.LocalPlayer
local u92 = Remotes.get(Remotes.InventoryChanged)
local u93 = {}
local u94 = {}
local QualityColors = ItemStats.QualityColors
local u98 = Remotes.get(Remotes.EquipmentChanged)
local u101 = Remotes.get(Remotes.RequestSetEquipment)
local u104 = Remotes.get(Remotes.RequestWear)
local u107 = Remotes.get(Remotes.WearablesChanged)
local u110 = Remotes.get(Remotes.RequestSetBackpackLayout)
local u113 = Remotes.get(Remotes.BackpackLayoutChanged)
local u115 = if not u21 then 62 else 50
local u118 = if not u21 then 32 else 26
local u121 = if not u21 then 10 else 7
local u125 = u115 + 34
local u126 = {"Weapon", "Pickaxe", "Axe"}
local Categories = ItemKinds.Categories
local u139 = ItemKinds.build(Config)
local u140 = {}
local u141 = {}

local function isEquipment(a1) -- Line: 105; upvalues: StackKey (val), u139 (val), Config (val); types: a1: string
    local v1 = StackKey.item(a1)
    local v2 = true

    if u139.equipSlotOf(v1) == nil then
        v2 = Config.Wearable.slotOf(v1) ~= nil
    end

    return v2
end

local u146 = {Collectibles = "SHINIES"}

local function categoryOf(a1) -- Line: 123; upvalues: u139 (val), StackKey (val); types: a1: string
    return u139.categoryOf(StackKey.item(a1)) or "Items"
end

local u148 = nil
local u149 = nil
local u150 = nil
local u151 = nil
local u152 = nil
local u153 = nil
local u154 = nil

local function tooltipHeight() -- Line: 157; upvalues: u149 (ref), u152 (ref)
    return (math.max(86, (math.ceil(u152.TextBounds.Y / (u149.AbsoluteSize.Y / math.max(u149.Size.Y.Offset, 1)))) + 26 + 10))
end

local function placeTooltip() -- Line: 169; upvalues: u154 (ref), u150 (ref), u149 (ref), u152 (ref), u115 (val)
    local v1 = u154

    if v1 and u150 then
        local v2 = u149.AbsoluteSize.Y / math.max(u149.Size.Y.Offset, 1)
        local v3 = math.max(86, (math.ceil(u152.TextBounds.Y / v2)) + 26 + 10)
        v2 = u149.AbsoluteSize.Y / math.max(u149.Size.Y.Offset, 1)
        local v4 = Vector2.new(u149.Size.X.Offset, u149.Size.Y.Offset)
        local v5 = (v1.AbsolutePosition.X - u149.AbsolutePosition.X) / v2
        local v6 = (v1.AbsolutePosition.Y - u149.AbsolutePosition.Y) / v2
        v2 = v6 + u115 + 6
        v1 = v2 + v3 <= v4.Y
        u150.Size = UDim2.fromOffset(260, v3)
        u150.Position = UDim2.fromOffset(math.clamp(v5 - 40, 8, (math.max(8, v4.X - 268))), if not v1 then math.max(8, v6 - v3 - 6) else v2)
    end
end

local function showTooltip(a1, a2, a3)
    -- Line: 193
    -- upvalues: u140 (ref), StackKey (val), u153 (ref), Config (val), ItemStats (val), u93 (ref), u94 (ref)
    -- upvalues: QualityColors (val), u56 (val), u151 (ref), Palette (val), u152 (ref), u154 (ref), placeTooltip (val)
    -- upvalues: u150 (ref)
    -- types: a1: string?, a2: userdata, a3: table?
    local v1, v2
    local v3 = if not a1 then nil else u140[a1]
    local v4 = if not a1 then a1 else StackKey.item(a1)
    local v5 = if not v3 or a3 then
        a3
    else
        {
            n = 0,
            itemId = v4,
            outcome = v3.outcome,
            perfect = v3.perfect,
            stats = v3.stats,
        }

    if not v4 then
        u153()
        return
    end

    v3 = Config.Description.of(v4)
    local v6 = Config.Tool.Tools[v4] or Config.Weapon.Weapons[v4]
    local v7 = false

    if v6 ~= nil then
        v7 = Config.Tool.UnrolledTiers[v6.tier or ""] == true
    end

    local of = ItemStats.of
    local stats = if not v7 then if not v5 then u93[v4] else v5.stats else nil
    v7 = ""
    local v8 = of(Config, v4, stats)
    local v9 = nil
    local v10 = nil

    for i, j in v8, v9, v10 do
        v2 = ("%*  %*"):format(j.label, (ItemStats.paint(j)))
        v7 = v7 .. ("%*%*"):format(if v7 ~= "" then "     " else "", v2)
    end

    if v3 == "" and v7 == "" then
        u153()
        return
    end

    v6 = if not v5 then u94[v4] else {[v5.outcome] = 1}
    v8 = ""
    v9 = 0
    local v11 = nil
    local v12 = nil

    for k in v6 or {}, v11, v12 do
        v9 = v9 + 1
    end

    if v6 then
        local Standard

        if v9 ~= 1 then
            v11 = nil
            v12 = nil

            for n, m in Config.Quality.Outcomes, v11, v12 do
                if v6[m] then
                    Standard = QualityColors[m] or QualityColors.Standard
                    v8 = v8
                        .. ("%*<font color=\"%*\">%*</font>"):format(if v8 ~= "" then " · " else "  ", Standard, m)
                end
            end
        elseif not v6.Standard then
            v11 = nil
            v12 = nil

            for i5, i6 in Config.Quality.Outcomes, v11, v12 do
                if v6[i6] then
                    Standard = QualityColors[i6] or QualityColors.Standard
                    v8 = v8
                        .. ("%*<font color=\"%*\">%*</font>"):format(if v8 ~= "" then " · " else "  ", Standard, i6)
                end
            end
        end
    end

    v6 = if not Config.Recipe.isUnique(v4) or v5 ~= nil then
        ""
    else
        ("  <font color=\"#%*\">UNIQUE</font>"):format((u56.Palette.Unique:ToHex()))
    u151.Text = ("%*%*%*"):format(Palette.displayName(v4), v6, v8)
    u152.Text = if v7 ~= "" then if v3 ~= "" then v3 .. "\n\n" .. v7 else v7 else v3
    u154 = v1

    placeTooltip()

    u150.Visible = true
end

function u153() -- Line: 285; upvalues: u150 (ref)
    if u150 then
        u150.Visible = false
    end
end

local u177 = nil
local u178 = nil
local u179 = {}
local u180 = nil
local rebuildTabs = nil
local u182 = nil
local u183 = nil
local u184 = nil
local u185 = {}
local u186 = {}
local u187 = {}
local u188 = {}
local u189 = false
local u190 = false
local u191 = {}
local u192 = {}
local u193 = {}
local u194 = {}
local u195 = {}
local u196 = "All"
local u197 = ""
local u198 = nil
local u199 = {}
local u200 = {}
local u201 = nil
local u202 = nil

local function u203() -- Line: 357
end

local u204 = nil
local u205 = nil
local u206 = nil
local u207 = nil
local u208 = nil

local function u209() -- Line: 370
end

local u210 = nil
local u211 = nil

local function haystack(a1)
    -- Line: 377
    -- upvalues: StackKey (val), u140 (ref), Palette (val), u139 (val)
    -- types: a1: string
    local v1 = StackKey.item(a1)
    local v2 = u140[a1]

    return string.lower((("%* %* %* %*"):format(Palette.displayName(v1), v1, u139.categoryOf(StackKey.item(v1)) or "Items", if not v2 then "" else v2.outcome)))
end

local u213 = nil

local function inActiveCategory(a1)
    -- Line: 394
    -- upvalues: u213 (ref), u139 (val), StackKey (val)
    -- types: a1: string
    local v1 = true

    if u213 ~= nil then
        v1 = (u139.categoryOf(StackKey.item(a1)) or "Items") == u213
    end

    return v1
end

local function arranged() -- Line: 399; upvalues: u213 (ref), u197 (ref)
    local v1 = false

    if u213 == nil then
        v1 = u197 == ""
    end

    return v1
end

local function matchesQuery(a1)
    -- Line: 403
    -- upvalues: u197 (ref), StackKey (val), u140 (ref), Palette (val), u139 (val)
    -- types: a1: string
    if u197 == "" then
        return true
    end

    local v1 = StackKey.item(a1)
    local v2 = u140[a1]
    local outcome = if not v2 then "" else v2.outcome
    local v3 = string.lower((("%* %* %* %*"):format(Palette.displayName(v1), v1, u139.categoryOf(StackKey.item(v1)) or "Items", outcome)))

    for i in string.gmatch(u197, "%S+") do
        if not string.find(v3, i, 1, true) then
            return false
        end
    end

    return true
end

local function buildSlot(a1, a2, a3, a4, a5)
    -- Line: 420
    -- upvalues: StackKey (val), u115 (val), NewBadges (val), u56 (val), u118 (val), u121 (val), ItemIcon (val)
    -- upvalues: u140 (ref), u141 (val), Config (val), QualityColors (val), Palette (val), u21 (val)
    -- types: a1: userdata, a2: string, a3: number, a4: number, a5: boolean
    local v1 = a2
    local v2 = StackKey.item(v1)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromOffset(u115, u115)
    local v3 = NewBadges.isNewItem(v2)
    local New = if not v3 then Color3.fromRGB(30, 34, 42) else u56.Palette.New
    Frame.BackgroundColor3 = New

    if v3 then
        u56.newDot(Frame)
    end

    Frame.BackgroundTransparency = 0.15
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = a4
    Frame.Active = true
    Frame.Parent = a1
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Frame
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = if not a5 then 2 else 3
    local Green = if not a5 then Color3.fromRGB(16, 18, 24) else u56.Palette.Green
    UIStroke.Color = Green
    UIStroke.Parent = Frame
    local Frame_2 = Instance.new("Frame")
    Frame_2.Size = UDim2.fromOffset(u118, u118)
    Frame_2.Position = UDim2.new(0.5, -u118 / 2, 0, u121)
    Frame_2.BackgroundTransparency = 1
    Frame_2.Parent = Frame

    ItemIcon.render(Frame_2, v2, u118, 4)

    if a3 >= 0 then
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "Count"
        TextLabel.Size = UDim2.fromOffset(u115 - 8, 14)
        TextLabel.Position = UDim2.fromOffset(4, 3)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = ("x%*"):format(a3)
        TextLabel.TextColor3 = u56.Palette.Gold
        TextLabel.FontFace = u56.Font.Bold
        TextLabel.TextSize = 13
        TextLabel.TextXAlignment = Enum.TextXAlignment.Right
        TextLabel.Parent = Frame
    end

    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.Size = UDim2.new(1, -6, 0, 22)
    TextLabel_2.Position = UDim2.new(0, 3, 1, -24)
    TextLabel_2.BackgroundTransparency = 1
    local v4 = u140[v1] or u141[v1]
    local outcome = if v4 ~= nil then
        if v4.outcome ~= "Standard" then v4.outcome else nil
    else
        "UNIQUE"

    if Config.Recipe.isUnique(v2) and outcome then
        local TextLabel_3 = Instance.new("TextLabel")
        TextLabel_3.Name = "UniqueTag"
        TextLabel_3.Size = UDim2.fromOffset(u115 - 8, 12)
        TextLabel_3.Position = UDim2.fromOffset(4, 3)
        TextLabel_3.BackgroundTransparency = 1
        TextLabel_3.Text = string.upper(outcome)
        local Unique = if not v4 then
            u56.Palette.Unique
        else
            if not QualityColors[v4.outcome] then
                u56.Palette.Unique
            else
                Color3.fromHex(QualityColors[v4.outcome])
        TextLabel_3.TextColor3 = Unique
        TextLabel_3.FontFace = u56.Font.Bold
        TextLabel_3.TextScaled = true
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
        UITextSizeConstraint.MaxTextSize = 8
        UITextSizeConstraint.Parent = TextLabel_3
        TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel_3.Parent = Frame

        if v4 then
            local Count = Frame:FindFirstChild("Count")

            if Count then
                Count.Position = UDim2.fromOffset(4, 14)
                Count.TextSize = 12
            end
        end
    end

    TextLabel_2.Text = Palette.displayName(v2)
    TextLabel_2.TextColor3 = Color3.fromRGB(210, 215, 228)
    TextLabel_2.TextSize = 10
    TextLabel_2.FontFace = u56.Font.Regular
    TextLabel_2.TextWrapped = true
    TextLabel_2.TextTruncate = Enum.TextTruncate.AtEnd

    if u21 then
        TextLabel_2.Size = UDim2.new(1, -4, 0, 12)
        TextLabel_2.Position = UDim2.new(0, 2, 1, -13)
        TextLabel_2.TextSize = 9
        TextLabel_2.TextWrapped = false
    end

    TextLabel_2.Parent = Frame

    return Frame
end

local u228 = {}
local u233 = Color3.fromRGB(38, 43, 54)
local Green = u56.Palette.Green
local u240 = Color3.fromRGB(16, 18, 24)
local u245 = Color3.fromRGB(70, 80, 98)

local function highlightEmptyCells(a1)
    -- Line: 555
    -- upvalues: u228 (val), Green (val), u233 (val)
    -- types: a1: boolean
    local UIStroke
    local v1 = nil
    local v2 = nil
    local v3 = a1

    for i, j in u228, v1, v2 do
        UIStroke = j:FindFirstChildWhichIsA("UIStroke")

        if UIStroke then
            UIStroke.Color = if not v3 then u233 else Green
            UIStroke.Transparency = if not v3 then 0.55 else 0.2
        end
    end
end

local function highlightHotbar(a1) -- Line: 579; upvalues: u199 (val), u56 (val), u240 (val); types: a1: boolean
    local UIStroke
    local v1 = nil
    local v2 = nil
    local v3 = a1

    for i, j in u199, v1, v2 do
        UIStroke = j:FindFirstChildWhichIsA("UIStroke")

        if UIStroke then
            UIStroke.Color = if not v3 then u240 else u56.Palette.Green
            UIStroke.Transparency = if not v3 then 0 else 0.45
        end
    end
end

local function buildEmptyCell(a1, a2, a3)
    -- Line: 592
    -- upvalues: u115 (val), u233 (val), u228 (val), u202 (ref), u203 (ref)
    -- types: a1: userdata, a2: number, a3: boolean
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.fromOffset(u115, u115)
    Frame.BackgroundColor3 = Color3.fromRGB(22, 25, 32)
    Frame.BackgroundTransparency = 0.45
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = a2
    Frame.Parent = a1
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Frame
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 2
    UIStroke.Color = u233
    UIStroke.Transparency = 0.55
    UIStroke.Parent = Frame

    if a3 then
        table.insert(u228, Frame)

        Frame.MouseEnter:Connect(function() -- Line: 615; upvalues: u202 (upval), Frame (val)
            u202 = Frame:GetAttribute("Cell")
        end)

        Frame.MouseLeave:Connect(function() -- Line: 618; upvalues: u202 (upval), Frame (val)
            if u202 == Frame:GetAttribute("Cell") then
                u202 = nil
            end
        end)

        local TextButton = Instance.new("TextButton")
        TextButton.Name = "Place"
        TextButton.Size = UDim2.fromScale(1, 1)
        TextButton.BackgroundTransparency = 1
        TextButton.Text = ""
        TextButton.Parent = Frame

        TextButton.Activated:Connect(function() -- Line: 629; upvalues: Frame (val), u203 (upval)
            local Attribute = Frame:GetAttribute("Cell")

            if type(Attribute) == "number" then
                u203(Attribute)
            end
        end)
    end

    return Frame
end

local function saveArrangement() -- Line: 642; upvalues: u190 (ref), u189 (ref), Config (val), u110 (val), u188 (ref)
    if not u190 and u189 then
        u190 = true
        task.delay(
            Config.Appearance.Backpack.ArrangeSaveSeconds,
            function() -- Line: 647; upvalues: u190 (upval), u110 (upval), u188 (upval)
                u190 = false
                u110:FireServer(u188)
            end
        )
    end
end

local function claimCell(a1, a2)
    -- Line: 654
    -- upvalues: u188 (ref), u190 (ref), u189 (ref), Config (val), u110 (val)
    -- types: a1: string, a2: number
    for i, j in u188 do
        if j == a2 and i ~= a1 then
            u188[i] = nil
        end
    end

    u188[a1] = a2

    if not u190 then
        if not u189 then
            return
        end

        u190 = true
        task.delay(
            Config.Appearance.Backpack.ArrangeSaveSeconds,
            function() -- Line: 647; upvalues: u190 (upval), u110 (upval), u188 (upval)
                u190 = false
                u110:FireServer(u188)
            end
        )
    end
end

local u254 = nil
local u255 = 0
local zero = Vector2.zero
local u257 = false

local function stopDrag()
    -- Line: 685
    -- upvalues: highlightEmptyCells (val), highlightHotbar (val), u205 (ref), u206 (ref), u207 (ref), u257 (ref)
    highlightEmptyCells(false)
    highlightHotbar(false)

    if u205 then
        u205:Destroy()

        u205 = nil
    end

    u206 = nil
    u207 = nil
    u257 = false
end

local function moveGhost(a1) -- Line: 700; upvalues: u205 (ref); types: a1: userdata
    if u205 then
        u205.Position = UDim2.fromOffset(a1.X + 14, a1.Y + 14)
    end
end

local function showDrag(a1)
    -- Line: 707
    -- upvalues: u206 (ref), u257 (ref), highlightHotbar (val), highlightEmptyCells (val), u207 (ref), u213 (ref)
    -- upvalues: u197 (ref), u204 (ref), u56 (val), ItemIcon (val), StackKey (val), u205 (ref)
    -- types: a1: userdata
    local v1 = u206

    if v1 and not u257 then
        u257 = true
        highlightHotbar(true)

        local v2 = true

        if u207 == nil then
            v2 = false

            if u213 == nil then
                v2 = u197 == ""
            end
        end

        highlightEmptyCells(v2)

        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.fromOffset(48, 48)
        Frame.BackgroundColor3 = Color3.fromRGB(30, 34, 42)
        Frame.BackgroundTransparency = 0.2
        Frame.BorderSizePixel = 0
        Frame.Active = false
        Frame.Parent = u204
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = Frame
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Thickness = 2
        UIStroke.Color = u56.Palette.Green
        UIStroke.Parent = Frame
        local Frame_2 = Instance.new("Frame")
        Frame_2.Size = UDim2.fromOffset(32, 32)
        Frame_2.Position = UDim2.fromOffset(8, 8)
        Frame_2.BackgroundTransparency = 1
        Frame_2.Parent = Frame

        ItemIcon.render(Frame_2, StackKey.item(v1), 32, 4)

        u205 = Frame

        if u205 then
            u205.Position = UDim2.fromOffset(a1.X + 14, a1.Y + 14)
        end
    end
end

local function beginDrag(a1, a2, a3)
    -- Line: 751
    -- upvalues: highlightEmptyCells (val), highlightHotbar (val), u205 (ref), u206 (ref), u207 (ref), u257 (ref)
    -- upvalues: u202 (ref), zero (ref), u255 (ref), Config (val), showDrag (val)
    -- types: a1: string, a2: number?, a3: userdata
    highlightEmptyCells(false)
    highlightHotbar(false)

    if u205 then
        u205:Destroy()

        u205 = nil
    end

    u206 = nil
    u207 = nil
    u257 = false
    u202 = nil
    u206 = a1
    u207 = a2
    zero = a3
    u255 = u255 + 1
    local u24 = u255

    task.delay(
        Config.Appearance.Backpack.DragHoldSeconds,
        function()
            -- Line: 763
            -- upvalues: u206 (upval), a1 (val), u255 (upval), u24 (val), u257 (upval), showDrag (upval), zero (upval)
            if u206 == a1 and u255 == u24 and not u257 then
                showDrag(zero)
            end
        end
    )
end

local function dropTargetAt(a1)
    -- Line: 782
    -- upvalues: LocalPlayer (val), GuiService (val), u199 (val), u177 (ref)
    -- types: a1: userdata
    local Attribute, Parent
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")

    if not PlayerGui then
        return nil, nil
    end

    local v1 = {a1, a1 - (GuiService:GetGuiInset())}
    local v2 = nil
    local v3 = nil

    for i, j in v1, v2, v3 do
        for k, n in PlayerGui:GetGuiObjectsAtPosition(j.X, j.Y) do
            Parent = n

            while Parent do
                if Parent == PlayerGui then
                    break
                end

                for m, i5 in u199 do
                    if i5 == Parent then
                        return m, nil
                    end
                end

                if Parent.Parent == u177 and Parent:IsA("GuiObject") then
                    Attribute = Parent:GetAttribute("Cell")

                    if type(Attribute) == "number" then
                        return nil, Attribute
                    end
                end

                Parent = Parent.Parent
            end
        end
    end

    return nil, nil
end

local function finishDrag(a1, a2)
    -- Line: 810
    -- upvalues: u206 (ref), u207 (ref), highlightEmptyCells (val), highlightHotbar (val), u205 (ref), u257 (ref)
    -- upvalues: dropTargetAt (val), u201 (ref), u202 (ref), HotbarController (val), u213 (ref), u197 (ref), u191 (val)
    -- upvalues: u254 (ref), u210 (ref), u211 (ref), u208 (ref)
    -- types: a1: userdata?, a2: boolean?
    local v1
    local v2 = u206
    local v3 = u207

    highlightEmptyCells(false)
    highlightHotbar(false)

    if u205 then
        u205:Destroy()

        u205 = nil
    end

    u206 = nil
    u207 = nil
    u257 = false

    if not v2 then
        return
    end

    local v4 = nil
    local v5 = nil

    if a1 then
        local v6
        v1, v6 = dropTargetAt(a1)
        v4 = v1
        v5 = v6
    end

    if not v4 and not v5 and not a2 then
        v4 = u201
        v5 = u202
    end

    if v4 then
        HotbarController.assign(v4, v2)
        u208()
        u210()
        u211()

        return
    end

    if v5 then
        v1 = false

        if u213 == nil then
            v1 = u197 == ""
        end

        if v1 and v5 ~= u191[v2] then
            u254(v2, v5, v3)
            return
        end
    end

    if v3 then
        HotbarController.assign(v3, nil)
        u208()
        u210()
        u211()

        return
    end

    HotbarController.setPending(v2)
    HotbarController.selectLoose(v2)
    u210()
    u211()
end

local function clear(a1) -- Line: 859; types: a1: userdata
    for i, j in a1:GetChildren() do
        if j:IsA("Frame") then
            j:Destroy()
        end
    end
end

function u211()
    -- Line: 867
    -- upvalues: HotbarController (val), u182 (ref), Palette (val), StackKey (val), u21 (val), u213 (ref), u197 (ref)
    -- upvalues: ControlGlyphs (val), u56 (val)
    local v1 = HotbarController.pending()

    if not v1 then
        u182.Text = if not u21 then
            if not ControlGlyphs.usingGamepad() then
                "Right-click an item to send it to the bar, or a bar slot to take it off. Drag works too."
            else
                ControlGlyphs.say("Hold {Y} and press {A} on an item to send it to the bar, or on a bar slot to take it off.")
        else
            "Tap an item, then a bar slot. Drag off the bar to remove."
        u182.TextColor3 = u56.Palette.Faint

        return
    end

    local v2 = u182
    local v3 = Palette.displayName(StackKey.item(v1))
    local v4 = false

    if u213 == nil then
        v4 = u197 == ""
    end

    v2.Text = ("Holding %*: %* a hotbar slot%* to place it"):format(v3, if not u21 then "click" else "tap", if not v4 then "" else " or an empty cell")
    u182.TextColor3 = Color3.fromRGB(150, 230, 170)
end

local u278 = {}

local function makeItemSlot(a1, a2, a3, a4)
    -- Line: 908
    -- upvalues: buildSlot (val), u177 (ref), showTooltip (val), u202 (ref), u153 (ref), HotbarController (val)
    -- upvalues: u208 (ref), u210 (ref), u211 (ref), ControlGlyphs (val), highlightEmptyCells (val)
    -- upvalues: highlightHotbar (val), u205 (ref), u206 (ref), u207 (ref), u257 (ref), zero (ref), u255 (ref)
    -- upvalues: Config (val), showDrag (val), NewBadges (val), StackKey (val)
    -- types: a1: string, a2: number, a3: number, a4: boolean
    local u10 = buildSlot(u177, a1, a2, a3, a4)
    local TextButton = Instance.new("TextButton")
    TextButton.Size = UDim2.fromScale(1, 1)
    TextButton.BackgroundTransparency = 1
    TextButton.Text = ""
    TextButton.Parent = u10

    TextButton.MouseEnter:Connect(function()
        -- Line: 920
        -- upvalues: showTooltip (upval), a1 (val), u10 (val), u202 (upval)
        showTooltip(a1, u10)

        u202 = u10:GetAttribute("Cell")
    end)

    TextButton.MouseLeave:Connect(function() -- Line: 924; upvalues: u153 (upval), u202 (upval), u10 (val)
        u153()

        if u202 == u10:GetAttribute("Cell") then
            u202 = nil
        end
    end)

    local function sendToBar()
        -- Line: 946
        -- upvalues: HotbarController (upval), a1 (val), u208 (upval), u210 (upval), u211 (upval)
        local v1 = HotbarController.firstFreeSlot()

        if v1 then
            HotbarController.assign(v1, a1)
            u208()
            u210()
            u211()
        end
    end

    TextButton.InputBegan:Connect(function(a1_2)
        -- Line: 956
        -- upvalues: HotbarController (upval), a1 (val), u208 (upval), u210 (upval), u211 (upval), ControlGlyphs (upval)
        -- upvalues: highlightEmptyCells (upval), highlightHotbar (upval), u205 (upval), u206 (upval), u207 (upval)
        -- upvalues: u257 (upval), u202 (upval), zero (upval), u255 (upval), Config (upval), showDrag (upval)
        local v1

        if a1_2.UserInputType == Enum.UserInputType.MouseButton2 then
            v1 = HotbarController.firstFreeSlot()

            if v1 then
                HotbarController.assign(v1, a1)
                u208()
                u210()
                u211()
            end

            return
        end

        v1 = true

        if a1_2.UserInputType ~= Enum.UserInputType.MouseButton1 then
            v1 = a1_2.UserInputType == Enum.UserInputType.Touch
        end

        if not v1 then
            return
        end

        if ControlGlyphs.bulkHeld() then
            v1 = HotbarController.firstFreeSlot()

            if v1 then
                HotbarController.assign(v1, a1)
                u208()
                u210()
                u211()
            end

            return
        end

        local u42 = a1
        local v2 = Vector2.new(a1_2.Position.X, a1_2.Position.Y)

        highlightEmptyCells(false)
        highlightHotbar(false)

        if u205 then
            u205:Destroy()

            u205 = nil
        end

        u206 = nil
        u207 = nil
        u257 = false
        u202 = nil
        u206 = u42
        u207 = nil
        zero = v2
        u255 = u255 + 1
        local u71 = u255

        task.delay(
            Config.Appearance.Backpack.DragHoldSeconds,
            function()
                -- Line: 763
                -- upvalues: u206 (upval), u42 (val), u255 (upval), u71 (val), u257 (upval), showDrag (upval)
                -- upvalues: zero (upval)
                if u206 == u42 and u255 == u71 and not u257 then
                    showDrag(zero)
                end
            end
        )
    end)

    local v1 = u10:FindFirstChild("Count")
    local v2 = {frame = u10, stroke = u10:FindFirstChildWhichIsA("UIStroke")}
    v2.amount = if not v1 then nil else if not v1:IsA("TextLabel") then nil else v1
    v2.count = a2
    v2.highlighted = a4
    v2.isNew = NewBadges.isNewItem(StackKey.item(a1))

    return v2
end

local function updateItemSlot(a1, a2, a3, a4, a5)
    -- Line: 989
    -- upvalues: StackKey (val), u56 (val), NewBadges (val)
    -- types: a1: table, a2: string, a3: number, a4: number, a5: boolean
    local v1 = StackKey.item(a2)
    local frame = a1.frame

    if frame.LayoutOrder ~= a4 then
        frame.LayoutOrder = a4
    end

    if a1.count ~= a3 then
        a1.count = a3

        if a1.amount then
            a1.amount.Text = ("x%*"):format(a3)
        end
    end

    if a1.highlighted ~= a5 then
        a1.highlighted = a5
        local stroke = a1.stroke

        if stroke then
            stroke.Thickness = if not a5 then 2 else 3
            local Green = if not a5 then Color3.fromRGB(16, 18, 24) else u56.Palette.Green
            stroke.Color = Green
        end
    end

    local v2 = NewBadges.isNewItem(v1)

    if a1.isNew ~= v2 then
        a1.isNew = v2
        local New = if not v2 then Color3.fromRGB(30, 34, 42) else u56.Palette.New
        frame.BackgroundColor3 = New
        local NewDot = frame:FindFirstChild("NewDot")

        if v2 and not NewDot then
            u56.newDot(frame)
            return
        end

        if not v2 and NewDot then
            NewDot:Destroy()
        end
    end
end

function u210()
    -- Line: 1023
    -- upvalues: u185 (ref), StackKey (val), u139 (val), Config (val), HotbarController (val), matchesQuery (val)
    -- upvalues: u213 (ref), u184 (ref), u183 (ref), Categories (val), u191 (val), u192 (val), u197 (ref), u189 (ref)
    -- upvalues: u188 (ref), u190 (ref), u110 (val), u278 (val), u177 (ref), updateItemSlot (val), makeItemSlot (val)
    -- upvalues: u228 (val), buildEmptyCell (val), u206 (ref), highlightEmptyCells (val), u115 (val), u211 (ref)
    local v1, v2, v3, v4, v5
    local v6 = {}
    local v7 = 0
    local v8 = 0
    local v9 = nil
    local v10 = nil

    for i, j in u185, v9, v10 do
        if j > 0 then
            v5 = StackKey.item(i)
            v4 = true

            if u139.equipSlotOf(v5) == nil then
                v4 = Config.Wearable.slotOf(v5) ~= nil
            end

            if not v4 then
                v7 = v7 + 1

                if HotbarController.isOnBar(i) then
                    v8 = v8 + 1
                elseif matchesQuery(i) then
                    v4 = true

                    if u213 ~= nil then
                        v4 = (u139.categoryOf(StackKey.item(i)) or "Items") == u213
                    end

                    if v4 then
                        table.insert(
                            v6,
                            {id = i, count = j}
                        )
                    end
                end
            end
        end
    end

    if #v6 > 0 or v7 == 0 then
        u184.Visible = false
    elseif v8 ~= v7 then
        u184.Visible = true
        u184.Text = ("No items match \"%*\" (%* not on the hotbar)"):format(u183.Text, v7 - v8)
    else
        u184.Visible = false
    end

    local u30 = {}

    for k, n in Categories do
        u30[n] = k
    end

    table.sort(
        v6,
        function(a1, a2) -- Line: 1060; upvalues: u30 (val), u139 (upval), StackKey (upval)
            local id = a1.id
            local v1 = u30[u139.categoryOf(StackKey.item(id)) or "Items"] or 99
            local id_2 = a2.id
            local v2 = u30[u139.categoryOf(StackKey.item(id_2)) or "Items"] or 99

            if v1 ~= v2 then
                return v1 < v2
            end

            return a1.id < a2.id
        end
    )

    v7 = {}
    local v11 = {}
    v9 = #v6

    table.clear(u191)
    table.clear(u192)

    v10 = false

    if u213 == nil then
        v10 = u197 == ""
    end

    if not v10 then
        for m, i5 in v6 do
            v7[i5.id] = m
            v11[m] = true
        end
    else
        local id, v12

        if u189 then
            for i6 in u188 do
                if (u185[i6] or 0) <= 0 then
                    u188[i6] = nil

                    if not u190 and u189 then
                        u190 = true
                        task.delay(
                            Config.Appearance.Backpack.ArrangeSaveSeconds,
                            function() -- Line: 647; upvalues: u190 (upval), u110 (upval), u188 (upval)
                                u190 = false
                                u110:FireServer(u188)
                            end
                        )
                    end
                end
            end
        end

        for i7, i8 in v6 do
            v12 = u188[i8.id]

            if v12 and not v11[v12] then
                v7[i8.id] = v12
                v11[v12] = true
            end
        end

        v10 = {}

        for i9, i10 in u188 do
            if not v7[i9] and 0 < (u185[i9] or 0) then
                v10[i10] = true
            end
        end

        v3 = 1
        v4 = nil
        v5 = nil

        for i11, i12 in v6, v4, v5 do
            if not v7[i12.id] then
                while true do
                    if v11[v3] then
                        v3 = v3 + 1
                        continue
                    end

                    if not v10[v3] then
                        break
                    end

                    v3 = v3 + 1
                end

                v7[i12.id] = v3
                v11[v3] = true

                if u189 then
                    id = i12.id

                    for i13, i14 in u188 do
                        if i14 == v3 and i13 ~= id then
                            u188[i13] = nil
                        end
                    end

                    u188[id] = v3

                    if not u190 and u189 then
                        u190 = true
                        task.delay(
                            Config.Appearance.Backpack.ArrangeSaveSeconds,
                            function() -- Line: 647; upvalues: u190 (upval), u110 (upval), u188 (upval)
                                u190 = false
                                u110:FireServer(u188)
                            end
                        )
                    end
                end
            end
        end

        v9 = 0

        for i15, i16 in v7 do
            u191[i15] = i16
            u192[i16] = i15
            v9 = math.max(v9, i16)
        end
    end

    v10 = HotbarController.pending()
    v3 = {}
    v4 = nil
    v5 = nil

    for i17, i18 in v6, v4, v5 do
        v3[i18.id] = true
        v1 = v7[i18.id]
        v2 = u278[i18.id]

        if not v2 or v2.frame.Parent ~= u177 then
            v2 = makeItemSlot(i18.id, i18.count, v1, v10 == i18.id)
            u278[i18.id] = v2
        else
            updateItemSlot(v2, i18.id, i18.count, v1, v10 == i18.id)
        end

        v2.frame:SetAttribute("Cell", v1)
    end

    for i19, i20 in u278 do
        if not v3[i19] then
            i20.frame:Destroy()

            u278[i19] = nil
        end
    end

    v3 = math.max(4, (math.ceil(v9 / 8)) + 1)
    v10 = {}
    local v13 = v3 * 8

    for i21 = 1, v13 do
        if not v11[i21] then
            table.insert(v10, i21)
        end
    end

    v9 = #v10

    while v9 < #u228 do
        table.remove(u228):Destroy()
    end

    v4 = nil
    v5 = nil

    for i22, i23 in u228, v4, v5 do
        v7 = v10[i22]

        if i23.LayoutOrder ~= v7 then
            i23.LayoutOrder = v7
        end

        i23:SetAttribute("Cell", v7)
    end

    for i24 = #u228 + 1, v9 do
        (buildEmptyCell(u177, v10[i24], true)):SetAttribute("Cell", v10[i24])
    end

    if u206 then
        highlightEmptyCells(true)
    end

    u177.CanvasSize = UDim2.fromOffset(0, v3 * (u115 + 6) + 6)
    u211()
end

function u254(a1, a2, a3)
    -- Line: 1194
    -- upvalues: u189 (ref), u192 (val), u191 (val), HotbarController (val), u188 (ref), u190 (ref), Config (val)
    -- upvalues: u110 (val), u208 (ref), u210 (ref), u211 (ref)
    -- types: a1: string, a2: number, a3: number?
    if not u189 then
        return
    end

    local v1 = u192[a2]
    local v2 = u191[a1]

    if a3 then
        HotbarController.assign(a3, nil)
    end

    if v1 and v1 ~= a1 then
        if not v2 then
            u188[v1] = nil
        else
            for i, j in u188 do
                if j == v2 and i ~= v1 then
                    u188[i] = nil
                end
            end

            u188[v1] = v2

            if not u190 and u189 then
                u190 = true
                task.delay(
                    Config.Appearance.Backpack.ArrangeSaveSeconds,
                    function() -- Line: 647; upvalues: u190 (upval), u110 (upval), u188 (upval)
                        u190 = false
                        u110:FireServer(u188)
                    end
                )
            end
        end
    end

    for k, n in u188 do
        if n == a2 and k ~= a1 then
            u188[k] = nil
        end
    end

    u188[a1] = a2

    if not u190 and u189 then
        u190 = true
        task.delay(
            Config.Appearance.Backpack.ArrangeSaveSeconds,
            function() -- Line: 647; upvalues: u190 (upval), u110 (upval), u188 (upval)
                u190 = false
                u110:FireServer(u188)
            end
        )
    end

    if a3 then
        u208()
    end

    u210()
    u211()
end

function u203(a1)
    -- Line: 1219
    -- upvalues: HotbarController (val), u213 (ref), u197 (ref), u185 (ref), u254 (ref)
    -- types: a1: number
    local v1 = HotbarController.pending()

    if v1 then
        local v2 = false

        if u213 == nil then
            v2 = u197 == ""
        end

        if v2 and not ((u185[v1] or 0) <= 0) and not HotbarController.isOnBar(v1) then
            HotbarController.setPending(v1)
            u254(v1, a1, nil)
        end
    end
end

local u284 = nil

local function equipmentSignature()
    -- Line: 1233
    -- upvalues: u126 (val), u139 (val), Config (val), u185 (ref), StackKey (val), u195 (ref), u186 (ref), u193 (ref)
    -- upvalues: u187 (ref), u194 (val)
    local v1
    local v2 = {}
    local v3 = nil
    local v4 = nil

    for i, j in u126, v3, v4 do
        for k, n2 in u139.equipmentFor(j) do
            v2[n2] = true
        end
    end

    for m in Config.Wearable.Items do
        v2[m] = true
    end

    local v5 = {}

    for i5, i6 in u185 do
        if v2[StackKey.item(i5)] then
            table.insert(v5, (("c%*=%*"):format(i5, i6)))
        end
    end

    for i7, i8 in u195 do
        if v2[i8.itemId] then
            v1 = StackKey.roll(i8.outcome, i8.perfect, i8.stats)
            table.insert(v5, (("g%*=%*"):format(i8.n, (StackKey.of(i8.itemId, v1)))))
        end
    end

    for i9, i10 in u186 do
        table.insert(v5, (("e%*=%*"):format(i9, i10)))
    end

    for i11, i12 in u193 do
        table.insert(v5, (("n%*=%*"):format(i11, i12)))
    end

    for i13, i14 in u187 do
        table.insert(v5, (("w%*=%*"):format(i13, i14)))
    end

    for i15, i16 in u194 do
        table.insert(v5, (("x%*=%*"):format(i15, i16)))
    end

    table.sort(v5)

    return table.concat(v5, ";")
end

function rebuildEquipment()
    -- Line: 1272
    -- upvalues: equipmentSignature (val), u284 (ref), u178 (ref), clear (val), u141 (val), u126 (val), u115 (val)
    -- upvalues: u56 (val), u139 (val), u195 (ref), StackKey (val), Config (val), u185 (ref), u186 (ref), u193 (ref)
    -- upvalues: u194 (val), buildSlot (val), u101 (val), showTooltip (val), u153 (ref), u233 (val)
    -- upvalues: rebuildEquipment (val), u187 (ref), u104 (val)
    local Frame, Frame_2, Frame_3, Frame_4, Frame_5, Frame_6, Green, Items, Slots, TextButton, TextButton_2,
        TextButton_3, TextButton_4, TextLabel, TextLabel_2, UICorner, UICorner_2, UICorner_3, UIGridLayout,
        UIGridLayout_2, UIStroke, UIStroke_2, UIStroke_3, UIStroke_4, copies, copies_2, copies_3, copies_4, isLit,
        litIn, stack, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21
    local dispatch = 0

    while true do
        if dispatch < 3 then
            if dispatch < 1 then
                v1 = equipmentSignature()
                dispatch = if v1 ~= u284 then 3 else 1
            else
                if not (dispatch < 2) then
                    return
                end

                dispatch = if not u178:FindFirstChildOfClass("Frame") then 3 else 2
            end
        elseif dispatch < 99 then
            u284 = v1
            clear(u178)
            table.clear(u141)

            v1 = 4
            v2 = u126
            v13 = nil
            v20 = nil
            local dispatchExit = nil

            for i22, i23 in v2, v13, v20 do
                local n, u1127
                local dispatch2 = 4

                while true do
                    if dispatch2 < 34 then
                        if dispatch2 < 28 then
                            if dispatch2 < 21 then
                                if dispatch2 < 20 then
                                    Frame_5 = Instance.new("Frame")
                                    Frame_5.Size = UDim2.new(1, -12, 0, u115 + 22)
                                    Frame_5.Position = UDim2.fromOffset(6, v1)
                                    Frame_5.BackgroundTransparency = 1
                                    Frame_5.Parent = u178
                                    TextLabel_2 = Instance.new("TextLabel")
                                    TextLabel_2.Size = UDim2.fromOffset(120, 18)
                                    TextLabel_2.BackgroundTransparency = 1
                                    TextLabel_2.Text = string.upper(i23)
                                    TextLabel_2.TextColor3 = u56.Palette.Faint
                                    TextLabel_2.FontFace = u56.Font.Bold
                                    TextLabel_2.TextSize = 11
                                    TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
                                    TextLabel_2.Parent = Frame_5
                                    Frame_6 = Instance.new("Frame")
                                    Frame_6.Position = UDim2.fromOffset(0, 20)
                                    Frame_6.BackgroundTransparency = 1
                                    Frame_6.Parent = Frame_5
                                    UIGridLayout_2 = Instance.new("UIGridLayout")
                                    UIGridLayout_2.CellSize = UDim2.fromOffset(u115, u115)
                                    UIGridLayout_2.CellPadding = UDim2.fromOffset(6, 6)
                                    UIGridLayout_2.FillDirectionMaxCells = 8
                                    UIGridLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
                                    UIGridLayout_2.Parent = Frame_6
                                    v21 = {}
                                    v3 = u139.equipmentFor(i23)
                                    v4 = nil
                                    v5 = nil
                                    local dispatchExit2 = nil

                                    for i24, i25 in v3, v4, v5 do
                                        local dispatch3 = 5

                                        while true do
                                            if dispatch3 < 14 then
                                                if dispatch3 < 12 then
                                                    if dispatch3 < 11 then
                                                        v8 = 0
                                                        v9 = {}
                                                        v10 = u195
                                                        v11 = nil
                                                        v12 = nil
                                                        local dispatchExit3 = nil

                                                        for i26, i27 in v10, v11, v12 do
                                                            local dispatch4 = 6

                                                            while true do
                                                                if not (dispatch4 < 8) then
                                                                    if not (dispatch4 < 9) then
                                                                        table.insert(v16.copies, i27)

                                                                        v17 = u141[v16.stack]
                                                                        v17.count = v17.count + 1
                                                                        v8 = v8 + 1
                                                                        break
                                                                    end

                                                                    v16 = {itemId = i25, copies = {}, stack = StackKey.of(i25, v15)}
                                                                    v9[v15] = v16

                                                                    table.insert(v21, v16)

                                                                    u141[v16.stack] = {
                                                                        count = 0,
                                                                        roll = v15,
                                                                        outcome = i27.outcome,
                                                                        perfect = i27.perfect,
                                                                        stats = i27.stats,
                                                                    }
                                                                    dispatch4 = 9
                                                                elseif not (dispatch4 < 7) then
                                                                    v15 = StackKey.roll(i27.outcome, i27.perfect, i27.stats)
                                                                    v16 = v9[v15]
                                                                    dispatch4 = if v16 then 9 else 8
                                                                elseif i27.itemId ~= i25 then
                                                                    break
                                                                else
                                                                    dispatch4 = 7
                                                                end
                                                            end

                                                            if dispatchExit3 then
                                                                break
                                                            end
                                                        end

                                                        dispatch3 = 11
                                                    else
                                                        dispatch3 = if Config.Tool.StarterEquipment[i25]
                                                            == true then
                                                            13
                                                        else
                                                            12
                                                    end
                                                else
                                                    v9 = not (dispatch3 < 13)
                                                    dispatch3 = 14
                                                end
                                            elseif dispatch3 < 16 then
                                                if not (dispatch3 < 15) then
                                                    dispatch3 = if v9 then 18 else 16
                                                elseif v8 ~= 0 then
                                                    break
                                                else
                                                    dispatch3 = 15
                                                end
                                            elseif dispatch3 < 17 then
                                                dispatch3 = if 0 < (u185[i25] or 0) then 18 else 17
                                            else
                                                if not (dispatch3 < 18) then
                                                    table.insert(
                                                        v21,
                                                        {itemId = i25, copies = {}, stack = i25}
                                                    )
                                                    break
                                                end

                                                if u186[i23] ~= i25 then
                                                    break
                                                else
                                                    dispatch3 = 18
                                                end
                                            end
                                        end

                                        if dispatchExit2 then
                                            break
                                        end
                                    end

                                    dispatch2 = 20
                                else
                                    n = u193[i23]
                                    dispatch2 = if n then 26 else 21
                                end
                            elseif dispatch2 < 26 then
                                v4 = v21
                                v5 = nil
                                v6 = nil
                                local dispatchExit4 = nil

                                for i28, i29 in v4, v5, v6 do
                                    local dispatch5 = 22

                                    while true do
                                        if not (dispatch5 < 23) then
                                            if not (dispatch5 < 24) then
                                                n = i29.copies[1].n
                                                dispatchExit4 = 26
                                                break
                                            end

                                            if not i29.copies[1] then
                                                break
                                            else
                                                dispatch5 = 24
                                            end
                                        elseif i29.itemId ~= u186[i23] then
                                            break
                                        else
                                            dispatch5 = 23
                                        end
                                    end

                                    if dispatchExit4 then
                                        break
                                    end
                                end

                                if not dispatchExit4 then end

                                dispatch2 = 26
                            elseif dispatch2 < 27 then
                                function litIn(a1) -- Line: 1369; upvalues: n (ref); types: a1: table
                                    for i, j in a1.copies do
                                        if j.n == n then
                                            return j
                                        end
                                    end

                                    return nil
                                end

                                function isLit(a1)
                                    -- Line: 1378
                                    -- upvalues: u186 (upval), i23 (val), n (ref)
                                    -- types: a1: table
                                    local v1 = false

                                    if u186[i23] == a1.itemId then
                                        v1 = true

                                        if #a1.copies ~= 0 then
                                            for i, j in a1.copies do
                                                if j.n == n then
                                                    return j ~= nil
                                                end
                                            end

                                            v1 = false
                                        end
                                    end

                                    return v1
                                end

                                dispatch2 = if #v21 > 8 then 28 else 27
                            else
                                v5 = false
                                dispatch2 = 29
                            end
                        elseif dispatch2 < 31 then
                            if dispatch2 < 29 then
                                v5 = true
                                dispatch2 = 29
                            elseif dispatch2 < 30 then
                                u1127 = v5
                                dispatch2 = if not u1127 then 33 else 30
                            else
                                dispatch2 = if u194[i23] == true then 32 else 31
                            end
                        elseif dispatch2 < 32 then
                            u1127 = false
                            dispatch2 = 33
                        elseif dispatch2 < 33 then
                            u1127 = true
                            dispatch2 = 33
                        else
                            v7 = v21
                            dispatch2 = if not v5 then 64 else 34
                        end
                    elseif dispatch2 < 91 then
                        if dispatch2 < 50 then
                            if dispatch2 < 35 then
                                dispatch2 = if u1127 then 64 else 35
                            elseif dispatch2 < 49 then
                                v7 = table.move(
                                    v21,
                                    1,
                                    7,
                                    1,
                                    {}
                                )
                                v8 = false
                                v9 = v7
                                v10 = nil
                                v11 = nil
                                local dispatchExit5 = nil

                                for i30, i31 in v9, v10, v11 do
                                    local dispatch6 = 36

                                    while true do
                                        if dispatch6 < 43 then
                                            if dispatch6 < 38 then
                                                if dispatch6 < 37 then
                                                    v14 = v8
                                                    dispatch6 = if v14 then 47 else 37
                                                else
                                                    v14 = false
                                                    dispatch6 = if u186[i23] ~= i31.itemId then
                                                        47
                                                    else
                                                        38
                                                end
                                            elseif dispatch6 < 39 then
                                                v14 = true
                                                dispatch6 = if #i31.copies == 0 then 47 else 39
                                            else
                                                copies_2 = i31.copies
                                                v17 = nil
                                                v18 = nil
                                                local dispatchExit6 = nil

                                                for i32, i33 in copies_2, v17, v18 do
                                                    local dispatch7 = 40

                                                    while true do
                                                        if not (dispatch7 < 41) then
                                                            v15 = i33
                                                            dispatchExit6 = 44
                                                            break
                                                        end

                                                        if i33.n ~= n then
                                                            break
                                                        else
                                                            dispatch7 = 41
                                                        end
                                                    end

                                                    if dispatchExit6 then
                                                        break
                                                    end
                                                end

                                                dispatch6 = if dispatchExit6 == 44 then 44 else 43
                                            end
                                        elseif dispatch6 < 45 then
                                            if dispatch6 < 44 then
                                                v15 = nil
                                                dispatch6 = 44
                                            else
                                                dispatch6 = if v15 ~= nil then 46 else 45
                                            end
                                        else
                                            if dispatch6 < 46 then
                                                v14 = false
                                            else
                                                if not (dispatch6 < 47) then
                                                    v8 = v14
                                                    break
                                                end

                                                v14 = true
                                            end

                                            dispatch6 = 47
                                        end
                                    end

                                    if dispatchExit5 then
                                        break
                                    end
                                end

                                dispatch2 = 49
                            else
                                dispatch2 = if v8 then 64 else 50
                            end
                        elseif dispatch2 < 64 then
                            v9 = v21
                            v10 = nil
                            v11 = nil
                            local dispatchExit7 = nil

                            for i34, i35 in v9, v10, v11 do
                                local dispatch8 = 51

                                while true do
                                    if dispatch8 < 58 then
                                        if dispatch8 < 53 then
                                            if dispatch8 < 52 then
                                                v14 = false
                                                dispatch8 = if u186[i23] ~= i35.itemId then 61 else 52
                                            else
                                                v14 = true
                                                dispatch8 = if #i35.copies == 0 then 61 else 53
                                            end
                                        elseif dispatch8 < 57 then
                                            copies = i35.copies
                                            v17 = nil
                                            v18 = nil
                                            local dispatchExit8 = nil

                                            for i36, i37 in copies, v17, v18 do
                                                local dispatch9 = 54

                                                while true do
                                                    if not (dispatch9 < 55) then
                                                        v15 = i37
                                                        dispatchExit8 = 58
                                                        break
                                                    end

                                                    if i37.n ~= n then
                                                        break
                                                    else
                                                        dispatch9 = 55
                                                    end
                                                end

                                                if dispatchExit8 then
                                                    break
                                                end
                                            end

                                            dispatch8 = if dispatchExit8 == 58 then 58 else 57
                                        else
                                            v15 = nil
                                            dispatch8 = 58
                                        end
                                    elseif dispatch8 < 60 then
                                        if dispatch8 < 59 then
                                            dispatch8 = if v15 ~= nil then 60 else 59
                                        else
                                            v14 = false
                                            dispatch8 = 61
                                        end
                                    elseif dispatch8 < 61 then
                                        v14 = true
                                        dispatch8 = 61
                                    else
                                        if not (dispatch8 < 62) then
                                            v7[#v7] = i35
                                            dispatchExit7 = 64
                                            break
                                        end

                                        if not v14 then
                                            break
                                        else
                                            dispatch8 = 62
                                        end
                                    end
                                end

                                if dispatchExit7 then
                                    break
                                end
                            end

                            if not dispatchExit7 then end

                            dispatch2 = 64
                        elseif dispatch2 < 90 then
                            v8 = v7
                            v9 = nil
                            v10 = nil
                            local dispatchExit9 = nil

                            for i38, i39 in v8, v9, v10 do
                                local itemId, u893
                                local dispatch10 = 65

                                while true do
                                    if dispatch10 < 80 then
                                        if dispatch10 < 72 then
                                            if dispatch10 < 70 then
                                                if dispatch10 < 69 then
                                                    itemId = i39.itemId
                                                    copies_3 = i39.copies
                                                    v16 = nil
                                                    v17 = nil
                                                    local dispatchExit10 = nil

                                                    for i40, i41 in copies_3, v16, v17 do
                                                        local u829
                                                        local dispatch11 = 66

                                                        while true do
                                                            if not (dispatch11 < 67) then
                                                                u829 = i41
                                                                dispatchExit10 = 70
                                                                break
                                                            end

                                                            if i41.n ~= n then
                                                                break
                                                            else
                                                                dispatch11 = 67
                                                            end
                                                        end

                                                        if dispatchExit10 then
                                                            break
                                                        end
                                                    end

                                                    dispatch10 = if dispatchExit10 == 70 then 70 else 69
                                                else
                                                    u829 = nil
                                                    dispatch10 = 70
                                                end
                                            elseif dispatch10 < 71 then
                                                dispatch10 = if u829 then 72 else 71
                                            else
                                                u829 = i39.copies[1]
                                                dispatch10 = 72
                                            end
                                        elseif dispatch10 < 74 then
                                            if dispatch10 < 73 then
                                                v15 = false
                                                dispatch10 = if u186[i23] ~= i39.itemId then 82 else 73
                                            else
                                                v15 = true
                                                dispatch10 = if #i39.copies == 0 then 82 else 74
                                            end
                                        elseif dispatch10 < 78 then
                                            copies_4 = i39.copies
                                            v18 = nil
                                            v19 = nil
                                            local dispatchExit11 = nil

                                            for i42, i43 in copies_4, v18, v19 do
                                                local dispatch12 = 75

                                                while true do
                                                    if not (dispatch12 < 76) then
                                                        v16 = i43
                                                        dispatchExit11 = 79
                                                        break
                                                    end

                                                    if i43.n ~= n then
                                                        break
                                                    else
                                                        dispatch12 = 76
                                                    end
                                                end

                                                if dispatchExit11 then
                                                    break
                                                end
                                            end

                                            dispatch10 = if dispatchExit11 == 79 then 79 else 78
                                        elseif dispatch10 < 79 then
                                            v16 = nil
                                            dispatch10 = 79
                                        else
                                            dispatch10 = if v16 ~= nil then 81 else 80
                                        end
                                    elseif dispatch10 < 84 then
                                        if dispatch10 < 82 then
                                            v15 = not (dispatch10 < 81)
                                            dispatch10 = 82
                                        elseif dispatch10 < 83 then
                                            v16 = buildSlot
                                            stack = i39.stack
                                            dispatch10 = if not (#i39.copies > 1) then 84 else 83
                                        else
                                            v19 = #i39.copies
                                            dispatch10 = 85
                                        end
                                    elseif dispatch10 < 86 then
                                        if dispatch10 < 85 then
                                            v19 = -1
                                            dispatch10 = 85
                                        else
                                            u893 = v16(Frame_6, stack, v19, i38, v15)
                                            dispatch10 = if #i39.copies ~= 0 then 88 else 86
                                        end
                                    elseif dispatch10 < 87 then
                                        v15 = u893:FindFirstChild("UniqueTag")
                                        dispatch10 = if not v15 then 88 else 87
                                    else
                                        if not (dispatch10 < 88) then
                                            TextButton_4 = Instance.new("TextButton")
                                            TextButton_4.Size = UDim2.fromScale(1, 1)
                                            TextButton_4.BackgroundTransparency = 1
                                            TextButton_4.Text = ""
                                            TextButton_4.Parent = u893

                                            TextButton_4.Activated:Connect(
                                                ((function(itemId, u829) -- upvalues: u101 (upval), i23 (val)
                                                    return function()
                                                        -- Line: 1424
                                                        -- upvalues: u101 (upval), i23 (val), itemId (val), u829 (val)
                                                        u101:FireServer(i23, itemId, if not u829 then nil else u829.n)
                                                    end
                                                end)(itemId, u829))
                                            )

                                            TextButton_4.MouseEnter:Connect(
                                                ((function(itemId, u893, u829) -- upvalues: showTooltip (upval)
                                                    return function()
                                                        -- Line: 1428
                                                        -- upvalues: showTooltip (upval), itemId (val), u893 (val)
                                                        -- upvalues: u829 (val)
                                                        showTooltip(itemId, u893, u829)
                                                    end
                                                end)(itemId, u893, u829))
                                            )

                                            TextButton_4.MouseLeave:Connect(u153)
                                            break
                                        end

                                        v15:Destroy()

                                        dispatch10 = 88
                                    end
                                end

                                if dispatchExit9 then
                                    break
                                end
                            end

                            dispatch2 = 90
                        else
                            v4 = #v7
                            dispatch2 = if not v5 then 95 else 91
                        end
                    elseif dispatch2 < 94 then
                        if dispatch2 < 92 then
                            v4 = v4 + 1
                            v8 = Instance.new("Frame")
                            v8.Size = UDim2.fromOffset(u115, u115)
                            v8.BackgroundColor3 = Color3.fromRGB(22, 25, 32)
                            v8.BackgroundTransparency = 0.45
                            v8.BorderSizePixel = 0
                            v8.LayoutOrder = v4
                            v8.Parent = Frame_6
                            UICorner_3 = Instance.new("UICorner")
                            UICorner_3.CornerRadius = UDim.new(0, 6)
                            UICorner_3.Parent = v8
                            UIStroke_4 = Instance.new("UIStroke")
                            UIStroke_4.Thickness = 2
                            UIStroke_4.Color = u233
                            UIStroke_4.Transparency = 0.55
                            UIStroke_4.Parent = v8
                            TextButton_3 = Instance.new("TextButton")
                            TextButton_3.Name = "MoreEquipment"
                            TextButton_3.Size = UDim2.fromScale(1, 1)
                            TextButton_3.BackgroundTransparency = 1
                            dispatch2 = if not u1127 then 93 else 92
                        else
                            v10 = if dispatch2 < 93 then "Less" else ("+%*\nmore"):format(#v21 - #v7)
                            dispatch2 = 94
                        end
                    elseif dispatch2 < 95 then
                        TextButton_3.Text = v10
                        TextButton_3.TextColor3 = u56.Palette.Dim
                        TextButton_3.FontFace = u56.Font.Bold
                        TextButton_3.TextSize = 12
                        TextButton_3.Parent = v8

                        TextButton_3.Activated:Connect(
                            ((function(u1127) -- upvalues: u194 (upval), i23 (val), rebuildEquipment (upval)
                                return function()
                                    -- Line: 1450
                                    -- upvalues: u194 (upval), i23 (val), u1127 (val), rebuildEquipment (upval)
                                    u194[i23] = not u1127
                                    rebuildEquipment()
                                end
                            end)(u1127))
                        )

                        dispatch2 = 95
                    else
                        if not (dispatch2 < 97) then
                            v21 = math.max(1, (math.ceil(v4 / 8)))
                            v4 = v21 * u115 + (v21 - 1) * 6
                            Frame_6.Size = UDim2.new(1, 0, 0, v4)
                            Frame_5.Size = UDim2.new(1, -12, 0, v4 + 22)
                            v1 = v1 + (v4 + 30)
                            break
                        end

                        local dispatchExit12 = nil

                        for i44 = v4 + 1, 8 do
                            v7 = Instance.new("Frame")
                            v7.Size = UDim2.fromOffset(u115, u115)
                            v7.BackgroundColor3 = Color3.fromRGB(22, 25, 32)
                            v7.BackgroundTransparency = 0.45
                            v7.BorderSizePixel = 0
                            v7.LayoutOrder = i44
                            v7.Parent = Frame_6
                            v5 = Instance.new("UICorner")
                            v5.CornerRadius = UDim.new(0, 6)
                            v5.Parent = v7
                            v5 = Instance.new("UIStroke")
                            v5.Thickness = 2
                            v5.Color = u233
                            v5.Transparency = 0.55
                            v5.Parent = v7
                        end

                        if not dispatchExit12 then end

                        dispatch2 = 97
                    end
                end

                if dispatchExit then
                    break
                end
            end

            dispatch = 99
        else
            if not (dispatch < 125) then
                u178.CanvasSize = UDim2.fromOffset(0, v1)
                return
            end

            Slots = Config.Wearable.Slots
            v13 = nil
            v20 = nil
            local dispatchExit13 = nil

            for i45, i46 in Slots, v13, v20 do
                local u116
                local dispatch13 = 100

                while true do
                    if dispatch13 < 111 then
                        if dispatch13 < 107 then
                            if dispatch13 < 101 then
                                if not i46.enabled then
                                    break
                                else
                                    dispatch13 = 101
                                end
                            elseif dispatch13 < 106 then
                                Frame = Instance.new("Frame")
                                Frame.Position = UDim2.fromOffset(6, v1)
                                Frame.BackgroundTransparency = 1
                                Frame.Parent = u178
                                TextLabel = Instance.new("TextLabel")
                                TextLabel.Size = UDim2.fromOffset(120, 18)
                                TextLabel.BackgroundTransparency = 1
                                TextLabel.Text = string.upper(i46.label)
                                TextLabel.TextColor3 = u56.Palette.Faint
                                TextLabel.FontFace = u56.Font.Bold
                                TextLabel.TextSize = 11
                                TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                                TextLabel.Parent = Frame
                                Frame_2 = Instance.new("Frame")
                                Frame_2.Position = UDim2.fromOffset(0, 20)
                                Frame_2.BackgroundTransparency = 1
                                Frame_2.Parent = Frame
                                UIGridLayout = Instance.new("UIGridLayout")
                                UIGridLayout.CellSize = UDim2.fromOffset(u115, u115)
                                UIGridLayout.CellPadding = UDim2.fromOffset(6, 6)
                                UIGridLayout.FillDirectionMaxCells = 8
                                UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
                                UIGridLayout.Parent = Frame_2
                                v21 = {}
                                Items = Config.Wearable.Items
                                v3 = nil
                                v4 = nil
                                local dispatchExit14 = nil

                                for i47, i48 in Items, v3, v4 do
                                    local dispatch14 = 102

                                    while true do
                                        if not (dispatch14 < 103) then
                                            if not (dispatch14 < 104) then
                                                table.insert(v21, i47)
                                                break
                                            end

                                            if not (0 < (u185[i47] or 0)) then
                                                break
                                            else
                                                dispatch14 = 104
                                            end
                                        elseif i48.slot ~= i46.id then
                                            break
                                        else
                                            dispatch14 = 103
                                        end
                                    end

                                    if dispatchExit14 then
                                        break
                                    end
                                end

                                dispatch13 = 106
                            else
                                table.sort(v21)

                                dispatch13 = if u187[i46.id] == nil then 108 else 107
                            end
                        elseif dispatch13 < 109 then
                            u116 = not (dispatch13 < 108)
                            dispatch13 = 109
                        elseif dispatch13 < 110 then
                            Frame_3 = Instance.new("Frame")
                            Frame_3.Size = UDim2.fromOffset(u115, u115)
                            Frame_3.BackgroundColor3 = Color3.fromRGB(22, 25, 32)
                            Frame_3.BackgroundTransparency = 0.45
                            Frame_3.BorderSizePixel = 0
                            Frame_3.LayoutOrder = 0
                            Frame_3.Parent = Frame_2
                            UICorner = Instance.new("UICorner")
                            UICorner.CornerRadius = UDim.new(0, 6)
                            UICorner.Parent = Frame_3
                            UIStroke = Instance.new("UIStroke")
                            UIStroke.Thickness = 2
                            UIStroke.Color = u233
                            UIStroke.Transparency = 0.55
                            UIStroke.Parent = Frame_3
                            UIStroke_2 = Frame_3:FindFirstChildOfClass("UIStroke")
                            dispatch13 = if not u116 then 112 else 110
                        else
                            dispatch13 = if not UIStroke_2 then 112 else 111
                        end
                    elseif dispatch13 < 114 then
                        if dispatch13 < 112 then
                            UIStroke_2.Thickness = 3
                            UIStroke_2.Color = u56.Palette.Green
                            UIStroke_2.Transparency = 0
                            dispatch13 = 112
                        elseif dispatch13 < 113 then
                            TextButton = Instance.new("TextButton")
                            TextButton.Name = "WearNothing"
                            TextButton.Size = UDim2.fromScale(1, 1)
                            TextButton.BackgroundTransparency = 1
                            TextButton.Text = "None"
                            dispatch13 = if not u116 then 114 else 113
                        else
                            Green = u56.Palette.Green
                            dispatch13 = 115
                        end
                    elseif not (dispatch13 < 121) then
                        if not (dispatch13 < 123) then
                            v21 = math.max(1, (math.ceil(v5 / 8)))
                            v5 = v21 * u115 + (v21 - 1) * 6
                            Frame_2.Size = UDim2.new(1, 0, 0, v5)
                            Frame.Size = UDim2.new(1, -12, 0, v5 + 22)
                            v1 = v1 + (v5 + 30)
                            break
                        end

                        v5 = math.max(8, #v21 + 1)
                        v8 = #v21 + 1
                        v6 = v5 - 1
                        local dispatchExit16 = nil

                        for i51 = v8, v6 do
                            Frame_4 = Instance.new("Frame")
                            Frame_4.Size = UDim2.fromOffset(u115, u115)
                            Frame_4.BackgroundColor3 = Color3.fromRGB(22, 25, 32)
                            Frame_4.BackgroundTransparency = 0.45
                            Frame_4.BorderSizePixel = 0
                            Frame_4.LayoutOrder = i51
                            Frame_4.Parent = Frame_2
                            UICorner_2 = Instance.new("UICorner")
                            UICorner_2.CornerRadius = UDim.new(0, 6)
                            UICorner_2.Parent = Frame_4
                            UIStroke_3 = Instance.new("UIStroke")
                            UIStroke_3.Thickness = 2
                            UIStroke_3.Color = u233
                            UIStroke_3.Transparency = 0.55
                            UIStroke_3.Parent = Frame_4
                        end

                        if not dispatchExit16 then end

                        dispatch13 = 123
                    elseif dispatch13 < 115 then
                        Green = u56.Palette.Dim
                        dispatch13 = 115
                    else
                        TextButton.TextColor3 = Green
                        TextButton.FontFace = u56.Font.Bold
                        TextButton.TextSize = 12
                        TextButton.Parent = Frame_3

                        TextButton.Activated:Connect(
                            ((function(u116) -- upvalues: u104 (upval), i46 (val)
                                return function() -- Line: 1527; upvalues: u116 (val), u104 (upval), i46 (val)
                                    if not u116 then
                                        u104:FireServer(i46.id, nil)
                                    end
                                end
                            end)(u116))
                        )

                        v5 = v21
                        v6 = nil
                        v7 = nil
                        local dispatchExit15 = nil

                        for i49, i50 in v5, v6, v7 do
                            local u300
                            local dispatch15 = 116

                            while true do
                                if not (dispatch15 < 118) then
                                    if not (dispatch15 < 119) then
                                        local u312 = buildSlot(Frame_2, i50, -1, i49, u300)
                                        TextButton_2 = Instance.new("TextButton")
                                        TextButton_2.Size = UDim2.fromScale(1, 1)
                                        TextButton_2.BackgroundTransparency = 1
                                        TextButton_2.Text = ""
                                        TextButton_2.Parent = u312

                                        TextButton_2.Activated:Connect(
                                            ((function(u300) -- upvalues: u104 (upval), i46 (val), i50 (val)
                                                return function()
                                                    -- Line: 1541
                                                    -- upvalues: u104 (upval), i46 (val), u300 (val), i50 (val)
                                                    u104:FireServer(i46.id, if not u300 then i50 else nil)
                                                end
                                            end)(u300))
                                        )

                                        TextButton_2.MouseEnter:Connect(function()
                                            -- Line: 1544
                                            -- upvalues: showTooltip (upval), i50 (val), u312 (val)
                                            showTooltip(i50, u312)
                                        end)

                                        TextButton_2.MouseLeave:Connect(u153)
                                        break
                                    end

                                    u300 = true
                                    dispatch15 = 119
                                elseif dispatch15 < 117 then
                                    dispatch15 = if u187[i46.id] == i50 then 118 else 117
                                else
                                    u300 = false
                                    dispatch15 = 119
                                end
                            end

                            if dispatchExit15 then
                                break
                            end
                        end

                        dispatch13 = 121
                    end
                end

                if dispatchExit13 then
                    break
                end
            end

            dispatch = 125
        end
    end
end

function u208()
    -- Line: 1575
    -- upvalues: u201 (ref), HotbarController (val), u199 (val), u198 (ref), u200 (val), u185 (ref), u115 (val)
    -- upvalues: u56 (val), u118 (val), u121 (val), ItemIcon (val), StackKey (val), Palette (val), u21 (val), u206 (ref)
    -- upvalues: u245 (val), showTooltip (val), u257 (ref), u240 (val), u153 (ref), u208 (ref), u210 (ref)
    -- upvalues: ControlGlyphs (val), highlightEmptyCells (val), highlightHotbar (val), u205 (ref), u207 (ref)
    -- upvalues: u202 (ref), zero (ref), u255 (ref), Config (val), showDrag (val)
    local Count, Frame_2, TextLabel, TextLabel_2, TextLabel_3, UICorner, v1, v2
    u201 = nil
    local FirstFreeSlot = HotbarController.FirstFreeSlot
    local TotalSlots = HotbarController.TotalSlots

    for i = FirstFreeSlot, TotalSlots do
        local u13 = HotbarController.itemAt(i)
        v1 = u199[i]

        if not v1 or v1.Parent ~= u198 or u200[i] ~= u13 then
            if v1 then
                v1:Destroy()
            end

            u200[i] = u13
            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.fromOffset(u115, u115)
            Frame.Position = UDim2.fromOffset((i - 1) * (u115 + 6), 0)
            Frame.BackgroundColor3 = Color3.fromRGB(26, 29, 36)
            Frame.BackgroundTransparency = 0.15
            Frame.BorderSizePixel = 0
            Frame.Active = true
            Frame.Parent = u198
            UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 6)
            UICorner.Parent = Frame
            local UIStroke = Instance.new("UIStroke")
            UIStroke.Thickness = 2
            UIStroke.Color = Color3.fromRGB(16, 18, 24)
            UIStroke.Parent = Frame
            TextLabel = Instance.new("TextLabel")
            TextLabel.Size = UDim2.fromOffset(14, 12)
            TextLabel.Position = UDim2.fromOffset(4, 3)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Text = tostring(i)
            TextLabel.TextColor3 = Color3.fromRGB(120, 132, 152)
            TextLabel.FontFace = u56.Font.Bold
            TextLabel.TextSize = 11
            TextLabel.Parent = Frame

            if u13 then
                Frame_2 = Instance.new("Frame")
                Frame_2.Size = UDim2.fromOffset(u118, u118)
                Frame_2.Position = UDim2.new(0.5, -u118 / 2, 0, u121)
                Frame_2.BackgroundTransparency = 1
                Frame_2.Parent = Frame

                ItemIcon.render(Frame_2, StackKey.item(u13), u118, 3)

                TextLabel_2 = Instance.new("TextLabel")
                TextLabel_2.Name = "Count"
                TextLabel_2.Size = UDim2.fromOffset(u115 - 8, 12)
                TextLabel_2.Position = UDim2.fromOffset(4, 3)
                TextLabel_2.BackgroundTransparency = 1
                TextLabel_2.Text = ("x%*"):format(u185[u13] or 0)
                TextLabel_2.TextColor3 = u56.Palette.Gold
                TextLabel_2.FontFace = u56.Font.Bold
                TextLabel_2.TextSize = 12
                TextLabel_2.TextXAlignment = Enum.TextXAlignment.Right
                TextLabel_2.Parent = Frame
                TextLabel_3 = Instance.new("TextLabel")
                TextLabel_3.Size = UDim2.new(1, -6, 0, 22)
                TextLabel_3.Position = UDim2.new(0, 3, 1, -24)
                TextLabel_3.BackgroundTransparency = 1
                TextLabel_3.Text = Palette.displayName(StackKey.item(u13))
                TextLabel_3.TextColor3 = Color3.fromRGB(210, 215, 228)
                TextLabel_3.TextSize = 10
                TextLabel_3.FontFace = u56.Font.Regular
                TextLabel_3.TextWrapped = true
                TextLabel_3.TextTruncate = Enum.TextTruncate.AtEnd

                if u21 then
                    TextLabel_3.Size = UDim2.new(1, -4, 0, 12)
                    TextLabel_3.Position = UDim2.new(0, 2, 1, -13)
                    TextLabel_3.TextSize = 9
                    TextLabel_3.TextWrapped = false
                end

                TextLabel_3.Parent = Frame
            end

            Frame.MouseEnter:Connect(function()
                -- Line: 1687
                -- upvalues: u201 (upval), i (val), UIStroke (val), u206 (upval), u56 (upval), u245 (upval)
                -- upvalues: showTooltip (upval), u13 (val), Frame (val)
                u201 = i
                UIStroke.Color = if not u206 then u245 else u56.Palette.Green
                UIStroke.Transparency = 0

                showTooltip(u13, Frame)
            end)

            Frame.MouseLeave:Connect(function()
                -- Line: 1694
                -- upvalues: u201 (upval), i (val), UIStroke (val), u257 (upval), u56 (upval), u240 (upval)
                -- upvalues: u153 (upval)
                if u201 == i then
                    u201 = nil
                end

                UIStroke.Color = if not u257 then u240 else u56.Palette.Green
                UIStroke.Transparency = if not u257 then 0 else 0.45

                u153()
            end)

            Frame.InputBegan:Connect(function(a1)
                -- Line: 1705
                -- upvalues: u13 (val), HotbarController (upval), i (val), u208 (upval), u210 (upval)
                -- upvalues: ControlGlyphs (upval), highlightEmptyCells (upval), highlightHotbar (upval), u205 (upval)
                -- upvalues: u206 (upval), u207 (upval), u257 (upval), u202 (upval), zero (upval), u255 (upval)
                -- upvalues: Config (upval), showDrag (upval)
                if a1.UserInputType == Enum.UserInputType.MouseButton2 then
                    if u13 then
                        HotbarController.assign(i, nil)
                        u208()
                        u210()
                    end

                    return
                end

                if a1.UserInputType ~= Enum.UserInputType.MouseButton1
                    and a1.UserInputType ~= Enum.UserInputType.Touch then
                    return
                end

                if u13 and ControlGlyphs.bulkHeld() then
                    HotbarController.assign(i, nil)
                    u208()
                    u210()

                    return
                end

                local v1 = HotbarController.pending()

                if v1 then
                    HotbarController.assign(i, v1)
                    HotbarController.setPending(nil)
                    u208()
                    u210()

                    return
                end

                if u13 then
                    local u47 = u13
                    local v2 = Vector2.new(a1.Position.X, a1.Position.Y)

                    highlightEmptyCells(false)
                    highlightHotbar(false)

                    if u205 then
                        u205:Destroy()

                        u205 = nil
                    end

                    u206 = nil
                    u207 = nil
                    u257 = false
                    u202 = nil
                    u206 = u47
                    u207 = i
                    zero = v2
                    u255 = u255 + 1
                    local u78 = u255

                    task.delay(
                        Config.Appearance.Backpack.DragHoldSeconds,
                        function()
                            -- Line: 763
                            -- upvalues: u206 (upval), u47 (val), u255 (upval), u78 (val), u257 (upval)
                            -- upvalues: showDrag (upval), zero (upval)
                            if u206 == u47 and u255 == u78 and not u257 then
                                showDrag(zero)
                            end
                        end
                    )
                end
            end)

            u199[i] = Frame
        else
            Count = v1:FindFirstChild("Count")

            if u13 and Count and Count:IsA("TextLabel") then
                v2 = ("x%*"):format(u185[u13] or 0)

                if Count.Text ~= v2 then
                    Count.Text = v2
                end
            end
        end
    end

    highlightHotbar(u257)
end

local u294 = false
local u295 = nil
local u296 = nil

local function showTab(a1)
    -- Line: 1775
    -- upvalues: u196 (ref), u213 (ref), u177 (ref), u178 (ref), u296 (ref), u184 (ref), u179 (ref), u56 (val)
    -- upvalues: rebuildEquipment (val), u210 (ref)
    -- types: a1: string
    local Gold, OnGold, v1, v2
    u196 = a1
    u213 = if a1 == "Equipment" then nil else if a1 ~= "All" then a1 else nil
    u177.Visible = not v1
    u178.Visible = v1

    u296()

    u184.Visible = false
    local v3 = nil
    local v4 = nil

    for i, j in u179, v3, v4 do
        Gold = if not (i == a1) then u56.Palette.Track else u56.Palette.Gold
        j.BackgroundColor3 = Gold
        OnGold = if not v2 then u56.Palette.Dim else u56.Palette.OnGold
        j.TextColor3 = OnGold
    end

    if v1 then
        rebuildEquipment()
        return
    end

    u210()
end

function u296() -- Line: 1801; upvalues: u196 (ref), u21 (val), u183 (ref), u180 (ref), u294 (ref), u295 (ref)
    local v1 = u196 == "Equipment"

    if not u21 then
        u183.Visible = not v1
        u180.Visible = true

        return
    end

    local v2 = u294 and not v1
    u183.Visible = v2
    u180.Visible = not v2
    local v3 = u295

    if v3 then
        v3.Visible = not v1
        v3.Text = if not v2 then "🔍" else "X"
    end
end

local function u300(a1)
    -- Line: 1819
    -- upvalues: u294 (ref), showTab (val), u183 (ref), u296 (ref)
    -- types: a1: boolean
    u294 = a1

    if a1 then
        showTab("All")
        u183:CaptureFocus()

        return
    end

    u183.Text = ""
    u183:ReleaseFocus()
    u296()
end

local u301 = {}

function u87.onVisibleChanged(a1) -- Line: 1839; upvalues: u301 (val); types: a1: function
    table.insert(u301, a1)
end

local function setVisible(a1)
    -- Line: 1843
    -- upvalues: u153 (ref), NewBadges (val), u149 (ref), u56 (val), u301 (val), BuildController (val)
    -- upvalues: HotbarController (val), u208 (ref), rebuildTabs (ref), showTab (val), u196 (ref)
    -- upvalues: highlightEmptyCells (val), highlightHotbar (val), u205 (ref), u206 (ref), u207 (ref), u257 (ref)
    -- upvalues: u183 (ref), u294 (ref), u296 (ref)
    -- types: a1: boolean
    if not a1 then
        u153()
        NewBadges.markItemsSeen()
    end

    u149.Visible = a1

    if a1 then
        u56.appear(u149)
    end

    for i, j in u301 do
        task.spawn(j, a1)
    end

    BuildController.setUiOpen("Backpack", a1)
    HotbarController.setBarVisible(not a1)

    if a1 then
        u208()
        rebuildTabs()
        showTab(u196)

        return
    end

    highlightEmptyCells(false)
    highlightHotbar(false)

    if u205 then
        u205:Destroy()

        u205 = nil
    end

    u206 = nil
    u207 = nil
    u257 = false

    HotbarController.setPending(nil)

    u183.Text = ""
    u183:ReleaseFocus()

    u294 = false
    u296()
end

function u87.isOpen() -- Line: 1881; upvalues: u149 (ref)
    local Visible = false

    if u149 ~= nil then
        Visible = u149.Visible
    end

    return Visible
end

function u87.toggle() -- Line: 1885; upvalues: setVisible (val), u149 (ref)
    setVisible(not u149.Visible)
end

function u87.close() -- Line: 1889; upvalues: setVisible (val)
    setVisible(false)
end

local u315 = u56.tap(26)

local function buildTab(a1, a2, a3)
    -- Line: 1913
    -- upvalues: u315 (val), u56 (val), u180 (ref), showTab (val), u179 (ref)
    -- types: a1: string, a2: string, a3: number
    local TextButton = Instance.new("TextButton")
    TextButton.AutomaticSize = Enum.AutomaticSize.X
    TextButton.Size = UDim2.fromOffset(0, u315)
    TextButton.LayoutOrder = a3
    TextButton.BackgroundColor3 = u56.Palette.Track
    TextButton.TextColor3 = u56.Palette.Dim
    TextButton.FontFace = u56.Font.Bold
    TextButton.TextSize = u56.tapText(12)
    TextButton.Text = a2
    TextButton.AutoButtonColor = false
    TextButton.Parent = u180
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = TextButton
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 12)
    UIPadding.PaddingRight = UDim.new(0, 12)
    UIPadding.Parent = TextButton

    TextButton.Activated:Connect(function() -- Line: 1936; upvalues: showTab (upval), a1 (val)
        showTab(a1)
    end)

    u179[a1] = TextButton
end

local function buildTabs(a1) -- Line: 1943; upvalues: buildTab (val), u146 (val); types: a1: table
    local v1
    buildTab("All", "ALL", 1)

    local v2 = 1
    local v3 = nil
    local v4 = nil

    for i, j in a1, v3, v4 do
        v2 = v2 + 1
        v1 = u146[j] or string.upper(j)

        buildTab(j, v1, v2)
    end

    buildTab("Equipment", "EQUIPMENT", v2 + 1)
end

local u318 = nil

function rebuildTabs()
    -- Line: 1965
    -- upvalues: u185 (ref), StackKey (val), u139 (val), Config (val), HotbarController (val), Categories (val)
    -- upvalues: u318 (ref), u179 (ref), u180 (ref), buildTabs (val), u196 (ref), showTab (val)
    local v1, v2
    local v3 = {}
    local v4 = nil
    local v5 = nil

    for i, j in u185, v4, v5 do
        if j > 0 then
            v2 = StackKey.item(i)
            v1 = true

            if u139.equipSlotOf(v2) == nil then
                v1 = Config.Wearable.slotOf(v2) ~= nil
            end

            if not v1 and not HotbarController.isOnBar(i) then
                v3[u139.categoryOf(StackKey.item(i)) or "Items"] = true
            end
        end
    end

    local v6 = {}

    for k, n in Categories do
        if v3[n] then
            table.insert(v6, n)
        end
    end

    v4 = table.concat(v6, ",")

    if v4 ~= u318 then
        u318 = v4

        for m, i5 in u180:GetChildren() do
            if i5:IsA("TextButton") then
                i5:Destroy()
            end
        end

        u179 = {}
        buildTabs(v6)
    elseif u179.All == nil then
        u318 = v4

        for i6, i7 in u180:GetChildren() do
            if i7:IsA("TextButton") then
                i7:Destroy()
            end
        end

        u179 = {}
        buildTabs(v6)
    elseif u179.All.Parent ~= u180 then
        u318 = v4

        for i8, i9 in u180:GetChildren() do
            if i9:IsA("TextButton") then
                i9:Destroy()
            end
        end

        u179 = {}
        buildTabs(v6)
    end

    if u196 ~= "All" and u196 ~= "Equipment" and not v3[u196] then
        showTab("All")
    end
end

local u320 = u125 + 470

local function layoutPanel(a1)
    -- Line: 2019
    -- upvalues: u56 (val), GuiService (val), u149 (ref), u320 (val)
    -- types: a1: number
    local v1

    if u56.TouchOnly then
        local CurrentCamera = workspace.CurrentCamera
        v1 = (if not CurrentCamera then 393 else CurrentCamera.ViewportSize.Y)
            - (GuiService:GetGuiInset()).Y
            - 16
        u149.Size = UDim2.fromOffset(a1, v1)
        u149.Position = UDim2.new(0.5, -(a1 / 2), 0, 8)

        return
    end

    local CurrentCamera_2 = workspace.CurrentCamera
    local v2 = (if not CurrentCamera_2 then 720 else CurrentCamera_2.ViewportSize.Y)
        / u56.layerScale(u149)
        - 56
        - 132
    v1 = math.max(math.min(u320, v2), 300)
    u149.Size = UDim2.fromOffset(a1, v1)
    u149.Position = UDim2.new(0.5, -(a1 / 2), 0, math.max(0, (v2 - v1) / 2) + 56)
end

function u87.start()
    -- Line: 2045
    -- upvalues: BuildController (val), u87 (val), PanelTabs (val), u179 (ref), u196 (ref), showTab (val), u148 (ref)
    -- upvalues: LocalPlayer (val), u204 (ref), u115 (val), u149 (ref), u56 (val), layoutPanel (val), u150 (ref)
    -- upvalues: u151 (ref), u152 (ref), placeTooltip (val), u21 (val), u295 (ref), u300 (ref), u294 (ref), u315 (val)
    -- upvalues: u180 (ref), u183 (ref), u197 (ref), u210 (ref), u184 (ref), u182 (ref), u177 (ref), u125 (val)
    -- upvalues: u178 (ref), HotbarController (val), u198 (ref), u118 (val), u121 (val), u209 (ref), u186 (ref)
    -- upvalues: u126 (val), ItemIcon (val), UserInputService (val), u206 (ref), u257 (ref), zero (ref), Config (val)
    -- upvalues: showDrag (val), u205 (ref), finishDrag (val), u92 (val), u185 (ref), u140 (ref), StackKey (val)
    -- upvalues: u93 (ref), u94 (ref), u195 (ref), u208 (ref), rebuildTabs (ref), u98 (val), u193 (ref)
    -- upvalues: rebuildEquipment (val), u113 (val), u188 (ref), u189 (ref), u107 (val), u187 (ref)
    local Frame, TextLabel_2
    BuildController.registerMenu("Backpack", u87.close)

    PanelTabs.register(
        u87.isOpen,
        function(a1) -- Line: 2049; upvalues: u179 (upval), PanelTabs (upval), u196 (upval), showTab (upval)
            local v1 = {}

            for i in u179 do
                table.insert(v1, i)
            end

            table.sort(
                v1,
                function(a1, a2) -- Line: 2054; upvalues: u179 (upval)
                    return u179[a1].LayoutOrder < u179[a2].LayoutOrder
                end
            )

            local v2 = PanelTabs.neighbour(v1, u196, a1)

            if v2 then
                showTab(v2)
            end
        end
    )

    u148 = Instance.new("ScreenGui")
    u148.Name = "AboveBackpack"
    u148.ResetOnSpawn = false
    u148.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u204 = Instance.new("ScreenGui")
    u204.Name = "AboveDrag"
    u204.ResetOnSpawn = false
    u204.IgnoreGuiInset = true
    u204.DisplayOrder = 50
    u204.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local u48 = math.floor((u115 * 8 + 54 + 12) * 1.12)
    u149 = Instance.new("Frame")
    u149.ClipsDescendants = true
    u149.BackgroundColor3 = u56.Palette.Card
    u149.BackgroundTransparency = 0
    u149.Visible = false
    u149.Active = false
    u149.Parent = u148

    layoutPanel(u48)
    u56.fitToScreen(u149)

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        (CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(function()
            -- Line: 2112
            -- upvalues: layoutPanel (upval), u48 (val)
            layoutPanel(u48)
        end)
    end

    u56.onLayerScaleChanged(function() -- Line: 2116; upvalues: layoutPanel (upval), u48 (val)
        layoutPanel(u48)
    end)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = u149
    u150 = Instance.new("Frame")
    u150.Size = UDim2.fromOffset(260, 86)
    u150.BackgroundColor3 = Color3.fromRGB(14, 16, 21)
    u150.BackgroundTransparency = 0.05
    u150.BorderSizePixel = 0
    u150.Visible = false
    u150.ZIndex = 20
    u150.Active = false
    u150.Parent = u149
    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.CornerRadius = UDim.new(0, 6)
    UICorner_2.Parent = u150
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(64, 70, 88)
    UIStroke.Parent = u150
    u151 = Instance.new("TextLabel")
    u151.Size = UDim2.new(1, -20, 0, 18)
    u151.Position = UDim2.fromOffset(10, 8)
    u151.BackgroundTransparency = 1
    u151.TextColor3 = u56.Palette.Gold
    u151.RichText = true
    u151.FontFace = u56.Font.Bold
    u151.TextSize = 13
    u151.TextXAlignment = Enum.TextXAlignment.Left
    u151.ZIndex = 21
    u151.Parent = u150
    u152 = Instance.new("TextLabel")
    u152.Size = UDim2.new(1, -20, 1, -32)

    ;(u152:GetPropertyChangedSignal("TextBounds")):Connect(placeTooltip)

    u152.Position = UDim2.fromOffset(10, 26)
    u152.BackgroundTransparency = 1
    u152.TextColor3 = Color3.fromRGB(196, 203, 220)
    u152.FontFace = u56.Font.Regular
    u152.TextSize = 12
    u152.TextXAlignment = Enum.TextXAlignment.Left
    u152.TextYAlignment = Enum.TextYAlignment.Top
    u152.TextWrapped = true
    u152.RichText = true
    u152.ZIndex = 21
    u152.Parent = u150
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.fromOffset(96, u56.tap(26))
    TextLabel.Position = UDim2.fromOffset(12, 8)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "Backpack"
    TextLabel.TextColor3 = u56.Palette.Gold
    TextLabel.FontFace = u56.Font.Bold
    TextLabel.TextSize = 17
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = u149

    u56.closeButton(u149, 8, u87.close)

    if u21 then
        local TextButton = Instance.new("TextButton")
        u295 = TextButton
        TextButton.Name = "SearchToggle"
        TextButton.Size = UDim2.fromOffset(u56.tap(26), u56.tap(26))
        TextButton.AnchorPoint = Vector2.new(1, 0)
        TextButton.Position = UDim2.new(1, -(10 + u56.tap(26) + 8), 0, 8)
        TextButton.BackgroundColor3 = u56.Palette.Track
        TextButton.BorderSizePixel = 0
        TextButton.Text = "🔍"
        TextButton.TextSize = u56.tapText(14)
        TextButton.FontFace = u56.Font.Bold
        TextButton.TextColor3 = u56.Palette.Dim
        TextButton.AutoButtonColor = true
        TextButton.Parent = u149

        u56.corner(TextButton, 6)

        TextButton.Activated:Connect(function() -- Line: 2208; upvalues: u300 (upval), u294 (upval)
            u300(not u294)
        end)
    end

    local v1 = u56.tap(26)
    local v2 = 8 + u56.tap(26) + 6
    local v3 = if not u21 then v2 + u315 + 6 else v2
    local v4 = if not u21 then v3 + v1 + 6 else v2 + math.max(u315, v1) + 6
    u180 = Instance.new("ScrollingFrame")
    u180.Size = UDim2.new(1, -24, 0, u315)
    u180.Position = UDim2.fromOffset(12, v2)
    u180.BackgroundTransparency = 1
    u180.BorderSizePixel = 0
    u180.ScrollBarThickness = 0
    u180.ScrollingDirection = Enum.ScrollingDirection.X
    u180.AutomaticCanvasSize = Enum.AutomaticSize.X
    u180.CanvasSize = UDim2.new()
    u180.Parent = u149
    v2 = Instance.new("UIListLayout")
    v2.FillDirection = Enum.FillDirection.Horizontal
    v2.Padding = UDim.new(0, 6)
    v2.SortOrder = Enum.SortOrder.LayoutOrder
    v2.Parent = u180
    u183 = Instance.new("TextBox")
    u183.Size = UDim2.new(1, -24, 0, v1)
    u183.Position = UDim2.fromOffset(12, v3)
    u183.Visible = false
    u183.BackgroundColor3 = u56.Palette.Track
    u183.BorderSizePixel = 0
    u183.Text = ""
    u183.PlaceholderText = "Search…"
    u183.PlaceholderColor3 = Color3.fromRGB(110, 120, 140)
    u183.TextColor3 = Color3.fromRGB(226, 232, 244)
    u183.FontFace = u56.Font.Regular
    u183.TextSize = 13
    u183.ClearTextOnFocus = false
    u183.Parent = u149
    v2 = Instance.new("UIPadding")
    v2.PaddingLeft = UDim.new(0, 8)
    v2.PaddingRight = UDim.new(0, 8)
    v2.Parent = u183
    v2 = Instance.new("UICorner")
    v2.CornerRadius = UDim.new(0, 5)
    v2.Parent = u183
    v2 = Instance.new("UIStroke")
    v2.Thickness = 1
    v2.Color = Color3.fromRGB(52, 58, 72)
    v2.Parent = u183

    ;(u183:GetPropertyChangedSignal("Text")):Connect(function()
        -- Line: 2298
        -- upvalues: u197 (upval), u183 (upval), u149 (upval), u196 (upval), u210 (upval)
        u197 = string.lower(u183.Text)

        if u149.Visible and u196 ~= "Equipment" then
            u210()
        end
    end)

    u184 = Instance.new("TextLabel")
    u184.Size = UDim2.new(1, -24, 0, 24)
    u184.Position = UDim2.fromOffset(12, v4 + 20)
    u184.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
    u184.BackgroundTransparency = 0.15
    u184.Text = ""
    u184.TextColor3 = u56.Palette.Faint
    u184.FontFace = u56.Font.Regular
    u184.TextSize = 12
    u184.TextXAlignment = Enum.TextXAlignment.Left
    u184.ZIndex = 5
    u184.Visible = false
    u184.Parent = u149

    u56.corner(u184, 6)

    v2 = Instance.new("UIPadding")
    v2.PaddingLeft = UDim.new(0, 10)
    v2.Parent = u184
    u182 = Instance.new("TextLabel")
    v2 = 10 + 2 * u56.tap(26) + 8 + 8
    u182.Size = UDim2.new(1, -(116 + v2), 0, u56.tap(26))
    u182.Position = UDim2.fromOffset(116, 8)
    u182.TextTruncate = Enum.TextTruncate.AtEnd
    u182.BackgroundTransparency = 1
    u182.Text = ""
    u182.TextColor3 = u56.Palette.Faint
    u182.FontFace = u56.Font.Regular
    u182.TextSize = 12
    u182.TextXAlignment = Enum.TextXAlignment.Left
    u182.Parent = u149
    u177 = Instance.new("ScrollingFrame")
    u177.Size = UDim2.new(1, -12, 1, -(v4 + 8) - u125)
    u177.Position = UDim2.fromOffset(6, v4)
    u177.BackgroundTransparency = 1
    u177.BorderSizePixel = 0
    u177.ScrollBarThickness = 5
    u177.Active = false
    u177.Parent = u149
    v2 = Instance.new("UIGridLayout")
    v2.CellSize = UDim2.fromOffset(u115, u115)
    v2.CellPadding = UDim2.fromOffset(6, 6)
    v2.FillDirectionMaxCells = 8
    v2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v2.SortOrder = Enum.SortOrder.LayoutOrder
    v2.Parent = u177
    v2 = Instance.new("UIPadding")
    v2.PaddingLeft = UDim.new(0, 6)
    v2.PaddingRight = UDim.new(0, 6)
    v2.PaddingTop = UDim.new(0, 6)
    v2.Parent = u177
    u178 = Instance.new("ScrollingFrame")
    u178.Size = UDim2.new(1, -12, 1, -(v4 + 8) - u125)
    u178.Position = UDim2.fromOffset(6, v4)
    u178.BackgroundTransparency = 1
    u178.BorderSizePixel = 0
    u178.ScrollBarThickness = 5
    u178.Visible = false
    u178.Active = false
    u178.Parent = u149
    local TotalSlots = HotbarController.TotalSlots
    v2 = TotalSlots * u115 + (TotalSlots - 1) * 6
    u198 = Instance.new("Frame")
    u198.Size = UDim2.fromOffset(v2, u115)
    u198.Position = UDim2.new(0.5, -v2 / 2, 1, -(u115 + 14))
    u198.BackgroundTransparency = 1
    u198.Parent = u149
    v4 = HotbarController.FirstFreeSlot - 1
    v2 = v4 * u115 + (v4 - 1) * 6
    v3 = Instance.new("Frame")
    v3.Name = "EquipmentSlots"
    v3.Size = UDim2.fromOffset(v2, u115)
    v3.BackgroundTransparency = 1
    v3.Parent = u198
    local u725 = {}

    for i = 1, v4 do
        v1 = Instance.new("Frame")
        v1.Size = UDim2.fromOffset(u115, u115)
        v1.Position = UDim2.fromOffset((i - 1) * (u115 + 6), 0)
        v1.BackgroundColor3 = Color3.fromRGB(26, 29, 36)
        v1.BackgroundTransparency = 0.15
        v1.BorderSizePixel = 0
        v1.Parent = v3

        u56.corner(v1, 6)

        TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Size = UDim2.fromOffset(14, 12)
        TextLabel_2.Position = UDim2.fromOffset(4, 3)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.Text = tostring(i)
        TextLabel_2.TextColor3 = Color3.fromRGB(120, 132, 152)
        TextLabel_2.FontFace = u56.Font.Bold
        TextLabel_2.TextSize = 11
        TextLabel_2.Parent = v1
        Frame = Instance.new("Frame")
        Frame.Size = UDim2.fromOffset(u118, u118)
        Frame.Position = UDim2.new(0.5, -u118 / 2, 0, u121)
        Frame.BackgroundTransparency = 1
        Frame.Parent = v1
        u725[i] = Frame
    end

    local TextButton_2 = Instance.new("TextButton")
    TextButton_2.Name = "OpenEquipment"
    TextButton_2.Size = UDim2.fromScale(1, 1)
    TextButton_2.BackgroundColor3 = Color3.fromRGB(12, 14, 19)
    TextButton_2.BackgroundTransparency = 0.35
    TextButton_2.Text = "EQUIPMENT"
    TextButton_2.TextColor3 = u56.Palette.Gold
    TextButton_2.FontFace = u56.Font.Bold
    TextButton_2.TextSize = 14
    TextButton_2.ZIndex = 3
    TextButton_2.Parent = v3

    u56.corner(TextButton_2, 6)
    u56.stroke(TextButton_2, Color3.fromRGB(70, 62, 30), 1)

    TextButton_2.Activated:Connect(function() -- Line: 2448; upvalues: showTab (upval)
        showTab("Equipment")
    end)

    local u849 = ""

    function u209()
        -- Line: 2453
        -- upvalues: u186 (upval), u849 (ref), u126 (upval), u725 (val), ItemIcon (upval), u118 (upval)
        local v1
        local v2 = table.concat(
            {u186.Weapon or "", u186.Pickaxe or "", u186.Axe or ""},
            "|"
        )

        if v2 == u849 then
            return
        end

        u849 = v2

        for i, j in u126 do
            v2 = u725[i]

            if v2 then
                v2:ClearAllChildren()

                v1 = u186[j]

                if v1 then
                    ItemIcon.render(v2, v1, u118, 3)
                end
            end
        end
    end

    u209()

    UserInputService.InputChanged:Connect(function(a1)
        -- Line: 2474
        -- upvalues: u206 (upval), u257 (upval), zero (upval), Config (upval), showDrag (upval), u205 (upval)
        local v1 = true

        if a1.UserInputType ~= Enum.UserInputType.MouseMovement then
            v1 = a1.UserInputType == Enum.UserInputType.Touch
        end

        if u206 and v1 then
            v1 = Vector2.new(a1.Position.X, a1.Position.Y)

            if not u257 then
                local Magnitude = (v1 - zero).Magnitude

                if Config.Appearance.Backpack.DragThresholdPixels <= Magnitude then
                    showDrag(v1)
                end
            end

            if u205 then
                u205.Position = UDim2.fromOffset(v1.X + 14, v1.Y + 14)
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(a1) -- Line: 2490; upvalues: u206 (upval), finishDrag (upval)
        local v1 = true

        if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
            v1 = a1.UserInputType == Enum.UserInputType.Touch
        end

        if v1 and u206 then
            finishDrag(Vector2.new(a1.Position.X, a1.Position.Y), a1.UserInputType == Enum.UserInputType.Touch)
        end
    end)

    u92.OnClientEvent:Connect(function(a1, a2, a3, a4, a5, a6, a7)
        -- Line: 2501
        -- upvalues: u185 (upval), u140 (upval), StackKey (upval), u93 (upval), u94 (upval), u195 (upval), u149 (upval)
        -- upvalues: u208 (upval), rebuildTabs (upval), showTab (upval), u196 (upval)
        local v1, v2 = StackKey.split(a1, if type(a7) ~= "table" then nil else a7)
        u185 = v1
        u140 = v2
        u93 = if type(a2) ~= "table" then {} else a2
        u94 = if type(a3) ~= "table" then {} else a3

        if type(a4) == "table" then
            v1 = {}
            local v3 = nil
            local v4 = nil

            for i, j in a4, v3, v4 do
                if type(j) == "table" and type(j.ns) == "table" then
                    for k, n in j.ns do
                        table.insert(
                            v1,
                            {
                                itemId = j.itemId,
                                n = n,
                                outcome = j.outcome,
                                perfect = j.perfect,
                                stats = j.stats,
                            }
                        )
                    end
                end
            end

            u195 = v1
        end

        if u149.Visible then
            u208()
            rebuildTabs()
            showTab(u196)
        end
    end)

    u98.OnClientEvent:Connect(function(a1, a2)
        -- Line: 2536
        -- upvalues: u186 (upval), u193 (upval), u209 (upval), u149 (upval), u196 (upval), rebuildEquipment (upval)
        u186 = a1
        u193 = if type(a2) ~= "table" then {} else a2

        u209()

        if u149.Visible and u196 == "Equipment" then
            rebuildEquipment()
        end
    end)

    u113.OnClientEvent:Connect(function(a1)
        -- Line: 2544
        -- upvalues: u188 (upval), u189 (upval), u149 (upval), u210 (upval)
        u188 = {}

        if type(a1) == "table" then
            for i, j in a1 do
                if type(i) == "string" and type(j) == "number" then
                    u188[i] = j
                end
            end
        end

        u189 = true

        if u149.Visible then
            u210()
        end
    end)

    u107.OnClientEvent:Connect(function(a1)
        -- Line: 2558
        -- upvalues: u187 (upval), u149 (upval), u196 (upval), rebuildEquipment (upval)
        u187 = if type(a1) ~= "table" then {} else a1

        if u149.Visible and u196 == "Equipment" then
            rebuildEquipment()
        end
    end)
end

return u87