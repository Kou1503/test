-- Script path: game:GetService("Players").TheKiller150306Alt.PlayerScripts.Client.Controllers.MenuBarController
-- Decompile time: 14.89 ms

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")
local DeviceMode = require(script.Parent.DeviceMode)
local Shared = (game:GetService("ReplicatedStorage")):WaitForChild("Shared")
local Remotes = require(Shared.Remotes)
local u53 = require(script.Parent.Parent.Ui)
local BackpackController = require(script.Parent.BackpackController)
local HotbarController = require(script.Parent.HotbarController)
local ControlGlyphs = require(script.Parent.ControlGlyphs)
local NewBadges = require(script.Parent.NewBadges)
local HintController = require(script.Parent.HintController)
local AchievementsController = require(script.Parent.AchievementsController)
local QuickTeleportController = require(script.Parent.QuickTeleportController)
local FriendsController = require(script.Parent.FriendsController)
local IslandsController = require(script.Parent.IslandsController)
local NewsController = require(script.Parent.NewsController)
local PremiumShopController = require(script.Parent.PremiumShopController)
local SettingsPanelController = require(script.Parent.SettingsPanelController)
local ShowroomController = require(script.Parent.ShowroomController)
local u119 = {}
local LocalPlayer = Players.LocalPlayer
local u121 = {}
local Config = require((game:GetService("ReplicatedStorage")):WaitForChild("Shared").Config)
local Icons = Config.Appearance.Icons
local u136 = {}
local v1 = {
    id = "Backpack",
    glyph = "🎒",
    tip = "Backpack  (E)",
    icon = Icons.Backpack,
    open = function() -- Line: 85; upvalues: BackpackController (val)
        BackpackController.toggle()
    end,
}
local v2 = {
    id = "Teleport",
    glyph = "🔄",
    tip = "Teleport  (C)",
    noTip = true,
    icon = Icons.Teleport,
    attach = QuickTeleportController.attach,
    open = function() -- Line: 99; upvalues: QuickTeleportController (val)
        QuickTeleportController.press()
    end,
}
local v3 = {
    id = "Published",
    glyph = "🏝",
    tip = "Published islands",
    icon = Icons.Published,
    onlyIf = function() -- Line: 112; upvalues: Config (val)
        return Config.Place.showroomOf(game.PlaceId) ~= nil
    end,
    open = function() -- Line: 115; upvalues: ShowroomController (val)
        ShowroomController.toggle()
    end,
}
local v4 = {
    id = "Friends",
    glyph = "👥",
    tip = "People  (L)",
    icon = Icons.People,
    open = function() -- Line: 126; upvalues: FriendsController (val)
        FriendsController.toggle()
    end,
}
local v5 = {
    id = "Achievements",
    glyph = "🏆",
    tip = "Achievements",
    icon = Icons.Achievements,
    open = function() -- Line: 135; upvalues: AchievementsController (val)
        AchievementsController.toggle()
    end,
}
local v6 = {
    id = "Shop",
    glyph = "⭐",
    tip = "Shop  (M)",
    icon = Icons.Shop,
    hidden = not Config.Monetization.ShopInMenuBar,
    open = function() -- Line: 146; upvalues: PremiumShopController (val)
        PremiumShopController.toggle()
    end,
}
local v7 = {
    id = "Islands",
    glyph = "🏝",
    tip = "Island Management",
    icon = Icons.Islands,
    open = function() -- Line: 155; upvalues: IslandsController (val)
        IslandsController.toggle()
    end,
}
local v8 = {
    id = "Settings",
    glyph = "⚙",
    tip = "Settings",
    dock = "TopStrip",
    icon = Icons.Settings,
    open = function() -- Line: 167; upvalues: SettingsPanelController (val)
        SettingsPanelController.toggle()
    end,
}
local v9 = {
    id = "News",
    glyph = "📰",
    tip = "Updates",
    dock = "TopStrip",
    icon = Config.News.Icon,
    open = function() -- Line: 178; upvalues: NewsController (val)
        NewsController.toggle()
    end,
}
u136[1] = v1
u136[2] = v2
u136[3] = v3
u136[4] = v4
u136[5] = v5
u136[6] = v6
u136[7] = v7
u136[8] = v8
u136[9] = v9
local u170 = nil
local u171 = nil
local u172 = false

