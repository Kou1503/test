-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.CraftingController
-- Decompile time: 38.11 ms

local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local RunService = game:GetService("RunService")
local DeviceMode = require(script.Parent.DeviceMode)
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Config = require(Shared.Config)
local ItemStats = require(Shared.ItemStats)
local ItemKinds = require(Shared.ItemKinds)
local Palette = require(Shared.Palette)
local Remotes = require(Shared.Remotes)
local u44 = {}
local LocalPlayer = Players.LocalPlayer
local u49 = Remotes.get(Remotes.RequestCraft)
local u52 = Remotes.get(Remotes.RequestHandCraft)
local u55 = Remotes.get(Remotes.RequestLoadFuel)
local u58 = Remotes.get(Remotes.RequestEmptyMachine)
local u61 = Remotes.get(Remotes.RequestStopCrafting)
local u62 = 0
local u65 = Remotes.get(Remotes.MachineUpdate)
local u68 = Remotes.get(Remotes.InventoryChanged)
local u71 = Remotes.get(Remotes.RequestUpgradeInfo)
local u74 = Remotes.get(Remotes.UpgradeInfo)
local u77 = Remotes.get(Remotes.RequestUpgrade)
local u84 = require(script.Parent.Parent.Ui)
local BuildController = require(script.Parent.BuildController)
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local PanelTabs = require(script.Parent.PanelTabs)
local NewBadges = require(script.Parent.NewBadges)
local ItemIcon = require(script.Parent.ItemIcon)
local ItemTooltip = require(script.Parent.ItemTooltip)
local u115 = 1
local u116 = nil
local u117 = nil
local u118 = nil
local u119 = nil
local u120 = nil
local u121 = nil
local u122 = nil
local u123 = nil
local u124 = nil
local u125 = nil
local u126 = nil
local u127 = nil
local u128 = nil
local u129 = nil
local u130 = nil
local u131 = nil
local u132 = nil
local u133 = nil
local u136 = u84.tap(26)
local u137 = false
local u138 = "Nothing here by that name"
local u139 = nil
local u140 = nil
local u141 = nil
local u142 = nil
local u143 = nil
local u144 = false
local u145 = nil
local u146 = nil
local u147 = ""
local u148 = false
local u149 = false
local u150 = false
local u151 = false
local u152 = nil
local u153 = nil
local u154 = nil
local u155 = true
local u156 = nil
local u157 = nil
local u158 = nil
local u159 = nil
local u160 = {}
local u161 = {}
local u162 = nil

local function stripNeeded() -- Line: 144; upvalues: u151 (ref), u162 (ref), u62 (ref)
    local v1 = u151

    if not v1 then
        v1 = true

        if u162 == nil then
            v1 = u62 > 0
        end
    end

    return v1
end

local function refreshProgress()
    -- Line: 148
    -- upvalues: u151 (ref), u162 (ref), u62 (ref), u155 (ref), u154 (ref), u129 (ref), u137 (ref), u119 (ref)
    -- upvalues: u120 (ref), Config (val), NewBadges (val), Palette (val)
    local v1 = u151

    if not v1 then
        v1 = true

        if u162 == nil then
            v1 = u62 > 0
        end
    end

    if v1 ~= u155 then
        u155 = v1
        u154()
    end

    local v2 = u129
    local v3 = not u137

    if v3 then
        v3 = true

        if not (u62 > 0) then
            v3 = u162 ~= nil
        end
    end

    v2.Visible = v3
    v1 = u162

    if not v1 then
        u119.Visible = false
        u120.Size = UDim2.fromScale(0, 1)

        return
    end

    u119.Visible = true
    u119.TextColor3 = Color3.fromRGB(170, 200, 230)
    v2 = math.max(0, v1.endsAt - (os.clock()))
    v3 = if not (u62 > 0) then "" else ("  ·  %* more queued"):format(u62)
    local v4 = Config.Recipe.All[v1.recipeId]
    local v5 = u119
    local v6 = math.ceil(v2)
    v5.Text = ("Crafting %*: %*s left%*"):format(if not v4 then Palette.displayName(v1.recipeId) else if NewBadges.knows(v4.output) then Palette.displayName(v1.recipeId) else "???", v6, v3)
    u120.Size = UDim2.fromScale(1 - v2 / math.max(v1.duration, 0.001), 1)
end

local u166 = DeviceMode.touchOnly()
local u168 = if not u166 then
    {
        rowHeight = 46,
        rowGap = 4,
        icon = 30,
        iconPad = 8,
        nameX = 46,
        nameY = 5,
        nameHeight = 18,
        nameText = 14,
        timeText = 12,
        chipY = 24,
        chipHeight = 18,
        chipText = 12,
        tabHeight = 22,
        tabText = 11,
        titleText = 17,
        headerY = 42,
        headerHeight = 20,
        headerText = 12,
        labelText = 13,
        barY = 64,
        searchY = 70,
        searchHeight = 24,
        searchText = 13,
        gap = 8,
        stopWidth = 74,
        fuelWidth = 84,
        unfuelWidth = 38,
        fuelSlot = 24,
        fuelLabelWidth = 90,
    }
else
    {
        rowHeight = 62,
        rowGap = 6,
        icon = 40,
        iconPad = 11,
        nameX = 60,
        nameY = 7,
        nameHeight = 24,
        nameText = 18,
        timeText = 15,
        chipY = 34,
        chipHeight = 22,
        chipText = 14,
        tabHeight = 36,
        tabText = 14,
        titleText = 20,
        headerY = 50,
        headerHeight = 36,
        headerText = 15,
        labelText = 15,
        barY = 92,
        searchY = 102,
        searchHeight = 38,
        searchText = 16,
        gap = 8,
        stopWidth = 100,
        fuelWidth = 118,
        unfuelWidth = 60,
        fuelSlot = 40,
        fuelLabelWidth = 120,
    }
local rowHeight = u168.rowHeight
local rowGap = u168.rowGap
local tabHeight = u168.tabHeight
local u176 = -(8 + u168.stopWidth)
local u179 = u176 - 4 - u168.fuelWidth
local u182 = u179 - 4 - u168.unfuelWidth
local u185 = u182 - 6 - u168.fuelSlot
local u188 = u185 - 6 - u168.fuelLabelWidth
local u193 = ItemKinds.build(Config)
local u194 = nil
local u195 = nil
local u196 = {}
local u197 = {}
local u199 = {"I", "II", "III", "IV", "V"}
local u209 = Color3.fromRGB(150, 210, 170)
local u214 = Color3.fromRGB(64, 56, 32)
local u219 = Color3.fromRGB(46, 42, 30)