local function hideHint() -- Line: 192; upvalues: u172 (ref), HintController (val), TweenService (val), u171 (ref)
    local v1

    if not u172 then
        return
    end

    u172 = false
    HintController.markSeen("Backpack")

    TweenService:Create(
        u171,
        TweenInfo.new(0.25),
        {BackgroundTransparency = 1}
    ):Play()

    for i, j in u171:GetDescendants() do
        if j:IsA("TextLabel") then
            v1 = TweenInfo.new(0.25)
            TweenService:Create(
                j,
                v1,
                {TextTransparency = 1}
            ):Play()
        elseif j:IsA("ImageLabel") then
            v1 = TweenInfo.new(0.25)
            TweenService:Create(
                j,
                v1,
                {ImageTransparency = 1}
            ):Play()
        end
    end

    task.delay(
        0.3,
        function() -- Line: 207; upvalues: u171 (upval)
            u171.Visible = false
        end
    )
end

local u174 = {}

function u119.focus() -- Line: 218; upvalues: u174 (ref), GuiService (val)
    for i, j in u174 do
        if j.Visible and j.Parent then
            GuiService.SelectedObject = j
            return
        end
    end
end

function u119.isFocused() -- Line: 228; upvalues: GuiService (val), u174 (ref)
    local SelectedObject = GuiService.SelectedObject
    local v1 = false

    if SelectedObject ~= nil then
        v1 = table.find(u174, SelectedObject) ~= nil
    end

    return v1
end

function u119.unfocus() -- Line: 234; upvalues: u119 (val), GuiService (val)
    if u119.isFocused() then
        GuiService.SelectedObject = nil
    end
end