local function escapeRich(a1) -- Line: 311; types: a1: string
    return (string.gsub(string.gsub(string.gsub(a1, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))
end

local function refreshTabs() -- Line: 335; upvalues: u196 (ref), u194 (ref), u84 (val)
    local Gold, OnGold, v1
    local v2 = nil
    local v3 = nil

    for i, j in u196, v2, v3 do
        Gold = if not ((u194 or "\000All") == i) then
            Color3.fromRGB(34, 37, 47)
        else
            u84.Palette.Gold
        j.BackgroundColor3 = Gold
        OnGold = if not v1 then Color3.fromRGB(150, 158, 178) else u84.Palette.OnGold
        j.TextColor3 = OnGold
    end
end

local function refreshRows()
    -- Line: 343
    -- upvalues: u161 (ref), Config (val), u160 (ref), Palette (val), NewBadges (val), u84 (val), u214 (val), u219 (val)
    -- upvalues: u194 (ref), u147 (ref), rowHeight (val), rowGap (val), u130 (ref), u131 (ref), u137 (ref), u138 (ref)
    local NewDot, inputs, name, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    local v11 = {}
    local v12 = nil
    local v13 = nil

    for i, j in u161, v12, v13 do
        v8 = true
        inputs = (Config.Recipe.forDisplay(i)).inputs
        v10 = nil
        v1 = nil

        for k, n in inputs, v10, v1 do
            v2 = Config.Recipe.heldOf(u160, k)
            v3 = n <= v2
            v8 = v8 and v3
            v4 = j.chips[k]

            if v4 then
                if not j.input then
                    v6 = Palette.displayName(k)
                    v4.Text = (" %*/%*  %* "):format(v2, n, v6)
                else
                    v4.Text = (" %*/%* in backpack "):format(v2, n)
                end

                v5 = if not v3 then
                    Color3.fromRGB(230, 160, 160)
                else
                    Color3.fromRGB(170, 220, 180)
                v4.TextColor3 = v5
                v5 = if not v3 then Color3.fromRGB(52, 34, 36) else Color3.fromRGB(34, 50, 40)
                v4.BackgroundColor3 = v5
            end
        end

        j.affordable = v8
        v7 = NewBadges.isNewRecipe(i)
        j.frame.BackgroundColor3 = if not v7 then
            if not j.recommended then
                if not v8 then Color3.fromRGB(30, 32, 38) else Color3.fromRGB(40, 46, 58)
            else
                if not v8 then u219 else u214
        else
            u84.Palette.New
        NewDot = j.frame:FindFirstChild("NewDot")

        if not v7 then
            if not v7 and NewDot then
                NewDot:Destroy()
            end
        elseif not NewDot then
            u84.newDot(j.frame)
        elseif not v7 and NewDot then
            NewDot:Destroy()
        end

        name = j.name
        v1 = if not v8 then Color3.fromRGB(150, 155, 168) else Color3.fromRGB(230, 236, 246)
        name.TextColor3 = v1
        j.frame.AutoButtonColor = v8
        v9 = true

        if u194 ~= nil then
            v9 = j.category == u194
        end

        v7 = if not j.input then true else 0 < (u160[j.input] or 0)
        v10 = v9

        if v10 then
            v10 = v7

            if v10 then
                v10 = true

                if u147 ~= "" then
                    v10 = string.find(j.search, u147, 1, true) ~= nil
                end
            end
        end

        j.frame.Visible = v10

        if v10 then
            table.insert(
                v11,
                {id = i, row = j, ok = v8, pinned = j.recommended}
            )
        end
    end

    table.sort(
        v11,
        function(a1, a2) -- Line: 411
            if a1.pinned ~= a2.pinned then
                return a1.pinned
            end

            if a1.ok ~= a2.ok then
                return a1.ok
            end

            return a1.id < a2.id
        end
    )

    for m, i5 in v11 do
        i5.row.frame.Position = UDim2.fromOffset(6, (m - 1) * (rowHeight + rowGap) + 4)
    end

    u130.CanvasSize = UDim2.fromOffset(0, #v11 * (rowHeight + rowGap) + 8)
    local v14 = u131
    v12 = false

    if #v11 == 0 then
        v12 = not u137
    end

    v14.Visible = v12

    if u131.Visible then
        u131.Text = if u147 == "" then u138 else "Nothing here by that name"
    end
end

local function fitProgress(a1)
    -- Line: 449
    -- upvalues: u188 (val), u176 (val), u119 (ref), u168 (val)
    -- types: a1: boolean
    u119.Size = UDim2.new(1, (if not a1 then u176 else u188) - 20, 0, u168.headerHeight)
    u119.TextTruncate = Enum.TextTruncate.AtEnd
end

local function relayout()
    -- Line: 455
    -- upvalues: u145 (ref), u148 (ref), u166 (val), u150 (ref), u195 (ref), u149 (ref), u152 (ref), u155 (ref)
    -- upvalues: u151 (ref), u162 (ref), u62 (ref), u153 (ref), u168 (val), u132 (ref), u136 (val), u130 (ref)
    -- upvalues: u139 (ref), u131 (ref)
    u145.Visible = u148 and (not u166 or u150)
    u195.Visible = u149 and not (u166 and u150)
    local v1 = u152

    if v1 then
        v1.Visible = u148
        v1.Text = if not u150 then "🔍" else "X"
    end

    local v2 = u151

    if not v2 then
        v2 = true

        if u162 == nil then
            v2 = u62 > 0
        end
    end

    u153.Visible = v2
    local searchY = u168.searchY
    u145.Position = UDim2.fromOffset(12, searchY)

    if u145.Visible then
        searchY = searchY + (u168.searchHeight + u168.gap)
    end

    u195.Position = UDim2.fromOffset(12, searchY)

    if u195.Visible then
        searchY = searchY + (u168.tabHeight + u168.gap)
    end

    v2 = if not u132 then 12 else if not u132.Visible then 12 else u136 + 20
    u130.Position = UDim2.fromOffset(12, searchY)
    u130.Size = UDim2.new(1, if not u139.Visible then -24 else -218, 1, -(searchY + v2))

    if u139 then
        u139.Position = UDim2.new(1, -198, 0, searchY)
        u139.Size = UDim2.new(0, 186, 1, -(searchY + 12))
    end

    u131.Position = UDim2.fromOffset(12, searchY + 6)
end

u154 = relayout

local function buildTabs(a1, a2)
    -- Line: 493
    -- upvalues: u195 (ref), u196 (ref), u197 (ref), u149 (ref), u194 (ref), relayout (val), Config (val), u193 (val)
    -- upvalues: ItemKinds (val), tabHeight (val), u84 (val), u168 (val), refreshTabs (ref), refreshRows (val)
    -- types: a1: table, a2: boolean
    for i, j in u195:GetChildren() do
        if j:IsA("TextButton") then
            j:Destroy()
        end
    end

    u196 = {}
    u197 = {}

    if a2 then
        u149 = false
        u194 = nil

        relayout()

        return
    end

    local v1 = {}

    for k, n in a1 do
        v1[u193.categoryOf((Config.Recipe.forDisplay(n)).output) or "Items"] = true
    end

    local v2 = {}

    for m, i5 in ItemKinds.Categories do
        if v1[i5] then
            table.insert(v2, i5)
        end
    end

    u149 = #v2 > 1
    relayout()

    if not u149 then
        u194 = nil
        return
    end

    local function addTab(a1, a2)
        -- Line: 532
        -- upvalues: tabHeight (upval), u84 (upval), u168 (upval), u195 (upval), u196 (upval), u197 (upval)
        -- upvalues: u194 (upval), refreshTabs (upval), refreshRows (upval)
        -- types: a1: string?, a2: string
        local TextButton = Instance.new("TextButton")
        TextButton.AutomaticSize = Enum.AutomaticSize.X
        TextButton.Size = UDim2.fromOffset(0, tabHeight)
        TextButton.BackgroundColor3 = Color3.fromRGB(34, 37, 47)
        TextButton.BorderSizePixel = 0
        TextButton.Text = a2
        TextButton.TextColor3 = Color3.fromRGB(150, 158, 178)
        TextButton.FontFace = u84.Font.Bold
        TextButton.TextSize = u168.tabText
        TextButton.AutoButtonColor = false
        TextButton.Parent = u195
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = TextButton
        local UIPadding = Instance.new("UIPadding")
        UIPadding.PaddingLeft = UDim.new(0, 10)
        UIPadding.PaddingRight = UDim.new(0, 10)
        UIPadding.Parent = TextButton
        u196[a1 or "\000All"] = TextButton

        table.insert(u197, a1 or "\000All")

        TextButton.Activated:Connect(function()
            -- Line: 556
            -- upvalues: u194 (upval), a1 (val), refreshTabs (upval), refreshRows (upval)
            u194 = a1
            refreshTabs()
            refreshRows()
        end)
    end

    addTab(nil, "ALL")

    for i6, i7 in v2 do
        addTab(i7, string.upper(i7))
    end

    refreshTabs()
end

local function buildList(a1)
    -- Line: 570
    -- upvalues: u130 (ref), u161 (ref), Config (val), u115 (ref), LocalPlayer (val), NewBadges (val), Palette (val)
    -- upvalues: rowHeight (val), u146 (ref), u168 (val), ItemIcon (val), u84 (val), u157 (ref), u156 (ref), u52 (val)
    -- upvalues: ControlGlyphs (val), u49 (val), u193 (val), u138 (ref), rowGap (val), buildTabs (val)
    -- upvalues: refreshRows (val)
    -- types: a1: string
    local Frame, Frame_2, Recommended, TextLabel, TextLabel_2, TextLabel_3, UICorner, UICorner_2, v1, v2, v3, v4, v5,
        v6, v7, v8, v9, v10, v11
    local v12 = a1

    for i, j in u130:GetChildren() do
        if j:IsA("TextButton") or j.Name == "AutoNote" then
            j:Destroy()
        end
    end

    u161 = {}
    local v13 = Config.Recipe.converterInputs(v12)
    local v14 = {}

    for k, n in Config.Recipe.All do
        if n.workbenchTier <= u115
            and table.find(n.stations, v12)
            and Config.Release.mayCraft(LocalPlayer, n.output)
            and n.family == nil
            and NewBadges.knows(n.output) then
            table.insert(v14, k)
        end
    end

    for m, i5 in Config.Recipe.Families do
        if i5.workbenchTier <= u115
            and table.find(i5.stations, v12)
            and Config.Release.mayCraft(LocalPlayer, i5.output) then
            table.insert(v14, m)
        end
    end

    table.sort(v14)

    local v15 = v14
    local v16 = nil
    local v17 = nil

    for i6, i7 in v15, v16, v17 do
        v10 = Config.Recipe.forDisplay(i7)
        v11 = nil

        if v13 then
            for i8 in v10.inputs do
                v11 = i8
                break
            end
        end

        v1 = if not (1 < v10.outputCount) then "" else ("  x%*"):format(v10.outputCount)

        if not v11 then
            v2 = ("%*%*"):format(Palette.displayName(v10.output), v1)
        else
            v3 = v10.inputs[v11] or 1
            v8 = Palette.displayName(v11)
            v9 = Palette.displayName(v10.output)
            v2 = ("%*%*   »   %*%*"):format(if not (v3 > 1) then "" else ("x%* "):format(v3), v8, v9, v1)
        end

        v1 = Instance.new("TextButton")
        v1.Size = UDim2.new(1, -12, 0, rowHeight)
        v1.BackgroundColor3 = Color3.fromRGB(40, 46, 58)
        v1.BorderSizePixel = 0
        v1.Text = ""
        v1.AutoButtonColor = true
        v1.Parent = u130

        u146.attach(v1, v10.output)

        UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = v1
        Frame = Instance.new("Frame")
        Frame.Size = UDim2.fromOffset(u168.icon, u168.icon)
        Frame.Position = UDim2.fromOffset(u168.iconPad, u168.iconPad)
        Frame.BackgroundTransparency = 1
        Frame.Parent = v1

        ItemIcon.render(Frame, v11 or v10.output, u168.icon, 4)

        TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, -140, 0, u168.nameHeight)
        TextLabel.Position = UDim2.fromOffset(u168.nameX, u168.nameY)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = v2
        TextLabel.FontFace = u84.Font.Bold
        TextLabel.TextSize = u168.nameText
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.Parent = v1
        TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Size = UDim2.fromOffset(60, u168.nameHeight)
        TextLabel_2.Position = UDim2.new(1, -68, 0, u168.nameY)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.Text = ("%*s"):format((math.floor((Config.Factory.craftSeconds(u157, v10.timeSeconds)) * 10 + 0.5)) / 10)
        TextLabel_2.TextColor3 = Color3.fromRGB(130, 145, 170)
        TextLabel_2.FontFace = u84.Font.Regular
        TextLabel_2.TextSize = u168.timeText
        TextLabel_2.TextXAlignment = Enum.TextXAlignment.Right
        TextLabel_2.Parent = v1
        Frame_2 = Instance.new("Frame")
        Frame_2.Size = UDim2.new(1, -(u168.nameX + 8), 0, u168.chipHeight)
        Frame_2.Position = UDim2.fromOffset(u168.nameX, u168.chipY)
        Frame_2.BackgroundTransparency = 1
        Frame_2.Parent = v1
        v4 = Instance.new("UIListLayout")
        v4.FillDirection = Enum.FillDirection.Horizontal
        v4.Padding = UDim.new(0, 4)
        v4.SortOrder = Enum.SortOrder.Name
        v4.Parent = Frame_2
        v4 = {}

        for i9 in v10.inputs do
            table.insert(v4, i9)
        end

        table.sort(v4)

        v6 = {}
        v7 = v4

        for i10, i11 in v7 do
            TextLabel_3 = Instance.new("TextLabel")
            TextLabel_3.Name = i11
            TextLabel_3.AutomaticSize = Enum.AutomaticSize.X
            TextLabel_3.Size = UDim2.fromOffset(0, u168.chipHeight)
            TextLabel_3.BackgroundColor3 = Color3.fromRGB(34, 50, 40)
            TextLabel_3.BorderSizePixel = 0
            TextLabel_3.Text = ""
            TextLabel_3.FontFace = u84.Font.Regular
            TextLabel_3.TextSize = u168.chipText
            TextLabel_3.Parent = Frame_2
            UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(0, 4)
            UICorner_2.Parent = TextLabel_3
            v6[i11] = TextLabel_3
        end

        v1.Activated:Connect(function()
            -- Line: 729
            -- upvalues: u156 (upval), u52 (upval), i7 (val), ControlGlyphs (upval), u49 (upval), Config (upval)
            if u156 == "hand" then
                u52:FireServer(i7)
                return
            end

            if u156 then
                u49:FireServer(u156, i7, if not (ControlGlyphs.bulkHeld()) then 1 else Config.Recipe.QueueMax)
            end
        end)

        Recommended = Config.Recipe.Recommended
        v4 = if v11 then
            nil
        else
            if not (u115 < Recommended.BelowTier) then
                nil
            else
                Recommended.Items[v10.output]

        if v4 then
            TextLabel.RichText = true
            TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
            v5 = math.floor(u168.nameText * 0.8)
            v7 = string.gsub(string.gsub(string.gsub(v4, "&", "&amp;"), "<", "&lt;"), ">", "&gt;")
            TextLabel.Text = ("%*  <font color=\"#E6C46A\" size=\"%*\">%*</font>"):format(string.gsub(string.gsub(string.gsub(v2, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"), v5, v7)
        end

        v7 = u161
        v8 = {
            affordable = true,
            recommended = v4 ~= nil,
            frame = v1,
            name = TextLabel,
            chips = v6,
            category = u193.categoryOf(v10.output) or "Items",
            input = v11,
            search = string.lower(v2),
        }
        v7[i7] = v8
    end

    if not v13 then
        u138 = "Nothing here by that name"
    else
        v15 = {}

        for i12 in v13 do
            table.insert(v15, (Palette.displayName(i12)))
        end

        table.sort(v15)

        u138 = ("Nothing in your backpack it can use. It takes %*."):format((table.concat(v15, ", ")))
    end

    u130.CanvasSize = UDim2.fromOffset(0, #v14 * (rowHeight + rowGap) + 8)
    buildTabs(v14, v13 ~= nil)
    refreshRows()
end

local function renderUpgrade(a1)
    -- Line: 792
    -- upvalues: u139 (ref), u142 (ref), u140 (ref), u199 (val), u141 (ref), u143 (ref), u144 (ref), u209 (val)
    -- upvalues: u84 (val)
    if u139 and type(a1) == "table" then
        local Frame, Frame_2, TextLabel, TextLabel_2, UICorner, v1, v2, v3, v4, v5

        for i, j in u142:GetChildren() do
            if j:IsA("Frame") then
                j:Destroy()
            end
        end

        local v6 = tonumber(a1.tier) or 1
        u140.Text = ("WORKBENCH %*"):format(u199[v6] or v6)

        if not a1.toTier then
            u141.Text = "Max Workbench"
            u143.Visible = false
            u144 = false

            return
        end

        u141.Text = ("NEXT: WORKBENCH %*"):format(u199[a1.toTier] or a1.toTier)
        v6 = {}

        for k, n in a1.accomplishments or {} do
            table.insert(v6, n)
        end

        for m, i5 in a1.materials or {} do
            table.insert(v6, i5)
        end

        if a1.coins then
            v3 = table.clone(a1.coins)
            v3.last = true

            table.insert(v6, v3)
        end

        table.sort(
            v6,
            function(a1, a2) -- Line: 838
                if a1.met == true ~= (a2.met == true) then
                    return a2.met == true
                end

                if a1.last == true ~= (a2.last == true) then
                    return a2.last == true
                end

                return (tostring(a1.label)) < tostring(a2.label)
            end
        )

        v3 = 0
        local v7 = nil
        local v8 = nil

        for i6, i7 in v6, v7, v8 do
            v5 = if not (i7.met == true) then Color3.fromRGB(255, 214, 110) else u209
            Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, -10, 0, 28)
            Frame.Position = UDim2.fromOffset(0, v3)
            Frame.BackgroundTransparency = 1
            Frame.Parent = u142
            TextLabel = Instance.new("TextLabel")
            TextLabel.Size = UDim2.new(1, -56, 0, 15)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Text = i7.label
            v2 = if not v4 then Color3.fromRGB(238, 240, 248) else Color3.fromRGB(150, 158, 178)
            TextLabel.TextColor3 = v2
            TextLabel.FontFace = u84.Font.Bold
            TextLabel.TextSize = 12
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
            TextLabel.Parent = Frame
            TextLabel_2 = Instance.new("TextLabel")
            TextLabel_2.Size = UDim2.fromOffset(56, 15)
            TextLabel_2.Position = UDim2.new(1, -56, 0, 0)
            TextLabel_2.BackgroundTransparency = 1
            TextLabel_2.Text = if not v4 then ("%* / %*"):format(i7.have, i7.need) else "✅"
            TextLabel_2.TextColor3 = v5
            TextLabel_2.FontFace = u84.Font.Bold
            TextLabel_2.TextSize = if not v4 then 12 else 14
            TextLabel_2.TextXAlignment = Enum.TextXAlignment.Right
            TextLabel_2.Parent = Frame
            Frame_2 = Instance.new("Frame")
            Frame_2.Size = UDim2.new(1, 0, 0, 5)
            Frame_2.Position = UDim2.fromOffset(0, 17)
            Frame_2.BackgroundColor3 = Color3.fromRGB(46, 51, 66)
            Frame_2.BorderSizePixel = 0
            Frame_2.Parent = Frame
            v1 = Instance.new("UICorner")
            v1.CornerRadius = UDim.new(0, 3)
            v1.Parent = Frame_2
            v1 = Instance.new("Frame")
            v2 = math.max(1, (tonumber(i7.need)) or 1)
            v1.Size = UDim2.fromScale(if not v4 then math.clamp((tonumber(i7.have) or 0) / v2, 0, 1) else 1, 1)
            v1.BackgroundColor3 = v5
            v1.BorderSizePixel = 0
            v1.Parent = Frame_2
            UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 3)
            UICorner.Parent = v1
            v3 = v3 + 28
        end

        u142.CanvasSize = UDim2.fromOffset(0, v3)
        u144 = a1.ready == true
        u143.Visible = true
        u143.Text = "UPGRADE"
        local v9 = u143
        v7 = if not u144 then Color3.fromRGB(34, 37, 47) else Color3.fromRGB(44, 78, 50)
        v9.BackgroundColor3 = v7
        v9 = u143
        v7 = if not u144 then Color3.fromRGB(104, 110, 128) else Color3.fromRGB(190, 235, 190)
        v9.TextColor3 = v7
        u143.AutoButtonColor = u144
    end
end

local function buildSidebar()
    -- Line: 925
    -- upvalues: u139 (ref), u168 (val), u117 (ref), u140 (ref), u84 (val), u141 (ref), u142 (ref), u143 (ref)
    -- upvalues: u144 (ref), u77 (val)
    u139 = Instance.new("Frame")
    u139.Size = UDim2.new(0, 186, 1, -104)
    u139.Position = UDim2.new(1, -198, 0, u168.searchY + 30)
    u139.BackgroundColor3 = Color3.fromRGB(28, 31, 40)
    u139.BorderSizePixel = 0
    u139.Visible = false
    u139.Parent = u117
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = u139
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(52, 57, 72)
    UIStroke.Parent = u139
    u140 = Instance.new("TextLabel")
    u140.Size = UDim2.new(1, -20, 0, 18)
    u140.Position = UDim2.fromOffset(10, 10)
    u140.BackgroundTransparency = 1
    u140.Text = ""
    u140.TextColor3 = Color3.fromRGB(255, 226, 130)
    u140.FontFace = u84.Font.Bold
    u140.TextSize = 15
    u140.TextXAlignment = Enum.TextXAlignment.Left
    u140.Parent = u139
    u141 = Instance.new("TextLabel")
    u141.Size = UDim2.new(1, -20, 0, 14)
    u141.Position = UDim2.fromOffset(10, 32)
    u141.BackgroundTransparency = 1
    u141.Text = ""
    u141.TextColor3 = Color3.fromRGB(126, 133, 152)
    u141.FontFace = u84.Font.Bold
    u141.TextSize = 12
    u141.TextXAlignment = Enum.TextXAlignment.Left
    u141.Parent = u139
    u142 = Instance.new("ScrollingFrame")
    u142.Size = UDim2.new(1, -20, 1, -108)
    u142.Position = UDim2.fromOffset(10, 52)
    u142.BackgroundTransparency = 1
    u142.BorderSizePixel = 0
    u142.ScrollBarThickness = 4
    u142.Active = true
    u142.Parent = u139
    u143 = Instance.new("TextButton")
    u143.Size = UDim2.new(1, -20, 0, u84.tap(28))
    u143.Position = UDim2.new(0, 10, 1, -(u84.tap(28) + 10))
    u143.BackgroundColor3 = Color3.fromRGB(44, 78, 50)
    u143.TextColor3 = Color3.fromRGB(190, 235, 190)
    u143.FontFace = u84.Font.Bold
    u143.TextSize = 12
    u143.Text = "UPGRADE"
    u143.AutoButtonColor = false
    u143.Parent = u139
    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.CornerRadius = UDim.new(0, 5)
    UICorner_2.Parent = u143

    u143.Activated:Connect(function() -- Line: 990; upvalues: u144 (upval), u77 (upval)
        if u144 then
            u77:FireServer()
        end
    end)
end

function u44.isOpen() -- Line: 999; upvalues: u117 (ref)
    local Visible = false

    if u117 ~= nil then
        Visible = u117.Visible
    end

    return Visible
end

function u44.close()
    -- Line: 1009
    -- upvalues: u145 (ref), u117 (ref), u161 (ref), NewBadges (val), u156 (ref), u158 (ref), u159 (ref), u146 (ref)
    -- upvalues: BuildController (val)
    if u145 then
        u145:ReleaseFocus()
    end

    if u117.Visible then
        local v1 = {}

        for i in u161 do
            table.insert(v1, i)
        end

        NewBadges.markRecipesSeen(v1)
    end

    u156 = nil
    u158 = nil
    u159 = nil

    u146.hide()

    u117.Visible = false
    BuildController.setUiOpen("Crafting", false)
end

local function closeIfOutOfRange()
    -- Line: 1032
    -- upvalues: u158 (ref), u117 (ref), u44 (val), LocalPlayer (val), Config (val)
    local v1 = u158

    if v1 and u117.Visible then
        if not v1.Parent then
            u44.close()
            return
        end

        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

        if not HumanoidRootPart then
            return
        end

        local Magnitude = (HumanoidRootPart.Position - v1.Position).Magnitude

        if Config.Player.InteractReachStuds + 8 < Magnitude then
            u44.close()
        end
    end
end

function u44.open(a1, a2, a3, a4)
    -- Line: 1051
    -- upvalues: u156 (ref), u157 (ref), u194 (ref), u159 (ref), u158 (ref), u137 (ref), u84 (val), ItemStats (val)
    -- upvalues: Config (val), u118 (ref), Palette (val), u162 (ref), refreshProgress (val), u151 (ref), u121 (ref)
    -- upvalues: u122 (ref), u127 (ref), u128 (ref), u188 (val), u176 (val), u119 (ref), u168 (val), u139 (ref)
    -- upvalues: u71 (val), u147 (ref), u145 (ref), u115 (ref), u148 (ref), u150 (ref), u132 (ref), relayout (val)
    -- upvalues: u117 (ref), BuildController (val), buildList (val), u131 (ref), u130 (ref), LocalPlayer (val)
    -- types: a1: string, a2: string, a3: userdata?, a4: string
    local v1, v2
    u156 = a1
    u157 = a2
    u194 = nil
    u159 = a4
    u158 = a3
    local v3 = false

    if a3 ~= nil then
        v3 = a3:GetAttribute("AutoSelects") == true
    end

    u137 = v3
    v3 = ""

    if a3 then
        v1, v2 = u84.machineRoll(a3)
        v3 = ItemStats.summary(Config, a2, v1, v2)
    end

    v1 = u118
    v2 = if v3 ~= "" then
        ("%*   <font size=\"12\" color=\"#AAB2C6\">%*</font>"):format(Palette.displayName(a2), v3)
    else
        Palette.displayName(a2)
    v1.Text = v2
    u162 = nil

    refreshProgress()

    u151 = 0 < (Config.Factory.Fuel.CraftsPerUnit[a2] or 0)
    u121.Visible = v3
    u122.Visible = v3
    u127.Visible = v3
    u128.Visible = v3
    u119.Size = UDim2.new(1, (if not v3 then u176 else u188) - 20, 0, u168.headerHeight)
    u119.TextTruncate = Enum.TextTruncate.AtEnd
    u139.Visible = a2 == "Workbench"

    if u139.Visible then
        u71:FireServer()
    end

    u147 = ""
    u145.Text = ""
    v3 = 0

    for i, j in Config.Recipe.All do
        if j.workbenchTier <= u115
            and table.find(j.stations, a4)
            and j.family == nil then
            v3 = v3 + 1
        end
    end

    v2 = nil
    local v4 = nil

    for k, n in Config.Recipe.Families, v2, v4 do
        if n.workbenchTier <= u115 and table.find(n.stations, a4) then
            v3 = v3 + 1
        end
    end

    u148 = v3 > 8
    u150 = false
    u132.Visible = false

    relayout()

    u117.Visible = true
    u84.appear(u117)
    BuildController.setUiOpen("Crafting", true)

    if a3 and a3:GetAttribute("AutoSelects") == true then
        buildList("")

        u131.Visible = false
        local Frame_2 = Instance.new("Frame")
        Frame_2.Name = "AutoNote"
        Frame_2.Size = UDim2.fromScale(1, 1)
        Frame_2.BackgroundTransparency = 1
        Frame_2.Parent = u130
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, -24, 0, 0)
        TextLabel.AutomaticSize = Enum.AutomaticSize.Y
        TextLabel.Position = UDim2.fromOffset(12, 10)
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextWrapped = true
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.TextYAlignment = Enum.TextYAlignment.Top
        local BeltNoteDefault = Config.Description.BeltNotes[a2]
            or Config.Description.BeltNoteDefault
        TextLabel.Text = BeltNoteDefault
        TextLabel.TextColor3 = Color3.fromRGB(190, 198, 215)
        TextLabel.TextSize = 14
        TextLabel.FontFace = u84.Font.Regular
        TextLabel.Parent = Frame_2
        v2 = Config.Description.BeltTips[a2]

        if not v2 then
            local v5, v6, v7, v8, v9
            v4 = {}
            local v10 = nil
            local v11 = nil

            for m, i5 in Config.Recipe.All, v10, v11 do
                if table.find(i5.stations, a4)
                    and not Config.Recipe.isSecret(i5.output)
                    and Config.Release.mayCraft(LocalPlayer, i5.output) then
                    v5 = {}

                    for i6, i7 in i5.inputs do
                        table.insert(
                            v5,
                            {name = Palette.displayName(i6), count = i7}
                        )
                    end

                    table.sort(
                        v5,
                        function(a1, a2) -- Line: 1189
                            if a1.count ~= a2.count then
                                return a2.count < a1.count
                            end

                            return a1.name < a2.name
                        end
                    )

                    v6 = {}
                    v8 = nil
                    v9 = nil

                    for i8, i9 in v5, v8, v9 do
                        table.insert(v6, if not (1 < i9.count) then i9.name else ("x%* %*"):format(i9.count, i9.name))
                    end

                    v7 = Palette.displayName(i5.output)
                    table.insert(
                        v4,
                        {
                            key = ("%* %*"):format(v5[1].name, v7),
                            text = ("%* = %*"):format(table.concat(v6, " + "), v7),
                        }
                    )
                end
            end

            table.sort(
                v4,
                function(a1, a2) -- Line: 1207
                    return a1.key < a2.key
                end
            )

            for i10, i11 in v4 do
                table.insert(
                    {},
                    i11.text
                )
            end
        end

        local Frame = Instance.new("Frame")
        Frame.BackgroundTransparency = 1
        Frame.Parent = Frame_2

        for i12, i13 in v2 do
            v3 = Instance.new("TextLabel")
            v3.Size = UDim2.new(1, -24, 0, 22)
            v3.Position = UDim2.fromOffset(12, (i12 - 1) * 24)
            v3.BackgroundTransparency = 1
            v3.TextXAlignment = Enum.TextXAlignment.Left
            v3.Text = i13
            v3.TextColor3 = Color3.fromRGB(150, 220, 170)
            v3.TextSize = 13
            v3.FontFace = u84.Font.Regular
            v3.Parent = Frame
        end

        local u378 = #v2 * 24

        local function place() -- Line: 1232; upvalues: TextLabel (val), Frame (val), u378 (val), u130 (upval)
            local v1 = 10 + TextLabel.AbsoluteSize.Y + 12
            Frame.Size = UDim2.new(1, 0, 0, u378)
            Frame.Position = UDim2.fromOffset(0, v1)
            u130.CanvasSize = UDim2.fromOffset(0, v1 + u378 + 8)
        end

        ;(TextLabel:GetPropertyChangedSignal("AbsoluteSize")):Connect(place)
        place()

        return
    end

    buildList(a4)
end

function u44.toggleHandCrafting()
    -- Line: 1247
    -- upvalues: u117 (ref), u156 (ref), u44 (val), u158 (ref), u194 (ref), u147 (ref), u145 (ref), Config (val)
    -- upvalues: u148 (ref), u150 (ref), u159 (ref), u137 (ref), u118 (ref), u162 (ref), refreshProgress (val)
    -- upvalues: u176 (val), u119 (ref), u168 (val), u151 (ref), u121 (ref), u122 (ref), u127 (ref), u128 (ref)
    -- upvalues: u139 (ref), relayout (val), u84 (val), BuildController (val), buildList (val)
    if u117.Visible and u156 == "hand" then
        u44.close()
        return
    end

    u156 = "hand"
    u158 = nil
    u194 = nil
    u147 = ""
    u145.Text = ""
    local v1 = 0

    for i, j in Config.Recipe.All do
        if table.find(j.stations, "Hand") then
            v1 = v1 + 1
        end
    end

    u148 = v1 > 8
    u150 = false
    u159 = "Hand"
    u137 = false
    u118.Text = "Crafting by hand"
    u162 = nil

    refreshProgress()

    u119.Size = UDim2.new(1, u176 - 20, 0, u168.headerHeight)
    u119.TextTruncate = Enum.TextTruncate.AtEnd
    u151 = false
    u121.Visible = false
    u122.Visible = false
    u127.Visible = false
    u128.Visible = false
    u139.Visible = false

    relayout()

    u117.Visible = true
    u84.appear(u117)
    BuildController.setUiOpen("Crafting", true)
    buildList("Hand")
end

function u44.start()
    -- Line: 1287
    -- upvalues: BuildController (val), u44 (val), PanelTabs (val), u149 (ref), u197 (ref), u194 (ref)
    -- upvalues: refreshTabs (ref), refreshRows (val), u116 (ref), LocalPlayer (val), u117 (ref), u84 (val), u118 (ref)
    -- upvalues: u168 (val), u119 (ref), u129 (ref), u176 (val), u156 (ref), u61 (val), u121 (ref), u188 (val)
    -- upvalues: u122 (ref), u185 (val), ItemIcon (val), Config (val), u124 (ref), u123 (ref), u166 (val), u125 (ref)
    -- upvalues: u126 (ref), u127 (ref), u179 (val), u128 (ref), u182 (val), buildSidebar (val), u74 (val), u139 (ref)
    -- upvalues: renderUpgrade (val), ControlGlyphs (val), u55 (val), u153 (ref), u120 (ref), u145 (ref), u147 (ref)
    -- upvalues: u152 (ref), u150 (ref), relayout (val), u131 (ref), u195 (ref), tabHeight (val), u130 (ref), u146 (ref)
    -- upvalues: ItemTooltip (val), u132 (ref), u136 (val), u133 (ref), u58 (val), ProximityPromptService (val)
    -- upvalues: NewBadges (val), u115 (ref), u159 (ref), buildList (val), u68 (val), u160 (ref), u65 (val)
    -- upvalues: Palette (val), u62 (ref), u162 (ref), refreshProgress (val), RunService (val), closeIfOutOfRange (val)
    BuildController.registerMenu("Crafting", u44.close)

    PanelTabs.register(
        u44.isOpen,
        function(a1)
            -- Line: 1291
            -- upvalues: u149 (upval), PanelTabs (upval), u197 (upval), u194 (upval), refreshTabs (upval)
            -- upvalues: refreshRows (upval)
            if not u149 then
                return
            end

            local v1 = u194 or "\000All"
            local v2 = PanelTabs.neighbour(u197, v1, a1)

            if v2 then
                u194 = if v2 ~= "\000All" then v2 else nil
                refreshTabs()
                refreshRows()
            end
        end
    )

    u116 = Instance.new("ScreenGui")
    u116.Name = "AboveCrafting"
    u116.ResetOnSpawn = false
    u116.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u117 = Instance.new("Frame")
    u117.ClipsDescendants = true
    u117.Size = UDim2.fromOffset(680, 520)
    u117.Position = UDim2.new(0.5, -340, 0.5, -260)

    u84.fitToScreen(u117)

    u117.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
    u117.BackgroundTransparency = 0.05
    u117.Visible = false
    u117.Active = true
    u117.Parent = u116
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = u117
    u118 = Instance.new("TextLabel")
    u118.Size = UDim2.new(1, -80, 0, 30)
    u118.Position = UDim2.fromOffset(12, 8)
    u118.BackgroundTransparency = 1
    u118.TextColor3 = Color3.fromRGB(255, 226, 130)
    u118.FontFace = u84.Font.Bold
    u118.TextSize = u168.titleText
    u118.TextXAlignment = Enum.TextXAlignment.Left
    u118.Text = "Workbench"
    u118.RichText = true
    u118.Parent = u117
    u119 = Instance.new("TextLabel")
    u119.Size = UDim2.new(1, -24, 0, u168.headerHeight)
    u119.Position = UDim2.fromOffset(12, u168.headerY)
    u119.BackgroundTransparency = 1
    u119.TextColor3 = Color3.fromRGB(170, 200, 230)
    u119.FontFace = u84.Font.Regular
    u119.TextSize = u168.labelText
    u119.TextXAlignment = Enum.TextXAlignment.Left
    u119.Text = "Idle"
    u119.Parent = u117
    u129 = Instance.new("TextButton")
    u129.Size = UDim2.fromOffset(u168.stopWidth, u168.headerHeight)
    u129.Position = UDim2.new(1, u176, 0, u168.headerY)
    u129.BackgroundColor3 = Color3.fromRGB(70, 40, 46)
    u129.TextColor3 = Color3.fromRGB(255, 200, 200)
    u129.FontFace = u84.Font.Bold
    u129.TextSize = u168.headerText
    u129.Text = "STOP"
    u129.Visible = false
    u129.Parent = u117
    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.CornerRadius = UDim.new(0, 4)
    UICorner_2.Parent = u129

    u129.Activated:Connect(function() -- Line: 1373; upvalues: u156 (upval), u61 (upval)
        if u156 and u156 ~= "hand" then
            u61:FireServer(u156)
        end
    end)

    u84.closeButton(u117, 10, u44.close)

    u121 = Instance.new("TextLabel")
    u121.Size = UDim2.fromOffset(u168.fuelLabelWidth, u168.headerHeight)
    u121.Position = UDim2.new(1, u188, 0, u168.headerY)
    u121.BackgroundTransparency = 1
    u121.Text = "0 crafts"
    u121.TextColor3 = Color3.fromRGB(170, 200, 230)
    u121.FontFace = u84.Font.Regular
    u121.TextSize = u168.labelText
    u121.TextXAlignment = Enum.TextXAlignment.Right
    u121.Visible = false
    u121.Parent = u117
    u122 = Instance.new("Frame")
    u122.Name = "FuelSlot"
    u122.Size = UDim2.fromOffset(u168.fuelSlot, u168.fuelSlot)
    u122.Position = UDim2.new(1, u185, 0, u168.headerY + (u168.headerHeight - u168.fuelSlot) / 2)
    u122.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
    u122.BorderSizePixel = 0
    u122.Visible = false
    u122.Parent = u117

    u84.corner(u122, 4)
    u84.stroke(u122, Color3.fromRGB(64, 70, 88), 1)
    ItemIcon.render(u122, Config.Factory.Fuel.ItemId, u168.fuelSlot, 4)

    u124 = Instance.new("Frame")
    u124.Size = UDim2.fromScale(1, 1)
    u124.BackgroundColor3 = Color3.new(0, 0, 0)
    u124.BackgroundTransparency = 0.45
    u124.BorderSizePixel = 0
    u124.ZIndex = 5
    u124.Parent = u122

    u84.corner(u124, 4)

    u123 = Instance.new("TextLabel")
    u123.Size = UDim2.new(1, -2, 1, 0)
    u123.BackgroundTransparency = 1
    u123.Text = ""
    u123.TextColor3 = Color3.new(1, 1, 1)
    u123.FontFace = u84.Font.Bold
    u123.TextSize = if not u166 then 11 else 14
    u123.TextXAlignment = Enum.TextXAlignment.Right
    u123.TextYAlignment = Enum.TextYAlignment.Bottom
    u123.ZIndex = 6
    u123.Parent = u122
    u125 = Instance.new("Frame")
    u125.Size = UDim2.new(0, if not u166 then 3 else 5, 1, -6)
    u125.Position = UDim2.fromOffset(2, 3)
    u125.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    u125.BorderSizePixel = 0
    u125.ZIndex = 7
    u125.Visible = false
    u125.Parent = u122

    u84.corner(u125, 2)

    u126 = Instance.new("Frame")
    u126.AnchorPoint = Vector2.new(0, 1)
    u126.Position = UDim2.fromScale(0, 1)
    u126.Size = UDim2.fromScale(1, 1)
    u126.BackgroundColor3 = Color3.fromRGB(240, 150, 60)
    u126.BorderSizePixel = 0
    u126.ZIndex = 8
    u126.Parent = u125

    u84.corner(u126, 2)

    u127 = Instance.new("TextButton")
    u127.Size = UDim2.fromOffset(u168.fuelWidth, u168.headerHeight)
    u127.Position = UDim2.new(1, u179, 0, u168.headerY)
    u127.BackgroundColor3 = Color3.fromRGB(58, 52, 40)
    u127.TextColor3 = Color3.fromRGB(255, 226, 130)
    u127.FontFace = u84.Font.Bold
    u127.TextSize = u168.headerText
    u127.Text = "+1 COAL"
    u127.Visible = false
    u127.Parent = u117
    u128 = Instance.new("TextButton")
    u128.Size = UDim2.fromOffset(u168.unfuelWidth, u168.headerHeight)
    u128.Position = UDim2.new(1, u182, 0, u168.headerY)
    u128.BackgroundColor3 = Color3.fromRGB(48, 44, 38)
    u128.TextColor3 = Color3.fromRGB(200, 180, 130)
    u128.FontFace = u84.Font.Bold
    u128.TextSize = u168.headerText
    u128.Text = "-1"
    u128.TextXAlignment = Enum.TextXAlignment.Center
    u128.Visible = false
    u128.Parent = u117
    local UICorner_3 = Instance.new("UICorner")
    UICorner_3.CornerRadius = UDim.new(0, 4)
    UICorner_3.Parent = u128
    local UICorner_4 = Instance.new("UICorner")
    UICorner_4.CornerRadius = UDim.new(0, 4)
    UICorner_4.Parent = u127

    buildSidebar()

    u74.OnClientEvent:Connect(function(a1) -- Line: 1495; upvalues: u139 (upval), renderUpgrade (upval)
        if u139.Visible then
            renderUpgrade(a1)
        end
    end)

    local MaxStoredCrafts = Config.Factory.Fuel.MaxStoredCrafts

    local function shifted() -- Line: 1504; upvalues: ControlGlyphs (upval)
        return ControlGlyphs.bulkHeld()
    end

    local function loadFuel(a1) -- Line: 1507; upvalues: u156 (upval), u55 (upval); types: a1: number
        if u156 and u156 ~= "hand" then
            u55:FireServer(u156, a1)
        end
    end

    local u576 = u84.holdForStack(
        u127,
        function() -- Line: 1512; upvalues: MaxStoredCrafts (val), u156 (upval), u55 (upval)
            if u156 and u156 ~= "hand" then
                u55:FireServer(u156, MaxStoredCrafts)
            end
        end
    )
    local u581 = u84.holdForStack(
        u128,
        function() -- Line: 1515; upvalues: MaxStoredCrafts (val), u156 (upval), u55 (upval)
            local v1 = -MaxStoredCrafts

            if u156 and u156 ~= "hand" then
                u55:FireServer(u156, v1)
            end
        end
    )

    u127.Activated:Connect(function()
        -- Line: 1519
        -- upvalues: u576 (val), ControlGlyphs (upval), MaxStoredCrafts (val), u156 (upval), u55 (upval)
        if u576() then
            return
        end

        local v1 = if not ControlGlyphs.bulkHeld() then 1 else MaxStoredCrafts

        if u156 and u156 ~= "hand" then
            u55:FireServer(u156, v1)
        end
    end)

    u128.Activated:Connect(function()
        -- Line: 1526
        -- upvalues: u581 (val), ControlGlyphs (upval), MaxStoredCrafts (val), u156 (upval), u55 (upval)
        if u581() then
            return
        end

        local v1 = if not ControlGlyphs.bulkHeld() then -1 else -MaxStoredCrafts

        if u156 and u156 ~= "hand" then
            u55:FireServer(u156, v1)
        end
    end)

    local Frame = Instance.new("Frame")
    u153 = Frame
    Frame.Size = UDim2.new(1, -24, 0, 4)
    Frame.Position = UDim2.fromOffset(12, u168.barY)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 44, 54)
    Frame.BorderSizePixel = 0
    Frame.Parent = u117
    u120 = Instance.new("Frame")
    u120.Size = UDim2.fromScale(0, 1)
    u120.BackgroundColor3 = Color3.fromRGB(255, 226, 130)
    u120.BorderSizePixel = 0
    u120.Parent = Frame
    u145 = Instance.new("TextBox")
    u145.Size = UDim2.new(1, -24, 0, u168.searchHeight)
    u145.Position = UDim2.fromOffset(12, u168.searchY)
    u145.BackgroundColor3 = Color3.fromRGB(32, 35, 44)
    u145.BorderSizePixel = 0
    u145.PlaceholderText = "Search"
    u145.Text = ""
    u145.TextColor3 = Color3.fromRGB(238, 240, 248)
    u145.PlaceholderColor3 = Color3.fromRGB(120, 126, 145)
    u145.TextSize = u168.searchText
    u145.FontFace = u84.Font.Regular
    u145.TextXAlignment = Enum.TextXAlignment.Left
    u145.ClearTextOnFocus = false
    u145.Parent = u117
    local UICorner_5 = Instance.new("UICorner")
    UICorner_5.CornerRadius = UDim.new(0, 5)
    UICorner_5.Parent = u145
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.Parent = u145

    ;(u145:GetPropertyChangedSignal("Text")):Connect(function()
        -- Line: 1572
        -- upvalues: u147 (upval), u145 (upval), refreshRows (upval)
        u147 = string.lower(u145.Text)
        refreshRows()
    end)

    if u166 then
        local TextButton = Instance.new("TextButton")
        u152 = TextButton
        TextButton.Name = "SearchToggle"
        TextButton.Size = UDim2.fromOffset(u84.tap(26), u84.tap(26))
        TextButton.AnchorPoint = Vector2.new(1, 0)
        TextButton.Position = UDim2.new(1, -(10 + u84.tap(26) + 8), 0, 10)
        TextButton.BackgroundColor3 = u84.Palette.Track
        TextButton.BorderSizePixel = 0
        TextButton.Text = "🔍"
        TextButton.TextSize = u84.tapText(14)
        TextButton.FontFace = u84.Font.Bold
        TextButton.TextColor3 = u84.Palette.Dim
        TextButton.AutoButtonColor = true
        TextButton.Visible = false
        TextButton.Parent = u117

        u84.corner(TextButton, 6)

        TextButton.Activated:Connect(function()
            -- Line: 1596
            -- upvalues: u150 (upval), u194 (upval), refreshTabs (upval), relayout (upval), u145 (upval)
            -- upvalues: refreshRows (upval)
            u150 = not u150

            if not u150 then
                u145.Text = ""
                u145:ReleaseFocus()
                relayout()
            else
                u194 = nil
                refreshTabs()
                relayout()
                u145:CaptureFocus()
            end

            refreshRows()
        end)

        u118.Size = UDim2.new(1, -(80 + u84.tap(26) + 8), 0, 30)
    end

    u131 = Instance.new("TextLabel")
    u131.Size = UDim2.new(1, -24, 0, 40)
    u131.Position = UDim2.fromOffset(12, 100)
    u131.BackgroundTransparency = 1
    u131.Text = "Nothing here by that name"
    u131.TextWrapped = true
    u131.TextColor3 = Color3.fromRGB(126, 133, 152)
    u131.FontFace = u84.Font.Regular
    u131.TextSize = 13
    u131.TextXAlignment = Enum.TextXAlignment.Left
    u131.TextYAlignment = Enum.TextYAlignment.Top
    u131.Visible = false
    u131.Parent = u117
    u195 = Instance.new("Frame")
    u195.Size = UDim2.new(1, -24, 0, tabHeight)
    u195.Position = UDim2.fromOffset(12, u168.searchY + u168.searchHeight + u168.gap)
    u195.BackgroundTransparency = 1
    u195.Visible = false
    u195.Parent = u117
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.Padding = UDim.new(0, 4)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = u195
    u130 = Instance.new("ScrollingFrame")
    u130.Size = UDim2.new(1, -24, 1, -136)
    u130.Position = UDim2.fromOffset(12, 124)
    u130.BackgroundTransparency = 1
    u130.BorderSizePixel = 0
    u130.ScrollBarThickness = 5
    u130.Active = true
    u130.Parent = u117
    u146 = ItemTooltip.new(
        u117,
        {unmade = true}
    )

    u146.hideOnScroll(u130)

    u132 = Instance.new("Frame")
    u132.Name = "Held"
    u132.Size = UDim2.new(1, -24, 0, u136)
    u132.Position = UDim2.new(0, 12, 1, -(u136 + 12))
    u132.BackgroundColor3 = Color3.fromRGB(34, 37, 47)
    u132.BorderSizePixel = 0
    u132.Visible = false
    u132.Parent = u117

    u84.corner(u132, 6)

    u133 = Instance.new("TextLabel")
    u133.Size = UDim2.new(1, -130, 1, 0)
    u133.Position = UDim2.fromOffset(10, 0)
    u133.BackgroundTransparency = 1
    u133.TextColor3 = u84.Palette.Text
    u133.FontFace = u84.Font.Medium
    u133.TextSize = 12
    u133.TextXAlignment = Enum.TextXAlignment.Left
    u133.TextTruncate = Enum.TextTruncate.AtEnd
    u133.Parent = u132
    local TextButton_2 = Instance.new("TextButton")
    TextButton_2.Size = UDim2.new(0, 110, 1, -6)
    TextButton_2.AnchorPoint = Vector2.new(1, 0.5)
    TextButton_2.Position = UDim2.new(1, -4, 0.5, 0)
    TextButton_2.BackgroundColor3 = u84.Palette.Gold
    TextButton_2.TextColor3 = u84.Palette.OnGold
    TextButton_2.Text = "TAKE OUT"
    TextButton_2.FontFace = u84.Font.Bold
    TextButton_2.TextSize = u84.tapText(12)
    TextButton_2.AutoButtonColor = true
    TextButton_2.Parent = u132

    u84.corner(TextButton_2, 5)

    TextButton_2.Activated:Connect(function() -- Line: 1688; upvalues: u156 (upval), u58 (upval)
        if u156 then
            u58:FireServer(u156)
        end
    end)

    ProximityPromptService.PromptTriggered:Connect(function(a1, a2)
        -- Line: 1696
        -- upvalues: LocalPlayer (upval), u44 (upval), u55 (upval)
        if a2 ~= LocalPlayer then
            return
        end

        local Parent = a1.Parent

        if Parent and Parent:IsA("BasePart") then
            local Attribute = Parent:GetAttribute("CellKey")
            local Attribute_2 = Parent:GetAttribute("MachineId")

            if Attribute and Attribute_2 then
                local Attribute_3 = Parent:GetAttribute("Station")

                if Attribute_3 then
                    u44.open(Attribute, Attribute_2, Parent, Attribute_3)
                    return
                end

                u55:FireServer(Attribute)
            end
        end
    end)

    NewBadges.onChanged(function() -- Line: 1724; upvalues: u117 (upval), refreshRows (upval)
        if u117.Visible then
            refreshRows()
        end
    end)

    local WorkbenchTierAttribute = Config.Player.WorkbenchTierAttribute
    ;(LocalPlayer:GetAttributeChangedSignal(WorkbenchTierAttribute)):Connect(function()
        -- Line: 1736
        -- upvalues: LocalPlayer (upval), WorkbenchTierAttribute (val), u115 (upval), u117 (upval), u159 (upval)
        -- upvalues: buildList (upval), refreshRows (upval)
        local Attribute = LocalPlayer:GetAttribute(WorkbenchTierAttribute)

        if type(Attribute) == "number" and Attribute ~= u115 then
            u115 = Attribute

            if u117.Visible and u159 then
                buildList(u159)
                refreshRows()
            end
        end
    end)

    local Attribute = LocalPlayer:GetAttribute(WorkbenchTierAttribute)

    if type(Attribute) == "number" and Attribute ~= u115 then
        u115 = Attribute

        if u117.Visible and u159 then
            buildList(u159)
            refreshRows()
        end
    end

    u68.OnClientEvent:Connect(function(a1, a2, a3, a4, a5)
        -- Line: 1750
        -- upvalues: u160 (upval), u117 (upval), refreshRows (upval)
        u160 = table.clone(a1)

        if type(a5) == "table" then
            local v1, v2

            for i, j in a5 do
                v1 = u160
                v2 = (u160[i] or 0) - j
                v1[i] = (math.max(0, v2))
            end
        end

        if u117.Visible then
            refreshRows()
        end
    end)

    u65.OnClientEvent:Connect(function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
        -- Line: 1765
        -- upvalues: u156 (upval), Palette (upval), u133 (upval), u132 (upval), relayout (upval), u62 (upval)
        -- upvalues: u121 (upval), Config (upval), u123 (upval), u124 (upval), u125 (upval), u126 (upval), u162 (upval)
        -- upvalues: refreshProgress (upval)
        local v1

        if a1 ~= u156 then
            return
        end

        local v2 = {}

        if type(a9) == "table" then
            local v3

            for i, j in a9 do
                if type(i) == "string" and type(j) == "number" and j > 0 then
                    v3 = Palette.displayName(i)
                    table.insert(v2, (("%* %*"):format(j, v3)))
                end
            end
        end

        table.sort(v2)

        local v4 = #v2 > 0
        u133.Text = ("Inside: %*"):format((table.concat(v2, "  ·  ")))

        if u132.Visible ~= v4 then
            u132.Visible = v4
            relayout()
        end

        u62 = if type(a8) ~= "number" then 0 else a8

        if u121.Visible then
            v4 = Config.Factory.Fuel.CraftsPerUnit[a2 or ""] or 0
            v2 = if not (v4 > 0) then 0 else math.floor((a6 or 0) / v4)
            u123.Text = if not (v2 > 0) then "" else ("x%*"):format(v2)
            u124.Visible = (a6 or 0) <= 0
            v2 = if not (v4 > 0) then 0 else (a6 or 0) % v4
            v1 = if not ((a6 or 0) <= 0) then if v2 ~= 0 then v2 / v4 else 1 else 0
            u125.Visible = v1 > 0
            u126.Size = UDim2.fromScale(1, v1)
            u121.Text = ("%* crafts"):format(a6 or 0)
            local v5 = u121
            local v6 = if not (0 < (a6 or 0)) then
                Color3.fromRGB(240, 150, 150)
            else
                Color3.fromRGB(170, 200, 230)
            v5.TextColor3 = v6
        end

        if not a3 or not (a4 > 0) then
            u162 = nil
        else
            v1 = if type(a10) ~= "number" then a4 else if not (a4 <= a10) then a4 else a10
            u162 = {recipeId = a3, endsAt = os.clock() + a4, duration = v1}
        end

        refreshProgress()
    end)

    RunService.RenderStepped:Connect(function()
        -- Line: 1822
        -- upvalues: refreshProgress (upval), closeIfOutOfRange (upval)
        refreshProgress()
        closeIfOutOfRange()
    end)
end

return u44