function u119.start()
    -- Line: 240
    -- upvalues: u170 (ref), LocalPlayer (val), u136 (val), DeviceMode (val), u174 (ref), u53 (val), u121 (val)
    -- upvalues: ControlGlyphs (val), TweenService (val), hideHint (val), QuickTeleportController (val)
    -- upvalues: UserInputService (val), u171 (ref), VRService (val), TextChatService (val), HotbarController (val)
    -- upvalues: Config (val), GuiService (val), HintController (val), u172 (ref), BackpackController (val)
    -- upvalues: Remotes (val), NewBadges (val)
    local Frame_3, ImageLabel, TextLabel_2, UICorner, UICorner_2, UICorner_3, UIStroke_3, UIStroke_4, hoverOff,
        hoverOn
    u170 = Instance.new("ScreenGui")
    u170.Name = "MenuBar"
    u170.ResetOnSpawn = false
    u170.DisplayOrder = 1
    u170.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local v1 = {}

    for i, j in u136 do
        if not j.hidden then
            table.insert(v1, j)
        end
    end

    local Frame = Instance.new("Frame")
    Frame.SelectionGroup = true
    Frame.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
    Frame.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
    Frame.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
    Frame.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
    local u787 = DeviceMode.touchOnly()
    local v2 = 0

    for k, n in v1 do
        if n.id ~= "Backpack" and not n.dock then
            v2 = v2 + 1
        end
    end

    local u829 = v2 * 44 + math.max(0, v2 - 1) * 6
    local u779 = {}
    local u783 = u787
    local u833 = UDim2.new(0, 12, 0.5, -(u829 / 2))
    Frame.BackgroundTransparency = 1
    Frame.Parent = u170
    local u837 = false
    local u592 = nil
    local u72 = nil

    local function u845() -- Line: 308
    end

    local u849 = {}
    u174 = u849
    local u853 = {}
    local u594 = nil
    local u596 = nil
    local v3 = nil
    local v4 = nil

    for m, i5 in v1, v3, v4 do
        local TextButton = Instance.new("TextButton")
        table.insert(u849, TextButton)

        u853[TextButton] = i5

        if i5.id == "Backpack" then
            u592 = TextButton
        elseif i5.id == "Settings" then
            u594 = TextButton
        elseif i5.id == "News" then
            u596 = TextButton
        end

        TextButton.Size = UDim2.fromOffset(44, 44)
        TextButton.BackgroundColor3 = Color3.fromRGB(26, 29, 36)
        TextButton.BackgroundTransparency = 0.15
        TextButton.Text = if not i5.icon then
            i5.glyph
        else
            if i5.icon == "" then i5.glyph else ""
        TextButton.TextColor3 = Color3.fromRGB(232, 236, 245)
        TextButton.TextSize = 20
        TextButton.FontFace = u53.Font.Bold
        TextButton.AutoButtonColor = true
        TextButton.Parent = Frame

        if i5.icon and i5.icon ~= "" then
            ImageLabel = Instance.new("ImageLabel")
            ImageLabel.Name = "Icon"
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            ImageLabel.Size = UDim2.new(1, -14, 1, -14)
            ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.Image = i5.icon
            ImageLabel.ScaleType = Enum.ScaleType.Fit

            ImageLabel:SetAttribute("ThemeTint", true)

            ImageLabel.Parent = TextButton
        end

        UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = TextButton
        UIStroke_3 = Instance.new("UIStroke")
        UIStroke_3.Color = Color3.fromRGB(58, 62, 78)
        UIStroke_3.Parent = TextButton
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.fromOffset(150, 24)
        TextLabel.Position = UDim2.new(1, 8, 0.5, -12)
        TextLabel.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
        TextLabel.BackgroundTransparency = 0.1
        TextLabel.Text = i5.tip
        TextLabel.TextColor3 = Color3.fromRGB(226, 231, 242)
        TextLabel.TextSize = 12
        TextLabel.FontFace = u53.Font.Medium
        TextLabel.Visible = false
        TextLabel.Parent = TextButton
        UICorner_2 = Instance.new("UICorner")
        UICorner_2.CornerRadius = UDim.new(0, 6)
        UICorner_2.Parent = TextLabel
        TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Name = "Badge"
        TextLabel_2.Size = UDim2.fromOffset(18, 18)
        TextLabel_2.Position = UDim2.new(1, -7, 0, -7)
        TextLabel_2.BackgroundColor3 = Color3.fromRGB(226, 62, 62)
        TextLabel_2.Text = ""
        TextLabel_2.TextColor3 = Color3.fromRGB(255, 245, 245)
        TextLabel_2.TextSize = 11
        TextLabel_2.FontFace = u53.Font.Bold
        TextLabel_2.Visible = false
        TextLabel_2.ZIndex = 3
        TextLabel_2.Parent = TextButton
        UICorner_3 = Instance.new("UICorner")
        UICorner_3.CornerRadius = UDim.new(1, 0)
        UICorner_3.Parent = TextLabel_2
        UIStroke_4 = Instance.new("UIStroke")
        UIStroke_4.Color = Color3.fromRGB(18, 20, 26)
        UIStroke_4.Thickness = 2
        UIStroke_4.Parent = TextLabel_2
        u121[i5.id] = TextLabel_2
        local u765 = UDim2.fromOffset(44, 44)
        local u770 = UDim2.fromOffset(49.28, 49.28)
        TextButton.AnchorPoint = Vector2.new(0.5, 0.5)

        function hoverOn()
            -- Line: 428
            -- upvalues: u779 (val), TextButton (val), TextLabel (val), u783 (ref), u787 (val), i5 (val)
            -- upvalues: ControlGlyphs (upval), TweenService (upval), u770 (val)
            if u779[TextButton] then
                return
            end

            TextLabel.Visible = not u783 and not u787 and not i5.noTip
            local tip = ControlGlyphs.usingGamepad() and string.match(i5.tip, "^(.-)  %(")
                or i5.tip
            TextLabel.Text = tip

            TweenService:Create(
                TextButton,
                TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = u770}
            ):Play()
        end

        function hoverOff()
            -- Line: 446
            -- upvalues: u779 (val), TextButton (val), TextLabel (val), TweenService (upval), u765 (val)
            if u779[TextButton] then
                return
            end

            TextLabel.Visible = false
            TweenService:Create(
                TextButton,
                TweenInfo.new(0.12),
                {Size = u765}
            ):Play()
        end

        TextButton.MouseEnter:Connect(hoverOn)
        TextButton.MouseLeave:Connect(hoverOff)
        TextButton.SelectionGained:Connect(hoverOn)
        TextButton.SelectionLost:Connect(hoverOff)

        TextButton.Activated:Connect(function()
            -- Line: 460
            -- upvalues: i5 (val), hideHint (upval), u783 (ref), u72 (ref)
            if i5.id == "Backpack" then
                hideHint()
            end

            i5.open()

            if u783 and i5.id ~= "Backpack" and i5.id ~= "Teleport" then
                u72(false)
            end
        end)

        if i5.attach then
            i5.attach(TextButton, u783, u787)
        end
    end

    local u92 = Instance.new("Frame")
    u92.Name = "MenuToggle"
    u92.Size = UDim2.fromOffset(44, 44)
    u92.BackgroundTransparency = 1
    u92.Visible = false
    u92.Parent = u170
    local TextButton_2 = Instance.new("TextButton")
    TextButton_2.Name = "Menu"
    TextButton_2.Size = UDim2.fromScale(1, 1)
    TextButton_2.BackgroundColor3 = Color3.fromRGB(26, 29, 36)
    TextButton_2.BackgroundTransparency = 0.15
    TextButton_2.Text = ""
    TextButton_2.AutoButtonColor = true
    TextButton_2.Parent = u92

    u53.corner(TextButton_2, 8)

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(58, 62, 78)
    UIStroke.Parent = TextButton_2

    for i6 = -1, 1 do
        Frame_3 = Instance.new("Frame")
        Frame_3.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame_3.Size = UDim2.fromOffset(20, 3)
        Frame_3.Position = UDim2.new(0.5, 0, 0.5, i6 * 7)
        Frame_3.BackgroundColor3 = Color3.fromRGB(232, 236, 245)
        Frame_3.BorderSizePixel = 0
        Frame_3.Parent = TextButton_2

        u53.corner(Frame_3, 2)
    end

    local Frame_2 = Instance.new("Frame")
    Frame_2.Size = UDim2.fromOffset(12, 12)
    Frame_2.Position = UDim2.new(1, -6, 0, -4)
    Frame_2.BackgroundColor3 = Color3.fromRGB(226, 62, 62)
    Frame_2.Visible = false
    Frame_2.ZIndex = 3
    Frame_2.Parent = TextButton_2

    u53.corner(Frame_2, 6)

    local UIStroke_2 = Instance.new("UIStroke")
    UIStroke_2.Color = Color3.fromRGB(18, 20, 26)
    UIStroke_2.Thickness = 2
    UIStroke_2.Parent = Frame_2

    local function refreshMenuDot() -- Line: 525; upvalues: u121 (upval), Frame_2 (val), u783 (ref), u837 (ref)
        local v1 = false

        for i, j in u121 do
            if i ~= "Backpack" and j.Visible then
                v1 = true
            end
        end

        Frame_2.Visible = u783 and not u837 and v1
    end

    function u72(a1)
        -- Line: 535
        -- upvalues: u837 (ref), u845 (ref), UIStroke (val), QuickTeleportController (upval), u121 (upval)
        -- upvalues: Frame_2 (val), u783 (ref)
        -- types: a1: boolean
        u845()

        local v1 = if not a1 then Color3.fromRGB(58, 62, 78) else Color3.fromRGB(255, 214, 110)
        UIStroke.Color = v1

        if not a1 then
            QuickTeleportController.close()
        end

        local v2 = false

        for i, j in u121 do
            if i ~= "Backpack" and j.Visible then
                v2 = true
            end
        end

        Frame_2.Visible = u783 and not a1 and v2
    end

    TextButton_2.Activated:Connect(function() -- Line: 544; upvalues: u72 (ref), u837 (ref)
        u72(not u837)
    end)

    UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 548; upvalues: u837 (ref), u783 (ref), u72 (ref)
        if u837 and u783 and not a2 and a1.UserInputType == Enum.UserInputType.Touch then
            u72(false)
        end
    end)

    u171 = Instance.new("Frame")
    u171.Size = UDim2.fromOffset(0, 34)
    u171.AutomaticSize = Enum.AutomaticSize.X
    u171.BackgroundColor3 = Color3.fromRGB(255, 214, 110)
    u171.BackgroundTransparency = 0.08

    u171:SetAttribute("ThemeAccent", true)

    u171.Visible = false
    u171.Parent = u170
    local v5 = Instance.new("UICorner")
    v5.CornerRadius = UDim.new(0, 8)
    v5.Parent = u171
    v5 = Instance.new("UIPadding")
    v5.PaddingLeft = UDim.new(0, 12)
    v5.PaddingRight = UDim.new(0, 12)
    v5.Parent = u171
    local u281 = Instance.new("TextLabel")
    u281.Size = UDim2.fromScale(0, 1)
    u281.AutomaticSize = Enum.AutomaticSize.X
    u281.BackgroundTransparency = 1
    u281.Text = if not u787 then "Press  E  for your Backpack" else "Tap the bag for your Backpack"
    u281.TextColor3 = Color3.fromRGB(28, 26, 20)
    u281.TextSize = 14
    u281.FontFace = u53.Font.Bold
    u281.Parent = u171

    local function drawHint()
        -- Line: 593
        -- upvalues: VRService (upval), ControlGlyphs (upval), u171 (upval), u281 (val), u787 (val)
        if VRService.VREnabled then
            ControlGlyphs.clear(u171)

            u281.Text = "Point at the bag for your Backpack"
            u281.Visible = true

            return
        end

        if ControlGlyphs.usingGamepad() and not u787 then
            ControlGlyphs.row(
                u171,
                {{text = "for your Backpack", key = Enum.KeyCode.DPadUp}},
                u281
            )

            u281.Visible = false

            return
        end

        ControlGlyphs.clear(u171)

        u281.Visible = true
    end

    drawHint()
    ControlGlyphs.onChanged(drawHint)
    ;(VRService:GetPropertyChangedSignal("VREnabled")):Connect(drawHint)

    local function chatBottom() -- Line: 618; upvalues: TextChatService (upval)
        local ChatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")

        if ChatWindowConfiguration and ChatWindowConfiguration.Enabled then
            local v1 = ChatWindowConfiguration.AbsolutePosition.Y
                + ChatWindowConfiguration.AbsoluteSize.Y
            local v2 = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")

            if v2 and v2.Enabled then
                v1 = math.max(v1, v2.AbsolutePosition.Y + v2.AbsoluteSize.Y)
            end

            if v1 > 0 then
                return v1
            end

            return nil
        end

        return nil
    end

    if u592 and HotbarController.dockLeft(u592) then
        u779[u592] = true
    end

    local function dockTopStrip(a1)
        -- Line: 641
        -- upvalues: LocalPlayer (upval), u53 (upval), Config (upval)
        -- types: a1: table
        local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        local AboveTopStrip = PlayerGui and PlayerGui:WaitForChild("AboveTopStrip", 10)
        local u84 = AboveTopStrip

        if u84 then
            u84 = AboveTopStrip:WaitForChild("Stats", 10)
        end

        if AboveTopStrip and u84 and u84:IsA("GuiObject") then
            local Icon, UIStroke
            local v1 = nil
            local v2 = nil

            for i, j in a1, v1, v2 do
                j.AnchorPoint = Vector2.new(1, 0)
                j.Parent = AboveTopStrip
                Icon = j:FindFirstChild("Icon")

                if Icon and Icon:IsA("GuiObject") then
                    Icon.Size = UDim2.new(1, -8, 1, -8)
                end

                UIStroke = j:FindFirstChildOfClass("UIStroke")

                if UIStroke then
                    UIStroke:Destroy()
                end
            end

            local function place() -- Line: 664; upvalues: u53 (upval), u84 (val), Config (upval), a1 (val)
                local new_2, v1
                local v2 = math.max(u84.AbsoluteSize.Y / (u53.layerScale(u84)), 24)
                local StatStripRight = Config.Touch.Hud.StatStripRight
                local StatStripTop = Config.Touch.Hud.StatStripTop

                for i, j in a1 do
                    j.Size = UDim2.fromOffset(v2, v2)
                    new_2 = UDim2.new
                    v1 = -(StatStripRight + (i - 1) * (v2 + 6))
                    j.Position = new_2(1, v1, 0, StatStripTop)
                end

                u84.Position = UDim2.new(1, -(StatStripRight + #a1 * (v2 + 6)), 0, StatStripTop)
            end

            ;(u84:GetPropertyChangedSignal("AbsoluteSize")):Connect(place)
            u53.onLayerScaleChanged(place)
            place()

            return true
        end

        return false
    end

    local v6 = {}

    if u596 then
        table.insert(v6, u596)
    end

    if u594 then
        table.insert(v6, u594)
    end

    if #v6 > 0 and dockTopStrip(v6) then
        for i7, i8 in v6 do
            u779[i8] = true
        end
    end

    local function layout()
        -- Line: 694
        -- upvalues: u849 (val), u853 (val), u779 (val), u829 (ref), Config (upval), GuiService (upval), u783 (ref)
        -- upvalues: u787 (val), u833 (ref), chatBottom (val), u53 (upval), Frame (val), u837 (ref), u592 (ref)
        -- upvalues: u594 (ref), u596 (ref), u92 (val), QuickTeleportController (upval), u171 (upval), u170 (upval)
        -- upvalues: u121 (upval), Frame_2 (val)
        local v1, v2, v3
        local CurrentCamera = workspace.CurrentCamera
        local ViewportSize = if not CurrentCamera then Vector2.zero else CurrentCamera.ViewportSize
        local v4 = 0
        local v5 = nil
        local v6 = nil

        for i, j in u849, v5, v6 do
            v3 = u853[j]

            if not u779[j] then
                if not v3.onlyIf or v3.onlyIf() then
                    v4 = v4 + 1
                end
            end
        end

        u829 = v4 * 44 + math.max(0, v4 - 1) * 6
        local MenuColumnTop = Config.Touch.Hud.MenuColumnTop
        local v7 = ViewportSize.Y - GuiService:GetGuiInset().Y
            - Config.Touch.Hud.MenuColumnStickClearance
            - MenuColumnTop
        u783 = u787 and v7 < u829
        u833 = if not u787 then
            UDim2.new(0, 12, 0.5, -(u829 / 2))
        else
            UDim2.fromOffset(12, MenuColumnTop + math.max(0, v7 - u829) / 2)
        v7 = if not u787 then chatBottom() else nil

        if v7 then
            v4 = u53.layerScale(Frame)
            v7 = v7 / v4
            v5 = (ViewportSize.Y - GuiService:GetGuiInset().Y) / v4
            v4 = v5 / 2 - u829 / 2
            v6 = math.max(0, v5 - u829 - 12)
            u833 = UDim2.fromOffset(12, (math.min(math.max(v4, v7 + Config.Touch.Hud.MenuBelowChatGap), v6)))
        end

        v7 = {}
        v6 = nil
        local v8 = nil

        for k, n in u849, v6, v8 do
            if not u779[n] then
                v1 = u853[n]

                if not v1.onlyIf or v1.onlyIf() then
                    v1 = not u783 or u837 or n == u592
                    n.Visible = v1

                    if v1 then
                        table.insert(v7, n)
                    end
                else
                    n.Visible = false
                end
            else
                n.Visible = true
            end
        end

        v5 = #v7 * 44 + math.max(0, #v7 - 1) * 6
        v6 = if not u783 then 0 else 50
        local v9 = if not u783 then UDim2.fromOffset(44, u829) else UDim2.fromOffset(v5, 44)
        Frame.Size = v9
        Frame.Position = if not u783 then u833 else UDim2.new(1, -(v5 + 12 + v6), 0, 8)
        v9 = nil
        v3 = nil

        for m, i5 in v7, v9, v3 do
            v6 = (m - 1) * 50 + 22
            v2 = if not u783 then UDim2.fromOffset(22, v6) else UDim2.fromOffset(v6, 22)
            i5.Position = v2
        end

        v5 = u594
        v8 = v7[#v7]

        if v5 and u779[v5] and v8 then
            v8.NextSelectionDown = v5
            v8.NextSelectionRight = v5
            v5.NextSelectionUp = v8
            v5.NextSelectionLeft = v8

            if u596 and u779[u596] then
                v5.NextSelectionRight = u596
                u596.NextSelectionLeft = v5
                u596.NextSelectionUp = v8
            end
        end

        u92.Visible = u783
        u92.Position = UDim2.new(1, -56, 0, 8)

        QuickTeleportController.orient(u783)

        u171.AnchorPoint = if not u783 then Vector2.zero else Vector2.new(1, 0)
        v9 = u171
        v3 = if not u783 then u833 + UDim2.fromOffset(52, 5) else UDim2.new(1, -12, 0, 60)
        v9.Position = v3
        v8 = u592

        if v8 and u779[v8] then
            v5 = u53.layerScale(u171)
            v7 = v8.AbsolutePosition - u170.AbsolutePosition
            u171.AnchorPoint = Vector2.new(0, 1)
            u171.Position = UDim2.fromOffset(v7.X / v5, (v7.Y - 8) / v5)
        end

        v8 = false

        for i6, i7 in u121 do
            if i6 ~= "Backpack" and i7.Visible then
                v8 = true
            end
        end

        Frame_2.Visible = u783 and not u837 and v8
    end

    u845 = layout

    layout()
    ;(LocalPlayer:GetAttributeChangedSignal(Config.Release.AdminAttribute)):Connect(layout)

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        (CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(layout)
    end

    if u592 and u779[u592] then
        (u592:GetPropertyChangedSignal("AbsolutePosition")):Connect(layout)
    end

    u53.onLayerScaleChanged(layout)

    if not u787 then
        local function watchChat(a1) -- Line: 821; upvalues: layout (val); types: a1: userdata
            if a1:IsA("ChatWindowConfiguration") then
                for i, j in {"AbsolutePosition", "AbsoluteSize", "Enabled"} do
                    (a1:GetPropertyChangedSignal(j)):Connect(layout)
                end

                layout()
            elseif a1:IsA("ChatInputBarConfiguration") then
                for k, n in {"AbsolutePosition", "AbsoluteSize", "Enabled"} do
                    (a1:GetPropertyChangedSignal(n)):Connect(layout)
                end

                layout()
            end
        end

        for i9, i10 in TextChatService:GetChildren() do
            watchChat(i10)
        end

        TextChatService.ChildAdded:Connect(watchChat)
    end

    HintController.onChanged(function()
        -- Line: 836
        -- upvalues: u172 (upval), HintController (upval), hideHint (upval), BackpackController (upval), u171 (upval)
        if u172 and HintController.hasSeen("Backpack") then
            hideHint()
            return
        end

        if not u172 and not HintController.hasSeen("Backpack") then
            if BackpackController.isOpen() then
                HintController.markSeen("Backpack")
                return
            end

            u172 = true
            u171.Visible = true
        end
    end)

    BackpackController.onVisibleChanged(function(a1) -- Line: 859; upvalues: hideHint (upval)
        if a1 then
            hideHint()
        end
    end)

    ;(Remotes.get(Remotes.CoopInvites)).OnClientEvent:Connect(function(a1)
        -- Line: 874
        -- upvalues: u121 (upval), Frame_2 (val), u783 (ref), u837 (ref)
        local Islands = u121.Islands

        if Islands and type(a1) == "number" then
            local v1 = math.max(0, (math.floor(a1)))
            Islands.Visible = v1 > 0
            Islands.Text = if not (v1 > 9) then tostring(v1) else "9+"
            v1 = false

            for i, j in u121 do
                if i ~= "Backpack" and j.Visible then
                    v1 = true
                end
            end

            Frame_2.Visible = u783 and not u837 and v1
        end
    end)

    local function refreshBackpackDot()
        -- Line: 890
        -- upvalues: u121 (upval), NewBadges (upval), BackpackController (upval)
        local Backpack = u121.Backpack

        if not Backpack then
            return
        end

        local v1 = NewBadges.hasNewItems() and not BackpackController.isOpen()
        Backpack.Text = ""
        Backpack.Size = UDim2.fromOffset(12, 12)
        Backpack.Position = UDim2.new(1, -6, 0, -4)
        Backpack.Visible = v1
    end

    NewBadges.onChanged(refreshBackpackDot)
    BackpackController.onVisibleChanged(refreshBackpackDot)
    refreshBackpackDot()
end

return u119